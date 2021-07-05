Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA74C07E98
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 07:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01E926135C
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 07:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhGEHcA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 03:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbhGEHb7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 03:31:59 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D279C061574
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 00:29:22 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id hc16so27711032ejc.12
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 00:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=YylV7ZRFa/mwVadYt/XLwmRp0Hd1C8NKPlrEDhHUfgU=;
        b=RUmrGAWb91bN30t1ZZntNP90Z9csUQ1FRA3wMgwzjI7o854NriuAsQhLko9ZpjCypf
         D9xkrElA1yaluEWeWglFmHMfkOcPO+o86B5mntfofKrJEzym77hPwr8zNq15+V/HnONw
         XsYfNhh3VwuOFuw2DH33S23uySZ54hn7WugkYv83LoaNFsTHU724Sn3s6u/lfaiSxe4Y
         E3FQmojgbps4IqfyBZ9eUgaWwlRK02hmmDtftOrH/9+UGWR0ym59tvgKX545QJTf4SZ/
         SAAlEeUXbs6fzf8k0xBfF3NLZly0Ol76av86vRhs4iY0hAY4v7+a1268RKJ4I1ExCINu
         3fTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=YylV7ZRFa/mwVadYt/XLwmRp0Hd1C8NKPlrEDhHUfgU=;
        b=XNKuYI+ziKXrxP+SkFOQ0MJCG32J+kCbh2Tf4u4E3e5+bJxxkzt42hMZydRh96IOta
         8edJAEafHuKIxA4BGtvq7AYvvAEZzGWJi3KtXgS0WP1ncSWIyHht5drYkWsTe2005MF+
         NwCtBplYEE3bYpOXtnqMOp3MIPX2bQ79MqSddBLIqbizCl7iyoQvZ2yQpBFgZRB/emZq
         HgiUaXdQ7fj/Ad7FvV+Y2YPZ7k3n4RxEZxtW70uppt6G3xUjLtlVxd56JCHtzltv5Vlv
         BF5hN974If5jqdHrdJp1F8KwkAzSBh/nEuG4Cv9WoKKKxEa4GgedLUqF4bcZDR4ABIch
         qEvg==
X-Gm-Message-State: AOAM532dIagPUaV1ex6y7D6iEcK05N13uTLdrIF31c8l5G2ZzoWhzlU4
        imguTfjk6bigKOB/8lpzW88=
X-Google-Smtp-Source: ABdhPJxlKtPSUzrHI6U+2Zsf9l4Iyqm1/QlIvcyrkR/u4DbVMEOoKgH0fQ60fQM1de/Hz0n+hvt6yQ==
X-Received: by 2002:a17:907:e8c:: with SMTP id ho12mr11883543ejc.372.1625470160870;
        Mon, 05 Jul 2021 00:29:20 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id s10sm2978536ejc.39.2021.07.05.00.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 00:29:20 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: Antw: [EXT] Re: bug in "git fsck"?
Date:   Mon, 05 Jul 2021 09:26:49 +0200
References: <60DF1C22020000A100042225@gwsmtp.uni-regensburg.de>
 <xmqqczs0popg.fsf@gitster.g>
 <60E2B04B020000A100042291@gwsmtp.uni-regensburg.de>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <60E2B04B020000A100042291@gwsmtp.uni-regensburg.de>
Message-ID: <87fswt6wxb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 05 2021, Ulrich Windl wrote:

>>>> Junio C Hamano <gitster@pobox.com> schrieb am 02.07.2021 um 20:15 in
> Nachricht
> <xmqqczs0popg.fsf@gitster.g>:
>> "Ulrich Windl" <Ulrich.Windl@rz.uni=E2=80=91regensburg.de> writes:
>>=20
>>> I was wondering whether git fsck should be able to cleanup
>>> orphaned branches ("HEAD points to an unborn branch") as described
>>> in https://stackoverflow.com/q/68226081/6607497 It seems I can fix
>>> it be editing files in the repository, but I feed that's not the
>>> way it should be.
>>=20
>> HEAD pointing at an unborn branch is not even a corruption, isn't
>> it?
>>=20
>>    $ rm =E2=80=91rf trash && git init trash
>>=20
>> would point HEAD at an unborn one, ready to be used.
>
>
> OK, so maybe I was just confused by "fsck". At it seems after committing,=
 fsck
> no longer complains.
> As "EXTRACTED DIAGNOSTICS" In man git-fsck (Git 2.26.2) does not mention
> "unborn" (and as it's not a common IT phrase), one could probably explain=
 what
> it means.

FWIW you're completely right about the unstated point that fsck's error
messages/reporting is pretty bad. I've been trying to fix some of it up
recently (including one hopefully soon-to-land series).

It has a bunch of output that's overly verbose, and other complaints
where it's not clear if they're actionable or not (e.g. what you
mentioned), or whether it's even a problem.

If I create an ext4 filesystem and run fsck on it it's not going to
complain that there's no files yet, so it's a bit silly that fsck
complains about a freshly git-init'd repo.
