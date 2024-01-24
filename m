Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B6E6D1CE
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 12:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706099499; cv=none; b=rbRFhYXJVm3rN5P7lEdNa2+WoauVfZ2U7BnLbMwBfYS9vMX9C0r2oX8hZf4P7CUyt9sHQTU2lyu7OdGlBrqt8bjJ5Gv4j+w+ZhFosuerOptQS7yWYpQLoJNMzA4wfmFqxOTVbw5lFkXZdbtv0wc4/cwYXvSR82ThEFQWBP0WRUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706099499; c=relaxed/simple;
	bh=K2K/u85rxRTMzkOiEZNuxYgcGCwed9XEux/KngMm1J4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MSzAZqRBCDLp6R1scWVwEk5wczeWnGL0EuTFjxoLSRuy+FRgLJAogcD95FSXaqsgDFOFzSiZcbnA6hM2BSeaxWOrSd8NSPHifbWXlslq5Q0hn4yGeI0CIqa5Xi+8s5B8Fn0kz2NoQBESEdtdqCS+IPWjcRKz84B1thLOlEFszJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kCn/eQ3E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HG6oyYaM; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kCn/eQ3E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HG6oyYaM"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id C1A7D3200ACC
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 07:31:35 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 24 Jan 2024 07:31:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1706099495; x=1706185895; bh=Sxcs2lfiavPP2jCEIpGFLK1MUSivU5EV
	mE3VL44TAf8=; b=kCn/eQ3EZ+m4ffNBcWilOP0/96/uca5AuwkbpyzMm37A+aeb
	KtxswHozV0rrBa1TiB75rP3j/6BMJ6Y09ksm2sH/hn1d2fEt8MQ4rynm84k8rMPN
	8Vme8a8u8ecq3B5EJNOPmr7q9QTWw3YGe6zUP0v2GggruKTnWdcGbjhgt/a6uhV+
	nKQyFVpatkdEVusljCdwuyoUKe3T5IMyWuJf6P+PCsEvcZdMGSrzwe+5Q2gHVHbf
	wImo0Ev13IoncmVqnCRmToRaJsWgRZjxLspG1XfgajGpn1ZMQx0OxikvabgY9aMU
	NxHslH9JKtI8LSJYQkUr7DVPNdH5r5MIYPxp/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1706099495; x=1706185895; bh=Sxcs2lfiavPP2jCEIpGFLK1MUSivU5EVmE3
	VL44TAf8=; b=HG6oyYaMWRPUroR1P9O38spu/Wx02FxsyWt4GrEdOlB8jbnbknm
	T1hVd4uWQ87GY9K6iXCov1Hj7bOaCsTC+KyS0L9Hn0tE8eb/scvDJL1+7DxkytsB
	KA2EjKL4BxOGabkm/cTywJFDAROenjlKlQOovVG2Vm2Tr+n2eBGyBUvZE1xuW6ag
	hIL2WTlcC6nlyppiOTbZjeV4GFNzf/AIyDblHLI4fJtMCWUDWOBsQqOKnP5suwli
	5gwNDqaryV8khUK32YQIG8pSX2sMxYbxFwCN1bTqeRz+40Y0eBINdPDePrMvwYlO
	lZ/xWa/dbjU5ljvTKRtcsTLZdW8wz6SP4Pg==
X-ME-Sender: <xms:JgOxZZ9HQ3HXcXSJhr5H4Fs8FedkalpAg9RytIgMO-tqcB5ER29fRw>
    <xme:JgOxZdt0iNx2GBXokCsVlQYghZr1bPwOx__g_YYd58lPZszrRxgQjcKl3cz2Y96eR
    JuX4793KZIrGnPqcg>
X-ME-Received: <xmr:JgOxZXDbWhqXQFYmzsRCHFTNHRdXHGdbHkkB87DLxNwUzBtJBRrsfeItRIzXRQ00kJzBycIlBDcX2bwG3kk-quYhBwM3LGEoqP5bv1EWFUOegw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeluddgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjeeifedvueelfffgjeduffdvgefhiefgjefgvd
    dvfeduvefffeevfffhgfekieffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:JgOxZdd6-YlL-gT4ZpOFTNrsDqtGpTY1JogUIDFRoKAx9btuptW06Q>
    <xmx:JgOxZeM7DtAN6AAisnM98MmlA4-5JPFUxSbg5K3kjTLP25AnXcJSew>
    <xmx:JgOxZfkNCPDujzEj60kpO8-WXdqYfZ4eVNKYBZj9slhuld-PFSj7rQ>
    <xmx:JwOxZRZIloZKBUvtZDNWTiVQmvWBIEqJYfWiFXV_bdIOE9HhpxyWcg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 24 Jan 2024 07:31:34 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2feeb7c2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 24 Jan 2024 12:28:25 +0000 (UTC)
