Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C415C636D4
	for <git@archiver.kernel.org>; Mon, 13 Feb 2023 19:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjBMTmo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Feb 2023 14:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjBMTmb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2023 14:42:31 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD8421A3C
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 11:41:50 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id mg23so6396802pjb.0
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 11:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n/1G8Adhq0uAOZZ3xqLieGeZ7b95Od2WgSKM6qfYqq8=;
        b=JVFGVTlTOVq8b4YnHLqhmlSqoHgCv/6He5V/IImnx2XTtEgt1O7QfIY6f54kVzkXeQ
         yskCrOLzEcPtMeQnIJFJLst40t6V1uSbo9HKQuGCXdqy+xoWnBeK/vyXwaWvWVU+KID8
         ifohT2hituW5Wln4fi33AyQiA64IkeVpjtX/OjPy939HsPhq5MynfNA9/+zoezQ5qijr
         jxbZtIk3TPJratveyAtxBdqwYUGVHur1KnOxL36MCY/Apu8q6C22U+e2faunYkIGeR/1
         kheTDPzxKbxHEV/b94y+FxWvmH0O9vpSeJRSi6jaYrfaBXHuWMViqHI7kUI7WsWBpv+y
         qtyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n/1G8Adhq0uAOZZ3xqLieGeZ7b95Od2WgSKM6qfYqq8=;
        b=wXD8U7Nr7ovCBQcg2DM0bTFUfxn6SJgPf87cHHDVEWwC3+EgiUtcOMNWrzbLLlQh3G
         4P8RkHLdqL9rppSSFiG2bMxmuiYzSI7yr+T/BtVuv8ifNrengjTfCJZxt7pUvzoK5jix
         FnN3lOjag4nRmnkAWPAUr5NBNU2wOn4KR6mBaxUEvII4MgefFgHmtW88GzhngnNO4kaf
         Nj6LFWzF7yJAz5bcvkfczDpmqjOgene9zow2pDp3m/xrFh6/qdNUOdA9BD60l/mHM+QB
         zmzsbR081a/xXNR1FWNNY3GfWRQsUavvxY+V5USFnubvl5TmDgUDqeFyvt+Ud7eyan4l
         vhNQ==
X-Gm-Message-State: AO0yUKUpJol045/lpUQ/K5slu0ziI50l48KfxefOa0yZRl4q74mQP3Xy
        Ufw4IuKlwd5fdt55OJgRY+4=
X-Google-Smtp-Source: AK7set9fciPHP/7uW1L4WNzk+3kYzw3Jv7/P3fP41Sgko8NKiaEeXfs+RtCvPK2PjQFt+2PLJRc20Q==
X-Received: by 2002:a17:903:32c7:b0:196:82d2:93a with SMTP id i7-20020a17090332c700b0019682d2093amr107523plr.11.1676317296671;
        Mon, 13 Feb 2023 11:41:36 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id s3-20020a170902a50300b00199309531d5sm8536107plq.172.2023.02.13.11.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 11:41:36 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, Josh Steadmon <steadmon@google.com>
Subject: Re: [RFC PATCH 2/6] t4041, t4060: modernize test style
References: <20230213182134.2173280-1-calvinwan@google.com>
        <20230213182134.2173280-3-calvinwan@google.com>
Date:   Mon, 13 Feb 2023 11:41:35 -0800
In-Reply-To: <20230213182134.2173280-3-calvinwan@google.com> (Calvin Wan's
        message of "Mon, 13 Feb 2023 18:21:30 +0000")
Message-ID: <xmqqedqtbbf4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> From: Josh Steadmon <steadmon@google.com>
>
> In preparation for later changes, move setup code into test_expect
> blocks. Smaller sections are moved into existing blocks, while larger
> sections with a standalone purpose are given their own new blocks.

Nice.

> -test_create_repo sm1 &&
> -add_file . foo >/dev/null
> -
> -head1=$(add_file sm1 foo1 foo2)
> -fullhead1=$(cd sm1; git rev-parse --verify HEAD)
> +test_expect_success 'setup' '
> +	test_create_repo sm1 &&
> +	add_file . foo >/dev/null &&

Now this is inside test_expect_success, redirection to /dev/null is
unnecessary.

> +	head1=$(add_file sm1 foo1 foo2) &&
> +	fullhead1=$(cd sm1 && git rev-parse --verify HEAD)
> +'

Or "fullhead1=$(git -C sm1 rev-parse ...)".

Both of the above can be ignored if we are trying to be a strict
rewrite of the original, but moving code inside test_expect_success
block is a large enough change that there may not be much point in
avoiding such an obvious modernization "while at it".


> -rm sm2
> -mv sm2-bak sm2
> -
>  test_expect_success 'setup nested submodule' '
> +	rm sm2 &&
> +	mv sm2-bak sm2 &&

To me, this looks more like something test_when_finished in the test
that wanted not to have sm2 (i.e. "deleted submodule with .git file")
should have done as part of its own clean-up.

There certainly can be two schools of thought when it comes to how to
arrange the precondition of subsequent tests.  More modern tests tend
to clean after themselves by reverting the damage they made to the
environment inside test_when_finished in themselves.  This one, as
the posted patch does, goes to the other extreme and forces the
subsequent test to undo the damage done by the previous ones.

The latter approach has two major downsides.  It would not work if
the tester wants to skip an earlier step, or if an earlier step
failed to cause the expected damage this step wants to undo.  The
correctness of "what we should see as sm2 here must be in sm2-bak
because we know an earlier step should have moved it there" can
easily be broken.  It also makes it harder to update the earlier
step to cause different damage to the environment---the "undoing the
damage done by the previous step(s)" done as early parts of this
step also needs to be updated.

Whichever approach we pick to use in each script, it would be better
to stick to one philosophy, and if we can make each step revert the
damage it caused when it is done, that would be nice.

> -mv sm2-bak sm2
> +test_expect_success 'submodule cleanup' '
> +	mv sm2-bak sm2
> +'
>  
>  test_done

Likewise.

Thanks.
