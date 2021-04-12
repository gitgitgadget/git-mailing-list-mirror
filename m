Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E24C433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0611C61221
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238951AbhDLLNX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 07:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237520AbhDLLNW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 07:13:22 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF70C061574
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:13:04 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id m3so14570611edv.5
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=gqJRAFAvljxgbBlMk5ReueASMTBLeuW0MXBrA3QM+zs=;
        b=l6JvK04h9JGa574gpNY+09/7FgQ2VVNRq7VUHUBGxmJMXSLejHQI4Six/rvwQPG9i/
         x17shWKXmJBl0/PxpB6dLb+FT5m6VXJCPjUnUeK+9Ci4wZCt4nZNEYysWOwcWKe5ms6f
         L5i+ZEXT4hiBpUNr7FeR4VLmigZsK0bmlU8U3AZOQ56ArpyU8zq8JA5aTXUvz0sDQSYU
         /BX0ifILerGii07Dwvcrb8uqugy2WPxEE8OWAb/bmRJY7rs4qVLjWfrfXTCaYQpEWQ02
         xEqp/kHpa4eHQBY86k4hnI8U1HjMvcQ6gVB24rUUx8tYVmSBFvpcucpqGR2itXosiAgO
         DNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=gqJRAFAvljxgbBlMk5ReueASMTBLeuW0MXBrA3QM+zs=;
        b=hTSh/MM1Uv9zRxc5HeHsp3r/1SBD8wpiMsODj5pGy3uim00l3zZaFLbqlRpE+kcbtT
         fKDOrFI9cNoCM22qxzaXHXvNfKj+STuPJqYnWLJus3MnS2m8WQZrXJMZqcju1pHOEKoL
         pYIyNqq1ebVhGroZ13VyDZwDa37YhcmW/XRLghpEm4/1f8vm8VirETw5Q6XB7nmzOcJf
         IKScZCfQ1/wQcHzM1RhD7HI6Z5yX/rJlgBIsLY3Tc0n4zz1MoFlIKEywuk8xIrQVkcYm
         mVxt7deggqO+rBUvAvMb+DYAo65TApewbHticAOu9L8PjQdZz6QxA+/hguOWMNBfnECd
         CTBQ==
X-Gm-Message-State: AOAM533/DGoOt/eU6l8945VDw11wccLFkSWidSf6SRPb4BD2hy4L0Zvu
        ON1IrMjpKMRpEYUdBcqmlauTfSzc0bq7yg==
X-Google-Smtp-Source: ABdhPJzLRiR88kuavqozzDs1ugkFMT8uFiahITDSDJbvbEb8xyjNtyuyFBXsB4Q4NkBjHRdqx1+0XQ==
X-Received: by 2002:aa7:c3c3:: with SMTP id l3mr24414955edr.103.1618225983032;
        Mon, 12 Apr 2021 04:13:03 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id o9sm2059861ejg.56.2021.04.12.04.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 04:13:02 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 09/15] hash: set and copy algo field in struct object_id
References: <20210410152140.3525040-1-sandals@crustytoothpaste.net>
 <20210410152140.3525040-10-sandals@crustytoothpaste.net>
 <87k0p9f2z9.fsf@evledraar.gmail.com>
 <YHNusqcmwv75P6Ck@camp.crustytoothpaste.net>
 <87wnt8eai1.fsf@evledraar.gmail.com> <xmqqeeffg4fi.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqeeffg4fi.fsf@gitster.g>
Date:   Mon, 12 Apr 2021 13:13:02 +0200
Message-ID: <87tuobeoxt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 12 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> But we can use some subset of C99 features, and happily designated
>> initializers is one of those, see cbc0f81d96f (strbuf: use designated
>> initializers in STRBUF_INIT, 2017-07-10). It's been used all over the
>> place since then.
>
> Good advice to cite a commit that on purpose used a feature and
> documented that it is allowed.
>
> Also see Documentation/CodingGuidelines ;-)  The document should
> give the authoritative blessing for features allowed to be used (add
> any missing with a proposed patch).

Our E-Mails probably crossed, my initial motivation for just-submitted
http://lore.kernel.org/git/cover-0.2-00000000000-20210412T105422Z-avarab@gm=
ail.com
was going to CodingGuidelines, and vaguely remembering that there was
some other C99 thing that wasn't listed there, and then (re-)discovering
the recent variadic macro commit from Jeff King.

As noted there maybe 2/2 of that is too aggressive, but in that case it
would make sense to have a V2 of that which just carved off the
CodingGuidelines change.
