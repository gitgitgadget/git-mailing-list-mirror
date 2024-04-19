Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFA638D
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 09:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713519637; cv=none; b=h+cF+oQ2mhQqo18N/IGzNNuSlkx7SAxBgVlN0Yf2HPDdC95FGumh6sCEhsWvT8pQtKhuG+jJ+7cfPU5PzNfWq74HPSrh5AWYYRedRPgyeSNMPhPaQG8fA4rXMswMMlXmJZVpU1HzHAiu+qdg/QfACxwXHVsF/80VNJBmJ97KPyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713519637; c=relaxed/simple;
	bh=eEYyrcFAtdtfjMvIlCoCsa3S2vajSmUivBro+KMTirE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHDBT+KXwEHz41/xvgk5oZBoFkpiZnGfbSw4BInJamytBT2dH0CaV63HUKfOIXTll0dnS+nJBdVyb8EYKvcFW0i0uDgQfMi7KWWOAzORBkmAdaYxQgEQQgjN8DNyzGoJFGjF2JA8FQIQbYh+U7gf1AIs0RmyfFYbnlLbTsAC1BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e6UAGPfe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lpgnwptv; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e6UAGPfe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lpgnwptv"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id E26E61C00114;
	Fri, 19 Apr 2024 05:40:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 19 Apr 2024 05:40:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713519633; x=1713606033; bh=nDJ+HLo43p
	O4Eaax7PPJZtK1bsM8elxI9olmufLUz0Q=; b=e6UAGPfeRuZbypzcp283lfz372
	J9k2BC4k6GIjtAsZtyMwBPtITATBbjDBzn7YVwta4kFmwx+KYj3PRqA4jYN9QNq9
	O+eQbU20WwgfigBasABpwy6T0UWlRYR4dWdKX0iTI45IRKAs1b6ZDSEXBUbswHsv
	LtE0S3QaVkio/lUXpbCcC9m/FzRjoCtcMAa6POMVWVnD7nHNkslePm8JLYAtBIcd
	TovnZow9RVMHZPop9OG8JheW/vo4VO9v/KXmSF1uXr5T71hAuxUHMdFc5M33WDzf
	gUd8lDgrEsynpWqsMVF03q1wALBO5SbFeY3qtRx/e8p666QDTJ3RHznjW1WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713519633; x=1713606033; bh=nDJ+HLo43pO4Eaax7PPJZtK1bsM8
	elxI9olmufLUz0Q=; b=LpgnwptvwdVI7i69+FgEEo+22N5RdqjOMRoufa6Ma8Xo
	87ydpS83el4wH+1BiRSWi5f8A7Kqo5YMJ0U7U0BxviMDx6sLgm2MXr482Ga3kA7H
	WaeQcyHNP0eoJu0tqvuj76+dpQN9QPd3AxdHV7+Udtb84s3tFZtsHf5XCi8S9FSm
	sPAU4nNVEjjOxZ+H/JWAGnCnVdZxJcs1rfad7LFkUB/DA2Li+Hg45rXfC04bFO10
	ptXc6BmOAQsmhwA1OqOiPuCsk8GGUvQTxdIJ4vQfhz5rFtvv3Dr4VdOaVRoYmr3+
	z+6VGTUq934TzHJus+ujD7dKECCSHN/aRzmU5OtUlA==
X-ME-Sender: <xms:ETwiZsJvRlmj7q7HDop20HDUUW82F5ffXtmpVQ8jvuX2ud3oSRx0Cw>
    <xme:ETwiZsL9M9ZLHO2bklElpUfccpvoOQwT3h3YPliId--_zJchoOvXEm_lKDGojNNPD
    tgwl3pz893AQgzXDw>
