Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BC4C636D3
	for <git@archiver.kernel.org>; Mon, 30 Jan 2023 18:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236733AbjA3Sn0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Jan 2023 13:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236294AbjA3SnN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2023 13:43:13 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C494CDBF9
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 10:43:11 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-15ff0a1f735so16270613fac.5
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 10:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GYF52DYhlVCWYr9FbAq4nr655m6e0d7aSmrh0tWgA0A=;
        b=CGJZguPKAP3V8J2eHouAaaKxgc2ilAl9SXGWZJAaTgMRmjiKTJo1OZvsz7+WKfsnf3
         WWt0CMwghC7LmbGHTVBqWanGeNkSM88QXoc74sZSZF/7XetZ5hCOJAI7FxCDvtm0KpJd
         9gy8k6+a7lg0y51HcAzJeHaAZkXFm+uDqRigDNkQebNvUO0C0bEWjCBGGtx5Xmq8tre1
         wtKAP2c28XbqXSFkt0dUwfZshfykgB4U4a5y+6mXQyjR1q/2TcmoDCaDW/2ulhMZlg4t
         XO/8UV6CWlbnY9r3UL55wTJX8Pz7mlT70BhyVczCFEeFpRiChZv8Qgt4u95sEhnpJ8sH
         fUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GYF52DYhlVCWYr9FbAq4nr655m6e0d7aSmrh0tWgA0A=;
        b=qQYdLLApujc5YnzoaJPoso1VH69MAph2oGEjMtuiItoQ51QCaYyB8Qf0vxOBX0SmK7
         Eg8LejXWh57L0HMJdrAkiL+jpVLISlCL6hACTviAfiaOTuG+EQc6rPnVOaMjVWA9Zqnl
         NJUF7Hdv6NCKlBliWiEmxqINHVfR0g8NKZLiTq7AUf2FbuwZZQeIOkDDoybuoHZkBVov
         /wgObkTmif8BDZeLv9tHUqFSCTAXgi3/1tNcGVDtz6WlYbSp65/lG1SqANwETISqXibF
         fdALyuNPTkTtBvpFRCq0de1IdtGI5vbiUADauyubK1eP3nnIb4xNpZb3Hhmomx0kOKN7
         pBrQ==
X-Gm-Message-State: AO0yUKVcm9GrmTw/IqemW0IAxrWvoxr0tTXpbhnjZrCdhrSNlgWAQAmn
        APRgCQFnHJNE2n3MdeTUOX7i
X-Google-Smtp-Source: AK7set/r92topECZxFNUwKlZXOjKs2tjIMV00zqIvLre9xoDw20Xvilbf+h3E6kIEwGwltby60yGsQ==
X-Received: by 2002:a05:6870:b156:b0:15f:3904:6a80 with SMTP id a22-20020a056870b15600b0015f39046a80mr5432600oal.51.1675104191051;
        Mon, 30 Jan 2023 10:43:11 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:ecb7:2dbf:e64c:6f68? ([2600:1700:e72:80a0:ecb7:2dbf:e64c:6f68])
        by smtp.gmail.com with ESMTPSA id ky12-20020a056871404c00b0014c8b5d54b2sm5502765oab.20.2023.01.30.10.43.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 10:43:10 -0800 (PST)
Message-ID: <07c4658e-89dd-0f82-77e9-e7c443f747cd@github.com>
Date:   Mon, 30 Jan 2023 13:43:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 05/10] bundle-uri: download in creationToken order
To:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, avarab@gmail.com,
        steadmon@google.com, chooglen@google.com
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
 <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
 <7cfaa3c518cbedb65c585cc02015bb21ae24e9fa.1674487310.git.gitgitgadget@gmail.com>
 <a2896d5b-f395-68df-1f23-356d0128cb9c@github.com>
 <xmqqpmaz93k3.fsf@gitster.g>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqpmaz93k3.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/27/2023 2:32 PM, Junio C Hamano wrote:
> Victoria Dye <vdye@github.com> writes:
> 
>>> +			/*
>>> +			 * Not downloaded yet. Try downloading.
>>> +			 *
>>> +			 * Note that bundle->file is non-NULL if a download
>>> +			 * was attempted, even if it failed to download.
>>> +			 */
>>> +			if (fetch_bundle_uri_internal(ctx.r, bundle, ctx.depth + 1, ctx.list)) {
>>> +				/* Mark as unbundled so we do not retry. */
>>> +				bundle->unbundled = 1;
>>
>> This implicitly shows that, unlike a failed unbundling, a failed download is
>> always erroneous behavior, with the added benefit of avoiding (potentially
>> expensive) download re-attempts.
> 
> Hmph, I somehow was hoping that we'd allow an option to use range
> requests to resume an interrupted download in the future, so
> outright "always avoid attempts to download again" may not be what
> we want in the longer run.  But being able to tell if download
> failed (and there will probably be more than "success/failure" bit,
> but something like "we got an explicit 401 not found" vs "we were
> disconnected after downloading a few megabytes"), and unbundling
> failed (where there is no point attempting) is a good idea.

I think there are two possible directions we can have when talking
about interrupted downloads:

1. The network connection was disconnected, and the client may want
   to respond to that with a retry and a ranged request.

2. The client process itself terminates for some reason, and a
   second process recognizes that some of the data already exists
   and could be used for a range request of the remainder.

I think both of these would not be handled at this layer, but
instead further down, inside fetch_bundle_uri_internal()
(specifically further down in download_https_uri_to_file()).

Any retry logic should happen there, closer to the connection,
and at the layer of the current patch, we should assume that any
retry logic that was attempted ended up failing in the end.

Does that satisfy your concerns here?

Thanks,
-Stolee
