Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FA712BF36
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 13:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709817036; cv=none; b=ud1K+hTweQpVWwHYr05ZkRg0bYnLnhUylwZLVmUI+jI4l/ji84tHjCJpZBoBeY/mAfnJtb1puw8T7n/nbgGUV5q8oBXkBxSR8/whFceQ692t/4M9MevfYZMtzHLghG2yH9+e8MZ0gFeCqIDqv3UjYvAMDtMubV2T8JQwutWf/dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709817036; c=relaxed/simple;
	bh=kyU4v8zLoqLYAJ10Fkqi3IWnlJQYRiDPj9+tB2l2dq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+mZp/w4+4+q1bQTOoNPzmiUwMJnINxKcNFFewybjENdxIdzGgksiM+9yy2/QLzVPOn5SiMTVjVHz/ppfli2xuMlxWQcJ8QQkKIWDllwp7qgR/lVdlXWVC9ArXBD2tD1TGIFdWD/N7p/H4Dln8r6Rd3oTrnz1eoPa6ypMcKzpUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=c/E5kaRi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MB9Cy4Uc; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c/E5kaRi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MB9Cy4Uc"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 4E19818000B9;
	Thu,  7 Mar 2024 08:10:32 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 07 Mar 2024 08:10:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709817031; x=1709903431; bh=OL7hurY4LM
	JzE/FWOTgEiASOMtR0IxlLeHNHFdlDkyg=; b=c/E5kaRioVTh8XUsvwypXV4zVn
	myOcwsB7LkQwJi5iWUK80JCkE6O2gJ3qdTUmlmEyh+VD2I12NagcxTaiRlZE/R2W
	yU4U6oil1PSY/Nw3liU8z7ZrL55OFGSOoWAln25CuDeZEJ+ieBhNKgun/V3xdbq8
	FjSPax1pKmyLVbo0IPX6qu3nwLoVbPdH3ahMqg2CqRV0VXdQUekC2lEXVSNh8TIQ
	+pXzfCQB9ejZ8x1uBp0D9rM5bN1IutjqK0s/MgfVL3oSuSO5rFeksIpYqRQ565Y7
	4BCEeft5hiW9x3VOQ9IgmhRzXKrRHdSFjzInRdYDZioMewEpG9FqvCv9JR8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709817031; x=1709903431; bh=OL7hurY4LMJzE/FWOTgEiASOMtR0
	IxlLeHNHFdlDkyg=; b=MB9Cy4Ucvh3fDwFEou8kZD4Nnd+ZD62a4EQo0VCB7+Qa
	Hn0pOJ4nAcT4OWW27eecmkyS3ZJOXEcis36kgXHbmimuC9FWuXoTJkjXmZJo1hCN
	b+jZsKijX6XJNSBOYan5BSWqHnIaP9QiWAcy0nkICxroahh2s3e+Csam5MCHmn0h
	2gaPsdrQ9+IH0Lz9qeJAf54Gm6Lf7G2TLEblLRV1SiA6AQhBC6G07xtXVscRf3dF
	1vGPNRn939uuQh93ReR2nPyGAy0ObOcwtuHAFCyxbEJYyfHH16ahpzw1TVOjmmP/
	u2uFgGJIyBakEzouYwBsZD5qVyPHU6WMniJs9w3ixQ==
X-ME-Sender: <xms:x7zpZfss90LYKGk0N7xan7O5DYvAcIDKXutIb-xAjMiYxMDFx1G9Mg>
    <xme:x7zpZQfFAf-4KAgBhAykVn6ldZG2hGdHeqdoHZxRRpP46h5dUS3Bhrmb_VN2RWrcr
    -N-pssLqSlwHBGB8g>
X-ME-Received: <xmr:x7zpZSyGmdZ3JtUspdq95O7H1mmiHETLbd3PgTZ8G6_7JvsCwO4rKUyZdo3c1S4gZMxb8zTX5KdGO6VBm6KjBWJYvSr66H-bDb2NOR3jh_6XNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieefgdeglecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:x7zpZeMUXWvky9S5J00O7JrIo5REv3Ys7UU3sMF4aRC4xdikKBkUGA>
    <xmx:x7zpZf-a7a6wmsisG5dC0sDOn7JfmN-p-XJGh1QrxgdR-5QIXbYJdg>
    <xmx:x7zpZeW0ZnqocozmIhIQvyCZ5UixxTl937fGkSzvyOiqVHNPJjU0Xw>
    <xmx:x7zpZbbdCKJe58qg1e7rVexaiqk8_3_0aXwnDoP_gD5X-9wTjodAqbiSU9w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Mar 2024 08:10:30 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id df7d48eb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 7 Mar 2024 13:05:57 +0000 (UTC)
