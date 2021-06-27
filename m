Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297E0C48BC2
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 10:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECAD161C21
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 10:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbhF0KZ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Jun 2021 06:25:58 -0400
Received: from mout.web.de ([212.227.17.12]:48053 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229761AbhF0KZ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jun 2021 06:25:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1624789399;
        bh=l1CSeRV1KLxp2NZL5cRGTrXKzJmSyxV7BH0rxDinQzo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=KJG8fmNefrECfgIq4D3KN6ZLIqpQC5y9h+DULsVLIYPBDsZ1/N9aUCfPZe+DBJPxf
         +YuJX5uyCwzrhrO668QES33nLsndCzNoFZHsOidZHFOgseP5TmkuNWGY2sTNbFBUt8
         vHKs/UMYwJGB7nmOBvvRFvi0W0UxEZzVK0g8ZLik=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([91.47.158.105]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1N01ds-1l3xdh0qOs-00x71P; Sun, 27 Jun 2021 12:23:19 +0200
Subject: Re: [PATCH 3/5] make object_directory.loose_objects_subdir_seen a
 bitmap
To:     Eric Wong <e@80x24.org>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
References: <20210627024718.25383-1-e@80x24.org>
 <20210627024718.25383-4-e@80x24.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <496545dc-e372-401c-13f4-daa7ee765d39@web.de>
Date:   Sun, 27 Jun 2021 12:23:18 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210627024718.25383-4-e@80x24.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BxDhxPTBAI/A8SVBcpe9MB4G6AqXOa28e1CFnHAICoeE/5PxcpD
 F19L8ZJsjZHGtSGXrVYU/tWOVHMfCuxTDqHPbiX9bopQX2xRjNCxQ1/vA1W/4+JoqIq2s/1
 3aK8p9Fi+Lrp9Dm+zof95s6X9P/6r7dVzu3eOPN4SFvB8ifSjQ/P1ETW0wpaMNp7wmce1aT
 jxWtcykPZtnckOWAYy4iw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kfhOsj9ZN4s=:u5dTjSPqADVPnoZWCRvo8c
 bfz8Kp/JOclUVRycP90unbvVy76r+f1oYTXvrnrWRiov3/cJSKeyJdzEGWCk5CclEVb5etkMO
 T3eH9eO4GOd8CX4iM7MvtMrPxFQcTCRAH2nQYS953fthi2vy38wurXwP+u0qCCxNBzmVGW5Fc
 9sJupWFriuOLuUuUApq+fmKNF70odVCEUbQCX6+PSYfJ2xD66B5qnE1EiGr3Wcbsgj89oLj42
 jXxR9x+/bbCFlxzzVwXwNLtfnjixv4l5I+QqaBoS1ooTfahdV+shWvti5QmLKrncbvK/z8nSR
 dHqpQpsUo3UaAK4c0/c/VPYlEr85dqkUKAaIv6wrXukLNXchuzDMfST4sAmgpA6pAnVqrmBll
 xGvRFgx36HAhOA9C0xtdZpw86IIXOg5nUeQspMa3gc2pG2MFzGdtkzU8L8itjyDsPLiV4s5+E
 P7ysqriBAx36Xbpno0+h3UE3afZd2oADm8pU9WhCytoiq97RcKHe0zbY02iT+jhmj3ghQayLk
 s8WtRGyOXEwu6QDdxSTiTMAJwgX1Du2sAc7Gcg9hI9rlYP5jvXoaiQXE8lz3Z8zuogDB9dD2K
 51Uuzto1H9bUy5m3tDrikqoN51A9rwquj02Y8ssIaQAo/W1HAmrXyDIVQE9kpHWyEoX401ARa
 iawVraMuQA98cTXvjiszjwopSsJE10gjwHEkNP4rUcomfO8tNDuhNOlLZ1zvm0S/3u9vyxr7g
 FLghF6jdhA/k+Guy9/uonflTjNFePVIiE4YIwRtezFQYy7ZikWgZCuDCfG/MFjWlxNw2ffht6
 COWcF1WYOQS0DvN6AcmxuD9cDuEnvgiHvwL2j+XLJsF453lhIgm1OIsYA446vg82nORNIDZTp
 UKghpjfDh7yE1r5xA/U3QqUhujG1HlAki/SCogl30GDjS2hy4mSP4Z+rMRt4pN3fqzY4T5EQc
 84PWtvbYebeDHIXsnZDVivvdhTXICJvXOma8VfICII56jWKt63MBoN5sFlvsiUYi5g954ENoI
 p2f8tVBQQB6evrafFqRw+MwYFSFWaZVndBa7+U48atrEATcX8dCjHjEvQq9feT+Ili60OrV07
 vK72PdN/3m99+0BgeL0pn2piN6HAYZybUXP
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.06.21 um 04:47 schrieb Eric Wong:
> There's no point in using 8 bits per-directory when 1 bit
> will do.  This saves us 224 bytes per object directory, which
> ends up being 22MB when dealing with 100K alternates.

The point was simplicity under the assumption that the number of
repositories is low -- for most users it's only one.  That obviously
doesn't hold for your use case anymore. :)

A compact representation should also reduce dcache misses, so this
should be a win for the single-repo case as well.

> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>  object-file.c  | 10 +++++++---
>  object-store.h |  2 +-
>  2 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/object-file.c b/object-file.c
> index 6be43c2b60..2c8b9c05f9 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -2463,12 +2463,16 @@ struct oid_array *odb_loose_cache(struct object_=
directory *odb,
>  {
>  	int subdir_nr =3D oid->hash[0];
>  	struct strbuf buf =3D STRBUF_INIT;
> +	size_t BM_SIZE =3D sizeof(odb->loose_objects_subdir_seen[0]) * CHAR_BI=
T;

With that name I'd expect the variable to contain the number of bytes or
bits in the whole bitmap.  And to not be a variable at all, but rather a
macro.  Perhaps word_bits?

bitsizeof() does the same and is slightly shorter.

> +	uint32_t *bitmap;

Ah, you call the array items bitmap, which they are.  Hmm.  I rather
think of the whole thing as a bitmap and its uint32_t elements as words.
Does it matter?  Not sure.

> +	uint32_t bit =3D 1 << (subdir_nr % BM_SIZE);

I'd call that mask, but bit is fine as well..

Anyway, it would look something like this:

	size_t word_bits =3D bitsizeof(odb->loose_objects_subdir_seen[0]);
	size_t word_index =3D subdir_nr / word_bits;
	size_t mask =3D 1 << (subdir_nr % word_bits);

>
>  	if (subdir_nr < 0 ||
> -	    subdir_nr >=3D ARRAY_SIZE(odb->loose_objects_subdir_seen))
> +	    subdir_nr >=3D ARRAY_SIZE(odb->loose_objects_subdir_seen) * BM_SIZ=
E)

bitsizeof(odb->loose_objects_subdir_seen) would be easier to read and
understand, I think.

>  		BUG("subdir_nr out of range");
>
> -	if (odb->loose_objects_subdir_seen[subdir_nr])
> +	bitmap =3D &odb->loose_objects_subdir_seen[subdir_nr / BM_SIZE];
> +	if (*bitmap & bit)
>  		return &odb->loose_objects_cache[subdir_nr];
>
>  	strbuf_addstr(&buf, odb->path);
> @@ -2476,7 +2480,7 @@ struct oid_array *odb_loose_cache(struct object_di=
rectory *odb,
>  				    append_loose_object,
>  				    NULL, NULL,
>  				    &odb->loose_objects_cache[subdir_nr]);
> -	odb->loose_objects_subdir_seen[subdir_nr] =3D 1;
> +	*bitmap |=3D bit;
>  	strbuf_release(&buf);
>  	return &odb->loose_objects_cache[subdir_nr];
>  }
> diff --git a/object-store.h b/object-store.h
> index 20c1cedb75..8fcddf3e65 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -22,7 +22,7 @@ struct object_directory {
>  	 *
>  	 * Be sure to call odb_load_loose_cache() before using.
>  	 */
> -	char loose_objects_subdir_seen[256];
> +	uint32_t loose_objects_subdir_seen[8]; /* 256 bits */

Perhaps	DIV_ROUND_UP(256, bitsizeof(uint32_t))?  The comment explains
it nicely already, though.

>  	struct oid_array loose_objects_cache[256];
>
>  	/*
>

Summary: Good idea, the implementation looks correct, I stumbled
over some of the names, bitsizeof() could be used.

Ren=C3=A9
