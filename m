From: "Thomas Kolejka" <Thomas.Kolejka@gmx.at>
Subject: [gitweb PATCH] Configure encoding
Date: Tue, 31 May 2005 09:55:11 +0200 (MEST)
Message-ID: <1839.1117526111@www5.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 31 09:53:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dd1YQ-000287-RI
	for gcvg-git@gmane.org; Tue, 31 May 2005 09:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbVEaHzY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 May 2005 03:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbVEaHzY
	(ORCPT <rfc822;git-outgoing>); Tue, 31 May 2005 03:55:24 -0400
Received: from imap.gmx.net ([213.165.64.20]:1743 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261331AbVEaHzO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2005 03:55:14 -0400
Received: (qmail 22023 invoked by uid 0); 31 May 2005 07:55:11 -0000
Received: from 141.130.250.71 by www5.gmx.net with HTTP;
	Tue, 31 May 2005 09:55:11 +0200 (MEST)
To: Kay Sievers <kay.sievers@vrfy.org>
X-Priority: 3 (Normal)
X-Authenticated: #20307258
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The following patch makes it easy to change the encoding:


--- gitweb.cgi.177      2005-05-31 09:43:17.000000000 +0200
+++ gitweb.cgi.p        2005-05-31 09:48:46.000000000 +0200
@@ -20,6 +20,9 @@
 my $my_uri =           $cgi->url(-absolute => 1);
 my $rss_link = "";
 
+my $encoding = "utf-8";
+$encoding = "iso-8859-1";
+
 # absolute fs-path which will be prepended to the project path
 my $projectroot =      "/pub/scm";
 $projectroot = "pub/scm";
@@ -183,9 +186,9 @@
                        $title .= "/$action";
                }
        }
-       print $cgi->header(-type=>'text/html',  -charset => 'utf-8',
-status=> $status);
+       print $cgi->header(-type=>'text/html',  -charset => $encoding,
-status=> $status);
        print <<EOF;
-<?xml version="1.0" encoding="utf-8"?>
+<?xml version="1.0" encoding="$encoding"?>
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
 <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">
 <!-- git web interface v$version, (C) 2005, Kay Sievers
<kay.sievers\@vrfy.org>, Christian Gierke <ch\@gierke.de> -->
@@ -1112,8 +1115,8 @@
        my (@revlist) = map { chomp; $_ } <$fd>;
        close $fd || die_error(undef, "Reading rev-list failed.");
 
-       print $cgi->header(-type => 'text/xml', -charset => 'utf-8');
-       print "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n".
+       print $cgi->header(-type => 'text/xml', -charset => $encoding);
+       print "<?xml version=\"1.0\" encoding=\"$encoding\"?>\n".
              "<rss version=\"0.91\">\n";
        print "<channel>\n";
        print "<title>$project</title>\n".



Thomas

-- 
Weitersagen: GMX DSL-Flatrates mit Tempo-Garantie!
Ab 4,99 Euro/Monat: http://www.gmx.net/de/go/dsl
