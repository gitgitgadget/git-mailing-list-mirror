Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726DEECAAA1
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 23:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbiJ0XX5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 19:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235512AbiJ0XXz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 19:23:55 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E97844D6
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 16:23:54 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id r14so5479055edc.7
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 16:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DPOdIwJiAB3gg6wFJAvLpwaipy9hTZQV4YSlSCQcyog=;
        b=naDkLJlpD2vdD9+962RyL9mYTibF1BWiyv6uW70aB9TmHX3KbxlMT2esI5lWxnsJkt
         gurqB1bJjmBWEY/2sMJQoCtiZxQg6HurMDn0AXxIQzpfixf59r3R0H6teb+Z/t+DnIKL
         yAc6eHzvnBxasyMjYnPfomRikgiNC5NHhz55h1dTYT2LD3zf9SPYW4yeJtCUBNW/2leY
         KfCNyC65LwQm+TqquMO3pNTo2XXQGQNFiZXuKOUngaepjb/w3XugT3j5p9puPopc5Gzf
         nUUO3FNmwX5wWzLFy35COGAsD+z6CepsKb7EBVcwC5tFQotWek3yVQ/MceCCeKFbxx70
         T3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DPOdIwJiAB3gg6wFJAvLpwaipy9hTZQV4YSlSCQcyog=;
        b=S2OlXCvWO62q0/0VNBFBxnIoe2vX9Ydg6V2qbdgMlTVRF5YR4uECdxjAA/itVCPI3f
         VCWfmes/yV+E20An1D6Q07EIVNu2xE5lUZi49EQiD13H5yjxOXpSItgck40OUJc10a5H
         eE8YeMV6EMC4RIExjyRm52EDmidG/WGsYetwFBwUWhfDGp5q0FiZ/1/SevRPorWlUxz2
         G5SFqSI6r0gwCk9Rd+qW9GT2TZeSbqNXBJrbjH1p7LDYE51l45kS0YxikTVWCOTFqYCQ
         2l3w9EcVqGrFKNaOpy0PFThFKOOnbBhbxELbUnqCZvZNilNphR84wu8Gp/Jbgkpk9HGI
         B3mg==
X-Gm-Message-State: ACrzQf2/L+r1PMr6Sn5NtbNzeGol9mHpaBSIwE7IO8Os/LBLkU1lP0LL
        MRMWZczFs57hqAxe7l89wAs=
X-Google-Smtp-Source: AMsMyM4lLPi9paiR1OQPjgexxnvcUzTMMNHQ1Rw6qw9lApuPyCzLpHvHwvy6rRv54OVhbhv6qYVTog==
X-Received: by 2002:a05:6402:371b:b0:460:ff7d:f511 with SMTP id ek27-20020a056402371b00b00460ff7df511mr38025972edb.148.1666913033471;
        Thu, 27 Oct 2022 16:23:53 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id f14-20020a056402068e00b0045bef7cf489sm1642092edy.89.2022.10.27.16.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 16:23:52 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ooCE4-009evg-09;
        Fri, 28 Oct 2022 01:23:52 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>
Subject: Re: [PATCH 04/10] string-list API: mark "struct_string_list" to
 "for_each_string_list" const
Date:   Fri, 28 Oct 2022 01:04:05 +0200
References: <cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com>
 <patch-04.10-40b3cc9b8d4-20221026T151328Z-avarab@gmail.com>
 <xmqqlep1kqpy.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqqlep1kqpy.fsf@gitster.g>
Message-ID: <221028.86a65gam0o.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 27 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Add a "const" to the "struct string_list *" passed to
>> for_each_string_list().
>>
>> This is arguably abuse of the type system, as the
>> "string_list_each_func_t fn" take a "struct string_list_item *",
>> i.e. not one with a "const", and those functions *can* modify those
>> items.
>>
>> But as we'll see in a subsequent commit we have other such iteration
>> functions that could benefit from a "const", i.e. to declare that
>> we're not altering the list itself, even though we might be calling
>> functions that alter its values.
>
> The callback functions are allowed to (by taking a non-const
> pointer) modify the items, but are there ones that actually modify
> them?

Tree-wide that's:

	 11 files changed, 18 insertions(+), 18 deletions(-)

I.e. a bunch of changes like:

	-static int get_notes_refs(struct string_list_item *item, void *arg)
	+static int get_notes_refs(const struct string_list_item *item, void *arg)

It turns out there's a grand total of one user of that:
=09
	setup.c: In function =E2=80=98canonicalize_ceiling_entry=E2=80=99:
	setup.c:1102:30: error: assignment of member =E2=80=98string=E2=80=99 in r=
ead-only object
	 1102 |                 item->string =3D real_path;
	      |                              ^

But note that that's for the "filter" variant. In any case using the
same function pointer type in eb5f0c7a616 (string_list: add a new
function, filter_string_list(), 2012-09-12) for both was probably a
mistake.

But still, I think it's best not to do anything about *that*. I.e. it
makes sense for such an interface to say that the iterator helper takes
your const list, i.e. unlike filter_string_list() it's not expected to
be changing the list itself.

But you as as the caller are then free to change list items you're
given.
