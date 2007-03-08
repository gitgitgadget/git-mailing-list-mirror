From: sf <sf@b-i-t.de>
Subject: Re: (Re: gitweb not friendly to firefox?) and unusable in the lynx
Date: Thu, 08 Mar 2007 16:31:50 +0100
Message-ID: <45F02C66.9010909@b-i-t.de>
References: <989B956029373F45A0B8AF02970818902DA81B@zch01exm26.fsl.freescale.net> <7vabyweypw.fsf@assigned-by-dhcp.cox.net> <E1HNATn-0005Y6-HW@flower> <200703030357.18822.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Oleg Verych <olecom@flower.upol.cz>,
	Junio C Hamano <junkio@cox.net>,
	Li Yang-r58472 <LeoLi@freescale.com>, rea-git@codelabs.ru,
	Raimund Bauer <ray@softwarelandschaft.com>,
	git@vger.kernel.org, Alp Toker <alp@atoker.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 16:39:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPKiY-0003y8-Nh
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 16:39:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158AbXCHPjn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 10:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752159AbXCHPjn
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 10:39:43 -0500
Received: from mail.medianet-world.de ([213.157.0.167]:46705 "HELO
	mail.medianet-world.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752158AbXCHPjn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 10:39:43 -0500
X-Greylist: delayed 424 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Mar 2007 10:39:42 EST
Received: (qmail 25199 invoked by uid 54139); 8 Mar 2007 15:31:23 -0000
Received: from sf@b-i-t.de by pop1 by uid 89 with qmail-scanner-1.22 
 (ExcuBAtor: 1.0.2.  Clear:RC:1(213.157.15.184):. 
 Processed in 0.042073 secs); 08 Mar 2007 15:31:23 -0000
Received: from ip-213157015184.dialin.heagmedianet.de (HELO IP-213157000067.dialin.heagmedianet.de) (213.157.15.184)
  by mail.medianet-world.de with SMTP; 8 Mar 2007 15:31:23 -0000
Received: from [192.168.168.40] (groa.b-i-t.de [192.168.168.40])
	by mail.b-i-t.de (Postfix) with ESMTP id CA17B41A9;
	Thu,  8 Mar 2007 16:31:51 +0100 (CET)
User-Agent: Thunderbird 1.5.0.10 (X11/20070305)
In-Reply-To: <200703030357.18822.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41751>

Jakub Narebski wrote:
...
> By "conservatively" it means that it uses 'application/xhtml+xml' only when
> client explicitly claims that it accepts its, and it is not due to for
> example */* accept globbing.

You may need something like the (not tested and line wrapped) patch 
below as well.

Regards

Stephan


diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 27b5970..6cc5c20 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1714,7 +1714,8 @@ sub git_header_html {
                 $content_type = 'text/html';
         }
         print $cgi->header(-type=>$content_type, -charset => 'utf-8',
-                          -status=> $status, -expires => $expires);
+                          -status=> $status, -expires => $expires,
+                          -Vary=> 'Accept');
         my $mod_perl_version = $ENV{'MOD_PERL'} ? " $ENV{'MOD_PERL'}" : '';
         print <<EOF;
  <?xml version="1.0" encoding="utf-8"?>
