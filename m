Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6772AC433FE
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 14:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243027AbiCGOLf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 09:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243020AbiCGOLd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 09:11:33 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9768D6B7
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 06:10:39 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id kt27so32337378ejb.0
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 06:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=yR4Q+i+Rd8ATQNNrjTGlyPOElfLQLl5apWMeFHG+dMQ=;
        b=DlSWR3gVE6Az6VC6SfICNA5rZMF5hqlUTGzKXxD51t0eBAnsAng9mhWcH9TIeFa9ik
         iiG46YstbJoDJYeclrM2/rus8hBUHsNqlCfX53UgtBvHvHvpmZ2VxUYWYYFKFQIcd0pO
         Vg3vkSFqP9+X0Fezcq++aXJyD9J9Ul87az3At2wgZgTm9yMj4GEYVBRiRmIJ3tom2pYp
         rP04NfgC7/BuHKG52I/41IslLwG/LLYLS4ZvfxywnwNUgodFy34uOovIG7R/ciDkxF5f
         JjxT8ZNtD/yGYL56ivGy1y4sgtOHtMi4dr7Uon+8XxX2Pd9leaPl3HwDfxXY6S1Z1DQo
         Jx8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=yR4Q+i+Rd8ATQNNrjTGlyPOElfLQLl5apWMeFHG+dMQ=;
        b=11bld5ncXKsqE2Kmxcu8ubWzDs3Lu4YE6lLxecO6ypGp/9yGe13f1LikWSgK2KZd/B
         CJgDzcwLfNuTQ4KkJyoY8OmMv/8LQxCSKAtgH3zLE1ekh2CZg0QhzJ36CYvNf7RMgu6u
         zJbaTOmNgY/8khCCXMrUoUPI+5ujdmiIFv6WZrRxrm3AfUIS6yS0u/MPCp3+uhiuNDIC
         vcEGas0q5njwIvFwFHr5nIIKCg+WEd3xvK01TON0ujDDR30IJ44dBZtN+uLslpE6qHsZ
         zAMf/GPHbWQ60HIg867CAG8b7COd1NLUEk4T8eBxiTk4Trq12NuTcYamsN26Iqudmdvz
         S93A==
X-Gm-Message-State: AOAM530cDQ1lFl6Xxr503q5+egpOe//kRVruYz17BMlVcSecXbHwd47I
        1TDOhWw+gaTCa0PUCMZBEnI=
X-Google-Smtp-Source: ABdhPJykTUHgI01iGgkOhrgp+XmCqxox7cWwZl8XpUvXk53p9rVzIiUa7bhsEfQmsLgNf5TbxlLjgw==
X-Received: by 2002:a17:906:1ec3:b0:6cf:d118:59e2 with SMTP id m3-20020a1709061ec300b006cfd11859e2mr9224578ejj.767.1646662237812;
        Mon, 07 Mar 2022 06:10:37 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id u23-20020a17090626d700b006cfcd39645fsm4844162ejc.88.2022.03.07.06.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 06:10:37 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nRE4J-001WbV-H8;
        Mon, 07 Mar 2022 15:10:35 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 2/2] string-list API: change "nr" and "alloc" to "size_t"
Date:   Mon, 07 Mar 2022 15:10:23 +0100
References: <cover-0.2-00000000000-20220307T113707Z-avarab@gmail.com>
 <patch-2.2-398682c07aa-20220307T113707Z-avarab@gmail.com>
 <34eb7b5a-180c-0e4a-0929-8eaf52f80090@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <34eb7b5a-180c-0e4a-0929-8eaf52f80090@github.com>
Message-ID: <220307.86sfrtzwdg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 07 2022, Derrick Stolee wrote:

> On 3/7/2022 6:38 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Change the "nr" and "alloc" members of "struct string_list" to use
>> "size_t" instead of "nr". On some platforms the size of an "unsigned
>> int" will be smaller than a "size_t", e.g. a 32 bit unsigned v.s. 64
>> bit unsigned. As "struct string_list" is a generic API we use in a lot
>> of places this might cause overflows.
>>=20
>
>>  			printf_ln(Q_("The bundle requires this ref:",
>> -				     "The bundle requires these %d refs:",
>> -				     r->nr),
>> -				  r->nr);
>> +				     "The bundle requires these %"PRIuMAX" refs:",
>> +				     (unsigned long)r->nr),
>> +				  (uintmax_t)r->nr);
>
> There are more additions of unsigned long here, which will possibly
> truncate the size_t of r->nr. I must be missing something here that
> explains why you are making this choice.

Replied to in the reply to your comment on 1/2.
