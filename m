Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B01CB1F42D
	for <e@80x24.org>; Wed, 30 May 2018 22:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932539AbeE3W5b (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 18:57:31 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46747 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753740AbeE3W53 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 18:57:29 -0400
Received: by mail-wr0-f193.google.com with SMTP id v13-v6so19409494wrp.13
        for <git@vger.kernel.org>; Wed, 30 May 2018 15:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=/iYbxLdHWdNC4VoVrs5TQCj9TWe0NNiQd8F3TJU/SAE=;
        b=u+njO8TR+ob9P29PHafsv2BHJuKjhC2LAyMy7TdIMKvRHESGVXuMcEkyZG0G/cmjaK
         gN5QqHuPzsoqG+dQlPtNj5dL3Q0GaA+F27aZInWWG08IAOokYGPDZ6O5TdOvQCkST1HC
         yaEuoEJ2gmeSotfaHrqgciikVOZ2K9A+6ANwmhbRbz4QhNeyk8wiAS/T4014pfiMcmZn
         hM0tV4jOWxLkUjsbckxN9lZMCdl7RJ1TzEyo7Yj561jQs0o6C4RAYu7x6kSXjtGzFUz0
         vAI2YlsL9i6RyWKq5VrEa58qIb6vcTGlzmsbYlj9aw8hYDoxnJjnzz5gdSCqpjvOaLyy
         IU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=/iYbxLdHWdNC4VoVrs5TQCj9TWe0NNiQd8F3TJU/SAE=;
        b=Xezy3wimgKC2g9xfukdVxRX3n+oUXUChzi9SDHzoMhAA84bJJkZ4rZs40+16APAD0d
         7QKFEofdsKl2bXGO11P448qmdlAR4JqkXBvolt1k7xN4C9D4HxxtpaaJX4q7I7VhxV//
         LyFVAkb/Z9HpNRRu8MIEN8a70YhfWMiSozXLiqJOLtPyQRQn73ZCJ3RUPCj4B7jzbpz6
         1crvBVqjkFX7qe0QafC3YNeu1/48m8a9KJA8PSrWDvlysbfDbyvUYgMHMhY4E5Ftel8p
         17q76JKLJ3aESD5Bky1DaGqPSo1lC5r9SFQzfcpRQgn04T0LtxVNy8S1JVPDrZW5BgcM
         F6MA==
X-Gm-Message-State: ALKqPwcEX+rdefdBxHRvl5WAmZ/IhkGWGrObwfxZk20dqcM7ZwKNCWzq
        TBS7KGV7ZxkaFUyfvTFFVP0=
X-Google-Smtp-Source: ADUXVKLcsPIKJPHuBtu4jc8c1RjiW48C79YHFDeVsEJrwezUFujdFr+5lCu2jaK6cyLjqKretqnMjw==
X-Received: by 2002:adf:9c01:: with SMTP id f1-v6mr3369882wrc.171.1527721048413;
        Wed, 30 May 2018 15:57:28 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u108-v6sm29262172wrc.40.2018.05.30.15.57.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 May 2018 15:57:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH 4/4] color.ui config: add "isatty" setting
References: <20180530210641.19771-1-avarab@gmail.com>
        <20180530210641.19771-5-avarab@gmail.com>
Date:   Thu, 31 May 2018 07:57:27 +0900
In-Reply-To: <20180530210641.19771-5-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 30 May 2018 21:06:41 +0000")
Message-ID: <xmqqmuwgda5k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> A co-worker of mine who was using UNIX systems when dinosaurs roamed
> the earth was lamenting that kids these days were using tools like
> "git" that thought they knew better than isatty(3) when deciding
> whether or not something was a terminal, and the state of the
> documentation fixed earlier in this series certainly didn't help.
>
> So this setting is a small gift to all the UNIX graybeards out
> there. Now they can set color.ui=isatty and only emit fancy colors in
> situations when the gods of old intended, not whatever heuristic we've
> decided to set "auto" to.

Re-read the above again, and notice that you are *only* hinting that
you consider difference between "auto" and "isatty" is important,
and that your "isatty" is better, without telling what the
difference is, let alone why you think "isatty" is better.

>
> As noted here this is *currently* the same as setting color.ui=auto &
> color.pager=false, but I think it's good to explicitly have this
> setting for any future changes. The reason, as now noted in the
> documentation is that the "auto" setting may become even smarter in
> the future and learn even deeper heuristics for when to turn itself on
> even if isatty(3) were returning true.

Do you mean s/true/false/ in the last part?

> At that point the fans of plain isatty(3) will become even more upset
> at what we're doing, so let's give them a simple future-proof opt-out.

You still haven't explained why "auto" that does more than "isatty"
is and will be irritating.

That's not a good way to sell a patch.

Also even "isatty" still needs to do more than isatty(1) call.  The
process that is trying to do color.ui=isatty may be talking to an
outgoing pipe due to the use of "git -p cmd", by that time, it is
too late to call isatty(1) and obtain the info the caller wishes to.
