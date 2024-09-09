Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD5F179AE
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 15:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725894256; cv=none; b=YFNIbGfd/DE3Nf5pyi0DYmliNy897ND/Q805h2XLjCDgVgeV+M+edsMbBmdXcCSng9aUA20MJddEPrLoIzuLmGEzAGs7rpKO8kdn56gGOFHtTzSdTNI9tIqRqGya5EZoV+kp7zefrFspjNQZm47vgcidSAMy7ufe7mS/MgsI2xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725894256; c=relaxed/simple;
	bh=Aab4J3Js05/k+PTdfIyzPgnaLy2t5rL6/w5fpF5i7DA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USZJnGt4GaqaXrDB/aKG03WapKeykbZBmI8nw/OijhzecVhS12FYb+SXZ8vnN3ltYEDl4zRp0vo4IfBUbEcoQii4sSzGqaSRUwFg09RbK2WlUi03w9tHCDH2cfu3FD6UiSVVlKCIkOot0P5l7RSJKKmKUwY8TV79arrSfzuaV68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XZj7ANLB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l67BV3qw; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XZj7ANLB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l67BV3qw"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 2CD6F138015D;
	Mon,  9 Sep 2024 11:04:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 09 Sep 2024 11:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725894251; x=1725980651; bh=TnEs3PwIbx
	J1qKAlikAmEQV1gzVGMWntrlMg9V1XYaQ=; b=XZj7ANLBHfaH1WVHOeSXXcTN6z
	O/unbJPI2ddeewyvFQAnhQDaDec1JHjTpLR0VKlfKZeMkdjcS0DI3N/XPKndevov
	QH+fGIE2fR54YoTH3aof0uIobjxYgGxYNrJjN96hhbDjFVCOeovdnZIiJuwKBNtT
	W4hOLAtR1bUi0qhYduhWpWEtHGEGHc5+2TeDvBsq9OE2dagJYOvsQkEnH8WEOJzp
	N3NJpCacEBoxSn27He/9mFIb80N7b1kHwRmp/r/xnlOCNx8FLyJF5Z6AYKIPiQ96
	iE3JkwwNMKnJ7o/tv86vybnVjWxFv0ynSZoEbcaRlG3Yfb6S4C9FHDctJNog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725894251; x=1725980651; bh=TnEs3PwIbxJ1qKAlikAmEQV1gzVG
	MWntrlMg9V1XYaQ=; b=l67BV3qwaVDN1OShsVVbPcoRggaCm6DBQ3Fus4PsSx7C
	2L3GKUn9VXcSkQKQeRtYp1vDcjLw8tUxTjLmQpYwcuxFuMeFugZ5K9XuEM8wkkZA
	ZlLcEAvkmAp6Zjatln1YuNZjOyR2+hkglhBNRG5p0oj33VOjoBZKTicJGTQ82L91
	KQ2MWuc06qsiVENYWVB9SBypfU3FRaMd/6lM2sxEeh8Pp2BYLmZviW+vTTnTKcgi
	1cXQRSSmoGIyS5uHiPy13NzxSZDCUF16IWMwFkRS7BKTHl6WTyNhhgR1DjmWfWx5
	c47T++XQoBex230VIHckc6X/Mh5dAeSg1e/uP3C5ZA==
X-ME-Sender: <xms:ag7fZuUG4AjUTNFFf1YTmcoWCbzU5cB46JkTyzMDFVmUAsI3iGTayA>
    <xme:ag7fZqnJpkb-55yOUka9UrQliIiwwztvA2isGq7-ob2OzjMe5f0oPu5QcNhJNL_iZ
    B4qdooAQFZCBc-2gw>
