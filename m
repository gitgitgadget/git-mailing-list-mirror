From: "Li Yang-r58472" <LeoLi@freescale.com>
Subject: RE: gitweb not friendly to firefox?
Date: Fri, 2 Mar 2007 17:36:36 +0800
Message-ID: <989B956029373F45A0B8AF02970818902DA81B@zch01exm26.fsl.freescale.net>
References: <7v1wk8i1et.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Cc: <rea-git@codelabs.ru>,
	"Raimund Bauer" <ray@softwarelandschaft.com>, <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>,
	"Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 10:36:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN4B3-0001fs-LG
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 10:35:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbXCBJfW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 04:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965330AbXCBJfW
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 04:35:22 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:46815 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422911AbXCBJfT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Mar 2007 04:35:19 -0500
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id l229ZDaA014500
	for <git@vger.kernel.org>; Fri, 2 Mar 2007 02:35:13 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net [10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l229ZC4f024008
	for <git@vger.kernel.org>; Fri, 2 Mar 2007 03:35:13 -0600 (CST)
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <7v1wk8i1et.fsf@assigned-by-dhcp.cox.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: gitweb not friendly to firefox?
Thread-Index: AcdclyxiXrY0ZI1nR7mRUI+oXUlZgQAFlMZQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41174>

Hi Jakub,

Problem sovled, using the following patch.  I'm not an expert of perl,
so I don't know if it is problem of the gitweb or problem with my perl
environment.  My environment is perl-5.8.0 and perl-CGI-2.81.

Signed-off-by: Li Yang<leoli@freecale.com>
---
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 653ca3c..8c9a291 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -591,7 +591,7 @@ sub esc_html ($;%) {
        my %opts = @_;

        $str = to_utf8($str);
-       $str = escapeHTML($str);
+       $str = $cgi->escapeHTML($str);
        if ($opts{'-nbsp'}) {
                $str =~ s/ /&nbsp;/g;
        }


> -----Original Message-----
> From: Junio C Hamano [mailto:junkio@cox.net]
> Sent: Friday, March 02, 2007 2:51 PM
> To: Li Yang-r58472
> Cc: rea-git@codelabs.ru; Raimund Bauer; git@vger.kernel.org; Jakub
Narebski
> Subject: Re: gitweb not friendly to firefox?
> 
> "Li Yang-r58472" <LeoLi@freescale.com> writes:
> 
> >> > Yes, you are right.  But why gitweb didn't do that for me?  I
> > observed
> >> > that some early version of gitweb doesn't have this problem.  Is
it
> >> > possible that some new change caused this?
> >>
> >> It's very possible.
> >
> > Well, I had found out that the escapeHTML() is not functioning on my
> > server.  It leaves the "<", ">", "@" unchanged.  Does anyone have a
clue
> > about it?  I'm using Redhat 9.0 full installation.
> 
> I am not sure offhand if escapeHTML implementation is wrong or
> the call site is calling escapeHTML when it should be using some
> other kinds of escape.
> 
> The person who knows about this issue the best, if I have to
> guess, would be Jakub Narebski.
> 
