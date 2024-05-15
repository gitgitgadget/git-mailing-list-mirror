Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E527040847
	for <git@vger.kernel.org>; Wed, 15 May 2024 06:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715755825; cv=none; b=BXHseENknVn75zTC8gsVhRBNQhfziiWyxj3Bmg5ZlTde5rnNKCvpGE3uBGFzhlAaaOMNdzst2m4e7C/Dq2W80CrGWttRVsKqb9QIppsvVCJVCIRueHmn2rjivrjvwc/V4P8LKpQw2P4lcX46lKlYCEDw8BI35/fLvUCQl71Lwq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715755825; c=relaxed/simple;
	bh=bO+rUEGGXxCrYzljG8G3TYtYVIPdiA9dcBUD91mg3iQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DXIXdx0klQeiPLIpBpd8AV04kkKFOnMXlr971aRZOir36IC61wJKnpoJVG31Es7XJ0EwFnx/9HHV3CDa4uhIjADmh0g4EBprtjBJ5yab6euLNb/9rySLyI+qZDrPpcdDXXBKSmeZ5IZHNrIZzaMdJSBUykUNF3iR00kcuUiD3YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=beq/369D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q9e/Ds/X; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="beq/369D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q9e/Ds/X"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id F14EA114018D;
	Wed, 15 May 2024 02:50:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 15 May 2024 02:50:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715755822; x=1715842222; bh=mRoz96RsNt
	n6w3nKaaRcZP0jINzlIAemZqQn2OANLfs=; b=beq/369DSoC1mywDwphm9i+WK3
	n9nmySx9qzuo2BS4MTiQDn4burNbK703q/ydEPdskrwyFUkSf+fOF5DVQ2Cv+DMF
	/IJpm7sK2esyf/DVecDqYDxr04Yn+S7+xVpHr26stpFjxqqHwZwLswfDkc6mQfh8
	9RQGHTfMwfcelVbXp1Y6AcJvqanexDLJxKwKoxQs3tcPamC9VtwtuvCbH8fr7U0b
	tf/jqmjYu32VJfU+sllbfv52D8nvgf+B//8WKKfWLVMmsrbcyG8guoH/gHzQqzsT
	6ELuEokMf+MgFmaEqLufgFcvltKoYhPIT+6hWNqDH11H38uuaM5NubjDwBKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715755822; x=1715842222; bh=mRoz96RsNtn6w3nKaaRcZP0jINzl
	IAemZqQn2OANLfs=; b=Q9e/Ds/Xm9rx84NxIChPt+FPuteLaeRlWkGw4KaZ2S/U
	WvnmkFdGjSOwG5p/XXx1FOrX82rDQkjaMzoFdRO2eHmRSKcmy5/bfcs0m9oUVx5F
	TBr67aQarHLU1Yo5sGoVzf5o8o3fPq7HI+PsB4Y5TdQwsUjK0CrLGghOAC0oYIrj
	PMzIuGS61ElI2dd5bBP7DpdtWFn9bDJQUl2oMoqmH4+AiG0iXUgk874sT2PG4IZ1
	wavHah4v6iiE3eT6zkD3akSkbfebCB8ltbhdFwGf4jEn07WwgDYPm0fZDCHbVk0m
	K9utNibZMlbvyxA+WRSJF+BRvorJ5xjFxBfm2zA0jQ==
X-ME-Sender: <xms:LltEZoBBuKmArwcYX0OsUFpCPugsvrjftCdUyYa66qUfifzH-23eTw>
    <xme:LltEZqj_QngIDi53_pgwKP93BZF2kQNKGdB1Wgb5NG_qyQFD4X7DweQJXHWkviEkd
    Cs32Ey0oz88Y2EDzA>
X-ME-Received: <xmr:LltEZrkieLymKKwxhd3uGzfmJxuUf7nZieYsLQ6AnTNpChF23Ao95mu70pQeMi2QlgUFP26yh0_KJ72tVNIup8664Eq7Ymj8Vfj6iOdkYyNkLQGd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegjedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:LltEZuxqyOOv9a4IJ-uVjH7ItVQ48R-4mOj09WEBVz2mP10Y7IQAkw>
    <xmx:LltEZtRSOYIDw_l6WC7nssQJFp_H8Pe8uqqJAxzRQDNbU1TY22yxRg>
    <xmx:LltEZpZYKafP2Gx50J1XxJBFwjTQuxSuaVFQncXVLPRxMSbdI3lh3w>
    <xmx:LltEZmQNF4N22xjNy8SG_Y66U8Lq9CizR1rb2oru5su57zrh8A-YNA>
    <xmx:LltEZoErSR7MFl0Ntbj4wCPtNnNaED7BA-gZKbDG2wdeVHSVYRZ8Q3Cv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 May 2024 02:50:21 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 2d19c752 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 May 2024 06:49:57 +0000 (UTC)
