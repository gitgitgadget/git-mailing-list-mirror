Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2C42F2B
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 05:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714456467; cv=none; b=o1PA2L564kTuibQLlj6Xo4FvqmcpHhJ/ABDtLgd8+pwM1b9ugGyheyokIUsYhaUCoStM5/Y8IgikQpuekymwiPOPITm50iEzjajXX0GX6kog+jqCqKInDn0Nl79cZpRyXlKzd81ZHttBBis3CQCI25TebMJGAyA5CSoremMAf90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714456467; c=relaxed/simple;
	bh=cOnjpQ9yRU6XpzZl0vkVAYqjSM2jg9MkYOeQ2nxencs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQ7K70qLXTyTCouTNbWPld4j8hxFwmTIU/EeVLLzuARa1ZWKP5ZFOAMmYni5+dL1/clSrznAExypt1mOEAMgvNTpcx5+91aqNQfnuJ0l5LFDivDAO4jRuZw+jqUSLtqCXdxUTTifnwUc76ENDsYxBhpNpyoj/YaesRZ137h8MFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=j40QUt8g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=juJQqfAh; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="j40QUt8g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="juJQqfAh"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 396DC1140190;
	Tue, 30 Apr 2024 01:54:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 30 Apr 2024 01:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714456463; x=1714542863; bh=H3hWJ77I7a
	3iXkXKHwZ8YSZUJfuHI//bu6qHgfxGuYg=; b=j40QUt8gQNx8LEmp3ge8F5F04+
	eyeajMkVOlMzdBVSoPq5ptPhpEn2LaxydcD/72QOTmUavr7DhsE6vWz6ewWvb63N
	EWnlxYCKOtVw5Yp8QFLZ9U/2Z8Zelf+s4ujrVie3B6OoPljw4kq2L+IUyV7irXKS
	Y0TkASgoEVK/8KQTmWVim2bwCgNy4JFVCTecy2qhPl5G0JcAaxWXNBqFwSpftLLu
	OEGdurv4+qb3IQ6S6S+V4MA9JAkUC2uV4901rPGlSwe9HN4yVkHJZiHLYO5l9AR8
	6CUHLO/IpqnLN146FO5asO+0QXUSL/eRCtdpn0g90LzV2PFlySWessisT7SQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714456463; x=1714542863; bh=H3hWJ77I7a3iXkXKHwZ8YSZUJfuH
	I//bu6qHgfxGuYg=; b=juJQqfAhyRmoZq6gXbP78D+Ze3hbHcFDPwPRYnlenzu5
	+s6aWbmmU66GWAGpKHu3mb6kY6encHsxPKOgg7LdprKUaQld4imjWm9HkHAfvyXR
	bnz+bpokiH+CDJR1CCIJwotSIQwwMhkucqEW6wxpWL5/7xFfHlkQuH3GSbI1Ij4u
	aPHJ/EyLu2LFUdGYwnQuDand27UUwEBGpDCi5hgj/aBxGsOYMnMnjKZa1og7eUS8
	3xtJcFqDAEyNV00+bjcxiRTbrMhecTPY6tazocwY5BhjmjA4T42lvc5LVjQvDzvk
	YrlfPwSx+s3rp+goGLrCr6ydCfLaiBUpeZbxBARKUw==
X-ME-Sender: <xms:j4cwZlTAVSpaIBQvkpb2fy2UPQsQx47SFTGVwQpuXJ9DGm5fMRwFJw>
    <xme:j4cwZux3tH488euVievrohMGA2XbGFPPqQ4H5YgVX7pi2uT_Q8DhbRMMB9JnCEbn5
    F3CzxOUxs-6JUyu5g>
X-ME-Received: <xmr:j4cwZq1vhUPGnFaNrQZ0kDnvKVi7lZTBAuX5oa8qQZ3v9Etl-xs0ik8s6gsgseToa5qBRSFdGz65e90FkUvSF2Po114E51Qku856x1pGKEh2dCZgO9I9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduvddgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:j4cwZtBmheBtTjBGbJpR-werDMAUlCtATiWAGIV8k13j_QCToUJg9A>
    <xmx:j4cwZuhqL9d0FINSOSrWwm1H36JVIB3pu_SnSjHdO2x6A8-YOZpBfA>
    <xmx:j4cwZhqRA3g3RDaqxtFKIUzNuc1sxlV79WJMknRnGqQ-1XP_aBNl3Q>
    <xmx:j4cwZpi1dxCh55mSFQQPoKqcIhUlca8rxWloV4FTS17VJqmripXpmg>
    <xmx:j4cwZmdfIXWkK96ajzdPcN_tPlTrdWay9GgJ5QFZI1Gk7mLw47R0ItKz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Apr 2024 01:54:21 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a5ff09ab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Apr 2024 05:53:58 +0000 (UTC)
