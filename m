Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1B72E9EAD
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 06:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758780876; cv=none; b=aPO++N2xEZWPo7oo2YmxXuRSbh5z9wc4s41FvpuOvNx+3JP0kWGdsewg2AmzN7cfG4+eGwzsC1Vjgh7hO2y0IAW8RZqAzqb3f7a++XPnAlbK3+49x723J1zOH+x2iPjXgwH+e1t718i7JGIwslVEQx22zvZwALq4vA6XvXrbe0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758780876; c=relaxed/simple;
	bh=Mz42+dKlaw/Hk0bIX96k0TEw4MVlyPQGefBoaMi1bok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/md3+MDzc5J65fHQTY2UhVAadAMHRsGtpk3yCYd8DOtobAkwmy7j9HeYWZYiaEF+zT1uZVHZtv/Cfz9J7WvMuDR5kMJns43nfACsBuSxKsLYnW3r7k4w6OHTnQn4J6lxypck3p9uSNA4VY9HEWO/jDgLYARv50Ri6FL5KJA5Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Qzkyen/a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ALnebwtn; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Qzkyen/a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ALnebwtn"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id EFDF91D000CF;
	Thu, 25 Sep 2025 02:14:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 25 Sep 2025 02:14:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758780873; x=1758867273; bh=dGF5XkLBYl
	biF97rMLtGtLkps+d9UBJm+QEmL1ra62A=; b=Qzkyen/aFiD7QWh1V3MCwnYmDT
	+Hlw1yuaa2zTyFPCusFk+Ql2g9W0OMsHWyVODIqUwXvEaQaDUFEMlBGlmOdd0BfF
	pWpNPfN0SchMhB9b4lzoBT6b5X9HCHPwoLlOWC2AAfbpzGQH4lBDIyC7gUivMLxO
	1Wm3UCH01BYuuaaI7+gSYtijBuvNd+rwN5eS0au2DFtk26q4JtnNzeMsjoCk3JPo
	xl36EIeszy7cArVLQcMzCuJ7IcShC3QcmW7FIBRp2LlA0SKj+I7KO4NFNqe2kQ4p
	fsY7XilTe5pw1y7PFa7rkqpvEb5T/EVB6Uyrh0hLnm3FBf+RlWLjrRFNKizg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758780873; x=1758867273; bh=dGF5XkLBYlbiF97rMLtGtLkps+d9UBJm+QE
	mL1ra62A=; b=ALnebwtnrZWjZ9FzOMe1leG6o/s3JfW2jrbFP82adPn1argFMES
	RBR9kn+bMQIVx/aeBYClhwCmeDjCckr0wzh6xNtT5Wa2l7X83CIeurF4+rPuLtQZ
	+L86IpQMrEfgXrn6pyRPfiwKlN3lZmQfoB/j3zlc4z8YeQKhBD0QY6IiXCX/RJVi
	6H6P7kpr1+/mPPVfSNN+gvFlnql9gH79OtvTjYr95KggoZd/unALDTH0czgFjplR
	jSTDPYT9grRqF+wGNCFMeXkgbuLkCcAsdMwwNKF5zlqPTl7vaVbOoEHIe46jDyQM
	DHI4HDWSabiSPUs/UdVp6cCipefSo2dc9uQ==
X-ME-Sender: <xms:yd3UaFp-zk8Q1XZiOuzQvUQcjX13o7WdVfsNZraMmDeuUaDSYedn4g>
    <xme:yd3UaOpol2rslCg7IgnM20hGwcYgZetimqu3bGSimJVnm5L1tyYxZzcNN5y2qTYxr
    ycf3azab5u_oK-QIL4kcM5pWpQlWz5b3144eKwU0GbJ4BPaOzlx>
