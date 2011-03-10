From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 04/10] rev-list: --left/right-only are mutually exclusive
Date: Thu, 10 Mar 2011 15:44:57 +0100
Message-ID: <24852d917104e294726c54803d5c9012997506ca.1299767412.git.git@drmicha.warpmail.net>
References: <4D78AC8B.7010308@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 10 15:48:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxhAY-0007SI-OX
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 15:48:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752324Ab1CJOss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 09:48:48 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:36674 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752751Ab1CJOsr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Mar 2011 09:48:47 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id E42F420D3C;
	Thu, 10 Mar 2011 09:48:46 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 10 Mar 2011 09:48:46 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=MSJ8cvuxIwUYRuUfvOzvFA4S7Qc=; b=AWHy0IOoXb0YG1jwbDK3GCjhKz2DuzqtJToqyIych1uIPntRMJ3r7e9922Epda+vUsPaum1rUxRr32Pr3KhSYfxrP5zrwpR10seiN55MbcfV8/qrv9fvtt/z1EAL8zMb5o8kjYn2ECoDPVxTK+mmciiUfXnin+7csNcQtIO1D7k=
X-Sasl-enc: K+BcEugNF9apWBbnkjGXkmpce9FEvt2ZXWtLR8u5Ecwb 1299768526
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 684DE44607F;
	Thu, 10 Mar 2011 09:48:46 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.317.gf445f
In-Reply-To: <4D78AC8B.7010308@drmicha.warpmail.net>
In-Reply-To: <cover.1299767412.git.git@drmicha.warpmail.net>
References: <cover.1299767412.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168817>

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 revision.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/revision.c b/revision.c
index 0681c7c..1fcaeb7 100644
--- a/revision.c
+++ b/revision.c
@@ -1284,8 +1284,12 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--left-right")) {
 		revs->left_right = 1;
 	} else if (!strcmp(arg, "--left-only")) {
+		if (revs->right_only)
+			die("--left-only is incompatible with --right-only");
 		revs->left_only = 1;
 	} else if (!strcmp(arg, "--right-only")) {
+		if (revs->left_only)
+			die("--right-only is incompatible with --left-only");
 		revs->right_only = 1;
 	} else if (!strcmp(arg, "--count")) {
 		revs->count = 1;
-- 
1.7.4.1.317.gf445f
