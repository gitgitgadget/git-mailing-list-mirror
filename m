From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv7 2/9] gitweb: uniform author info for commit and commitdiff
Date: Sat, 27 Jun 2009 14:04:58 +0200
Message-ID: <1246104305-15191-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1246104305-15191-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1246104305-15191-2-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 27 14:06:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKWfg-0007Dq-Pd
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 14:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753550AbZF0MFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2009 08:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753503AbZF0MFQ
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jun 2009 08:05:16 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:40331 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753009AbZF0MFC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2009 08:05:02 -0400
Received: by fg-out-1718.google.com with SMTP id e21so627857fga.17
        for <git@vger.kernel.org>; Sat, 27 Jun 2009 05:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=cf3CChLaadjufySQWSrXbEJDKQI+wIaKbUYxFPiM31w=;
        b=ZoO5oSsGcQI2andFXFXAV6vGuV8nopyV1ZD7rWqrl4//MFN2FGqAL2ow1bIOR6VMEY
         /SDY/w9/+wn71eIpogz+zrpBx0OfZ66mS4hGWa+ONhJk41wwzF3NWXEPx6/rVRrcHruT
         OTfReNUtTGHNt0HYIG4NTyhUOARMmxNDq26kA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=F1frYHDYk8kkswbdCX9CoufoSgnPzXQgX3ElMGdE8H2ClcQ/nM+fQkb0etfcmnMc59
         sejsz3iZMCU96ZC4kBz8d9WjoFGLlm5YQa9ScB+uNNjmQBwts2xT1RiJveqhkoxLyQU2
         Z6yY7GAZImX/QdEcE/eqJoiBm/wBA56hfVJ6M=
Received: by 10.86.94.7 with SMTP id r7mr426139fgb.11.1246104305069;
        Sat, 27 Jun 2009 05:05:05 -0700 (PDT)
Received: from localhost (dynamic-adsl-94-37-10-227.clienti.tiscali.it [94.37.10.227])
        by mx.google.com with ESMTPS id 12sm2147479fgg.4.2009.06.27.05.05.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Jun 2009 05:05:04 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc1.192.gdbfcb
In-Reply-To: <1246104305-15191-2-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122356>

Switch from

A U Thor <email@example.com> [date time]

to

author	A U Thor <email@example.com>
	date time
committer	C O Mitter <other.email@example.com>
	committer date time

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 9be723c..0d8005d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5599,7 +5599,11 @@ sub git_commitdiff {
 		git_header_html(undef, $expires);
 		git_print_page_nav('commitdiff','', $hash,$co{'tree'},$hash, $formats_nav);
 		git_print_header_div('commit', esc_html($co{'title'}) . $ref, $hash);
-		git_print_authorship(\%co, 'localtime' => 1);
+		print "<div class=\"title_text\">\n" .
+		      "<table class=\"object_header\">\n";
+		git_print_authorship_rows(\%co);
+		print "</table>".
+		      "</div>\n";
 		print "<div class=\"page_body\">\n";
 		if (@{$co{'comment'}} > 1) {
 			print "<div class=\"log\">\n";
-- 
1.6.3.rc1.192.gdbfcb
