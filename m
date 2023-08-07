Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226AAEB64DD
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 05:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjHGFuq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 01:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjHGFup (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 01:50:45 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E7B1703
        for <git@vger.kernel.org>; Sun,  6 Aug 2023 22:50:44 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-563fbc76454so4120219a12.2
        for <git@vger.kernel.org>; Sun, 06 Aug 2023 22:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691387444; x=1691992244;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yROdIoBE0j38ktlmoeIDamfzfy9svoBTt5r2zDm3X70=;
        b=lArnB1cx4UV8pK3/+utQhGNCKUpMuFnnTfmqf8SDfmTiajz/ay8KvWVLLym5+hSayz
         +rCLe78UKj0j8OYw6N/IewygUTI2DY3M0ZGjRvE93YiiCcao73AT2Wpfj1scdfwWysKT
         JyGy/p1by2EJx2gkGh3XIECVnTeO5T4AO7BQJp+v17cnMfp0nRemiHdqq/zNufM8Lv4M
         DeaFkzFjd81Y+r4IPNqcpwpE3HEkoYtcLg0yIyaZwmEx1tEwQVlB1nqvzxd0zSNeAGSi
         J2fvpkD+00WYdnazVyrn1fe4irhqzWjN8igiJx56n83iENu6lX+pbuwohcq+mOfvor+5
         29oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691387444; x=1691992244;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yROdIoBE0j38ktlmoeIDamfzfy9svoBTt5r2zDm3X70=;
        b=dRboJBh/1KqWf7PSI+4GiN8Q+TMFhoZK+UYxR0TTLoNU/TVlfN+jo58dWe3MX6ie0I
         kDIb2jH/Hep8bWP9TD4oNVJUy2k1IoUseV/XGAiuOvW6kfSQvvLA38c1iTjemwb8mznG
         BEiRi+DrGma0Lb5kpECKDmhkW/0JFNsSv+1LOPw4R92Zo8FsoTXdqhv2i3Z3WI/jDHFy
         f5+Ayoid74A0SndvgOiHmzIIoMmvUY3D8El4xPolx+ynRU4uKAGzeMZ6BGkAZlDlGZrt
         WLg63p10QMNxM8N8g0rI4zyU5sIQwojs/mgwGV06ItfZw3GOSSPfIkzGU4xcK9MNWWLj
         3giw==
X-Gm-Message-State: AOJu0YzoHayCUw+dvqrjZNiycS8OYPQVVAmZrbASy9dbXPE3mTRBs38D
        K/4U88e7r9qWX1qhzFrsLG7+gVMQK5o=
X-Google-Smtp-Source: AGHT+IEITjJYU4YlYOOrEKlYOhUjTLSdxMeIOllgKOMTiVJgoz+vcSj8Na+O3af8WMMrJCpi5mwoPHhM0dM=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:903:2349:b0:1bc:4c3d:eb08 with SMTP id
 c9-20020a170903234900b001bc4c3deb08mr34227plh.8.1691387443702; Sun, 06 Aug
 2023 22:50:43 -0700 (PDT)
Date:   Sun, 06 Aug 2023 22:50:42 -0700
In-Reply-To: <6d67ae6b1f62a2be076d752a2af65bb07998ca73.1691210737.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
References: <pull.1564.git.1691210737.gitgitgadget@gmail.com> <6d67ae6b1f62a2be076d752a2af65bb07998ca73.1691210737.git.gitgitgadget@gmail.com>
Message-ID: <owlya5v3bdu5.fsf@fine.c.googlers.com>
Subject: Re: [PATCH 1/5] trailer tests: make test cases self-contained
From:   Linus Arver <linusa@google.com>
To:     Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
> ...
> @@ -1392,7 +1610,9 @@ test_expect_success 'with failing command using $ARG' '
>  '
>  
>  test_expect_success 'with empty tokens' '
> -	git config --unset trailer.fix.command &&
> +	test_config trailer.sign.command "echo \"\$GIT_AUTHOR_NAME <\$GIT_AUTHOR_EMAIL>\"" &&
> +	test_config trailer.sign.key "Signed-off-by: " &&
> +	test_config trailer.ifexists "addIfDifferent" &&
>  	cat >expected <<-EOF &&
>  
>  		Signed-off-by: A U Thor <author@example.com>

In this test and some other places we get the chance to remove
invocations of "git config --unset ..." (because we don't leak config
state anymore). I will update the commit message accordingly in the next
reroll.
