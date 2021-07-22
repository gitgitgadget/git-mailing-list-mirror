Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0359EC6377D
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 11:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA5C860D07
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 11:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhGVKoA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 06:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbhGVKoA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 06:44:00 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9A3C061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 04:24:35 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id h8so6341485eds.4
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 04:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=6FF3KoTJM/crAK7QUFbj2yIug1M4WAT4Ux9GQPjM2Ig=;
        b=eF42IM9pKJvcnEPYc6w3P9GfAgl2+a8nTfTyobPc6pZem2oi6VKkYNQHEZE41T6oEf
         xdkFaHeYXwWCCf1p2GIgIOQOdrhVlZ09Qy1C9KntjRfnajAEti+1mVxPoOkZ7L737K+2
         NVKcqMJ+ZRa8VfeTdgZVbw0MtvKIMw3sGfNyMolxAHNJWSEfEHGMi2bLhyFYVCWVA17J
         iKPWhbYyPQ9JOJO0Fwv/Gd1dWwFkSXZsrKnf02EEms1JnEr9yqw3UNsAXSwK67GhwumH
         8YRNnMeZ5H4au5RamUUX8MptDvwV6vRMh4qDM0uD1x/egmuZ2Ro6Vlge90UXoHQn9TFq
         G3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=6FF3KoTJM/crAK7QUFbj2yIug1M4WAT4Ux9GQPjM2Ig=;
        b=oaFn6QIcjk9pfpSzmf4NA4bTnHi7+a3omt/cNcPwoy9maFuBW8cO8uwb1CUZZfWmcO
         YcsmHs9P6EsSxlogg+dkgkjZTy3UHs5xEt3wWZeSikSsT36ILUBougcafQQVaoj5jqag
         OZjLH279WY31moNdryA2qdfBzoVOGjbs5271dgC11q0uoEM551alUoVqcb0MOn3KdUup
         CTqHYN/gutG3IduzFlv4Drt6Cm3dwIjKENIWPNIsAitTNyB5MkTUjqW+oRelpz55VLjc
         LZJ+/yN/CKb177IS/Swofp9RWeLSOQ5zXLsOT4+I447vqndXstTNFt8Z24TpINDqZRsx
         9UmQ==
X-Gm-Message-State: AOAM5329EaXyW8vZ2nNyAguAL44EZpDkoI+6LEFlIsQOE53VbtaNNR+D
        00+t8S42nWXBJb8w2B9YRoRMTNB3yONieA==
X-Google-Smtp-Source: ABdhPJwavHZM+YYUnxDF2VM2UTIkbGuoepg8MY5G8+6m/mgpsMMjw/mWq1N50c8PpjYYl+2NzUT62w==
X-Received: by 2002:a05:6402:28b5:: with SMTP id eg53mr48248672edb.60.1626953073500;
        Thu, 22 Jul 2021 04:24:33 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id x13sm9499237ejv.64.2021.07.22.04.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 04:24:33 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [BUG?] submodule-config.c:config_from() has left me confused
Date:   Thu, 22 Jul 2021 12:59:03 +0200
References: <FB8C1154-6092-48C7-96B8-6B6D9A28D9AA@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <FB8C1154-6092-48C7-96B8-6B6D9A28D9AA@gmail.com>
Message-ID: <87y29ytwu3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 22 2021, Atharva Raykar wrote:

> Hi Git Developers,

Hi, just skimming this, hopefully someone can get it the attention it
deserves...

> Since HEAD and HEAD^ are valid tree-ish objects, the gitmodule_oid_from_commit()
> line should have returned early with a NULL object, but that does not happen.
> The output seems to match what I would expect from the API.
>
> Applying Christian's suggestions pass the same test as well.
>
> I also wonder what is the situation with the case where, the oid is non-null
> and invalid?
>
> If we look at the code again:
>
> static int gitmodule_oid_from_commit(const struct object_id *treeish_name,
> 				     struct object_id *gitmodules_oid,
> 				     struct strbuf *rev)
> {
> 	int ret = 0;
>
> 	if (is_null_oid(treeish_name)) {
> 		oidclr(gitmodules_oid);
> 		return 1;
> 	}
>
> 	strbuf_addf(rev, "%s:.gitmodules", oid_to_hex(treeish_name));
> 	if (get_oid(rev->buf, gitmodules_oid) >= 0)
> 		ret = 1;
>
> 	return ret;
> }
>
> ...what happens to the value of gitmodules_oid when get_oid() fails?
>
> *If* it is set to NULL, it would probably lead to undefined behaviour when
> we try to hash the oid for the submodule cache lookup in [1]. If it is set
> to 'null_oid()' or zero'd out (like with oidclr()), then it should return
> the submodule from the latest revision, which does not seem desirable, as
> the input is invalid.

We won't set it to NULL, we'll att worst oidclr() it, or leave it alone,
no?

In general we should not rely on the values we expect to munge if we
return an error. In practice it's probably OK to rely on an oid
passed-in not being in an inconsistent state in that case.

It could be, e.g. this might eventually go to get_oid_basic() which in
calling get_hash_hex_algop() might partially have copied a hash when it
fails. I have not traced this codepath but it could happen in general.

In practice I think it's OK to rely on passing an OID in, and it being
bad or not, i.e.:

    struct object_id *oid = null_oid();
    if (get_oid(..., oid))
        error(...);
    else
        /* oid is still == null_oid, not some bizarro value, probably... */