X-ME-Received: <xmr:ag7fZiYLXlswzmaj1YpWDXc8hBv7wNYTZnAhLWNbSM-75n-uii1hzASDlWy3s7oKTByptpje-pLK2bnPoXyWxIPPwACFTcK1dvIJ4CbYv5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeijedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhh
    vghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ag7fZlVP-uRRagZDjRBpO8UyBFx9VapW2Yx448iAuVwtzoGlG-wOCA>
    <xmx:ag7fZonpeXZc0tFTtxiQPM9e5gEqGyExaT7fnrf-zdWwPa4sA9t5EQ>
    <xmx:ag7fZqch7JL92buqMNMvcja-C57coRwZ9jJz2ABXVGnzQ-bYv3hgiA>
    <xmx:ag7fZqHvV_-u7UEBxLn064E9hkz-8ETXB8SVAd0gb6EUNENCcilxUg>
    <xmx:aw7fZpBxYX7erK0NsrZSOPE0EwMsmGdMNgzPUMihjZx_pCs6gENdpLcY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Sep 2024 11:04:09 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5c342bb2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Sep 2024 15:04:05 +0000 (UTC)
Date: Mon, 9 Sep 2024 17:04:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/4] ref: add regular ref content check for files
 backend
Message-ID: <Zt8OZywRAxYaWqpo@pks.im>
References: <Ztb-mgl50cwGVO8A@ArchLinux>
 <Ztb_HqLg-WvwA2I0@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ztb_HqLg-WvwA2I0@ArchLinux>

On Tue, Sep 03, 2024 at 08:20:46PM +0800, shejialuo wrote:
> We implicitly rely on "git-fsck(1)" to check the consistency of regular
> refs. However, when parsing the regular refs for files backend by using
> "files-backend.c::parse_loose_ref_contents", we allow the ref content to
> end with no newline or to contain some garbages.
> 
> Even though we never create such loose refs ourselves, we have accepted
> such loose refs. So, it is entirely possible that some third-party tools
> may rely on such loose refs being valid. We should not report an error
> fsck message at current. But let's notice such a "curiously formatted"
> loose refs being valid and tell the user our findings, so we can access
> the possible extent of damage when we tighten the parsing rules in the
> future.
> 
> And it's not suitable to either report a warn fsck message to the user.

s/to either/either to

> This is because if the caller set the "strict" field in "fsck_options",
> fsck warns will be automatically upgraded to errors. We should not allow
> user to specify the "--strict" flag to upgrade the fsck warnings to
> errors at current.

This is formulated a bit curiously: it reads as if we wanted to limit
what the user can do, but what we really want to ensure is that the
`--strict` flag doesn't convert it into an error. So maybe something
like this instead of the second sentence:

    We don't (yet) want the "--strict" flag that controls this bit to
    end up generating errors for such weirdly-formatted reference
    contents, as we first want to assess whether this retroactive
    tightening will cause issues for any tools out there.

> It might cause compatibility issue which may break

s/issue/issues

> the legacy repository. So we add the following two fsck infos to

I wouldn't call it "legacy" just yet, as we didn't yet decide whether
we're going to make this formatting invalid in the first place. It's
rather a test balloon.

> represent the situation where the ref content ends without newline or has
> garbages:

s/garbages/trailing garbage

> 1. "refMissingNewline(INFO)": A ref does not end with newline. This kind
>    of ref may be considered ERROR in the future.
> 2. "trailingRefContent(INFO)": A ref has trailing contents. This kind of
>    ref may be considered ERROR in the future.

In both cases, "may be considered ERROR" -> "may be considered an
error". Also in the actual messages.

> It may seem that we could not give the user any warnings by creating
> fsck infos. However, in "fsck.c::fsck_vreport", we will convert
> "FSCK_INFO" to "FSCK_WARN" and we can still warn the user about these
> situations when using "git-refs verify" without introducing

s/"git-refs verify"/"git refs verify". We don't use dashed builtins
nowadays anymore.

> compatibility issue.

s/issue/issues

> In current "git-fsck(1)", it will report an error when the ref content
> is bad, so we should following this to report an error to the user when
> "parse_loose_ref_contents" fails. And we add a new fsck error message
> called "badRefContent(ERROR)" to represent that a ref has a bad content.

Okay, so this is basically porting over behaviour that git-fsck(1)
already has to `git refs verify` and should thus not cause new issues
anywhere. I think it would have made sense to do so in a first step and
then introduce the tightened rules in a separate commit.

