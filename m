From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH v2 06/11] gitweb: use CSS to style split head lists.
Date: Thu, 13 Nov 2008 23:49:12 +0100
Message-ID: <1226616555-24503-7-git-send-email-giuseppe.bilotta@gmail.com>
References: <1226616555-24503-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-4-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-5-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-6-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 13 23:50:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0l1V-0004iw-KK
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 23:50:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752975AbYKMWtR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 17:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753185AbYKMWtQ
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 17:49:16 -0500
Received: from mu-out-0910.google.com ([209.85.134.184]:43326 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752970AbYKMWtL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 17:49:11 -0500
Received: by mu-out-0910.google.com with SMTP id g7so1096018muf.1
        for <git@vger.kernel.org>; Thu, 13 Nov 2008 14:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=gIFmII/4FdjITnlAB/4yifuaRs8A3Pig97VpgU6JudQ=;
        b=H2uucahECsQZGZPFGMOjIpzMV4i38A9RGwD9Zw4P2vN5lAQOaxr/D69ELMETRlNsDN
         B/ampWFUvtQYaIzPnP5Xqjb0Rp4l9ijbU+y0xtiAOCChvrPXWsm2/LIzCupKPsHwohoH
         DDtLMl+QoPPAhzZbdbcAbF5WUAAWFVkpXNTO4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JXezXO427lGl+/N32pm2Sm/Wek00zosdqXgUM1biN/xKXS+zZe1K8wealn9kN31ZLC
         j2LxB4lJpWNHvfI4+otmEVumKxjK5deCdxzcYawjeY8fReFQv4M7mV/+SCWWMT00dZhH
         evhjc1jb5rzG3+zh8HdhQAwZSNyv7Gj4A1+Rg=
Received: by 10.181.30.10 with SMTP id h10mr64658bkj.200.1226616550100;
        Thu, 13 Nov 2008 14:49:10 -0800 (PST)
Received: from localhost ([78.15.2.247])
        by mx.google.com with ESMTPS id k29sm5935708fkk.2.2008.11.13.14.49.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 13 Nov 2008 14:49:09 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1226616555-24503-6-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a new div class 'subsection' in the CSS and use it to style
split head lists.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.css  |   10 ++++++++++
 gitweb/gitweb.perl |    4 +++-
 2 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index a01eac8..751749f 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -8,6 +8,16 @@ body {
 	color: #000000;
 }
 
+div.subsection {
+	border: solid #d9d8d1;
+	border-width: 1px;
+	margin: 10px;
+}
+
+.subsection .title {
+	font-size: smaller;
+}
+
 a {
 	color: #0000cc;
 }
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 836b6ba..03e0b21 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4296,9 +4296,11 @@ sub git_split_heads_body {
 	} @$headlist;
 
 	foreach $leader (sort(keys %headlists)) {
-		print "<b>$leader</b><br/>\n" unless $leader eq "\000";
+		print "<div class=\"subsection\">\n";
+		git_print_header_div(undef, $leader) unless $leader eq "\000";
 		$list = $headlists{$leader};
 		git_heads_body($list, $head, $from, $to, $extra);
+		print "</div>\n";
 	}
 }
 
-- 
1.5.6.5
