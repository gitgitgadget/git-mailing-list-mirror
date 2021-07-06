Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C71C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 19:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0F4861C20
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 19:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhGFTkV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 15:40:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62659 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhGFTkV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 15:40:21 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F5E5C1467;
        Tue,  6 Jul 2021 15:37:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=5EnKzMhy5i63
        n1+xtNrlsahhRaJQqzAoCeLGWcH6Chw=; b=NnrSl5Oe+P95sGoGsAwwq8RdHyiI
        t2woRslbnhRPgGyo7BVsm4Qh+BatvHHzIuVM+j2Mn825tfMvG1odz/gtataneVPN
        xxyGm2BzzvScO6fGL6/SBUL7Rzf69Tm3WM0zx65+orKEhP2Mdf1Z/vvzYGHhNZqQ
        fhnU8IzjnReUz34=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2592CC1466;
        Tue,  6 Jul 2021 15:37:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A02B0C1465;
        Tue,  6 Jul 2021 15:37:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v4 5/6] refs: explicitly return failure_errno from
 parse_loose_ref_contents
References: <pull.1012.v3.git.git.1625518566.gitgitgadget@gmail.com>
        <pull.1012.v4.git.git.1625597757.gitgitgadget@gmail.com>
        <ab147afb38d6e74e0e2fc1fbb83346e6ee32cdd5.1625597757.git.gitgitgadget@gmail.com>
Date:   Tue, 06 Jul 2021 12:37:40 -0700
In-Reply-To: <ab147afb38d6e74e0e2fc1fbb83346e6ee32cdd5.1625597757.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Tue, 06 Jul 2021
        18:55:56 +0000")
Message-ID: <xmqqfswrjksb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A0F12888-DE91-11EB-B921-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> The EINVAL error from parse_loose_ref_contents is used in files-backend
> to create a custom error message.
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> Reviewed-By: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

I think a -By in the trailer is spelled with lowercase, i.e. "Reviewed-by=
".

> ---
>  refs.c               |  8 +++++---
>  refs/files-backend.c | 13 +++++++++----
>  refs/refs-internal.h |  6 ++++--
>  3 files changed, 18 insertions(+), 9 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 25d80e544d0..eca7310e7a4 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1653,7 +1653,8 @@ int for_each_fullref_in_prefixes(const char *name=
space,
> =20
>  static int refs_read_special_head(struct ref_store *ref_store,
>  				  const char *refname, struct object_id *oid,
> -				  struct strbuf *referent, unsigned int *type)
> +				  struct strbuf *referent, unsigned int *type,
> +				  int *failure_errno)
>  {
>  	struct strbuf full_path =3D STRBUF_INIT;
>  	struct strbuf content =3D STRBUF_INIT;
> @@ -1663,7 +1664,8 @@ static int refs_read_special_head(struct ref_stor=
e *ref_store,
>  	if (strbuf_read_file(&content, full_path.buf, 0) < 0)
>  		goto done;
> =20
> -	result =3D parse_loose_ref_contents(content.buf, oid, referent, type)=
;
> +	result =3D parse_loose_ref_contents(content.buf, oid, referent, type,
> +					  failure_errno);
> =20
>  done:
>  	strbuf_release(&full_path);
> @@ -1683,7 +1685,7 @@ int refs_read_raw_ref(struct ref_store *ref_store=
, const char *refname,
> =20
>  	if (!strcmp(refname, "FETCH_HEAD") || !strcmp(refname, "MERGE_HEAD"))=
 {
>  		return refs_read_special_head(ref_store, refname, oid, referent,
> -					      type);
> +					      type, failure_errno);
>  	}
> =20
>  	return ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index f38c9703504..b43ec4c66cb 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -455,9 +455,13 @@ stat_ref:
>  	strbuf_rtrim(&sb_contents);
>  	buf =3D sb_contents.buf;
> =20
> -	ret =3D parse_loose_ref_contents(buf, oid, referent, type);
> -
> +	ret =3D parse_loose_ref_contents(buf, oid, referent, type, failure_er=
rno);
> +	errno =3D *failure_errno;

All of the above makes sense.

>  out:
> +	/* Collect all types of failures from errno. Many system calls in thi=
s
> +	 * function can fail with ENOTDIR/EISDIR, and we want to collect all =
of
> +	 * them.
> +	 */

Style.

>  	*failure_errno =3D errno;
>  	strbuf_release(&sb_path);
>  	strbuf_release(&sb_contents);
> @@ -465,7 +469,8 @@ out:
>  }
> =20
>  int parse_loose_ref_contents(const char *buf, struct object_id *oid,
> -			     struct strbuf *referent, unsigned int *type)
> +			     struct strbuf *referent, unsigned int *type,
> +			     int *failure_errno)
>  {
>  	const char *p;
>  	if (skip_prefix(buf, "ref:", &buf)) {
> @@ -484,7 +489,7 @@ int parse_loose_ref_contents(const char *buf, struc=
t object_id *oid,
>  	if (parse_oid_hex(buf, oid, &p) ||
>  	    (*p !=3D '\0' && !isspace(*p))) {
>  		*type |=3D REF_ISBROKEN;
> -		errno =3D EINVAL;
> +		*failure_errno =3D EINVAL;
>  		return -1;
>  	}

OK.

>  	return 0;
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index 54f57c6a2df..bf581e70cf6 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -689,10 +689,12 @@ struct ref_store {
>  };
> =20
>  /*
> - * Parse contents of a loose ref file.
> + * Parse contents of a loose ref file. *failure_errno maybe be set to =
EINVAL for
> + * invalid contents.
>   */

OK.

>  int parse_loose_ref_contents(const char *buf, struct object_id *oid,
> -			     struct strbuf *referent, unsigned int *type);
> +			     struct strbuf *referent, unsigned int *type,
> +			     int *failure_errno);
> =20
>  /*
>   * Fill in the generic part of refs and add it to our collection of
