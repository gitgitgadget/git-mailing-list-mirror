Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F81AC4167B
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 10:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237659AbiLNKFS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 05:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiLNKFP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 05:05:15 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9525E6593
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 02:05:14 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id kw15so43214790ejc.10
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 02:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PMo1ONqIQAlUMCQABhoEzYlVdF+/ZywJP2Qvzu1HYi8=;
        b=H/Xkpgi/Yg3Hg5JU8gNNeGDXf1XAfXFXp9VKmI+0f+QcwyWj07pa+hM26vMPfKkSpL
         vDRXYURqu1DkjZ82gPGcr2877+LHrjTelLR6ZLaMdgWob+WsbRePG2LHRTCXyWxkokoe
         uP1H5k1j6SB+EyZ26nPzLD9Com9z4ijDo5KSXSR2o7AgztSixZYnUGlc2Xwydx8XjESi
         2amNyZAOObJZFejashooFF8KqriTZjau5UqPSohWtaOiE5SP4mCKJV4XWoRNz0/AhXyE
         Vv+0HP/DffEnxLM1tahw/M+C1ft+hpA2uAL+/CzBHu1vL05amQItRNhMd5oZ6s3XhIU+
         LtrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMo1ONqIQAlUMCQABhoEzYlVdF+/ZywJP2Qvzu1HYi8=;
        b=D43W4cGaRHhh3H10YqsjHMW3tdBjZnWT12CPld/L1+sm4BpFR2Mu4OYI2nOttUMjrc
         eUTyBLd2bRxKNPalHxwE7jXnkWkTwn9FSRkVFGRp5RD1KYeq7sd6JZ/ew/F4pkuheZ0E
         CLg4cOCC2bMMPPjjc7whx/UYqpkT1mj5PcnO691IYXnwtgWo5weOt4+LkTa5C4NQ6+EH
         X7sq3TxenKqfd5RvqAKrS6tTeo+vbHAa7gY0LTJTEnBxSCaydl2yvefNQWBIp02JIkw2
         DghcHyqyUbJZRw+po47mT2wuqo80f6XAw4hhGLKU5jI8z5BlGhSYImY0N5clsEJ3U1bM
         SKfA==
X-Gm-Message-State: ANoB5pnTnHCK3xSlZUqmjBTwP7Dh5QNKnCjou74w9M6PBtkVlkB3Hi4f
        p62wCrBJAEiLu+emBoL6Dbo=
X-Google-Smtp-Source: AA0mqf7WwaVbWu9+psSp3rcA8uGZpFzxc73DMl1PPM7OQwCvnPne4pFBvFQRPWzAlZiBaWyDTjfOhA==
X-Received: by 2002:a17:907:c05:b0:7ae:b2e4:7b3f with SMTP id ga5-20020a1709070c0500b007aeb2e47b3fmr25764671ejc.8.1671012313088;
        Wed, 14 Dec 2022 02:05:13 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id vw11-20020a170907a70b00b007b935641971sm2932684ejc.5.2022.12.14.02.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 02:05:12 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p5OdT-005XnB-3D;
        Wed, 14 Dec 2022 11:05:12 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com, me@ttaylorr.com
Subject: Re: [RFC PATCH 6/6] ls-tree: introduce '--pattern' option
Date:   Wed, 14 Dec 2022 11:03:39 +0100
References: <20221117113023.65865-1-tenglong.tl@alibaba-inc.com>
 <20221117113023.65865-7-tenglong.tl@alibaba-inc.com>
 <2q985o75-p6ro-3319-rqos-004621r0p7pq@tzk.qr> <xmqqtu20qinx.fsf@gitster.g>
 <xmqqbko6y2q5.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqqbko6y2q5.fsf@gitster.g>
Message-ID: <221214.86edt247xk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 14 2022, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>>> The hard-coded object IDs break the `linux-sha256` job, as pointed out in
>>> https://github.com/git/git/blob/6ab7651d8669/whats-cooking.txt#L522-L537.
>>>
>>> Please squash this in to address this (Junio, please feel free to
>>> cherry-pick this on top of `tl/ls-tree--pattern` to reduce the number of
>>> CI failures):
>
> After re-reading the patches, I am very much inclined to drop this
> topic, which does not add much value to the system and adds an odd
> corner case in the UI.
>
> Who needs "git ls-tree --pattern='blob 486' HEAD" that is a synonym
> to "git ls-tree HEAD | grep 'blob 486'"?  Should we end up adding
> the same option to "git ls-files", "git status", "git ls-remote",
> "git remote", "git branch --list", etc. for consistency?
>
> This is simply insane and goes directly against the "one tool does
> one job well, and can be combined with other such tools via pipe",
> which is a key to scale the usability of a set of tools.

I agree, and FWIW I read
https://lore.kernel.org/git/20221121114150.3473-1-tenglong.tl@alibaba-inc.com/
as the submitter of the topic agreeing to drop it ~3 weeks ago.
