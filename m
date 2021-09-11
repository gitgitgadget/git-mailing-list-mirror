Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C210FC433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 11:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A57B6610C8
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 11:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235678AbhIKLXh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 07:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbhIKLXe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 07:23:34 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A74AC061574
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 04:22:21 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id g8so6451540edt.7
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 04:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=/IgKuH9lmXHzrysTGN57cglCQW7Jrk1yjoHpVN9u1fg=;
        b=g4+lSsKKrgO+9iU7XVYDlB8YTkbq2MeLeI89oxx3kxAMPeqcBAbRFNwh6fbSXFglN4
         niV0im5iMUe78eLXuCN3v3QxvIQvMh4KPeucxoFcGnGbY6kfEZ4bI30DiWu+xC6KjEG5
         pxI/97uRRtcot0zarU57qQuJCItVhlW7NyVkQxlrs7Tv3ddoHk4vHAeyq1oQvWZqge6h
         ZoQaIc8jXIlSpMGdfY5W8B1CNPsREC6RCngo3+ZeoCIstgGIQbu2TxSHdZHRiJalgdqI
         mxC0G+NmrV/nufsxJuPQZWG9Za7JutdyyZ9zsFOQWWwoIHSk1fQWR4pZSfE/MvEzuPkx
         AzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=/IgKuH9lmXHzrysTGN57cglCQW7Jrk1yjoHpVN9u1fg=;
        b=QpdZcZCE8m6m0L1SUi23EfHXyBaH3Z6/9P7Z2kLPw+0Chz8VVMwOwz3vAdt26Nxndz
         4HzkO4d2aKIMQ6hRinNXSCC3MKYfKsobCBLSbAEeFIH8lEhVqFAru0uWmjcWcaa8gFgX
         WHEovCAuXLp/RJHIuiJ0SASG5kfbg2Dmb5bmtEEceUsdeKzQozG/Avof39KukU3+tfa4
         QgKt9dwJKLBimq59VYHE0kwVwVQdeIhahAPpTJR71KS4B8ODuYVVjuCxlJqBKFJmKntB
         T6Rf/ahD3EDbic0103QuA5MZQWVs6uIovju7Rd+9z1SLyCqKzsPVCHE0xWfrXJPKZ4W6
         ZkZw==
X-Gm-Message-State: AOAM531B55kJeJ5mRIi80k/SyU6Crxmw18ddD+OpioUpGfvfVboywKAj
        AJSLkTgDBJNhXNHdvetTvpc=
X-Google-Smtp-Source: ABdhPJxfPBui3nG4bZLYEWvfs30Bj/cL+y2g0nfRouecWfqc70cMZw8aWRWeTXufl3QqKy2FCzSEJQ==
X-Received: by 2002:a05:6402:1607:: with SMTP id f7mr2759513edv.187.1631359340132;
        Sat, 11 Sep 2021 04:22:20 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id c17sm791135edu.11.2021.09.11.04.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 04:22:19 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 8/8] builtin/repack.c: pass `--refs-snapshot` when
 writing bitmaps
Date:   Sat, 11 Sep 2021 13:19:27 +0200
References: <cover.1631331139.git.me@ttaylorr.com>
 <6a1c52181e8c8c9fe2f0e2d7fbeb1057f68c1f3d.1631331139.git.me@ttaylorr.com>
 <871r5v9z3i.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <871r5v9z3i.fsf@evledraar.gmail.com>
Message-ID: <87sfyb8ihg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Sep 11 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Fri, Sep 10 2021, Taylor Blau wrote:
>
>> +struct midx_snapshot_ref_data {
>> +	struct tempfile *f;
>
> Style/readability: Spare more than one byte for a variable name in a
> struct, maybe file, or tmpfile?
>
>> +	fprintf(data->f->fp, "%s%s\n", data->preferred ? "+" : "",
>> +		oid_to_hex(oid));
>
> Just an idea: Maybe the file could be lines of "+\tOID\n" instead of
> "+OID\n"? Lends itself more naturally to extension, use with the likes
> of string_list_split() etc.

Actually, even better a format like:

    "OID[\t+]\n"

Or

    "OID[\tpreferred=3D1]\n"

Then you can just use the strbuf API to eat the lines, and only parse
any optional \t-delimited "flags" if the length of the line you get
doesn't match the hash size length.

I don't think it matters for speed or whatever, just ease of parsing &
working with this new format.

The "+" v.s. "preferred=3D1" suggestion is just to make it future-proof
for comma-delimited key-value options, which we already use in the
protocol etc., so it's easy to parse, but I don't know if we're ever
likely to add a new flag here (and even if we are, we can use the next
"\t" positional...
