Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E807C433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 03:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbiKHDAK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 22:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbiKHDAH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 22:00:07 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97C8B7EB
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 19:00:04 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id n191so10487295iod.13
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 19:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aTw6bpWE+Gt0orScUxngVgWQ4eE5JQAJKEjI+1ms/cU=;
        b=0+P7sM50j/3ionsS1q8QYrIknm9k3jEliYQABiUVOpy7hOKqJZBwJbeY4HI4yKkdiH
         92dM37+VAvgeXHkjpIUP4aDI9YUBEb37lDObLTTM3BsKfVDFI72u1eiXsi5cJIDoX2X0
         e9bb7HwNBzsvx6DAMxfljIPGFVAMGQyKeYby3RldwPntsG1T1NgVwJlMp0xHgHC1BKFM
         1caARR1o8hP8qCWKC6f5y01TttrYhLEsw0d1cYf8Zh1YW3zcTu5u14G9iu343mGQ9Sxg
         ebAYbZNUE+JJ5UekB6TRuspXmsURPXC2CNdn2aV4TVqXb/euDCUblj8Glvt9IvCt+kv/
         XSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTw6bpWE+Gt0orScUxngVgWQ4eE5JQAJKEjI+1ms/cU=;
        b=SS1bhPlvGFAh5n1xAT4JGBZxn26xp8ok1gE2vyy//uk/s1UEzjx9EHU0v1CY3VLolA
         80nQ2sWsIb0e0MSmS2q1C7dg3xWk7c2luUhKY3J2YPRz6+0TCuVnGVcxSQTzIzuQgD12
         I5imrHkeXtVOFTuhryvHbh/fXuq19HFmDVcQW7/vUcnAO5W4YBaBRD2FHNp9FjMfhH++
         4nAkEhce7kATv9REUaZSm70OiFVE5shw6JeVkTDEO9TBRK4rgykLUOTCVKiP6uUdL9Yy
         jdE4+VRfL8lwZMQEq9+me9XI4yTjo2LhN/KuFhhvS0LH8G2gie754Q5/7oDqKDst3L7T
         H3Yw==
X-Gm-Message-State: ACrzQf0iAjIg4/H+IwP3/Wm6xdhq2nMsMqgQ3H9QMp9EyDMW8PqsD0OS
        gVu3RJKN0M/bIyJnbyxshO1Afg==
X-Google-Smtp-Source: AMsMyM46LqgkB8TkxH4LrHYS4kZ+lh144cwaZkhJBr+94jVGBxtiUCExEHhVx1lyEnM9cZlyv4gOhQ==
X-Received: by 2002:a05:6638:3802:b0:351:d8a5:6d58 with SMTP id i2-20020a056638380200b00351d8a56d58mr33167793jav.206.1667876404067;
        Mon, 07 Nov 2022 19:00:04 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v14-20020a056e020f8e00b002fa9a1fc421sm3410518ilo.45.2022.11.07.19.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 19:00:03 -0800 (PST)
Date:   Mon, 7 Nov 2022 22:00:02 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Alison Winters via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Alison Winters <alisonatwork@outlook.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Subject: Re: [PATCH 0/2] add case insensitivity option to bash completion
Message-ID: <Y2nGMquKVz4vDNDS@nand.local>
References: <pull.1374.git.git.1667669315.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1374.git.git.1667669315.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alison,

On Sat, Nov 05, 2022 at 05:28:33PM +0000, Alison Winters via GitGitGadget wrote:
> Alison Winters (2):
>   completion: add optional ignore-case when matching refs
>   completion: add case-insensitive match of pseudorefs
>
>  contrib/completion/git-completion.bash | 51 ++++++++++++++++++++++++--
>  t/t9902-completion.sh                  | 32 ++++++++++++++++
>  2 files changed, 80 insertions(+), 3 deletions(-)

It looks reasonable to me, but I'm far from an expert on the completion
code ;-).

CC'ing some folks who are going to be more familiar with it than me.

Thanks,
Taylor
