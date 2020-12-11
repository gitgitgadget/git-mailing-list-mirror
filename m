Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C797CC433FE
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 00:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DD7223C18
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 00:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387829AbgLKAEL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 19:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731914AbgLKAEF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 19:04:05 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EDFC0613D6
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 16:03:25 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id 91so7255600wrj.7
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 16:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VkfJSM/QuAbd2+0xZPubus3XABN5t8AQeo7eZRIG748=;
        b=B7QAoUFcjhpLgd9n7pTnnamuYgXSB0dbOEs2+p2lzzlwlxQGDuEdvkKzdGWpxRaZn/
         WZd9sGYno2sQhfCEtu1LxU1sfrQ6LHi7v6Lh+fzolNsptLhkm2cIv5ze5qErKXPC863P
         tLNo7R2a637N3kEijxkjeSk+hsiIiStGXWv9h853g7Rp70Y+4Dp6PvBtuPbVfBs5z5ar
         0EI0eOCUDdkMlCVpInuKwh7d0j1D8b50r7AWj5c17YvGbfN/tZuPYeENPA+XOKscnmDR
         xSmqzG2XiVq+2gxZJ0GhQoJKNsDADQwhHP91nXQ1KRe5hz+7IZcxsCfKqSwI4/erE3u/
         bkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VkfJSM/QuAbd2+0xZPubus3XABN5t8AQeo7eZRIG748=;
        b=ZSymqW2siWauT1DD949HVd3VFZbvo6NHOmUtQhezC7Yv4r+S7Y8qRQsWECxohF3Ea+
         YNqaEsdbphFKHS+ZmCo+wE7iNDEBS+u80cowSWc2T1OzJZAVQp0yOk1nToze/kHilzEN
         MdXt1AU7rMjnG9u+i4YMyYJRrX3sGpcLXOCTrOUf/JNYaIBiv8GLNdgIuoQqo0Q6vZcb
         jiPzc3TI+sXYJcj1if+x7Uy/N8b6KOfdvEu3Iow+VTEEpDV3rJNMcmr3V4HnE0toqxcm
         ydpILTBpujNpv+Y44sTraTsb5EyY3Kj8VvaAoimbfv8WulgWnaZSjwTeqVjki6iwLOVf
         BtPA==
X-Gm-Message-State: AOAM5306fqeFMPUa5srjzxygWggRR/2YR2sZfyRbTbLq84w8V3ctwzy3
        FEObw/HqSVN25FkZhfKn0Goig3zEA2Dl8+fr0e8=
X-Google-Smtp-Source: ABdhPJzAHwEK0LdV6wjh0pEbA+qWUyzseC096+WW/oRXqZOkSWISHr0uHNB/heuy52nYK76tHjfD76JM5KvBVKEu1Lk=
X-Received: by 2002:adf:ce90:: with SMTP id r16mr11095035wrn.100.1607645003618;
 Thu, 10 Dec 2020 16:03:23 -0800 (PST)
MIME-Version: 1.0
References: <xmqqpn3j4ved.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2012091510280.25979@tvgsbejvaqbjf.bet>
 <xmqqft4e1w2j.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2012100540220.25979@tvgsbejvaqbjf.bet>
 <xmqqeejxwlx9.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqeejxwlx9.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Thu, 10 Dec 2020 18:03:12 -0600
Message-ID: <CAMP44s3Wp5HfmHB2UZFJyZSVv7xE9YAKVOWfDUCGOwHtQV6Gzw@mail.gmail.com>
Subject: Re: js/init-defaultbranch-advice, was Re: What's cooking in git.git
 (Dec 2020, #01; Tue, 8)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 10, 2020 at 12:38 PM Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> > Obviously, I have no idea how many users chose the first option because we
> > do not collect any usage data in the Git for Windows project. However,
> > anecdotal data suggests that most users go with the first one, not caring
> > one iota and simply going with what Git decides for them.

1. The first option says let git use "master". The user might have
stopped reading there.
2. Even if you had collected numbers, anyone with a minimal
understanding of statistics would tell you that you can't extrapolate
numbers from a subgroup of the population to the total population. You
need a random (non-biased) sample.
3. Anecdotal evidence is the weakest form of evidence.

So yeah, even if we suppose that most users (what is "most"? 51%?,
75%?, 90%?) of Git for Windows did choose the first option, we can't
assume the rest of the users are going to choose that option, and for
the same reason.

Something that very often happens in these types of questions is that
the user simply did not understand the question, and just chose the
first one.

Cheers.

-- 
Felipe Contreras
