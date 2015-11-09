From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4] Add git-grep threads param
Date: Mon, 9 Nov 2015 09:55:34 -0800
Message-ID: <CA+55aFzHic5AN05QkbERFszRC=i3aDDGy9yhXEjgzZjwzFVBLQ@mail.gmail.com>
References: <1445980944-24000-1-git-send-email-vleschuk@accesssoftek.com>
	<xmqqvb9jc81q.fsf@gitster.mtv.corp.google.com>
	<20151104064021.GB16605@sigill.intra.peff.net>
	<6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA15@mail.accesssoftek.com>
	<20151109155538.GC27224@sigill.intra.peff.net>
	<6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA17@mail.accesssoftek.com>
	<20151109165343.GA29179@sigill.intra.peff.net>
	<6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA18@mail.accesssoftek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Victor Leschuk <vleschuk@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"john@keeping.me.uk" <john@keeping.me.uk>
To: Victor Leschuk <vleschuk@accesssoftek.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 18:55:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZvqfM-0005hs-4B
	for gcvg-git-2@plane.gmane.org; Mon, 09 Nov 2015 18:55:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977AbbKIRzg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 12:55:36 -0500
Received: from mail-ig0-f175.google.com ([209.85.213.175]:35999 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589AbbKIRzf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2015 12:55:35 -0500
Received: by igcph11 with SMTP id ph11so32612036igc.1
        for <git@vger.kernel.org>; Mon, 09 Nov 2015 09:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=2HdYwXhjmUX8vqcTGy5L1fHlOuGBr2Jvsw/4EMm8gYw=;
        b=Uj0fnM7bBR2ttM1VN1QZsAT7AIDs6N+UAvqJKIYCkrxlTsN5/4nLmVNyk3h9+9YAxc
         66aMJoETX8clq9QTht61pT0JxuHozixLElTsuoyXqU53W/eaVIXy4RtpetGcg0qqfstY
         3J4yNreDRrH3yxB+wfvNbiNzk3T1mdZl1O4vGMftQBkyTT+tFIy1qgWyppzgBNyoZDY5
         0gAl8MHiBEezvpMoZwcILu9M1LQ8aLH7IxMMNheE7cuRCpO0YHX4KUpeOdT4ZJBaJwP3
         Kv4Og6oOig+42fl1Mryx+7pAQt0tEmKyI+13tFgWdWBULIfTQZOWwb8I3padzBt8aWDd
         xgpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=2HdYwXhjmUX8vqcTGy5L1fHlOuGBr2Jvsw/4EMm8gYw=;
        b=KmLqgypzjtM6Dn1pJhB0FG6wgVm17k3JhvI5JtiyS/Ngt4nWSkk5QPSe/ugffrtJS6
         e7T+Y2S0UhIp9FdaQvmqUtdffL45n9C612LfENUkqX60uXlmq0ngdGV5SnHAszDVl+yR
         s7uIU6y/em4azP9Vbwtm/Ku2xh0XeTG0l2YxA=
X-Received: by 10.50.20.105 with SMTP id m9mr21048539ige.45.1447091734458;
 Mon, 09 Nov 2015 09:55:34 -0800 (PST)
Received: by 10.36.33.81 with HTTP; Mon, 9 Nov 2015 09:55:34 -0800 (PST)
In-Reply-To: <6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA18@mail.accesssoftek.com>
X-Google-Sender-Auth: znDnUoAOweoVXmBzkUraim4wG_c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281072>

On Mon, Nov 9, 2015 at 9:28 AM, Victor Leschuk
<vleschuk@accesssoftek.com> wrote:
>
> Maybe use the simplest version (and keep num_numbers == 0 also as flag for all other checks in code like if(num_flags) .... ):
>
> if (list.nr || cached )
>   num_threads = 0; // do not use threads
> else if (num_threads == 0)
>   num_threads = online_cpus() <= 1 ? 0 : GREP_NUM_THREADS_DEFAULT;

I will say this AGAIN.

The number of threads is *not* about the number of CPU's. Stop this
craziness. It's wrong.

The number of threads is about parallelism. Yes, CPU's is a small part
of it. But as mentioned earlier, the *big* wins are for slow
filesystems, NFS in particular. On NFS, even if you have things
cached, the cache revalidation is going to cause network traffic
almost every time. Being able to have several of those outstanding is
a big deal.

So stop with the "online_cpus()" stuff. And don't base your benchmarks
purely on the CPU-bound case. Because the CPU-bound case is the case
that is already generally so good that few people will care all *that*
deeply.

Many of the things git does are not for "best-case" behavior, but to
avoid bad "worst-case" situations. Look at things like the index
preloading (also threaded). The big win there is - again - when the
stat() calls may need IO. Sure, it can help for CPU use too, but
especially on Linux, cached "stat()" calls are really quite cheap. The
big upside is, again, in situations like git repositories over NFS.

In the CPU-intensive case, the threading might make things go from a
couple of seconds to half a second. Big deal. You're not getting up to
get a coffee in either case.

In the network traffic case, the threading might make things go from
one minute to ten seconds. And *that* is a big deal. That's huge.
That's "annoyingly slow" to "oh, this is the fastest SCM I have ever
worked with in my life".

That can literally be something that changes how you work for a
developer. You start doing things that you simply would never
otherwise do.

So *none* of the threading in git is about CPU's. Maybe we should add
big honking comments about that.

And that big honking comment should be in the documentation for the
new flag too. Because it would be really really sad if people say "I
have a laptop with just two cores, so I'll set the threading option to
2", when they then work mostly over a slow wireless network and their
company wants minimal local installs.

The biggest reason to NOT EVER add that configuration is literally the
confusion about this being about CPU's. That was what got the whole
thread started, that was what the original benchmark numbers were
about, and that was WRONG.

So I would strongly suggest that Junio ignore these patches unless
they very clearly talk about the whole IO issue. Both in the source
code, in the commit messages, and in the documentation for the config
option.

                       Linus
