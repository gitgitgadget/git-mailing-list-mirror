Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E19140E23
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 07:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717485553; cv=none; b=G5e1qqQftrWOpgevIqfRFjXZqgYS582PbuNVH2Mc2GmESYzplwpBHrMQmdrIYmIuYHXk0q55YwMuVnh4Tr0WAbI4n9qHV7wyXIS7xsZlXaNDCon1xHvbmhyfterAh6B4xXA9UoXkgykP83UPgueryWZPi1q6xpdsJB9bzgStyPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717485553; c=relaxed/simple;
	bh=+ls8VTRZn3o0e4rCZsJ7FN76isBFPa5NEURbLavqqoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7Gr/gz4MRfDPd6iAj/OZSZlt4///9GF0NVras43d0JOhBcf8+mgU6RG1AlNzpRGvRaAl5RnE5Nfo88jwxrqgCH1okuKFZ3RK4FbRnB7Q6I4NJyuQwBQn1GPDx+Ji4R4QYqAQWTa/uqqBsmstYPrSd9t/mq1fvCzQjLcRZJ0Ojg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IMz2f2+m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EhUwTt1A; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IMz2f2+m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EhUwTt1A"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 6A7F11800180;
	Tue,  4 Jun 2024 03:19:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 04 Jun 2024 03:19:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717485550; x=1717571950; bh=9rdVS5E9ih
	Di0E0fsmPH4o9QyOKqTDlB9/Ke4ijTN1E=; b=IMz2f2+mnpU+RRQUYDhM+bKB3i
	MLcYahzIo/uYvIipop57iPsBie0Q3iYSqNP/sTBo0m7TqqUNYK7GU14jxla/EtTK
	QTv+yRecz/40gTT0+MPwyqkB7e35Y54g/eUJucoARopJZfKYOHTBvW4lAXUvzMwg
	+ah94eXtK99I3XT3B/IV3sok2VXiKV2GUXiZtIxN+FEbNIaRzK/TGklLSCzDe6sE
	1CLfz45LtWrnWhmv9325nnCOWWKmKvwd49VbdLGXoryxmD36a+8wWZg2Fz3jMdnF
	3t5LDTKMcwv+JXWB9E9SBZWMEDTZ/RqQUCubbr/GYYjlSS7svP/aEqS259xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717485550; x=1717571950; bh=9rdVS5E9ihDi0E0fsmPH4o9QyOKq
	TDlB9/Ke4ijTN1E=; b=EhUwTt1AmQ8KusKsNov/J0dIydMmvIKwX2EeGYYJCpEW
	qgDDPJQQZeZiN4/Figch6n4LdjME5C/sPh6s3V8FMwUbm/mT/kR/Nq5o7DR4Wv+8
	ru8tkGVF1BjRTCty69qjMc13mNL38wJtH11jbetXUVDp+z2cx1rkh/OY0zW4Z86G
	cyYEJn477PJ3qstlhJ3xjlZJ1bsZ/1tq5DifJ86sGaudYMOaBg3NFJ22B7djSvuz
	zdJQ9Q+bjvP3iblpz8VlzTXtZhJrWDOO54KwKnTYLmxbnPxW0vlXJpAxwCseeodd
	w93/IFq1HsE5KpnswNAC7xOhOp3L3CKbm7uyaRLDYw==
X-ME-Sender: <xms:7b9eZlTvV98PhWyK8zvD9TY1TJow_6Z91zYSDgRkwPcRkSq1deP6Ow>
    <xme:7b9eZux63Nofl1Uc-wG9NLzRHttOg2iSKzL3sRB-p_eX5jL6bodgjtol6mdYMGAyS
    PVSjSzDnc30eM-Arw>
X-ME-Received: <xmr:7b9eZq22QDf60ZMb8HxA9heu_1UJOHPMzc879IkAyRL1ob9SZGFVwOV9eOBpl7fm97mpWe6QvlDSgmpazNXNREPL6Tg7O72SPMYxkmazjhF_RbwJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelfedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:7b9eZtChDF0u4QGRTjwHOGT19Nq1xRaVVqT2yS4uNUCYaRo3VjlPdw>
    <xmx:7b9eZuiJxb___CS6xkKsJkYzzDE4NHmMP9cJD-MfzHv18ZR4XjT-XQ>
    <xmx:7b9eZhrEyPPq-8SaGP83Gzc0CziD5uV4f-LAs2lDrwyFU2Ug_DN89w>
    <xmx:7b9eZphsQPP8UWMZnOBsuMBST1RxEAj5CeQ4m0rslK6X69PNFq6r1Q>
    <xmx:7r9eZhvscCwyRpJzzP3mMjy3_a8rDe3p7k_h5-h1d6LRfyYhC2UKoioL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 03:19:08 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id cdc1dea4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Jun 2024 07:18:41 +0000 (UTC)
Date: Tue, 4 Jun 2024 09:19:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org
Subject: Re: [PATCH 20/29] sequencer: fix leaking string buffer in
 `commit_staged_changes()`
