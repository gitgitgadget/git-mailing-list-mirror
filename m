From: Andreas Ericsson <ae@op5.se>
Subject: Re: Linus' sha1 is much faster!
Date: Mon, 17 Aug 2009 10:22:32 +0200
Message-ID: <4A891348.5030203@op5.se>
References: <4A85F270.20703@draigBrady.com>  <3e8340490908151302y33a97d50t38ad0a8a788f1cee@mail.gmail.com> <43d8ce650908151312o6a43416el27965c4b0ab8d83d@mail.gmail.com> <alpine.LFD.2.01.0908151315400.3162@localhost.localdomain> <alpine.LFD.2.01.0908151336530.3162@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: John Tapsell <johnflux@gmail.com>,
	Bryan Donlan <bdonlan@gmail.com>,
	=?ISO-8859-15?Q?P=E1draig_Brady?= <P@draigbrady.com>,
	Bug-coreutils@gnu.org, Git Mailing List <git@vger.kernel.org>,
	Brandon Casey <drafnel@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@cam.org>,
	Paul Kocher <paul@paulkocher.com>,
	Paul Kocher <paul@cryptography.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Aug 17 10:22:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McxUL-0007V7-AA
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 10:22:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757388AbZHQIWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 04:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757223AbZHQIWg
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 04:22:36 -0400
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:59082 "HELO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757278AbZHQIWf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Aug 2009 04:22:35 -0400
Received: from source ([74.125.78.26]) by na3sys009aob113.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSokTS3a75SZwl9tWGR0j1GwYNUIRnnj2@postini.com; Mon, 17 Aug 2009 01:22:37 PDT
Received: by ey-out-2122.google.com with SMTP id 22so562584eye.51
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 01:22:35 -0700 (PDT)
Received: by 10.210.119.16 with SMTP id r16mr6618939ebc.49.1250497354914;
        Mon, 17 Aug 2009 01:22:34 -0700 (PDT)
Received: from clix.int.op5.se (90-227-176-162-no128.tbcn.telia.com [90.227.176.162])
        by mx.google.com with ESMTPS id 10sm12498138eyz.31.2009.08.17.01.22.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Aug 2009 01:22:34 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <alpine.LFD.2.01.0908151336530.3162@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126141>

Linus Torvalds wrote:
> 
> On Sat, 15 Aug 2009, Linus Torvalds wrote:
>> That said, I don't know if the MPL is ok for X11. I've not looked at 
>> compatibility issues with MPL. For git, we could just ignore the MPL, 
>> since the GPLv2 was acceptable regardless of it.
> 
> If MPL isn't ok for X11, then we'd need to make sure that even the 
> silliest Mozilla crud has been rewritten. There really isn't much, but 
> hey, the _history_ is based on the mozilla code, and who knows - the 
> 'blk_SHA_CTX' struct has things like the fields in the same order as the 
> Mozilla equivalent, for all those historical reasons.
> 
> (Heh. Looking at that, I probably should move the 'size' field first, 
> since that would have different alignment rules, and the struct would be 
> more tightly packed that way, and initialize better).
> 
> Afaik, none of the actual code remains (the mozilla SHA1 thing did the 
> wrong thing for performance even for just the final bytes, and did those a 
> byte at a time etc, so I rewrote even the trivial SHA1_Final parts).
> 
> Of course, maybe the Mozilla people would be interested in taking my 
> faster version, and say that the new-BSD license is ok, and make everybody 
> happy. The only listed author for the Mozilla SHA1 is Paul Kocher. I added 
> him to the Cc.
> 
> Paul, for your information, we're talking about a faster rewritten "mostly 
> portable" SHA1 routines that you can find at
> 
> 	http://git.kernel.org/?p=git/git.git;a=tree;f=block-sha1;hb=pu
> 
> (follow the "blob" pointers to see sha1.c and sha1.h). I don't know if 
> you're active with Mozilla/Firefox or whether you even care, but you seem 
> to be the logical choice of person to ask.
> 

I contacted Paul in february this year to get permission to use the mozilla
sha1 code for libgit2. His reply then was:
"I'm not sure which version the diffs are relative to, so I haven't reviewed them.
It's fine to distribute under BSD, GPL, or LGPL, however."

I also got explicit permission to relicense it under GPLv2 with the gcc exception.

I added the mail-address I used to contact him to CC as well. Sorry if you get
this twice, Paul.

Naturally, I'd like to use the faster version for libgit2 as well. The people
who Linus listed as contributors earlier (Brandon Casy, Linus, Junio and Nicolas
Pitre) have already consented to relicense their git contributions for libgit2
use. If anyone would like to revoke that consent for this code, speak now please,
or I'll patch it into libgit2 as well.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
