Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9382BC433FE
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 07:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiKUH2W (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 02:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiKUH14 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 02:27:56 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C71025EE
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 23:27:51 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id jn7so7967474plb.13
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 23:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qruUN3s6s2ISmU/B+WrEauo6zVOIciyXk7QTArILnb8=;
        b=fG6PuTNiC3VK1YNCpie6B1hAs32Pc65MmnU8EW3BmzJBkd/CDnqNTKPvVH4nsI06hG
         52lsC12hAsCyFq2qhB1JSmtxG/mANvmOrlff0FI99Cwwi3iAETGSGxyN1MVtfJgz3ivi
         uxvFYnpEhBrGd82EvCb6T2++GHUFuW/aAOsvg4EJIiF89XUVLhYUwTpte0tkWZwqpsMd
         T4SqsIvnX3zSx7d54sJeg4OHMpOfRlOSSdz+Qo4DmjliVz3z2gkETd7kK2AS6Kqxt1yj
         UVamSeU9vQ10e+66vKdraJGUv8PJ7ZRr9pvKrn4DmpeirgjjY1BSwymtyghTSpFVbj9R
         V/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qruUN3s6s2ISmU/B+WrEauo6zVOIciyXk7QTArILnb8=;
        b=7PVf98/A5qXJNGE3tFpATTn7fz6EAZZ+MyZdH42PPihkgiVhPQV7Pv6JUO6RDAY5If
         XjxcRMEoBjCXkFVvqZd9pdsxZd+dfzMvCjeHi4zxe5jM5963V9nFTnjwrgBykPNr1b69
         CDiZMJXUVEZS5O/5N653f5r9hZ/O2Aju36EOA2+2qgZ1GDI1qL2nCohvPeiTtOLPFBFx
         KG9gX8RUm1IN/cseKPMmRWzFHm+FJxkw+QovU+Ueplimn7p0xvZPa92tc0+tfy3lfdDT
         zwTOM74qClVkIGP4ZXgLwmBO8MNeghIluxFikvJ0Ayx4hN60XhCmB6/VzRK/TZ1ewI0u
         368w==
X-Gm-Message-State: ANoB5pnnkwlAjeXNBc/O0S5HdY4rwR+7YZQ2NC5hWaeND9VFx+7Pt2v9
        FRtzPE64TDokItDU0wKKEjLis00Bq81bYQ==
X-Google-Smtp-Source: AA0mqf4513qm/2lOXeoXtPnSkBZ6vJFLZ+HX/j2CXhb5R0o8/QPd/9T1+LbUOrpCL42qIF/VPByqHw==
X-Received: by 2002:a17:902:bcc7:b0:188:f42e:6a90 with SMTP id o7-20020a170902bcc700b00188f42e6a90mr920336pls.127.1669015670745;
        Sun, 20 Nov 2022 23:27:50 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id o7-20020a1709026b0700b00186a2dd3ffdsm8923985plk.15.2022.11.20.23.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 23:27:49 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Siddharth Asthana <siddharthasthana31@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        johncai86@gmail.com, Johannes.Schindelin@gmx.de, avarab@gmail.com,
        me@ttaylorr.com
Subject: Re: [PATCH v5 1/2] cat-file: add mailmap support to -s option
References: <20220916205946.178925-1-siddharthasthana31@gmail.com>
        <20221120074852.121346-1-siddharthasthana31@gmail.com>
        <20221120074852.121346-2-siddharthasthana31@gmail.com>
Date:   Mon, 21 Nov 2022 16:27:48 +0900
In-Reply-To: <20221120074852.121346-2-siddharthasthana31@gmail.com> (Siddharth
        Asthana's message of "Sun, 20 Nov 2022 13:18:51 +0530")
Message-ID: <xmqqy1s4wyvf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Siddharth Asthana <siddharthasthana31@gmail.com> writes:

> +test_expect_success 'git cat-file -s returns correct size with --use-mailmap' '
> +	test_when_finished "rm .mailmap" &&
> +	cat >.mailmap <<-\EOF &&
> +	C O Mitter <committer@example.com> Orig <orig@example.com>
> +	EOF
> +	git cat-file commit HEAD | wc -c >expect &&
> +	git cat-file --use-mailmap commit HEAD | wc -c >>expect &&
> +	git cat-file -s HEAD >actual &&
> +	git cat-file --use-mailmap -s HEAD >>actual &&

Doesn't this break under macOS where wc output tends to be padded
with SP on the right?  We used to often see test breakage when a
carelessly written test like

	test "$(wc -l <outout)" = 2

which expects the output file to have exactly two files (the
solution in this sample case is to lose the double quotes around the
command substitution).

Besides, having "cat-file" on the upstream side of a pipe is a bad
practice.

