Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53396C4743C
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 19:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2925461075
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 19:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhFWT2V (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 15:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhFWT2T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 15:28:19 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8140EC061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 12:26:01 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id s23so4533662oiw.9
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 12:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=C2rGEhDcWyTLA0PyD+55gBr8es4M8tkURTpzvoUNLic=;
        b=a06UlH6AIRE8GRXhUqtb/R4pGwtP9wQP2GyHpszBIjjUwvqhIALLhuKBiplXTZCXxH
         dhYJsMzrIz946LYoXUyxUxGwRz8IzDH2leOvho+VkrnTymPb3ppO/F2WZ9iaYfna1TuZ
         4anVy0pe+O72jur3Ahob4WZKjiOhGbHxlarNZsRRbnUoc+NKngSx4RW2lhEh1E5DGzX/
         8mKxWNjhz7x3I7vIN59tGyRbBuXbJWVLtoF2JvGRlLZ7KCVkeU9wnQ6himldNQ8p8j7y
         kMZQHY8QEvy0OCZbQcHwRII+FNgye2/M0ph2nN/VOGlhulekCUoxfS65Z8YpHfQhLEO8
         OaZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=C2rGEhDcWyTLA0PyD+55gBr8es4M8tkURTpzvoUNLic=;
        b=EBllabcq9d0Eu7emAc+FyMbfsPcj+no6/VcB5kdHK/il3Gvd31BGnjiOSAjtajvF96
         5cN7YJl7IQPI3BMWJu2GXQfOL0TsHYZoCOAnyAGVg4HLHo42ffaGGdlPqjp0er09hZ8G
         vT1jzll59zA4RgAz/i2fd3uGfuvZZKCwi4fcG6FSzYQISsy+YpGHrFAnfKcxxJNoyELf
         gMuYfPsX7eZt3PI1PKva3Gqu4CChFWdccnj9+vNroPNLty89RmigR+ChdAwqkO2OnSRC
         7EH6o/7guFqrMA8Sc2Iwbx9a9xbs8WwDAnJVjc+lAoC61EQvMwBkPmqKtY0c70E9IEMF
         b8Lg==
X-Gm-Message-State: AOAM533YGBEoJGBS4fJ3uvXly8KL43q1iU3ytenylkmNdTH/EgZH+1Sn
        LKG/cWmOPQdTEQLkxVOwZJU=
X-Google-Smtp-Source: ABdhPJzzIMUK3SvCv/fmxiugMUgBR4nvlCwxghKlKnG7Q920vrvFgjfkeO9+pJQNCIUZ942sxODXHQ==
X-Received: by 2002:a05:6808:1144:: with SMTP id u4mr4512947oiu.133.1624476360909;
        Wed, 23 Jun 2021 12:26:00 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id r27sm137058oiw.34.2021.06.23.12.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 12:26:00 -0700 (PDT)
Date:   Wed, 23 Jun 2021 14:25:59 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Kristof Provost <Kristof@provost-engineering.be>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <60d38ac74a93d_4290208ae@natae.notmuch>
In-Reply-To: <patch-2.3-ea39f1f5cd2-20210622T141844Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210622T141844Z-avarab@gmail.com>
 <patch-2.3-ea39f1f5cd2-20210622T141844Z-avarab@gmail.com>
Subject: RE: [PATCH 2/3] Makefile: fix "cscope" target to refer to cscope.out
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> --- a/Makefile
> +++ b/Makefile
> @@ -2737,10 +2737,11 @@ tags: FORCE
>  	$(FIND_SOURCE_FILES) | xargs ctags -a -o tags+ && \
>  	mv tags+ tags
>  =

> +cscope.out:
> +	$(FIND_SOURCE_FILES) | xargs cscope -f$@ -b
> +
>  .PHONY: cscope
> -cscope:
> -	$(RM) cscope*
> -	$(FIND_SOURCE_FILES) | xargs cscope -b
> +cscope: cscope.out

The reason for the $(RM) removal is not explained in the commit message.

Otherwise the pach looks good to me.

-- =

Felipe Contreras=
