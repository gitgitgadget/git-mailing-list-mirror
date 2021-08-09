Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEE0C4320A
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 19:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E63E760BD3
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 19:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235656AbhHITLm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 15:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235487AbhHITLm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 15:11:42 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864B5C0613D3
        for <git@vger.kernel.org>; Mon,  9 Aug 2021 12:11:21 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id a20so17646564plm.0
        for <git@vger.kernel.org>; Mon, 09 Aug 2021 12:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E1seFjOdjfXedtOJwIoHb9Hu47D8yX2ZZgGkCwMRnr0=;
        b=HbYqFU82WmqGWhxmW3rFrUpiCCAsKzOtRwyDoeHnIMzFk4rcbXAMf79+QNGDmzGolF
         lmwLVvLahUk17rV6Ph21an8j6Q67TxpdZJZVhkNVQg/Xz7shZgi59t9cq54zXNgSOnis
         oB9bWU8gI8tw8lwjyDHnMbDunJZU9Mf7aeWcPKT93OFmHu7MJOGQqgMW1a97E/0kTsVv
         UAR+Ytv0zcbrsu9BKNPJcDrT0by5doOCICrJxMV0rYVUxntsK5blJCg3bAwMPT1cA+Uq
         TKPD/6+00PB47MbpMpfiqPyXcaNRSvU+sb/eYbAX2wfUEx8wdgDjBZiuHau1lZgExO+E
         aoRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E1seFjOdjfXedtOJwIoHb9Hu47D8yX2ZZgGkCwMRnr0=;
        b=DRM43Cej7Z1y4dvPWCbPc1QFNW7RcMJI5WmLiyVSIjYoZ2AZk1XKzWTk0Thn4ntdaq
         rCKOwMVvCvy0xIAoUOXR0QS00j5dHkcDOn3sW1vxik3zSCSem6Eyf+7OJCnlH6bZh/Ys
         G6g79DURJvJTDVj6lgu9nMfLjcAV1h6La+Q4NgOEvVcOvDfTW1RJd5sDrBOVhDdRbMpL
         SIHSpXSSdvDhMzaru9ayhFi/CRZ9JYB6N47Sq+scSgNFd2uY0mwADm2mQVj9KIFI4BCD
         SvvDLaS7qbS6Tmy5WAxM4iW4CUbJs3lhW63+nNvU+rX8J+IxKp3IbjsUsGwMxTlTWtA7
         Eu6g==
X-Gm-Message-State: AOAM531iTuAGv1Ez8WvBXT5lPxxuzBsoNEVL6SczKY8a3VzBSQ1qb3R4
        S4i2fFdT1udbtM3d+9Y0hnQ=
X-Google-Smtp-Source: ABdhPJyMSfwNg3X7wG/VbMNkMeBwsc6kGIKW9HxZ1Fz5NQR/F6mWXt5eQ3b2rs4SbvzIR9jjG5uo5w==
X-Received: by 2002:a17:902:bd81:b029:12c:b6fb:feef with SMTP id q1-20020a170902bd81b029012cb6fbfeefmr22042237pls.84.1628536281089;
        Mon, 09 Aug 2021 12:11:21 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:4d74:2fd5:acb7:59ca])
        by smtp.gmail.com with ESMTPSA id n35sm24566908pgb.90.2021.08.09.12.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 12:11:20 -0700 (PDT)
Date:   Mon, 9 Aug 2021 12:11:18 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] transport: no warning if no server wait-for-done
Message-ID: <YRF91qCi+c7csUxM@google.com>
References: <20210806214612.1501980-1-jonathantanmy@google.com>
 <xmqqh7fyfrtl.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh7fyfrtl.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:

>> -	if (finish_command(&child)) {
>> -		/*
>> -		 * The information that push negotiation provides is useful but
>> -		 * not mandatory.
>> -		 */
>> -		warning(_("push negotiation failed; proceeding anyway with push"));
>> -	}
>
> Perhaps like "optional ancestry negotiation failed---pushing
> normally" or some phrasing that assures the users that pushing
> without negotiation is perfectly normal?

The question is what the user will do with this information.

Will they contact the service provider to ask them to turn on push
negotiation?

Will they turn off push negotiation because they don't want to waste a
round trip?

Does what they will do depend on _why_ push negotiation failed?  If it
failed because the server didn't declare the capability and the user
has set push.negotate to true to represent "I want to live in the
future by using push negotiation wherever it's available", then the
message is noise.  If it failed due to a bug, then the message is more
relevant to the user --- e.g., should we use a different exit status
to distinguish between these two cases?

Thanks,
Jonathan