Message-ID: <Zl6_6Z6Bu-zgOmPs@framework>
References: <cover.1717402439.git.ps@pks.im>
 <48bcd0ac80ee0b60eeda2bcedf55003a5049f289.1717402439.git.ps@pks.im>
 <758f2321-dc63-4209-8b54-99b74b6bb897@gmail.com>
 <Zl6390B6kUu5TlBM@framework>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3pEFehbRpiwhhgwA"
Content-Disposition: inline
In-Reply-To: <Zl6390B6kUu5TlBM@framework>


--3pEFehbRpiwhhgwA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2024 at 08:45:11AM +0200, Patrick Steinhardt wrote:
> On Mon, Jun 03, 2024 at 02:14:20PM +0100, Phillip Wood wrote:
> > Hi Patrick
> >=20
> > On 03/06/2024 10:48, Patrick Steinhardt wrote:
> > > @@ -5259,12 +5277,13 @@ static int commit_staged_changes(struct repos=
itory *r,
> > >   				}
> > >   			unuse_commit_buffer:
> > >   				repo_unuse_commit_buffer(r, commit, p);
> > > -				if (res)
> > > -					return res;
> > > +				if (res) {
> > > +					ret =3D res;
> > > +					goto out;
> > > +				}
> >=20
> > Having 'ret' and 'res' in this block is a bit confusing - we could dele=
te
> > the declaration for 'res' and  either replace its use with 'ret', or re=
name
> > 'ret' to 'res' in this patch.
>=20
> Yeah, let's just drop the local `res` variable here and use `ret`
> instead.

For the record, below is the diff to address this. I'll refrain from
sending out this whole patch series again for now to only address this
one issue, but will include it if there are more things that need to be
handled.

Patrick

diff --git a/sequencer.c b/sequencer.c
index 9e90084692..cc57a30883 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5253,7 +5253,6 @@ static int commit_staged_changes(struct repository *r,
 				 * We need to update the squash message to skip
 				 * the latest commit message.
 				 */
-				int res =3D 0;
 				struct commit *commit;
 				const char *msg;
 				const char *path =3D rebase_path_squash_msg();
@@ -5266,22 +5265,22 @@ static int commit_staged_changes(struct repository =
*r,
=20
 				p =3D repo_logmsg_reencode(r, commit, NULL, encoding);
 				if (!p)  {
-					res =3D error(_("could not parse commit %s"),
+					ret =3D error(_("could not parse commit %s"),
 						    oid_to_hex(&commit->object.oid));
 					goto unuse_commit_buffer;
 				}
 				find_commit_subject(p, &msg);
 				if (write_message(msg, strlen(msg), path, 0)) {
-					res =3D error(_("could not write file: "
+					ret =3D error(_("could not write file: "
 						       "'%s'"), path);
 					goto unuse_commit_buffer;
 				}
+
+				ret =3D 0;
 			unuse_commit_buffer:
 				repo_unuse_commit_buffer(r, commit, p);
-				if (res) {
-					ret =3D res;
+				if (ret)
 					goto out;
-				}
 			}
 		}
=20

--3pEFehbRpiwhhgwA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZev+gACgkQVbJhu7ck
PpQVtg/+OENX5BGsJZQTFUFVWqlPxpw8/0s9eWUrWOaTGwfqZ6dMfDzMpOSPivki
6475run7+dzPOn+Sz2xTt2ePhQi3fzLgy9PoZFJZgh3fEewwi273q7G8YSx/Imy4
UH2Yb2mzltoI3wTlyO1oCXGFNrn+swOLqMZ1XqVVfGD/JdU15zdbHtCwZI85V6Rp
DRqfFXnb4+dTvtCeeBBzdkF8Pb/BYiTh8exfpsueXT+f+ydJGKkXtMz1psLONK60
DPpVkp3z7OGF6Bx//GHHiaLougMuRkjMl0Jrj1U4+wC7eFDgipAjg+XtA0vR+03g
jaspT5gAyHdHxa0+Q+m/n5IOvBXNqCTYH6yNm2VxWJ42iE4rh7eXr94e0OL4yVfJ
XCuEvWfnkYvGXw7Lk5BRUv6hMlHThkFrrL7lY7zR7I4dfCCtwmxKjDJvpMYfgzI/
vJAFIX6C9RkllzCEr/p4JwhhDaQGBMYS8UrGpHpWp2OM0Z3nQiiuff8waIUwHp4/
/dNanapP1TQ+2/vx33b5gvTfHA2e/r/VqWA0TO/7eIH4YyFTQ7g0MWwDkKx3xTlK
NYvco+HGzOrDlIxaddm/TcdR+YNOLmrBXsFK50JcvGg2T9TJs4xbfjFpD9mjzafJ
0G6xpL2KnpKzHhpfY69jgBOoNlqVH4vM3QSLFhkBzlvwaunwLjg=
=hvjV
-----END PGP SIGNATURE-----

--3pEFehbRpiwhhgwA--
