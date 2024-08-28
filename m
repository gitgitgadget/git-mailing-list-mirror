Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB9D45C1C
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 14:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724856044; cv=none; b=KvhrwMnEcVkp0O/JF0eURVVxAWHTcdaBUC9OchjQ94pDqWqMqiWugjYiOkiFsWfsFSB9IBJnMtJhaRk9I0SYyMAPXM8FWFNnpccecdsREhA6e9SSyigLo8U7+fgv8AilUGUQZ5MyqGWymohtqwGBV12FCXXUKbB8IFdMi5RcU6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724856044; c=relaxed/simple;
	bh=m7FdgrJp7abpirySCkzCnC5IXP1IPGR76Yy9qYl+P0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+qZ3f3qWNcv3I0XOrrto32PczfcvfTaphkSwSbFiMkOTB0QNwQwlCub63y6H5IYxn93G6ZOSdTpeEGIKR9KMzFqmUpfhE7T3W88bNPplakXPfT0HRrTmeZ7hDIuv9VL1SukD0af6mzCUOfw0bwSjKWcRGdi5wViHJ9W9H14VUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7O7PRi0; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7O7PRi0"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-714186ce2f2so5361740b3a.0
        for <git@vger.kernel.org>; Wed, 28 Aug 2024 07:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724856042; x=1725460842; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D/uMLrtMXoOs+cuOpXAdyyk11kaLo+yBj7cMkcz8dlg=;
        b=e7O7PRi0HAnNlKDB61mnpy/Lzo0qclBcUvAhmrB5oTokKbJgeyBsYlGMbtz6WbSx23
         PdhNsl8h6K5rRRlI7/0Vs8jIH0EaX9LbiS0RWuSQpy7sWyTIhobJu0ewk98mP800X+zz
         AXzPM+rwMsPjsm2UMFLJA8bkzRaIIljSXlB3xY6acJp4n1qyKzCabWGaKTy11Vi4DZLl
         6A+qmg+LuUs9MGwvv2zH708LyR+L5nt4RuupFEJfLjV0Bz7UbulyTMNPxBo7bzG3bVwM
         NDuMBTM8YGw74R+U0+upFoun3yallWVT8k9+oGcH1p9kwuLiysDelhUgFp/NKVCVcbvw
         p1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724856042; x=1725460842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/uMLrtMXoOs+cuOpXAdyyk11kaLo+yBj7cMkcz8dlg=;
        b=HmeWuUjLVxfYj9IBOToHQlMVIpE++Kq2sQ0mRpjN1nK+zf0nfKbRFhiHdl/wJkgPRX
         TNI7EQyKpqd9cV9uVUVuGswjB87Mto5RPjG768jDkqxgKvsel3xCCderq4C5fQ2XLMRV
         oJCCEqFWntZl2dM/JQtzNwrDotKSP/ADJqQ6Czrb/nbAZeZO24PBYJ0HqP1TkT+o/fZu
         HCJkMbxHGGlD7umXKUbt1f2AXDW5BxjSIEXcakzX9YqYUR+nZjBkmC948hIACg/iMQa6
         DpSvZKb3ZHQuDS04OfAYi1xZbd0gVoKHWpy2u9YzXLCVYD47Oedlz3XtnMJxK5EYCLVS
         xc3w==
X-Gm-Message-State: AOJu0YxfgS9t5HH4Ohw2ut4wB1LJYVulEhHyxazhD3y0FZ+B3hdXiVYo
	bs7bVKz5O5LQvn5Sreyw0wv+b4Nrmazz+qNN00/XdC+hDTaoowe4
X-Google-Smtp-Source: AGHT+IETny53YzroEa3kiDm1Tp5bAfp+kKNbUOMC1rtIAAoHWKs4iVcEWKsTABWvsGCsye9HcHBsEQ==
X-Received: by 2002:a05:6a00:1950:b0:714:2881:44cc with SMTP id d2e1a72fcca58-7144577249bmr17447086b3a.10.1724856041844;
        Wed, 28 Aug 2024 07:40:41 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714343341cdsm10210401b3a.198.2024.08.28.07.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 07:40:40 -0700 (PDT)
Date: Wed, 28 Aug 2024 22:41:32 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] ref: add regular ref content check for files
 backend
Message-ID: <Zs83HCZjM1gycfv1@ArchLinux>
References: <Zs348uXMBdCuwF-2@ArchLinux>
 <Zs353oLDaw2SbNQs@ArchLinux>
 <Zs8c81Z-zb4uQpp6@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs8c81Z-zb4uQpp6@tanuki>

