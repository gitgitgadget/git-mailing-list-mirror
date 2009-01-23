From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 4/4] gitweb: rss channel date
Date: Fri, 23 Jan 2009 05:48:41 +0100
Message-ID: <1232686121-1800-5-git-send-email-giuseppe.bilotta@gmail.com>
References: <1232686121-1800-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1232686121-1800-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1232686121-1800-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1232686121-1800-4-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 23 05:50:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQDzm-00049L-B0
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 05:50:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755978AbZAWEsk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 23:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755851AbZAWEsk
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 23:48:40 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:61810 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755890AbZAWEsg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 23:48:36 -0500
Received: by fg-out-1718.google.com with SMTP id 19so2404923fgg.17
        for <git@vger.kernel.org>; Thu, 22 Jan 2009 20:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=5arRxrfCLPb4wE89aHp0smktiFBcUWS4HsBX19rSrn8=;
        b=Yg74nRt05wgYIwFa2dpXgEJrk1fFazeGDVd3LZEhi7UKMd6sjamxW1HhjABtISfRni
         xRKvGSndUuBfDhKscGiIqj6qNLzeEfysZB2yjpK5B7Y1ek0+UwzA8ANgInm2rof/tz2N
         UDdNuni8Am1U52DWaARDq1AdWhw2B4ejK5BVA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=I17DMW4qFz70U3bhptLsNhQOJrr25nuc/7vX3Zt7lEDQpbu90jxFIQvoAd2qU88tAG
         wjB0EjoCCZt1kaVb4zWfpQgvBO+d+ytQKKQsRDXvlYaJYOMeUzvhltd6pCgMorErk8vx
         gz/NDTlmrtHljNIEkBLmxKaeCVoK5G4eNaDmc=
Received: by 10.86.51.10 with SMTP id y10mr536376fgy.51.1232686115227;
        Thu, 22 Jan 2009 20:48:35 -0800 (PST)
Received: from localhost ([94.37.14.37])
        by mx.google.com with ESMTPS id 4sm8658150fgg.44.2009.01.22.20.48.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 22 Jan 2009 20:48:34 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1232686121-1800-4-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106835>

The RSS 2.0 specifications defines not one but _two_ dates for its
channel element! Woohoo! Luckily, it seems that consensus seems to be
that if both are present they should be equal, except for some very
obscure and discouraged cases. Since lastBuildDate would make more sense
for us and pubDate seems to be the most commonly used, we defined both
and make them equal.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index cc6d0fb..756868a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -6087,6 +6087,10 @@ XML
 			      "<link>$alt_url</link>\n" .
 			      "</image>\n";
 		}
+		if (%latest_date) {
+			print "<pubDate>$latest_date{'rfc2822'}</pubDate>\n";
+			print "<lastBuildDate>$latest_date{'rfc2822'}</lastBuildDate>\n";
+		}
 		print "<generator>gitweb v.$version/$git_version</generator>\n";
 	} elsif ($format eq 'atom') {
 		print <<XML;
-- 
1.5.6.5
