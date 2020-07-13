Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B72C433E3
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 20:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F62920771
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 20:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9C40tIi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgGMUrB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 16:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgGMUrA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 16:47:00 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FA6C061755
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 13:47:00 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id u12so11102674qth.12
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 13:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UKqFA+WkgCsYBHTSWhRtWmt4oyUxbxhyVi/GANsjMKc=;
        b=U9C40tIivVy3W/qWdbIF14JHpzxowcSGmZL7+4s2doyIYwvr9cfS2nayTOoFlsu4AA
         M7N5fXCnJr/8ZErvBapB1G+2YvI2jLcupoiEYTopRWq97ly2160cOs7cPRTNCbdWAEUb
         TD6bC+9I9V26K0NznuhltKxte88NgmoWB9PN65R//zZqPh9Qs2g3iW1xEbL3TCptYtdQ
         Np9zQjKgA4eYbPSddKb+2OB13I6sIPh0miblUsNs9I6fXrejfzZF79qmEbyQWAOwRKOX
         r/+9mIulMgPAy4pzubj4sjuvJbLV6Exop4xhAepsjx+fI/x+NGgKjM0dX0o493Tb0gSP
         3uuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UKqFA+WkgCsYBHTSWhRtWmt4oyUxbxhyVi/GANsjMKc=;
        b=FwM1W5DtyASmPE6Cfca+r9KaUl/GH4qlsrxQps1xLVQOBfYSLzOtiL7NF1FsPiym3w
         4C0eEJBmpW9ul7VeZnsc1Zxn8VL8YdvwOlNVewwI3te1h3pQkVDxJJaKDL6jJFa7WOFv
         p+PaX3OmR2xr3epuE0qmg9KjeiwPbk+kUZUMPEddRm6+/N9ZuxbiJq0aNnmNOq+Dyb0l
         iqUNTxW+hcGxTUYVjaKfi7a4G1c8eTLwfBDZltM+nf4vgLAba3ZglgpLOpU/XsHY+2AL
         uHSwiUglHQtA3vaKDR2jnfkzkDW4Z/a7tX5sM+VLSmPvMR+d/xZOo/XbI4nZ5R7P3t3F
         lJFA==
X-Gm-Message-State: AOAM531K7yyrUVvkCt4JORRts0h+whPRP7J0pv4JXmNbqatKJCq5Lwqx
        CukI3t/ovn47+78QDD/4GTE=
X-Google-Smtp-Source: ABdhPJzBh6dm91iDhbXQU46rlq2cILNcWQdsh2ozG1Jhf+4AcVbg1bDt77qB8Mg9vK7W4En/woqQJA==
X-Received: by 2002:ac8:408c:: with SMTP id p12mr1245676qtl.332.1594673219292;
        Mon, 13 Jul 2020 13:46:59 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id h197sm20498445qke.51.2020.07.13.13.46.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 13:46:58 -0700 (PDT)
Subject: Re: [PATCH] setup: tweak upgrade policy to grandfather worktreeconfig
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, delphij@google.com,
        peff@peff.net, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.674.git.1594668051847.gitgitgadget@gmail.com>
 <xmqqblkjnr5m.fsf@gitster.c.googlers.com>
 <xmqqy2nnmbh8.fsf@gitster.c.googlers.com>
 <xmqqpn8zmao1.fsf_-_@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b8ae18f7-a0af-bd62-2553-92989e1dbe7e@gmail.com>
Date:   Mon, 13 Jul 2020 16:46:57 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <xmqqpn8zmao1.fsf_-_@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/13/2020 4:18 PM, Junio C Hamano wrote:
> The "fail and warn" approach introduced in the previous step may be
> with smaller impact to the codebase, but
> 
>  - it requires the end-user to read, understand and execute the
>    manual upgrade
> 
>  - it encourages to follow the same procedure blindly, making the
>    protection even less useful
> 
> Let's instead keep failing hard without teaching how to bypass the
> repository protection, but allow upgrading even when only the
> worktreeconfig extension exists in an old repository, which is
> likely to be set by a broke version of Git that did not update the
> repository version when setting the extension.

This is a more subtle way to handle the case. In fact, it
silently makes extensions.worktreeConfig work as it did in 2.27,
which means users will not have any troubles after upgrading.

I also like that you are actually fixing the case where a user in
the bad state _can_ get out using "git sparse-checkout init".

This can be verified by adding this test:

test_expect_success 'git sparse-checkout works if repository format is wrong' '
	test_when_finished git -C repo config core.repositoryFormatVersion 1 &&
	git -C repo sparse-checkout init &&
	git -C repo config core.repositoryFormatVersion >actual &&
	echo 1 >expect &&
	test_cmp expect actual &&
	git -C repo config core.repositoryFormatVersion 0 &&
	git -C repo sparse-checkout init &&
	git -C repo config core.repositoryFormatVersion >actual &&
	test_cmp expect actual
'

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * This time with a log message to explain and justify the change,
>    with a matching tweak to the test script, designed to be applied
>    on top, but feel free to squash it in if you agree with me that
>    we do not need two separate commits for this.

Since this commit removes all evidence of the previous one, I would
recommend just squashing them together.

Thanks for your fast feedback!
-Stolee
