Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF81EC433E2
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 18:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDA562074A
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 18:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUiaavX8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgH1S15 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 14:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbgH1S1z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 14:27:55 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFC5C061264
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 11:27:55 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id k20so57534otr.1
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 11:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fN80UYcD7MHMJrEHOMBvSSZ+SxUfK2isCUoTzdejJnM=;
        b=RUiaavX8SbWNhjomhMv8uK1qG0Alj/rkP6cfayQv8ufFNUfm1VYmxyWsa8jyJTZGrg
         ZsIgTBnrzUogi3Ou41/QdROnjFWapNRCvYjn0Aq19+AdK5FhxlB5PXMQkKUwoUZIMNS2
         J5X9Vf929UxRc3zKVRgo37Vp2OjwDLl2B50o8P2gsPeEzX5y3pCGqNJcfwU8lFlSEalw
         H6SROasU1wPW4WkD8DipchNwWv/ukKeDIXBBbapIlwsr9XGq62P4M2CRFilxT3RzmnB+
         hOkkeEJlk10WPyPnMV+50Ir6zWD6gmq+CtPLcSb/Ka+orNaMEEtwGVkgwuki1S3tEWUD
         e+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fN80UYcD7MHMJrEHOMBvSSZ+SxUfK2isCUoTzdejJnM=;
        b=JujZmQH5BavfhNq1PvjsVpfJ5etCOXrLk9ZkgGUDwQl7eh7iuC79OdsYDQ1HXHd1lB
         ayaHHuAdOH6e4AbAoGDn4QZV7YjffNTvy+0EO2FhiUYTEHdWMkWG7SrfrbbOkZgWHXb5
         pEiRfOLVmOAiNi0whHo5mKnt6x1JhBSEev6huKZL12kW+FS+TYGxJIdpJhAUxHp1LUBs
         19rJmBUnLMjgdmz+EXthDtWGtSjjJNK7mqFQ7d/Y/Zuw63TS1y7vrDhRerwJKcmOdnh+
         YevKx7DT0wi/mYjinFRiR9V/1rBJ6jvrWA5D/oeFig1Cu5kMqj6vGU0SsTzjuZzs21q0
         2jSA==
X-Gm-Message-State: AOAM531iqYDmcDins9IGXQFCnnFobTucgywiuyDUdaYHU5Uc5sx5eYKm
        BHrvim3qOVNBXFSGuyoOOck=
X-Google-Smtp-Source: ABdhPJzBowEz236DxTrHDC24FfuNbZIHFgrBQTz8O4pg8waj3kJpF6bvkKwOLSYLWqzY3Gh9c1FTQA==
X-Received: by 2002:a9d:734a:: with SMTP id l10mr2059539otk.240.1598639274824;
        Fri, 28 Aug 2020 11:27:54 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:b1a6:3982:6cb3:22b6? ([2600:1700:e72:80a0:b1a6:3982:6cb3:22b6])
        by smtp.gmail.com with ESMTPSA id j76sm4335oih.17.2020.08.28.11.27.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2020 11:27:54 -0700 (PDT)
Subject: Re: [PATCH] midx: traverse the local MIDX first
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
References: <20200828180621.GA9036@nand.nand.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9a599bb5-fb6f-1e35-6e02-d62703ebc420@gmail.com>
Date:   Fri, 28 Aug 2020 14:27:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <20200828180621.GA9036@nand.nand.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/28/2020 2:06 PM, Taylor Blau wrote:
> This invariant is only preserved by the insertion order in
> 'prepare_packed_git()', which traverses through the ODB's '->next'
> pointer, meaning we visit the local object store first. This fragility
> makes this an undesirable long-term solution, but it is acceptable for
> now since this is the only caller.
> 
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
> This is kind of a hack, but the order that we call
> 'prepare_multi_pack_index_one()' from 'prepare_packed_git()' makes it
> acceptable, at least in my own assessment.

The natural alternative would be to scan the list _after_ all are
inserted and pull any MIDX marked "local" to the front of the list.
Such a check would need to happen in the same method that iterates
over all alternates, so that seems a bit redundant.

While perhaps a bit hack-ish, I think this is a sound approach.
And, we have a test that will detect change in behavior here!

Thanks,
-Stolee

