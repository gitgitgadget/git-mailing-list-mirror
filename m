From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 0/3] make builtin-commit use commit_tree() and reduce_heads()
Date: Wed, 10 Sep 2008 22:10:30 +0200
Message-ID: <cover.1221077214.git.vmiklos@frugalware.org>
Cc: Russell King <rmk@arm.linux.org.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 22:12:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdW2T-0003is-A7
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 22:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752273AbYIJUKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 16:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752230AbYIJUKh
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 16:10:37 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:36729 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986AbYIJUKe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 16:10:34 -0400
Received: from vmobile.example.net (dsl5401CEA5.pool.t-online.hu [84.1.206.165])
	by yugo.frugalware.org (Postfix) with ESMTPA id 39C91149C5F;
	Wed, 10 Sep 2008 22:10:33 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 596FC84CB; Wed, 10 Sep 2008 22:10:33 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95553>

Hi,

On Tue, Sep 09, 2008 at 05:52:37PM +0100, Russell King <rmk@arm.linux.org.uk> wrote:
> Is this intentional, or is it a bug?

It is because builtin-commit does not use reduce_heads(), but
builtin-merge does.

Here are 3 patches to make builtin-commit use commit_tree() and
reduce_heads() as well.

The first one just improves the commit_tree() interface.

The second one is a cleanup, but it also adds reduce_heads() usage, to
fix the issue, pointed out by Russell King.

The third one adds new testcases, based on the ones provided by him.

Miklos Vajna (3):
  commit_tree(): add a new author parameter
  builtin-commit: use commit_tree()
  t7603: add new testcases to ensure builtin-commit uses reduce_heads()

 builtin-commit-tree.c         |    9 ++++--
 builtin-commit.c              |   63 +++++++++-------------------------------
 builtin-merge.c               |    4 +-
 builtin.h                     |    3 +-
 t/t7603-merge-reduce-heads.sh |   53 ++++++++++++++++++++++++++++++++++
 5 files changed, 77 insertions(+), 55 deletions(-)
