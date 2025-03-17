Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A756823FC68
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 13:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742219851; cv=none; b=MlEAYsllXCqVQinHm6Ei4VekM/35y1ruPiP1ZHSxEeh+k8TsLbDyR/UE8mHmaGZJnXnRfBQEmojXH+tbqANxjbhUc06rRki2HzvQhBcLbPC9OnRBPCNIcAfKDgC7RkYQC/xsPL8V5Y/v0tve27HMTljSn+BHsCIrZizfSb2HXv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742219851; c=relaxed/simple;
	bh=Qd/5hlw60lrU9400laNOB4Jl2j3NugMS5VhoAaNhpEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gieL+CAx48RMNz1+3RkgIDeJctWJIDx2eBPYuVBFS8JzuM6fgGQrXarlHKzcjf8IZJT7aKhs3aD7O/HFkCInICCJpLtegt0QFb2sY6ts+AS9xS6NTh1ICl//pmCzMkzJUUgO9y222jT349j6ZxOLLE7ETP1jrIjSixPdfzm5hDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QnIhpnrr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N8UPklAp; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QnIhpnrr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N8UPklAp"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id BC8E111400EA;
	Mon, 17 Mar 2025 09:57:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 17 Mar 2025 09:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1742219848; x=1742306248; bh=o/n/7JQ0x+
	pb5LiDjvM1VfthF/fyRNRMN/z3y1DNM+I=; b=QnIhpnrrRPp+m0+OmqtJpVOjPs
	/28n+z/zDvDoIySg3cOL2oeeTJERNNxq+bQVMJqA8xZ74FIzzyUr7fvKU103iME2
	i04WLmwzE8anVTCLbaHIu8KwbjOq020+Ny3b+BAjamtE/yGPqawljUpoMvmGZ90O
	MN8OYj1zCO0wCic/3GZvViz1r0gnWljS0kT9mBzMGW2cd1wWDAJLorfJ5FovODFz
	GMHdaQIZs1ksnr1AjaTQpA8CwMFtVq33e+QGfO7sOy8zJ83xfUYEWpUXUIiZ+e/r
	11YaUJMBars6YA3nxK5Y++o3pQqVsFjC6DkUVeTJlnC/lYDXnzEuCG1o69mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742219848; x=1742306248; bh=o/n/7JQ0x+pb5LiDjvM1VfthF/fyRNRMN/z
	3y1DNM+I=; b=N8UPklAphdtrWTGvusmWOOWPxiawzi24bGjc/MFHY3TRCsUZUeC
	9G9yWwibBKuhjZrFJbdOVFkdwQIjH6PzAIRDo3m1dEkK+wvsKpXrU5mooc8l5RPo
	74hC75wx9wfSjXwYMWkXru1eyjg5xc4K+gj+GZfFbcumzKCRtvpKI0oPG3QIjPR+
	2wBdFHsQY6fXa39bdcq4U7L8iqWkdOjzDvp4vA8i9ceHnBfvSlyyHEYrvZ+/bzMm
	pJkLWjDeKuLZq4tjntgmvb/kbL2M5W2mMj/d+M/JuN8rZrfTuMGpQYiuHbKs0Y4K
	D8Hi24igYzkk9Hjv6KfVP/zk/EGo6IjcxhQ==
X-ME-Sender: <xms:SCrYZ41GBiZLyyjgVkBdUa3Zn7PPpdd87s8k44ZUYXMS-QA_LoT9Hw>
    <xme:SCrYZzHUAGzZJIhfWlaS7girBlWJSEWjU_QqgKx4Q0be3G81eoiNukWKWHBnwvSu_
    C2CIkEv6LaFQj6OPA>
X-ME-Received: <xmr:SCrYZw63is1uZSF8VJyWXA0ATmocwE3xNldqpcDj-AuU7rZ_o8ZMleGHSihAA0swWrQEHzX2txqGA_d-czvPMT-wvpYer_XRXvO0Jz20kyxOMRe->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeelieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmh
    drohhrghdruhhkpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:SCrYZx3xUU4itAAWYW8tZ9Ds3suMbJMjpxlMzVgXUfp4LHtWIiXDKQ>
    <xmx:SCrYZ7F7g6AToWxGx4jhK0gzP49jVko9NzfuY_fUbdWaOZcIroLjBA>
    <xmx:SCrYZ69ML3-6p04uqBoozrTDUpNMtkOM2Y0_SJduyOE7f9wWik70CA>
    <xmx:SCrYZwly-ou6NhJtGBw7x4HxhpMnsWl9sZitTWzQPQlg2_u8KcgpfA>
    <xmx:SCrYZ_jYWv-NIphJosxIcLwqD8Oc5DaCKeNpDt0zhqR5pGXPYsRimlAq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 09:57:27 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2e095765 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 17 Mar 2025 13:57:24 +0000 (UTC)
Date: Mon, 17 Mar 2025 14:57:19 +0100
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] meson: don't install git-pack-redundant(1) docs with
 breaking changes
Message-ID: <Z9gqP3ng0a9Zfpqc@pks.im>
References: <20250312-b4-pks-meson-breaking-changes-v1-0-b89e9a59d228@pks.im>
 <20250312-b4-pks-meson-breaking-changes-v1-3-b89e9a59d228@pks.im>
 <44a3ad4e-fb50-447f-bb66-f43b5c5ae012@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44a3ad4e-fb50-447f-bb66-f43b5c5ae012@gmail.com>

On Sun, Mar 16, 2025 at 03:19:48PM +0000, Phillip Wood wrote:
> On 12/03/2025 13:17, Patrick Steinhardt wrote:
> > +manpages_breaking_changes = {
> > +  'git-pack-redundant.adoc' : 1,
> > +}
> > +
> > +if not get_option('breaking_changes')
> > +  manpages += manpages_breaking_changes
> > +endif
> > +
> >   docs_backend = get_option('docs_backend')
> >   if docs_backend == 'auto'
> >     if find_program('asciidoc', dirs: program_path, required: false).found()
> > @@ -479,7 +486,9 @@ endif
> >   # Sanity check that we are not missing any tests present in 't/'. This check
> >   # only runs once at configure time and is thus best-effort, only. Furthermore,
> >   # it only verifies man pages for the sake of simplicity.
> > -configured_manpages = manpages.keys() + [ 'git-bisect-lk2009.adoc', 'git-tools.adoc' ]
> > +configured_manpages = manpages.keys()
> > +configured_manpages += manpages_breaking_changes.keys()
> > +configured_manpages += [ 'git-bisect-lk2009.adoc', 'git-tools.adoc' ]
> 
> I don't think we need this hunk as we add manpages_breaking_changes into
> manpages in the hunk above.

We indeed need it: it's required in case the 'breaking_changes' option
is enabled. In that case we still need to have the man pages here in
this variable because we use it to check that the manpage is handled at
all. Otherwise we would error out because Meson thinks that we forgot to
wire up this manpage that we found in the source directory.

Patrick
