Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6765E1F51A
	for <e@80x24.org>; Tue, 15 May 2018 01:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbeEOB2M (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 21:28:12 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51270 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752031AbeEOB2L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 21:28:11 -0400
Received: by mail-wm0-f65.google.com with SMTP id j4-v6so16579559wme.1
        for <git@vger.kernel.org>; Mon, 14 May 2018 18:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=d9ok+lYWHyQIQ9tn2sacBuJWRUOBToUS2MYe+opERFg=;
        b=lwFRpWv1wYYWMuTfWvZVHb5IlVADDiv+tqGzzrNDGcrszgb9IlJxHtHBBLSAhUamSq
         7/YloDga99XmjOcMNugTjlRKk2YhqHwi8LjEym4S5XnJV0OuDqOte4V21K9oZ5+YO61c
         HGY6iNGLGCfMdZ/0Wi+fd0VQ3fxmVIccrc9hk0P/FfIRU+eZ0pxBbWjI+jvCvldjL9QM
         BlMiiUIAcpd9DLNlqTNnKO7qsiEU5X1WO2cTw/9HUS9FIR9Su/empoRhB+QzEF6WYaLB
         nbEqllLPw5EMGH6NmO/WarAKw3U2+2siu3gkVJFAI8GYga8zUtzVPeuwdP9EWdPsVfns
         spXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=d9ok+lYWHyQIQ9tn2sacBuJWRUOBToUS2MYe+opERFg=;
        b=ZOvV4O2pYECk3y12cjyywaSfMcePK7mbSkJ5wxgfQ0tqzpFCwaZuMU8DLgd7ETgSTl
         woVkM8uhwKviXw701ACoGJUiKUSL45Y9aTyLeWGPrvWLelmvjzYdysOS+mn9bWhhLry5
         babQbkPJ34gcrEBRkqzMyUSylYdcoXVa6P1s0PavCvAT5SagcPmTPXtNDZgFP0YSoiWW
         DR/+OiGZffHKEgErpI5FVJigtawyac70lrPFwatl4tIyyjg9rmLFfNpy4oLP2uSn5BYP
         lmcLEbnpGrO+PlszJEJ0JlOZetbBQG0pHVFBwpmkMNgg72dlsRavD/Ws1LnPfT2bCkHW
         4anw==
X-Gm-Message-State: ALKqPwfDP5URxUFCrnNikj5q3yRfZszLsI8K50f6vZraeWX1F0JLEiHx
        6Y7TGUXFQ0UAEfs9TpWTCFk=
X-Google-Smtp-Source: AB8JxZpfHo8hctbNWtDRD6k41c1kAEu5RgW+gdOBGj5wkLWdvRBsNG0YjzbOJRamOPiisxwfTa5VDQ==
X-Received: by 2002:a1c:92c4:: with SMTP id u187-v6mr6459612wmd.78.1526347689526;
        Mon, 14 May 2018 18:28:09 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b133-v6sm12671859wmh.12.2018.05.14.18.28.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 May 2018 18:28:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v1 1/8] fetch-object: make functions return an error code
References: <20180513103232.17514-1-chriscool@tuxfamily.org>
        <20180513103232.17514-2-chriscool@tuxfamily.org>
Date:   Tue, 15 May 2018 10:28:08 +0900
In-Reply-To: <20180513103232.17514-2-chriscool@tuxfamily.org> (Christian
        Couder's message of "Sun, 13 May 2018 12:32:25 +0200")
Message-ID: <xmqqmux1aes7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> The callers of the fetch_object() and fetch_objects() might
> be interested in knowing if these functions succeeded or not.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  fetch-object.c | 15 +++++++++------
>  fetch-object.h |  6 +++---
>  sha1-file.c    |  4 ++--
>  3 files changed, 14 insertions(+), 11 deletions(-)

"might", but nobody pays attention to the return value, as the
local availablity of the object at the end is the only thing that
matters, so at this step, it is not all that impactful a change.

Let's see how it plays out.

>  			/*
> -			 * TODO Investigate haveing fetch_object() return
> -			 * TODO error/success and stopping the music here.
> +			 * TODO Investigate checking fetch_object() return
> +			 * TODO value and stopping on error here.
>  			 */
>  			fetch_object(repository_format_partial_clone, real->hash);
>  			already_retried = 1;