X-ME-Received: <xmr:yd3UaHP1W3yq_QDqDu5dYTkBVfySnbnKsHLpGcIQsrfwJ120j94gwOK4foXCCX774IeWvFWmJrZhFx7bMFIrBXGFwHb3WpBG1s4zZ1hAN-Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiheejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ejtddtgeffkedujeejgeduhefghedtgfdtieduleeulefgueetheeludegueeuveenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:yd3UaPzh0GrGpoSnHfOWpXVMuiKTucOkFaCAvmmG-c0dQZJ6ES6dmg>
    <xmx:yd3UaAvWia8d336N531gqQ1EgPA8DJjLYgNHHDhwCzUgvfJwOsyTRA>
    <xmx:yd3UaI5SuL7purHcXdm44jV9CG9nTZTvN5GfUizyb56cCmC0k70HaQ>
    <xmx:yd3UaPTNeZWwJ7XtcDXFmJAfWcgl-juMtAy3iWbvY3y3bLUGBkmcRA>
    <xmx:yd3UaGtJKgLoSHKp1L6AuZlSbGx0QE3QDpk2wQnZIxRvrGmnOyxfsy3F>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 02:14:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ebb856f9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 25 Sep 2025 06:14:31 +0000 (UTC)
Date: Thu, 25 Sep 2025 08:14:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, shejialuo@gmail.com
Subject: Re: [PATCH v3 7/8] reftable: add code to facilitate consistency
 checks
Message-ID: <aNTdwzUMlubjcppb@pks.im>
References: <20250918-228-reftable-introduce-consistency-checks-v3-0-271af03eb34d@gmail.com>
 <20250918-228-reftable-introduce-consistency-checks-v3-7-271af03eb34d@gmail.com>
 <aNOHqEq5qxXrOCX7@pks.im>
 <CAOLa=ZQ641MncC9ACm9jfjx0WtQ+nK2shtyucQOxd08LDXDzAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQ641MncC9ACm9jfjx0WtQ+nK2shtyucQOxd08LDXDzAw@mail.gmail.com>

On Wed, Sep 24, 2025 at 11:40:31AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > On Thu, Sep 18, 2025 at 10:11:48AM +0200, Karthik Nayak wrote:
> >> diff --git a/reftable/fsck.c b/reftable/fsck.c
> >> new file mode 100644
> >> index 0000000000..785e4b43e8
> >> --- /dev/null
> >> +++ b/reftable/fsck.c
[snip]
> >> +	struct reftable_fsck_info info;
> >> +	struct dirent *d = NULL;
> >> +	uint64_t min, max;
> >> +	int err = 0;
> >> +
> >> +	if (!dir)
> >> +		return 0;
> >> +
> >> +	while ((d = readdir(dir))) {
> >> +		if (!strcmp(d->d_name, "tables.list"))
> >> +			continue;
> >> +
> >> +		if ((d->d_name[0] == '.' &&
> >> +		     (d->d_name[1] == '\0' ||
> >> +		      (d->d_name[1] == '.' && d->d_name[2] == '\0'))))
> >> +			continue;
> >> +
> >> +		if (d->d_type == DT_REG) {
> >> +			if (!valid_table_name(d->d_name, &min, &max)) {
> >> +				info.error = REFTABLE_FSCK_ERROR_TABLE_NAME;
> >> +				info.msg = "file with invalid table name";
> >> +				info.path = d->d_name;
> >> +
> >> +				err |= report_fn(&info, cb_data);
> >> +			}
> >
> > One problem with this is that this is racy with concurrent writers. We
> > don't recognize the "tables.list.lock" file, and neither do we recognize
> > "0x*-0x*.{ref,log}.temp.XXXXXX"-style files.
> >
> > Would it be a better approach be to instead go through table names as
> > loaded by the stack? The reftable code already knows to prune unknown
> > files anyway, so I don't think we should scan for any other files.
> >
> 
> I actually had a more structured code here, where the idea was:
> 
> - For each stack
>   - Run stack level checks
>   - For each table in stack
>     - Run table level checks
>     - For each block in table
>       - Run block level checks
>       - For each ref / log
>         - Run ref / log level checks
> 
> But we move some of my tests to be runtime checks, leaving this as the
> only check remaining. We could still do the first level of what I
> mentioned above. The only reason I didn't was because we wanted to check
> all files in the stack dir. But I think this is much better, having
> unknown files in the reftable directory doesn't affect the repository in
> any way. So I would argue perhaps that we shouldn't even care about it.

Yeah, agreed. As long as we don't know about any edge cases where this
does or did create problems I agree.

Patrick
