Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A1AC32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 16:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjARQWy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 11:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjARQW2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 11:22:28 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04FF41B70
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 08:20:21 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id i65so23120987pfc.0
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 08:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DirxOXHKb9dBP/3sJU4YPgb7D6O2XPVEinXGBAenoCw=;
        b=e5jSOg2BBGtK17ukHwKM9EugyGaPHyvI0G3f+dVOjeUj5j/GxpNEkDWsxzsFAnRKp2
         AzwJB3x3VRSuxuwRbNcvDRJG/xVoIUQq8js3dUkyzovUIabC+FsgDk+uIQ9hzhY7Zsbw
         rOaZ2ombFS4c1BTxzgu5fuwJIFSssKSFozv6rhXyZHHzE0IeWGEQ7i39vLtdv9DFmXDw
         Gm3TNz+s4FhWr+DNGEr8kyair/BBQnZQCIe2k4CAhnvWO3F+7NG9Yxf0V5nDp2LtJjxf
         Lfi8veo3cF1A8wI5pAJmj8Ds7yhBFtWAwGvztbCkZ/nVKnDFR1G8w2EaEt4Qx+Npl3ab
         uh3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DirxOXHKb9dBP/3sJU4YPgb7D6O2XPVEinXGBAenoCw=;
        b=duRzxXW4YsVtEFerT23FtpKH3DvEXBq3iVq7FURSAsEh2/giCkYVHmlto7Z9BzQ7ne
         zm8N6dMtUjHS7ycAeaHmPzkP8I/WJ9jF2peSfwD6M5AeSsR/1oYwp8c2LfOsFocLeI45
         kqZbU3nPffU7K0bAWefbQNeCNrFMeD0Py/FLSZOc6764N64SlIs7COSu2MKUAPbZNJyS
         8zX/jAjEOguJXFLYy5EB56Zoru0xoz6f/WoHYxFSFi/uIlxHxxwoaYn2+LIjpadpfeho
         QdiXg/45/AeH0N/VnNwwbmeGjNhXsXy8O+urlqgLW81Suk7+zZSwKHZSUxij7aoER8I5
         /OQA==
X-Gm-Message-State: AFqh2koF1JibwDiXviNwe+AbQbzNHvOxpbuLRsZp8t6zHHQPU29+SlRf
        KsrphIU/+SwXcZVJ27A+8GO7KgSEDD0=
X-Google-Smtp-Source: AMrXdXvBsCD2yyYUGHJS+fA/GDeOB8/nxNpQKqzvF4Fbhqa7VJoPWd3+5ix9CGWlhiRst+of6GwlVg==
X-Received: by 2002:aa7:9116:0:b0:577:272f:fdb with SMTP id 22-20020aa79116000000b00577272f0fdbmr7472677pfh.29.1674058821298;
        Wed, 18 Jan 2023 08:20:21 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 5-20020a621505000000b005772d55df03sm22204021pfv.35.2023.01.18.08.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 08:20:20 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org,
        Diomidis Spinellis <dds@aueb.gr>
Subject: Re: [PATCH v3] grep: correctly identify utf-8 characters with
 \{b,w} in -P
References: <20230108155217.2817-1-carenas@gmail.com>
        <20230117105123.58328-1-carenas@gmail.com>
        <230117.865yd5z4ke.gmgdl@evledraar.gmail.com>
        <xmqqr0vt9oj9.fsf@gitster.g>
        <CAPUEspgzrW63GgbjXhKuvjpKXjEhiKaC7jtupiB-3AhcKTba8A@mail.gmail.com>
        <230118.86tu0ovyvj.gmgdl@evledraar.gmail.com>
Date:   Wed, 18 Jan 2023 08:20:20 -0800
In-Reply-To: <230118.86tu0ovyvj.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 18 Jan 2023 12:49:36 +0100")
Message-ID: <xmqq7cxj6chn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> GNU grep -P has no knob and would likely never have one.
>
> I think the general knob in not just GNU grep but GNU utils and the
> wider *nix landscape is "tweak your LC_ALL and/or other locale
> varibales".
>
> Which works for it, and will work for us once we're using PCRE2_UCP too.
>
>> So for now, I think we should acknowledge the bug, provide an option
>> for people that might need the fix, and fix all other problems we
>> have, which will include changes in PCRE2 as well to better fit our
>> use case.
>
> Hrm, what are those PCRE2 changes? The one I saw so far (or was it a
> proposal) was to just make its "grep" utility use the PCRE2_UCP like GNU
> grep is now doing in its unreleased version in its git repo...

Yeah, I didn't understand Carlo's comment in that paragraph at all.

In short, it sounds to me that the earlier one that added PCRE2_UCP
unconditionally would be the best alternative among those that have
been discussed.


