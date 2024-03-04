Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF81A1AAC4
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 08:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709541246; cv=none; b=fZZwFDnKr+xnwrLolkMPTyTbyxMdJJEdQcU3/EYRUqxaYNet1efwWtdYUj4lM5Os548sJ3Pxi22BWncUdrraAheHzC23Zn4/gnkJhyUjEoFrYEUnsx3qan9z8H5bZGMhe7JLtxerHIosVgp1LBYp2D3lSwZIVvbFoACsEMcZktc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709541246; c=relaxed/simple;
	bh=cOQgzfsS5SQjrVc4B6N+AVlraERJlOSl1wxQOaCiO64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9updwwMd2PaQQGBAgl6jGyPCJttWH3PilP43lgF6AhMlCNZ0jjLOHo/SA2fPqcv2b6rvANOnG1+YWeieShSiMm/dXm3wetZ89FP0TePymAtViJ1QI5wsb6fdftdHYRYYSH39vtXwAYmWqzrhD3hJLEMXE1u67hGQZL23AmiMRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gEmgXZmF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WhJkD603; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gEmgXZmF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WhJkD603"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id AB1F932001FC;
	Mon,  4 Mar 2024 03:34:02 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 04 Mar 2024 03:34:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709541242; x=1709627642; bh=uKaygc+DGz
	Cu1LEGPbtWqWazU7qFr7cvwOjEIbxObv4=; b=gEmgXZmF7KwWsbVAWcC8ToqZMr
	Nz9awN54waM/rkNfC8XWA4ubW2/pKtOpte09ppSEs4LHtTTxQ4wpYpGuYTQi2wlG
	y0pWYZCeWdlvanjYq1jxQrGmulaT6F9SxSBnwvwuM/CmDtPFJbr1Lgw9cZLERMmi
	kzuglPa6B/Idg7k2J3aoNeOxdJGOxS4HLT0kyX5HRqy1vfKAUpWrb3qJ0pyfJAeq
	cA2+5oI0MylNUkrRYCgiVeOzobtWjgbVl1URqPlR4oNi3RcESbSww1ulS00rdUvc
	vTgq7WlfIeMhOEUM5sgNs3ZhvboYvIZ2Vl4wlxuSVQs3noMqGPQhFrDTEQmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709541242; x=1709627642; bh=uKaygc+DGzCu1LEGPbtWqWazU7qF
	r7cvwOjEIbxObv4=; b=WhJkD6035KjBPQ8VNJ4acFvNvj9yILwYqQaHSxLHlBey
	INYofxOsFH4hR8iaHMIqH5u2jbp2oY8bbnrTqzRdGeh6WYa7TT/gLOU+8lNKXNFn
	CIoQobvHvyHLFx5RnXBPkl2VJCGdChveqNdL2N6WcsvF2iCYRvchppfACGtexXSQ
	/CQXJ0faSASFYuRDCni/e5Tbk3WtyHrhoAkPQ2+BIC3guJnNOBKM8+V5LBsE8oHp
	4MPiq/2MRlk/9znBAzltop3obQKofSgd/Cgi0YGNCeb9vlowHYfPQQ/vbVGrhkBW
	02CRxYurqAw7f2Mxiyp0wLo2rPmtWXjjkJOktZ9rTQ==
X-ME-Sender: <xms:eoflZcH7as4atngfd_Xi8DWONXB6-BT-P1jkrUJZMly8CaFU7Xnk8g>
    <xme:eoflZVWznr2Cj337MPUsrYBLMXLpLPXcPkayavtJCw6VmQ5d3FgDowO_0KOWmE_ca
    QOJywmipi6pDKxh1Q>
X-ME-Received: <xmr:eoflZWIRbVEQgsrtYGbjx48T3XIvCoWgrIeiJoN82fZCho1UyOaAU6e029mDLFMz8jcZzcrLD7nXBF-CVJbExXc7Nr6qhNKFBC77kVl75uFmHEc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheeigdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnheptdffffettdefhfdvveetgedvtdffjeekleelieejjefglefftedtieehvedvfeet
    necuffhomhgrihhnpehuphhlohgrugdqphgrtghkrdguvghvnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:eoflZeHeSfBALr71GgzJiFUEJHPLYbDDt7VysTIYnG_Hjpca6ZAq5g>
    <xmx:eoflZSXQYX9gdqeIm6agQc-zc776r4VNo0tQRSYZHjYH-cAZCU8u5Q>
    <xmx:eoflZRN6qZamt2oewr2-QbfjrxyvHrJwEuxHZt6Ip2lh-wIw7Zm_5g>
    <xmx:eoflZfjcBvkdWw244wFNVz6qdrSPmn7LOIvego1Bt_3E25FHEJ1xow>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 03:34:01 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 92d991cd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 Mar 2024 08:29:34 +0000 (UTC)
