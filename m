From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 0/3] Implement 'git archive --submodules'
Date: Sun, 18 Jan 2009 11:53:16 +0100
Message-ID: <1232275999-14852-1-git-send-email-hjemli@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 18 11:55:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOVJ2-0008GS-Dw
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 11:55:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763858AbZARKxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 05:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763772AbZARKx3
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 05:53:29 -0500
Received: from mail46.e.nsc.no ([193.213.115.46]:49591 "EHLO mail46.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762413AbZARKxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 05:53:25 -0500
Received: from localhost.localdomain (ti0025a380-2706.bb.online.no [83.108.109.152])
	by mail46.nsc.no (8.13.8/8.13.5) with ESMTP id n0IArKDa021200;
	Sun, 18 Jan 2009 11:53:21 +0100 (MET)
X-Mailer: git-send-email 1.6.1.150.g5e733b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106167>

This series teaches read_tree_recursive() how to traverse into gitlinked
repositories by automatically adding submodule object databases as
alternates during traversal. It is still perfectly legal for a submodule
not to be checked out, in which case the submodule will be ignored.

On top of this, the implementation of 'git archive --submodules' simply
activates the new feature in read_tree_recursive().

Lars Hjemli (3):
  sha1_file: add function to insert alternate object db
  Teach read_tree_recursive() how to traverse into submodules
  git-archive: add support for --submodules

 Documentation/git-archive.txt |    7 +++-
 archive.c                     |    4 ++
 cache.h                       |    3 ++
 environment.c                 |   12 ++++++
 sha1_file.c                   |    5 +++
 t/t5001-archive-submodules.sh |   78 +++++++++++++++++++++++++++++++++++++++
 tree.c                        |   80 +++++++++++++++++++++++++++++++++++++++++
 7 files changed, 187 insertions(+), 2 deletions(-)
 create mode 100755 t/t5001-archive-submodules.sh