X-ME-Received: <xmr:ETwiZsuvVwxs_OVO4NZ3kniOgHAGBbSenm0TtIi1kwB2HTOjJz7v65zdtUhoH2a9cJi-miJmMF7wlcdUcITH3bFm43wyEG7_1x2bC3iP6Tc3M9dWOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekvddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:ETwiZpanTWfno82_uQDr-HQPYYgHVKO6I1ZvEuORj-LxkiReyZ4gLw>
    <xmx:ETwiZjbjLI8LN8xH2OtbVrkZTNwBT04GJ3D2I9BAPdphmsMAgshHIA>
    <xmx:ETwiZlDe7RQuBGYAZyLo0FgO0BLi8dhDm9l2LvcAFetSf8PGF6_72A>
    <xmx:ETwiZpYZYWOuvAnE7DTGDf8lQ6yc3pb-CXhtD1feY_nY5a4Fk1l_aQ>
    <xmx:ETwiZiUFCFCChQWbFQISiVh4BiX_Q1TCKx8C1ww4s8VxrdB_5Enskup4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Apr 2024 05:40:32 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 3895f89c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Apr 2024 09:40:05 +0000 (UTC)
Date: Fri, 19 Apr 2024 11:40:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: chris.torek@gmail.com, git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 2/7] update-ref: add support for symref-verify
Message-ID: <ZiI8DmqrbvdCDWt0@tanuki>
References: <20240330224623.579457-1-knayak@gitlab.com>
 <20240412095908.1134387-1-knayak@gitlab.com>
 <20240412095908.1134387-3-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hwATlVxtBxC/WLXk"
Content-Disposition: inline
In-Reply-To: <20240412095908.1134387-3-knayak@gitlab.com>


--hwATlVxtBxC/WLXk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 11:59:03AM +0200, Karthik Nayak wrote:
> From: Karthik Nayak <karthik.188@gmail.com>
>=20
> In the previous commit, we added the required base for adding symref
> support in transactions provided by the 'git-update-ref(1)'. This commit
> introduces the 'symref-verify' command which is similar to the existing
> 'verify' command for regular refs.
>=20
> The 'symref-verify' command allows users to verify if a provided <ref>
> contains the provided <old-ref> without changing the <ref>. If <old-ref>
> is not provided, the command will verify that the <ref> doesn't exist.
> Since we're checking for symbolic refs, this command will only work with
> the 'no-deref' mode. This is because any dereferenced symbolic ref will
> point to an object and not a ref and the regular 'verify' command can be
> used in such situations.
>=20
> This commit adds all required helper functions required to also
> introduce the other symref commands, namely create, delete, and update.
> We also add tests to test the command in both the regular stdin mode and
> also with the '-z' flag.
>=20
> When the user doesn't provide a <old-ref> we need to check that the
> provided <ref> doesn't exist. And to do this, we take over the existing
> understanding that <old-oid> when set to its zero value, it refers to
> the ref not existing. While this seems like a mix of contexts between
> using <*-ref> and <*-oid>, this actually works really well, especially
> considering the fact that we want to eventually also introduce
>=20
>     symref-update SP <ref> SP <new-ref> [SP (<old-oid> | <old-rev>)] LF
>=20
> and here, we'd allow the user to update a regular <ref> to a symref and
> use <old-oid> to check the <ref>'s oid. This can be extrapolated to the
> user using this to create a symref when provided a zero <old-oid>. Which
> will work given how we're setting it up.
>=20
> We also disable the reference-transaction hook for symref-updates which
> will be tackled in its own commit.
>=20
> Add required tests for 'symref-verify' while also adding reflog checks for
> the pre-existing 'verify' tests.
>=20
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  Documentation/git-update-ref.txt |  7 +++
>  builtin/update-ref.c             | 82 ++++++++++++++++++++++++++++----
>  refs.c                           | 37 +++++++++++---
>  refs.h                           |  1 +
>  refs/files-backend.c             | 46 +++++++++++++++++-
>  refs/refs-internal.h             |  7 +++
>  refs/reftable-backend.c          | 23 ++++++++-
>  t/t1400-update-ref.sh            | 80 ++++++++++++++++++++++++++++++-
>  8 files changed, 262 insertions(+), 21 deletions(-)
>=20
> diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-=
ref.txt
> index 374a2ebd2b..749aaa7892 100644
> --- a/Documentation/git-update-ref.txt
> +++ b/Documentation/git-update-ref.txt
> @@ -65,6 +65,7 @@ performs all modifications together.  Specify commands =
of the form:
>  	create SP <ref> SP <new-oid> LF
>  	delete SP <ref> [SP <old-oid>] LF
>  	verify SP <ref> [SP <old-oid>] LF
> +	symref-verify SP <ref> [SP <old-ref>] LF
>  	option SP <opt> LF
>  	start LF
>  	prepare LF
> @@ -86,6 +87,7 @@ quoting:
>  	create SP <ref> NUL <new-oid> NUL
>  	delete SP <ref> NUL [<old-oid>] NUL
>  	verify SP <ref> NUL [<old-oid>] NUL
> +	symref-verify SP <ref> [NUL <old-ref>] NUL
>  	option SP <opt> NUL
>  	start NUL
>  	prepare NUL
> @@ -117,6 +119,11 @@ verify::
>  	Verify <ref> against <old-oid> but do not change it.  If
>  	<old-oid> is zero or missing, the ref must not exist.
> =20
> +symref-verify::
> +	Verify symbolic <ref> against <old-ref> but do not change it.
> +	If <old-ref> is missing, the ref must not exist.  Can only be
> +	used in `no-deref` mode.

