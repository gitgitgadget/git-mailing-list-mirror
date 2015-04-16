From: Andreas Mohr <andi@lisas.de>
Subject: Re: Issue: repack semi-frequently fails on Windows
 (msysgit) - suspecting file descriptor issues
Date: Thu, 16 Apr 2015 22:56:58 +0200
Message-ID: <20150416205658.GB20385@rhlx01.hs-esslingen.de>
References: <20150416100359.GA19951@rhlx01.hs-esslingen.de>
 <552F98AC.5030603@virtuell-zuhause.de>
 <20150416113505.GA30818@rhlx01.hs-esslingen.de>
 <20150416152849.GA30137@peff.net>
 <a710472d7bf37757b7341dd99f8c76f3@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Andreas Mohr <andi@lisas.de>,
	Thomas Braun <thomas.braun@virtuell-zuhause.de>,
	git@vger.kernel.org, msysGit <msysgit@googlegroups.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: msysgit+bncBCY73CGE2IFRBGWEYCUQKGQERRUQHCI@googlegroups.com Thu Apr 16 22:57:00 2015
Return-path: <msysgit+bncBCY73CGE2IFRBGWEYCUQKGQERRUQHCI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f184.google.com ([209.85.217.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCY73CGE2IFRBGWEYCUQKGQERRUQHCI@googlegroups.com>)
	id 1YiqqJ-0002zI-OW
	for gcvm-msysgit@m.gmane.org; Thu, 16 Apr 2015 22:56:59 +0200
Received: by lbiv13 with SMTP id v13sf30309809lbi.1
        for <gcvm-msysgit@m.gmane.org>; Thu, 16 Apr 2015 13:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=iSyg8d8ILZUgH4JcESOKq8RD8uDgHLJah+5ZeqZrbvI=;
        b=F600tXa0mNxaSPtJPSIaCKnyzHYof91k0Ih0ajfFzRulcNoqPE8mNVTNEhyV8rIuWU
         nA32rtNqg0TwZuOxnsj2IEm8/xxgB+ZzURoUDGUO2hpuExKDrB2SlZnrAHnzYTyp6Oea
         XicWfvENQKyZwZlONnmYzdqkhve7EcnBnDq9TZbzu1TD+mZTbkY5+U83UyJCO/3k+jmp
         wRwJZmS5Dk+smttXS9aR04zysNmohN/SzLuwLkhIzcba2by6DDVfzbRB+G4yativHHXt
         6GYS/m0OAuzCGrRxsuLhftSuOCQ22p/JL/xw3dzAlqHgTViE9uWT9xud7JQQEjI+3egS
         66KQ==
X-Received: by 10.181.8.74 with SMTP id di10mr821wid.14.1429217819336;
        Thu, 16 Apr 2015 13:56:59 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.81.104 with SMTP id z8ls14785wix.10.gmail; Thu, 16 Apr
 2015 13:56:58 -0700 (PDT)
X-Received: by 10.180.106.136 with SMTP id gu8mr2562722wib.6.1429217818496;
        Thu, 16 Apr 2015 13:56:58 -0700 (PDT)
Received: from rhlx01.hs-esslingen.de (rhlx01.hs-esslingen.de. [129.143.116.10])
        by gmr-mx.google.com with ESMTPS id eg1si601711wic.1.2015.04.16.13.56.58
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Apr 2015 13:56:58 -0700 (PDT)
Received-SPF: none (google.com: andi@rhlx01.hs-esslingen.de does not designate permitted sender hosts) client-ip=129.143.116.10;
Received: by rhlx01.hs-esslingen.de (Postfix, from userid 102)
	id 3A22F4A758; Thu, 16 Apr 2015 22:56:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <a710472d7bf37757b7341dd99f8c76f3@www.dscho.org>
X-Priority: none
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Original-Sender: andi@lisas.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=none
 (google.com: andi@rhlx01.hs-esslingen.de does not designate permitted sender
 hosts) smtp.mail=andi@rhlx01.hs-esslingen.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267333>

[git-owner CC dutifully removed]

On Thu, Apr 16, 2015 at 05:48:42PM +0200, Johannes Schindelin wrote:
> Hi Peff,
> 
> On 2015-04-16 17:28, Jeff King wrote:
> > On Thu, Apr 16, 2015 at 01:35:05PM +0200, Andreas Mohr wrote:
> > 
> >> I strongly suspect that git's repacking implementation
> >> (probably unrelated to msysgit-specific deviations,
> >> IOW, git *core* handling)
> >> simply is buggy
> >> in that it may keep certain file descriptors open
> >> at least a certain time (depending on scope of implementation/objects!?)
> >> beyond having finished its operation (rename?).
> > 
> > Hrm. [... detailed analysis, including a Minimal, Complete & Verifiable Example ...]
> 
> Thank you so much! I will definitely test this (at the moment, I have to recreate my build environment in a different VM than I used so far, that takes quite some time...)

Your hash-object script successfully and with ease
managed to provoke the issue again, thanks a lot!
(syntax issue though: missed a '|' pipe).

And I then did some unload tests (force-unloaded, via End Process Tree) of the virus,
and the unlink issue persisted
(but to be truly certain, I would have to rename away
the entire virus installation tree).
Not to mention that it already looks anyway
like we seem to be on the way of nailing a genuine git handling bug...

Also, I have a very hard time remembering that the "retry unlink?" EVER
finally ended up successful (despite virus file activity surely being a very
temporary thing!).

So much for some "related" observations that I can contribute currently
- I had no time left to actually work on it today
but I'll try to do some testing given the very detailed
(and gratifyingly matching :) analysis of Jeff King (thanks a lot, too!).

Andreas Mohr

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
