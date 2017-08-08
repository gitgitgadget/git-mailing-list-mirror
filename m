Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B9A8208B4
	for <e@80x24.org>; Tue,  8 Aug 2017 09:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751891AbdHHJRM (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 05:17:12 -0400
Received: from mail-ua0-f173.google.com ([209.85.217.173]:38369 "EHLO
        mail-ua0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750818AbdHHJRL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 05:17:11 -0400
Received: by mail-ua0-f173.google.com with SMTP id w45so11998024uac.5
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 02:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2V8RMSlB/QyP9OqZkTqrDBjMT75OEnVbSR+J8wQrquY=;
        b=KB7pWCsi+PEbJs5NC7CQg5eVF/ljGbWHsIbF0exEtwIAq2+ZnzNCGeO0YQLtU/DIZH
         gKufGbdu8NjZUClstO/DWbfL8L1f3x20aJGIiY4Po+KmEtRpGgwTqD94FKXiyhZ4wqoM
         dB2Dibp9NYYUrTPDaihVsmHYd8M6H2Ilf0NEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2V8RMSlB/QyP9OqZkTqrDBjMT75OEnVbSR+J8wQrquY=;
        b=D33DTTfIE2kYnDdfx4VLfiuADc12CnJk8q7ZzMSl9kDqOYC4vC8aEp02Z9RGb/qxGa
         /hk78c9NXUFkUHqn5LPRzSGkRi06xPMPg4tn45HsHJmi7mC3qixUb47FcgBoj4zEN12c
         GuNG+3BX6OOFajRD57f6l62+Evx99P25952/r+zG6ZBWm6YOz6Zvky26ds/3cJQqqpsi
         GJbWNat1BsNYfvJ8HZjglS+DdOE7rr/WsiEWHB6Z+yjynLq07SteSn3F2GRM2uU/RE7+
         lMz1IJacZ9bOy524R2PWcRu6fP7xNcGOf0suY7fQWcVTvUXb0GlpPWwKQYGag7MCz3t5
         pukA==
X-Gm-Message-State: AHYfb5jG5fQ9AfoT9+pkNs80weRyJN+fHQWZKW8P2vcrYTe/fICsaDAR
        D/RyRC6w021nwpPtLk36V5clXvONJgY+
X-Received: by 10.159.54.111 with SMTP id s44mr2364423uad.197.1502183830091;
 Tue, 08 Aug 2017 02:17:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.83.7 with HTTP; Tue, 8 Aug 2017 02:16:49 -0700 (PDT)
In-Reply-To: <20170808075254.sfazy7a6oc5bcc7b@sigill.intra.peff.net>
References: <CAJo=hJsOHF0KVmXvbSBiBgxq4zRdt7v7sj_GuKvcpbu8tkujFA@mail.gmail.com>
 <874ltkzlcf.fsf@gmail.com> <CAJo=hJuPwEWJEWOUpJ_T-=j0NxnzjOLy_=-qG51_zuYhKbBvrw@mail.gmail.com>
 <CAOhB0ruYhGAyNn84ZjS7TH7QdwxNi2bPN8KFxEEBd58B9qVrmg@mail.gmail.com>
 <CAJo=hJsEaKH40WnhxqvkASpiXnV8ipc+b1zrZ9VEjqRjpJ17Qg@mail.gmail.com>
 <833bc420609e452e8837862eb90f6a43@exmbdft7.ad.twosigma.com> <20170808075254.sfazy7a6oc5bcc7b@sigill.intra.peff.net>
From:   Shawn Pearce <spearce@spearce.org>
Date:   Tue, 8 Aug 2017 02:16:49 -0700
Message-ID: <CAJo=hJv7-m0eQUt0fpsoJ6+xWk8nnMU_5_=yktCCGbGYhao8_w@mail.gmail.com>
Subject: Re: reftable [v5]: new ref storage format
To:     Jeff King <peff@peff.net>
Cc:     David Turner <David.Turner@twosigma.com>,
        Ben Alex <ben.alex@acegi.com.au>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        David Borowitz <dborowitz@google.com>,
        Stefan Beller <sbeller@google.com>,
        Kristoffer Sjogren <stoffe@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 8, 2017 at 12:52 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Aug 07, 2017 at 03:40:48PM +0000, David Turner wrote:
>
>> > -----Original Message-----
>> > From: Shawn Pearce [mailto:spearce@spearce.org]
>> > In git-core, I'm worried about the caveats related to locking. Git tries to work
>> > nicely on NFS, and it seems LMDB wouldn't. Git also runs fine on a read-only
>> > filesystem, and LMDB gets a little weird about that. Finally, Git doesn't have
>> > nearly the risks LMDB has about a crashed reader or writer locking out future
>> > operations until the locks have been resolved. This is especially true with shared
>> > user repositories, where another user might setup and own the semaphore.
>>
>> FWIW, git has problems with stale lock file in the event of a crash (refs/foo.lock
>> might still exist, and git does nothing to clean it up).
>>
>> In my testing (which involved a *lot* of crashing), I never once had to clean up a
>> stale LMDB lock.  That said, I didn't test on a RO filesystem.
>
> Yeah, I'd expect LMDB to do much better than Git in a crash, because it
> relies on flock. So when the kernel goes away, so too does your lock
> (ditto if a git process dies without remembering to remove the lock,
> though I don't think we've ever had such a bug).
>
> But that's also why it may not work well over NFS (though my impression
> is that flock _does_ work on modern NFS; I've been lucky enough not to
> ever use it). Lack of NFS support wouldn't be a show-stopper for most
> people, but it would be for totally replacing the existing code, I'd
> think. I'm just not clear on what the state of lmdb-on-nfs is.
>
> Assuming it could work, the interesting tradeoffs to me are:
>
>   - something like reftable is hyper-optimized for high-latency
>     block-oriented access. It's not clear to me if lmdb would even be
>     usable for the distributed storage case Shawn has.
>
>   - reftable is more code for us to implement, but we'd "own" the whole
>     stack down to the filesystem. That could be a big win for debugging
>     and optimizing for our use case.
>
>   - reftable is re-inventing a lot of the database wheel. lmdb really is
>     a debugged, turn-key solution.
>
> I'm not opposed to a world where lmdb becomes the standard solution and
> Google does their own bespoke thing. But that's easy for me to say
> because I'm not Google. I do care about keeping complexity and bugs to a
> minimum for most users, and it's possible that lmdb could do that. But
> if it can't become the baseline standard (due to NFS issues), then we'd
> still want something to replace the current loose/packed storage. And if
> reftable does that, then lmdb becomes a lot less interesting.

Peff, thank you for this summary. It echos my opinions as well.

On the one hand, I love the idea of offloading the database stuff to
lmdb. But its got two technical blockers for me: behavior on NFS, and
virtualizing onto a different filesystem in userspace.

I really need a specialized reference store on a virtualized
distributed storage. The JGit reftable implementation fits that need
today. So we're probably going to go ahead and deploy that in our
environment.

I'd like to start writing a prototype reftable in C for git-core soon,
but I've been distracted by the JGit version first. It would be good
to have something to compare against the lmdb approach for git-core
before we make any decisions about what git-core wants to promote as
the new standard for ref storage.
