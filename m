Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED2EF1F453
	for <e@80x24.org>; Thu, 31 Jan 2019 21:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbfAaVmS (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 16:42:18 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53749 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfAaVmS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 16:42:18 -0500
Received: by mail-wm1-f66.google.com with SMTP id d15so4043303wmb.3
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 13:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4NHMC2Do/obRjoLdGR6GRC8J7IFOJTjA1cYOV06fJLo=;
        b=Bt6UsjFABhA2wn/XMPhDgaYh7RmQpUsIOPy0CL5UesaY+T6hSeZYbLNT6nJSelFZLY
         Fm/TE62vQNSZsY3nVbuFBTP7KAAuFAqXeYDJ9e4/dnm93SPpK0L9pb9R6kMEVxlLFom7
         jK4MW79A55tWzbHq8p3XKrc1UBktJe+8TfuneoMiefEv6gUZSLnZ3VnX+rDh0ndmdWan
         iZ2Jc9lnuyLbJY7cc8KLJ0PDSIawJvv9SGsS/EiHZM91jmqpssz+XvbpSj5ZfluITiaY
         3eQw6AmUQ3rN0nQhusdU2/liTpfKd0SYBx1o6pRZDr0smyLDBAjTrkz9w46zUp/5/Wxo
         ldEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4NHMC2Do/obRjoLdGR6GRC8J7IFOJTjA1cYOV06fJLo=;
        b=NCFDwKRDEEeZDA/6ai8a6et1UDZKDTE7Sv9MHTvzC4FIkF2SPFYb+5K4fWyXr/Wwj/
         eyfzeneqchz27fsaB0rkNq2tmC9slDLmNpfieihcnVrsDjgUnj3Nds/wCTSzxKgYLshv
         IcJL+ZAgU//Lxz2xXFKmvhd72Kfx6clPuPI36foViGbObMpy3JUWNhjqFIAPpxRvKp47
         yPxNft9tSxsmLShm1xt0ryWIOANplpUIMrboEHvX8hmBvWvem8EXkp0aQmM8ixd/qZwM
         my2vgVkzzv35Fu1q+SOrsa22M66Q/o1sKXkMrStBalNVmrQuANecv3Eu9DI48Yw0P5o4
         2bgQ==
X-Gm-Message-State: AHQUAuYGdXaf36v9GQvJZFX3nAbpprTVx2SB0gfiawhDHrItrpQM5B7v
        HQiI/j7vfIKyoYO+xfSooFY=
X-Google-Smtp-Source: AHgI3IZzgI8TFwKFVRRY2H3/Ns/121PiLB0osiSadjfAB1KUlDNOPEtdRg9TJH04FsGKfz8M2WAWtA==
X-Received: by 2002:a1c:44c5:: with SMTP id r188mr11401332wma.151.1548970935576;
        Thu, 31 Jan 2019 13:42:15 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x12sm4815077wrt.20.2019.01.31.13.42.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 13:42:14 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Nickolai Belakovski <nbelakovski@gmail.com>, git@vger.kernel.org,
        Rafael =?utf-8?Q?Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v6 1/3] ref-filter: add worktreepath atom
References: <20190122232301.95971-1-nbelakovski@gmail.com>
        <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
        <20190122232301.95971-2-nbelakovski@gmail.com>
        <xmqq36pjcicw.fsf@gitster-ct.c.googlers.com>
        <CAC05384+KjC=4_ZF9BrxweMUjwpkaGXNqRNSnwif6yci6TxMMw@mail.gmail.com>
        <xmqq5zud52ut.fsf@gitster-ct.c.googlers.com>
        <20190124183235.GA16580@sigill.intra.peff.net>
        <xmqqd0olj1kj.fsf@gitster-ct.c.googlers.com>
        <20190124212608.GD16114@sigill.intra.peff.net>
Date:   Thu, 31 Jan 2019 13:42:14 -0800
In-Reply-To: <20190124212608.GD16114@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 24 Jan 2019 16:26:08 -0500")
Message-ID: <xmqqef8s1p3d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Jan 24, 2019 at 11:30:20AM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > What if you have other atoms that need worktrees? E.g., does
>> > %(worktreepath:foo) use the same used_atom slot? What if we have another
>> > worktree-related atom?
>> > ...
>> > And that one is a good example where we _do_ need the global, because we
>> > already have multiple atoms pulling from it.
>> 
>> I guess that we broke the original atom design by mistake when we
>> added ":<modifiers>" support.  There should have been one layer of
>> indirection that binds the instances of the same atom with different
>> modifiers together---I agree with you that we cannot avoid globals
>> without fixing that mistake first.
>
> Yes, that's one way to fix it.
>
> I actually think the biggest mistake is having that used_atoms list in
> the first place, as we iterate over it several times asking "can we fill
> this in yet?". The way pretty.c does it is just to incrementally parse
> the commit, saving intermediate results. And in cat-file.c, we figure
> out what we need ahead of time in a single pass, and then just fill it
> in for each object (which sort of works out the same, but doesn't
> require that the parsing needed for item X is a strict superset of item
> Y).
>
> So I'd much rather see us parse the format into a real tree of nodes,
> and figure out (once) which properties of each object are required to
> fulfill that. Then for each object, we grab those properties, and then
> walk the tree to generate the output string.

That sounds like a sensible longer-term strategy.  Let's however
leave it outside the scope of this change.
