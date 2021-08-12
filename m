Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C85C4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 09:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85F8F60EB9
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 09:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbhHLJd3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 05:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235823AbhHLJd2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 05:33:28 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A857AC061765
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 02:33:03 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id q18so463868wrm.6
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 02:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yjMvbywbvK0l3+ZRaEvzSjC6TmNH57nYTu0eyyId+eM=;
        b=cq7I0rEfvIWc7zRmt/zxjQFBZGUz/4SoTb7HSNLTI3Edz7zWAWsKjsOxshmKnqJeWN
         jMIcSWsI/ZbLthna+bmSjFKNwdRUIKKabuvPTjpz2BJNV2BtbjEZiw8x3b3jzsvEq4IJ
         hMJh+POm0N+QhOO4nWQPlSMsSd4zVBfXFnQuADsjiuQwJpG0hxFHeY0yE/biJjX6oKc5
         vyFLDI7cvRz4+PoS5i05XaoBB/3sbYbCRbldQCQMQC6TvgFgyIpOydZQvwpUdFSRnj6Q
         XPtulI5ivqw1fOIAX0c8hsAFbfztlVCPuMJznBscwzWBA7eg963HI/nS5iwsD4iKiEZZ
         C/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=yjMvbywbvK0l3+ZRaEvzSjC6TmNH57nYTu0eyyId+eM=;
        b=g+Ll5LfoIZLAm6zI+waIpFbkB1wpHwRCPKCh867bmhUnX3h09DLwmpU9Rzq6kA8XbG
         Kx8Yvavpr3B7zXCQGmhS8EVzzQNuK0Hp5XYPjFyRkdPZX9ADOzBNhqTOcreOSQ3U6KQN
         TIXdY+42cscvRdMI8xTrjwSiM4OnnIntVLGMq0tty/LdMzKWDzhbJl3hHtAV+p+xK5FP
         lSzkjxKRtgN163okeJv9g8X2iZW/saKXpdyw66gMYNDsfEO+TqLCGjHWI6c2Ov092Dml
         RmUVupTvD1lP066fjzyQL6h95/JmBaLFIkTMa/nORN4LL8vtZfme2ArHu3JMswR/5dl8
         gRhQ==
X-Gm-Message-State: AOAM531T9Lq/fF9rmvOwtWbGeir02EbwN+ZXRyyoZlZc7D9lPlbo9vw1
        tCPQkBw/LzEybM33cFNO8jY=
X-Google-Smtp-Source: ABdhPJzlEbA+0xGpOvakU8e8QJo0bQQs1jWGEGr+mixyUwFaEN1L0Nux8OexoWKvpKWCHt8HS1ereQ==
X-Received: by 2002:a05:6000:128a:: with SMTP id f10mr2933266wrx.252.1628760782296;
        Thu, 12 Aug 2021 02:33:02 -0700 (PDT)
Received: from [192.168.1.240] (188.96.189.80.dyn.plus.net. [80.189.96.188])
        by smtp.gmail.com with ESMTPSA id i9sm2857361wre.36.2021.08.12.02.33.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 02:33:01 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] commit: restore --edit when combined with --fixup
To:     Joel Klinghed via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Joel Klinghed <the_jk@spawned.biz>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.1014.v2.git.1628725421868.gitgitgadget@gmail.com>
 <pull.1014.v3.git.1628755346354.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <e3a24819-9953-0245-7f64-472def4d180a@gmail.com>
Date:   Thu, 12 Aug 2021 10:32:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <pull.1014.v3.git.1628755346354.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Joel

On 12/08/2021 09:02, Joel Klinghed via GitGitGadget wrote:
> From: Joel Klinghed <the_jk@spawned.biz>
> 
> Recent changes to --fixup, adding amend suboption, caused the
> --edit flag to be ignored as use_editor was always set to zero.
> 
> Restore edit_flag having higher priority than fixup_message when
> deciding the value of use_editor by only changing the default
> if edit_flag is not set.

Thanks for fixing this

> diff --git a/builtin/commit.c b/builtin/commit.c
> index 190d215d43b..560aecd21b1 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1333,7 +1333,8 @@ static int parse_and_validate_options(int argc, const char *argv[],
>   		} else {
>   			fixup_commit = fixup_message;
>   			fixup_prefix = "fixup";
> -			use_editor = 0;
> +			if (edit_flag < 0)
> +				use_editor = 0;
>   		}
>   	}
>   

Commit 494d314a05 ("commit: add amend suboption to --fixup to create 
amend! commit", 2021-03-15) that broke this has the following hunk above 
this change

@@ -1170,7 +1206,7 @@ static int parse_and_validate_options(int argc, 
const char *argv[],
         if (force_author && renew_authorship)
                 die(_("Using both --reset-author and --author does not 
make sense"));

-       if (logfile || have_option_m || use_message || fixup_message)
+       if (logfile || have_option_m || use_message)
                 use_editor = 0;
         if (0 <= edit_flag)
                 use_editor = edit_flag;

I think it should have moved those last two context lines that set 
`use_editor` to below the part that you are fixing. Then the `use_editor 
= 0` line that you are changing continues to work as before. (As you see 
there are quite a few legacy Yoda conditions in this file, nowadays we 
avoid adding new ones). I'm not sure if it is worth re working this 
patch to do that, but it does have the advantage of only testing 
edit_flag once.

> diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
> index 7d02f79c0de..a48fe859235 100755
> --- a/t/t7500-commit-template-squash-signoff.sh
> +++ b/t/t7500-commit-template-squash-signoff.sh
> @@ -281,6 +281,19 @@ test_expect_success 'commit --fixup -m"something" -m"extra"' '
>   
>   extra"
>   '
> +test_expect_success 'commit --fixup --edit' '
> +	commit_for_rebase_autosquash_setup &&
> +	write_script e-append <<-\EOF &&
> +	sed -e "2a\\
> +something\\
> +extra" <"$1" >"$1-"
> +	mv "$1-" "$1"
> +	EOF

Again I'm not sure it is worth changing it now but for future reference 
this is a rather complicated way of appending to the commit message. The 
test file has an example using set_fake_editor() together with 
FAKE_COMMIT_AMEND just below where you have added this test or you can 
just have

     EDITOR="echo something extra >>" git commit --fixup=HEAD~1 --edit

Best Wishes

Phillip

> +	EDITOR="./e-append" git commit --fixup HEAD~1 --edit &&
> +	commit_msg_is "fixup! target message subject linesomething
> +extra"
> +'
> +
>   get_commit_msg () {
>   	rev="$1" &&
>   	git log -1 --pretty=format:"%B" "$rev"
> 
> base-commit: ebf3c04b262aa27fbb97f8a0156c2347fecafafb
> 