Date: Thu, 7 Mar 2024 14:10:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Toon claes <toon@iotcl.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/4] reftable/stack: register temporary files
Message-ID: <cover.1709816483.git.ps@pks.im>
References: <cover.1709549619.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JQJmvdUXEdT3bGAd"
Content-Disposition: inline
In-Reply-To: <cover.1709549619.git.ps@pks.im>


--JQJmvdUXEdT3bGAd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that registers temporary
files written by the reftable library with the tempfile framework. This
ensures that those files get cleaned up even when Git dies or otherwise
gets signalled.

Changes compared to v1:

  - Patch 1: Clarify that rolling back a deactivated lockfile will not
    result in an error.

  - Patch 4: Rename some local variables for improved consistency with
    other code.

Patrick

Patrick Steinhardt (4):
  lockfile: report when rollback fails
  reftable/stack: register new tables as tempfiles
  reftable/stack: register lockfiles during compaction
  reftable/stack: register compacted tables as tempfiles

 lockfile.h        |   6 +-
 reftable/stack.c  | 330 ++++++++++++++++++++++------------------------
 reftable/system.h |   2 +
 tempfile.c        |  21 +--
 tempfile.h        |   2 +-
 5 files changed, 178 insertions(+), 183 deletions(-)

Range-diff against v1:
1:  1acaa9ca1a ! 1:  782e96a678 lockfile: report when rollback fails
    @@ Commit message
    =20
      ## lockfile.h ##
     @@ lockfile.h: static inline int commit_lock_file_to(struct lock_file =
*lk, const char *path)
    +  * Roll back `lk`: close the file descriptor and/or file pointer and
    +  * remove the lockfile. It is a NOOP to call `rollback_lock_file()`
       * for a `lock_file` object that has already been committed or rolled
    -  * back.
    +- * back.
    ++ * back. No error will be returned in this case.
       */
     -static inline void rollback_lock_file(struct lock_file *lk)
     +static inline int rollback_lock_file(struct lock_file *lk)
2:  02bf41d419 =3D 2:  5dbc93d5be reftable/stack: register new tables as te=
mpfiles
3:  45b5c3167f =3D 3:  c88c85443e reftable/stack: register lockfiles during=
 compaction
