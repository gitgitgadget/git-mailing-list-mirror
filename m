From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-rerere observations and feature suggestions
Date: Wed, 18 Jun 2008 15:01:24 -0700 (PDT)
Message-ID: <m33anao11u.fsf@localhost.localdomain>
References: <20080616110113.GA22945@elte.hu>
	<7vej6xb4lr.fsf@gitster.siamese.dyndns.org>
	<20080616190911.GA7047@elte.hu> <20080618105731.GA9242@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Thu Jun 19 00:02:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K95jT-0000QP-Ez
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 00:02:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754168AbYFRWB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 18:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754145AbYFRWB1
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 18:01:27 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:39506 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754083AbYFRWB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 18:01:27 -0400
Received: by an-out-0708.google.com with SMTP id d40so107771and.103
        for <git@vger.kernel.org>; Wed, 18 Jun 2008 15:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=idX9wOPn7hdt8z40EowJcrqnplqM1xGdAfXOrNfBmvI=;
        b=tn7U4eIxAx7dnhSe98cCvhzLxBDmnFSheXtBa4jmSG4bhTUGgGcNJG+ShJ43l3GWyL
         VC0sShaeHf0aQyf55pbrL7zH/AZgV4jK3s/EBZ2Ic1oAE3XwbxDMnqr3nO3Rpa+etuwU
         QMJAM8bKgDdneYX2L81xl8nMXBak42ZV297J4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=bxxuZ/WYSCbhZckFLf5NLzB/H8mWFxBaLQiLhJ1gSd6uKFomniNR0DrnrX2lBKUWTg
         qjQKYptC8sjP4+5hEVnDiNtbOfixHVnVKPOgDuryYFfLaMImimj9EOm9tM1OvRe+nv6A
         ng55Gwhq7vlyn+bKCsFbiDVcZmcbrI5VG9lGI=
Received: by 10.101.67.15 with SMTP id u15mr1926635ank.136.1213826485910;
        Wed, 18 Jun 2008 15:01:25 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.255.188])
        by mx.google.com with ESMTPS id m71sm5678207rnd.16.2008.06.18.15.01.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Jun 2008 15:01:24 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5IM1M2e012647;
	Thu, 19 Jun 2008 00:01:22 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5IM1HV6012644;
	Thu, 19 Jun 2008 00:01:17 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080618105731.GA9242@elte.hu>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85412>

Ingo Molnar <mingo@elte.hu> writes:

> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > And while asking for an arm i'd also like to ask for a leg, if i may: 
> > i'd love it if a "slightly conflicting" octopus merge of 85 topic 
> > trees would not result in one huge conflict commit that merges 
> > together 1000 commits into a single commit ;-)
> > 
> > So right now in our -tip scripts work around this issue: we 
> > 'serialize' the topic merges despite having very nice opportunities 
> > for higher-order octopus merges. The integration would be a lot faster 
> > if we could use octopus merges and automated git-rerere. (Octopus 
> > merges would look much nicer as well in graphical representation as 
> > well, which counts too :-) )
> 
> just to demonstrate it, i tried today to do an octopus merge of 87 topic 
> branches:
> 
> git-merge build checkme core/checkme core/debugobjects core/futex-64bit 
> core/iter-div core/kill-the-BKL core/locking core/misc core/percpu 
> core/printk core/rcu core/rodata core/softirq core/softlockup 
> core/stacktrace core/topology core/urgent cpus4096 genirq kmemcheck 
> kmemcheck2 mm/xen out-of-tree pci-for-jesse safe-poison-pointers sched 
> sched-devel scratch stackprotector timers/clockevents timers/hpet 
> timers/hrtimers timers/nohz timers/posixtimers tip tracing/ftrace 
> tracing/ftrace-mergefixups tracing/immediates tracing/markers 
> tracing/mmiotrace tracing/mmiotrace-mergefixups tracing/nmisafe 
> tracing/sched_markers tracing/stopmachine-allcpus tracing/sysprof 
> tracing/textedit x86/apic x86/apm x86/bitops x86/build x86/checkme 
> x86/cleanups x86/cpa x86/cpu x86/defconfig x86/delay x86/gart x86/i8259 
> x86/idle x86/intel x86/irq x86/irqstats x86/kconfig x86/ldt x86/mce 
> x86/memtest x86/mmio x86/mpparse x86/nmi x86/numa x86/numa-fixes x86/pat 
> x86/pebs x86/ptemask x86/resumetrace x86/scratch x86/setup x86/smpboot 
> x86/threadinfo x86/timers x86/urgent x86/urgent-undo-ioapic x86/uv 
> x86/vdso x86/xen x86/xsave
> 
> it failed miserably:
> 
>  warning: ignoring 066519068ad2fbe98c7f45552b1f592903a9c8c8; cannot 
>  handle more than 25 refs
>  [...]
>  fatal: merge program failed
>  Automated merge did not work.
>  Should not be doing an Octopus.
>  Merge with strategy octopus failed.
> 
> this wasnt even for purposes of an integration run: all i wanted to do 
> was to pick up 2-3 new commits i have queued into 2-3 topic branches, 
> into the (throw-away) integration branch. All the other branches were 
> unmodified and already merged into the integration branch.
> 
> Hence i believe that the suggestions above by Git that i'm doing 
> something wrong are ... wrong :-)
> 
> My scripting around this would be a lot faster (less than 10 seconds 
> runtime versus a minute currently) and more robust if we could do such 
> higher-order octopus merges.

As a part of patch series introducing new fast-forward strategies
(--ff=never, --ff=only) there was patch which did merge reduction
before selecting merge strategy, by Sverre Hvammen Johansen
  "[PATCH 4/5] Head reduction before selecting merge strategy"
  http://thread.gmane.org/gmane.comp.version-control.git/80288/focus=80335
(I'm not sure if the link above is to nevest version of patch series).

It is now part of 'pu' branch, as commit 59171adb9c.  It didn't make
into 'next' as it conflict with builtin merge by Miklos Vajna, which
(as he wrote) also includes head reduction.

So you either would have to compile git from builtin-merge repository,
compile git from 'pu' or just use git-merge.sh from 'pu' branch, or
apply or cherry pick appropriate commit and compile git.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
