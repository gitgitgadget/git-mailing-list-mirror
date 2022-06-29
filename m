Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BE0C433EF
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 12:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbiF2MzB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 08:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbiF2MzA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 08:55:00 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3BC2BB23
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 05:54:59 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id k20so11938740qkj.1
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 05:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=eMya2odsKWK8pL3HOTi8sr/9/Y8kpJ2QgYC1Reg5XIk=;
        b=KtM2elWGWfUlU/EQf1jNt8ig7eyLcpxkCb6WgPTL/sBZnKHPc68UE6zuKOXEUnAWBe
         Hx45qBa4URzFbAUvnMytYF/MFVcWh/RbZ+fRAUnTrctyFr/OhfvFWdVg6LyaHvSWDKzC
         BldzOKeT70v4AyV6Wc1ZbwgZyoqJYGnaVU0MGZPw9oFOD6qgByUZFQxGdB9O4vRN8roL
         52GfsIZns+fiToQTK9lEg79VUEdIIk2/bBPGKSExbAX9Rls1/t2Ogv74Uee0doUHTohx
         u4Kt8lTsz1kQ6x0uGk7tWRRZpRz/vjA/qWXvbgcjxnrLL1wqS0weJlgnONtXUjcy0OHZ
         nG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eMya2odsKWK8pL3HOTi8sr/9/Y8kpJ2QgYC1Reg5XIk=;
        b=uN4kLP7HJscdHZsk8PbJct2OCnYDLMZPb59TlHwWhG8g7PWzocXeqw+oY3QJM79kLc
         luxkdq4xRRqgx/Fi+aZbhYUzpG+luDm+tduVpnXQYSQghixCzSGkMNpv4gxSunFknvQq
         H3HLxxqXXY5x8G3cG6Agwxe7nPFX6S/obybhBW06Nh8AoK8NJ9NfGKagX7ZYvwMCsBQv
         EUajfaiiW8j+pmng3G3bJRnlMebiYJemdL3l9vv9WvAztrWpUb+30hkn4rZbq/4Zcb/M
         edZ2IZ11r0Zr8myJmL53eI25i3W/sOIvgEZiH4V6mehX0ERMV+sLqj2xhWipHsiVvS6d
         9DpQ==
X-Gm-Message-State: AJIora+Ocg/06OPNeDaryFh9Qka3Q0ViGKJoRzL7v61jX0BjtUf1odLs
        W+k+mB/5nDkAmYaOgwkWnmEW
X-Google-Smtp-Source: AGRyM1sjyAkeIfdlmkOkYrk7mHljQAmbEtbLjbPN2nW8qG4rHcOzEJwcObYe0tpXpH+qnVH3k8UoGQ==
X-Received: by 2002:a37:a488:0:b0:6af:4bb:fea9 with SMTP id n130-20020a37a488000000b006af04bbfea9mr1823747qke.380.1656507298213;
        Wed, 29 Jun 2022 05:54:58 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:d803:95aa:58b0:8205? ([2600:1700:e72:80a0:d803:95aa:58b0:8205])
        by smtp.gmail.com with ESMTPSA id x8-20020a05620a258800b006a75a0ffc97sm13453334qko.3.2022.06.29.05.54.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 05:54:57 -0700 (PDT)
Message-ID: <4016eee6-0759-dece-cd7b-0ed8454faf63@github.com>
Date:   Wed, 29 Jun 2022 08:54:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v3 1/8] t2407: test branches currently using apply backend
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
 <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
 <fbaedc7f1f02efec251cb4df665fd3cb71f1d3b3.1656422759.git.gitgitgadget@gmail.com>
 <xmqqtu84iklu.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqtu84iklu.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/28/22 4:44 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

>> -test_expect_success 'refuse to overwrite: worktree in rebase' '
>> +test_expect_success 'refuse to overwrite: worktree in rebase (apply)' '
>> +	test_when_finished rm -rf .git/worktrees/wt-*/rebase-apply &&
>> +
>> +	mkdir -p .git/worktrees/wt-3/rebase-apply &&
>> +	echo refs/heads/fake-1 >.git/worktrees/wt-3/rebase-apply/head-name &&
>> +	echo refs/heads/fake-2 >.git/worktrees/wt-3/rebase-apply/onto &&
>> +
>> +	test_must_fail git branch -f fake-1 HEAD 2>err &&
>> +	grep "cannot force update the branch '\''fake-1'\'' checked out at.*wt-3" err
>> +'
>> +
>> +test_expect_success 'refuse to overwrite: worktree in rebase (merge)' '
>>  	test_when_finished rm -rf .git/worktrees/wt-*/rebase-merge &&
>>  
>>  	mkdir -p .git/worktrees/wt-3/rebase-merge &&
> 
> This is not the first offender, since the other existing one is
> doing the same, but it is a bit sad that this makes it worse to
> expose and depend on the details of the way the rebase happens to be
> currently implemented.

This is true that it is based on how  it's currently implemented. I
was confused that none of these rebase storage mechanisms are
documented anywhere (so I couldn't extend that documentation with the
new update-refs file added in this series). But perhaps that's by
design: this is intentionally an internal implementation detail.

I do wonder where that leaves third-party implementations like libgit2
to handle any changes we make in this space, or how much we care about
supporting someone rebasing in a worktree with an older Git client
while also checking out a branch in another worktree using a newer one.

> Perhaps a more kosher way to do this is to find an commit that
> surely would not allow fake-1 branch to be cleanly rebased onto and
> actually start (and cause it to stop) a rebase.

This, and the equivalent "pause in the middle of a bisect" would be
ways to hide these internal details.

While I was thinking that this provides a low-weight mechanism for
testing the implementation of branch_checked_out(), it is only testing
the implementation but not the _intention_. If 'git rebase' changed
its backend, then these tests would not start failing as we need them
to.

> I notice that the original offence was committed fairly recently, by
> d2ba271a (branch: check for bisects and rebases, 2022-06-14) that we
> can easily eject out of the 'next' branch when we rewind and rebuild
> it, if we wanted to.

I can either re-roll that series or create a new forward-fix that
includes the functionality of this test. Both are the same amount of
work for me, so let me know which you prefer.

Thanks,
-Stolee