Should this say "is zero or missing", like the comment for "verify"
does?

[snip]
> @@ -297,11 +321,48 @@ static void parse_cmd_verify(struct ref_transaction=
 *transaction,
>  		die("verify %s: extra input: %s", refname, next);
> =20
>  	if (ref_transaction_verify(transaction, refname, &old_oid,
> -				   update_flags, &err))
> +				   NULL, update_flags, &err))
> +		die("%s", err.buf);
> +
> +	update_flags =3D default_flags;
> +	free(refname);
> +	strbuf_release(&err);
> +}
> +
> +static void parse_cmd_symref_verify(struct ref_transaction *transaction,
> +                                    const char *next, const char *end)
> +{
> +	struct strbuf err =3D STRBUF_INIT;
> +	struct object_id old_oid;
> +	char *refname, *old_ref;
> +
> +	if (!(update_flags & REF_NO_DEREF))
> +		die("symref-verify: cannot operate with deref mode");

This feels quite restrictive to me. Wouldn't it be preferable to simply
ignore `REF_NO_DEREF` here? It basically means that this command can't
ever be used in a normal `git update-ref --stdin` session.

> +	refname =3D parse_refname(&next);
> +	if (!refname)
> +		die("symref-verify: missing <ref>");
> +
> +	/*
> +	 * old_ref is optional, but we want to differentiate between
> +	 * a NULL and zero value.
> +	 */
> +	old_ref =3D parse_next_refname(&next);
> +	if (!old_ref)
> +		old_oid =3D *null_oid();
> +	else if (read_ref(old_ref, NULL))
> +		die("symref-verify %s: invalid <old-ref>", refname);
> +
> +	if (*next !=3D line_termination)
> +		die("symref-verify %s: extra input: %s", refname, next);
> +
> +	if (ref_transaction_verify(transaction, refname, old_ref ? NULL : &old_=
oid,
> +				   old_ref, update_flags | REF_SYMREF_UPDATE, &err))
>  		die("%s", err.buf);
> =20
>  	update_flags =3D default_flags;
>  	free(refname);
> +	free(old_ref);
>  	strbuf_release(&err);
>  }
> =20
> @@ -380,15 +441,16 @@ static const struct parse_cmd {
>  	unsigned args;
>  	enum update_refs_state state;
>  } command[] =3D {
> -	{ "update",  parse_cmd_update,  3, UPDATE_REFS_OPEN },
> -	{ "create",  parse_cmd_create,  2, UPDATE_REFS_OPEN },
> -	{ "delete",  parse_cmd_delete,  2, UPDATE_REFS_OPEN },
> -	{ "verify",  parse_cmd_verify,  2, UPDATE_REFS_OPEN },
> -	{ "option",  parse_cmd_option,  1, UPDATE_REFS_OPEN },
> -	{ "start",   parse_cmd_start,   0, UPDATE_REFS_STARTED },
> -	{ "prepare", parse_cmd_prepare, 0, UPDATE_REFS_PREPARED },
> -	{ "abort",   parse_cmd_abort,   0, UPDATE_REFS_CLOSED },
> -	{ "commit",  parse_cmd_commit,  0, UPDATE_REFS_CLOSED },
> +	{ "update",        parse_cmd_update,        3, UPDATE_REFS_OPEN },
> +	{ "create",        parse_cmd_create,        2, UPDATE_REFS_OPEN },
> +	{ "delete",        parse_cmd_delete,        2, UPDATE_REFS_OPEN },
> +	{ "verify",        parse_cmd_verify,        2, UPDATE_REFS_OPEN },
> +	{ "symref-verify", parse_cmd_symref_verify, 2, UPDATE_REFS_OPEN },
> +	{ "option",        parse_cmd_option,        1, UPDATE_REFS_OPEN },
> +	{ "start",         parse_cmd_start,         0, UPDATE_REFS_STARTED },
> +	{ "prepare",       parse_cmd_prepare,       0, UPDATE_REFS_PREPARED },
> +	{ "abort",         parse_cmd_abort,         0, UPDATE_REFS_CLOSED },
> +	{ "commit",        parse_cmd_commit,        0, UPDATE_REFS_CLOSED },
>  };
> =20
>  static void update_refs_stdin(void)
> diff --git a/refs.c b/refs.c
> index 967c81167e..124b294c9f 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -19,6 +19,7 @@
>  #include "object-store-ll.h"
>  #include "object.h"
>  #include "path.h"
> +#include "string.h"
>  #include "tag.h"
>  #include "submodule.h"
>  #include "worktree.h"
> @@ -29,6 +30,7 @@
>  #include "date.h"
>  #include "commit.h"
>  #include "wildmatch.h"
> +#include "wrapper.h"
> =20
>  /*
>   * List of all available backends
> @@ -1217,6 +1219,7 @@ void ref_transaction_free(struct ref_transaction *t=
ransaction)
> =20
>  	for (i =3D 0; i < transaction->nr; i++) {
>  		free(transaction->updates[i]->msg);
> +		free((void *)transaction->updates[i]->old_ref);
>  		free(transaction->updates[i]);
>  	}
>  	free(transaction->updates);
> @@ -1242,10 +1245,19 @@ struct ref_update *ref_transaction_add_update(
> =20
>  	update->flags =3D flags;
> =20
> -	if (flags & REF_HAVE_NEW)
> -		oidcpy(&update->new_oid, new_oid);
> -	if (flags & REF_HAVE_OLD)
> -		oidcpy(&update->old_oid, old_oid);
> +	/*
> +	 * The ref values are to be considered over the oid values when we're
> +	 * doing symref operations.
> +	 */

