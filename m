From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/6] Modernize mktree somewhat
Date: Sun, 10 May 2009 11:49:45 -0700
Message-ID: <1241981391-19639-1-git-send-email-gitster@pobox.com>
References: <7vvdo8zxwp.fsf@alter.siamese.dyndns.org>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 10 20:50:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3E6O-0004rg-7V
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 20:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753782AbZEJStz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 14:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753254AbZEJStz
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 14:49:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52359 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650AbZEJSty (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 14:49:54 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9F649B1B64;
	Sun, 10 May 2009 14:49:54 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E2AC7B1B63; Sun,
 10 May 2009 14:49:52 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.9.g6345d
In-Reply-To: <7vvdo8zxwp.fsf@alter.siamese.dyndns.org>
X-Pobox-Relay-ID: 59F337B6-3D93-11DE-BE29-CABC03BA4B0C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118733>

This series updates mktree to make it a built-in, teaches it to use
parse-options, and then adds tests.  These are all necessary steps to
modernize it.

The last one adds --missing option to make things consistent with other
parts of the system.  The combination of update-index and write-tree has
provisions to record a tree of objects that we may not have, but so far it
was not possible with mktree.

Junio C Hamano (6):
  build-in git-mktree
  mktree: use parse-options
  builtin-mktree.c: use a helper function to handle one line of input
  mktree: do not barf on a submodule commit
  t1010: add mktree test
  mktree --missing: allow missing objects

 Makefile          |    2 +-
 builtin-mktree.c  |  141 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 builtin.h         |    1 +
 git.c             |    1 +
 mktree.c          |  131 -------------------------------------------------
 t/t1010-mktree.sh |   71 +++++++++++++++++++++++++++
 6 files changed, 215 insertions(+), 132 deletions(-)
 create mode 100644 builtin-mktree.c
 delete mode 100644 mktree.c
 create mode 100755 t/t1010-mktree.sh
