Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A1091F461
	for <e@80x24.org>; Sat, 24 Aug 2019 12:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbfHXM6F (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Aug 2019 08:58:05 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45156 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbfHXM6F (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Aug 2019 08:58:05 -0400
Received: by mail-io1-f67.google.com with SMTP id t3so26471761ioj.12
        for <git@vger.kernel.org>; Sat, 24 Aug 2019 05:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mXt8m13ZIbFUS25mh+STgLCmTDxb7Sj3SImKPT8tU7U=;
        b=HA94jCnXDEHZg8L6POJUK+Merllr/FVfes0yvK0Tb2C/VY4muNrAULy6rfToIIx+T4
         8XGyjjnPz49RxQs077bd29BkNLFJN9T71fWMggh6Kb77TPk+W3axt9FeyIGnvngAvrMu
         wD99798zU4Qi055CtL0ngFo0EpQLmelnofO/2Pe0/ZrL7T5QuR5LrDnhKQj32Al5WBuP
         NWKnT0Qya5JMbw+m6ZaEVYHlyJc19O+bscRGcpP7PRVSZKCxKxYM/lslaNIEvH0XJMe2
         I+BJLt2fk43sJJmCZOHgXVMKjnK7600APFQ36ynBobJGadl00R2haOEBxtmbJWRwK99J
         8B6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mXt8m13ZIbFUS25mh+STgLCmTDxb7Sj3SImKPT8tU7U=;
        b=YqX4uEmjMBaSwkLTsu2GZJ5clu8c5nZdgboN84PXn5FKmiUxbX85PwEPiJcXo4zmiK
         pTx9ZI77eYvFUZTz0dSg1kQee4wr0L7miy3We2EbCDv4LLnmFdpBmbWlJl4NNK57sS0p
         OdxC3c1onOoqe6lBVpuPCRNlaUwYwkpzUl6qn3p0XvTaep0EbVFzg0dRKbGf3NkEfS9S
         XV5TNWYp7utQJyp1IlIdv63yHCif/zEl6DxJsdNh4LLqKVpfyVkD45prQekU2J9V0lAf
         ySPfAI1u8Hck26GgJTlkidPb6EM1s8BN4AMq7OltABdQWWbNIEOaQ0hHV7mDIIwtb4On
         xifg==
X-Gm-Message-State: APjAAAV5Qe32a0N5luodXQ4uKHhE97cWapTxMMLNs1nwycwDHXkyYzmV
        qb9/ZBL2D9EdGr8IhfdDcxSO1+3L+UGZhsocT1g=
X-Google-Smtp-Source: APXvYqxjUOOXIyjB94z81mXTxzdQ/Gu9iuUFfmmBundtg+1ZM/OZfi0yiWDWx/WrL/LS9Iq3V4TLwYoSes0mbvOPagA=
X-Received: by 2002:a05:6602:186:: with SMTP id m6mr12989700ioo.162.1566651483975;
 Sat, 24 Aug 2019 05:58:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190818201727.31505-1-dev+git@drbeat.li> <xmqqk1b8x0ac.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqk1b8x0ac.fsf@gitster-ct.c.googlers.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sat, 24 Aug 2019 05:57:52 -0700
Message-ID: <CAPUEspg9F7RutCUCoRAAXmRePjiunq3-zG7cN3uz_t5DVMxP=g@mail.gmail.com>
Subject: Re: [PATCH] grep: under --debug, show whether PCRE JIT is enabled
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Beat Bolli <dev+git@drbeat.li>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 19, 2019 at 3:23 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> There may be others I am missing.

should we still support PCRE1? I think in this case the problem is
compounded by the fact that unless we do something like [1], the real
fix for those UTF-8 validation issues will require a yet unreleased
version of PCRE2 and will never be available for PCRE1, making the
user experience suboptimal.

and explained in [1] there was a series to cleanup (both for
maintainability and to mitigate regressions) the PCRE1 code that is
yet to be formally reviewed in [2]

there is also the question of if we should provide knobs so users can
"tune" their pcre library to workaround some of the quirks or if we
should do more work ourselves to handle those quirks and improve the
error reporting.

one example of that is as you pointed out JIT, but also applies to
other things like PCRE's stack size, or depending on our solution for
PCRE1, accepting the risk (which already exist anyway) to accept
problems with matching because of corrupted UTF-8 in the haystack

> Is ab/pcre-jit-fixes a good base to collectively work on to finish
> the topics floated around PCRE during the last cycle?

V3 of that (which was never sent) might be better IMHO, I had to also
admit I was surprised to see the whole no-kwset series this depended
on being dropped but would seem it was just partially merged with
pcre-jit-fixes (which is missing the patches that address the UTF-8
issues with PCRE2's unreleased flag and that should be part of that
V3)

it might be worth also rebasing pcre2-chartables-leakfix on top of
this to avoid conflicts, eventhough I had to admit that I was
expanding on integrating [3], to avoid having to squash a fix into
Ren=C3=A9's patch (as he suggested) and that would be part of a reroll from
that series.

Carlo

[1] https://public-inbox.org/git/CAPUEspgStVxL=3D0SoAg82vxRMRGLSEKdHrT-xq6n=
CW1sNq7nLsw@mail.gmail.com/
[2] https://public-inbox.org/git/20190726202642.7986-1-carenas@gmail.com/
[3] https://public-inbox.org/git/20190721194052.15440-1-carenas@gmail.com/
