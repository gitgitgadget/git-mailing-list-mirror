Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACC27201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 17:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752016AbdF3ReF (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 13:34:05 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36637 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751657AbdF3ReE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 13:34:04 -0400
Received: by mail-pf0-f193.google.com with SMTP id z6so17771115pfk.3
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 10:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bpV0TZU69404vUGhOa/wwIQDCFMp0x+N/XHG4uKEw6E=;
        b=GBgsBAwbQtxC8LjYH89vXsKRZzQWeUZ/YlbWuaCOBq8Be9XvAQEKK/k3LcqmIrYcEf
         d53iBxDEZJOHQq5rgaEjhuPsvv8bX52k62KJfNPHzlZsBSH09uRoD5rMJLabDfrVc3/C
         qqTG6tHIusUMWVZmvTk8jEq6zxFyMOxCArhLLg/QCEvhFLqejljH/5jRMwc0K1kTyVs6
         CfDkAoXLDYPhhhOUFLZHKTltdyCA9/CpumBZhYt6xC3DWX3kYiYhPmn3TxtBkWehWMA/
         zF9DH4Va1PPb/PndMCPbDli30IN3HnpuWKZLfbo1i/gfpqR/+u++mt1EL9elyIiTnGRE
         ANRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=bpV0TZU69404vUGhOa/wwIQDCFMp0x+N/XHG4uKEw6E=;
        b=mAwa9wKAnINpauaLdf/HKOw59y8nXAfvzj+PP2tpYyVk+2zKltx/wEhNHrGjawc6DC
         Sqqulv3LlY6HlsAxnRd5eAAyzW/8sM7YCb7dzuaQmStaki+NBUIGk4gFldrkXbf6KwrH
         PzXH27lZXo2HrH/vH7Q6o84CkBsRZJWgOeBqPGKp74fYE8jn1zdzOdOCWzvvb0sBQATF
         J3XZYfxl3E5Siuy1p0H0lyXTszWshAJFT49iio4JgW1lHEdDZTx0jQ3gMIfLxBDBrJmu
         J01C+ixtp8o4eOWeujRQ1moYihZuRjMb3SbrJ4JSENOGpo819Nc6ZGNSTGOSN80B29qF
         u/xg==
X-Gm-Message-State: AKS2vOyJkD8XIjKVw4Xb0tuI4GrcH0brPbepFiEHjyGykHAO1axXoF6C
        ZnIlG4K8rVBn0A==
X-Received: by 10.98.65.198 with SMTP id g67mr23263354pfd.196.1498844043664;
        Fri, 30 Jun 2017 10:34:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:54f:b41d:dd9d:3de0])
        by smtp.gmail.com with ESMTPSA id d89sm19813065pfl.7.2017.06.30.10.34.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 10:34:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, git@jeffhostetler.com
Subject: Re: [PATCHv2 1/2] hashmap.h: compare function has access to a data field
References: <20170629011334.11173-1-sbeller@google.com>
        <20170629235336.28460-1-sbeller@google.com>
        <20170629235336.28460-2-sbeller@google.com>
Date:   Fri, 30 Jun 2017 10:34:01 -0700
In-Reply-To: <20170629235336.28460-2-sbeller@google.com> (Stefan Beller's
        message of "Thu, 29 Jun 2017 16:53:35 -0700")
Message-ID: <xmqqlgo9s7li.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> When using the hashmap a common need is to have access to arbitrary data
> in the compare function. A couple of times we abuse the keydata field
> to pass in the data needed. This happens for example in patch-ids.c.

It is not "arbitrary data"; it is very important to streess that we
are not just passing random crud, but adding a mechanism to
tailor/curry the function in a way that is fixed throughout the
lifetime of a hashmap.

> diff --git a/hashmap.h b/hashmap.h
> index de6022a3a9..1c26bbad5b 100644
> --- a/hashmap.h
> +++ b/hashmap.h
> @@ -33,11 +33,12 @@ struct hashmap_entry {
>  };
>  
>  typedef int (*hashmap_cmp_fn)(const void *entry, const void *entry_or_key,
> -		const void *keydata);
> +		const void *keydata, const void *cbdata);

As I view the new "data" thing the C's (read: poor-man's) way to
cutomize the function, I would have tweaked the function signature
by giving the customization data at the front, i.e.

	fn(fndata, entry, entry_or_key, keydata);

That would hopefully make it more obvious that the new thing is
pairs with fn, not with other arguments (and entry-or-key and
keydata pairs, instead of three old arguments standing as equals).

As I think the way we wish to be able to express it in a better
language would have been something like:

	(partial_apply(fn, fndata))(entry, entry_or_key, keydata)

that order would match what is going on better.
