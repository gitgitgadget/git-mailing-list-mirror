Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFA6C49EA5
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 23:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55C966137D
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 23:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbhFXXKS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 19:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhFXXKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 19:10:16 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BEBC061574
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 16:07:56 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id df12so10898450edb.2
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 16:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=hOXm/VWULqD0rylfCdNi5jwood0Cq4EHq7zXIdaf+ZM=;
        b=gs2PUz4ZUzkBBBRj9JHZ+kbYphAguPh7VUQpZ1Dxx6Y8N4NE35xvI5Kh41DB8SDgcj
         vA5oI9avDokpJqedccqfrjxxs1a/QK2YLgf7jSVfjBNAmJ3j3KDs9r2tNtRO8RRr1j9c
         ++3Ak4rlsOq94B+ZfqoaacE73FHICOSwadQVgEQ6THkZWEtnfflxpxpxHASyomANKJp4
         g9eqJQF3SAWVWqZPLHKKp5nYaKpUY3cVAetcciWUP0uojIYvakKODHDXoVYJgjerzZq0
         k8MBr/FB98rBmvNTvO0MrrrbHtsNEaWuow275YQqTHBz7F4kKi/+9fbfiutMsWKzqfGL
         heJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=hOXm/VWULqD0rylfCdNi5jwood0Cq4EHq7zXIdaf+ZM=;
        b=bTXEjdezMnVKnFKf3RVAXqQhryLPZO2BNoqx6X4GGPDxYwOfZleTFFg1AOhhtS0dUF
         4ZSuf5hBYvGifL4gTDXgVkfajfypFZpuHj0jAu6vCaMSmFeiT+GQORSSKwyevuS6PXWU
         C/mdEtHXoTJdSnUqTE8Y8calHH7Vz3YoXL9rXbJBJxHvkWbDmKeK6pahbd7ufxk6AXUC
         OhM//1xg3ELooPr4WabJI+DhS4MUApAmfVsnrMbEAqVnmUHRpJQ/JSq675s/S72q6ViL
         QXg+WaC+dbfUUOGF0aEOuEza/bipE5oPPrWih0sfc3IJq9ZrP8qNESnVNMqmiaqhnV2B
         CSnw==
X-Gm-Message-State: AOAM53045tpxp18TmRZX0KHVgDMVGZlvAIWBU8qxXvrWPZqn+pWqI+kv
        CjsT7aM3b+OnJnGShvcXaxk=
X-Google-Smtp-Source: ABdhPJygLiU1TaMZSfqG+5GSigI9EihxCd9eKQC+fHaOAOxWo17rndxSetyrTrwlAkIOBuGOwgEIUw==
X-Received: by 2002:a05:6402:d66:: with SMTP id ec38mr10748872edb.212.1624576075493;
        Thu, 24 Jun 2021 16:07:55 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id w17sm1803786ejk.112.2021.06.24.16.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 16:07:55 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH v2 01/24] pack-bitmap.c: harden 'test_bitmap_walk()' to
 check type bitmaps
Date:   Fri, 25 Jun 2021 01:02:56 +0200
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <a18baeb0b42994ebcb216df5fe69459ba9a33795.1624314293.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <a18baeb0b42994ebcb216df5fe69459ba9a33795.1624314293.git.me@ttaylorr.com>
Message-ID: <87k0mizws5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 21 2021, Taylor Blau wrote:

> +	enum object_type bitmap_type = OBJ_NONE;
> +	int bitmaps_nr = 0;
> +
> +	if (bitmap_get(tdata->commits, pos)) {
> +		bitmap_type = OBJ_COMMIT;
> +		bitmaps_nr++;
> +	}
> +	if (bitmap_get(tdata->trees, pos)) {
> +		bitmap_type = OBJ_TREE;
> +		bitmaps_nr++;
> +	}
> +	if (bitmap_get(tdata->blobs, pos)) {
> +		bitmap_type = OBJ_BLOB;
> +		bitmaps_nr++;
> +	}
> +	if (bitmap_get(tdata->tags, pos)) {
> +		bitmap_type = OBJ_TAG;
> +		bitmaps_nr++;
> +	}

This made me wonder if this could be better with something like the
HAS_MULTI_BITS() macro, but that trick probably can't be applied here in
any shape or form :)

> +
> +	if (!bitmap_type)
> +		die("object %s not found in type bitmaps",
> +		    oid_to_hex(&obj->oid));

It feels a bit magical to use an enum and then assume to know the enum's
values, I know we do "type < 0" all over the place, but I'd think "if
(bitmap_type == OBJ_NONE)" would be better here....

> +
> +	if (bitmaps_nr > 1)
> +		die("object %s does not have a unique type",
> +		    oid_to_hex(&obj->oid));

Or just check the bitmaps_nr instead:

    if (!bitmaps_nr)
        die("found none");
    else if (bitmaps_nr > 1)
        ...;

Just bikeshedding...

> +
> +	if (bitmap_type != obj->type)
> +		die("object %s: real type %s, expected: %s",
> +		    oid_to_hex(&obj->oid),
> +		    type_name(obj->type),
> +		    type_name(bitmap_type));

To argue against myself (sort of) about that "== OBJ_NONE" above, if
we're not assuming that then it's sort of weird not to also assume that
type_name(type) won't return a NULL in the case of OBJ_NONE, which it
does (but this code guards against).
