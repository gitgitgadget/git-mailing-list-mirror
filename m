From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv5 08/12] gitweb: auxiliary function to group data
Date: Fri, 24 Sep 2010 18:02:43 +0200
Message-ID: <1285344167-8518-9-git-send-email-giuseppe.bilotta@gmail.com>
References: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 24 18:05:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzAmD-0006eN-UT
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 18:05:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371Ab0IXQF3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 12:05:29 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60113 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932115Ab0IXQF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 12:05:28 -0400
Received: by wyb28 with SMTP id 28so2053296wyb.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 09:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=BtMdvt4ISuup+jAVjnoGIc7x92GoSZZkOew82Qu7s+g=;
        b=KguNeickDTefUUHHxEqAbbL6m/dZkst06Ka08jQlHXFB5LcLaAQ6n4HiAt9EUqCJkT
         GG99M7HbhWdextZF8ni/PEH3Lcuay5C/gRUDiJ2RA3vU2teXKyWozZX+gfGLlL5jC6wb
         PeyyVbOclfM8tz2UTxHrqGR7DyboO+S65D11s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=e3jM7DdiSFfcDppWTPx4VJjxoJ0+WCTSm+QzRwZOK63sNZ0VLma55Ao3iypva/qykZ
         cGTHV8ct8IQHH8xSQ0pVaoYuwlo0WMX6GWFkH9Mkc1L8AQB8/88/fY1xAWr1G8wrNPYr
         IyKWrH2JRe2YsPDjj1ZDwG4H32QZSMBeW/cLg=
Received: by 10.216.38.20 with SMTP id z20mr2839225wea.108.1285344263366;
        Fri, 24 Sep 2010 09:04:23 -0700 (PDT)
Received: from localhost ([151.60.177.109])
        by mx.google.com with ESMTPS id v16sm1434432weq.8.2010.09.24.09.03.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 09:04:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.68.g6ec8
In-Reply-To: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157012>

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7c62701..8f11fb5 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3786,6 +3786,22 @@ sub git_print_header_div {
 	      "\n</div>\n";
 }
 
+sub git_group {
+	my ($class, $id, @rest) = @_;
+
+	my $content_func = pop @rest;
+
+	$class = join(' ', 'group', $class);
+
+	print $cgi->start_div({
+		-class => $class,
+		-id => $id,
+	});
+	git_print_header_div(@rest);
+	$content_func->() if defined $content_func;
+	print $cgi->end_div;
+}
+
 sub print_local_time {
 	print format_local_time(@_);
 }
-- 
1.7.3.68.g6ec8
