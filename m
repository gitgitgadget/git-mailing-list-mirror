Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4193EC433E0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 14:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFB6D64FEF
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 14:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbhCKOsb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 09:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233698AbhCKOsZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 09:48:25 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76F9C061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 06:48:25 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id 94so1286249qtc.0
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 06:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pTPh+osYuJZ+xrKPZcEYOHls3R86KKaYV0vp4Y66qHg=;
        b=mjlmcglEm1MIy4lbHZCyGf2lLxmUfE/Kj0lMI+TWtQ4LWTFtvF1Ukhnv72xyOcU+3P
         pbJYU521N6lCv4W6mNx7SVSXtaVFNq7cy12NidG9TLp3yx6n7+ZXr9rTKI0tJOsylGhh
         wkh6I1uhni5byGLOebP85OCcb97ppaMLuHbr+DzBlWA/Vz55H+zXfEKtvPxJgoqjkzMI
         A8PLpzgpGmiyGfeoNDtNjfjwLNhX2V1c5nhX51B2W5vtP3f7pk/kiDihyiStS2sBwPn6
         phfVIun5XGIYUOZNfc6Se6VWFwrPAXeucBSsDOM5M+1QqKI/e3ErCVrVWiTIbyARVQAH
         lP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pTPh+osYuJZ+xrKPZcEYOHls3R86KKaYV0vp4Y66qHg=;
        b=gfnnIL8U3AAhOe0Oe2aPUsfcSirns1sEjWR3vJkce2O+SI1598+lAd3vcXdF2SCgjj
         qrjKR1jR3x3YEDgeD9FFpgS35GujOUophuXrPRk3GWfFVvZedaGcjPiGwwzpp9CgDmHo
         q5EGmJWBLNA9emAP1O4tR7eLgpBV6ymGbRnMfUvPLgRATfpFdPBdof3RU8Ec1mLJRU5k
         eOGAgZ6we3Qgnn5AtFhPU792gwGS0jbWEaVEomFkRIpgC1lClbh+UxMhjyS2EKmR8kXo
         CfEOuZfL1hyxSNHPWVd/JJiqI9aMNsYMWC9sv/4PTIqAiHbF3go15Xu+b3J4TU/3zytn
         HxIg==
X-Gm-Message-State: AOAM533FFi9QeHeHcqzSoenmTJB+lBkNzoTbJf7yo0xGHrUK7LN8IOh/
        +xnwYRa+M/b9rd7lVngkBd8=
X-Google-Smtp-Source: ABdhPJzEbnzrkwt4VZqRQ1+H6GuYFeW99yyq1O3jCttJtglNRIrA+BxiIYDnrK+r7UBdysQm4zLZWQ==
X-Received: by 2002:aed:2641:: with SMTP id z59mr1504178qtc.328.1615474104785;
        Thu, 11 Mar 2021 06:48:24 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:6d39:6117:2464:aeb7? ([2600:1700:e72:80a0:6d39:6117:2464:aeb7])
        by smtp.gmail.com with ESMTPSA id t6sm1919677qti.2.2021.03.11.06.48.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Mar 2021 06:48:24 -0800 (PST)
Subject: Re: [PATCH v2 02/10] merge-ort: add a special minimal index just for
 renormalization
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
 <pull.973.v2.git.git.1615271086.gitgitgadget@gmail.com>
 <24454e67b186992b9ef7a8ac6f220cbb4aaafd6b.1615271086.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <10b30844-2e4c-157f-b4c6-5e4890e18858@gmail.com>
Date:   Thu, 11 Mar 2021 09:48:23 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <24454e67b186992b9ef7a8ac6f220cbb4aaafd6b.1615271086.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/9/2021 1:24 AM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> renormalize_buffer() requires an index_state, which is something that
> merge-ort does not operate with.  However, all the renormalization code
> needs is an index with a .gitattributes file...plus a little bit of
> setup.  Create such an index, along with the deallocation and
> attr_direction handling.
> 
> A subsequent commit will add a function to finish the initialization
> of this index.

Is this the best way to solve this problem? Shouldn't we extract the
logic that interacts with the .gitattributes file from
renormalize_buffer() (say, to renormalize_buffer_attributes()) and
just pass the .gitattributes file instead of creating a fake index?

It probably moves more code to do it the way I recommend, but it
helps to separate the concerns a bit better. Of course, I haven't
tried doing it myself, so maybe it's harder than I think.
 
Thanks,
-Stolee
