Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E539C4708E
	for <git@archiver.kernel.org>; Wed,  4 Jan 2023 14:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239173AbjADO5W (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Jan 2023 09:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235207AbjADO5D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2023 09:57:03 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C5110B54
        for <git@vger.kernel.org>; Wed,  4 Jan 2023 06:57:01 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 5F6EC5C008F;
        Wed,  4 Jan 2023 09:57:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 04 Jan 2023 09:57:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1672844221; x=1672930621; bh=+kqOkLQYeI
        dcbgq5VnSf7nVxUaeVgyh3NyLxfZguQFM=; b=S/7l2P+zhJgaxo1jlXhDIGjTcv
        y6/+USsyZWGLN4wC62oi0mF9hNjR83z+s3aEndEctN8puD1GGU5vz4F8isqiJd/L
        k/AR1TMvVCsblwzFcOF6gnSjhGMwRIo4iDQ1jZvswx/brNnlGit+VZuFAS6FWBtG
        RR+p8p46n5Rwg0Q/5Y2LkGH7IyuOWSfPuo3126p0xW5l6Yk3l/y/Ny9VF1V3vMiv
        dyeWnqlDbotsijPsJFGD23D63EzSWofOBSRi6pf9sYkYiFFaXr4fdXtOrQ9n+L02
        UFKsKBwtzU9Xln8/4gSl/JlL0+RrZSv0e2RT/2QeKDj0ms3+4wIBThfryYyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1672844221; x=1672930621; bh=+kqOkLQYeIdcbgq5VnSf7nVxUaeV
        gyh3NyLxfZguQFM=; b=jR68ch8euxiHDelxMLSFfuASLKTyNzDP6oFSlohK7P/d
        W6dPvtPXJku4W/b4NIhM/YBx8kO9sDLot5XvEvH4tdrCm8k9XY9kVlOKUYoPPqqO
        ymll6XazNIC7I+ReEQCzQp4j1kOBW5V/S9ELEBWRAlJvsTe0cgz8H9JtX9Nb0BwG
        v01YRk/o7Fss9t1R42aSRcnhSu49iQ6HdS+FI2AQjmeALqs3J84QGWEG4gOgmQNt
        lCS3hvzaNUZyFzIssxsdKQwz43CMIaVd5z/ud2n/xyR9wz5Y4MBVNMe443lrtjl1
        CXVdgQGO9F5jlIn6MSacOR0diK4EqCPv10B0cDKjQA==
X-ME-Sender: <xms:vZO1Y50A25aitXW0U9NaNNyk_e2ELHvZoXVbW5_12NtVmxYvIs7l8Q>
    <xme:vZO1YwFtfvzud3tU8dHaABEAw7guiu9homndmqYnhjPV8uQQalQDWhErsXbrKVW2f
    hH6Xi3CJuFyQkdUkA>
X-ME-Received: <xmr:vZO1Y56nD2oyj6-Z3Lcg2Ax2Td-X6oaYIEYmnT_SjLuNHekVLq_VU_UGWj1NcPN8KQxDXZ73pHkgfQ0BTMQGn9xGeOw5HBXwSLqpc9-n5OSe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjeeigdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:vZO1Y22-zQcRgpmuEu3lFoNKKWcbBA8aW6M1CygIFYN4psWrWD18tA>
    <xmx:vZO1Y8HGb3p5m81Vyleb3P-zVe1ULDvpaGNhwsY_LNXDI0pEEDDbwA>
    <xmx:vZO1Y3-i-6bqr5wJHXIcXKqrnII4SwbNLy69OTNWjGjUJu93kFEF1w>
    <xmx:vZO1Y3050c-NlGpMpRoLCjD-ww4YmvMtDhTfChP950BKgSDH81EXZA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Jan 2023 09:56:59 -0500 (EST)
Received: by pks.im (OpenSMTPD) with ESMTPSA id e8a9e77e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 4 Jan 2023 14:56:49 +0000 (UTC)
Date:   Wed, 4 Jan 2023 15:56:57 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 2/3] repack: add --filter=<filter-spec> option
Message-ID: <Y7WTuQvoHEWRlEA4@ncase>
References: <20221122175150.366828-1-christian.couder@gmail.com>
 <20221221040446.2860985-1-christian.couder@gmail.com>
 <20221221040446.2860985-3-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5EJP5Cli2lSOvuxm"
Content-Disposition: inline
In-Reply-To: <20221221040446.2860985-3-christian.couder@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5EJP5Cli2lSOvuxm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 21, 2022 at 05:04:45AM +0100, Christian Couder wrote:
> From: Christian Couder <chriscool@tuxfamily.org>
>=20
> After cloning with --filter=3D<filter-spec>, for example to avoid
> getting unneeded large files on a user machine, it's possible
> that some of these large files still get fetched for some reasons
> (like checking out old branches) over time.
>=20
> In this case the repo size could grow too much for no good reason
> and `git repack --filter=3D<filter-spec>` would be useful to remove
> the unneeded large files.
>=20
> This command could be dangerous to use though, as it might remove
> local objects that haven't been pushed which would lose data and
> corrupt the repo. On a server, this command could also corrupt a
> repo unless ALL the removed objects aren't already available in
> another remote that clients can access.
>=20
> To mitigate that risk, we check that a promisor remote has at
> least been configured.

