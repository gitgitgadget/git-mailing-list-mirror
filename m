Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB67C433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 18:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235921AbiDMSpk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 14:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbiDMSpj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 14:45:39 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B827A369D8
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 11:43:17 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g20so3507774edw.6
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 11:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=wcNDc6qmEO+HmUX0cBRbqu+j40GIr9l1pJCdq2kw4Hs=;
        b=kkXyfoykG+Tt9Lr9Zxg+zIilKAZqZTjY2LNMY5RZnSzJMD01uyD3r3F6z/Moa1dMug
         d29xCgH9niwXutHdEoE7uihb3JytTH0i4SqkibqhHJ0XxmyxpHIsmwv69KiyCXa9hac7
         Iq5UI9sVaBIZVceoj03VzC4hO7Fdof5TveUMqzDABLU8o5Vr4sPL7U3YLKUVKtT8BCQh
         xq8JWXzlvmVxxZOU2TNXWLES7dX47HkEx/lbebdKGkDt0HmtSkU2PT+5LCP2B/aIUgtr
         JpmOgYYGR3dbJ2I3jmgNgWesNW7seXuyDtsPyvfBfY+xEel3FpUD0ZzvdwI1pDw2MdZh
         R1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=wcNDc6qmEO+HmUX0cBRbqu+j40GIr9l1pJCdq2kw4Hs=;
        b=OQ6qHiz+cBgbgBDH3MOOfJNT0M53aK8eU78uM/Di4OTXWr8DZHTOxxlJQ36unOTt8P
         Z1fPatVpQbfnT64d4/WYN/6c3zB47xXVOT4gJzzVSaUck+SZ4DUHFDHjOXlMadHdJnea
         /vFANK+OahpAHBbp35Is1+7Pa1gn+dd/tAHfMOj9vEjGJsL4GUXCo3pk5s5eoZF6b0x6
         urHNYrSBLU4+eFTASApXUNk8wQitMSCfihROruslzl/EY1Ei1e3kOk2hB+DMk7qrw8hZ
         Cnu+OCWdLfDlsXE6DK3gUdNvWYQRnm4selYzMWCNn3FsNMyh9DTURdaiNIU/SkONROIX
         fUMw==
X-Gm-Message-State: AOAM533QKeYbzAIFIlNCmuEK2TSQEc96e5uug9Po575C85Dz/2pxoRN0
        U8/jiS2BuzxeSNG2UUn5teV/7AtApiQ=
X-Google-Smtp-Source: ABdhPJyAU0zJOplD9cXQHjjZdmYL9cUkgopyRKutYgyWbt8a/gG8hRnQP10pxxVz7PPxpfHMl4n1KQ==
X-Received: by 2002:a05:6402:4493:b0:41d:83ca:35d6 with SMTP id er19-20020a056402449300b0041d83ca35d6mr13760928edb.89.1649875396190;
        Wed, 13 Apr 2022 11:43:16 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gy10-20020a170906f24a00b006e894144707sm250980ejb.53.2022.04.13.11.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 11:43:15 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nehxT-0059FS-52;
        Wed, 13 Apr 2022 20:43:15 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 4/4] builtin/stash: provide a way to import stashes
 from a ref
Date:   Wed, 13 Apr 2022 20:33:33 +0200
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
 <20220407215352.3491567-1-sandals@crustytoothpaste.net>
 <20220407215352.3491567-5-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220407215352.3491567-5-sandals@crustytoothpaste.net>
Message-ID: <220413.861qy0g6yk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 07 2022, brian m. carlson wrote:

[Finding time to go over this in a few passes, so some disjointed
replies, sorry]

> +	for (i = 0;; i++) {
> +		struct object_id tree, oid;
> +		char revision[GIT_MAX_HEXSZ + 1];
> +
> +		oid_to_hex_r(revision, &chain);
> +
> +		if (get_oidf(&tree, "%s:", revision) ||
> +		    !oideq(&tree, the_hash_algo->empty_tree)) {
> +			return error(_("%s is not a valid exported stash commit"), revision);

I think you're leaking memory here, i.e. you're in the for-loop and
doing oid_array_append()< but here you won't clear that or do other
"out" free-ing at the end.

But I also checked if your tests leaked with SANITIZE=leak, and (after
omitting the existing leaks) they didn't, so either I'm wrong or it's a
test blindspot.

Have you tried "make coverage-report" with this?

> +		}
> +		if (get_oidf(&chain, "%s^1", revision) ||
> +		    get_oidf(&oid, "%s^2", revision))
> +			break;
> +		oid_array_append(&items, &oid);
> +	}
> +
> +	/*
> +	 * Now, walk each entry, adding it to the stash as a normal stash
> +	 * commit.
> +	 */
> +	for (i = items.nr - 1; i >= 0; i--) {
> +		unsigned long bufsize;
> +		const char *p;
> +		const struct object_id *oid = items.oid + i;
> +
> +		this = lookup_commit_reference(the_repository, oid);
> +		buffer = get_commit_buffer(this, &bufsize);
> +		if (!buffer) {
> +			res = -1;
> +			error(_("cannot read commit buffer for %s"), oid_to_hex(oid));
> +			goto out;
> +		}
> +
> +		p = memmem(buffer, bufsize, "\n\n", 2);

Nit: Grepping in-tree all other API users of get_commit_buffer() just
use strstr(buffer, "\n\n"), if this one needs to handle \0 specially
(for reasons I'm missing) perhaps a comment here discussing why?

> +		if (!p) {
> +			res = -1;
> +			error(_("cannot parse commit %s"), oid_to_hex(oid));
> +			goto out;
> +		}
> +
> +		p += 2;
> +		msg = xmemdupz(p, bufsize - (p - buffer));
> +		unuse_commit_buffer(this, buffer);
> +		buffer = NULL;
> +
> +		if (do_store_stash(oid, msg, 1)) {
> +			res = -1;
> +			error(_("cannot save the stash for %s"), oid_to_hex(oid));

Maybe just "res = error" for these? You use that in 3/4, would be good
to continue the same pattern consistently in 4/4.

> +			goto out;
> +		}
> +		FREE_AND_NULL(msg);
> +	}
> +out:
> +	if (this && buffer)
> +		unuse_commit_buffer(this, buffer);
> +	oid_array_clear(&items);
> +	free(msg);
> +
> +	return res;
> +}
> +
> +static int import_stash(int argc, const char **argv, const char *prefix)
> +{
> +	struct option options[] = {
> +		OPT_END()
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options,
> +			     git_stash_import_usage,
> +			     PARSE_OPT_KEEP_DASHDASH);
> +
> +	if (argc != 1) {
> +		usage_with_options(git_stash_import_usage, options);

This function is a NORETURN....

> +		return -1;

...so this code isn't reachable, and will warn on some compilers (suncc
at least).

But consider using usage_msg_opt() instead, i.e. tell the user what went
wrong.
