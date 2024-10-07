Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C89315B130
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 06:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728284340; cv=none; b=GXGNjIY2U+EXC4NCBP5WBxROC54RJq0AAatHkLRsUz4Eq6PkhIT5nicFUc1vYFnMcig1D5AuvD2MNLWxTU6PwHfXkZ07ubImMfMtRomFh7v5IT1tAUrsnFKpWeM8356sPaa69FbUkLSH5NZFOORNy43+p9WDmFoObPeUuQGupG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728284340; c=relaxed/simple;
	bh=CnapbXn8cV3e3Q1nVQgvq+J9T7U3c4m6lEpjBb6A/Qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4XBl4HhbxFLY2bYDP7tO6jGQFJuinoYA+ce/PDsQawaHLwBsgP17p8Dwp//YL7TwAXtbkWF4Kxi+8LQL1GgpPtfzDcFFeL9b9VVHWU72pr4aq083+KNk1TyM70nCN1S1FEzUN3fhXLTS6U8s5a4539xzcv3jNoyW3tlXxUCnAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WqK6zevg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MYNM1qZu; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WqK6zevg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MYNM1qZu"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1784125400CB;
	Mon,  7 Oct 2024 02:58:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 07 Oct 2024 02:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728284337; x=1728370737; bh=eACfhoj3Y2
	JFHsZWmyJT0LE5KpwThTZUI9rCB7H77jw=; b=WqK6zevgfyoXt1FRFuORMsphBm
	7tg81Ri07nytXQpUi/Zof7k5sHYGQBJ62cUN5LaVA+sEZrbt7tdqU5D7qKn1B4BK
	HGXednyCBeznsuqFllW3dN9MNUaomeaDF5W9/n5UBuAy4mrwfosIkVAzeGPdrEGL
	PEr1Bv2RXCR6IEws77IiUiyOktEQaL6AjWKGhroTnhWCwfSUvyDO/deY19k+ZJO2
	hc+p3HumZynpoXCKVhV2x9U/2CjlKToxe13zbVs1M6PVNwqNZ+/5o7j/3ftmG+B8
	HRIgZ8TEyt/Lm0VZZsHZvXwgs9RVrjxjZr3kh+ycsl2fsS8MV/tZxTVuTUlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728284337; x=1728370737; bh=eACfhoj3Y2JFHsZWmyJT0LE5KpwT
	hTZUI9rCB7H77jw=; b=MYNM1qZuudxKt3NIEpQu6zcom2n+4Ftg10D+ArxqVb4r
	b3JD8k0mgJkImOuKjqPDzrgzyQxlhmQb4JxltJxHEmDZzQ0we67j+DvLAOBdTIrg
	4ja9cx6Y6KBnZipSh4jHZ6dhSxqDid4JYXqUhnyzhPk7yvzCZSWJXc5Z+nODAVGp
	zLqmsHc89mQaH5RWkhsc8BEZANggvoEIwUR0MAw/h/CBNd9941ZXZ2d+nzwGeDBr
	fd9CJpWrsGHsw1KHe77Iqpjpxvi4RF9Htm9HlUGVzwHr5mrnl0c8Rqlph9fY1Rch
	brZQ8FPWyML9YfnovWSH0zrrKeAvoc3ZbvBFBxg9Gg==
X-ME-Sender: <xms:sYYDZ6DwO4xirjMY3YHRicVuSTDuCA5w44IdYWZjExNMzZNvRN3ZPQ>
    <xme:sYYDZ0hQK2so1FXH3ate2yTpmP0tDe1anKRoUIPIsUQRcBygqeJZLZseUg50AdUyH
    kRi9C7gF8CCTuc1Xg>
X-ME-Received: <xmr:sYYDZ9k2UvVccQJupAuNpsMseNsMe1nNr7vDAu2KbBpd4UqOskvvAsKhI2WFQDPJzwRJlaZOaApnLigwVN6_aA9eNn3xAwvldo0S98g3s2v_vgJE1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvkedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhgv
    jhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekke
    esghhmrghilhdrtghomh
