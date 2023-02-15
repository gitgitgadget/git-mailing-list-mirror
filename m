Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831A5C636D4
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 23:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjBOXmR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 18:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBOXmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 18:42:16 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7672E80D
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 15:42:14 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id r8so340586pls.2
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 15:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bhKpbumJV31K0J1vyAcoZU/Z5u0fwuqWJmx1OLiuslE=;
        b=RpHsMOHAy7Z56IEAq1dvDHed75d360lMfzVC+jaALeUyY6rgNzV/95RKZJCRK8NDON
         zUHtQr3iJL3xD14Mlq9p+JUFGsoXCzJmvghRHTM+JFxn1kuvi/xjU23UPdGAUK96wB0O
         2C+l3FVeNa8ZqmGof0cozXxZ67za5GFwO8tQvFlcNgQpQw9J8MVBJsY4ewGfSe5Jui9Z
         JWHxVyN2IzV7wKHpfI2Lmt4toh0u420KCTEEoq525o2MaUiWpxuw4KKekjXvOnaFX2mS
         gQSSTJxWz90lVSqVioqN/XxhhC0dfyR42w6ndHt2dJMi84ozBwtboYCv+QEP0CPW5Jc1
         z+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bhKpbumJV31K0J1vyAcoZU/Z5u0fwuqWJmx1OLiuslE=;
        b=aDnMVSrqkcfQQuJArLdILpyeAEYPce8sVEa4vJWkLW9oyTqN5JErF0FlCJfddBbJVh
         VQS9WyY8JMXsEXmWbXWqqFfZ8hrseMBEcVK6tVKJRQbQZcf1MrA1Lwim89x+D8HrYLAv
         OXcD6u5GZ4w/aTQJbxD9o0p7eLgOj9QrEkPrqxAwxyo0ILM5YMHC13apt+yEsWfxy1BQ
         M1w235+1uH/fhZYbXJt5G08ZXwUNJK7dzUlV+UoTtEoaDfCOOl12gBCLU98+YEHClL+O
         2OKjSFuLNVwgdhjIcsmRUhxSAANnpPi5Vxa17EQuUSvO7jeYDTXrPDluVVJBjef0/B96
         /iwA==
X-Gm-Message-State: AO0yUKVorajYjxTSB45vsY+WnBEn/LR3DyyUosQ8S6J/mnkMkE6Y7Vig
        /VZk+7QWNsiMqp89tg52lio=
X-Google-Smtp-Source: AK7set8G44J6P7UKp5ogoBxKR6vWXV+zPMGYMUYyqje4Id/0Cpui3stUyTkRCCEDaQkFzshvwu7AUg==
X-Received: by 2002:a17:902:ecc9:b0:19a:74c7:dcda with SMTP id a9-20020a170902ecc900b0019a74c7dcdamr332567plh.15.1676504533715;
        Wed, 15 Feb 2023 15:42:13 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id x22-20020a1709027c1600b0019907b82a24sm12707644pll.273.2023.02.15.15.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 15:42:13 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     John Cai <johncai86@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/2] diff: consolidate diff algorithm option parsing
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
        <pull.1452.v2.git.git.1676410819.gitgitgadget@gmail.com>
        <0c5e1fc6c2651e39bcefa27ee0976c9519671969.1676410819.git.gitgitgadget@gmail.com>
        <xmqqk00j3b6r.fsf@gitster.g>
        <AAC53EE0-91F5-4A74-AB26-5F3F8B680CDE@gmail.com>
Date:   Wed, 15 Feb 2023 15:42:12 -0800
In-Reply-To: <AAC53EE0-91F5-4A74-AB26-5F3F8B680CDE@gmail.com> (John Cai's
        message of "Wed, 15 Feb 2023 18:34:59 -0500")
Message-ID: <xmqqmt5ev6ln.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

John Cai <johncai86@gmail.com> writes:

> Yeah, it's not great to pull things out from a bit flip to a callback but I
> needed some way of setting the xdl_opts_command_line member in the next commit

If that is the case (and after reading [2/2], of course, readers of
the series can tell that it was the reason), it would be good to be
honest and document _that_ as the reason why you are using callbacks
for all of them in the proposed log message for [1/2].

And I think that is a reasonable way to use callback to do "more
than just setting a bit".  Even in that case, I am not sure if it is
a good idea to share the same callback that has conditional code
that only is relevant to the "patience" case, though.

THanks.