Date: Tue, 30 Apr 2024 07:54:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: John Passaro via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	John Passaro <john.a.passaro@gmail.com>
Subject: Re: [PATCH v3 1/3] builtin/commit.c: refactor --trailer logic
Message-ID: <ZjCHiPS8N-eSBrQV@tanuki>
References: <pull.1723.v2.git.1714409638089.gitgitgadget@gmail.com>
 <pull.1723.v3.git.1714416863.gitgitgadget@gmail.com>
 <0c9517f434aa5456dbde129f0514e3e3f50a095d.1714416865.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tOYVo8KvVppjMDy1"
Content-Disposition: inline
In-Reply-To: <0c9517f434aa5456dbde129f0514e3e3f50a095d.1714416865.git.gitgitgadget@gmail.com>


--tOYVo8KvVppjMDy1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 06:54:21PM +0000, John Passaro via GitGitGadget wro=
te:
> From: John Passaro <john.a.passaro@gmail.com>
>=20
> git-commit adds user trailers to the commit message by passing its
> `--trailer` arguments to a child process running `git-interpret-trailers
> --in-place`. This logic is broadly useful, not just for git-commit but
> for other commands constructing message bodies (e.g. git-tag).
>=20
> Let's move this logic from git-commit to a new function in the trailer
> API, so that it can be re-used in other commands.
>=20
> Additionally, replace git-commit's bespoke callback for --trailer with
> the standard OPT_PASSTHRU_ARGV macro. This bespoke callback was only
> adding its values to a strvec and sanity-checking that `unset` is always
> false; both of these are already implemented in the parse-option API.
>=20
> Signed-off-by: John Passaro <john.a.passaro@gmail.com>
> Helped-by: Patrick Steinhardt <ps@pks.im>
> Helped-by: Junio C Hamano <gitster@pobox.com>

Your signed-off-by should always go last.

