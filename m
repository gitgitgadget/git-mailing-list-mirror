Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EF0C00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 15:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236774AbiHRP5I (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 11:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245730AbiHRP5G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 11:57:06 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E281170
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 08:57:05 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ba1so2230676wrb.5
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 08:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=E26t4+iHifEhiTZKJQ6DWevyrwgu7JnYIf5eopJRnc4=;
        b=ckNEjvkSeJ2wIcfQfp6GWBLUzuLihr9Dx+d1AdiECuXA+c9Q8Vq2bsEGBEQPi+56AB
         W2uW2AysX6GnPqqIvnKhjhZfL1MfWH95inj/uzMTyhdmhNCkQr8G+W8BwLruHO7iKIwJ
         dMHvNCMDmp6P4Oc/2iTE5SchB83mAR5YD4lv7BqLeellQ4CyI9oNEBFtFGqz7bRkNWo3
         VnTgoo0s+CF6T28ggEOi5IihLjpdCEbYzvTC95jk8SEyVgF2DYVhPHJQOYSTt8h13Yvl
         jtGLUJBBqnPfRWrnSqEbrRv24Ad41TXD819SLu6mr3BF+WVHc1Fpdl2qNHqIxFw5DkBd
         akMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=E26t4+iHifEhiTZKJQ6DWevyrwgu7JnYIf5eopJRnc4=;
        b=8BI8+fizZjX02pQabTkHxpCb9RXYSaJT/VUMHtpfhwWt6LvNi5ozjbTJ5ZW0MI91Y5
         GT0BsWsqFx6jAF2l+szH8y8EWY2G1J+QEyj62Ic8iRqO3N4QzVqEefNyxB7ZnBbruuaZ
         pDzOFHmqRNd1WySe9wh58uK4LCPtiYlVfMNq82geAnmwetZ1GCZuz4AFMh79pxtxbZt2
         vWOgiYHpYqkGKhepZ5VzvrNxW59t/GflJKSMJvWv5q2CeycCnbAzUpkYAz9nDjpww131
         C/K/3CkthQcUacRJ7lpCGmFO7I396uu2/OEUyGe34Z/TV8hC0EWuHtXYNAygIpkmxXDL
         H5Fg==
X-Gm-Message-State: ACgBeo1aKTNP+iK3TPbC5ionSIdzsnY8XOAnvcuhwobdmHAfm+C4b6W1
        W0S2s3TICIEzZlXRz4EcKMc=
X-Google-Smtp-Source: AA6agR6XSgesdhbh3sXZc9Sum/TjCmjQmUHKjVTOAnbax/7r/45422TghMgvKNIhi7eZNUP1K04sYw==
X-Received: by 2002:a05:6000:18a2:b0:221:7d99:5d22 with SMTP id b2-20020a05600018a200b002217d995d22mr1937435wri.248.1660838224000;
        Thu, 18 Aug 2022 08:57:04 -0700 (PDT)
Received: from gmgdl ([213.220.124.15])
        by smtp.gmail.com with ESMTPSA id v5-20020a5d6105000000b002251c75c09csm2072033wrt.90.2022.08.18.08.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 08:57:03 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oOhtE-000Iq9-2R;
        Thu, 18 Aug 2022 17:57:00 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 2/2] revision: allow --ancestry-path to take an argument
Date:   Thu, 18 Aug 2022 17:50:50 +0200
References: <pull.1303.git.1660704498.gitgitgadget@gmail.com>
 <pull.1303.v2.git.1660803467.gitgitgadget@gmail.com>
 <f580ec6d06072ea6ed2ecc4f8142b94fccbe4c0f.1660803467.git.gitgitgadget@gmail.com>
 <ee4a7a7f-d646-6357-233a-1fefde5607bf@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <ee4a7a7f-d646-6357-233a-1fefde5607bf@github.com>
Message-ID: <220818.86ilmp8rzn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 18 2022, Derrick Stolee wrote:

> On 8/18/2022 2:17 AM, Elijah Newren via GitGitGadget wrote:
>> +test_expect_success 'rev-list --ancestry-path=F D..M' '
>> +	test_write_lines E F J L M >expect &&
>> +	git rev-list --ancestry-path=F --format=%s D..M |
>> +	sed -e "/^commit /d" |
>> +	sort >actual &&
>> +	test_cmp expect actual
>> +'
>
> These tests follow the patterns from other tests in this file, but
> it also has bad patterns. Specifically, the 'git rev-list' command
> is fed directly into a pipe. I include a patch below that applies
> directly on this one to rewrite these tests. If you want, you could
> rebase to have that test refactor happen before you add your new
> --ancestry-path=<X> option tests.

Thanks, I was going to comment on the same, but your solution is much
better (I was just going to suggest using intermediate files).

> [...]
> -test_expect_success 'rev-list --ancestry-path D..M -- M.t' '
> -	echo M >expect &&
> -	git rev-list --ancestry-path --format=%s D..M -- M.t |
> -	sed -e "/^commit /d" >actual &&
> -	test_cmp expect actual
> -'
> +test_ancestry () {
> +	args=$1
> +	expected=$2

Maybe add &&-chaining here (we do it in some cases, but I'm not sure
when such assignments would ever fail).

> +	test_expect_success "rev-list $args" "
> +		test_write_lines $expected >expect &&
> +		git rev-list --format=%s $args >raw &&
> +
> +		if test -n \"$expected\"

Aren't you making things harder for yourself here than required by using
""-quoting for the body of the test.

We eval it into existence, so you can use ''-quotes, and then you don't
need to escape e.g. the "" quotes here for expected, no?

> +		then
> +			sed -e \"/^commit /d\" raw | sort >actual &&

nit for debuggability (and not correctness), maybe using intermediate
files here would be nicer? And then perhaps call them "actual" and
"actual.sorted".


> +			test_cmp expect actual || return 1

No need for a "return 1" here when we're not in a loop. It's redundant,
and makes the -x output on failure confusing ("why didn't I fail on the
test_cmp, but on this stray return?...").

...

> +		else
> +			test_must_be_empty raw

...which would also allow you to extract much of this if/else at the
cost of not using test_must_be_empty, i.e. just make the "expected"
empty unless "$expected" is provided. Just a thought/nit, we could also
leave this as-is :)

Also does the "compare rev" part of this want test_cmp_rev instead?
