Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D10C001B0
	for <git@archiver.kernel.org>; Mon, 14 Aug 2023 16:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjHNQYu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Aug 2023 12:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbjHNQYe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2023 12:24:34 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B2E127
        for <git@vger.kernel.org>; Mon, 14 Aug 2023 09:24:33 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bdbbede5d4so26118505ad.2
        for <git@vger.kernel.org>; Mon, 14 Aug 2023 09:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1692030273; x=1692635073;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9aDrDB6njJrtzcNDgnuJB1mJoWBaaaCVd4qVpSbSMIE=;
        b=GAPn49wXgxMUvQsnp8IIo+PqRTRlL0M4xJy2hYVx0h26+hcf2uW44qrY/9jcCkP9P4
         rIEt7/eJYQZgLgZjPWiJiwYGdmXqS9hmmp2V3n941QwjkuNuC4gdzyBqjEk9SbLaFpJZ
         lSM3RY3JrYxB573bHwFPVqb6pMkZVbn37fCrUer9FmTO0PgT7r2kP7YOuA1Fm/8aS+Jl
         pQ0qSW2pt36WfBg3CdUWzISLsC4UdK5bDKOQ8u2rLvoIV8gffipaJeXbt2towgN3znBx
         IGNIbzxzQNM3viDXy91BSZDrsZxcBlacWd3NrXhoQh0QE8ICsF/ngunAndGK3IrlTmn+
         1YuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692030273; x=1692635073;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9aDrDB6njJrtzcNDgnuJB1mJoWBaaaCVd4qVpSbSMIE=;
        b=dDnVOuVbwzFIp74Hv0JTZDvzVVu4IuL8vqiqhH02+6qB8nPMlp8CdSXF+mYmXds3Y3
         W5JsuTghGFbPA8beGpsc0+tiq3kdCsMXy+yfy4W4uPn/T4ontSwkndmeNJ2YzV0WHfVv
         Abt+Q7pL1X+Jh4zWMKoLOdVjGgSjIyC2BUF/+IMsD/K+yjbkOEaO5aKbuPQA40QzoIBg
         KP9kQzRUzDUzKgyNqLusbdiejxrhcqElKwpx3uMC+8fa/3XO4eja/TrCZdRyjqNE8qk2
         gaHT5ILCFF0dqbKqXd/x3PnZ+kYZNxpTq+NfLQuLH5wkfs4eelU8MYlJ8eSMVkxNG37E
         o5eA==
X-Gm-Message-State: AOJu0YyI25EslcckOub3Gm5lYi9s4pgmvYNcB39PSOklf5SNitWo2tFX
        C2G/lRjqYAMsSNCISjgAxyKL
X-Google-Smtp-Source: AGHT+IE39Vv6I1QcrMaVe/KUhfpu0c+RKqtkBhfHpvXOBqfH5xcOuh9sDNDi0hTRj75jpgYdrTxEzQ==
X-Received: by 2002:a17:902:904a:b0:1bb:a4e4:54b6 with SMTP id w10-20020a170902904a00b001bba4e454b6mr10393850plz.62.1692030272795;
        Mon, 14 Aug 2023 09:24:32 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id e10-20020a170902b78a00b001bd41b70b60sm9659872pls.45.2023.08.14.09.24.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 09:24:32 -0700 (PDT)
Message-ID: <3b2a5b4b-ab8f-746b-6b69-8e8262b6390b@github.com>
Date:   Mon, 14 Aug 2023 09:24:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v5 0/3] check-attr: integrate with sparse-index
Content-Language: en-US
To:     Shuqi Liang <cheskaqiqi@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com
References: <20230718232916.31660-1-cheskaqiqi@gmail.com>
 <20230811142211.4547-1-cheskaqiqi@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20230811142211.4547-1-cheskaqiqi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang wrote:
> change against v4:

I've reviewed the patches in this version and all of my prior feedback
appears to be addressed. Overall, I think this is ready to merge. 

I see that you didn't take the suggestion from [1], though. I personally
don't consider it a blocking issue, but I am curious to hear your
thoughts/reasoning behind sticking with your current patch organization over
what was suggested there.

[1] https://lore.kernel.org/git/kl6la5v82izn.fsf@chooglen-macbookpro.roam.corp.google.com/

Otherwise, a couple notes:

> 
> 1/3:
> * Add a commit message to explain why 'test_expect_failure' is set
> and why 'test_expect_success' is set.
> 
> * Update 'diff --check with pathspec outside sparse definition' to
> compare "index vs HEAD" rather than "working tree vs index".
> 
> * Use 'test_all_match' to apply the config to the test repos instead of
> the parent .
> 
> * Use 'test_(all|sparse)_match' when running Git commands in
> these tests.
> 
> 2/3:
> * Create a variable named 'sparse_dir_pos' to make the purpose of
> variable clearer.
> 
> * Remove the redundant check of '!path_in_cone_mode_sparse_checkout()'
> since 'pos' will always be '-1' if 'path_in_cone_mode_sparse_checkout()'
> is true.
> 
> * Remove normalize path check because 'prefix_path'(builtin/check-attr.c)
> call to 'normalize_path_copy_len' (path.c:1124). This confirms that the
> path has indeed been normalized.

Nice, thanks for looking into this! I'm glad we're able to avoid the
normalization, it simplifies the code quite a bit.

> 
> * Leave the 'diff --check' test as 'test_expect_failure' with a note about
> the bug in 'diff' to fix later.

Makes sense. The extra detail added in the "NEEDSWORK" comment is especially
helpful in pointing out which part of the diff machinery causes the issue.

> 
> 
> Shuqi Liang (3):
>   t1092: add tests for 'git check-attr'
>   attr.c: read attributes in a sparse directory
>   check-attr: integrate with sparse-index

