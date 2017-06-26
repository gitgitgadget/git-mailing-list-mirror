Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24327207D2
	for <e@80x24.org>; Mon, 26 Jun 2017 17:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751381AbdFZR0F (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 13:26:05 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35746 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751101AbdFZR0E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 13:26:04 -0400
Received: by mail-pg0-f68.google.com with SMTP id f127so917469pgc.2
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 10:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=67rldIPsPHLdkaYQFt9+ZX5uyTbEXxDNwrXChCcyFrk=;
        b=NDp1XQYpObTqZ49CD00iTcnuJsXSZJ9UehXW5zuVRgNZZBUuQ+q2v6Wvnv+DTZyShM
         k0fn0FzSYmBgfJsYYPAd1MljhKaVoufYEyT7J17netGcKH7ExKUd9ayCOXbkRDHv2pXP
         lpvXJ5QPNRen9A+EwOy234kzPNpEuhDa9IKGtNd/wDfUxGJ/H9Xwh5yt//pih0pF2Eze
         JWYKv+pMv17GQE71rvsdwFpDZ6REP/WNwYgfclfAitZFKXy4Db88eT6Xj5KZkhV7Dr4N
         xALAxw8Ig1TPeCQt9mOysT/bFDCxAzxyQVU8lb8AlgwfNNDq9INnjtjXGW5jJmNnE5u9
         Tsvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=67rldIPsPHLdkaYQFt9+ZX5uyTbEXxDNwrXChCcyFrk=;
        b=mMXGy1R51id/bV2YoNNrOKces0SQtq/kAN/jrxzRVlTqk9RAcbi8Yup/39PPKREmVw
         B6I+6cUJ3lL+EwvCuPElCUJnizs+PvHMwzPuydXZtCHBlE3CM4zXiDOhBxoZR/BPo/JZ
         opiSjZMcDq9P0v2UBcOZ3yd2Tb2BC6KZRLF3lmuratug2kamgq5o2LG47YG+nWdVRq2X
         K4UqgbIEIVi9k/yVyRbpxbkN/pnapeEjw1HZMhcXbzaFoNeoeF3GNpv4atGxoQgTTM39
         vPQCFEFnXt58k7Gi4BuihlvyRgWHJWKTAmxYLoWbDXDbY8niYJdpx3xTXojVIo6ejRGy
         VJdA==
X-Gm-Message-State: AKS2vOzCVQoYhNel6fJFCGK4mIxpyzpCRLYVE5a/foj4Tl2COXR7r8KY
        qn6IR057KNAMsQ==
X-Received: by 10.98.105.2 with SMTP id e2mr1128452pfc.181.1498497963363;
        Mon, 26 Jun 2017 10:26:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b537:cc1a:8e81:b9ca])
        by smtp.gmail.com with ESMTPSA id 79sm1114631pgg.46.2017.06.26.10.26.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 26 Jun 2017 10:26:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v4 6/8] sha1_file: improve sha1_object_info_extended
References: <cover.1497035376.git.jonathantanmy@google.com>
        <cover.1497920092.git.jonathantanmy@google.com>
        <ad3b02bae9db62400f89f387f0a1bb714e0a432d.1497920092.git.jonathantanmy@google.com>
        <20170624124522.p2dnwdah75e4ngya@sigill.intra.peff.net>
Date:   Mon, 26 Jun 2017 10:26:01 -0700
In-Reply-To: <20170624124522.p2dnwdah75e4ngya@sigill.intra.peff.net> (Jeff
        King's message of "Sat, 24 Jun 2017 08:45:22 -0400")
Message-ID: <xmqq4lv27j9y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Jun 19, 2017 at 06:03:13PM -0700, Jonathan Tan wrote:
>
>> Subject: [PATCH v4 6/8] sha1_file: improve sha1_object_info_extended
>> Improve sha1_object_info_extended() by supporting additional flags. This
>> allows has_sha1_file_with_flags() to be modified to use
>> sha1_object_info_extended() in a subsequent patch.
>
> A minor nit, but try to avoid vague words like "improve" in your subject
> lines. Something like:
>
>   sha1_file: teach sha1_object_info_extended more flags
>
> That's not too specific either, but I think in --oneline output it gives
> you a much better clue about what part of the function it touches.

Yeah, thanks for paying attention to the --oneline output.  Mention
of the exact function name tells that it is about a more options on
information gathering, which is a better title.

>> ---
>>  cache.h     |  4 ++++
>>  sha1_file.c | 43 ++++++++++++++++++++++++-------------------
>>  2 files changed, 28 insertions(+), 19 deletions(-)
>
> The patch itself looks good.

Yeah, I agree.
