Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1166F2013A
	for <e@80x24.org>; Wed, 15 Feb 2017 18:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752710AbdBOSO6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 13:14:58 -0500
Received: from mail-it0-f50.google.com ([209.85.214.50]:35905 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752314AbdBOSO4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 13:14:56 -0500
Received: by mail-it0-f50.google.com with SMTP id c7so71776853itd.1
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 10:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eLjhx1Q4Y3s1gF+/7HGWXLRoU+EkcTXsP8qZv4IfGlg=;
        b=ln9kuiX0EuNe6jhdBsH8/4ce1bpZpyuh0+t46eNThUmoaXX7wgzJc4CMyTHZfHDe6d
         VQkjnHEH/luKgWAiskmgY/OpdCafiXjtVoRb9Y/X4B4yQkmer1ZrN/Uk6B55CXAqCZb+
         nmDzclW8nB+WDO/vLYIfLPUp4BCB0X4qiYQYp2aHv7xdcb3Tp70pqvrq8DMvc+DwNKEp
         0cQRH5SgGxU1S/ln9+bsgkL+2f7xUdrI1UKtvTdOpikfI5NTsxMW2exzf1RC5yevzXu3
         rJ7RlGMkEpwerDvKt+MSQmwFvkSrQPuViPgX9VUqy4kSE0CU9myW23/FWHppkMcx4lge
         bRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eLjhx1Q4Y3s1gF+/7HGWXLRoU+EkcTXsP8qZv4IfGlg=;
        b=oVP6uXKwWApxP9C8DWfhvfkkxlB96SRVR1ZqpgicHqprk3BRAk7uilIBjI2NKjkQke
         82fWba4vmbUQ7c+qqv2mtYHKYldGZm4hZF1mhXDM15vECO829lGRc8MKSPhaM/yAePuf
         nJSr2R77Qsr4J5gciYVrw7Fny4yNi745EaGsk+ubCCLgp00KwgyP++pzLr5JLoHbgAgd
         8Jf3zxQ1G1AVQ90YOgtWeEH0xtALpqMQx9TX2y4kg/hifmR73eH96LxjpYoT4+J4uZK1
         4s4sdRF/sekBX6m66dxBfeELEzdpXwd/FS9XxaBNiETF3OfX5LLirjRDM3X3ws+AKFnJ
         GBqw==
X-Gm-Message-State: AMke39l4jgayM3ALkQ75XVbTrEwl0q6HvBLwk1MLJUmvw5jQNlNAf01dXOvjpmGA0S0it+jHO4AMp80MSfjU31YA
X-Received: by 10.36.40.198 with SMTP id h189mr10136969ith.114.1487182495276;
 Wed, 15 Feb 2017 10:14:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Wed, 15 Feb 2017 10:14:54 -0800 (PST)
In-Reply-To: <20170215111704.78320-1-larsxschneider@gmail.com>
References: <20170215111704.78320-1-larsxschneider@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 15 Feb 2017 10:14:54 -0800
Message-ID: <CAGZ79kboUB=1NRDw_=yvUhm4US-TtfyNA5uu4XetkXAEfkBr+A@mail.gmail.com>
Subject: Re: [BUG] submodule config does not apply to upper case submodules?
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 15, 2017 at 3:17 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:
> It looks like as if submodule configs ("submodule.*") for submodules
> with upper case names are ignored. The test cases shows that skipping
> a submodule during a recursive clone seems not to work.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>
> I observed the bug on Windows, macOS, and Linux and at least on
> v2.11.0 and v2.11.1:
> https://travis-ci.org/larsxschneider/git/builds/201828672

Thanks for the bug report.

>
> Right now I have no time to fix it but I might be able to look into it
> next week (if no one else tackles it before that).

I might look into it before next week.

> Notes:
>     Base Commit: 3b9e3c2ced (v2.11.1)
>     Diff on Web: https://github.com/larsxschneider/git/commit/a122feaf9f
>     Checkout:    git fetch https://github.com/larsxschneider/git submodule/uppercase-bug-v1 && git checkout a122feaf9f

I like these notes, though base commit is duplicate with below.


> +test_expect_success 'submodule config does not apply to upper case submodules' '
...
> +               git submodule add ../UPPERSUB &&
> +               git commit -m "add submodules"
> +       ) &&

up to here we only do "setup"-sy stuff.
("setup being a trigger word that you cannot omit
the test for subsequent tests to work)
So maybe have
    test_expect_success 'setup submodule with lower and uppercase' '
    ...
    '
    test_expect_success 'just the clone' '
    ...
    '
    test_expect_success ' check for lower case'
        grep -e "Skipping submodule *lowersub*" err
    '
    test_expect_failure ' check for upper case'
        grep ...
    '
> +       git -c submodule.lowersub.update=none clone --recursive super clone-success 2>&1 |
> +               grep "Skipping submodule" &&
> +       git -c submodule.UPPERSUB.update=none clone --recursive super clone-failure 2>&1 |
> +               grep "Skipping submodule"

I'd rather give both options in one invocation and then grep from a file, e.g.

    git -c submodule.lowersub.update=none -c submodule.UPPERSUB.update=none \
        clone --recursive super super_clone 2>err 1>out &&
    grep -e "Skipping submodule *lowersub*" err

> +'
>
>  test_done
>

> base-commit: 3b9e3c2cede15057af3ff8076c45ad5f33829436

Heh, I see what you did here. :)

> --
> 2.11.0
>
