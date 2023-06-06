Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48259C77B7A
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 05:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234203AbjFFFAK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jun 2023 01:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbjFFFAH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2023 01:00:07 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E291D1BB
        for <git@vger.kernel.org>; Mon,  5 Jun 2023 22:00:05 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 27BDB3200B3F;
        Tue,  6 Jun 2023 01:00:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 06 Jun 2023 01:00:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1686027604; x=1686114004; bh=TZ
        KtDrCzspTv1tAMh4QBdsVOmc9LP4gvAjp5Y3rHCps=; b=Op22LfkJpr5qNwha0+
        yVDRFbg6ppmlY0eZJ4MEdr4Qi3egGo98pq+G/k3b/Qfz8k9B/xn6t3xjW1bhGMqK
        dxYabCj1vdfUq/4TkjRbQiLmkZnLptk+YHS50KVfrl36dEPtfc4AxGbBop+OurQC
        jwX4paF4msX/vSavEZ6j33GyddYOub8nLNLFrz92Twd0bl+mnZIqVZfokO/sPgbA
        tkJ1z6rmK563FHajIFUhF4ywjQpBlhN8msgbHTPRqXCgxQLSkEgOJKR+1Wpr1u8y
        38upT9JILQb+m5omhsSAYHGO/GjblDvpV4cIywdSBBbZjPKkIr4CeVS4D0Yk0u/3
        bFLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686027604; x=1686114004; bh=TZKtDrCzspTv1
        tAMh4QBdsVOmc9LP4gvAjp5Y3rHCps=; b=LstsFeVns7ny9uEWDa9Zg3Xu1MLRX
        l6J76JVTkhJZNqeyMiwKxHoeMbmkaohQOeo7yXjBYzhkNTEqO4MMSaWQ9fYACHb4
        yTHc7x69qhQWf/PrNexBuMyCKgH2Jg4d9n9KpIEQ4byjUcVCz9CPHoKOdAZCyyw0
        FWg+Uq13M6aUHeazWrZsq4Hg6KedNFLiT0Ja/GVMoziZJU4J4Jf8Fhgiy8r80A9X
        0R2RnRIpCwZ/Rtdi7+3f1h/oCaG40ZBdZE5UoG9XY2QsjspYIVJ0oRnUdGI02XwI
        BVXQse8ccW7aF+IRdviDI8pWOF/JmLSL8MtPpksXsCU96SxXamUeZT4HA==
X-ME-Sender: <xms:U71-ZBeQqF7l-deomVnU0KcK0B0v4EqMvby6m8Bg9j1gZdLeM7LlEA>
    <xme:U71-ZPMfZM4U3shF6MDCuDI0-gdW6prgMj5OD4u9A-Z4r3HsnP_-vSsBV9kJMJsRw
    qcqCTcA55A5Fw-Onw>
X-ME-Received: <xmr:U71-ZKhEuvoAWJEIY0tVy5j8GfCj2QRMAEEEpSjeUHLQgYd3WUMc0mgEv1IAWoOhNxmN-kM7yUUkwpLr0ZpKtsoB4w1n2qP7y1fLjogxDLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedttddgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:U71-ZK-XwVptxhY0LzDx0SJ_TisLS1uAelEqDFjYzPu6uvb-lwSlRQ>
    <xmx:U71-ZNuTTGZspfQLYmlEq11ykD2bB8IDdAvVO21AaqeR4xvZ7rrGSA>
    <xmx:U71-ZJFSPBTUrYLAOp_HmSvRjZ4pYKlqQVB7KNvjn_TwyHNaoz9X_A>
    <xmx:VL1-ZFIZrPZhcS4HmV38aGMgaFken3CIKU_sE3RMv1F7lgZQnarGrQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jun 2023 01:00:02 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id ad5b5869 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 6 Jun 2023 04:58:58 +0000 (UTC)
Date:   Tue, 6 Jun 2023 07:00:00 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] cat-file: Introduce new option to delimit output
 with NUL characters
Message-ID: <ZH69UBT_H0OtGR6l@ncase>
References: <cover.1685710884.git.ps@pks.im>
 <07a7c34615ec68fa42c725fd34d6144b6b191f03.1685710884.git.ps@pks.im>
 <9900512f-b0da-2e47-f1ab-ed51ec2c78ff@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Y92GeaU3FvbBpRQ2"
Content-Disposition: inline
In-Reply-To: <9900512f-b0da-2e47-f1ab-ed51ec2c78ff@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Y92GeaU3FvbBpRQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 05, 2023 at 04:47:14PM +0100, Phillip Wood wrote:
> > @@ -384,6 +390,11 @@ notdir SP <size> LF
> >   is printed when, during symlink resolution, a file is used as a
> >   directory name.
> >  =20
> > +Alternatively, when `-Z` is passed, the line feeds in any of the above=
 examples
