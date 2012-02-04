From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] send-email: add extra safetly in address sanitazion
Date: Sat,  4 Feb 2012 17:10:55 +0200
Message-ID: <1328368255-10591-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 04 16:11:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RthHJ-0003FD-De
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 16:11:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751841Ab2BDPLl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 10:11:41 -0500
Received: from mail-lpp01m020-f174.google.com ([209.85.217.174]:42460 "EHLO
	mail-lpp01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750788Ab2BDPLl (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Feb 2012 10:11:41 -0500
Received: by lbom4 with SMTP id m4so728638lbo.19
        for <git@vger.kernel.org>; Sat, 04 Feb 2012 07:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=QWme9gh87a1YCnSyAR0G6vP+bzE+vRTXQ4zKPrYoMUo=;
        b=dwshRJJk6AeARo4Dkwwi6QKZEx86bJ98Q7bgAGDRdlL5LhouR2GXixwdTI9laeiWd7
         doj3TklqIGnFaqEqwhPU3pQDQBfGSSnvFLWNLHAeZRZHO9Zuq4W5klWVoAS6XJKKKTQU
         Hquoyn5U5Fpz1hftBuVtnCtBzwo5QnXRkPiuQ=
Received: by 10.112.102.161 with SMTP id fp1mr2875040lbb.71.1328368299752;
        Sat, 04 Feb 2012 07:11:39 -0800 (PST)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi. [91.153.253.80])
        by mx.google.com with ESMTPS id jh4sm7727809lab.17.2012.02.04.07.11.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 04 Feb 2012 07:11:39 -0800 (PST)
X-Mailer: git-send-email 1.7.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189870>

Otherwise, 'git send-email' would be happy to do:

 % git send-email --to '<foo@bar.com>>'

And use '<foo@bar.com>>' in the headers.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index ef30c55..b8bf014 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -889,7 +889,7 @@ sub is_rfc2047_quoted {
 # use the simplest quoting being able to handle the recipient
 sub sanitize_address {
 	my ($recipient) = @_;
-	my ($recipient_name, $recipient_addr) = ($recipient =~ /^(.*?)\s*(<.*)/);
+	my ($recipient_name, $recipient_addr) = ($recipient =~ /^(.*?)\s*(<.*?>)/);
 
 	if (not $recipient_name) {
 		return $recipient;
-- 
1.7.9
