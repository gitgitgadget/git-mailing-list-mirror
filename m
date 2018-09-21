Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE6341F453
	for <e@80x24.org>; Fri, 21 Sep 2018 16:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390391AbeIUW3r (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 18:29:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40046 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390065AbeIUW3r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 18:29:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id y8-v6so9824204wrh.7
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 09:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sFiQJKtYK+R/SZOtGT0JZSNoNgecwmziZAOr0k/zNGs=;
        b=usEmd5wgP2OrJKLjiwkwYO4bT1HAvNbJLt+D70EGI6Xr/aeVzkX47j5THpiFbvMMxh
         e++uI8GwbxouiD2mWonaCf0sMyId9kd51CExJIqikiXx7ZI6pyS7nXo10AsMXGndW37H
         RdqSzrZGohTTXymsr/QajFX9cG192KPASHCfl4HXcyKt3Xjem+k4p/guK+zAdQhmDiN7
         OhmX+u+E6R5q2XWdraQhFkOvE+20YQ3SiiBq4OKO6ypI21JWYLtrSYSEhPgGKcOBu/Az
         lQa7MZ/Bgg6oe7RS4E5YQGa7LnJpfJfhL+wVSij6MK0BhjAlVq73jvphQN4qS/zp1z6T
         A3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=sFiQJKtYK+R/SZOtGT0JZSNoNgecwmziZAOr0k/zNGs=;
        b=PBF0AuVmHMoSVUlbf4igBfWaPaGm6A23ou5ru1efOj/sn/R5bH3asNGBTJPCGpTK95
         l4JDjS3bnoHUb4xuwwHCFCJoqd1UXHLsOKGl78JV96W3Ris1hPBeBQs/HAkb5Txc4Gyk
         qwaLT0v3M1v1goQ/OSQ1OTOE5nvcHd83y4QfNaJtXzoK4nVblC7vU0V4cZrSJvk5D1hL
         UbXdKQ2FIYOY1xY2pfEvD5L+7RjN1b0f9sTvJULcPQKU7wV/HLY5J86DNjfxmKy4zimo
         GYKQm7iFDeaTSGd5yw31g+8eVZVH2S0M6sXhfZFiAWnHb4oESH4IuNgl7WTJUrPG13E8
         X4rg==
X-Gm-Message-State: APzg51CVkhfwzmgCaFbnUehZcJLbe/HgllowaF+vcnD2SodF1VoJsHcd
        t2j60XPtx1LXHeNDG8jwsUg=
X-Google-Smtp-Source: ANB0VdaNWwb86F4Z/+4VtisJPcJlFHlcmg6k/vla8kXAwJlt/qZfJONGqD6F0jqYjQKpTvF1q9+7qw==
X-Received: by 2002:adf:f984:: with SMTP id f4-v6mr39684119wrr.105.1537548004312;
        Fri, 21 Sep 2018 09:40:04 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q16-v6sm20464448wrn.41.2018.09.21.09.40.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 09:40:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     ttaylorr@github.com, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] transport.c: introduce core.alternateRefsPrefixes
References: <cover.1537466087.git.me@ttaylorr.com>
        <3639e9058859b326f64600fcd0b608171b56ce9f.1537466087.git.me@ttaylorr.com>
        <CAPig+cT7WTyBCQZ75WSjmBqiui383YrKqoHqbLASQkOaGVTfVA@mail.gmail.com>
Date:   Fri, 21 Sep 2018 09:40:03 -0700
In-Reply-To: <CAPig+cT7WTyBCQZ75WSjmBqiui383YrKqoHqbLASQkOaGVTfVA@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 21 Sep 2018 03:19:20 -0400")
Message-ID: <xmqqk1nex0rg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, Sep 20, 2018 at 2:04 PM Taylor Blau <ttaylorr@github.com> wrote:
>> The recently-introduced "core.alternateRefsCommand" allows callers to
>> specify with high flexibility the tips that they wish to advertise from
>> alternates. This flexibility comes at the cost of some inconvenience
>> when the caller only wishes to limit the advertisement to one or more
>> prefixes.
>> [...]
>> Signed-off-by: Taylor Blau <me@ttaylorr.com>
>> ---
>> diff --git a/t/t5410-receive-pack.sh b/t/t5410-receive-pack.sh
>> @@ -44,4 +44,15 @@ test_expect_success 'with core.alternateRefsCommand' '
>> +test_expect_success 'with core.alternateRefsPrefixes' '
>> +       test_config -C fork core.alternateRefsPrefixes "refs/tags" &&
>> +       cat >expect <<-EOF &&
>> +       $(git rev-parse one) .have
>> +       $(git rev-parse three) .have
>> +       $(git rev-parse two) .have
>> +       EOF
>
> It's probably a matter of taste as to which is more readable, but this
> entire "cat <<EOF" block could be replaced with a simple one-liner:
>
>     printf "%s .have\n" $(git rev-parse one three two) >expect &&
>
> Same comment applies to previous patch, as well.

If the expected pattern is expected to stay to be just a sequence of
"<oid> .have" and nothing else for the foreseeable future, I think
it is a good idea.

>
>> +       printf "0000" | git receive-pack fork | extract_haves >actual &&
>> +       test_cmp expect actual
>> +'
