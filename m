From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] config.txt,diff-options.txt: porcelain vs. plumbing for color.diff
Date: Wed, 27 Apr 2011 09:38:27 +0200
Message-ID: <24a6907cade7aedb51dc20ab5977603ca21e70bb.1303889849.git.git@drmicha.warpmail.net>
References: <7voc3sewpg.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Elias Persson <delreich@takeit.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 09:38:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEzKZ-0003OQ-9J
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 09:38:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753875Ab1D0Hie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 03:38:34 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:50419 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753856Ab1D0Hid (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2011 03:38:33 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id A8A5B20CBA;
	Wed, 27 Apr 2011 03:38:32 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Wed, 27 Apr 2011 03:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=cs/2RUuVQhGBa23ppwAAQvCsEs0=; b=LL6bmH67vxZrwUEl3dJ2OZws3jA0q2My+Y0fx5FEh+Fdd00J1P4zzQUCYM+wQCFQkrbAf7VPboxfqSQLoq7bJ26pa4IT4r+XOcchFdYuGyKpUPPS60+mDtFtvIAxw1GZIcrQa8s5CfYEAOWB7tR7EumXVaCHX1+9VuBaJe/J9Js=
X-Sasl-enc: 51yri+Ed3LwpLAK3e7gEEKwIEjtaefkhGk/yV1k/knSz 1303889912
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 28ABA4406E1;
	Wed, 27 Apr 2011 03:38:32 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.270.gafca7
In-Reply-To: <7voc3sewpg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172183>

Reading the diff-family and config man pages one may think that the
color.diff and color.ui settings apply to all diff commands. Make it
clearer that they do not apply to the plumbing variants
diff-{files,index,tree}.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/config.txt       |    4 ++--
 Documentation/diff-options.txt |   15 +++++++++++----
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 750c86d..1e22832 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -708,7 +708,7 @@ second is the background.  The position of the attribute, if any,
 doesn't matter.
 
 color.diff::
-	When set to `always`, always use colors in patch.
+	When set to `always`, always use colors in patch for porcelain commands.
 	When false (or `never`), never.  When set to `true` or `auto`, use
 	colors only when the output is to the terminal. Defaults to false.
 
@@ -796,7 +796,7 @@ color.status.<slot>::
 	color.branch.<slot>.
 
 color.ui::
-	When set to `always`, always use colors in all git commands which
+	When set to `always`, always use colors in all porcelain commands which
 	are capable of colored output. When false (or `never`), never. When
 	set to `true` or `auto`, use colors only when the output is to the
 	terminal. When more specific variables of color.* are set, they always
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index c93124b..c26e494 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -120,12 +120,19 @@ any of those replacements occurred.
 
 --color[=<when>]::
 	Show colored diff.
-	The value must be always (the default), never, or auto.
+	The value must be `always` (the default for `<when>`), `never`, or `auto`.
+	The default value is `never`.
+ifdef::git-diff[]
+	It can be changed by the `color.ui` and `color.diff`
+	configuration settings.
+endif::git-diff[]
 
 --no-color::
-	Turn off colored diff, even when the configuration file
-	gives the default to color output.
-	Same as `--color=never`.
+	Turn off colored diff.
+ifdef::git-diff[]
+	This can be used to override configuration settings.
+endif::git-diff[]
+	It is the same as `--color=never`.
 
 --word-diff[=<mode>]::
 	Show a word diff, using the <mode> to delimit changed words.
-- 
1.7.5.270.gafca7
