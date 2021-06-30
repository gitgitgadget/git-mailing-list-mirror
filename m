Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF33C11F65
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 18:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8D1161469
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 18:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbhF3SEc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 14:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbhF3SEa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 14:04:30 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F27C061756
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 11:02:01 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id j5-20020a170902da85b0290128c0eedd67so1549452plx.15
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 11:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mz+/9d6lYYAu5GT72z5Haw0m2L/YdUJbrzZvWyY0lfk=;
        b=WiEXphtiQY1a/8C1Df3T9o/Q5Hmnfq88ivazXtHS+m9jCenQ1NdgHbumsM4wjTOwuL
         cUc4AvdYJYxrhMQjD5dWXQwnsv3YohHESMyw5OTne9GLseVUfbraSjBlJB8o9JN6QMCS
         XZ0yLjuKhEAWaUOaSUXhtK694LcSrSYlHQJsTF2smmqX8TKLoTJkpdyehzMNGMtwcGG6
         VBCCZROlN9q7uDPlSqRnC/JVbkPPJps2DNU/7cArcBDI/eT+byUrksYL20qKKR4GLJH5
         ZAtBHcdcyaWYTkPCB/ZfVr8XtL7MBqOe44NPWnE7WTpP4w/t1L/uvzKQdBNaF6EO/3mC
         HpKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mz+/9d6lYYAu5GT72z5Haw0m2L/YdUJbrzZvWyY0lfk=;
        b=Nn3X6V//bTkvx3mbKabesrzzl4l8BPPs8Iy/LUL3pj82c8OYv4ECp4IBJCjvUNDcK5
         8DgjlFIDl4/k4nF772M6OuODy5+/oaT6SeLSQTIhTUAkRVWQ0LknpFfP5k8UXSPCbLi3
         +6ZW4DlclO1HhwEaLSn9jAc2oWc8HmQwBCjiKFZIAcCHLoWHkHhqdRJsEedVr7fUIHZN
         CSfHJNJ6jQk0l2fzlmLIPUhrnD1mN74v24cuSl/obEQ+A8ZlY5uUcgi8aW+NWgGZRgvQ
         szlBU7HTCWFdkSBDksOw2rKwhxb7puAA4WmROIhibi+O7NqFgvvyH+9lJJ124m1tLwQW
         QhnA==
X-Gm-Message-State: AOAM530dHPuZdb6R6DurMkNI+ruqCuTmhpsy09DzO2bQfyC3PQ8NOaLD
        Wy7Fzbu/74BeDdJH0UQKQKu4J/jxOuafcMO+/MU6
X-Google-Smtp-Source: ABdhPJxJWuymeOwRB1C3kFyUWkcYCz1ryO9IjnA/wYUtHHR5bjSPVvhOiOikrBlH/iK7zfrUJTOHK4J/o3C4c3V0mddF
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:1614:0:b029:308:22b0:5cff with
 SMTP id 20-20020a6216140000b029030822b05cffmr34459573pfw.13.1625076120753;
 Wed, 30 Jun 2021 11:02:00 -0700 (PDT)
Date:   Wed, 30 Jun 2021 11:01:57 -0700
In-Reply-To: <patch-3.3-38930024d95-20210630T163329Z-avarab@gmail.com>
Message-Id: <20210630180157.1227166-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <patch-3.3-38930024d95-20210630T163329Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: Re: [PATCH 3/3] fetch: fix segfault in --negotiate-only without --negotiation-tip=*
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
> index 66af411057c..920815478c7 100755
> --- a/t/t5702-protocol-v2.sh
> +++ b/t/t5702-protocol-v2.sh
> @@ -599,6 +599,23 @@ setup_negotiate_only () {
>  	test_commit -C client three
>  }
>  
> +test_expect_success 'usage: --negotiate-only without --negotiation-tip' '
> +	SERVER="server" &&
> +	URI="file://$(pwd)/server" &&
> +
> +	setup_negotiate_only "$SERVER" "$URI" &&
> +
> +	cat >err.expect <<-\EOF &&
> +	fatal: --negotiate-only needs one or more --negotiate-tip=*
> +	EOF
> +
> +	test_must_fail git -c protocol.version=2 -C client fetch \
> +		--negotiate-only \
> +		origin 2>err.actual &&
> +	cat err &&

I think I inadvertently left a similar line in other tests in this file, but
this shouldn't be in.

Other than that, all the patches look good to me. Thanks for taking a look at this.

I have a patch set [1] that fixes related bugs (but not this one - in
particular, --negotiate-only without --negotiation-tip still fails, so we still
need this patch set). I've tried merging my set into this set; the merge is
clean and all tests still pass, so there shouldn't be any problems with that.

[1] https://lore.kernel.org/git/cover.1624486920.git.jonathantanmy@google.com/