Date: Mon, 4 Mar 2024 09:33:57 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Benjamin Flesch <benjaminflesch@icloud.com>
Subject: Re: [PATCH 9/9] upload-pack: free tree buffers after parsing
Message-ID: <ZeWHdaZnhOHKs5QP@tanuki>
References: <20240228223700.GA1157826@coredump.intra.peff.net>
 <20240228223907.GI1158131@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cm0R6O4wFYjyrisY"
Content-Disposition: inline
In-Reply-To: <20240228223907.GI1158131@coredump.intra.peff.net>


--cm0R6O4wFYjyrisY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 05:39:07PM -0500, Jeff King wrote:
> When a client sends us a "want" or "have" line, we call parse_object()
> to get an object struct. If the object is a tree, then the parsed state
> means that tree->buffer points to the uncompressed contents of the tree.
> But we don't really care about it. We only really need to parse commits
> and tags; for trees and blobs, the important output is just a "struct
> object" with the correct type.
>=20
> But much worse, we do not ever free that tree buffer. It's not leaked in
> the traditional sense, in that we still have a pointer to it from the
> global object hash. But if the client requests many trees, we'll hold
> all of their contents in memory at the same time.
>=20
> Nobody really noticed because it's rare for clients to directly request
> a tree. It might happen for a lightweight tag pointing straight at a
> tree, or it might happen for a "tree:depth" partial clone filling in
> missing trees.
>=20
> But it's also possible for a malicious client to request a lot of trees,
> causing upload-pack's memory to balloon. For example, without this
> patch, requesting every tree in git.git like:
>=20
>   pktline() {
>     local msg=3D"$*"
>     printf "%04x%s\n" $((1+4+${#msg})) "$msg"
>   }
>=20
>   want_trees() {
>     pktline command=3Dfetch
>     printf 0001
>     git cat-file --batch-all-objects --batch-check=3D'%(objectname) %(obj=
ecttype)' |
>       while read oid type; do
>         test "$type" =3D "tree" || continue
>         pktline want $oid
>       done
>       pktline done
>       printf 0000
>   }
>=20
>   want_trees | GIT_PROTOCOL=3Dversion=3D2 valgrind --tool=3Dmassif ./git =
upload-pack . >/dev/null
>=20
> shows a peak heap usage of ~3.7GB. Which is just about the sum of the
> sizes of all of the uncompressed trees. For linux.git, it's closer to
> 17GB.
>=20
> So the obvious thing to do is to call free_tree_buffer() after we
> realize that we've parsed a tree. We know that upload-pack won't need it
> later. But let's push the logic into parse_object_with_flags(), telling
> it to discard the tree buffer immediately. There are two reasons for
> this. One, all of the relevant call-sites already call the with_options
> variant to pass the SKIP_HASH flag. So it actually ends up as less code
> than manually free-ing in each spot. And two, it enables an extra
> optimization that I'll discuss below.
>=20
> I've touched all of the sites that currently use SKIP_HASH in
> upload-pack. That drops the peak heap of the upload-pack invocation
> above from 3.7GB to ~24MB.
>=20
> I've also modified the caller in get_reference(); a partial clone
> benefits from its use in pack-objects for the reasons given in
> 0bc2557951 (upload-pack: skip parse-object re-hashing of "want" objects,
> 2022-09-06), where we were measuring blob requests. But note that the
> results of get_reference() are used for traversing, as well; so we
> really would _eventually_ use the tree contents. That makes this at
> first glance a space/time tradeoff: we won't hold all of the trees in
> memory at once, but we'll have to reload them each when it comes time to
> traverse.
>=20
> And here's where our extra optimization comes in. If the caller is not
> going to immediately look at the tree contents, and it doesn't care
> about checking the hash, then parse_object() can simply skip loading the
> tree entirely, just like we do for blobs! And now it's not a space/time
> tradeoff in get_reference() anymore. It's just a lazy-load: we're
> delaying reading the tree contents until it's time to actually traverse
> them one by one.
>=20
> And of course for upload-pack, this optimization means we never load the
> trees at all, saving lots of CPU time. Timing the "every tree from
> git.git" request above shows upload-pack dropping from 32 seconds of CPU
> to 19 (the remainder is mostly due to pack-objects actually sending the
> pack; timing just the upload-pack portion shows we go from 13s to
> ~0.28s).
>=20
> These are all highly gamed numbers, of course. For real-world
> partial-clone requests we're saving only a small bit of time in
> practice. But it does help harden upload-pack against malicious
> denial-of-service attacks.
>=20
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  object.c      | 14 ++++++++++++++
>  object.h      |  1 +
>  revision.c    |  3 ++-
>  upload-pack.c |  9 ++++++---
>  4 files changed, 23 insertions(+), 4 deletions(-)
>=20
> diff --git a/object.c b/object.c
> index e6a1c4d905..f11c59ac0c 100644
> --- a/object.c
> +++ b/object.c
> @@ -271,6 +271,7 @@ struct object *parse_object_with_flags(struct reposit=
ory *r,
>  				       enum parse_object_flags flags)
>  {
>  	int skip_hash =3D !!(flags & PARSE_OBJECT_SKIP_HASH_CHECK);
> +	int discard_tree =3D !!(flags & PARSE_OBJECT_DISCARD_TREE);
>  	unsigned long size;
>  	enum object_type type;
>  	int eaten;
> @@ -298,6 +299,17 @@ struct object *parse_object_with_flags(struct reposi=
tory *r,
>  		return lookup_object(r, oid);
>  	}
> =20
> +	/*
> +	 * If the caller does not care about the tree buffer and does not
> +	 * care about checking the hash, we can simply verify that we
> +	 * have the on-disk object with the correct type.
> +	 */
> +	if (skip_hash && discard_tree &&
> +	    (!obj || obj->type =3D=3D OBJ_TREE) &&
> +	    oid_object_info(r, oid, NULL) =3D=3D OBJ_TREE) {
> +		return &lookup_tree(r, oid)->object;
> +	}

The other condition for blobs does the same, but the condition here
confuses me. Why do we call `oid_object_info()` if we have already
figured out that `obj->type =3D=3D OBJ_TREE`? Feels like wasted effort if
the in-memory object has been determined to be a tree already anyway.

I'd rather have expected it to look like the following:

if (skip_hash && discard_tree &&
    ((obj && obj->type =3D=3D OBJ_TREE) ||
     (!obj && oid_object_info(r, oid, NULL)) =3D=3D OBJ_TREE)) {
		return &lookup_tree(r, oid)->object;
}

Am I missing some side effect that `oid_object_info()` provides?

Patrick

>  	buffer =3D repo_read_object_file(r, oid, &type, &size);
>  	if (buffer) {
>  		if (!skip_hash &&
> @@ -311,6 +323,8 @@ struct object *parse_object_with_flags(struct reposit=
ory *r,
>  					  buffer, &eaten);
>  		if (!eaten)
>  			free(buffer);
> +		if (discard_tree && type =3D=3D OBJ_TREE)
> +			free_tree_buffer((struct tree *)obj);
>  		return obj;
>  	}
>  	return NULL;
> diff --git a/object.h b/object.h
> index 114d45954d..c7123cade6 100644
> --- a/object.h
> +++ b/object.h
> @@ -197,6 +197,7 @@ void *object_as_type(struct object *obj, enum object_=
type type, int quiet);
>   */
>  enum parse_object_flags {
>  	PARSE_OBJECT_SKIP_HASH_CHECK =3D 1 << 0,
> +	PARSE_OBJECT_DISCARD_TREE =3D 1 << 1,
>  };
>  struct object *parse_object(struct repository *r, const struct object_id=
 *oid);
>  struct object *parse_object_with_flags(struct repository *r,
> diff --git a/revision.c b/revision.c
> index 2424c9bd67..b10f63a607 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -381,7 +381,8 @@ static struct object *get_reference(struct rev_info *=
revs, const char *name,
> =20
>  	object =3D parse_object_with_flags(revs->repo, oid,
>  					 revs->verify_objects ? 0 :
> -					 PARSE_OBJECT_SKIP_HASH_CHECK);
> +					 PARSE_OBJECT_SKIP_HASH_CHECK |
> +					 PARSE_OBJECT_DISCARD_TREE);
> =20
>  	if (!object) {
>  		if (revs->ignore_missing)
> diff --git a/upload-pack.c b/upload-pack.c
> index b721155442..761af4a532 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -470,7 +470,8 @@ static int do_got_oid(struct upload_pack_data *data, =
const struct object_id *oid
>  {
>  	int we_knew_they_have =3D 0;
>  	struct object *o =3D parse_object_with_flags(the_repository, oid,
> -						   PARSE_OBJECT_SKIP_HASH_CHECK);
> +						   PARSE_OBJECT_SKIP_HASH_CHECK |
> +						   PARSE_OBJECT_DISCARD_TREE);
> =20
>  	if (!o)
>  		die("oops (%s)", oid_to_hex(oid));
> @@ -1150,7 +1151,8 @@ static void receive_needs(struct upload_pack_data *=
data,
>  		}
> =20
>  		o =3D parse_object_with_flags(the_repository, &oid_buf,
> -					    PARSE_OBJECT_SKIP_HASH_CHECK);
> +					    PARSE_OBJECT_SKIP_HASH_CHECK |
> +					    PARSE_OBJECT_DISCARD_TREE);
>  		if (!o) {
>  			packet_writer_error(&data->writer,
>  					    "upload-pack: not our ref %s",
> @@ -1467,7 +1469,8 @@ static int parse_want(struct packet_writer *writer,=
 const char *line,
>  			    "expected to get oid, not '%s'", line);
> =20
>  		o =3D parse_object_with_flags(the_repository, &oid,
> -					    PARSE_OBJECT_SKIP_HASH_CHECK);
> +					    PARSE_OBJECT_SKIP_HASH_CHECK |
> +					    PARSE_OBJECT_DISCARD_TREE);
> =20
>  		if (!o) {
>  			packet_writer_error(writer,
> --=20
> 2.44.0.rc2.424.gbdbf4d014b
>=20

--cm0R6O4wFYjyrisY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXlh3QACgkQVbJhu7ck
PpR5Eg/+MOaufnxETN1XhpsmFeXIFGsuJidPg06gYN0K24pycDe8a5ascRZ3UGv8
hLTdvMMaFWYp8sdfgb63FqlKGvjDQhmxbDPAoOAj6eVM/cwttRA0R3vofyvvZofr
cD7Vf4A6cHpnP6TgIzz2Nw5m3BDIRS5s6HbdGzWH3M7sqVg/glY+wXtt5UyoVSoC
DtXrdIR+CDVrHLTehrbQxgwKYURZM5dEcsQrvgwCE3V6bEwTh8r0g6hlU1AEb9nR
vMX3c43IBjZ7GtB0sl8WtTmSRwV+aNb+9lpU5SX/4dy0YnKC1DsPJFTA5bdF/2je
PikAOlw0Mbue7rL51oGXuKFhIpxbhBezNQrepwff5kOIMFoYlu/qCWh0WgrmlHFD
792pyCzN2R3/kZTavJPyk5NJfHZPf3PHJQLyTiW+87qpcI2CWW1voo10wVTcWnds
B+eLaU0IZZb+fBjCkD0s1BMqjdS3SJfUkhy3zWu5gsC1rWQtsZY9UO0dfR6QeqNQ
F00qOf0cCjs3ZDyu0tCZ3GuxlvTIKn4t2nnRTPCLfsyV84MRpqvpUe1wYQDE+su6
9qqsUaO2ZBACB6Di/kiisUvwoGRb4P6izSjdmFjdsLbVq8BIEoZzQZNyN7tuH+hY
0PtMn7jbkmIWUO6T0moQq4YiqrUEsWoh1P8nIle6PUT6ZoDoARs=
=vBBd
-----END PGP SIGNATURE-----

--cm0R6O4wFYjyrisY--
