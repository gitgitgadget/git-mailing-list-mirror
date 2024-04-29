Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FA513AE2
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 06:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714373409; cv=none; b=rG3DnPrXHiDSitxq4sAJ+Nr9LYmZ0s692tZv5CUfS/sjBCSEQaY+/XW29Kn0HJ9xqvxWUNL2o6ZOhb/NRX/kqy3ALgb222ta3ltyeaqZKWsEAErxHqDnYfyTAHqI2a4cMOafsA9ihnB8RUK+tWWssVKORdODiqcqH8SL1loBgeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714373409; c=relaxed/simple;
	bh=xa8QwzCq1uxVlY8tS14xR3chixYXgsgGIeL2LiJA5VQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRfsgaL3fub2i4mu5v2sFaKGAwHusZOaLk4LLDy2XcPLfzI7uIm+QB+fBSmx9vqCpyk9Mt8fTge89r4jtnk375aQHX3jfjIN8u1O6+LwgXDmiW845Ni3a2JA0OX4VGOghAqpwZNNdOk2NZW9F7W26v884PJwAD7Swp4/1x8xQ7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=THpJRSeb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OuwA7jzu; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="THpJRSeb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OuwA7jzu"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 92C4B1140133;
	Mon, 29 Apr 2024 02:50:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 29 Apr 2024 02:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714373406; x=1714459806; bh=Vb9G7j+NGT
	xzgD2sxzfKPiHZffWhwgCiEEb8706iPhw=; b=THpJRSebmQ+XLpABoV6J/aAq/b
	A5YmvAKdm+pXE8dLbtQwHCL0g/Yyu0XWgmWdM4OJZGKAx32iRfdtF0P439vWd/2t
	I2GetU5ugIFhuBYU1hwR4uhl9j4DXFDQ8w4c1eR3+La5gzF/8LxRzKafRMfbbKSL
	lLXgR66LMthY0c4bi/KBQ5ujE7ck1O2o5cQWoAjNTHr4y/LUYY3KRFlnss2lKaH7
	kBmnP+PxQkogo/OX07Lc/hfjzdA+9lv/2wnA+N3r5nVo8daKPSMccV7bqzCur79H
	bwUEJi+ssp40cuewmnu09VLBRyO8iIuGypDCca2hGo/TYjcAi5uaha4vVTzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714373406; x=1714459806; bh=Vb9G7j+NGTxzgD2sxzfKPiHZffWh
	wgCiEEb8706iPhw=; b=OuwA7jzukClX0zBsXLszfGoBFLXt/2mzDx/AtJcOa/ym
	JgnivizGr/iBGkBdBgjr7aB9+Rerd3/dI3GEVgipPl2WWOAgdVk5JUXFFMW+Qm4I
	vuvcyPZsrqCO2RSIWWUmH51xyoyzYtTaPGZZi0BuHpxE6+zy8Dh4VJ3SBsrzCPhN
	w5V7pwhua2Lc1zDHTYIWK0YpFOyANeXMhO/+CXFkze6KDGb9u5zpK6jCYqXaPXvI
	aPqppFASIfFNQl3eQue4ZVOoBwpDka86wN1k36+ndKfO5mCBoN1r84pgWc31rfPt
	4zsEDwELgx4/TqH+CzcTwRvrH5pW2U23wJJTHeVXvg==
X-ME-Sender: <xms:HkMvZu093JEETEj9V8uHxQ7s6hKi9HaNy8ASItsdxJj68NV9PUP3Mw>
    <xme:HkMvZhFo294LnMFzNYgUxLNVG_unzbZLb-zh_euDCoxj9fJg0aR5hLHPf01rHLaex
    HToK4qJaRqCNxFdBg>