Date: Wed, 15 May 2024 08:50:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <avila.jn@gmail.com>
Subject: [PATCH v5 00/10] Clarify pseudo-ref terminology
Message-ID: <cover.1715755591.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bxs1D10ST1jmHMYg"
Content-Disposition: inline
In-Reply-To: <cover.1714398019.git.ps@pks.im>


--bxs1D10ST1jmHMYg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the fifth version of my patch series that aims to clarify the
pseudo-ref terminology. Changes compared to v4:

  - Dropped a now-unneeded comment in `is_head_ref_syntax()` which
    claims that "HEAD is not a pseudoref". Due to the rename of the
    function this comment no longer applies.

  - Adapted `is_root_ref()` so that it does not check the ref for
    existence at all anymore, as proposed by Peff. This makes the
    function's behaviour way less confusing overall. I also added some
    explanations to the commit message to explain why this is okay to
    do.

  - Adapted the commit message of `is_headref()` to explain some of the
    subtleties that result from the removed ref existence check.

Thanks!

Patrick Steinhardt (10):
  Documentation/glossary: redefine pseudorefs as special refs
  Documentation/glossary: clarify limitations of pseudorefs
  Documentation/glossary: define root refs as refs
  refs: rename `is_pseudoref()` to `is_root_ref()`
  refs: rename `is_special_ref()` to `is_pseudo_ref()`
  refs: do not check ref existence in `is_root_ref()`
  refs: classify HEAD as a root ref
  refs: pseudorefs are no refs
  ref-filter: properly distinuish pseudo and root refs
  refs: refuse to write pseudorefs

 Documentation/glossary-content.txt | 72 +++++++++++-----------
 builtin/for-each-ref.c             |  2 +-
 ref-filter.c                       | 16 ++---
 ref-filter.h                       |  4 +-
 refs.c                             | 98 +++++++++++-------------------
 refs.h                             | 48 ++++++++++++++-
 refs/files-backend.c               |  3 +-
 refs/reftable-backend.c            |  3 +-
 t/t5510-fetch.sh                   |  6 +-
 t/t6302-for-each-ref-filter.sh     | 34 +++++++++++
 10 files changed, 169 insertions(+), 117 deletions(-)

Range-diff against v4:
 1:  b1fc4c1ac7 =3D  1:  1f2445b95b Documentation/glossary: redefine pseudo=
refs as special refs
 2:  dce3a0fa7e =3D  2:  d328081c52 Documentation/glossary: clarify limitat=
ions of pseudorefs
 3:  79249962f5 =3D  3:  0d185e6479 Documentation/glossary: define root ref=
s as refs
 4:  ee2b090f75 !  4:  33b221b248 refs: rename `is_pseudoref()` to `is_root=
_ref()`
    @@ refs.c: int is_per_worktree_ref(const char *refname)
      	const char *c;
     =20
     @@ refs.c: static int is_pseudoref_syntax(const char *refname)
    + 			return 0;
    + 	}
    +=20
    +-	/*
    +-	 * HEAD is not a pseudoref, but it certainly uses the
    +-	 * pseudoref syntax.
    +-	 */
      	return 1;
      }
     =20
 5:  2c09bc7690 !  5:  9087696d82 refs: refname `is_special_ref()` to `is_p=
seudo_ref()`
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
    =20
      ## Commit message ##
    -    refs: refname `is_special_ref()` to `is_pseudo_ref()`
    +    refs: rename `is_special_ref()` to `is_pseudo_ref()`
    =20
         Rename `is_special_ref()` to `is_pseudo_ref()` to adapt to the new=
ly
         defined terminology in our gitglossary(7). Note that in the preced=
ing
 6:  5e402811a6 !  6:  af22581c22 refs: root refs can be symbolic refs
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
    =20
      ## Commit message ##
    -    refs: root refs can be symbolic refs
    +    refs: do not check ref existence in `is_root_ref()`
    =20
         Before this patch series, root refs except for "HEAD" and our spec=
