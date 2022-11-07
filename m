Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD2FC4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 20:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbiKGUPZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 15:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbiKGUPL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 15:15:11 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526982BB35
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 12:14:43 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id j6so8874604qvn.12
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 12:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JZUHQe2VWhU7eyTaQ9zhllZ6jjzSnVyCjoIDzoY1x8Y=;
        b=ezwujNOvO4h37EODxdbIMoJ56T1GQeqg8QGqIhbVKSm88odzDivlXeOhcbxgjyP4lw
         YV1LxzqDg08xEE1aeKdpiOfmJnbcx+A910sdLPwolA78GXmJ7exiN3dxkbid/znRZzbA
         imrmJb6uPpcUKR4r4DEyPpctAt/Y02fHtXwO/0f96lVDAfX1vG2LnoVLJkJyJ+v6Lj3j
         sCAuZDlzCfitODlWBCfIdKFefprC5PauIPVU79tsC+y7Wcy/eo3S5YQ1p+FlN6g4Nfo8
         gJw5vyTU71NM5jsXmg5nvgq1q6tlL6A5AzzQQ9EkKeIv+R5CKsEpASWJ5PGZGSE9dFw3
         K7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JZUHQe2VWhU7eyTaQ9zhllZ6jjzSnVyCjoIDzoY1x8Y=;
        b=MN6ZtngJClRCcJCpvKqYM9NOoU748sy88Px/ZQ2Ie0a48fa4Y/qUKDHFnp5SE6okDJ
         PsKb/wKT+qJOE9rHOKoAtPOqfXTa+g0jkfxBiBdKwCrC6STfcoMKRn3Qyqw5QCBylqrn
         jQj4hRqYOzsZGYnZiQi0Cn8ycnDSMV+/sD+TosCb8J8BTozcCnDVQ5Ie5jMg6phrQkTJ
         uL4g5txg95han3udrDla9QUpWdfCMRJQ5pmTKOvnmGgX+3ZquHus/9x0mKt/WT0fqnuL
         Ou1S09OSezgrkXiIfo7CtIuXmGrYcUC+ldbTnAS43A63xMYY6weXUitTcMoTwFk+A3lH
         XU6g==
X-Gm-Message-State: ACrzQf0dvtAd2voDPWQerqwQ1jbN8IulPGW8Vg826b6SjPmN/ME46j5V
        d/D5fcOJL5ICk2dQqJEs46fJr6nm0zRX
X-Google-Smtp-Source: AMsMyM7Vu8EyRhp9csuPxIZdCdcl0vD77hZDlyLpNw0yiX+wFlvAED9F8VweYjulsbTUTsphgIvAhQ==
X-Received: by 2002:a05:6214:29cd:b0:4bb:6b5b:a0c3 with SMTP id gh13-20020a05621429cd00b004bb6b5ba0c3mr46920517qvb.10.1667852082348;
        Mon, 07 Nov 2022 12:14:42 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:d948:f30c:63de:b667? ([2600:1700:e72:80a0:d948:f30c:63de:b667])
        by smtp.gmail.com with ESMTPSA id k1-20020ac81401000000b003434d3b5938sm6690129qtj.2.2022.11.07.12.14.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 12:14:42 -0800 (PST)
Message-ID: <8e4a8817-4fd5-d7f3-2c7d-bf23e61b9823@github.com>
Date:   Mon, 7 Nov 2022 15:14:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH] scalar reconfigure -a: remove stale `scalar.repo` entries
Content-Language: en-US
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1407.git.1667845501422.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1407.git.1667845501422.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/7/22 1:25 PM, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Every once in a while, a Git for Windows installation fails because the
> attempt to reconfigure a Scalar enlistment failed because it was deleted
> manually without removing the corresponding entries in the global Git
> config.

Not actually important to this patch: does it actually fail, or does it
just report a warning message (which _looks_ like a failure)?
 
> In f5f0842d0b5 (scalar: let 'unregister' handle a deleted enlistment
> directory gracefully, 2021-12-03), we already taught `scalar delete` to
> handle the case of a manually deleted enlistment gracefully. This patch
> adds the same graceful handling to `scalar reconfigure --all`.
> 
> This patch is best viewed with `--color-moved`.
 
Thanks, that did help, even if it's a small change.

> @@ -638,8 +656,22 @@ static int cmd_reconfigure(int argc, const char **argv)
>  		strbuf_reset(&gitdir);
>  
>  		if (chdir(dir) < 0) {
> -			warning_errno(_("could not switch to '%s'"), dir);
> -			res = -1;
> +			struct strbuf buf = STRBUF_INIT;
> +
> +			if (errno != ENOENT) {
> +				warning_errno(_("could not switch to '%s'"), dir);
> +				res = -1;
> +				continue;
> +			}
> +
> +			strbuf_addstr(&buf, dir);
> +			if (remove_deleted_enlistment(&buf))
> +				res = error(_("could not remove stale "
> +					      "scalar.repo '%s'"), dir);
> +			else
> +				warning(_("removing stale scalar.repo '%s'"),
> +					dir);
> +			strbuf_release(&buf);

Looks good.

> +test_expect_success '`reconfigure -a` removes stale config entries' '
> +	git init stale/src &&
> +	scalar register stale &&
> +	scalar list >scalar.repos &&
> +	grep stale scalar.repos &&
> +	rm -rf stale &&
> +	scalar reconfigure -a &&
> +	scalar list >scalar.repos &&
> +	! grep stale scalar.repos
> +'

In his reply, Taylor mentioned it would be good to check that we
still have the correct list of scalar.repos value. I think that
might be critical since one "solution" to this problem of a stale
repo could be to remove all scalar.repos values (and this test
would currently pass).

Please use a `test_cmp` against scalar.repos. Something like
this works:

test_expect_success '`reconfigure -a` removes stale config entries' '
	git init stale/src &&
	scalar register stale &&
	scalar list >scalar.repos &&
	grep stale scalar.repos &&

	grep -v stale scalar.repos >expect &&

	rm -rf stale &&
	scalar reconfigure -a &&
	scalar list >scalar.repos &&
	test_cmp expect scalar.repos
'

Thanks,
-Stolee
