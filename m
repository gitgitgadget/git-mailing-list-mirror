Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C27CD484C
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 18:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbjIVS0i (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 14:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjIVS0h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 14:26:37 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD65C1
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 11:26:31 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59e9a08f882so36480077b3.3
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 11:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695407191; x=1696011991; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vTNuTHhMWtwmc23w0uiSf2ZfL6MsuJbF/5/g/aGaiLg=;
        b=TWDUtKJUMuQoQ6YIPvncEcZZKwS9cEUB0OtQ5pAEZfUK7TAcgFg6p5j9JrjcQKmGxg
         u/B4knqZ7rwLw3EUi+xdvZmDFSLScv83Bpan9i9TApMsAwE2GSg9MhRV4mXquNWgG+vH
         f1lHNFwNL+fu7GhXx1TMBzu+goITkWT/ijGocg651+1E3TdC8EpKcsw/ZMg2rH3UBDte
         eu7RH4VNy3fR9eRz4vXHNymE5ALqo7x/f92Ww1MdWN0PHXF07HGkca/iC0ujBmQNWTLM
         iCgLrFydOiDIsfCZI8kbJ9yy8LV94ScTIJWZ5CbsZqb4KMdD50m6Iek9DMpkr0qaGL/2
         P7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695407191; x=1696011991;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vTNuTHhMWtwmc23w0uiSf2ZfL6MsuJbF/5/g/aGaiLg=;
        b=nolWWpv/vHg55vQEoTVGqpHU1TndE7pD0Z94DT+8L4xQPSHDufyTsdAupghySDNlJ4
         7UZ3wQB+Z1nEk550lJ6/fNS0HD1edcyG6BDXYOXGGuC1RnQybUPvO/Jd7T/z9i6a72bP
         KOxaGj672b3g7UztuSj51ocRKFVy8/ZFjAAhlUjSHvj77JKtTQp1vWGPL3ka7tWbChIK
         SgmgSJyGDs9U4NAb7CCdpVWuBVh8ugylMQAKa5zd0ROknky3drVSskS+MRha7VNMnMb4
         MGGb6vesTVze8zoCmxFFnQWHRqwtSmEX7fqkFCXGEpcQASA1QOtTYmbgHULDoxHT8cqZ
         gmoA==
X-Gm-Message-State: AOJu0YzA5AQKErhT+ZlMSLLqCwDKRHvluiKXphNHiTOuoZYFZfs4b30V
        eBYnj/2XplGEQp+abVdduAahyMbT48M=
X-Google-Smtp-Source: AGHT+IG63dK1Mc9JcoNmLecfNSvlxD6/krcytsOhakJM9AIZULFq4/K0tImFrPgJr2mR9kT6f+mqj0qUzjU=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:1689:b0:d7b:9902:fb3d with SMTP id
 bx9-20020a056902168900b00d7b9902fb3dmr1714ybb.0.1695407191030; Fri, 22 Sep
 2023 11:26:31 -0700 (PDT)
Date:   Fri, 22 Sep 2023 11:26:29 -0700
In-Reply-To: <xmqq8r90dh2v.fsf@gitster.g>
Mime-Version: 1.0
References: <20230919225926.2189091-1-jonathantanmy@google.com> <xmqq8r90dh2v.fsf@gitster.g>
Message-ID: <owly5y42t67e.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v3 13/13] trailer doc: <token> is a <key> or <keyAlias>,
 not both
From:   Linus Arver <linusa@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Tan <jonathantanmy@google.com> writes:
>
>> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>> @@ -248,34 +258,40 @@ With `add`, a new trailer will be added.
>>>  +
>>>  With `doNothing`, nothing will be done.
>>>  
>>> -trailer.<token>.key::
>>> -	This `key` will be used instead of <token> in the trailer. At
>>> -	the end of this key, a separator can appear and then some
>>> -	space characters. By default the only valid separator is ':',
>>> -	but this can be changed using the `trailer.separators` config
>>> -	variable.
>>> +trailer.<keyAlias>.key::
>>> +	Defines a <keyAlias> for the <key>. The <keyAlias> must be a
>>> +	prefix (case does not matter) of the <key>. For example, in `git
>>> +	config trailer.ack.key "Acked-by"` the "Acked-by" is the <key> and
>>> +	the "ack" is the <keyAlias>. This configuration allows the shorter
>>> +	`--trailer "ack:..."` invocation on the command line using the "ack"
>>> +	<keyAlias> instead of the longer `--trailer "Acked-by:..."`.
>>> ++
>>> +At the end of the <key>, a separator can appear and then some
>>> +space characters. By default the only valid separator is ':',
>>> +but this can be changed using the `trailer.separators` config
>>> +variable.
>>
>> I think all the other patches will be a great help to the user, but I'm
>> on the fence about this one. Someone who knows these trailer components
>> by their old names might be confused upon seeing tne new ones, so I'm
>> inclined to minimize such changes. I do think that the new names make
>> more sense, though.
>
> As long as the new names describe the world order better than the
> old description, I do not mind rephrasing the documentation, and you
> seem to find the more descriptive <keyAlias> easier to understand
> compared to the non-descriptive <token>.  Adding a concrete example
> (ack vs acked-by) is also a good change.

SGTM (i.e., I am OK to keep this patch as is). So I will not re-roll.

In the future I will be cleaning up more of the trailer system to make
use of the disinction between the key vs keyAlias where appropriate.

Thanks!
