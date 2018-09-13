Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DA6D1F404
	for <e@80x24.org>; Thu, 13 Sep 2018 20:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbeINCHE (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 22:07:04 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40624 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbeINCHE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 22:07:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id n2-v6so8086156wrw.7
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 13:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=P0+UNINFH/qATJts3RF7v8BaBhakj9nOufCTvcdPoBA=;
        b=WbH/yz3jnVBrvlClSLVhO143Ma7p65Lw3s6ErWA1vAQHFMcRU5b32gJD6LBUvjxP4L
         HlMWQKDKsMdFhdlaZ26ZocalhZ/ZEeLUd4o9GyYee/QD8eCRXi5vG+q+snwKNrAjlN6N
         QgezoqF0aYApTOaPdMCkLMBrGjKwINbWlC8Px5VpGwgJw8r4jI8R3mQb10YKFHvL7jkJ
         bH+gmaEuOkgmlnW9GLhB2X+u0wJiK1mol+wWjsT20wVUDp+9EORBr9kohSwRRi6koOx2
         Xdp1Gxg8Zpx2ehf/EmqW2lQ00KXSx2rQNIOw0GAIxm4NFi5JYqKeJvVZigqXzfdrD5NK
         t7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=P0+UNINFH/qATJts3RF7v8BaBhakj9nOufCTvcdPoBA=;
        b=r631VARBTmCBJQfJ9Voa8JdARPn/Na05V90TSaG8rpSKT85nazaBbJ7C7lvIorXKQ/
         smhm+QN8i4UpGS2HgisQZ+kBR3CXFMo68bk1eAHZmosl/J95wGzM3R2jS2c2i044aLKb
         sDqwmw0/8fqpus54aTFDH4BagrAK2pEExSozTlEyOxeCtMwz7NEPo50tT3VhQgGtIwG4
         yyzL5JP3AyNZNHtSgfo0YBnM5DD9U4D06zwJpQC7cklr8HEEAl95Q3dprBOoY0HfdxPo
         n+nKoNIDDxjHknEgZZQWK3FBExTW0UqeBgxqOxS/L6vkLBPfK9kCP2L2YvFb3eyYJT1Q
         Asig==
X-Gm-Message-State: APzg51Bmlo+FSdEAQoDUjNJXR/CSSngHduFkM7gpxDlFjg7ISl+RKwVT
        vk8C+amx6Nre4gYnV2G7MLg=
X-Google-Smtp-Source: ANB0VdY/vdQ13CyKJzQKsjjFC6iEboUdLXWatREj0IU0m1kd+t+iCD3MziHL19sqPPSArEsz0OrIGQ==
X-Received: by 2002:a1c:b404:: with SMTP id d4-v6mr6898818wmf.28.1536872152507;
        Thu, 13 Sep 2018 13:55:52 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r66-v6sm9058740wmb.37.2018.09.13.13.55.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 13:55:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] fetch-object: provide only one fetching function
References: <xmqqefdyjsgh.fsf@gitster-ct.c.googlers.com>
        <20180913180932.93341-1-jonathantanmy@google.com>
Date:   Thu, 13 Sep 2018 13:55:51 -0700
In-Reply-To: <20180913180932.93341-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Thu, 13 Sep 2018 11:09:32 -0700")
Message-ID: <xmqqa7olf76w.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> Instead of explaining why the new convention is better to justify
>> (2), the above three lines handwave by saying "more flexible"
>> twice.  We should do better.
>> 
>> 	fetch-object: unify fetch_object[s] functions
>> 
>> 	There are fetch_object() and fetch_objects() helpers in
>> 	fetch-object.h; as the latter takes "struct oid_array",
>> 	the former cannot be made into a thin wrapper around the
>> 	latter without an extra allocation and set-up cost.
>> 
>> 	Update fetch_objects() to take an array of "struct
>> 	object_id" and number of elements in it as separate
>> 	parameters, remove fetch_object(), and adjust all existing
>> 	callers of these functions to use the new fetch_objects().
>> 
>> perhaps?
>
> Thanks - your explanation is much clearer than mine. Let me know if you
> want a reroll (or if you can update the commit message yourself, that's
> fine too).

If there is no other change needed for either of the patches, I do
not mind rewording the 1/2 myself to save a round-trip.

Thanks.
