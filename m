Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=0.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 8536 invoked by uid 107); 2 Nov 2012 21:08:26 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.84) with ESMTP; Fri, 02 Nov 2012 17:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753233Ab2KBVHM (ORCPT <rfc822;peff@peff.net>);
	Fri, 2 Nov 2012 17:07:12 -0400
Received: from plane.gmane.org ([80.91.229.3]:45946 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751488Ab2KBVHK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 17:07:10 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TUOSS-0004mG-F1
	for git@vger.kernel.org; Fri, 02 Nov 2012 22:07:16 +0100
Received: from ip68-6-43-149.sb.sd.cox.net ([68.6.43.149])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Nov 2012 22:07:16 +0100
Received: from richard_hubbe11 by ip68-6-43-149.sb.sd.cox.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Nov 2012 22:07:16 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:	git@vger.kernel.org
From:	rh <richard_hubbe11@lavabit.com>
Subject: [PATCH] gitweb.perl: fix %highlight_ext mappings
Date:	Fri, 2 Nov 2012 14:12:26 -0700
Message-ID: <20121102141226.643a96e61b8bf383428c5287@lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: ip68-6-43-149.sb.sd.cox.net
User-Agent: dsodnetnin
X-Mailer: EZnn0.37p
X-Newsreader: EZnn0.37p
X-Gmane-NNTP-Posting-Host: EZnn0.37p
Original-Received: from slem by 1.1 with local
X-No-Archive: yes
Archive: no
X-Archive: expiry=11
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org
X-Status: A


The previous change created a dictionary of one-to-one elements when
the intent was to map mutliple related types to one main type.
e.g. bash, ksh, zsh, sh all map to sh since they share similar syntax
This makes the mapping as the original change intended.

Signed-off-by: rh <richard_hubbe11@lavabit.com>

diff --git a/gitweb.cgi.orig b/gitweb.cgi
index 060db27..155b238 100755
--- a/gitweb.cgi.orig
+++ b/gitweb.cgi
@@ -246,19 +246,19 @@ our %highlight_basename = (
 	'Makefile' => 'make',
 );
 # match by extension
+
 our %highlight_ext = (
 	# main extensions, defining name of syntax;
 	# see files in /usr/share/highlight/langDefs/ directory
-	map { $_ => $_ }
-		qw(py c cpp rb java css php sh pl js tex bib xml awk bat ini spec tcl sql make),
+	(map { $_ => $_ } qw(py rb java css js tex bib xml awk bat ini spec tcl sql)),
 	# alternate extensions, see /etc/highlight/filetypes.conf
-	'h' => 'c',
-	map { $_ => 'sh'  } qw(bash zsh ksh),
-	map { $_ => 'cpp' } qw(cxx c++ cc),
-	map { $_ => 'php' } qw(php3 php4 php5 phps),
-	map { $_ => 'pl'  } qw(perl pm), # perhaps also 'cgi'
-	map { $_ => 'make'} qw(mak mk),
-	map { $_ => 'xml' } qw(xhtml html htm),
+	(map { $_ => 'c'   } qw(c h)),
+	(map { $_ => 'sh'  } qw(sh bash zsh ksh)),
+	(map { $_ => 'cpp' } qw(cpp cxx c++ cc)),
+	(map { $_ => 'php' } qw(php php3 php4 php5 phps)),
+	(map { $_ => 'pl'  } qw(pl perl pm)), # perhaps also 'cgi'
+	(map { $_ => 'make'} qw(make mak mk)),
+	(map { $_ => 'xml' } qw(xml xhtml html htm)),
 );
 
 # You define site-wide feature defaults here; override them with