X-ME-Received: <xmr:HkMvZm7t9qcFtyKjBRon9i6H_-h3f4SlTy_4cR7GLP31z0SFist833xOVwR3kRFtOgcxlg9c7NMt9vuJbeAMluFZwAdHp0s0-p2CHx9R8wDOeswV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddutddgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:HkMvZv1Xv-fU2k2ufEOqMWXGKAa1IYGX1AvR2wrPrs17m0LDcsaAlg>
    <xmx:HkMvZhGJBVX9Fx3f0lApFGHPv9sBwQ_3AwRQxY0yZXgMAh737DB08g>
    <xmx:HkMvZo8-E8dmWG7CtY5t4tcwPc2O4aCLd1Vuh-xre4iRoG8o85i2FA>
    <xmx:HkMvZmmu1y1_2W5mMmrCkcbVjKazKsEEaKEeLeN3mtodbamCGrxofw>
    <xmx:HkMvZhBHqV4s-JUXrvcIzY1wFTZvD-ss9M8dhdeqJgwcd3ZdPpB5DE2m>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 02:50:05 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id bc988585 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Apr 2024 06:49:44 +0000 (UTC)
Date: Mon, 29 Apr 2024 08:50:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: John Passaro via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, John Passaro <john.a.passaro@gmail.com>
Subject: Re: [PATCH] builtin/tag.c: add --trailer arg
Message-ID: <Zi9DGYwlT7VnW7oj@tanuki>
References: <pull.1723.git.1714365076246.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Atq81V1XSWVKJrxt"
Content-Disposition: inline
In-Reply-To: <pull.1723.git.1714365076246.gitgitgadget@gmail.com>


--Atq81V1XSWVKJrxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 04:31:15AM +0000, John Passaro via GitGitGadget wro=
te:
> From: John Passaro <john.a.passaro@gmail.com>
>=20
> Teach git-tag to accept --trailer option to add trailers to annotated
> tag messages, like git-commit.
>=20
> Signed-off-by: John Passaro <john.a.passaro@gmail.com>

This feels like a sensible addition to me indeed, thanks!

[snip]
> diff --git a/builtin/tag.c b/builtin/tag.c
> index 9a33cb50b45..0334a5d15ec 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -28,9 +28,11 @@
>  #include "date.h"
>  #include "write-or-die.h"
>  #include "object-file-convert.h"
> +#include "run-command.h"
> =20
>  static const char * const git_tag_usage[] =3D {
>  	N_("git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [-e]\n"
> +	   "        [(--trailer <token>[(=3D|:)<value>])...]\n"
>  	   "        <tagname> [<commit> | <object>]"),
>  	N_("git tag -d <tagname>..."),
>  	N_("git tag [-n[<num>]] -l [--contains <commit>] [--no-contains <commit=
>]\n"
> @@ -290,10 +292,11 @@ static const char message_advice_nested_tag[] =3D
>  static void create_tag(const struct object_id *object, const char *objec=
t_ref,
>  		       const char *tag,
>  		       struct strbuf *buf, struct create_tag_options *opt,
> -		       struct object_id *prev, struct object_id *result, char *path)
> +		       struct object_id *prev, struct object_id *result, struct strvec=
 *trailer_args, char *path)

This line is overly long now, let's break it.