Date: Wed, 24 Jan 2024 13:31:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 0/2] reftable: adjust permissions of compacted tables
Message-ID: <cover.1706099090.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qwRu3UCPV26BLmU6"
Content-Disposition: inline


--qwRu3UCPV26BLmU6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this small patch series fixes a bug in the reftable stack implementation
where the "default_permissions" write option is not honored for newly
written compacted tables. The effect is that the "core.sharedRepository"
config is ignored when performing compaction.

The series runs into two minor conflicts with jc/reftable-core-fsync
that can be fixed like follows. As this series has been merged to next
already I'd also be happy to rebase these patches on top of it. Please
let me know your preference.

Patrick

diff --cc reftable/stack.c
index 27cc586460,ab295341cc..0000000000
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@@ -633,13 -643,13 +643,13 @@@ int reftable_addition_add(struct reftab
                err =3D REFTABLE_IO_ERROR;
                goto done;
        }
 -      if (add->stack->config.default_permissions) {
 -              if (chmod(temp_tab_file_name.buf, add->stack->config.defaul=
t_permissions)) {
 -                      err =3D REFTABLE_IO_ERROR;
 -                      goto done;
 -              }
 +      if (add->stack->config.default_permissions &&
 +          fchmod(tab_fd, add->stack->config.default_permissions) < 0) {
 +              err =3D REFTABLE_IO_ERROR;
 +              goto done;
        }
 +
-       wr =3D reftable_new_writer(reftable_fd_write, &tab_fd,
+       wr =3D reftable_new_writer(reftable_fd_write, reftable_fd_flush, &t=
ab_fd,
                                 &add->stack->config);
        err =3D write_table(wr, arg);
        if (err < 0)
@@@ -731,13 -741,7 +741,13 @@@ static int stack_compact_locked(struct
        strbuf_addstr(temp_tab, ".temp.XXXXXX");

        tab_fd =3D mkstemp(temp_tab->buf);
 +      if (st->config.default_permissions &&
 +          fchmod(tab_fd, st->config.default_permissions) < 0) {
 +              err =3D REFTABLE_IO_ERROR;
 +              goto done;
 +      }
 +
-       wr =3D reftable_new_writer(reftable_fd_write, &tab_fd, &st->config);
+       wr =3D reftable_new_writer(reftable_fd_write, reftable_fd_flush, &t=
ab_fd, &st->config);

        err =3D stack_write_compact(st, wr, first, last, config);
        if (err < 0)

Patrick Steinhardt (2):
  reftable/stack: use fchmod(3P) to set permissions
  reftable/stack: adjust permissions of compacted tables

 reftable/stack.c      | 35 ++++++++++++++++++++---------------
 reftable/stack_test.c | 25 +++++++++++++++++++++++--
 2 files changed, 43 insertions(+), 17 deletions(-)

--=20
2.43.GIT


--qwRu3UCPV26BLmU6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWxAyEACgkQVbJhu7ck
PpSORQ//S4g2O2lNJzwsqers264YWvJ8OOt6x7m3nNaN1UhOc8EmHSZgajn6Jmvm
adixyWb5UmT4QsY/n+Y2KG2c/ZAw6OIfX7K0NVLpu1kUqEe48tM8YmwC5/Z+FZSK
N1IplZOk5cQjDsfwlpkElxj8omPERtn/PY0aO49Hqc4gpkF6DZqTN3s7AY7FmGj1
eAQcobiSmA1wyaQuf8gu4CM6P84I3YYRtVRnRi6QtVH1ujlgZjN8va6+JvQ1iA4Z
Bwl4U/kLF5q4f7TH50X8OjPfvetCasoD6Pw7v5N5c3vQN0s/cT2hSYHd6BBPwXrB
38E6u/biPg4ItCOb3VuHbdJMcRpjp60gDxKOT+OQ/9a8gcx278ePgcQcnJbFuogj
EY4/talr9sfNgrm3l21lsL7qSTJBi2m58bQ65yx0oYQ75NqT51ySaRaiARs/1h+5
SQrnJQzpA+MDgK9zCKFghT/8dQBCgDan5mkGWWScGK+4QM5ALXLYOvColryv9CgU
RLyWrkY200dMben26REnVGf39t0VzxzAnMXtJwfrmAQicZs/YTtQIV73Ajnmyi8i
7nNY4jwOx4O/UHKDXRFqkE6MMt9mAxMYUNSHLnSVMCSR85KIowxSMNlnb7ygrgwo
HVcVv9A9dee37274fCdX6dKbZxSOK9kkeTs+4v9UltRvTkXs3IE=
=lLu8
-----END PGP SIGNATURE-----

--qwRu3UCPV26BLmU6--