> ---
>  builtin/commit.c | 20 +++-----------------
>  trailer.c        | 12 ++++++++++++
>  trailer.h        |  8 ++++++++
>  3 files changed, 23 insertions(+), 17 deletions(-)
>=20
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 6e1484446b0..63cd090b6f2 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -38,6 +38,7 @@
>  #include "commit-reach.h"
>  #include "commit-graph.h"
>  #include "pretty.h"
> +#include "trailer.h"
> =20
>  static const char * const builtin_commit_usage[] =3D {
>  	N_("git commit [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--a=
mend]\n"
> @@ -142,14 +143,6 @@ static struct strbuf message =3D STRBUF_INIT;
> =20
>  static enum wt_status_format status_format =3D STATUS_FORMAT_UNSPECIFIED;
> =20
> -static int opt_pass_trailer(const struct option *opt, const char *arg, i=
nt unset)
> -{
> -	BUG_ON_OPT_NEG(unset);
> -
> -	strvec_pushl(opt->value, "--trailer", arg, NULL);
> -	return 0;
> -}
> -

Nice to see this gone. I would have moved this refactoring into a
separate commit because it is completely unrelated to the new trailer
function that you're introducing.

>  static int opt_parse_porcelain(const struct option *opt, const char *arg=
, int unset)
>  {
>  	enum wt_status_format *value =3D (enum wt_status_format *)opt->value;
> @@ -1038,14 +1031,7 @@ static int prepare_to_commit(const char *index_fil=
e, const char *prefix,
>  	fclose(s->fp);
> =20
>  	if (trailer_args.nr) {
> -		struct child_process run_trailer =3D CHILD_PROCESS_INIT;
> -
> -		strvec_pushl(&run_trailer.args, "interpret-trailers",
> -			     "--in-place", "--no-divider",
> -			     git_path_commit_editmsg(), NULL);
> -		strvec_pushv(&run_trailer.args, trailer_args.v);
> -		run_trailer.git_cmd =3D 1;
> -		if (run_command(&run_trailer))
> +		if (amend_file_with_trailers(git_path_commit_editmsg(), &trailer_args))
>  			die(_("unable to pass trailers to --trailers"));
>  		strvec_clear(&trailer_args);
>  	}
> @@ -1673,7 +1659,7 @@ int cmd_commit(int argc, const char **argv, const c=
har *prefix)
>  		OPT_STRING(0, "fixup", &fixup_message, N_("[(amend|reword):]commit"), =
N_("use autosquash formatted message to fixup or amend/reword specified com=
mit")),
>  		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autosqu=
ash formatted message to squash specified commit")),
>  		OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit is autho=
red by me now (used with -C/-c/--amend)")),
> -		OPT_CALLBACK_F(0, "trailer", &trailer_args, N_("trailer"), N_("add cus=
tom trailer(s)"), PARSE_OPT_NONEG, opt_pass_trailer),
> +		OPT_PASSTHRU_ARGV(0, "trailer", &trailer_args, N_("trailer"), N_("add =
custom trailer(s)"), PARSE_OPT_NONEG),
>  		OPT_BOOL('s', "signoff", &signoff, N_("add a Signed-off-by trailer")),
>  		OPT_FILENAME('t', "template", &template_file, N_("use specified templa=
te file")),
>  		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
> diff --git a/trailer.c b/trailer.c
> index c72ae687099..843c378199e 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -7,6 +7,7 @@
>  #include "commit.h"
>  #include "trailer.h"
>  #include "list.h"
> +#include "run-command.h"
>  /*
>   * Copyright (c) 2013, 2014 Christian Couder <chriscool@tuxfamily.org>
>   */
> @@ -1170,3 +1171,14 @@ void trailer_iterator_release(struct trailer_itera=
tor *iter)
>  	strbuf_release(&iter->val);
>  	strbuf_release(&iter->key);
>  }
> +
> +int amend_file_with_trailers(const char *path, struct strvec const* trai=
ler_args) {

I would have called this `amend_trailers_to_file()`, which feels a bit
easier to understand. But I don't mind this much, your version should be
okay, too.

In any case, the second argument should be `const struct strvec *`. For
one, the `const` should come first. Second, the `*` always sticks to the
variable name in our codebase.

> +	struct child_process run_trailer =3D CHILD_PROCESS_INIT;
> +
> +	run_trailer.git_cmd =3D 1;
> +	strvec_pushl(&run_trailer.args, "interpret-trailers",
> +		     "--in-place", "--no-divider",
> +		     path, NULL);
> +	strvec_pushv(&run_trailer.args, trailer_args->v);
> +	return run_command(&run_trailer);
> +}
> diff --git a/trailer.h b/trailer.h
> index 9f42aa75994..55f85b008ee 100644
> --- a/trailer.h
> +++ b/trailer.h
> @@ -3,6 +3,7 @@
> =20
>  #include "list.h"
>  #include "strbuf.h"
> +#include "strvec.h"

Arguably you don't have to include "strvec.h" here, but can instead add
a simple forward declaration `struct strvec`.

>  enum trailer_where {
>  	WHERE_DEFAULT,
> @@ -158,4 +159,11 @@ int trailer_iterator_advance(struct trailer_iterator=
 *iter);
>   */
>  void trailer_iterator_release(struct trailer_iterator *iter);
> =20
> +/*
> + * Augment a file to add trailers to it by running git-interpret-trailer=
s.
> + * This calls run_command() and its return value is the same (i.e. 0 for
> + * success, various non-zero for other errors). See run-command.h.
> + */
> +int amend_file_with_trailers(const char *path, struct strvec const* trai=
ler_args);

Same comments here regarding the second argument.

Patrick

--tOYVo8KvVppjMDy1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYwh4cACgkQVbJhu7ck
PpRQSw//fhJ1BdO8/s9PghGWulgzr3bAPDNVps3jK9pVUavUMNmyI0Ipj5dHXCED
lpaaJ0hU9jsgpbS3u0ZlmaE1Er3ARA9YFccL0J9eYhKMckljGVkgqHzyogaYq25N
DbLwVxs500IPxMWOMk9rpk4Rwi40ol/qyu1OslGNHb2mjIdfwn/a/v53yDiHyFg6
k6dbaxYIRgFakg/z0hjPS1P1ctkh09jyi/3BLvMlXykRlX4xLyhgV7bX99/hkjx+
jd16eHoL4EGgXLmWD1DdGrXWSc4E6fhCRqgmd3eJpoHH6pyzVbP7rEkawOuHaXOM
oC8XPyu+Uih4UCMHH37+/jjMJ6JlshHmY6cxBkmmzmYL3pz9xUiCPAQHxga+bH/U
Bn3Ubgntf1YDERAuV7A8XAg07DqnJ9xLEEranS3PNdudaOF0aH+ByiREad0wKgnr
M4DTtQ3ScxrFYsPROROnNf1tvCUBTh/wORY5awBAs9Eao6WNJCnx8q2y6e03WLnp
FaNe5u6SdZpKyt1mIRND//UzFeZ166pXTUatAoK8P3X5+ofWrqQAXAB6Dd9ZJh23
N/+VHsYYJbMeZ1SeTa4zowokxKWg4apeGx+5IKowxOl1F1Re+UciVX73E9mW7j43
i1ZM+n7bP3rqUrDPThj5vRoR4y1zZkxqYeAi4N2aUrx/jK8dsTc=
=cpgH
-----END PGP SIGNATURE-----

--tOYVo8KvVppjMDy1--
