Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4187C433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 23:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A64864E68
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 23:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbhBQXk5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 18:40:57 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64760 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbhBQXkw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 18:40:52 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 23754A947B;
        Wed, 17 Feb 2021 18:40:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=w/PQ+67+bVrJ
        rsa04ge29T5lLsE=; b=gnOuv8Q1fdb1W3wM9jHWfjZAJIHH1PkaEDcH59DlcdzQ
        V1gTmMFjN019HsbEQN19FYmQEdPyroMCoUQvEIwB09zGrmCtq19FE9uLocrORqVn
        F0Zj7uJhgrLcWgqs2Xx6UJaQPTEBkT3Si/QkBNovJYM2uRxfDmdLTGU0I+Jcubk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=OiTVrY
        Xo+wKWEP/IK8bYbo0Rc2QqNZYAcKnbLJHuLxnBiLeJv4ENw0B7naxEtKYm6ODoiL
        pfVPJqyM5hZr+DOHKm/qQwBBQZOLROZmVg/wvNPgVDeKjnofToNzsdRP2l2zw4PS
        kG+f69JLbHyaL+4gwOYFKtFpwRivCTWniuo0I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 19021A9479;
        Wed, 17 Feb 2021 18:40:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0CC38A9478;
        Wed, 17 Feb 2021 18:40:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 02/14] fsck.h: use use "enum object_type" instead of "int"
References: <87blcja2ha.fsf@evledraar.gmail.com>
        <20210217194246.25342-3-avarab@gmail.com>
Date:   Wed, 17 Feb 2021 15:40:08 -0800
In-Reply-To: <20210217194246.25342-3-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 17 Feb 2021 20:42:34 +0100")
Message-ID: <xmqqczwyi7qf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 787748C2-7179-11EB-B46C-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Subject: Re: [PATCH 02/14] fsck.h: use use "enum object_type" instead o=
f "int"

use use.

> Change the fsck_walk_func to use an "enum object_type" instead of an
> "int" type. The types are compatible, and ever since this was added in
> 355885d5315 (add generic, type aware object chain walker, 2008-02-25)
> we've used entries from object_type (OBJ_BLOB etc.).
>
> So this doesn't really change anything as far as the generated code is
> concerned, it just gives the compiler more information and makes this
> easier to read.

Yup, as long as we won't trick the compiler into complaining "ah,
but you are not covering OBJ_OFS_DELTA or OBJ_BAD values in your
switch statement", I think a change like this is a good thing.

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  builtin/fsck.c           | 3 ++-
>  builtin/index-pack.c     | 3 ++-
>  builtin/unpack-objects.c | 3 ++-
>  fsck.h                   | 3 ++-
>  4 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 821e7798c70..68f0329e69e 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -197,7 +197,8 @@ static int traverse_reachable(void)
>  	return !!result;
>  }
> =20
> -static int mark_used(struct object *obj, int type, void *data, struct =
fsck_options *options)
> +static int mark_used(struct object *obj, enum object_type object_type,
> +		     void *data, struct fsck_options *options)
>  {
>  	if (!obj)
>  		return 1;
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 54f74c48741..2f291a14d4a 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -212,7 +212,8 @@ static void cleanup_thread(void)
>  	free(thread_data);
>  }
> =20
> -static int mark_link(struct object *obj, int type, void *data, struct =
fsck_options *options)
> +static int mark_link(struct object *obj, enum object_type type,
> +		     void *data, struct fsck_options *options)
>  {
>  	if (!obj)
>  		return -1;
> diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
> index dd4a75e030d..ca54fd16688 100644
> --- a/builtin/unpack-objects.c
> +++ b/builtin/unpack-objects.c
> @@ -187,7 +187,8 @@ static void write_cached_object(struct object *obj,=
 struct obj_buffer *obj_buf)
>   * that have reachability requirements and calls this function.
>   * Verify its reachability and validity recursively and write it out.
>   */
> -static int check_object(struct object *obj, int type, void *data, stru=
ct fsck_options *options)
> +static int check_object(struct object *obj, enum object_type type,
> +			void *data, struct fsck_options *options)
>  {
>  	struct obj_buffer *obj_buf;
> =20
> diff --git a/fsck.h b/fsck.h
> index df0b64a2163..0c75789d219 100644
> --- a/fsck.h
> +++ b/fsck.h
> @@ -23,7 +23,8 @@ int is_valid_msg_type(const char *msg_id, const char =
*msg_type);
>   *     <0	error signaled and abort
>   *     >0	error signaled and do not abort
>   */
> -typedef int (*fsck_walk_func)(struct object *obj, int type, void *data=
, struct fsck_options *options);
> +typedef int (*fsck_walk_func)(struct object *obj, enum object_type obj=
ect_type,
> +			      void *data, struct fsck_options *options);
> =20
>  /* callback for fsck_object, type is FSCK_ERROR or FSCK_WARN */
>  typedef int (*fsck_error)(struct fsck_options *o,