While this is a nice safeguard, I wonder whether it is sufficient.
Suppose you for example have a non-bare repository that already has
blobs checked out that would become removed by the filtering repack --
does Git handle this situation gracefully?

A quick check seems to indicate that it does. But not quite as well as
I'd have hoped: when I switch to a detached HEAD with an arbitrary
commit and then execute `git repack --filter=3Dblob:none` then it also
removes blobs that are referenced by the currently checked-out commit.
This may or may not be what the user is asking for, but I'd rather lean
towards this behaviour being surprising.

Patrick

> Signed-off-by: John Cai <johncai86@gmail.com>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/git-repack.txt |  8 ++++++++
>  builtin/repack.c             | 28 +++++++++++++++++++++-------
>  t/t7700-repack.sh            | 15 +++++++++++++++
>  3 files changed, 44 insertions(+), 7 deletions(-)
>=20
> diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
> index 4017157949..2539ee0a02 100644
> --- a/Documentation/git-repack.txt
> +++ b/Documentation/git-repack.txt
> @@ -143,6 +143,14 @@ depth is 4095.
>  	a larger and slower repository; see the discussion in
>  	`pack.packSizeLimit`.
> =20
> +--filter=3D<filter-spec>::
> +	Omits certain objects (usually blobs) from the resulting
> +	packfile. WARNING: this could easily corrupt the current repo
> +	and lose data if ANY of the omitted objects hasn't been already
> +	pushed to a remote. Be very careful about objects that might
> +	have been created locally! See linkgit:git-rev-list[1] for valid
> +	`<filter-spec>` forms.
> +
>  -b::
>  --write-bitmap-index::
>  	Write a reachability bitmap index as part of the repack. This
> diff --git a/builtin/repack.c b/builtin/repack.c
> index c1402ad038..8e5ac9c171 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -49,6 +49,7 @@ struct pack_objects_args {
>  	const char *depth;
>  	const char *threads;
>  	const char *max_pack_size;
> +	const char *filter;
>  	int no_reuse_delta;
>  	int no_reuse_object;
>  	int quiet;
> @@ -163,6 +164,8 @@ static void prepare_pack_objects(struct child_process=
 *cmd,
>  		strvec_pushf(&cmd->args, "--threads=3D%s", args->threads);
>  	if (args->max_pack_size)
>  		strvec_pushf(&cmd->args, "--max-pack-size=3D%s", args->max_pack_size);
> +	if (args->filter)
> +		strvec_pushf(&cmd->args, "--filter=3D%s", args->filter);
>  	if (args->no_reuse_delta)
>  		strvec_pushf(&cmd->args, "--no-reuse-delta");
>  	if (args->no_reuse_object)
> @@ -234,6 +237,13 @@ static struct generated_pack_data *populate_pack_ext=
s(const char *name)
>  	return data;
>  }
> =20
> +static void write_promisor_file_1(char *p)
> +{
> +	char *promisor_name =3D mkpathdup("%s-%s.promisor", packtmp, p);
> +	write_promisor_file(promisor_name, NULL, 0);
> +	free(promisor_name);
> +}
> +
>  static void repack_promisor_objects(const struct pack_objects_args *args,
>  				    struct string_list *names)
>  {
> @@ -265,7 +275,6 @@ static void repack_promisor_objects(const struct pack=
_objects_args *args,
>  	out =3D xfdopen(cmd.out, "r");
>  	while (strbuf_getline_lf(&line, out) !=3D EOF) {
>  		struct string_list_item *item;
> -		char *promisor_name;
> =20
>  		if (line.len !=3D the_hash_algo->hexsz)
>  			die(_("repack: Expecting full hex object ID lines only from pack-obje=
cts."));
> @@ -282,13 +291,8 @@ static void repack_promisor_objects(const struct pac=
k_objects_args *args,
>  		 * concatenate the contents of all .promisor files instead of
>  		 * just creating a new empty file.
>  		 */
> -		promisor_name =3D mkpathdup("%s-%s.promisor", packtmp,
> -					  line.buf);
> -		write_promisor_file(promisor_name, NULL, 0);
> -
> +		write_promisor_file_1(line.buf);
>  		item->util =3D populate_pack_exts(item->string);
> -
> -		free(promisor_name);
>  	}
>  	fclose(out);
>  	if (finish_command(&cmd))
> @@ -800,6 +804,8 @@ int cmd_repack(int argc, const char **argv, const cha=
r *prefix)
>  				N_("limits the maximum number of threads")),
>  		OPT_STRING(0, "max-pack-size", &po_args.max_pack_size, N_("bytes"),
>  				N_("maximum size of each packfile")),
> +		OPT_STRING(0, "filter", &po_args.filter, N_("args"),
> +				N_("object filtering")),
>  		OPT_BOOL(0, "pack-kept-objects", &pack_kept_objects,
>  				N_("repack objects in packs marked with .keep")),
>  		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
> @@ -834,6 +840,12 @@ int cmd_repack(int argc, const char **argv, const ch=
ar *prefix)
>  			die(_("options '%s' and '%s' cannot be used together"), "--cruft", "-=
k");
>  	}
> =20
> +	if (po_args.filter && !has_promisor_remote())
> +		die("a promisor remote must be setup\n"
> +		    "Also please push all the objects "
> +		    "that might be filtered to that remote!\n"
> +		    "Otherwise they will be lost!");
> +

>  	if (write_bitmaps < 0) {
>  		if (!write_midx &&
>  		    (!(pack_everything & ALL_INTO_ONE) || !is_bare_repository()))
> @@ -971,6 +983,8 @@ int cmd_repack(int argc, const char **argv, const cha=
r *prefix)
>  		if (line.len !=3D the_hash_algo->hexsz)
>  			die(_("repack: Expecting full hex object ID lines only from pack-obje=
cts."));
>  		item =3D string_list_append(&names, line.buf);
> +		if (po_args.filter)
> +			write_promisor_file_1(line.buf);
>  		item->util =3D populate_pack_exts(item->string);
>  	}
>  	strbuf_release(&line);
> diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
> index 4aabe98139..3a6ad9f623 100755
> --- a/t/t7700-repack.sh
> +++ b/t/t7700-repack.sh
> @@ -253,6 +253,21 @@ test_expect_success 'auto-bitmaps do not complain if=
 unavailable' '
>  	test_must_be_empty actual
>  '
> =20
> +test_expect_success 'repacking with a filter works' '
> +	test_when_finished "rm -rf server client" &&
> +	test_create_repo server &&
> +	git -C server config uploadpack.allowFilter true &&
> +	git -C server config uploadpack.allowAnySHA1InWant true &&
> +	test_commit -C server 1 &&
> +	git clone --bare --no-local server client &&
> +	git -C client config remote.origin.promisor true &&
> +	git -C client rev-list --objects --all --missing=3Dprint >objects &&
> +	test $(grep -c "^?" objects) =3D 0 &&
> +	git -C client -c repack.writebitmaps=3Dfalse repack -a -d --filter=3Dbl=
ob:none &&
> +	git -C client rev-list --objects --all --missing=3Dprint >objects &&
> +	test $(grep -c "^?" objects) =3D 1
> +'
> +
>  objdir=3D.git/objects
>  midx=3D$objdir/pack/multi-pack-index
> =20
> --=20
> 2.39.0.59.g395bcb85bc.dirty
>=20

--5EJP5Cli2lSOvuxm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmO1k7gACgkQVbJhu7ck
PpQrSA//dd1S0Sw+WkDg0fl/awNH7AWYlxMGVzmoIO8B4I/z8G9oLr4mXQXlZTE6
jRjaFblxXBFia1/i85Ln0WpQwGKCupKvlsbbLd8hjDWvqXoFP9cc/9CJQH5oEwiq
wKP5VsFIZ3oqKusJ1fOuxKwptpntaW2C3y5MGsP4NyMkEsLwY2pS6vni3V8pQYrU
vtrSVFRwv06cWn8I85le5oAnhTVIJ0IJEuROBlTtLWNj9LnCTEPxQ41QZbbXpu2+
3rdEvkfo86Pv6lyrafXgYB6vX/AwVtOgzNfB+ukskV0/PC0pjR0f5z9+TqUFY5LV
xAoTnJsT4OP2xqgVJvJyoVP0flcTY8aqDu+W8vME6R4Zm/kAxU0FrW8If46uEuYG
5FwS4WS+tyBOTTR51iYL14l506xv+taLTMebXFM7ZDT16l+NedyvG/MYm6Ky1LWx
lhzWjpIhxO30hA7r3PKkEOezVdB9aAqE60/DgBcqX5skMnx2d07mB3FEIWzHDMDC
0lC50lVcMsLm15r2v35Uej+Uqx+S0F3eFRTCH2xR5dxB1t8Dz2nye2Iibn4OsWaK
eardnqyzQIF3xbXSaTHHO0JT2Oib6RT2Mo3gtxe16RZM2tDSPQ+ONp+RniHVtqyN
8ZsR7tvPnroPvf+nFZZm2ABJ5tRj7v11kTHGXanVu52V/igx8E0=
=1R8r
-----END PGP SIGNATURE-----

--5EJP5Cli2lSOvuxm--
