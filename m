Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027DA179958
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 07:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731483384; cv=none; b=OQyh/8Lr88Hw2cdDsr2E9JduUrNW3/8NyXA6Aeg0N6vlnSdzrhW4JSEXhz5Qa97Br47999+39MK9WVy9Z1mreXzHrYo0BGQ/fvDCbnHPIRisnBj/mh2BB69Zb7CBU286wGotQRmtPAEsCXMyeiMqikQUkvxISznwtsTzKrxsSoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731483384; c=relaxed/simple;
	bh=Zp/dbPz2Z/F8oYiDR0VCwypcV3UaxpOzjvsXtwVih84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9yUf9Fx7De9U5mdgIH3G7Ugoz+B0XfzAzvRRM2m4XHvdugyuQtOTBFmkK+IhC6mR7VotuCsm2e2RLHkNlAYQobtZ2qAS9r+kbpNladBQw5hmGkRT2l8x3gBqNl5n/kblR64T+y81svWqrCXCINTk+MYghm8guz4bhdKwihlU6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GJ0qd759; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MRhwFgSJ; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GJ0qd759";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MRhwFgSJ"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 1D1491380271;
	Wed, 13 Nov 2024 02:36:22 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 13 Nov 2024 02:36:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731483382; x=1731569782; bh=drq41jJjhi
	MPRuOvhjSnyLDcQ2bbgSAa3dwig35CHas=; b=GJ0qd759IoaH5J6CyZHEFKKbbN
	LYSOSCAzADAJMUVSlpfS2N9mv0iVTSb4PEfAFtdV7Kxj5t6LnGr5zFdw55iNFllR
	kQtebetNLavX1Ay2irmEzQpcSOr6gKy8BifpDB/Y+w/RTZ9FSBRlT0gRMv8k1CXq
	Rufm21ssZqlmSnl06b1DzK8eGrhgMZyKY0yio5GNzhQ81hF0fr8q6mNVFhhEOPXP
	J/oxB5KkoWE2Km73K7FbGa3cB35kqck+uO9AZv5+CJ72def6nfiDEvlBbCgjCr4G
	EWTl/7+oywY2FiHXODiIIiLFqlnvfxECq+2C58wx2IkDPlLalK2aZ7GjnM7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731483382; x=1731569782; bh=drq41jJjhiMPRuOvhjSnyLDcQ2bbgSAa3dw
	ig35CHas=; b=MRhwFgSJR9LS4Plo7PfDy8Vy/9WF0u/jnXqVjjmnztdG3DxTC8t
	E6PL7m/QCd45yt2/Kblv4uRII/kk7VxBw5Bq4HgzAOuO2xQX1lb8oZlBcdzLQc8u
	zUz0dXV299OM0OlHcDauZVFZJS/yIPICIecpmDmsmfFHQAoVjvv3TYs5WQ9itdfc
	VtlNhsaDHo/+vTb+KGg5bnwZKgXRYMjMwaBfrOEEwJKuiXsoWSe28OsYHImSWy+N
	vSlwRDhfiUkQvVET6yY517C5nADe4NBQ6eIGsEqGcYfOFaD4SmvviY1X8d7u7pYs
	iaollcFMJCREuZLbNOKE0N7lSRYSmhV5IRg==
X-ME-Sender: <xms:9VY0Zxm7b0DL_RY6GtgNg3C0ylWgbtaGE2lZH_b5nrrnTxE3gqKphQ>
    <xme:9VY0Z807rUKw7OhOBy04wTxt_Y_osvUaHTp_mxeP1l5S-PE2eyONV7cuZTZlk1g2T
    WhDD-g4kQ1SxgIIuA>
X-ME-Received: <xmr:9VY0Z3r82OXkczpzAk1xFiDQ8sErcG-_fDGnzaCFthprYoiFartOAa9GNhRFDM7GpHkDiafJ_Bcu1Lak6M6VcCu-Qs-0NrP3oHUWnUV9NvysUyU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudelgddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhh
    ihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhvghjihgrlhhuohesgh
    hmrghilhdrtghomh
X-ME-Proxy: <xmx:9VY0ZxmIlKEESyRSJtof7gK98Dypqe4QrXOFWxDgn0N0f1iO8iucbw>
    <xmx:9VY0Z_0s1J95Divvqk6T7Jm2KqLxVJFxhJo8Zc6qglJeBj3Mxn_GXw>
    <xmx:9VY0ZwsS5Q37nmDg3WnjOLcj9-Tq0vWdWw8EAAO-cw2HbgjGuQPbjQ>
    <xmx:9VY0ZzUigFc4UqVQTit9FAkeH4Z7F0nSCLBmESC10lpH3X0hrn9wAg>
    <xmx:9lY0Z6TiXQ76VShV2si37rQZwyoxoz4a1cCs2c6oZtL0IwG-zsvqmvOO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 02:36:20 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c54eb3b4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 13 Nov 2024 07:35:43 +0000 (UTC)
Date: Wed, 13 Nov 2024 08:36:12 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 5/9] ref: port git-fsck(1) regular refs check for
 files backend
Message-ID: <ZzRW7E2Z0ZYQ7i20@pks.im>
References: <ZzCiCGxL4Adnd_eq@ArchLinux>
 <ZzCij4ilPLhlKXS6@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzCij4ilPLhlKXS6@ArchLinux>

On Sun, Nov 10, 2024 at 08:09:51PM +0800, shejialuo wrote:
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 8bfdce64bc..2d126ecbbe 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -3505,6 +3505,48 @@ typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
>  				  const char *refname,
>  				  struct dir_iterator *iter);
>  
> +static int files_fsck_refs_content(struct ref_store *ref_store,
> +				   struct fsck_options *o,
> +				   const char *target_name,
> +				   struct dir_iterator *iter)
> +{
> +	struct strbuf ref_content = STRBUF_INIT;
> +	struct strbuf referent = STRBUF_INIT;
> +	struct fsck_ref_report report = { 0 };
> +	unsigned int type = 0;
> +	int failure_errno = 0;
> +	struct object_id oid;
> +	int ret = 0;
> +
> +	report.path = target_name;
> +
> +	if (S_ISLNK(iter->st.st_mode))
> +		goto cleanup;
> +
> +	if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0) {
> +		ret = fsck_report_ref(o, &report,
> +				      FSCK_MSG_BAD_REF_CONTENT,
> +				      "cannot read ref file '%s': %s",
> +				      iter->path.buf, strerror(errno));
> +		goto cleanup;
> +	}

I didn't catch this in previous rounds, but it's a little dubious
whether we should report this as an actual fsck error. I can expect
multiple situations:

  - The file has weird permissions and thus cannot be read, failing with
    EPERM, which doesn't match well with BAD_REF_CONTENT.

  - The file does not exist anymore because we were racing with a
    concurrent writer, failing with ENOENT. This is benign and expected
    to happen in busy repos, so generating an error here feels wrong.

  - The file cannot be read at all due to an I/O error. This may be
    reported with BAD_REF_CONTENT, but conflating this with the case
    where we have actually bad content may not be the best idea.

So maybe we should ignore ENOENT, report bad permissions and otherwise
return an actual error to the caller?

Patrick