Will we eventually remove those checks from git-fsck(1) when we adapt it
to call `git refs verify`? If so, we should likely note that in the
commit message.

> In order to tell whether the ref has trailing content, add a new
> parameter "trailing" to "parse_loose_ref_contents". Then introduce a new
> function "files_fsck_refs_content" to check the regular refs to enhance
> the "git-refs verify".

This paragraph only re-explains what the diff already tells us, so it
can likely be removed.

> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Signed-off-by: shejialuo <shejialuo@gmail.com>
> ---
>  Documentation/fsck-msgids.txt |  11 ++++
>  fsck.h                        |   3 +
>  refs.c                        |   2 +-
>  refs/files-backend.c          |  68 ++++++++++++++++++-
>  refs/refs-internal.h          |   2 +-
>  t/t0602-reffiles-fsck.sh      | 120 ++++++++++++++++++++++++++++++++++
>  6 files changed, 202 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
> index 68a2801f15..06d045ac48 100644
> --- a/Documentation/fsck-msgids.txt
> +++ b/Documentation/fsck-msgids.txt
> @@ -19,6 +19,9 @@
>  `badParentSha1`::
>  	(ERROR) A commit object has a bad parent sha1.
>  
> +`badRefContent`::
> +	(ERROR) A ref has a bad content.
> +

s/a bad content/bad content

>  `badRefFiletype`::
>  	(ERROR) A ref has a bad file type.
>  
> @@ -170,6 +173,14 @@
>  `nullSha1`::
>  	(WARN) Tree contains entries pointing to a null sha1.
>  
> +`refMissingNewline`::
> +	(INFO) A ref does not end with newline. This kind of ref may
> +	be considered ERROR in the future.
> +

I'd reformulate the second sentence to "This will be considered an error
in the future". This indicates that we have the intent to tighten this
check to any user and would urge them to speak up in case they disagree
with such a tightening.

> +`trailingRefContent`::
> +	(INFO) A ref has trailing contents. This kind of ref may be
> +	considered ERROR in the future.

Same.

> @@ -3430,6 +3434,65 @@ typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
>  				  const char *refs_check_dir,
>  				  struct dir_iterator *iter);
>  
> +static int files_fsck_refs_content(struct ref_store *ref_store,
> +				   struct fsck_options *o,
> +				   const char *refs_check_dir,
> +				   struct dir_iterator *iter)
> +{
> +	struct strbuf ref_content = STRBUF_INIT;
> +	struct strbuf referent = STRBUF_INIT;
> +	struct strbuf refname = STRBUF_INIT;
> +	struct fsck_ref_report report = {0};
> +	const char *trailing = NULL;
> +	unsigned int type = 0;
> +	int failure_errno = 0;
> +	struct object_id oid;
> +	int ret = 0;
> +
> +	strbuf_addf(&refname, "%s/%s", refs_check_dir, iter->relative_path);
> +	report.path = refname.buf;
> +
> +	if (S_ISLNK(iter->st.st_mode))
> +		goto cleanup;
> +
> +	if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0) {
> +		ret = error_errno(_("%s/%s: unable to read the ref"),
> +				  refs_check_dir, iter->relative_path);

We typically have the name of things we read trailing and not leading in
error messages. So this should rather be "unable do read ref '%s/%s'".

> +		goto cleanup;
> +	}
> +
> +	if (parse_loose_ref_contents(ref_store->repo->hash_algo,
> +				     ref_content.buf, &oid, &referent,
> +				     &type, &trailing, &failure_errno)) {
> +		ret = fsck_report_ref(o, &report,
> +				      FSCK_MSG_BAD_REF_CONTENT,
> +				      "invalid ref content");
> +		goto cleanup;
> +	}
> +
> +	if (!(type & REF_ISSYMREF)) {

Coming back to my comment further up, I guess this whole block here
could be introduced in a separate commit. So the first commit introduces
the infra to check loose ref contents as an obvious step because we
simply port over rules that already exist in git-fsck(1). And the second
step could then do this retroactive tightening with the justification
you have spelt out in the commit message.

> +		if (*trailing == '\0') {

`if (!*trailing)`

Patrick
