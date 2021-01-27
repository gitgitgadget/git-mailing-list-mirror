Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0A6C433E6
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 14:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E70321D7A
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 14:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbhA0OM0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 09:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbhA0OK4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 09:10:56 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA23C061574
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 06:10:16 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id c20so1858683ilj.13
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 06:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6aY1q5Icoi5dpktvrozUtgeX0McrFoZ59md2xg2p0XU=;
        b=IWZHWcsOmf+wTnaWfUpxJljdR9Badalfhw0qMd6gH9Pns6wYHQqPMx2TJkTv/0XPnq
         BzVNVfaA4iGrnAaOG/xYdiyYxQWwiuKraO5UCGWVd3g1XW+jw6MKrw2WondbJYlaunif
         dzWKOHmcxcB9WQOIJFgUa60ExEgvViF5MGW2q8Amaj7W7Hn1TiQAjhiqENE3Rh4Rozca
         0KSljwZIziqTLwkhnqzusJ/fQ3X3XOmZ9liMkgg3AkOl9sOQrebOMI4Hvg8gvweQVP0m
         i1SICfE6Rh144ZD2bXz/AVBCtP1scINvY7qLt7krNq2qbpN92ZCpgcosKF1Z9Gf5aQ5g
         jRqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6aY1q5Icoi5dpktvrozUtgeX0McrFoZ59md2xg2p0XU=;
        b=XjqUi/SnQXiWYeFEXQbkvgdcZQocqrauuZvL71J3+Rg//UmmJ8q5UScQN6+VkrOC5X
         8HOoHdb8qDgWoTnVyg6sCu8TGh/DX+Q59GMfEfSHhnMH8EqpYL1e+ClZASy1CsfaCRMW
         uKrMA/81gwx4TYYrOCu8DZGJLzEORVBV3UwJt2+9ILHzmRwIXhyewHrWDEbnvigrohrn
         4S3/sQ2rOk5gdugBVNWxiYCoB9PJVj25cl8bmCQEdHkRaBlzgGni7Pm/p2FFyf2TTod5
         aiQ/kp1UzkaVnFQtNZNFtYK98VXbdAJQoo0NC9oTE+hGX4GHMSwxCzOqO+tdyIWV4y+g
         U61A==
X-Gm-Message-State: AOAM531VxEBw3t+P/YXi74199okHyauyh9Q+n0xXkNzIH0ehV0WJwAak
        7aqMfTvjILknc5olgewcmVxL4rhtg6B0eVCowEE=
X-Google-Smtp-Source: ABdhPJxFsm8Im22cPWi+qjsR7IZs9QCtnXiPnv5iSVeKNQ9EGGIWnqIra6aJbHdkH70UfHHIN9Pib2Dj7pDXdqduXt0=
X-Received: by 2002:a92:d987:: with SMTP id r7mr8562485iln.3.1611756615858;
 Wed, 27 Jan 2021 06:10:15 -0800 (PST)
MIME-Version: 1.0
References: <20210123154056.48234-1-mirucam@gmail.com> <20210123154056.48234-2-mirucam@gmail.com>
 <gohp6kv9bml9qc.fsf@gmail.com> <CAN7CjDANLB85GHVVn32w_Y70bzvadtqdq2uRyc81j7nz+W05jA@mail.gmail.com>
 <xmqqczxr35xs.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqczxr35xs.fsf@gitster.c.googlers.com>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Wed, 27 Jan 2021 15:10:04 +0100
Message-ID: <CAN7CjDCbbKLKVjCP5kWzAJXFBJs5G_MRST0rdTgvH0yTusRqeg@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] bisect--helper: reimplement `bisect_log` shell
 function in C
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Rafael Silva <rafaeloliveira.cs@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

El mar, 26 ene 2021 a las 19:32, Junio C Hamano (<gitster@pobox.com>) escri=
bi=C3=B3:
>
> "Miriam R." <mirucam@gmail.com> writes:
>
> >> Although I compiled and did small test on the above code snippet, don'=
t
> >> trust it blindly and perform your own test and judge whether this is t=
he
> >> best way to implement this shortcoming.
> > Ok, thank you.
> > I am not the original author of this subcommand reimplementation
> > and I don't know if there is a reason for the difference with the
> > error message. Maybe we can wait for some other reviewers opinion.
>
> Sorry I missed this thread.
>
> My understanding is that this topic is an attempt to "reimplement"
> what is there in the scripted version, so any deviation of behaviour
> obserbable from outside, which is *not* justified, should by
> definition be treated as a bug.
>
> If the original author did not explain why the behaviour difference
> exists and defend why the new behaviour in the reimplementation is
> better, and if you do not think of a good reason why the behaviour
> should be different and the new behaviour is better, then let's
> treat it in a bug and fix it.
>
Ok, I will send another patch series adding this.
Thank you.
Miriam.
> Thanks.
