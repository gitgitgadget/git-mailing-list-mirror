Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACC883CDF
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717408022; cv=none; b=efqpZ/biIw6VmYKRa3hjtJ7gL3U66YoWOLb0+0d7H2PEpZohvZQLXnHX0vPi6QR2NDVrTDua3FZ8Yy9UzrXzFeS/Y71WO7o1Dq90B8lS+Tk6GcTidntW6Z1NMVPJ7Al+YWhiwpgh8TgCEng7Engb/1vR3J/OVO5ZUZUE44KgiDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717408022; c=relaxed/simple;
	bh=Q8NoaU7heMKLgZTykLqPxf1odm/eY90bKs9iquFdG6Q=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUHAGgc905dXimgqGq2wZo3U7N6gvjR1f+ouyqByMqIWf9eFzwQfrLFa9T6ptKzatrw/rM7Ya0Q5ArxyPHpJ3b6oinFJagVu61F4vzX04ggqFQQYKUrRL2yXJ9xvdNPPtnNxPdbIEfiHiwyGpLPaJERDahMRgc8UMSXAdSo9cuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hsFB2VhL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mBATQTuo; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hsFB2VhL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mBATQTuo"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 9FCF81800076
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 05:47:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 03 Jun 2024 05:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717408020; x=1717494420; bh=hV4zXY7OrV
	EgJVIYIo+q8Ge5bkJL56hmM5o+uRCL2H4=; b=hsFB2VhLMlpE6kC7Ec/FhTWKyO
	QsWDnkkQQoElmIv4xEu/uNUIER13/eIZYhddhqWk0ajs5lJ3aTlJCdT4yRqjRZeb
	kFZNFXFl/m+z7tYBNnkW7iYbLIOyfwV57M1din3lEF43gEG78uWA4LN4FZCTrxHa
	KxbztBRQXDnt2tDNpMir8Z/tgXAXtOC7HXY2yAHdGFfxEyH0fpk0439PneOgamlK
	9yjLuY21jx2R415V8/6tc1fhpGramTvUFnHL9pRFtxIdAtMuxxo2w0hqMwifvgXc
	CIb8h7b0lFY3i26OPBQReTl5iCNxALbnVxOeNNq3T+RirATWK37mbRQEcG5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717408020; x=1717494420; bh=hV4zXY7OrVEgJVIYIo+q8Ge5bkJL
	56hmM5o+uRCL2H4=; b=mBATQTuo5g9udUaXLp9l482WPO87Q3ktEl38Bk65hk2p
	/ZWW516Y6K7VyBLDEHCUa50cBb6/EJaTvqMOhR18SdSJG9oeCHOMLLgiREg1+ojJ
	jr1di5JJ4m3+4FLQqC72q7oFl+Apanz9RlGiQP0xuuiXSr8D2A1wEG7cUX7IKCA0
	3718SU1BYue3yTaddNddeo9RIq42LduySwIcESquI46Bl5ZTjdNaE4wsit6DgmEQ
	2k1C9gRyymwrC+qx2cbCaSpSCIxjLKcnwBu/kGIFlnnBuB+BhlN6aQRkuUOqQLQn
	ab6d/VQc+EpRnAxr8Xu1/ZfklsjT0lmIavICONqBig==
X-ME-Sender: <xms:FJFdZquJLA0qQMxfOzi2TCDoH-l84u-LQZ6BSMgOAivbcabEIQIGWQ>
    <xme:FJFdZvdbQBuNd_bbw8hQMsw_plm2yGhET598ioLnqjQFwbEsW83UZhFokvFLVBcTB
    HhQ8LeOdvk8lCujGw>
X-ME-Received: <xmr:FJFdZlxqG17Jyh3iERhkoIAJJ6OR9T1m0j-4teKXlMvqrNH-sYz5LJMlmf3BP7pD4LXYub4U1Cho2MtDiVLkOimrEIkh8QaAmiosQsFKKEoJrkvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:FJFdZlNd7sw0QdeP7Z-NmcQgRnylAeDlnnR3DE0IALpYIMYNJlZ-UA>
    <xmx:FJFdZq8SHqhbYmPvV1NHcEzabWpWYj4gLf2Sit4qIBK4tCI2AKX0Zg>
    <xmx:FJFdZtXK0RXhTmRgZIL-6HXeEI-Hol7WwBX-2oZIEeaCgz4y7Qt7cw>
    <xmx:FJFdZjdMiOu48ZIM96qZNP652HYgVDqKBY1UCqcub0akN4Mf7TWk3A>
    <xmx:FJFdZgmgBpxC6DwHwY_AAmfmi6YlB6OLgh3JnVABQnISBbm4OHsxraFL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 3 Jun 2024 05:46:59 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 6fc46beb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 3 Jun 2024 09:46:35 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:46:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 07/29] revision: fix leaking display notes
Message-ID: <8c55370b8efe0d83946af5ad007c60c902974c72.1717402439.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AO1lidYNUmQiEJpD"
Content-Disposition: inline
In-Reply-To: <cover.1717402439.git.ps@pks.im>


--AO1lidYNUmQiEJpD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We never free the display notes options embedded into `struct revision`.
Implement a new function `release_display_notes()` that we can call in
`release_revisions()` to fix this.

