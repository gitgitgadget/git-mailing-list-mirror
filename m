From: Ingo Molnar <mingo@elte.hu>
Subject: Re: linux-next: stackprotector tree build failure
Date: Wed, 22 Oct 2008 09:29:23 +0200
Message-ID: <20081022072923.GC27637@elte.hu>
References: <20081022131124.a572b11f.sfr@canb.auug.org.au> <20081022043227.GA31413@elte.hu> <20081022182149.f89fe88d.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gleixner <tglx@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-next@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
X-From: linux-next-owner@vger.kernel.org Wed Oct 22 09:30:58 2008
connect(): Connection refused
Return-path: <linux-next-owner@vger.kernel.org>
Envelope-to: glkn-linux-next@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsYBF-0001Qy-91
	for glkn-linux-next@gmane.org; Wed, 22 Oct 2008 09:30:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631AbYJVH3m (ORCPT <rfc822;glkn-linux-next@m.gmane.org>);
	Wed, 22 Oct 2008 03:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752035AbYJVH3m
	(ORCPT <rfc822;linux-next-outgoing>);
	Wed, 22 Oct 2008 03:29:42 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:34322 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751631AbYJVH3l (ORCPT <rfc822;linux-next@vger.kernel.org>);
	Wed, 22 Oct 2008 03:29:41 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1KsY9m-0004Xh-BT
	from <mingo@elte.hu>; Wed, 22 Oct 2008 09:29:28 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 9DCEE3E21A3; Wed, 22 Oct 2008 09:29:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20081022182149.f89fe88d.sfr@canb.auug.org.au>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx2: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00,DNS_FROM_SECURITYSAGE autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.0 DNS_FROM_SECURITYSAGE  RBL: Envelope sender in
	blackholes.securitysage.com
Sender: linux-next-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-next.vger.kernel.org>
X-Mailing-List: linux-next@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98834>


* Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi Ingo,
> 
> On Wed, 22 Oct 2008 06:32:27 +0200 Ingo Molnar <mingo@elte.hu> wrote:
> >
> > This seems to have been caused by a git-rerere bug - it mis-matched a 
> > timers tree conflict resolution. I cleared out that resolution (it had 
> > nothing to do with stackprotector), re-did the conflict resolution 
> > (which was about overlapping additions of header files), and pushed out 
> > a new stackprotector tree - the delta below has the expected result.
> 
> I wondered how you could have possibly got that result - aren't 
> computers wonderful! :-)

heh, yes :)

this is the second time i met a git-rerere mismatch - the first one was 
half a year ago.

Unfortunately i failed at generating a reproducer back then and even now 
- as to resolve this problem i manually removed the preimage and 
postimage, so it's gone now.

I've Cc:-ed Junio and the Git list as a general FYI - but it must be 
frustrating to get such a bugreport, because i have no reproducer.

git-rerere sometimes seems to be picking up the wrong resolution. VERY 
rarely.

It seems random and content dependent. Once it happened to 
arch/x86/kernel/traps_32.c and now to kernel/fork.c. Along the ~170 
successful resolutions i have in my tree right now. And i do many 
conflict resolutions every day - and it happened only once every 6 
months or so.

(the arch/x86/kernel/traps_32.c one happened regularly, that's why i 
thought it's content sha1 dependent, and not some corruption.)

Next time it happens i'll be on the watchout and will save the complete 
tree.

	Ingo
