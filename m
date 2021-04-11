Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9EFC433B4
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 22:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9FBA6101D
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 22:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbhDKWNB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 18:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235718AbhDKWNA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 18:13:00 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22522C061574
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 15:12:41 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id w3so17100208ejc.4
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 15:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=vkY3r3ACroQOTpfYKPlnFTHG6HbyWltkd5j8Qy/prBA=;
        b=PDBV04MYnbiGmT+lKeHvVn9W5sYjSxlnlBSBGApY4DNVE6WjrBubvrgTA5XFVkw1O5
         rY5hiXnJy0ZXbNf4m75OAn2l7miw3N742frqJYAAitnmLwqrXCrX6AX19MY0plwBWN/c
         4kGDKbQ6yD9Wu3DV1CjmYkTkpnvRmT/SzK1vXNb85rR8DHzoo1cp6zrzDk4qpmV6kIbH
         lnm/CGSQufAwlgW/Ch4/Yie8ufz1/bVJOSA62Rsb2uLhnSK/8habBgarGyqoFy3Vbnr9
         oCDFO/TGKFfxw5rSrDd2gRz0seEGax/chEAcU3i1XCjWhC5EDt4djYMnr2oYqNiGVwY1
         vZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=vkY3r3ACroQOTpfYKPlnFTHG6HbyWltkd5j8Qy/prBA=;
        b=cK6mo5B/11krEl3ewpQwhHK/mDFlkVJ2XyHoxkkn7brK/Cwy7cITIZs4jVqF0YiQAE
         t627tb6OwAL7mzfLF+sy9sqra+kC6dxkuze9WTIwCKBpTqLhk36G1URW0FTkpI5b1kxr
         tPjrT3NMiPNEQcjQp5/DXklMCu9+7tfOn04Y/2crj0gsi679JV7tDad+w6M5GMDztabZ
         VkIJMWGDRAh5U8Wgllj/Nj+UpRSZadULWyZryTOWEULxR58z0O+fHsHHvYr2wr6115l0
         zOU6LDQ6XvfWU38F2xgU3nx1Sdl0nKdIDJzkQ16byr+xuYtfesSVeR73ZeWlg9pXzURq
         ou7A==
X-Gm-Message-State: AOAM5307mKy1I6qH1suVIsk6BVDDyd0qkzsjZk29VL1NVXMcIMUlUSnN
        msngqooYCNz1XZN21n9IBEwHPYmAO3CSzQ==
X-Google-Smtp-Source: ABdhPJwjNZb7FkkLPlcKUCGf0dJyHLinmMQ8ZHIejEXcFNaegDB4hbKtP1QjsxrrxBO4QEt0hantgg==
X-Received: by 2002:a17:906:4ec3:: with SMTP id i3mr8531674ejv.119.1618179159669;
        Sun, 11 Apr 2021 15:12:39 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id k8sm5387207edr.75.2021.04.11.15.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 15:12:39 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 09/15] hash: set and copy algo field in struct object_id
References: <20210410152140.3525040-1-sandals@crustytoothpaste.net>
 <20210410152140.3525040-10-sandals@crustytoothpaste.net>
 <87k0p9f2z9.fsf@evledraar.gmail.com>
 <YHNusqcmwv75P6Ck@camp.crustytoothpaste.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <YHNusqcmwv75P6Ck@camp.crustytoothpaste.net>
Date:   Mon, 12 Apr 2021 00:12:38 +0200
Message-ID: <87wnt8eai1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Apr 11 2021, brian m. carlson wrote:

> On 2021-04-11 at 11:57:30, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Sat, Apr 10 2021, brian m. carlson wrote:
>>=20
>> >  const struct object_id null_oid;
>> >  static const struct object_id empty_tree_oid =3D {
>> > -	EMPTY_TREE_SHA1_BIN_LITERAL
>> > +	EMPTY_TREE_SHA1_BIN_LITERAL,
>> > +	GIT_HASH_SHA1,
>> >  };
>> >  static const struct object_id empty_blob_oid =3D {
>> > -	EMPTY_BLOB_SHA1_BIN_LITERAL
>> > +	EMPTY_BLOB_SHA1_BIN_LITERAL,
>> > +	GIT_HASH_SHA1,
>> >  };
>> >  static const struct object_id empty_tree_oid_sha256 =3D {
>> > -	EMPTY_TREE_SHA256_BIN_LITERAL
>> > +	EMPTY_TREE_SHA256_BIN_LITERAL,
>> > +	GIT_HASH_SHA256,
>> >  };
>> >  static const struct object_id empty_blob_oid_sha256 =3D {
>> > -	EMPTY_BLOB_SHA256_BIN_LITERAL
>> > +	EMPTY_BLOB_SHA256_BIN_LITERAL,
>> > +	GIT_HASH_SHA256,
>> >  };
>>=20
>> In this and some other patches we're continuing to add new fields to
>> structs without using designated initializers.
>>=20
>> Not a new problem at all, just a note that if you re-roll I for one
>> would very much appreciate starting by migrating over to that. It makes
>> for much easier reading in subsequent patches in this series, and in
>> future ones.
>
> I'm happy to do that.  I thought we were not allowed to use C99 features
> because only recent versions of MSVC support modern C.  I was previously
> under the impression that MSVC didn't support anything but C89, but they
> now support C11 and C17 in their latest release[0], much to my surprise.
>
> If we're willing to require C99 features, then I'm happy to add those.
> I'll also send a follow-up series to require C99 support, which I think
> is overdue considering the standard is 22 years old.
>
> [0] https://devblogs.microsoft.com/cppblog/c11-and-c17-standard-support-a=
rriving-in-msvc/

I don't think we can in general require C99, e.g. I found just the other
day that our CI's MSVC will fail on %zu (to print size_t without %lu & a
cast).

But we can use some subset of C99 features, and happily designated
initializers is one of those, see cbc0f81d96f (strbuf: use designated
initializers in STRBUF_INIT, 2017-07-10). It's been used all over the
place since then.

See e.g.: git grep -P '^\s+\.\S+ =3D ' -- '*.[ch]'