I feel like this is a statement that should be backed up by a deeper
explanation of why that is. I'm still wondering here why we cannot
assert that the old value is an object ID when I want to update it to a
symref, or alternatively why it would even be possible to have both
`REF_SYMREF_UPDATE` and a set of other, incompatible fields set. It
feels like this should be a `BUG()` instead if this is supposedly an
unsupported configuration rather than silently ignoring it.

In any case, I feel like it would be easier to reason about if this was
introduced together with the actual user. As far as I can see this code
shouldn't ever be hit for "verify-symref", right? Currently, the reader
is forced to figure out what is and isn't related to the new command.

> +	if (update->flags & REF_SYMREF_UPDATE) {
> +		if (old_ref)
> +			update->old_ref =3D xstrdup(old_ref);
> +	} else {
> +		if (flags & REF_HAVE_NEW)
> +			oidcpy(&update->new_oid, new_oid);
> +		if (flags & REF_HAVE_OLD)
> +			oidcpy(&update->old_oid, old_oid);
> +	}
>  	update->msg =3D normalize_reflog_message(msg);
>  	return update;
>  }
> @@ -1280,6 +1292,7 @@ int ref_transaction_update(struct ref_transaction *=
transaction,
>  	flags &=3D REF_TRANSACTION_UPDATE_ALLOWED_FLAGS;
> =20
>  	flags |=3D (new_oid ? REF_HAVE_NEW : 0) | (old_oid ? REF_HAVE_OLD : 0);
> +	flags |=3D (new_ref ? REF_HAVE_NEW : 0) | (old_ref ? REF_HAVE_OLD : 0);
> =20
>  	ref_transaction_add_update(transaction, refname, flags,
>  				   new_oid, old_oid, new_ref, old_ref, msg);
> @@ -1318,14 +1331,17 @@ int ref_transaction_delete(struct ref_transaction=
 *transaction,
>  int ref_transaction_verify(struct ref_transaction *transaction,
>  			   const char *refname,
>  			   const struct object_id *old_oid,
> +			   const char *old_ref,
>  			   unsigned int flags,
>  			   struct strbuf *err)
>  {
> -	if (!old_oid)
> +	if (flags & REF_SYMREF_UPDATE && !old_ref && !old_oid)
> +		BUG("verify called with old_ref set to NULL");
> +	if (!(flags & REF_SYMREF_UPDATE) && !old_oid)
>  		BUG("verify called with old_oid set to NULL");
>  	return ref_transaction_update(transaction, refname,
>  				      NULL, old_oid,
> -				      NULL, NULL,
> +				      NULL, old_ref,
>  				      flags, NULL, err);
>  }
> =20
> @@ -2342,6 +2358,9 @@ static int run_transaction_hook(struct ref_transact=
ion *transaction,
>  	for (i =3D 0; i < transaction->nr; i++) {
>  		struct ref_update *update =3D transaction->updates[i];
> =20
> +		if (update->flags & REF_SYMREF_UPDATE)
> +			continue;
> +
>  		strbuf_reset(&buf);
>  		strbuf_addf(&buf, "%s %s %s\n",
>  			    oid_to_hex(&update->old_oid),
> @@ -2795,3 +2814,9 @@ int copy_existing_ref(const char *oldref, const cha=
r *newref, const char *logmsg
>  {
>  	return refs_copy_existing_ref(get_main_ref_store(the_repository), oldre=
f, newref, logmsg);
>  }
> +
> +int null_new_value(struct ref_update *update) {
> +	if (update->flags & REF_SYMREF_UPDATE && update->new_ref)
> +		return 0;
> +	return is_null_oid(&update->new_oid);
> +}
> diff --git a/refs.h b/refs.h
> index 645fe9fdb8..a988e672ff 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -772,6 +772,7 @@ int ref_transaction_delete(struct ref_transaction *tr=
ansaction,
>  int ref_transaction_verify(struct ref_transaction *transaction,
>  			   const char *refname,
>  			   const struct object_id *old_oid,
> +			   const char *old_ref,
>  			   unsigned int flags,
>  			   struct strbuf *err);
> =20
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index e4d0aa3d41..8421530bde 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2411,6 +2411,37 @@ static const char *original_update_refname(struct =
ref_update *update)
>  	return update->refname;
>  }
> =20
> +/*
> + * Check whether the REF_HAVE_OLD and old_ref values stored in update
> + * are consistent with ref, which is the symbolic reference's current
> + * value. If everything is OK, return 0; otherwise, write an error
> + * message to err and return -1.
> + */
> +static int check_old_ref(struct ref_update *update, char *ref,
> +			 struct strbuf *err)
> +{
> +	if (!(update->flags & REF_HAVE_OLD) ||
> +	    !strcmp(update->old_ref, ref))
> +		return 0;
> +
> +	if (!strcmp(update->old_ref, ""))
> +		strbuf_addf(err, "cannot lock ref '%s': "
> +			    "reference already exists",
> +			    original_update_refname(update));
> +	else if (!strcmp(ref, ""))
> +		strbuf_addf(err, "cannot lock ref '%s': "
> +			    "reference is missing but expected %s",
> +			    original_update_refname(update),
> +			    update->old_ref);
> +	else
> +		strbuf_addf(err, "cannot lock ref '%s': "
> +			    "is at %s but expected %s",
> +			    original_update_refname(update),
> +			    ref, update->old_ref);
> +
> +	return -1;
> +}
> +
>  /*
>   * Check whether the REF_HAVE_OLD and old_oid values stored in update
>   * are consistent with oid, which is the reference's current value. If
> @@ -2464,8 +2495,7 @@ static int lock_ref_for_update(struct files_ref_sto=
re *refs,
>  			       struct strbuf *err)
>  {
>  	struct strbuf referent =3D STRBUF_INIT;
> -	int mustexist =3D (update->flags & REF_HAVE_OLD) &&
> -		!is_null_oid(&update->old_oid);
> +	int mustexist =3D (update->flags & REF_HAVE_OLD) && !is_null_oid(&updat=
e->old_oid);

This change is a no-op, right? If so, let's rather drop it.

>  	int ret =3D 0;
>  	struct ref_lock *lock;
> =20
> @@ -2514,6 +2544,18 @@ static int lock_ref_for_update(struct files_ref_st=
ore *refs,
>  					ret =3D TRANSACTION_GENERIC_ERROR;
>  					goto out;
>  				}
> +			}
> +
> +			/*
> +			 * For symref verification, we need to check the referent value
> +			 * rather than the oid. If we're dealing with regular refs or we're
> +			 * verifying a dereferenced symref, we then check the oid.
> +			 */
> +			if (update->flags & REF_SYMREF_UPDATE && update->old_ref) {
> +				if (check_old_ref(update, referent.buf, err)) {
> +					ret =3D TRANSACTION_GENERIC_ERROR;
> +					goto out;
> +				}
>  			} else if (check_old_oid(update, &lock->old_oid, err)) {
>  				ret =3D TRANSACTION_GENERIC_ERROR;
>  				goto out;
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index 4c5fe02687..21c6b940d8 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -749,4 +749,11 @@ void base_ref_store_init(struct ref_store *refs, str=
uct repository *repo,
>   */
>  struct ref_store *maybe_debug_wrap_ref_store(const char *gitdir, struct =
ref_store *store);
> =20
> +/*
> + * Helper function to check if the new value is null, this
> + * takes into consideration that the update could be a regular
> + * ref or a symbolic ref.
> + */
> +int null_new_value(struct ref_update *update);

When adding it to the header we should probably prefix this to avoid
name collisions. `ref_update_is_null_new_value()` might be a mouth full,
but feels preferable to me.

>  #endif /* REFS_REFS_INTERNAL_H */
> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index 6104471199..7a03922c7b 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -938,7 +938,28 @@ static int reftable_be_transaction_prepare(struct re=
f_store *ref_store,
>  		 * individual refs. But the error messages match what the files
>  		 * backend returns, which keeps our tests happy.
>  		 */
> -		if (u->flags & REF_HAVE_OLD && !oideq(&current_oid, &u->old_oid)) {
> +		if ((u->flags & REF_HAVE_OLD) &&
> +		    (u->flags & REF_SYMREF_UPDATE) &&
> +		    u->old_ref) {
> +			if   (strcmp(referent.buf, u->old_ref)) {

s/   / /

> +				if (!strcmp(u->old_ref, ""))
> +					strbuf_addf(err, "cannot lock ref '%s': "
> +						    "reference already exists",
> +						    original_update_refname(u));
> +				else if (!strcmp(referent.buf, ""))
> +					strbuf_addf(err, "cannot lock ref '%s': "
> +						    "reference is missing but expected %s",
> +						    original_update_refname(u),
> +						    u->old_ref);
> +				else
> +					strbuf_addf(err, "cannot lock ref '%s': "
> +						    "is at %s but expected %s",
> +						    original_update_refname(u),
> +						    referent.buf, u->old_ref);

I'd use better-matching error messages here. I know that we talk about
"cannot lock ref" in the next branch, as well. But the only reason we
did this is to have the same error messages as the "files" backend.
Semantically, those errors don't make much sense as the "reftable"
backend never locks specific refs, but only the complete stack.

> +				ret =3D -1;
> +				goto done;
> +			}
> +		} else if (u->flags & REF_HAVE_OLD && !oideq(&current_oid, &u->old_oid=
)) {
>  			if (is_null_oid(&u->old_oid))
>  				strbuf_addf(err, _("cannot lock ref '%s': "
>  					    "reference already exists"),
> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index ec3443cc87..d8ffda4096 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -890,17 +890,23 @@ test_expect_success 'stdin update/create/verify com=
bination works' '
>  '
> =20
>  test_expect_success 'stdin verify succeeds for correct value' '
> +	test-tool ref-store main for-each-reflog-ent $m >before &&
>  	git rev-parse $m >expect &&
>  	echo "verify $m $m" >stdin &&
>  	git update-ref --stdin <stdin &&
>  	git rev-parse $m >actual &&
> -	test_cmp expect actual
> +	test_cmp expect actual &&
> +	test-tool ref-store main for-each-reflog-ent $m >after &&
> +	test_cmp before after
>  '
> =20
>  test_expect_success 'stdin verify succeeds for missing reference' '
> +	test-tool ref-store main for-each-reflog-ent $m >before &&
>  	echo "verify refs/heads/missing $Z" >stdin &&
>  	git update-ref --stdin <stdin &&
> -	test_must_fail git rev-parse --verify -q refs/heads/missing
> +	test_must_fail git rev-parse --verify -q refs/heads/missing &&
> +	test-tool ref-store main for-each-reflog-ent $m >after &&
> +	test_cmp before after
>  '

The updated tests merely assert that the refs didn't change, right?

>  test_expect_success 'stdin verify treats no value as missing' '
> @@ -1641,4 +1647,74 @@ test_expect_success PIPE 'transaction flushes stat=
us updates' '
>  	test_cmp expected actual
>  '
> =20
> +create_stdin_buf ()
> +{

The curly brace should go on the same line as the function name.

> +	if test "$1" =3D "-z"
> +	then
> +		shift
> +		printf "$F" "$@" >stdin
> +	else
> +		echo "$@" >stdin
> +	fi
> +}
> +
> +for type in "" "-z"
> +do

We should probably indent all of the tests to make it easier to see that
they run in a loop.

Patrick

> +test_expect_success "stdin ${type} symref-verify fails without --no-dere=
f" '
> +	git symbolic-ref refs/heads/symref $a &&
> +	create_stdin_buf ${type} "symref-verify refs/heads/symref" "$a" &&
> +	test_must_fail git update-ref --stdin ${type} <stdin 2>err &&
> +	grep "fatal: symref-verify: cannot operate with deref mode" err
> +'
> +
> +test_expect_success "stdin ${type} symref-verify fails with too many arg=
uments" '
> +	create_stdin_buf ${type} "symref-verify refs/heads/symref" "$a" "$a" &&
> +	test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err  =
&&
> +	if test "$type" =3D "-z"
> +	then
> +		grep "fatal: unknown command: $a" err
> +	else
> +		grep "fatal: symref-verify refs/heads/symref: extra input:  $a" err
> +	fi
> +'
> +
> +test_expect_success "stdin ${type} symref-verify succeeds for correct va=
lue" '
> +	git symbolic-ref refs/heads/symref >expect &&
> +	test-tool ref-store main for-each-reflog-ent refs/heads/symref >before =
&&
> +	create_stdin_buf ${type} "symref-verify refs/heads/symref" "$a" &&
> +	git update-ref --stdin ${type} --no-deref <stdin &&
> +	git symbolic-ref refs/heads/symref >actual &&
> +	test_cmp expect actual &&
> +	test-tool ref-store main for-each-reflog-ent refs/heads/symref >after &&
> +	test_cmp before after
> +'
> +
> +test_expect_success "stdin ${type} symref-verify succeeds for missing re=
ference" '
> +	test-tool ref-store main for-each-reflog-ent refs/heads/symref >before =
&&
> +	create_stdin_buf ${type} "symref-verify refs/heads/missing" &&
> +	git update-ref --stdin ${type} --no-deref <stdin &&
> +	test_must_fail git rev-parse --verify -q refs/heads/missing &&
> +	test-tool ref-store main for-each-reflog-ent refs/heads/symref >after &&
> +	test_cmp before after
> +'
> +
> +test_expect_success "stdin ${type} symref-verify fails for wrong value" '
> +	git symbolic-ref refs/heads/symref >expect &&
> +	create_stdin_buf ${type} "symref-verify refs/heads/symref" "$b" &&
> +	test_must_fail git update-ref --stdin ${type} --no-deref <stdin &&
> +	git symbolic-ref refs/heads/symref >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success "stdin ${type} symref-verify fails for mistaken null=
 value" '
> +	git symbolic-ref refs/heads/symref >expect &&
> +	create_stdin_buf ${type} "symref-verify refs/heads/symref" &&
> +	test_must_fail git update-ref --stdin ${type} --no-deref <stdin &&
> +	git symbolic-ref refs/heads/symref >actual &&
> +	test_cmp expect actual
> +'
> +
> +done
> +
>  test_done
> --=20
> 2.43.GIT
>=20

--hwATlVxtBxC/WLXk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYiPA0ACgkQVbJhu7ck
PpRd3w//dSSnH51V1G0b+ZoEb5B6bu97kBeV9HYRbmjG1vKKwa3+O2NDMXPLwA7Q
rUYCf+dCzEHqqluDq7zOnpKEZv+o6vOq9tbsgouyGHnftJwY6vbE+ZydYYC+yp9W
Uh16RIFqviOKxl9Wj6FQfRNNzWuSQhXJONB8Oj7WdA7+CajzLGMFK0oIyfoSclTY
7yJR5LgoWRqJl8OqMkfa5dx3izMLdY4FMjeWzjkBo6kj+LLnPoxUmdQIpWUy7de6
bJWVN+aQ1tb+dvqteHnY+VAp76b7AO3c/ci5PN1iJ6ETOeWyXGYENZoTJWB2/Eek
ct1DxmFULz2nEt/6rzJgYWVR7j67VjS9CtM4uXcDZ48iqqxRTPlCkjlM3x206SWf
MqavO3qnUvkjz1GTzpU7tupEoSjDsRVT7FfMOPm6++bSSKDz+05Vk0cCOj4Dy2/V
JfyGopnmkXejrnG8TYPd1ZKTVQWQbMbKa81XTR3MA5BwNNImRL7TxaGZIXlFVQ80
Ohuy4OEJWSskLYZ+MXeFP1SVklwV4IcwHEfPfBamcnLgrzGSYUNxEJMmUcYPWgwI
GKEgnGe+Pz3fW6feA5EU5KHKSUiQdReOV3/hpsUzPOMGMERZn6++7cGsgvs0hanW
QPr/ZxjU1ytaY2LjmH/PBcevSvPReNr03H8qJxw9ocM5pDspzfw=
=37eN
-----END PGP SIGNATURE-----

--hwATlVxtBxC/WLXk--