ial
         refs were classified as pseudorefs. Furthermore, our terminology
    @@ Commit message
    =20
         Last but not least, the current behaviour can actually lead to a
         segfault when calling `is_root_ref()` with a reference that either=
 does
    -    not exist or that is a symbolic ref because we never initialized `=
oid`.
    +    not exist or that is a symbolic ref because we never initialized `=
oid`,
    +    but then read it via `is_null_oid()`.
    =20
    -    Let's loosen the restrictions in accordance to the new definition =
of
    -    root refs, which are simply plain refs that may as well be a symbo=
lic
    -    ref. Consequently, we can just check for the ref to exist instead =
of
    -    requiring it to be a regular ref.
    +    We have now changed terminology to clarify that pseudorefs are rea=
lly
    +    only "MERGE_HEAD" and "FETCH_HEAD", whereas all the other refs tha=
t live
    +    in the root of the ref hierarchy are just plain refs. Thus, we do =
not
    +    need to check whether the ref is symbolic or not. In fact, we can =
now
    +    avoid looking up the ref completely as the name is sufficient for =
us to
    +    figure out whether something would be a root ref or not.
    +
    +    This change of course changes semantics for our callers. As there =
are
    +    only three of them we can assess each of them individually:
    +
    +      - "ref-filter.c:ref_kind_from_refname()" uses it to classify ref=
s.
    +        It's clear that the intent is to classify based on the ref nam=
e,
    +        only.
    +
    +      - "refs/reftable_backend.c:reftable_ref_iterator_advance()" uses=
 it to
    +        filter root refs. Again, using existence checks is pointless h=
ere as
    +        the iterator has just surfaced the ref, so we know it does exi=
st.
    +
    +      - "refs/files_backend.c:add_pseudoref_and_head_entries()" uses i=
t to
    +        determine whether it should add a ref to the root directory of=
 its
    +        iterator. This had the effect that we skipped over any files t=
hat
    +        are either a symbolic ref, or which are not a ref at all.
    +
    +        The new behaviour is to include symbolic refs know, which alig=
ns us
    +        with the adapted terminology. Furthermore, files which look li=
ke
    +        root refs but aren't are now mark those as "broken". As broken=
 refs
    +        are not surfaced by our tooling, this should not lead to a cha=
nge in
    +        user-visible behaviour, but may cause us to emit warnings. This
    +        feels like the right thing to do as we would otherwise just si=
lently
    +        ignore corrupted root refs completely.
    +
    +    So in all cases the existence check was either superfluous, not in=
 line
    +    with the adapted terminology or masked potential issues. This comm=
it
    +    thus changes the behaviour as proposed and drops the existence che=
ck
    +    altogether.
    =20
         Add a test that verifies that this does not change user-visible
         behaviour. Namely, we still don't want to show broken refs to the =
