Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7702C433DF
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3988D206B2
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qCxsM/3O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgHFR6b (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbgHFR6a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 13:58:30 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF58EC061574
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 10:58:29 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id z11so2954369oon.5
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 10:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V2CBkgi2h2VdvmjeVPymCYyjXBiZ4dllun0z2TsBbMg=;
        b=qCxsM/3O3fvDERmJSqMlm1B9BypN6Te9JrQ5XFxjk/9Rhd8p1SsAfYi7KchZmptqJl
         uxbbX9gRHwCSJzbU+La6O7JTU+ZRnetedkNgObHnGD/KC+gxxmZzj0jVf3e4AZIDIsR8
         rgrCwdS3oDKnfPkC+l47ig8HL9S0xq6692wCUPcYgQ2aax9NcNfUTO1CZ87nfmn60+3Z
         M5p3Y2nsIBdzTE2RTxogYO7ZJgj+WedGNHmRpH+nt3trA1aWkwLz5kBFD846dpyzOrsp
         BVNHjSmXyYp37mSi+/rK/CVYVNs+KwItcugxnU39ekzKxU1RmEXxhOrBwXHPAon1DTqj
         pWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V2CBkgi2h2VdvmjeVPymCYyjXBiZ4dllun0z2TsBbMg=;
        b=JpujIjMDp91faExwBanvuXUj+7mkEYwfERjdRqGMZpe1/Ung4Iy2maBhLYjxKG+FCY
         wIPIGY6ECm6V3Gp5OmyW1dxMVqzrL2XsX03hxw1FcJ1++mNGef+L9BUm5DPLXcKAxFrH
         9JwdAsUOxlS2KhTFxaUErJIrHiYnjpqRdg2DmmX97fhX999Lsw5onL2+CeEDOshCi2Xw
         llW3z8rS7VDx0fF5OMaseIKkETl7kpodIxdrX/iod07+gn2fAmN5q8boUhbcTPnAAO36
         ijdj+TAvrg9VAm5I4d77rxC45257LN34z9p3VVO3EyIjODdKkiAmD6n799PM11Yt0X3F
         hP8g==
X-Gm-Message-State: AOAM531axQu5PZgEpBQ1b1B2mSpPob+nkr2xt4Rm6wcyDV9+cY4I+XKV
        kcqXWWQjMsym7rYHG24DwDk=
X-Google-Smtp-Source: ABdhPJweKxhky2fLQS1QQEDho6y/okI+YYt69CZur9RM3oDoYTuGA89sE5I9Nyn36cBVbfh+Uf+a6g==
X-Received: by 2002:a4a:92cd:: with SMTP id j13mr8871249ooh.70.1596736708703;
        Thu, 06 Aug 2020 10:58:28 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:adee:5243:22a7:36c0? ([2600:1700:e72:80a0:adee:5243:22a7:36c0])
        by smtp.gmail.com with ESMTPSA id u204sm1341203oif.36.2020.08.06.10.58.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 10:58:27 -0700 (PDT)
Subject: Re: [PATCH v3 00/20] Maintenance builtin, allowing 'gc --auto'
 customization
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com, Derrick Stolee <derrickstolee@github.com>
References: <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
 <pull.671.v3.git.1596147867.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <43187293-cbc1-84e6-df5c-6970ac25e72b@gmail.com>
Date:   Thu, 6 Aug 2020 13:58:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <pull.671.v3.git.1596147867.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/30/2020 6:24 PM, Derrick Stolee via GitGitGadget wrote:
> This is a second attempt...

Just chiming in on this version to point out that what would
have been v4 of this series is now split across two series:

[1] https://lore.kernel.org/git/pull.695.git.1596728921.gitgitgadget@gmail.com/
[2] https://lore.kernel.org/git/pull.696.git.1596731424.gitgitgadget@gmail.com/

Thanks,
-Stolee
