Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964741891D6
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 08:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723104733; cv=none; b=VPt9wYGc0uuBTBaoIP7dl9pHIf53XCF+kqVZ7OUTqQu18XC91ZQFdGBk3L7n9aRN+mi9+G6K33v6ORVz+jtwlGSepWEeDuf5RGDj4tM3t3lwdQePjMsPP1cfIX0TyFgQNX0vlaZqTTiCvoPi9yI06OdL6PnrPG2WkJ8bTdYRJHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723104733; c=relaxed/simple;
	bh=1m9L+Kz1R1oIXGGV/G6oCOTUfbjWe6JnIrk3TDxB0bE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+y16BtK7COqnqwKIk3NOO9dz7rzEzMNyF2sySHVDcSW0gOOtJrX34nnO3tWCcZALfdT7RQIz9VfYDDpqKMQCxfejUG3hIYzt+BnF+kGp8o/s+xAkhlU4udN+AZk+RnRgjzGmrvffsOz7O1Ipw3Gs0ckIP98I3ZZTiNNiDvdB1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IaLYfChr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jjnVpT7X; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IaLYfChr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jjnVpT7X"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A6E381151B72;
	Thu,  8 Aug 2024 04:12:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 08 Aug 2024 04:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723104730; x=1723191130; bh=NJ/BfhSAQH
	CD859yzyygqRSy5OBj7NLkrvub639RmVk=; b=IaLYfChrg8ZC0zrW5ivnk1yzvL
	ueRw1hAEc9Sqxz+EV0pZXcvgpcjXwzpbBE/gzSgx20RkLRgTgzDi8HEHr57VX95Q
	xKmLM6BDLetXzHkUqaLC3dQAyYUDUmPkwVaOkV3Ir2Ol5YNP4OVX9vd4OaTNnj35
	qKVPhVfuShQYRDmtO0h4oX1sZfdaP+8S0YVuKrZoAY7CcpqZF7GtNE8eyrwhRzZq
	v6Jl/6ah41LI7ZyQscA4EEpfHZZJ+WDZD2wNNDQzRA7RMLgi+XBMBrMOKNLKx5Qa
	3J4L1ahjvrivRIG/y2NCe6gBuzhFCL7WeP3oFrtB9d6lfBhx3ZkMt4n6K0sQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723104730; x=1723191130; bh=NJ/BfhSAQHCD859yzyygqRSy5OBj
	7NLkrvub639RmVk=; b=jjnVpT7XcWSyg5Gr0HGYqf0fni2N6ZokJeihalwpJ0yX
	DekSqe7L2EPZ6rWk/aWj9+EJJb2X3yXyTLimYqMchv6eUnInRCimMSn5QHpnvA5M
	g32W0lgfELmhv5jaseGmS0DxQ8SsUqWZBNWiWSrGhGYvlkbRN8vXdeLz8j5cDDuS
	55Szs8Wnd00OIsx+IiNJ3j95kBsCE7J7DTzhIiTCmipTxnfrHaomSA+Z+mXBUTdz
	cWJ3Qkjbizl+lpqF1xVTTuXSn8KWqFoSG5evBE5sDRdLEnVo7xM0fK3uJOwMdnio
	oCmMfmplUrBwzaMznv5xh6pZlLc0YogvpLRq4mwmug==
X-ME-Sender: <xms:2n20ZmiAnlignIMyVoIvpNdsQrkA2lioQKN6osllPIZ8N4RDJo0N1w>
    <xme:2n20ZnA4sPo6ygAUymw0FjObbpzmYORWktdcQ6DerzT704rhffnzruzw9SqDLbDqp
    qv4si6ZW58RokXJcQ>
X-ME-Received: <xmr:2n20ZuH_XC7Xk1ZcMJwEqb3m2GR7eYgc8BS_Oy831k1uUDzK7otZLEHWfBYUVbftvmL3hu4ctdMsqw_s7uXww1aItNnf3VSAcD4JFppKODQs70rl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledvucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfurfetoffk
    rfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculd
    dquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhho
    mheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecugg
    ftrfgrthhtvghrnhepveeiueetleejfeehffejgfekleeijeeilefhheffjeetfeelheej
    gfekleejkedunecuffhomhgrihhnpehuphgurghtvgdrnhgvfidpuhhpuggrthgvrdhnrg
    hmvgdpuhhpuggrthgvrdgvmhgrihhlnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegthhgrnhgurhgrphhrrghtrghpfeehudelsehgmhgrihhlrd
    gtohhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrgh
X-ME-Proxy: <xmx:2n20ZvSEzJHDgGNtDP3qFp7zjuiPLXUonSVgsL5WL-tnHG1KDGiefg>
    <xmx:2n20ZjyYuzi2JJEq1-ild4OhG9xBq8V0xqpFIKutIpBg9LiPECeiSw>
    <xmx:2n20Zt5V3JL1BkO8qX7X676HYaY-RGz5alTSorm8VGrj9MVYwHXreQ>
    <xmx:2n20ZgyVO5zoJz07p6AAnioCTBDvO8-DqzqyeURhjZ8x-DrkGA4cAw>
    <xmx:2n20Zj9Zevj4w9g2vt-d9sqT_RKpEpuul3e-_kycIRKx8XHJwDvsOEms>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 04:12:09 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a7a5fe2b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 08:12:00 +0000 (UTC)
Date: Thu, 8 Aug 2024 10:12:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 5/5] t-reftable-readwrite: add tests for print functions
Message-ID: <ZrR91dR3G06L9dy7@tanuki>
References: <20240807141608.4524-1-chandrapratap3519@gmail.com>
 <20240807141608.4524-6-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qiBwRr61opMzsGtu"
