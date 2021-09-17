Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50643C433EF
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 19:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 332FC60F3A
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 19:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242755AbhIQTXm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 15:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbhIQTXm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 15:23:42 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796EDC061574
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 12:22:19 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id h17so33836428edj.6
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 12:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=pVSXSsE4fk9m1Ur6wvFBnpy74RNWJycIOKwohtxU9xk=;
        b=oxo0rkpWWJmuxlOtxchu1nl+5KUqEml+PqUu2UobpD4KEnXeXcaT3I76YBY1tibzzD
         kJHTT+sqsuwF6Amy5Ppfh/HY8W6p6XPGBuKForCa3WCXh3ysd5DkWZbsqC3lDNjhosSr
         CVdfPrFmrRSs51lMGKldnYNLu+RwK7yI0ycfrRrQXGre6OL1oz9yd9lZFb6TswyDV+iu
         MbNovq74+XsL2X4CpqfWPID6O3t2qqUCY0MYMp8eH9x88v9gA1zdcO/8QUP4aVpCr5ty
         rHUn5HE2diCBbe8OMUnoNpq53OvlPqBGWt/+EO+yWSy9Y6AcJ4vp4pYg/jko+6o9sUga
         guGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=pVSXSsE4fk9m1Ur6wvFBnpy74RNWJycIOKwohtxU9xk=;
        b=u82QoMnhP5XuVhR7M/OLW8K9I2q7j54tXXSfyGYEz2/dcmOZ4fS8yMfrokJDs7zoYz
         7CDdux+zAK8q3mmkCrpfZbTLZllu17zcD9sKwKNQko95SSWMKxb71BAATvoVwm9NEgsG
         3QaECI+j3KGEW2LBwijlJacoFrO/luV2sdENSthds0k72ClWyuXNVD7908MjIgsI3Hxc
         UC/V3HQyW+rdJzvdsYeNmFT1a71mjLKiDT+58ttu6u+StcHr7AuzAe50tiigwW9KbtTu
         /I27jH6fV/mbrQygEsNLEe+Ni5rkKq8oGoIqjC5MUSPWzx7iQTqNV1egD/sGPiY8h2bU
         xwpw==
X-Gm-Message-State: AOAM530s346ObDlcr2LKAjeRlAMNPDdDkzR2s3QM/u5lDDzmrhtfIdj9
        xXofoDQg3FatMTqBwz5v5E8=
X-Google-Smtp-Source: ABdhPJzHye+SuADf+TLtlNDIgPDb3puG1ipKtSzX0RgqaLzPu0y8uHGB3PgSJRg0SVrVJjnsRRhvPw==
X-Received: by 2002:a17:906:24c1:: with SMTP id f1mr14135512ejb.314.1631906537984;
        Fri, 17 Sep 2021 12:22:17 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id s3sm2742060ejm.49.2021.09.17.12.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 12:22:17 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/5] wrapper.c: add x{un,}setenv(), and use xsetenv()
 in environment.c
Date:   Fri, 17 Sep 2021 21:18:50 +0200
References: <cover-v2-0.5-00000000000-20210916T182918Z-avarab@gmail.com>
 <patch-v2-1.5-49706b26642-20210916T182918Z-avarab@gmail.com>
 <xmqq35q3i1hi.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqq35q3i1hi.fsf@gitster.g>
Message-ID: <87czp7dn2u.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 17 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> -	if (setenv(GIT_DIR_ENVIRONMENT, path, 1))
>> -		die(_("could not set GIT_DIR to '%s'"), path);
>> +	xsetenv(GIT_DIR_ENVIRONMENT, path, 1);
>> ...
>> +int xsetenv(const char *name, const char *value, int overwrite)
>> +{
>> +	if (!name)
>> +		die("xsetenv() got a NULL name, setenv() would return EINVAL");
>> +	if (setenv(name, value, overwrite))
>> +		die_errno("setenv(%s, '%s', %d) failed", name, value, overwrite);
>> +	return 0;
>> +}
>> +
>> +int xunsetenv(const char *name)
>> +{
>> +	if (!name)
>> +		die("xunsetenv() got a NULL name, xunsetenv() would return EINVAL");
>> +	if (!unsetenv(name))
>> +		die_errno("unsetenv(%s) failed", name);
>> +	return 0;
>> +}
>
> None of the existing callers have the "NULL name gets shown a
> special error".  If we would get EINVAL and die anyway, there is any
> need to add such an extra check that is always performed, no?
>
> As there seems no justification for it in the proposed log message,
> I'd have to say this is another "I'd do so while we are at it even
> though it has no reason to be there to support this topic" change.
>
> With explanation, perhaps these addtions would make sense.  If you
> wanted to protect the printf-like die_errno() from name=3D=3DNULL, the
> cost of the check should be borne by the error codepath.
>
> IOW,
>
>     if (!unsetenv(name))
> 	die_errno(_("unsetenv(%s) failed"), name ? name : "<NULL given>");
>
> or something along that line, perhaps?  That won't need extra
> justification, as we are not adding a mysterious feature that gives
> a NULL name any special error status.

Sure, I didn't think much about it when writing it.

I'd think skipping the translation would be fine here, but sure, will
include it. On second thought just a:

    die_errno(_("unsetenv(%s) failed"), name);

Should be fine. I.e. this is an internal-only function, we're
exceedingly unlikely to end up with a xsetenv(NULL, ...).

Even if we did I'd think the undefined behavior is OK here. In practice
modern C libraries are forgiving about it (e.g. glibc formatting it as
"(null)"), and if not we were about to die anyway...

But unless you explicitly Ack that undefined behavior bit I'll use your
version in a re-roll. Thanks.
