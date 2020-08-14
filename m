Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771E5C433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 01:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B51E20855
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 01:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOlN8FRO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgHNBNU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 21:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgHNBNR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 21:13:17 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB30C061757
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 18:13:17 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id v22so5902210qtq.8
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 18:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7iWmqpYkpIhNMaME5DRfIs1ELx/WJCju8p4eA+mJGrs=;
        b=HOlN8FRO8ptTBTilQig8vArlQSjOZOsKi3VrcrBVBCk5bKpg7jY/Z7qsKVAnTZIVtX
         oaKGcb68RF6bEiIxkQ4t5mv1Dbwn13+6rkNFCi6C8/ii2aVzHMvJf4hq6KozoPio28AC
         8MPFjX4ZU7+INWBYlsVK/FLdV4CFiXlOZpNJP//Qqp+emM0LbzPCfjIiXstFAjWW9p5U
         VI1QfP8sUKKWSEMnbr9f6Dn4i4w5ZMF5nYvQpSGLo9W/tV4Y2+3trXvao3vA8P/zT3MP
         TcvyvvIqdkphjy+ldIDk0VD64ZxWdrEV8RoTVY8Hh0eb7dtRazwBsPsaDbkNVqwvxvej
         6z3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7iWmqpYkpIhNMaME5DRfIs1ELx/WJCju8p4eA+mJGrs=;
        b=emyFDl/m0eRRc/F5u2B9UiyDfyZ5WXtkhV/OekHKkSaIqusghm0+djGk5S6MIhLqS0
         6Q55yl/5Qfmb9x5zo4w9CvYre4taM0imKhyHPREwl3Ew8RmccvW8zc559hSsEVuBd60B
         1RMzJYbcR9rEn/bSm37vIigA+QPBe/2qnf1k/BYwOfVeqtMBqdgF5m1QEt+vdZE97byC
         rbxMokR/ctDv2BEroPLK4Qz13ykHDPgmLno9F79Vqk78IFbgJgg8mTjiT9HZgcuqc895
         IUzUk1F9JgGk7BTagfDc4xbjy6rnl3uNBrvmL6GlQYj2XuvaVaQBar4ewpS1O3zt3eQ1
         GfJQ==
X-Gm-Message-State: AOAM530uHaGd8/sI3ZEfq9ZpO+cmgpt6ZQbl6XY9zsm1kqGnlIJ9H0cV
        kZ6h/AtSkompl1whRx06RFvgUhE19OE=
X-Google-Smtp-Source: ABdhPJw9OCINCWHPudnA6Kx1xD8a3igWyjwfWLIG/VDnxzkSGe5SesMD8DX/CR+2wm7u7eTUP8Fqyw==
X-Received: by 2002:ac8:72c7:: with SMTP id o7mr43482qtp.99.1597367596250;
        Thu, 13 Aug 2020 18:13:16 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:7dfc:cd76:faf5:aaad? ([2600:1700:e72:80a0:7dfc:cd76:faf5:aaad])
        by smtp.gmail.com with ESMTPSA id o13sm7580323qko.48.2020.08.13.18.13.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 18:13:15 -0700 (PDT)
Subject: Re: [PATCH v3] fetch: optionally allow disabling FETCH_HEAD update
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Emily Shaffer <emilyshaffer@google.com>
References: <pull.696.git.1596731424.gitgitgadget@gmail.com>
 <83401c52002716084b9c53a77c9d57b6009f84e2.1596731424.git.gitgitgadget@gmail.com>
 <20200812231021.GG2965447@google.com>
 <xmqqo8nf4dkb.fsf@gitster.c.googlers.com>
 <xmqqh7t740vu.fsf_-_@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8acc67e5-4b17-7fdc-0685-b5113e819010@gmail.com>
Date:   Thu, 13 Aug 2020 21:13:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <xmqqh7t740vu.fsf_-_@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/13/2020 12:37 AM, Junio C Hamano wrote:
> If you run fetch but record the result in remote-tracking branches,
> and either if you do nothing with the fetched refs (e.g. you are
> merely mirroring) or if you always work from the remote-tracking
> refs (e.g. you fetch and then merge origin/branchname separately),
> you can get away with having no FETCH_HEAD at all.
> 
> Teach "git fetch" a command line option "--[no-]write-fetch-head".
> The default is to write FETCH_HEAD, and the option is primarily
> meant to be used with the "--no-" prefix to override this default,
> because there is no matching fetch.writeFetchHEAD configuration
> variable to flip the default to off (in which case, the positive
> form may become necessary to defeat it).
> 
> Note that under "--dry-run" mode, FETCH_HEAD is never written;
> otherwise you'd see list of objects in the file that you do not
> actually have.  Passing `--write-fetch-head` does not force `git
> fetch` to write the file.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * So, it becomes much smaller by punting the whole configuration
>    thing, as we do not need the extra code for config parsing and
>    there is no need for code to override the user configuration when
>    driving "git fetch" from "git pull".

Sounds good. I'll incorporate this patch into my next version,
except it seems you dropped this test:

diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index 159afa7ac8..db1a381cd9 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -85,6 +85,13 @@ test_expect_success 'git pull --cleanup errors early on invalid argument' '
        test -s err)
 '
 
+test_expect_success 'git pull --no-write-fetch-head fails' '
+       mkdir clonedwfh &&
+       (cd clonedwfh && git init &&
+       test_expect_code 129 git pull --no-write-fetch-head "../parent" >out 2>err &&
+       test_must_be_empty out &&
+       test_i18ngrep "no-write-fetch-head" err)
+'
 
 test_expect_success 'git pull --force' '
        mkdir clonedoldstyle &&

which I changed "test_must_fail" to "test_expect_code 129" to
demonstrate that this is a usage error, not just any error.

Thanks,
-Stolee