Content-Disposition: inline
In-Reply-To: <20240807141608.4524-6-chandrapratap3519@gmail.com>


--qiBwRr61opMzsGtu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 07, 2024 at 07:42:01PM +0530, Chandra Pratap wrote:
> +static void t_table_print(void)
> +{
> +	char name[100];
> +	struct reftable_write_options opts = {
> +		.block_size = 512,
> +		.hash_id = GIT_SHA1_FORMAT_ID,
> +	};
> +	struct reftable_ref_record ref = { 0 };
> +	struct reftable_log_record log = { 0 };
> +	struct reftable_writer *w = NULL;
> +	struct tempfile *tmp = NULL;
> +	size_t i, N = 3;
> +	int n, fd;
> +
> +	xsnprintf(name, sizeof(name), "t-reftable-readwrite-%d-XXXXXX", __LINE__);

Is it really required to include the line number in this file? This
feels unnecessarily defensive to me as `mks_tempfile_t()` should already
make sure that we get a unique filename. So if we drop that, we could
skip this call to `xsnprintf()`.

> +	tmp = mks_tempfile_t(name);
> +	fd = get_tempfile_fd(tmp);
> +	w = reftable_new_writer(&fd_write, &fd_flush, &fd, &opts);
> +	reftable_writer_set_limits(w, 0, update_index);
> +
> +	for (i = 0; i < N; i++) {
> +		xsnprintf(name, sizeof(name), "refs/heads/branch%02"PRIuMAX, (uintmax_t)i);
> +		ref.refname = name;
> +		ref.update_index = i;
> +		ref.value_type = REFTABLE_REF_VAL1;
> +		set_test_hash(ref.value.val1, i);
> +
> +		n = reftable_writer_add_ref(w, &ref);
> +		check_int(n, ==, 0);
> +	}
> +
> +	for (i = 0; i < N; i++) {
> +		xsnprintf(name, sizeof(name), "refs/heads/branch%02"PRIuMAX, (uintmax_t)i);
> +		log.refname = name;
> +		log.update_index = i;
> +		log.value_type = REFTABLE_LOG_UPDATE;
> +		set_test_hash(log.value.update.new_hash, i);
> +		log.value.update.name = (char *) "John Doe";
> +		log.value.update.email = (char *) "johndoe@anon.org";
> +		log.value.update.time = 0x6673e5b9;
> +		log.value.update.message = (char *) "message";
> +
> +		n = reftable_writer_add_log(w, &log);
> +		check_int(n, ==, 0);
> +	}
> +
> +	n = reftable_writer_close(w);
> +	check_int(n, ==, 0);
> +
> +	test_msg("testing printing functionality:");

Is it intentionally that this line still exists? If so, I think it
really only causes unnecessary noise and should rather be dropped.

> +	n = reftable_reader_print_file(tmp->filename.buf);
> +	check_int(n, ==, 0);

Wait, doesn't this print to stdout? I don't think it is a good idea to
exercise the function as-is. For one, it would pollute stdout with data
that we shouldn't care about. Second, it doesn't verify that the result
is actually what we expect.

I can see two options:

  1. Refactor these interfaces such that they take a file descriptor as
     input that they are writing to. This would allow us to exercise
     that the output is correct.

  2. Rip out this function. I don't think this functionality should be
     part of the library in the first place, and it really only exists
     because of "reftable/dump.c".

I think the latter is the better option. The functionality exists to
drive `cmd__dump_reftable()` in our reftable test helper. We should
likely make the whole implementation of this an internal implementation
detail and not expose it.

Patrick

--qiBwRr61opMzsGtu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0fdQACgkQVbJhu7ck
PpTrsg//bjhwySupt8Z1dKkzAgKT/WmaUbb4QtyOcFPVaSzSD8w7kwnP5/PJ5Fs5
LQi5KCOe4jGuFZgPFClgQsB42E16CykzEpMNfqNBcm8V7SDgLjMDgch5b7A63r63
am7KQdhh7LEVdQikXYVjESGKS2pd+25aZ6aeWpgF0jF+OouOFIk2zVH7Arf93HJ2
MOdjXWo+JNPqXQiJUlLdPb5PRlJxmhNrpCYfzMExg9eqB0LSxHAnvufcAstDFw7t
8YozOxvUut26Ak0aErn2KJPXql7JKbrZEFqdWXOijzWYjc47JUXNNeI7p3vPmvXZ
xi+LLMiA9kE3dL8yoqi0kVoAkFZ5L61ViIBTURqR0u5nmAo40tQ8OOfzAMNF9AqT
VQEAGMnwZlR/ZG3o4mycue3G/IVrKlKFYuLWejBxkOwGKHNPQawKrc0ZWIIHakR6
qbyvlnRTRUVOJWEVR0kwCG2s8S4YQq8NNjSMtSiYj/e3d9zLT5kIzoPDcGVHxFHb
w8kr3++x0fBxShEfQdC7abgJ+5OkJDfZ14iXMkBIutlCPp88TgRZPHL7Y47JzuJs
KFVuHh8BAfkE3SV+jnbk+HM6KXCtI22gDh2ZxwC79WB+AZRN8NUAXVWxZzI4RL8J
X2uZW1HFU8EA5OsChZI3PEqRl6vsuPq+hQLjIYN0SUrdkmskw40=
=L2WI
-----END PGP SIGNATURE-----

--qiBwRr61opMzsGtu--