user
    @@ Commit message
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
    + ## ref-filter.c ##
    +@@ ref-filter.c: static int ref_kind_from_refname(const char *refname)
    + 			return ref_kind[i].kind;
    + 	}
    +=20
    +-	if (is_root_ref(get_main_ref_store(the_repository), refname))
    ++	if (is_root_ref(refname))
    + 		return FILTER_REFS_PSEUDOREFS;
    +=20
    + 	return FILTER_REFS_OTHERS;
    +
      ## refs.c ##
    +@@ refs.c: static int is_root_ref_syntax(const char *refname)
    + 	return 1;
    + }
    +=20
    +-int is_root_ref(struct ref_store *refs, const char *refname)
    ++int is_root_ref(const char *refname)
    + {
    + 	static const char *const irregular_root_refs[] =3D {
    + 		"AUTO_MERGE",
     @@ refs.c: int is_root_ref(struct ref_store *refs, const char *refname)
      		"NOTES_MERGE_REF",
      		"MERGE_AUTOSTASH",
      	};
     -	struct object_id oid;
    -+	struct strbuf referent =3D STRBUF_INIT;
    -+	struct object_id oid =3D { 0 };
    -+	int failure_errno, ret =3D 0;
    -+	unsigned int flags;
      	size_t i;
     =20
      	if (!is_root_ref_syntax(refname))
      		return 0;
     =20
    -+	/*
    -+	 * Note that we cannot use `refs_ref_exists()` here because that also
    -+	 * checks whether its target ref exists in case refname is a symbolic
    -+	 * ref.
    -+	 */
    - 	if (ends_with(refname, "_HEAD")) {
    +-	if (ends_with(refname, "_HEAD")) {
     -		refs_resolve_ref_unsafe(refs, refname,
     -					RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
     -					&oid, NULL);
     -		return !is_null_oid(&oid);
    -+		ret =3D !refs_read_raw_ref(refs, refname, &oid, &referent,
    -+					 &flags, &failure_errno);
    -+		goto done;
    - 	}
    +-	}
    ++	if (ends_with(refname, "_HEAD"))
    ++		return 1;
     =20
    --	for (i =3D 0; i < ARRAY_SIZE(irregular_root_refs); i++)
    -+	for (i =3D 0; i < ARRAY_SIZE(irregular_root_refs); i++) {
    - 		if (!strcmp(refname, irregular_root_refs[i])) {
    + 	for (i =3D 0; i < ARRAY_SIZE(irregular_root_refs); i++)
    +-		if (!strcmp(refname, irregular_root_refs[i])) {
     -			refs_resolve_ref_unsafe(refs, refname,
     -						RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
     -						&oid, NULL);
     -			return !is_null_oid(&oid);
    -+			ret =3D !refs_read_raw_ref(refs, refname, &oid, &referent,
    -+						 &flags, &failure_errno);
    -+			goto done;
    - 		}
    -+	}
    +-		}
    ++		if (!strcmp(refname, irregular_root_refs[i]))
    ++			return 1;
     =20
    --	return 0;
    -+done:
    -+	strbuf_release(&referent);
    -+	return ret;
    + 	return 0;
      }
    -=20
    - int is_headref(struct ref_store *refs, const char *refname)
    =20
      ## refs.h ##
     @@ refs.h: extern struct ref_namespace_info ref_namespace[NAMESPACE__C=
OUNT];
    @@ refs.h: extern struct ref_namespace_info ref_namespace[NAMESPACE__CO=
UNT];
     =20
      /*
     - * Check whether the reference is an existing root reference.
    -+ * Check whether the reference is an existing root reference. A root =
reference
    -+ * that is a dangling symbolic ref is considered to exist.
    ++ * Check whether the provided name names a root reference. This funct=
ion only
    ++ * performs a syntactic check.
       *
       * A root ref is a reference that lives in the root of the reference =
hierarchy.
       * These references must conform to special syntax:
    +@@ refs.h: void update_ref_namespace(enum ref_namespace namespace, cha=
r *ref);
    +  *
    +  *   - MERGE_AUTOSTASH
    +  */
    +-int is_root_ref(struct ref_store *refs, const char *refname);
    ++int is_root_ref(const char *refname);
    +=20
    + int is_headref(struct ref_store *refs, const char *refname);
    +=20
    +
    + ## refs/files-backend.c ##
    +@@ refs/files-backend.c: static void add_pseudoref_and_head_entries(st=
ruct ref_store *ref_store,
    + 		strbuf_addstr(&refname, de->d_name);
    +=20
    + 		dtype =3D get_dtype(de, &path, 1);
    +-		if (dtype =3D=3D DT_REG && (is_root_ref(ref_store, de->d_name) ||
    +-								is_headref(ref_store, de->d_name)))
    ++		if (dtype =3D=3D DT_REG && (is_root_ref(de->d_name) ||
    ++					is_headref(ref_store, de->d_name)))
    + 			loose_fill_ref_dir_regular_file(refs, refname.buf, dir);
    +=20
    + 		strbuf_setlen(&refname, dirnamelen);
    +
    + ## refs/reftable-backend.c ##
    +@@ refs/reftable-backend.c: static int reftable_ref_iterator_advance(s=
truct ref_iterator *ref_iterator)
    + 		 */
    + 		if (!starts_with(iter->ref.refname, "refs/") &&
    + 		    !(iter->flags & DO_FOR_EACH_INCLUDE_ROOT_REFS &&
    +-		     (is_root_ref(&iter->refs->base, iter->ref.refname) ||
    ++		     (is_root_ref(iter->ref.refname) ||
    + 		      is_headref(&iter->refs->base, iter->ref.refname)))) {
    + 			continue;
    + 		}
    =20
      ## t/t6302-for-each-ref-filter.sh ##
     @@ t/t6302-for-each-ref-filter.sh: test_expect_success '--include-root=
-refs with other patterns' '
 7:  b32c56afcb !  7:  b719fb7110 refs: classify HEAD as a root ref
    @@ Commit message
         Adapt the function to also treat "HEAD" as a root ref. This change=
 is
         safe to do for all current callers:
    =20
    -    - `ref_kind_from_refname()` already handles "HEAD" explicitly befo=
re
    -      calling `is_root_ref()`.
    +      - `ref_kind_from_refname()` already handles "HEAD" explicitly be=
fore
    +        calling `is_root_ref()`.
    =20
    -    - The "files" and "reftable" backends explicitly called both
    -      `is_root_ref()` and `is_headref()`.
    +      - The "files" and "reftable" backends explicitly call both
    +        `is_root_ref()` and `is_headref()` together.
    =20
         This also aligns behaviour or `is_root_ref()` and `is_headref()` s=
uch
    -    that we also return a trueish value when the ref is a dangling sym=
bolic
    -    ref. As there are no callers of `is_headref()` left afer the refac=
toring
    -    we absorb it completely into `is_root_ref()`.
    +    that we stop checking for ref existence. This changes semantics fo=
r our
    +    backends:
    +
    +      - In the reftable backend we already know that the ref must exist
    +        because `is_headref()` is called as part of the ref iterator. =
The
    +        existence check is thus redundant, and the change is safe to d=
o.
    +
    +      - In the files backend we use it when populating root refs, wher=
e we
    +        would skip adding the "HEAD" file if it was not possible to re=
solve
    +        it. The new behaviour is to instead mark "HEAD" as broken, whi=
ch
    +        will cause us to emit warnings in various places.
    +
    +    As there are no callers of `is_headref()` left afer the refactorin=
g, we
    +    can absorb it completely into `is_root_ref()`.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## refs.c ##
     @@ refs.c: static int is_root_ref_syntax(const char *refname)
    - int is_root_ref(struct ref_store *refs, const char *refname)
    + int is_root_ref(const char *refname)
      {
      	static const char *const irregular_root_refs[] =3D {
     +		"HEAD",
      		"AUTO_MERGE",
      		"BISECT_EXPECTED_REV",
      		"NOTES_MERGE_PARTIAL",
    -@@ refs.c: int is_root_ref(struct ref_store *refs, const char *refname)
    - 	return ret;
    +@@ refs.c: int is_root_ref(const char *refname)
    + 	return 0;
      }
     =20
     -int is_headref(struct ref_store *refs, const char *refname)
    @@ refs.h: void update_ref_namespace(enum ref_namespace namespace, char=
 *ref);
       *
     @@ refs.h: void update_ref_namespace(enum ref_namespace namespace, cha=
r *ref);
       */
    - int is_root_ref(struct ref_store *refs, const char *refname);
    + int is_root_ref(const char *refname);
     =20
     -int is_headref(struct ref_store *refs, const char *refname);
     -
    @@ refs/files-backend.c: static void add_pseudoref_and_head_entries(str=
uct ref_stor
      		strbuf_addstr(&refname, de->d_name);
     =20
      		dtype =3D get_dtype(de, &path, 1);
    --		if (dtype =3D=3D DT_REG && (is_root_ref(ref_store, de->d_name) ||
    --								is_headref(ref_store, de->d_name)))
    -+		if (dtype =3D=3D DT_REG && is_root_ref(ref_store, de->d_name))
    +-		if (dtype =3D=3D DT_REG && (is_root_ref(de->d_name) ||
    +-					is_headref(ref_store, de->d_name)))
    ++		if (dtype =3D=3D DT_REG && is_root_ref(de->d_name))
      			loose_fill_ref_dir_regular_file(refs, refname.buf, dir);
     =20
      		strbuf_setlen(&refname, dirnamelen);
    @@ refs/reftable-backend.c: static int reftable_ref_iterator_advance(st=
ruct ref_ite
      		 */
      		if (!starts_with(iter->ref.refname, "refs/") &&
      		    !(iter->flags & DO_FOR_EACH_INCLUDE_ROOT_REFS &&
    --		     (is_root_ref(&iter->refs->base, iter->ref.refname) ||
    +-		     (is_root_ref(iter->ref.refname) ||
     -		      is_headref(&iter->refs->base, iter->ref.refname)))) {
    -+		      is_root_ref(&iter->refs->base, iter->ref.refname))) {
    ++		      is_root_ref(iter->ref.refname))) {
      			continue;
      		}
     =20
 8:  19af8c754c !  8:  5709d7f780 refs: pseudorefs are no refs
    @@ refs.c: int is_per_worktree_ref(const char *refname)
      static int is_root_ref_syntax(const char *refname)
      {
      	const char *c;
    -@@ refs.c: int is_root_ref(struct ref_store *refs, const char *refname)
    - 	unsigned int flags;
    +@@ refs.c: int is_root_ref(const char *refname)
    + 	};
      	size_t i;
     =20
     -	if (!is_root_ref_syntax(refname))
    @@ refs.c: int is_root_ref(struct ref_store *refs, const char *refname)
     +	    is_pseudo_ref(refname))
      		return 0;
     =20
    - 	/*
    + 	if (ends_with(refname, "_HEAD"))
     @@ refs.c: static int refs_read_special_head(struct ref_store *ref_sto=
re,
      	return result;
      }
 9:  86f7f2d2d8 !  9:  c7e90e3170 ref-filter: properly distinuish pseudo an=
d root refs
    @@ ref-filter.c: static int ref_kind_from_refname(const char *refname)
      			return ref_kind[i].kind;
      	}
     =20
    --	if (is_root_ref(get_main_ref_store(the_repository), refname))
    +-	if (is_root_ref(refname))
     +	if (is_pseudo_ref(refname))
      		return FILTER_REFS_PSEUDOREFS;
    -+	if (is_root_ref(get_main_ref_store(the_repository), refname))
    ++	if (is_root_ref(refname))
     +		return FILTER_REFS_ROOT_REFS;
     =20
      	return FILTER_REFS_OTHERS;
    @@ refs.c: int is_per_worktree_ref(const char *refname)
      ## refs.h ##
     @@ refs.h: void update_ref_namespace(enum ref_namespace namespace, cha=
r *ref);
       */
    - int is_root_ref(struct ref_store *refs, const char *refname);
    + int is_root_ref(const char *refname);
     =20
     +/*
     + * Pseudorefs are refs that have different semantics compared to
10:  640d3b169f =3D 10:  15595991dc refs: refuse to write pseudorefs

base-commit: 83f1add914c6b4682de1e944ec0d1ac043d53d78
--=20
2.45.GIT


--bxs1D10ST1jmHMYg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZEWygACgkQVbJhu7ck
PpSRNQ//YH60gsJ4iukz8yPrLeJMmBxQ//Lz5G2H7gnkhxfD4pK5V9IyT0AGvk21
C40XTlnDftBZVRQDm5pkCfEFiZ7a4ATaWCISZLBxxPO90ZopYEd6batYbExtn/ci
vDWp6Yh8DQWAap1V8MzSagMvo1XLGERTnPa9XACTIyz3xEmauqflAvMP2VH/r5Zi
m2H82qyZnbgrOnyFX2bH3OtOl1CJsiUXaD50O8LsCo1OT6ufBpH1IQNBTLedOjVq
xzC6MD5/2gAKZEuCTdQTZ3oJ1uGIAZZt4ntgUk/INpyPiSfeTpYqHaEc8eRJecv1
eaaqBnGCVd31BONmZQHGfd/w9bomUgfVJHKioF12tt+ktn/PJAim7i+JFyVZGwt6
v/PkFi2PaZcr3Q4vW0u13y1+2QRDIgOt4CxHLBTElN7ZZbqPvSUbCat3h1G5XXfB
JA3PLEn5X8hiNomR5o4gghPBDI8hRGjmMEJ4qJm83Z1ZT2fz+KxQ9joQhd3CHu/q
cfwaeHYvSalwQMNqHxehzn/6DeoeIDRtLZs/ho6nLZg2H0EHkURUZM6Jx8A8m6+U
Jq8MlEAz3cTeUbNHs0ocusibcpNgtuUleo9oz6nlia3Ev9mHzfk45Phl3fT4eJ4u
G1LkQ2Kmr18VY3au4j983iCchxxdpsNkPqCitZk90e5RdnRu3Ks=
=KQpd
-----END PGP SIGNATURE-----

--bxs1D10ST1jmHMYg--
