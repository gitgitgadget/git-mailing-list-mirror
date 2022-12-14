Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16F0C4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 11:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238109AbiLNL3T (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 06:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiLNL3R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 06:29:17 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1B414096
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 03:29:14 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id gh17so43775279ejb.6
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 03:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NiEcw3scJGpobY0pQOYvaO6YV3jwiAo+/zmwXIx6VXc=;
        b=FMtX5I61e4Jjh0/EmJzLrCUkvH4v0txUxMjTh13iU4lC4MpjqcyfhCCrDIvTdJllOh
         cehDvcWNhJ1RWN5ICA8wipDl3ZrblF4ka+ygRv3SoAWvV9aPqWDNUsjj+6rzLl31wfaL
         OIkIwWQsm3sTwja/Ctdw0LA/gmbGyQ9dboz3/FP38SMvVRfr/OJxd3PKOa3Ex5tTJZ5w
         N6JSKhC0+LHkugAbgfxvMrSmlSmAkMWvWME1W+GOFJdw8pBrkOMyFMwQtZeCeSF730Iy
         eWG8IuMI/cT2zEjW90g/AS6aUAbOJRiqrBp0rejLXigXI/o+Ewls90CJBoyn5Exm9Ct7
         3Nvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NiEcw3scJGpobY0pQOYvaO6YV3jwiAo+/zmwXIx6VXc=;
        b=bq1yA51r+sB1dh4PJbLQUPFBX5h4dWk6LV+jM8X4nEPXgF8fUC3GGvhDxSN3P1aAEr
         lHgP79Wqy4Ljr6p2AntI0xwe9Rrt4DC9jwMqp/H1xNOUESk+M9wHMfsHIG4eNaK7rOVs
         sKDQBrLPM5Zd9BgESm10GM2C1Atem+zDqntQ3T8Lhzwtws0Gb9wZjWHChLAQ2VDIMvBJ
         jKcthe8p5DUNYmSOu89F2sYogBP261O2N7KYsO8YPplxGxS/oHQWAy09eBprzwmsW3NT
         /R+sxZ5Gq1dB0owwlswcdGoA08gpPcyT+H2tcOLsyL3Be3yThB/cSIixQcgzf1bJWJtu
         Z67A==
X-Gm-Message-State: ANoB5pmz1U0UcvaNNgRYnVINyM5DBPhomxKXW8/4S3/Qis5pcyfcKZJD
        hYaYL/T9b1Wv4WkOMCuSTdf7Fpt8LCQ=
X-Google-Smtp-Source: AA0mqf56NzeVuhH7LTw/yaxpjizhI6Qm/MJuuUc4f7AAJPNUghZjs8JYOQBCAn08K8CCtryczUybnQ==
X-Received: by 2002:a17:906:846c:b0:7c1:124d:2ac3 with SMTP id hx12-20020a170906846c00b007c1124d2ac3mr21920167ejc.40.1671017352718;
        Wed, 14 Dec 2022 03:29:12 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id hw20-20020a170907a0d400b00779a605c777sm5714594ejc.192.2022.12.14.03.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 03:29:12 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p5Pwl-005a6q-26;
        Wed, 14 Dec 2022 12:29:11 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Siddharth Asthana <siddharthasthana31@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
        johncai86@gmail.com, Johannes.Schindelin@gmx.de, me@ttaylorr.com
Subject: Re: [PATCH v6 2/2] cat-file: add mailmap support to --batch-check
 option
Date:   Wed, 14 Dec 2022 12:27:20 +0100
References: <20220916205946.178925-1-siddharthasthana31@gmail.com>
 <20221201155504.320461-1-siddharthasthana31@gmail.com>
 <20221201155504.320461-3-siddharthasthana31@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221201155504.320461-3-siddharthasthana31@gmail.com>
Message-ID: <221214.86a63q441k.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 01 2022, Siddharth Asthana wrote:

> 2. Make one call to `oid_object_info_extended()` to get the type of the
>    object. Then, if the object type is either of commit or tag, make a
>    call to `read_object_file()` to read the contents of the object.
> [...]
> +			buf = read_object_file(&data->oid, &data->type, &data->size);

Could you please change this to:

	buf = repo_read_object_file(the_repository, &data->oid, &data->type,
				    &data->size);

I.e. just use the repo_*() variant. We have been trying for a long time
to migrate away from these, and new code should use the non-macro
variants.

I noticed this because I have a local topic to do that migration, which
has a semantic conflict with this.
