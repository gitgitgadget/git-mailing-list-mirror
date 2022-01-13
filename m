Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F89C433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 10:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbiAMKUo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 05:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbiAMKUo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 05:20:44 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7417C06173F
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 02:20:43 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id t24so21189495edi.8
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 02:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=HcZ5VewnTWm2vq3tEm5cXsbgde/4KWfr21KmpLPfEqo=;
        b=fI6ckKmwVfJ5UBxs+niPMxX493R04tUR0X5iYoO/R4g6ZlXIdBibzbm9RacFJKaGXi
         CPF1gUgB/yf3h5tDWD44HGNhcR+tKoeL3qcmQrWuOztD6F96g7KdVtvTVZPAb3mPCMDG
         thwic0Af64UpBL5y+17edIh6hbFv7L0fUQn1PLzK1G9msU4zKRzpyu//hrU3aH7VrlQ8
         Q7SHPG/cLmqCa/dph0hVyFIR2wt+s4Tus1wbmWHX7s7Mv5kbmPGVRaeKJJrh7DTilRHm
         w2EUvrG3B6mPEpCpeRk0DsG3a0gKL8D8hqoQ4/itHAgdJVRiVl4J+ZTsZYwl+7nA4lU2
         tQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=HcZ5VewnTWm2vq3tEm5cXsbgde/4KWfr21KmpLPfEqo=;
        b=BA/t+ckA4WBB0WU5w4I2g1Adk1Bu9TVRb7iyKeAFrJpAGHWGib3YABDh4SU6aHjmIN
         KJtQgOTkrUrfwZlVYFoS/m7yszLXhZzIbgCoLT+qv4UXNOq2+CgQPwV8kEyVj170o31I
         XM3GfIRhwHDkZlYoX8jfM0CH3WUg0An/ja9v4+bjTrQTh46ar6ygu+n7eBh2A3H7ILSN
         8t35auj84lXiru2qsU4XwpWhZRPJ4okhzMS8NcPoNJJ4ZbtOznrpzGqigWij3U2Rd7L8
         wRAhfZe5lFI8L/fCo0fdf2bGeK8i26pYvrq812RN1c4M3jAlAi+NNkFIAyPBxOameKA+
         il4A==
X-Gm-Message-State: AOAM533n+p7oXRB45iQBi0Jzz+hzpq99LxHHaevXQhW4a2SKHhcIGw1B
        ypJdsG4SMjXAqWAyLrLacic=
X-Google-Smtp-Source: ABdhPJxMlJMmLKgkmlyq7eUUFaOk34Bz16VaI7eFHF8MIjubsUd9yAGSCfAvoVEg9T0JKNVVvG6GWg==
X-Received: by 2002:a17:907:763a:: with SMTP id jy26mr2996428ejc.296.1642069242197;
        Thu, 13 Jan 2022 02:20:42 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ec25sm947254edb.51.2022.01.13.02.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 02:20:41 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n7xDl-000rK0-98;
        Thu, 13 Jan 2022 11:20:41 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 1/3] test-tool genzeros: initialize "zeros" to avoid
 SunCC warning
Date:   Thu, 13 Jan 2022 11:08:44 +0100
References: <cover-0.3-00000000000-20220111T163908Z-avarab@gmail.com>
 <patch-1.3-4dadf7320ab-20220111T163908Z-avarab@gmail.com>
 <nycvar.QRO.7.76.6.2201121518360.2121@tvgsbejvaqbjf.bet>
 <Yd8njHz2m099iDfL@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <Yd8njHz2m099iDfL@nand.local>
Message-ID: <220113.8635lsvsw6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 12 2022, Taylor Blau wrote:

> On Wed, Jan 12, 2022 at 03:21:46PM +0100, Johannes Schindelin wrote:
>> > diff --git a/t/helper/test-genzeros.c b/t/helper/test-genzeros.c
>> > index 8ca988d6216..5dc89eda0cb 100644
>> > --- a/t/helper/test-genzeros.c
>> > +++ b/t/helper/test-genzeros.c
>> > @@ -3,8 +3,7 @@
>> >
>> >  int cmd__genzeros(int argc, const char **argv)
>> >  {
>> > -	/* static, so that it is NUL-initialized */
>> > -	static const char zeros[256 * 1024];
>> > +	const char zeros[256 * 1024] = { 0 };
>>
>> This diff does two things: add an initializer, and turn the variable into
>> a `static`. The former is the actual fix that is required. The latter is
>> not. During the -rc phase, we do not want to see any of the latter. It is
>> unnecessarily controversial and distracting, and can easily be postponed
>> until January 25th, 2022.
>
> This assumes that making the declaration non-static isn't necessary to
> fix the warning from SunCC.

Just adding "= { 0 }" and retaining the "static" would FWIW make SunCC
happy here.

> I would guess that in reality it probably isn't, so removing the static
> designation is a stray change, and this would have been easier to grok
> as simply:
>
>     -	static const char zeros[256 * 1024];
>     +	static const char zeros[256 * 1024] = { 0 };
>
> But to be honest I don't think it is _that_ big of a deal to make such a
> small change during this point of the development cycle.

We'd also need to change the comment, so:

-	/* static, so that it is NUL-initialized */
-	static const char zeros[256 * 1024];
+	/* static, for no particular reason */
+	static const char zeros[256 * 1024] = { 0 };

Which is why I stripped the "static" off it, it was only there as a
shorthand for doing the initialization, so once we're doing it ourselves
it makes no sense to retain it for this invoked-only-once test helper.

So I think this patch is good as-is. just adding the initializer would
need even further explanation in the comment/commit message about the
non-sensical end-state. I'm all for being careful in the rc period, but
in this case I think we'd be overdoing it.
