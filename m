From: Aaron Schrab <aaron@schrab.com>
Subject: [PATCH v2 0/3] pre-push hook support
Date: Sun, 13 Jan 2013 00:17:01 -0500
Message-ID: <1358054224-7710-1-git-send-email-aaron@schrab.com>
References: <1356735452-21667-1-git-send-email-aaron@schrab.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 06:18:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuFxe-0003DG-ON
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 06:18:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869Ab3AMFRk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2013 00:17:40 -0500
Received: from pug.qqx.org ([50.116.43.67]:36672 "EHLO pug.qqx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750746Ab3AMFRk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 00:17:40 -0500
Received: from zim.qqx.org (cpe-107-015-024-243.nc.res.rr.com [107.15.24.243])
	by pug.qqx.org (Postfix) with ESMTPSA id 086091D2D6
	for <git@vger.kernel.org>; Sun, 13 Jan 2013 00:17:38 -0500 (EST)
Received: from ats (uid 1000)
	(envelope-from aaron@schrab.com)
	id 401f0
	by zim.qqx.org (DragonFly Mail Agent);
	Sun, 13 Jan 2013 00:17:38 -0500
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1356735452-21667-1-git-send-email-aaron@schrab.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213331>

Main changes since the initial version:

 * The first patch converts the existing hook callers to use the new
   find_hook() function.
 * Information about what is to be pushed is now sent over a pipe rather
   than passed as command-line parameters.

Aaron Schrab (3):
  hooks: Add function to check if a hook exists
  push: Add support for pre-push hooks
  Add sample pre-push hook script

 Documentation/githooks.txt       |  29 +++++++++
 builtin/commit.c                 |   6 +-
 builtin/push.c                   |   1 +
 builtin/receive-pack.c           |  25 ++++----
 run-command.c                    |  15 ++++-
 run-command.h                    |   1 +
 t/t5571-pre-push-hook.sh         | 129 +++++++++++++++++++++++++++++++++++++++
 templates/hooks--pre-push.sample |  53 ++++++++++++++++
 transport.c                      |  60 ++++++++++++++++++
 transport.h                      |   1 +
 10 files changed, 300 insertions(+), 20 deletions(-)
 create mode 100755 t/t5571-pre-push-hook.sh
 create mode 100644 templates/hooks--pre-push.sample

-- 
1.8.1.340.g425b78d
