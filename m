Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A5CC433E9
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 20:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12EFA23443
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 20:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389694AbhATUNp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 15:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389548AbhATUNj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 15:13:39 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87011C061757
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 12:12:59 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id 22so26612155qkf.9
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 12:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+WsQEKecGsYdPJ/2VLsazMRIqcMFYE9RwozfeOGEIdI=;
        b=B/g6AR0e1wAPp1pQgK1YYDTXsntg1d3nGlacAbvsPhbkD/T1U0aNdUAOSpfk5Gpv1e
         wLwFGdeV+qEPMjZzBzjv+jRfFIrczdGd1HH+2gWhzucGJOZ3W6bi/ulO4gWiwMjmntxR
         Bd8vHvvIMIRZ0DxKGvyMuIoMLlDLq+XVVh0jY04Q6Xhht8KjRPNlRLKTM+UBB7LIlTGX
         PpyWz2IuvMdt2KwakdmBfhX3D8UprMJoYPiGQHcZVeVlR3yT6Y54KhrKvSI+/XTeEI1T
         nQh/bXKpOlTLa+tGC3/Dij7jTgebFFJLOHA3JRCJ3QC2uTJwT2oOM/F6/m4w8dUqLlDl
         FO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+WsQEKecGsYdPJ/2VLsazMRIqcMFYE9RwozfeOGEIdI=;
        b=BAr0bjDRlrYZq9OoioakVSOQuoIxLZ7oS4dAca4YBGp7IOd+WxhEcSriyzCL6hYKca
         RwSb9ZNbxUU4MooimUpbVZrBiL2D616X7ka5Ng0ANFbyX1tsYhSzeYfy2/slMEEHfsxZ
         YwDQkQOhZbP2m3aT17x72gPvKoKK8q6TeFoK1hi6rBBbr3AGQ7qXAh6jymNP2VFo0AmT
         KQjggB1NSgHC7H6IJhA897bW9rfB4ncdzuW9t+q1j8lEyriw2UsvA4lrlyS9y04PTRAe
         fgjjbCnHQrMXd7PaQ3C9eQlfzIdZiv54kcTpf6NaMPtVHC3SHGsU7/+KTmR6pn7PHSdK
         D7aA==
X-Gm-Message-State: AOAM531ZzWJ9JCPvYw8LMk8EMkKEeCYbl9/IqfUj3KKe4j5ziyK7WTTW
        2TLxpkT2x1OWDTVkElrszOGD6Q==
X-Google-Smtp-Source: ABdhPJyn+JYXfZp4swWo0dUJR3qVelyAhV8npzlgLYmdz2k5XeQnVRwh26Qg+MJ52hSHYB3M4lNpiQ==
X-Received: by 2002:a37:b6c6:: with SMTP id g189mr11193329qkf.432.1611173578828;
        Wed, 20 Jan 2021 12:12:58 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7d49:7932:5c79:ddd4])
        by smtp.gmail.com with ESMTPSA id y56sm1929268qty.94.2021.01.20.12.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 12:12:58 -0800 (PST)
Date:   Wed, 20 Jan 2021 15:12:55 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        jacob@gitlab.com
Subject: Re: [PATCH v2 1/3] refs: expose 'for_each_fullref_in_prefixes'
Message-ID: <YAiOx3km0WoZliYj@nand.local>
References: <cover.1611080326.git.me@ttaylorr.com>
 <cover.1611158549.git.me@ttaylorr.com>
 <bda314fe7ae1629ba068a0c4ada9b6adc20576eb.1611158549.git.me@ttaylorr.com>
 <YAiK4U1KnjPtWFN6@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YAiK4U1KnjPtWFN6@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 20, 2021 at 02:56:17PM -0500, Jeff King wrote:
> On Wed, Jan 20, 2021 at 11:04:21AM -0500, Taylor Blau wrote:
> > The code moved in this patch is identical before and after, with the one
> > exception of renaming some arguments to be consistent with other
> > functions exposed in refs.h.
>
> The other non-identical thing is that it handles a namespace parameter
> (which is good, but an obvious non-movement).

Ack; I knew that I forgot to mention something. Thanks for pointing it
out here. (Since you seem to be OK with this patch even without this
mention, I'll avoid sending another revision).

> -Peff

Thanks,
Taylor