On Wed, Aug 28, 2024 at 02:50:01PM +0200, Patrick Steinhardt wrote:
> On Wed, Aug 28, 2024 at 12:07:58AM +0800, shejialuo wrote:
> > @@ -170,6 +173,12 @@
> >  `nullSha1`::
> >  	(WARN) Tree contains entries pointing to a null sha1.
> >  
> > +`refMissingNewline`::
> > +	(INFO) A valid ref does not end with newline.
> 
> This reads a bit funny to me. If the ref is valid, why do we complain?
> 
> Maybe this would read better if you said "An otherwise valid ref does
> not end with a newline".
> 

I think we should just drop the "valid" here. Because for symref, it
may miss newline and is NOT valid.

I will improve this in the next version.

> > @@ -3430,6 +3434,65 @@ typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
> >  				  const char *refs_check_dir,
> >  				  struct dir_iterator *iter);
> >  
> > +static int files_fsck_refs_content(struct ref_store *ref_store,
> > +				   struct fsck_options *o,
> > +				   const char *refs_check_dir,
> > +				   struct dir_iterator *iter)
> > +{
> > +	struct strbuf ref_content = STRBUF_INIT;
> > +	struct strbuf referent = STRBUF_INIT;
> > +	struct strbuf refname = STRBUF_INIT;
> > +	struct fsck_ref_report report = {0};
> > +	const char *trailing = NULL;
> > +	unsigned int type = 0;
> > +	int failure_errno = 0;
> > +	struct object_id oid;
> > +	int ret = 0;
> > +
> > +	strbuf_addf(&refname, "%s/%s", refs_check_dir, iter->relative_path);
> > +	report.path = refname.buf;
> > +
> > +	if (S_ISREG(iter->st.st_mode)) {
> 
> This is still indenting the whole body. You mentioned that you don't
> want to use `goto`, but in our codebase it's actually quite idiomatic.
> And you already use it anyway.
> 

I think so, indenting is noisy. Will use "goto" to avoid indenting.

> > diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
> > index 71a4d1a5ae..7c1910d784 100755
> > --- a/t/t0602-reffiles-fsck.sh
> > +++ b/t/t0602-reffiles-fsck.sh
> > @@ -89,4 +89,91 @@ test_expect_success 'ref name check should be adapted into fsck messages' '
> >  	test_must_be_empty err
> >  '
> >  
> > +test_expect_success 'regular ref content should be checked' '
> > +	test_when_finished "rm -rf repo" &&
> > +	git init repo &&
> > +	branch_dir_prefix=.git/refs/heads &&
> > +	tag_dir_prefix=.git/refs/tags &&
> > +	cd repo &&
> > +	git commit --allow-empty -m initial &&
> > +	git checkout -b branch-1 &&
> > +	git tag tag-1 &&
> > +	git commit --allow-empty -m second &&
> > +	git checkout -b branch-2 &&
> > +	git tag tag-2 &&
> > +	git checkout -b a/b/tag-2 &&
> 
> Wouldn't it be sufficient to only create a single commit, e.g. via
> `test_commit`? From all I can see all you need is some object ID, so
> creating the tags and second commit doesn't seem to be necessary.
> 

I agree with this. I will clean the code for the next version.

> > +	printf "%s" "$(git rev-parse branch-1)" > $branch_dir_prefix/branch-1-no-newline &&
> 
> We don't typically have spaces after the redirect. So you should remove
> them here and in all the subsequent instances.
> 

I will clean the code style here.

> > +	git refs verify 2>err &&
> > +	cat >expect <<-EOF &&
> > +	warning: refs/heads/branch-1-no-newline: refMissingNewline: missing newline
> > +	EOF
> > +	rm $branch_dir_prefix/branch-1-no-newline &&
> > +	test_cmp expect err &&
> 
> I was wondering whether each of these cases should be a separate test,
> but that may be a bit wasteful. Alternatively, can we maybe set up a
> single repository with all the garbage that we want to verify and then
> double check that executing `git refs verify` surfaces them all in a
> single invocation?
> 

Actually, I have also thought about separating the tests which may
clear and I dropped this idea due to the reason the same as yours. I DO
agree that we should set up a single repository with all the garbage
that we want to verify. This is necessary.

Thanks,
Jialuo