> > +are replaced with NUL terminators. This ensures that output will be pa=
rsable if
> > +the output itself would contain a linefeed and is thus recommended for
> > +scripting purposes.
> > +
> >   CAVEATS
> >   -------
> >  =20
> > diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> > index 001dcb24d6..90ef407d30 100644
> > --- a/builtin/cat-file.c
> > +++ b/builtin/cat-file.c
> > @@ -492,17 +494,18 @@ static void batch_object_write(const char *obj_na=
me,
> >   	strbuf_reset(scratch);
> >  =20
> >   	if (!opt->format) {
> > -		print_default_format(scratch, data);
> > +		print_default_format(scratch, data, opt);
> >   	} else {
> >   		strbuf_expand(scratch, opt->format, expand_format, data);
> > -		strbuf_addch(scratch, '\n');
> > +		strbuf_addch(scratch, opt->output_delim);
> >   	}
> >  =20
> >   	batch_write(opt, scratch->buf, scratch->len);
> >  =20
> >   	if (opt->batch_mode =3D=3D BATCH_MODE_CONTENTS) {
> > +		char buf[] =3D {opt->output_delim};
>=20
> I found this a bit confusing, I think it would be clearer just to do
>=20
> 	batch_write(opt, &opt->output_delim, 1);

Agreed, that's cleaner.

> >   		print_object_or_die(opt, data);
> > -		batch_write(opt, "\n", 1);
> > +		batch_write(opt, buf, 1);
> >   	}
> >   }
>=20
> > @@ -920,7 +927,7 @@ int cmd_cat_file(int argc, const char **argv, const=
 char *prefix)
> >   		N_("git cat-file (-t | -s) [--allow-unknown-type] <object>"),
> >   		N_("git cat-file (--batch | --batch-check | --batch-command) [--bat=
ch-all-objects]\n"
> >   		   "             [--buffer] [--follow-symlinks] [--unordered]\n"
> > -		   "             [--textconv | --filters] [-z]"),
> > +		   "             [--textconv | --filters] [-z] [-Z]"),
>=20
> If we're recommending that people don't use '-z' then maybe we should=20
> remove it from the synopsis and add OPT_HIDDEN to it below.

I might still change this depending on the conclusion Junio and I will
arrive at, but for now I agree that this makes sense.

> >   		N_("git cat-file (--textconv | --filters)\n"
> >   		   "             [<rev>:<path|tree-ish> | --path=3D<path|tree-ish> =
<rev>]"),
> >   		NULL
> > @@ -950,6 +957,7 @@ int cmd_cat_file(int argc, const char **argv, const=
 char *prefix)
> >   			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
> >   			batch_option_callback),
> >   		OPT_BOOL('z', NULL, &input_nul_terminated, N_("stdin is NUL-termina=
ted")),
> > +		OPT_BOOL('Z', NULL, &nul_terminated, N_("stdin and stdout is NUL-ter=
minated")),
>=20
> > diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> > index 7b985cfded..d73a0be1b9 100755
> > --- a/t/t1006-cat-file.sh
> > +++ b/t/t1006-cat-file.sh
> > @@ -392,17 +393,18 @@ deadbeef
> >  =20
> >   "
> >  =20
> > -batch_output=3D"$hello_sha1 blob $hello_size
> > -$hello_content
> > -$commit_sha1 commit $commit_size
> > -$commit_content
> > -$tag_sha1 tag $tag_size
> > -$tag_content
> > -deadbeef missing
> > - missing"
> > +printf "%s\0" \
> > +	"$hello_sha1 blob $hello_size" \
> > +	"$hello_content" \
> > +	"$commit_sha1 commit $commit_size" \
> > +	"$commit_content" \
> > +	"$tag_sha1 tag $tag_size" \
> > +	"$tag_content" \
> > +	"deadbeef missing" \
> > +	" missing" >batch_output
>=20
> I think writing the expected output to a file is a good change as we=20
> always use it with test_cmp. As "-z" is deprecated I think it makes=20
> sense to model the expected output for "-Z" and use tr for the "-z"=20
> tests as you have done here. It looks like we have good coverage of the=
=20
> new option.

It's actually also required in order to not have to specify the expected
output twice. While we could leave this as-is, translating it to be NUL
terminated via `tr \n \0` doesn't work as the output contains newlines
in places where we don't want to translate them to NUL delimiters. And
storing the NUL-delimited string in a variable doesn't work either as
shells will truncate the C strings.

Thanks for your review!

Patrick

--Y92GeaU3FvbBpRQ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmR+vU8ACgkQVbJhu7ck
PpTZxg//Q9jwuu4rdVGg0zPSG1wSUf+eWmjqbC6QytEAxH0J3bskXdgGWdm/i3af
uK1MDRAWIve3P9eUBRDWZGuKPVEHvGfO2vWeNfX8vgtCkecd6NW/nJBcg/RjjvRf
YbH7gnAdfpD5yY1kya7rI4zfitZmpszRfe4E5xMclCRtC2Jut07nJnXM1/Sc4tD3
jZgebGCu9owcspt2JD/J6qhSFJPp2fkcq4+Sw/8Myq8XPWYRmyi315fbViIY3DwO
c/x8OhORMdU/tCu4JzpaH8odvwwgi5kgNSm/bFqwFZt38V1DBz4ubb9iRIxgnWdV
zIA6b0aqhAmE2uwoBIMIuh6BXKi0SD2/On+oc908OPV5nQ+FVLe1l8jedKeym18q
y/VuPFEx4BsKrF4pUR9OCzR4pUNSDUW3N0ENVmKkCj38ffbV+cn/PGHqeKOE2JeU
nEFm/UdEos0bK1VwW+dSJHkzrnrqCkb7WDIa7OmTw7ygZbEVazrwvkJXaanrenvG
etglMaW8xZHhy6SlRHztL4PaRdAZR2NER8SGaHjkcT9imUCmpBfh6SN6p7cBVJcZ
fALsnvn5y2hk0aSSpi1DBo7UdqfLlI4crr3nw79L4TcN/tGwPZunzazIzQrxAkuL
niNw2BqzsZXjgeRs9h9iPa1MxYlY6tRkYg75dMsHxCwfnPH+qas=
=KtI7
-----END PGP SIGNATURE-----

--Y92GeaU3FvbBpRQ2--
