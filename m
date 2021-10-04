Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBBDC433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 11:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A39966137D
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 11:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbhJDLRb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 07:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbhJDLRa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 07:17:30 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A50C061745
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 04:15:41 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id p13so35227028edw.0
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 04:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=eH3mImcLKXlsuBwCk9w7ylC8/hr3ACTJZ2jhMdfpwKo=;
        b=PoSst0zXIyUIBV7/i534DNc6C6Vd/kW7j0p2LJtmlV37Cb6vGGqephKmOBqvH8v0xO
         NiwFMh66hbaJupewcAiRQbf/1G6JVoChAoyIOJQKZqFVLUQf2GUTIxYmFpirt9ve76yP
         BjGqkbJ+4llDf9Cn7xPlYsDOYOy0z5icKq5p5Y9mI1aj3OYZNAgFevNnakJmR30xFILO
         n1ygpt2GcdTNV7xHq/usM2j/CdT//z2aQWaBjBXl30hputHUKUN0npIts5hipeYaZQtd
         4gKsXn8bDrDKV6L8nM3v1sEA21mxcUbzx1eOCCb7Mw3NyTHFAmrnXa1ZcGqk76R7XI1z
         6Q5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=eH3mImcLKXlsuBwCk9w7ylC8/hr3ACTJZ2jhMdfpwKo=;
        b=YU872nfPKR1L36SCOoVEC0VpGHJ4ZQW3NdKdQvVoFw6XN/5F2nNtSHSbSqDivSRHkl
         EUK/Vr0eiGwWamWVEARNQHjNaJngb0q7TRYynlhPfgxa9ayMpbj9YXzGwemECgE+pYA/
         devH71sQbQSSvGFezCJuBC6o2qrzK9gqMYwSMrj8g7vHmvmm/d6XX7eDx18hIcN4KKwy
         IxM+6hLBXAwkRgY7FYrKeJh9/3jlC4rNouTbzHibLBG3+tIleX7MhRD8Zw02KU4SMZxq
         OeWKnODwUFEiMryfNXbC9IZDjNlzjFfAITfdGusNcV0myTSkf1EWyD+ZcnHsKYzm73Gs
         9DKA==
X-Gm-Message-State: AOAM530FPXIVbvfRSb/yw1MhqsF2yn08ccTR577iNOFZtNoYJO1SXHSS
        RARfJumvUBYCOXNm64O3LYI=
X-Google-Smtp-Source: ABdhPJzSKIpgSAkUSp8pb6+EIePd4zojHZhnGNCrB6JAlcCF7j2ItmV82d1yQ0NwKW+v0M3aAUxxig==
X-Received: by 2002:a17:907:97d2:: with SMTP id js18mr15985543ejc.191.1633346140359;
        Mon, 04 Oct 2021 04:15:40 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p21sm6261080ejm.88.2021.10.04.04.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 04:15:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 04/10] unpack-trees API: don't have
 clear_unpack_trees_porcelain() reset
Date:   Mon, 04 Oct 2021 13:12:16 +0200
References: <cover-00.10-00000000000-20211004T002226Z-avarab@gmail.com>
 <patch-04.10-9d62edd35bf-20211004T002226Z-avarab@gmail.com>
 <f24733e9-8742-33b6-5fae-93d89698cc00@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <f24733e9-8742-33b6-5fae-93d89698cc00@gmail.com>
Message-ID: <87bl45niqs.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 04 2021, Phillip Wood wrote:

> Hi =C3=86var
>
> On 04/10/2021 01:46, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Change the clear_unpack_trees_porcelain() to be like a *_release()
>> function, not a *_reset() (in strbuf.c terms). Let's move the only API
>> user that relied on the latter to doing its own
>> unpack_trees_options_init(). See the commit that introduced
>> unpack_trees_options_init() for details on the control flow involved
>> here.
>
> Before this change if there was a call to unpack_trees() after
> clear_unpack_trees_porcelain() then that caller would get the default=20
> error messages. After this change we end up with a use-after-free
> error in that situation. I found the subject line of this patch hard
> to understand, the commit message explains what it is doing but I'm
> still not sure what the motivation for this change is.

I'll work on the commit message part.

With this series such a caller is purely hypothetical, isn't it?
I.e. the journey in 02/10 & 04/10, and later in the 07/10 you commented
on is to make the API behave similarly to e.g. strbuf, where there's a
release() that leaves it in such a state, different from a "reset".

Perhaps this step in isolation is confusing at it leaves the function
named as clear_unpack_trees_porcelain(). I had this all in one change
initially, but figured having such a large rename diff & one behavior
change was worse.

We could just leave the "reset" semantics in place for everyone, but
just like "strbuf_release()" et al I think it's good for
self-documentation purposes to explicitly make clear if you're re-using
the struct, or just freeing it at the end.

For this API only one user of the API cares about the re-use case,
merge-recursive.c.

>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>   merge-recursive.c | 1 +
>>   unpack-trees.c    | 1 -
>>   2 files changed, 1 insertion(+), 1 deletion(-)
>> diff --git a/merge-recursive.c b/merge-recursive.c
>> index d24a4903f1d..a77f66b006c 100644
>> --- a/merge-recursive.c
>> +++ b/merge-recursive.c
>> @@ -442,6 +442,7 @@ static void unpack_trees_finish(struct merge_options=
 *opt)
>>   {
>>   	discard_index(&opt->priv->orig_index);
>>   	clear_unpack_trees_porcelain(&opt->priv->unpack_opts);
>> +	unpack_trees_options_init(&opt->priv->unpack_opts);
>>   }
>>     static int save_files_dirs(const struct object_id *oid,
>> diff --git a/unpack-trees.c b/unpack-trees.c
>> index 94767d3f96f..e7365322e82 100644
>> --- a/unpack-trees.c
>> +++ b/unpack-trees.c
>> @@ -197,7 +197,6 @@ void clear_unpack_trees_porcelain(struct unpack_tree=
s_options *opts)
>>   {
>>   	strvec_clear(&opts->msgs_to_free);
>>   	dir_clear(&opts->dir);
>> -	memset(opts->msgs, 0, sizeof(opts->msgs));
>>   }
>>     static int do_add_entry(struct unpack_trees_options *o, struct
>> cache_entry *ce,
>>=20

