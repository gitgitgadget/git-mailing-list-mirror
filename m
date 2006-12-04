X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Moving a directory into another fails
Date: Mon, 4 Dec 2006 22:01:34 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612042155480.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <9e4733910607260800v618edf0em7b0f5c3332bf8fc5@mail.gmail.com>
 <20060726223459.GA30601@vsectoor.geht-ab-wie-schnitzel.de>
 <9e4733910607261603m6772602cr333d8c58f555edaa@mail.gmail.com>
 <20060728014350.GI13776@pasky.or.cz> <f3d7535d0612041019q4bda01a1k9938b056d51f8a78@mail.gmail.com>
 <el1qtr$bca$1@sea.gmane.org> <Pine.LNX.4.63.0612042001320.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <el1rmm$bca$2@sea.gmane.org> <Pine.LNX.4.63.0612042009590.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <el1t9a$lmo$1@sea.gmane.org> <7617FA7E-D49A-4A4C-B033-C2CB20623F5F@wf227.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-1942586586-1165266094=:28348"
NNTP-Posting-Date: Mon, 4 Dec 2006 21:01:52 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7617FA7E-D49A-4A4C-B033-C2CB20623F5F@wf227.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33249>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrKwW-00058X-TI for gcvg-git@gmane.org; Mon, 04 Dec
 2006 22:01:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967131AbWLDVBi (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 16:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937389AbWLDVBi
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 16:01:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:58855 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S937390AbWLDVBh
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 16:01:37 -0500
Received: (qmail invoked by alias); 04 Dec 2006 21:01:34 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp040) with SMTP; 04 Dec 2006 22:01:34 +0100
To: Wolfgang Fischer <wf@wf227.com>
Sender: git-owner@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-1942586586-1165266094=:28348
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

thank you, Wolfgang, for back Cc'ing me (Jakub never does that...), but I 
am Cc'ing the git list here, also. Hope both of you don't mind.

On Mon, 4 Dec 2006, Wolfgang Fischer wrote:

> On 04.12.2006, at 20:37, Jakub Narebski wrote:
> 
> > And HFS+ is on MacOS X / Darwin, without iconv in libc...
> 
> And, what is even worse, is the fact that HFS+ uses an encoding, which is not
> represented in libiconv.
> 
> If you CREATE a file, you can use UTF8-NFC 
> (Normalization-Form-Composed), but if you later READDIR a directory, you 
> will get the very same name back in the encoding used by HFS+, which is 
> UTF8-NFD Normalization-Form-Decomposed. The difference is noticeable for 
> some non-ASCII characters like e.g.
> 
> LATIN SMALL LETTER A WITH DIAERESIS  U+00E4 or U+0061 U+0308 in Unicode.
> 
> If you need a sane backward mapping, one has to use some CoreFoundation 
> interface, for which I removed the details out of my brain, in order to 
> reclaim that memory area (garbage collection!). But I can help you with 
> some details and probably code, if you really need that conversion 
> direction.

Yes. When my iBook was still alive, I saw that problem, too: writing and 
reading filenames were completely different issues.

Worse, you can experience the same on USB-Sticks when accessing them with 
different OSes. For example, when checking out a git repo on a stick with 
Linux, and then calling git-status on the same stick with Windows XP, you 
see an issue with the file "Märchen", like you did on MacOSX.

So, please, please, please do not try to be smart about filename encodings 
in git, but just DO NOT USE ANYTHING BUT ASCII IN FILENAMES IF THE 
REPOSITORY IS GOING TO BE PUT ON DIFFERENT OPERATING SYSTEMS/FILE SYSTEMS. 
(Wow, the Caps Lock key is _not_ dead after all. I must have been infected 
by Linus...)

Ciao,
Dscho

