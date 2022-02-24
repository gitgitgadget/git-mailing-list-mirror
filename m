Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42839C433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 11:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbiBXL4v (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 06:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234140AbiBXL4t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 06:56:49 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4DE254561
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 03:56:19 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id p9so3787419ejd.6
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 03:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=YxWxF+ZwnLWTvZ8Yqb/0H4prvEMidu3j1Sjqp/rzCDY=;
        b=EL9LmtYOrbztllH1SQiivrvydk80AZ5mYZhgMI10QC4WC8XTPQxaIKFeVRpgiz6uaj
         Br6641DCEuqvnAqmN4z56Dm4E+3RPBNygjJj7fS6cCp3Hb0Ob4y+9DgmbLbzambZYmmg
         HhDfZ5pd5a0SUBsDFJnUZe6o1li3SzzV3WW7Poyicw+WQD8Q2GTlnWF9hVy/oRaIUEHa
         Hf5Dp/aRbApjSTzJ/KLC9upDbN5ivAVNcmquXNGuK3VnXPhYExHlO3fwuPluXpK2oSOD
         3Ff3qEjLsCSXj6EdElmjnExyGF7KUiVy+yGWR/1GIKed4OmTRzqVwpNgDWCOyfnYlXul
         hMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=YxWxF+ZwnLWTvZ8Yqb/0H4prvEMidu3j1Sjqp/rzCDY=;
        b=KVIp9nslYtDt9Fcgnos11cES1XfZLP9aLmBDqPBDCgqvh4tfHXbtK7VeW+7qyTwKmF
         JcoF7UVbkuzuq0Hi+DE+lcBYMZeyt6Ikzkj8vOAdwihUcoiFMeYVgGdajgZ/YO5jZnBT
         happgbL30JLNcek+vfxVm6xuUR99bojDETYitcq7XGGkUMWuD3hQJbWaLrqoOwHIdHQS
         TY9t5ChtCqqxV23WxlbP9lNsFOIa1He3RL4tJvL12uzEc/X8wANXRoOopV1YXKgT1T1V
         ZSuB3tyR8nufr80EViE5ruXbNhzESLZkBOICxeaA7mD65oXA7drMGpORu2NJCywvTTQM
         CazA==
X-Gm-Message-State: AOAM530vuDE1RRb+dOmIHWRbiE3snP4zYI4hd9ZzI/oGS0VbCSDQn7M8
        2G83eqIXFO0x8a7MnW/Oa5P57KxVrBR00Q==
X-Google-Smtp-Source: ABdhPJyK0ZC2lYEKl4IcK5RfRgjI5DhQoresMcM+nCvuKcIVcsp06lp9dw5fz2qJ9Ub3FhGv7JD6Ug==
X-Received: by 2002:a17:906:f18b:b0:6d0:4fa4:8c2d with SMTP id gs11-20020a170906f18b00b006d04fa48c2dmr1948990ejb.122.1645703777653;
        Thu, 24 Feb 2022 03:56:17 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id v8sm1254622edc.0.2022.02.24.03.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 03:56:17 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nNCjI-000It1-Hk;
        Thu, 24 Feb 2022 12:56:16 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 02/10] t5526: stop asserting on stderr literally
Date:   Thu, 24 Feb 2022 12:52:58 +0100
References: <20220215172318.73533-1-chooglen@google.com>
 <20220224100842.95827-1-chooglen@google.com>
 <20220224100842.95827-3-chooglen@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220224100842.95827-3-chooglen@google.com>
Message-ID: <220224.8635k8a36n.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 24 2022, Glen Choo wrote:

> +check_sub() {
> +	NEW_HEAD=$1 &&
> +	cat <<-EOF >$pwd/expect.err.sub

Hrm, I didn't know that would work, the usual style is:

    cat >file <<...

Instead of:

    cat <<.. >file

Maybe better to use that?

> +	Fetching submodule submodule
> +	From $pwd/submodule
> +	   OLD_HEAD..$NEW_HEAD  sub        -> origin/sub
> +	EOF
> +}
> +
> +check_deep() {
> +	NEW_HEAD=$1 &&
> +	cat <<-EOF >$pwd/expect.err.deep
> +	Fetching submodule submodule/subdir/deepsubmodule
> +	From $pwd/deepsubmodule
> +	   OLD_HEAD..$NEW_HEAD  deep       -> origin/deep
> +	EOF
> +}
> +
> +check_super() {
> +	NEW_HEAD=$1 &&
> +	cat <<-EOF >$pwd/expect.err.super
> +	From $pwd/.
> +	   OLD_HEAD..$NEW_HEAD  super      -> origin/super
> +	EOF
> +}

These look a lot better, but instead of always passing the result of
"git rev-parse --short HEAD" can't we just always invoke that in these
helpers?

Maybe there are cases where $NEW_HEAD is different, I've just skimmed
this series.

> @@ -62,7 +82,8 @@ verify_fetch_result() {
>  	if [ -f expect.err.deep ]; then
>  		cat expect.err.deep >>expect.err.combined
>  	fi &&
> -	test_cmp expect.err.combined $ACTUAL_ERR
> +	sed -E 's/[0-9a-f]+\.\./OLD_HEAD\.\./' $ACTUAL_ERR >actual.err.cmp &&
> +	test_cmp expect.err.combined actual.err.cmp
>  }

I think this is unportable per check-non-portable-shell.pl:

        /\bsed\s+-[^efn]\s+/ and err 'sed option not portable (use only -n, -e, -f)';