There is another gotcha here though: we play some games with the string
list used to track extra notes refs, where we sometimes set the bit that
indicates that strings should be strdup'd and sometimes unset it. This
dance is done to avoid a copy of an already-allocated string when we
call `enable_ref_display_notes()`. But this dance is rather pointless as
we can instead call `string_list_append_nodup()` to transfer ownership
of the allocated string to the list.

Refactor the code to do so and drop the `strdup_strings` dance.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 notes.c          | 14 ++++++++------
 notes.h          |  5 +++++
 revision.c       |  1 +
 t/t3301-notes.sh |  1 +
 4 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/notes.c b/notes.c
index 53ca25c814..6a157e34ce 100644
--- a/notes.c
+++ b/notes.c
@@ -1060,6 +1060,12 @@ void init_display_notes(struct display_notes_opt *op=
t)
 {
 	memset(opt, 0, sizeof(*opt));
 	opt->use_default_notes =3D -1;
+	string_list_init_dup(&opt->extra_notes_refs);
+}
+
+void release_display_notes(struct display_notes_opt *opt)
+{
+	string_list_clear(&opt->extra_notes_refs, 0);
 }
=20
 void enable_default_display_notes(struct display_notes_opt *opt, int *show=
_notes)
@@ -1073,19 +1079,15 @@ void enable_ref_display_notes(struct display_notes_=
opt *opt, int *show_notes,
 	struct strbuf buf =3D STRBUF_INIT;
 	strbuf_addstr(&buf, ref);
 	expand_notes_ref(&buf);
-	string_list_append(&opt->extra_notes_refs,
-			strbuf_detach(&buf, NULL));
+	string_list_append_nodup(&opt->extra_notes_refs,
+				 strbuf_detach(&buf, NULL));
 	*show_notes =3D 1;
 }
=20
 void disable_display_notes(struct display_notes_opt *opt, int *show_notes)
 {
 	opt->use_default_notes =3D -1;
-	/* we have been strdup'ing ourselves, so trick
-	 * string_list into free()ing strings */
-	opt->extra_notes_refs.strdup_strings =3D 1;
 	string_list_clear(&opt->extra_notes_refs, 0);
-	opt->extra_notes_refs.strdup_strings =3D 0;
 	*show_notes =3D 0;
 }
=20
diff --git a/notes.h b/notes.h
index 064fd7143a..235216944b 100644
--- a/notes.h
+++ b/notes.h
@@ -275,6 +275,11 @@ struct display_notes_opt {
  */
 void init_display_notes(struct display_notes_opt *opt);
=20
+/*
+ * Release resources acquired by the display_notes_opt.
+ */
+void release_display_notes(struct display_notes_opt *opt);
+
 /*
  * This family of functions enables or disables the display of notes. In
  * particular, 'enable_default_display_notes' will display the default not=
es,
diff --git a/revision.c b/revision.c
index af95502d92..75e71bcaea 100644
--- a/revision.c
+++ b/revision.c
@@ -3168,6 +3168,7 @@ void release_revisions(struct rev_info *revs)
 {
 	free_commit_list(revs->commits);
 	free_commit_list(revs->ancestry_path_bottoms);
+	release_display_notes(&revs->notes_opt);
 	object_array_clear(&revs->pending);
 	object_array_clear(&revs->boundary_commits);
 	release_revisions_cmdline(&revs->cmdline);
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index cf23c06c09..536bd11ff4 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -5,6 +5,7 @@
=20
 test_description=3D'Test commit notes'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 write_script fake_editor <<\EOF
--=20
2.45.1.410.g58bac47f8e.dirty


--AO1lidYNUmQiEJpD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdkRAACgkQVbJhu7ck
PpTs6g//UUdzo8IaORHVCFTqIClJAU/G1WbZl1udyXkD2CGl31KR45fVr8vD1Z9Z
Y0jU4s8+/4j6TJVi1LO1/6EMAtOp+2Wv0/Qw7rBHQFQzhKNdfc+xseSVI+mGFyj6
V1uxzH6ZtvSf3UJiZ2OpXQwJAxdDxT3hZ/6nTFhv0GvVQACm+BBOf5y9jfc6nahN
27KBLuvUwkRPu4v1IaK/EIljiqYvbV3zcpH0pi2l3MxIwovYY9i12DyZhT4NSIB6
6bhH4IVjLdbNK+n+E/z5Cv53e+cX2JMQ1xLDePgL5k7YNx/ZAr1NG01zuGD81MSx
LBEgQdPI0XxS+QZQuC7PcAlzxWWFBoB7tE8XHz4/WCSvcp02rDiVRjkz/R3/SFAi
1oE5AnalpqvHuYkGLj6EvFeWbUzHfnRYLf19vR+r+kv0q/U54khiJhJ7cS8Ajflt
dOajmZkxH6IjcaGJIQ1h4so5OOs7e3gAx1sF4Gm3PrWycNyXaK98Jo3YmmqHNHoG
gafKxBY3lkhN46enOvZgM+LsW5VlJNxSIGyidxYWeRx2s4+ik2bkSyiAPyRFtZOi
/o/A0881a4PMd+2lj0eRjHKP+5oOIkOm7GfPQMkQzQ/OC3Z6nnOfbf3EaZc/+0h5
42M1jThb1jJ9cJKGSROLW8Im2Ud7sm/IMSzh4dNxXmpE2bjh+lk=
=wipi
-----END PGP SIGNATURE-----

--AO1lidYNUmQiEJpD--