>  {
>  	enum object_type type;
>  	struct strbuf header =3D STRBUF_INIT;
> +	int should_edit;
> =20
>  	type =3D oid_object_info(the_repository, object, NULL);
>  	if (type <=3D OBJ_NONE)
> @@ -313,14 +316,18 @@ static void create_tag(const struct object_id *obje=
ct, const char *object_ref,
>  		    tag,
>  		    git_committer_info(IDENT_STRICT));
> =20
> -	if (!opt->message_given || opt->use_editor) {
> +	should_edit =3D opt->use_editor || !opt->message_given;
> +	if (should_edit || trailer_args->nr) {
>  		int fd;
> =20
>  		/* write the template message before editing: */
>  		fd =3D xopen(path, O_CREAT | O_TRUNC | O_WRONLY, 0600);
> =20
> -		if (opt->message_given) {
> +		if (opt->message_given && buf->len) {
>  			write_or_die(fd, buf->buf, buf->len);
> +			if (trailer_args->nr && buf->buf[buf->len-1] !=3D '\n') {
> +				write_or_die(fd, "\n", 1);
> +			}

We avoid braces around single-line statements.

I was also wondering whether we can simplify this to:

    if (opt->message_given && buf->len) {
        strbuf_complete(buf, '\n');
        write_or_die(fd, buf->buf, buf->len);
    }

Or does changing `buf` cause problems for us?

>  			strbuf_reset(buf);
>  		} else if (!is_null_oid(prev)) {
>  			write_tag_body(fd, prev);
> @@ -338,10 +345,31 @@ static void create_tag(const struct object_id *obje=
ct, const char *object_ref,
>  		}
>  		close(fd);
> =20
> -		if (launch_editor(path, buf, NULL)) {
> -			fprintf(stderr,
> -			_("Please supply the message using either -m or -F option.\n"));
> -			exit(1);
> +		if (trailer_args->nr) {
> +			struct child_process run_trailer =3D CHILD_PROCESS_INIT;
> +
> +			strvec_pushl(&run_trailer.args, "interpret-trailers",
> +				     "--in-place", "--no-divider",
> +				     path, NULL);
> +			strvec_pushv(&run_trailer.args, trailer_args->v);
> +			run_trailer.git_cmd =3D 1;
> +			if (run_command(&run_trailer))
> +				die(_("unable to pass trailers to --trailers"));
> +		}

This part is copied from `builtin/commit.c`. Would it make sense to move
it into a function `amend_trailers_to_file()` or similar that we add to
our trailer API so that we can avoid the code duplication?

> +		if (should_edit) {
> +			if (launch_editor(path, buf, NULL)) {
> +				fprintf(stderr,
> +				_("Please supply the message using either -m or -F option.\n"));
> +				exit(1);
> +			}

I know you simply re-indented the block here, but let's also fix the
indentation of the second argument to fprintf(3P) while at it.

> +		} else if (trailer_args->nr) {
> +			strbuf_reset(buf);
> +			if (strbuf_read_file(buf, path, 0) < 0) {
> +				fprintf(stderr,
> +						_("Please supply the message using either -m or -F option.\n"));
> +				exit(1);
> +			}
>  		}
>  	}
> =20
> @@ -416,6 +444,14 @@ struct msg_arg {
>  	struct strbuf buf;
>  };
> =20
> +static int opt_pass_trailer(const struct option *opt, const char *arg, i=
nt unset)
> +{
> +	BUG_ON_OPT_NEG(unset);
> +
> +	strvec_pushl(opt->value, "--trailer", arg, NULL);
> +	return 0;
> +}
> +
>  static int parse_msg_arg(const struct option *opt, const char *arg, int =
unset)
>  {
>  	struct msg_arg *msg =3D opt->value;
> @@ -463,6 +499,7 @@ int cmd_tag(int argc, const char **argv, const char *=
prefix)
>  	struct ref_sorting *sorting;
>  	struct string_list sorting_options =3D STRING_LIST_INIT_DUP;
>  	struct ref_format format =3D REF_FORMAT_INIT;
> +	struct strvec trailer_args =3D STRVEC_INIT;
>  	int icase =3D 0;
>  	int edit_flag =3D 0;
>  	struct option options[] =3D {
> @@ -479,6 +516,7 @@ int cmd_tag(int argc, const char **argv, const char *=
prefix)
>  		OPT_CALLBACK_F('m', "message", &msg, N_("message"),
>  			       N_("tag message"), PARSE_OPT_NONEG, parse_msg_arg),
>  		OPT_FILENAME('F', "file", &msgfile, N_("read message from file")),
> +		OPT_CALLBACK_F(0, "trailer", &trailer_args, N_("trailer"), N_("add cus=
tom trailer(s)"), PARSE_OPT_NONEG, opt_pass_trailer),
>  		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of tag message")),
>  		OPT_BOOL('s', "sign", &opt.sign, N_("annotated and GPG-signed tag")),
>  		OPT_CLEANUP(&cleanup_arg),
> @@ -548,7 +586,7 @@ int cmd_tag(int argc, const char **argv, const char *=
prefix)
>  		opt.sign =3D 1;
>  		set_signing_key(keyid);
>  	}
> -	create_tag_object =3D (opt.sign || annotate || msg.given || msgfile);
> +	create_tag_object =3D (opt.sign || annotate || msg.given || msgfile || =
edit_flag || trailer_args.nr);
> =20
>  	if ((create_tag_object || force) && (cmdmode !=3D 0))
>  		usage_with_options(git_tag_usage, options);
> @@ -635,7 +673,7 @@ int cmd_tag(int argc, const char **argv, const char *=
prefix)
>  	else if (!force)
>  		die(_("tag '%s' already exists"), tag);
> =20
> -	opt.message_given =3D msg.given || msgfile;
> +	opt.message_given =3D msg.given || (msgfile !=3D NULL);
>  	opt.use_editor =3D edit_flag;

Besides being not required, this change also violates our coding style
where we don't explicitly check for NULL pointers.

>  	if (!cleanup_arg || !strcmp(cleanup_arg, "strip"))
> @@ -653,7 +691,7 @@ int cmd_tag(int argc, const char **argv, const char *=
prefix)
>  		if (force_sign_annotate && !annotate)
>  			opt.sign =3D 1;
>  		path =3D git_pathdup("TAG_EDITMSG");
> -		create_tag(&object, object_ref, tag, &buf, &opt, &prev, &object,
> +		create_tag(&object, object_ref, tag, &buf, &opt, &prev, &object, &trai=
ler_args,
>  			   path);

Nit: let's move `&trailer_args` to the next line to not make it overly
long.

>  	}
> =20
> @@ -686,6 +724,7 @@ int cmd_tag(int argc, const char **argv, const char *=
prefix)
>  	strbuf_release(&reflog_msg);
>  	strbuf_release(&msg.buf);
>  	strbuf_release(&err);
> +	strvec_clear(&trailer_args);
>  	free(msgfile);
>  	return ret;
>  }
> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index 696866d7794..364db2b4685 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -668,6 +668,105 @@ test_expect_success \
>  	test_cmp expect actual
>  '
> =20
> +# trailers
> +
> +get_tag_header tag-with-inline-message-and-trailers $commit commit $time=
 >expect
> +cat >>expect <<EOF
> +create tag with trailers
> +
> +my-trailer: here
> +alt-trailer: there
> +EOF

You probably just follow precedent in this file, but our modern coding
style sets up the `expect` file inside of the test body itself. You also
do it like that in other tests, so let's be consistent.

The same comment applies to other tests, as well.

Patrick

--Atq81V1XSWVKJrxt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYvQxgACgkQVbJhu7ck
PpRAxhAAmeV2YgH2q+FOcpeff33oG/zC4pinI1MH0O/053YBJSWG0CwDa7EqUXek
ksbWSMFAgvrNWmmtjuCd7VQCF49fpRCr+sDsivJj6JviAb5ZoASwnroyD/AJqNIr
ewB57zhXTJyfZ+Yh9kmYZVCRzsPw9NUM7WcWLkFjyEZkNEKh29IGSBLtOKYMSkvc
IvwsgD//TE6EZrxWShHBz1lFX0XbwBSPXgiCeUCWtOuxxgeQi4GZ2bpL4+UruOYh
rn9emHvkUk0Jq2R76ke8X8O1UeIkumQglFts0dcObXZbIbcLwE4QW8TLv/Tzwf+k
TOC5K6/pQ2jX/Z+TQRtD2kAjRcd+Ks/DGMOHPw7DvAPpsLZUCN8y8GPiSfNG3OcV
4/o2ABhcd3LmErYnBGSZMRaDSJ4e3GgCrVolR6+ZKjd8qWAf+Bmd/2fKst76seVS
uqxUK8kXegHZThOQR70roXWiM577aP8i4ZtIc6wnoO241GoP4WwRUt4AHD/kKGjD
DN5Ug38oTTzGUUf/wS3Cuwge3F5BtZ9hpGJwbWshSQDNLxG0OrKF5FgpKoN4SS7e
DC3Ay6lBq9EpIKdoiqUSvVmjsgNfM72+AtImt35kPHGBNm0FJlGa6Z6h5ADzRugx
6/5WDYKi7WBzCeO9045RtD/gzL/k1+pkOCyp4a25AneR4/nThA8=
=M4Mm
-----END PGP SIGNATURE-----

--Atq81V1XSWVKJrxt--
