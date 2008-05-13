From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 0/4] freebsd portability fixes
Date: Tue, 13 May 2008 22:44:42 +0200
Message-ID: <20080513204442.GB3981@steel.home>
References: <20080513084338.GA23729@sigill.intra.peff.net> <20080513090424.GA26181@sigill.intra.peff.net> <20080513203931.GA3981@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 13 22:46:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jw1Nz-0004F6-9o
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 22:46:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbYEMUop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 16:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbYEMUop
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 16:44:45 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:8481 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932491AbYEMUoo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 16:44:44 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnareO8OVwvA==
Received: from tigra.home (Fafac.f.strato-dslnet.de [195.4.175.172])
	by post.webmailer.de (klopstock mo4) (RZmta 16.34)
	with ESMTP id h0367ek4DIucU4 ; Tue, 13 May 2008 22:44:42 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 49B6C277BD;
	Tue, 13 May 2008 22:44:42 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 46E0656D28; Tue, 13 May 2008 22:44:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080513203931.GA3981@steel.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82043>

Alex Riesen, Tue, May 13, 2008 22:39:31 +0200:
> Jeff King, Tue, May 13, 2008 11:04:24 +0200:
> > On Tue, May 13, 2008 at 04:43:39AM -0400, Jeff King wrote:
> > 
> > > With these patches, I can successfully run all test scripts from the
> > > current 'master' on FreeBSD 6.1 (some of them probably affect OS X, too
> > > -- I recall somebody complaining about the '! foo | bar' construct
> > > recently).
> > 
> > Ah, nevermind about OS X. It was 97ad535b from Alex, and he specifically
> > mentioned FreeBSD 4.
> > 
> > Alex, you might want to try re-running the tests with these patches.
> > 
> 
> Very good! GnuPG is missing on the system, so t7004 was skipped,
> but everything besides that ran fine. My config.mak:
> 
> NO_STRTOUMAX=Yes
> NO_C99_FORMAT=Yes
> SHELL_PATH=/usr/local/bin/bash
> 
> perl 5.8.6
> 
> I also have the test-tr patches I sent some time ago in that tree.
> 

I also have the following in git-compat-util.h:

diff --git a/git-compat-util.h b/git-compat-util.h
index 01c4045..161bd50 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -191,6 +191,7 @@ extern size_t gitstrlcpy(char *, const char *, size_t);
 
 #ifdef NO_STRTOUMAX
 #define strtoumax gitstrtoumax
+typedef unsigned long long uintmax_t;
 extern uintmax_t gitstrtoumax(const char *, char **, int);
 #endif
 

Which is obviously a hack, but I considered too minor an issue. It
(the missing uintmax_t) is probably something very specific to this
particular system. I am probably wrong about the issue being minor...