X-ME-Proxy: <xmx:sYYDZ4y8N1SJHTTr71272YYxCC9ztDALg_IPweAV62MstdruTYGQGg>
    <xmx:sYYDZ_TTdGTuun9rjDzJsikECyvOBdztXZBzQ6kI2qsVxQSnp-N7PA>
    <xmx:sYYDZzYTAjpS0PVjLvUnDY80TEG4FFFsOVUQVJkmkDvLJE_dZvKM0Q>
    <xmx:sYYDZ4RDioz6mGUBavNRWwumhN-W8xhAGm-NSBhmAMjoARn18j4CEg>
    <xmx:sYYDZ9M-xxA5kaY-VgS36qz-BB93kODu7ey85okRv49gBbfSJWX5FcJI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 02:58:56 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b04a32ac (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 06:57:59 +0000 (UTC)
Date: Mon, 7 Oct 2024 08:58:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 6/9] ref: add escape check for the referent of symref
Message-ID: <ZwOGr4Tv8K_wemtD@pks.im>
References: <Zvj-DgHqtC30KjJe@ArchLinux>
 <Zvj-xaa_j26Auig7@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zvj-xaa_j26Auig7@ArchLinux>

On Sun, Sep 29, 2024 at 03:16:21PM +0800, shejialuo wrote:
> Ideally, we want to the users use "git symbolic-ref" to create symrefs
> instead of writing raw contents into the filesystem. However, "git
> symbolic-ref" is strict with the refname but not strict with the
> referent. For example, we can make the "referent" located at the
> "$(gitdir)/logs/aaa" and manually write the content into this where we
> can still successfully parse this symref by using "git rev-parse".
> 
>   $ git init repo && cd repo && git commit --allow-empty -mx
>   $ git symbolic-ref refs/heads/test logs/aaa
>   $ echo $(git rev-parse HEAD) > .git/logs/aaa
>   $ git rev-parse test

Oh, curious. This should definitely be tightened in git-symbolic-ref(1)
itself. The target should either be a root ref or something starting
with "refs/". Anyway, that is of course outside of the scope of this
patch series.

> We may need to add some restrictions for "referent" parameter when using
> "git symbolic-ref" to create symrefs because ideally all the
> nonpeudo-refs should be located under the "refs" directory and we may
> tighten this in the future.

Agreed.

> In order to tell the user we may tighten the "escape" situation, create
> a new fsck message "escapeReferent" to notify the user that this may
> become an error in the future.
> 
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Signed-off-by: shejialuo <shejialuo@gmail.com>
> ---
>  Documentation/fsck-msgids.txt |  8 ++++++++
>  fsck.h                        |  1 +
>  refs/files-backend.c          |  7 +++++++
>  t/t0602-reffiles-fsck.sh      | 18 ++++++++++++++++++
>  4 files changed, 34 insertions(+)
> 
> diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
> index e0e4519334..223974057d 100644
> --- a/Documentation/fsck-msgids.txt
> +++ b/Documentation/fsck-msgids.txt
> @@ -52,6 +52,14 @@
>  `emptyName`::
>  	(WARN) A path contains an empty name.
>  
> +`escapeReferent`::
> +	(INFO) The referent of a symref is outside the "ref" directory.

Proposal: 'The referent of a symbolic reference points neither to a root
reference nor to a reference starting with "refs/".'

I'd also rename this to e.g. "symrefTargetIsNotAReference" or something
like that, because it's not really about whether or not the referent is
"escaping". It's a bit of a mouthful, but I don't really have a better
name. So feel free to pick something different that describes the error
better.

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 57ac466b64..bd215c8d08 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -3520,6 +3520,13 @@ static int files_fsck_symref_target(struct fsck_options *o,
>  	orig_last_byte = referent->buf[orig_len - 1];
>  	strbuf_rtrim(referent);
>  
> +	if (!starts_with(referent->buf, "refs/")) {
> +		ret = fsck_report_ref(o, report,
> +				      FSCK_MSG_ESCAPE_REFERENT,
> +				      "referent '%s' is outside of refs/",
> +				      referent->buf);
> +	}
> +
>  	if (check_refname_format(referent->buf, 0)) {
>  		ret = fsck_report_ref(o, report,
>  				      FSCK_MSG_BAD_REFERENT,

This check is invalid, because referents can also point to root refs. So
you should probably also add a call to `is_root_ref()` here.

We also have `is_pseudo_ref()`, and one might be tempted to also allow
that. But pseudo refs aren't proper refs, so I'd argue that a symref
pointing to a pseudo ref is invalid, too.

Patrick