4:  b952d54a05 ! 4:  4023d78f08 reftable/stack: register compacted tables a=
s tempfiles
    @@ reftable/stack.c: uint64_t reftable_stack_next_update_index(struct r=
eftable_stac
     -				struct strbuf *temp_tab,
     -				struct reftable_log_expiry_config *config)
     +				struct reftable_log_expiry_config *config,
    -+				struct tempfile **temp_table_out)
    ++				struct tempfile **tab_file_out)
      {
      	struct strbuf next_name =3D STRBUF_INIT;
     -	int tab_fd =3D -1;
    -+	struct strbuf table_path =3D STRBUF_INIT;
    ++	struct strbuf tab_file_path =3D STRBUF_INIT;
      	struct reftable_writer *wr =3D NULL;
    -+	struct tempfile *temp_table;
    -+	int temp_table_fd;
    - 	int err =3D 0;
    +-	int err =3D 0;
    ++	struct tempfile *tab_file;
    ++	int tab_fd, err =3D 0;
     =20
      	format_name(&next_name,
      		    reftable_reader_min_update_index(st->readers[first]),
      		    reftable_reader_max_update_index(st->readers[last]));
    -+	stack_filename(&table_path, st, next_name.buf);
    -+	strbuf_addstr(&table_path, ".temp.XXXXXX");
    ++	stack_filename(&tab_file_path, st, next_name.buf);
    ++	strbuf_addstr(&tab_file_path, ".temp.XXXXXX");
     =20
     -	stack_filename(temp_tab, st, next_name.buf);
     -	strbuf_addstr(temp_tab, ".temp.XXXXXX");
    -+	temp_table =3D mks_tempfile(table_path.buf);
    -+	if (!temp_table) {
    ++	tab_file =3D mks_tempfile(tab_file_path.buf);
    ++	if (!tab_file) {
     +		err =3D REFTABLE_IO_ERROR;
     +		goto done;
     +	}
    -+	temp_table_fd =3D get_tempfile_fd(temp_table);
    ++	tab_fd =3D get_tempfile_fd(tab_file);
     =20
     -	tab_fd =3D mkstemp(temp_tab->buf);
      	if (st->config.default_permissions &&
     -	    chmod(temp_tab->buf, st->config.default_permissions) < 0) {
    -+	    chmod(get_tempfile_path(temp_table), st->config.default_permissi=
ons) < 0) {
    ++	    chmod(get_tempfile_path(tab_file), st->config.default_permission=
s) < 0) {
      		err =3D REFTABLE_IO_ERROR;
      		goto done;
      	}
    @@ reftable/stack.c: uint64_t reftable_stack_next_update_index(struct r=
eftable_stac
     -	wr =3D reftable_new_writer(reftable_fd_write, reftable_fd_flush, &ta=
b_fd, &st->config);
     -
     +	wr =3D reftable_new_writer(reftable_fd_write, reftable_fd_flush,
    -+				 &temp_table_fd, &st->config);
    ++				 &tab_fd, &st->config);
      	err =3D stack_write_compact(st, wr, first, last, config);
      	if (err < 0)
      		goto done;
    @@ reftable/stack.c: uint64_t reftable_stack_next_update_index(struct r=
eftable_stac
     =20
     -	err =3D close(tab_fd);
     -	tab_fd =3D 0;
    -+	err =3D close_tempfile_gently(temp_table);
    ++	err =3D close_tempfile_gently(tab_file);
     +	if (err < 0)
     +		goto done;
     +
    -+	*temp_table_out =3D temp_table;
    -+	temp_table =3D NULL;
    ++	*tab_file_out =3D tab_file;
    ++	tab_file =3D NULL;
     =20
      done:
    -+	delete_tempfile(&temp_table);
    ++	delete_tempfile(&tab_file);
      	reftable_writer_free(wr);
     -	if (tab_fd > 0) {
     -		close(tab_fd);
    @@ reftable/stack.c: uint64_t reftable_stack_next_update_index(struct r=
eftable_stac
     -		strbuf_release(temp_tab);
     -	}
      	strbuf_release(&next_name);
    -+	strbuf_release(&table_path);
    ++	strbuf_release(&tab_file_path);
      	return err;
      }
     =20
--=20
2.44.0


--JQJmvdUXEdT3bGAd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXpvMIACgkQVbJhu7ck
PpSbxg//Wov/adhB6X7RxlsvvmSv8unE1renyZGd5O3waabwWvYwTR6SfbV8y5O8
Eg0/LxtprsSjY43hAP+6saJf+SeJTASvVHgtmv214PUnitIAvyz5NCzTNqQyKfMl
s6zJE/+OShXW75HqFw23TkxB1gWmEYke5rkQqM555C9WM05TqmnkAx1AAr5amMTL
ubHnBgB+2NDJ4sZ2/RQVHfDTe7jEQ+B4IzSLGHxxv6UoztMYiRqsOdQQMHMmUmOf
HiWm+t3N+0JP2KcOhorozeay5GmtZXvKxdso+R69at2Jk3dDfDsv55VfYW6krFGC
I+Ixp6+NPgWGPQ6Parxsp3LqhgZQHZ+8KYNKyQDA2NsCwhJaOf7RQu/RJwp5rknp
NIbG8NThDLIW76DcDXFf4V6Ma6TndYpC5n/ctm6s9jWmJhnGWgIy46EgI7IrBRZE
Ql7nPYp2fanBoK/3fpiUYB5FpGC+apFRGjspDWOM2KoxI0TgIgBeTLF8u4orsRD+
hyanoTn1eiwxOdoCQmF4qMfqjxdMkRSVpHlMp4gDg9XYJ3i0cRe/Ie/JVePiP0w3
AlnkLcA0VIq/k+pKA4egkuzFRrs2K9noiysGePu9FIrem3VLiBU4Xv08RXsYXqcF
yE+YJUB/lmrcETHRVyfW5KHU8Deg7yglPwllM3GQQb1BaKsCNZw=
=Wn7/
-----END PGP SIGNATURE-----

--JQJmvdUXEdT3bGAd--
