From: Artur Skawina <art.08.09@gmail.com>
Subject: Re: [PATCH 0/7] block-sha1: improved SHA1 hashing
Date: Fri, 07 Aug 2009 00:55:08 +0200
Message-ID: <4A7B5F4C.30102@gmail.com>
References: <alpine.LFD.2.01.0908060803140.3390@localhost.localdomain> <4A7B1166.8020507@gmail.com> <alpine.LFD.2.01.0908061052320.3390@localhost.localdomain> <4A7B2A88.2040602@gmail.com> <alpine.LFD.2.01.0908061233360.3390@localhost.localdomain> <4A7B384C.2020407@gmail.com> <alpine.LFD.2.01.0908061329320.3390@localhost.localdomain> <4A7B4D84.80906@gmail.com> <4A7B509A.5010405@gmail.com> <alpine.LFD.2.01.0908061502570.3390@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 07 00:55:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZBrn-0003wH-My
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 00:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754039AbZHFWzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 18:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752978AbZHFWzM
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 18:55:12 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:48956 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125AbZHFWzL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 18:55:11 -0400
Received: by bwz9 with SMTP id 9so1074757bwz.41
        for <git@vger.kernel.org>; Thu, 06 Aug 2009 15:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=MBFGTEXaTuaSS+L45rab8BUHt2ob6omv+OtbygzFI/g=;
        b=kVJ5zTC3rymmxzkFXSL5rK/ByzmLQnjp1XanViRsuh8/M8K991L0mbrklfhjrwNJ8j
         p0NnmqGrUTCCtTTPFBrnvoATC/ZVi1wAyoBP7JZTLlf1+Tz0bTpQbZj7tOt/JtETZXz+
         lTo+W1hu6WbptlI9eu6aHax23PJvPfbAXzZxY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=mR+MhFr2ms1iff/xR1eYg4IUMt7Y2ds0Dj00mLI99WtwpD6r6NoFphYA/gQiIZkkEx
         Wcdz+I35ZJ9eSXxFjIOxcqdP7kbrfrJb/OopGK1R+Z7V7B/E6yr7/zYxKzj6+s/MkPFu
         mU5ZqAAyDR+P7tsudl3RbPf7z+XKTrsQZzu0Q=
Received: by 10.204.65.17 with SMTP id g17mr2525289bki.193.1249599309785;
        Thu, 06 Aug 2009 15:55:09 -0700 (PDT)
Received: from ?172.19.43.221? (ip-89-174-120-248.multimo.pl [89.174.120.248])
        by mx.google.com with ESMTPS id 22sm1453589fkr.30.2009.08.06.15.55.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 Aug 2009 15:55:09 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22pre (X11/20090422)
In-Reply-To: <alpine.LFD.2.01.0908061502570.3390@localhost.localdomain>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125135>

Linus Torvalds wrote:
> 
> On Thu, 6 Aug 2009, Artur Skawina wrote:
>> Does this make any difference for you? For me it's the best one so far
>> (the linusas2 number clearly shows that for me the register renaming does
>> nothing; other than that the functions should be very similar)
> 
> Nope. If anything, it's bit slower, but it might be in the noise. I 
> generally got 330MB/s with my "cpp renaming" on Nehalem (32-bit - the 
> 64-bit numbers are ~400MB/s), but with this I got 325MB/s twice in a row, 
> which matches the linusas2 numbers pretty exactly.
> 
> But it seems to make a big difference for you.

It seems to do well on P2 and P4 here, if it works for core2 this could
be a good generic candidate. It only does 62% on an Atom, but the best C
version so far exceeds it only by ~2%.

> Btw, _what_ P4 do you have (Northwood or Prescott)?

northwood

> The Intel optimization manuals very much talk about avoiding rotates. And 
> they mention "with a CPUID signature corresponding to family 15 and model 
> encoding of 0, 1, or 2" specifically as being longer latency. That's 
> basically pre-prescott P4, I think.

cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.80GHz
stepping        : 5

> Anyway, on P4 I think you have two double-speed integer issue ports (ie 
> max four ops per cycle), but only one of them takes a rotate, and only in 
> the first half of the cycle (ie just one shift per cycle).
> 
> And afaik, that is actually the _improved_ state in Prescott. The older 
> P4's didn't have a full shifter unit at all, iirc: shifts were "complex 
> instructions" in Northwood and weren't even single-clock.
> 
> In Core 2, I think there's still just one shifter unit, but at least it's 
> as fast as all the other units. So P4 really does stand out as sucking as 
> far as shifts are concerned, and if you have an older P4, it will be even 
> worse.

hmm, I might be able to try it on some old willamette, but my prescott's
mobo died, so i can't verify that right now.

I'll upload an updated sha1bench, maybe somebody else feels like checking...

artur 
