Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2E1C433F5
	for <git@archiver.kernel.org>; Mon,  3 Oct 2022 18:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiJCSFo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Oct 2022 14:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiJCSFM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2022 14:05:12 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88C322BE7
        for <git@vger.kernel.org>; Mon,  3 Oct 2022 11:05:09 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id c3so5986535pfb.12
        for <git@vger.kernel.org>; Mon, 03 Oct 2022 11:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8tkjxkDmA7cP9dn/kM+RcUzB3Hna5zZaOuiyKa1jTzs=;
        b=Fy8HFdGj8hworQAcgGnFSuBnfjlqL5rBOrHVGfu6/ZSGlgkX9eJYscu6cEis6b+03X
         pwNwJAZVN98MlRKSFhJgCAhZD/RadDYMAu/ri48teUwtNl6XdDxQXb5EX92lADMU586F
         g/aXWf8KK4nri88bWTnM5HAn1abrkVhoUJdjqtRnumlUH7OHEKZtkRB9cCkth5u645TH
         gAqsYtB2R7QnJob/B+vFW2EfCTDUUt0E1WYq00XhHfHjAgrj20Bg2d0861SEnHwOcicf
         WRqS1CJDxqbLWyPvuvlpIiBFEyd4AMj84WYLpg8hILiMJw5/pDMHfYUoZXBS1SYiX9zB
         7QTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8tkjxkDmA7cP9dn/kM+RcUzB3Hna5zZaOuiyKa1jTzs=;
        b=qdhdzbzZZB25y5eOq743rtbCdW/h2k3dEWWMkfGCJAHaerFFXiQSW7SZFBsgdNPSi3
         dHzmjUYHZUrGWfGDZvqfbCMcrZYcbgZNN9/YADrGl8a63n+P7wYtlG9trgJ7FzwImPA+
         52x+7+UFuXwAma/sBtfxJmFrLhiM8nlXx/Y9r+kNF4kP9n0uXoHQhKmgyT/X9loxtMKj
         hFM9LvBk+APkcDMWY0KK+0GqtvAvRd1Nc7sDePMqvDqFeOvbAz4UZeflwkM0K2ceUuWl
         OHqHzOivAP82mRQU3wZpASgZXpNOmxALK+6ycgR5qShj3EnleVz/R+hdVnIIM2Aop8qS
         QYzA==
X-Gm-Message-State: ACrzQf1hK7jbtPuulwF4/LyPmvX/ju4U3PhJITBkmRsPJa5sJlfpekFO
        ubu9yT2fdxxPbKU9IA7ins8=
X-Google-Smtp-Source: AMsMyM4vSJmUm+I053XPcTJ0kzkhHQgJ07639vf/uc8FxAgqvww1k/ku2Bmd8SDljlyYyZI1jqYREQ==
X-Received: by 2002:a65:6954:0:b0:445:fdb8:738e with SMTP id w20-20020a656954000000b00445fdb8738emr10671840pgq.520.1664820308577;
        Mon, 03 Oct 2022 11:05:08 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id ik21-20020a170902ab1500b00176be23bbb3sm7436632plb.172.2022.10.03.11.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 11:05:07 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "Michael V. Scovetta" <michael.scovetta@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: Re: [PATCH] sequencer: detect author name errors in
 read_author_script()
References: <CADG3Mza_QU+ceTUsMYxJ3PzsEqi8M98oOBAzzz0GHRJ-F7vkpA@mail.gmail.com>
        <YzqhEcTDwMwa8dQX@coredump.intra.peff.net>
        <221003.86k05htf84.gmgdl@evledraar.gmail.com>
        <YzsbiRcCEaJUGwdp@coredump.intra.peff.net>
        <YzseUy8bRT0LN2Wp@coredump.intra.peff.net>
Date:   Mon, 03 Oct 2022 11:05:05 -0700
In-Reply-To: <YzseUy8bRT0LN2Wp@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 3 Oct 2022 13:39:31 -0400")
Message-ID: <xmqq7d1gu6jy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Oct 03, 2022 at 01:27:37PM -0400, Jeff King wrote:
>
>> -check_broken_author 'unknown key in author-script' '
>> +test_expect_success 'unknown key in author-script' '
>> +	create_conflict &&
>> +
>>  	echo "GIT_AUTHOR_BOGUS=${SQ}whatever${SQ}" \
>> -		>>.git/rebase-merge/author-script'
>> +		>>.git/rebase-merge/author-script &&
>>  
>> +	check_resolve_fails
>> +'
>>  
>>  test_done
>> 
>> That makes the boilerplate shorter in the "-v" output but focuses on the
>> actual modification that breaks the author-script.
>
> Note that we do still keep the ${SQ} bits here. They're necessary for
> the same reason: before and after a snippet is being passed through a
> variable. Whereas in yours we'd use stdin. I _do_ like that approach in
> general, but it is unlike the rest of the test suite. Maybe it's worth
> resurrecting:
>
>   https://lore.kernel.org/git/YHDUg6ZR5vu93kGm@coredump.intra.peff.net/
>
> ?

Yeah, it is indeed quite tempting.
