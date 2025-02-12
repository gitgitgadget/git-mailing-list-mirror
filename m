Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CEE1E47CC
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 10:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739355382; cv=none; b=OMcIUqj2P++W8F2rfcHcHYOzE1Mg4jj7bqhvEc4q0ENSSdB4RpbXInPCMexFalKzp0mH4McPE8qz0leKIG4vjJQ1vyD4CT/rVSMQS+X+YFPFrJ1lTkLokXqsgBQTlj543yo3RMEqqWN7Im8rbKzkhxA6KrE5PhbPJI76xHnG8gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739355382; c=relaxed/simple;
	bh=ESKgX7J5ecw+nInIv3mliIFFU18ZJDSutlOUDbiFd/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swsxE9wkXS8RBzArTpfK6uNhCrHgcuRNvkhNtU2kri2AEcGNwj9n3gueWiqVAWyhm4+6jraL1RYFFexuouQlrPi9xYQiyHGmZKZsCqdTxZWeK2rOkfn5yCxCcVxO9KoKqwAO1hXiJMeuE1GURmK2UNKFhauoOYg0r9BcQ1J1E5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6A3fGGo; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6A3fGGo"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7be8efa231aso679423885a.2
        for <git@vger.kernel.org>; Wed, 12 Feb 2025 02:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739355379; x=1739960179; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aNNZjknvWMWKDqEZojPtsN8KRtSLelbov/5G29bjArY=;
        b=g6A3fGGok4Od2ECp04nsiKERUoxpDGyCVUPTZZegSGcjMI1dnVUIGjn0q7aITzNZjp
         4yxVEWEktuDefIz/MYQ4HREtYJod8FUHK7qsFExfxEWb6/KnIpHN5JjHTRJ31uUKgOLv
         GDHkmx10jAHo1Hwpt9nUhaoxfqYYg5dMvCUzCJ7i7esj5q76/zbglOO4s6BhRTCawn7q
         ZcMD5XF4CMyh4hjxKNAEWkxGjDsssb1fxvjMrDKBo3yZwtp5enrhBdtK3KqMa31VYdVA
         oG01Cae8oayQyQ/DFuMmLuFTYPMb5l7UKCFWovGvrhGIJJ6OHHK8ZQHnbSRQrGdyPtew
         ZEVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739355379; x=1739960179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNNZjknvWMWKDqEZojPtsN8KRtSLelbov/5G29bjArY=;
        b=c/G0Y3GM/8NDT3EjZoil8Z5ys1wS8zvDka6OHiShX0TUew+MRC7TnQ4PWK4NMTaVya
         DXJpPMxKmnXN1wzSLH3Ykd4VBkv0NuVGUptcdgJqR2LPo645xE7Y/y5+NxYqlFrY+1Ga
         u8Mhv+hl/yDG61GW5S1Kd1yjFwkjnHNAXSVroTXqlFZ6SxHbsxLRTq90qeeKi0TONCy5
         4yIMP5FNZyzdGdKlKGIEYvT4tutnRD5fxEJ7joDmSffoVHBMTJosp8tB5dzbkMDwUpgk
         BBst5e956mMTY9CBpmv3ovo+RhdDS65yedMA/bHroHPoru+0C91n3L86R1mDfXfG94gT
         7PQw==
X-Gm-Message-State: AOJu0YzaCgBLYcePz2Zh+Z1ugf6DpR+WSl+oW+ZnvNwI967KKjlUdkQx
	xhw1db0hCPDQw+Lp9iFOFtRMR9Vs2wZjTjvpI5X8tFatWpnB+/XW
X-Gm-Gg: ASbGncusORVtTOhRLWLZh4fwX/667g3LeZwd6HK0r4goIO/aeNx37rRI3KqIDWk6gd4
	lMsgShPQeD42hZN0P3i8/ob2/cP9vY4mOFIm0cVk+UnEzAYlGkFnhvM9SJrfJ/79/KNI+bNpucs
	QREwJGS908JqfWMMZsUG2E37BJY8oO43cnZqjAV4yMCiy6Ni6XxpPsdY249vU8N/6IHsEGw/LMb
	2I7eLjkYyOs5r/GepYLnUJHh3UW5gmRegnpkVhgrpD02w4yaJa4aelOid3zoHL5zP8FfA==
X-Google-Smtp-Source: AGHT+IEEtLHgDh8KSS6EZsvtlaxxKreXTI8dIOASGss8bGubVK6Qb4rDk5s9BKJYEHXefJLPHwk5/A==
X-Received: by 2002:a05:6214:1d29:b0:6d8:9dad:e167 with SMTP id 6a1803df08f44-6e46ed8349emr33187376d6.15.1739355379323;
        Wed, 12 Feb 2025 02:16:19 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e4532f9ce9sm54721356d6.65.2025.02.12.02.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 02:16:18 -0800 (PST)
Date: Wed, 12 Feb 2025 18:18:12 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 6/8] packed-backend: add "packed-refs" entry
 consistency check
Message-ID: <Z6x1ZIsgYaLh71D2@ArchLinux>
References: <Z6RPJI10-2QkwyqH@ArchLinux>
 <Z6RPzIGD-fSwIEPV@ArchLinux>
 <Z6xwYlYFzbn3ft8u@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6xwYlYFzbn3ft8u@pks.im>

On Wed, Feb 12, 2025 at 10:56:50AM +0100, Patrick Steinhardt wrote:
> On Thu, Feb 06, 2025 at 01:59:40PM +0800, shejialuo wrote:
> > diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> > index c8bb93bb18..658f6bc7da 100644
> > --- a/refs/packed-backend.c
> > +++ b/refs/packed-backend.c
> > @@ -1826,6 +1899,26 @@ static int packed_fsck_ref_content(struct fsck_options *o,
> >  		line_number++;
> >  	}
> >  
> > +	while (start < eof) {
> > +		strbuf_reset(&packed_entry);
> > +		strbuf_addf(&packed_entry, "packed-refs line %lu", line_number);
> 
> Instead of greedily computing the name of the line, can we pass in the
> line number? The motivation is that in a well-formatted packed-refs file
> we won't ever need this string at all, so it's wasteful to proactively
> compute it for every single line.
> 

I agree with you here. And I already have idea to do this. Let me
improve this in the next version.

> > diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
> > index da321f16c6..3ab6b5bba5 100755
> > --- a/t/t0602-reffiles-fsck.sh
> > +++ b/t/t0602-reffiles-fsck.sh
> > @@ -664,4 +664,46 @@ test_expect_success 'packed-refs header should be checked' '
> >  	)
> >  '
> >  
> > +test_expect_success 'packed-refs content should be checked' '
> > +	test_when_finished "rm -rf repo" &&
> > +	git init repo &&
> > +	(
> > +		cd repo &&
> > +		test_commit default &&
> > +		git branch branch-1 &&
> > +		git branch branch-2 &&
> > +		git tag -a annotated-tag-1 -m tag-1 &&
> > +		git tag -a annotated-tag-2 -m tag-2 &&
> > +
> > +		branch_1_oid=$(git rev-parse branch-1) &&
> > +		branch_2_oid=$(git rev-parse branch-2) &&
> > +		tag_1_oid=$(git rev-parse annotated-tag-1) &&
> > +		tag_2_oid=$(git rev-parse annotated-tag-2) &&
> > +		tag_1_peeled_oid=$(git rev-parse annotated-tag-1^{}) &&
> > +		tag_2_peeled_oid=$(git rev-parse annotated-tag-2^{}) &&
> > +		short_oid=$(printf "%s" $tag_1_peeled_oid | cut -c 1-4) &&
> > +
> > +		printf "# pack-refs with: peeled fully-peeled sorted \n"  >.git/packed-refs &&
> > +		printf "%s\n" "$short_oid refs/heads/branch-1" >>.git/packed-refs &&
> > +		printf "%sx\n" "$branch_1_oid" >>.git/packed-refs &&
> > +		printf "%s   refs/heads/bad-branch\n" "$branch_2_oid" >>.git/packed-refs &&
> > +		printf "%s refs/heads/branch.\n" "$branch_2_oid" >>.git/packed-refs &&
> > +		printf "%s refs/tags/annotated-tag-3\n" "$tag_1_oid" >>.git/packed-refs &&
> > +		printf "^%s\n" "$short_oid" >>.git/packed-refs &&
> > +		printf "%s refs/tags/annotated-tag-4.\n" "$tag_2_oid" >>.git/packed-refs &&
> > +		printf "^%s garbage\n" "$tag_2_peeled_oid" >>.git/packed-refs &&
> 
> This can be simplified using HERE docs.
> 
>         cat >.git/packed-refs <<-EOF
>         # pack-refs with: peeled fully-peeled sorted 
>         $short_oid refs/heads/branch-1
>         ${branch_1_oid}x
>         $branch_2_oid   refs/heads/bad-branch
>         $branch_2_oid refs/heads/branch.
>         $tag_1_oid refs/tags/annotated-tag-3
>         ^$short_oid\n
>         $tag_2_oid refs/tags/annotated-tag-4.
>         ^$tag_2_peeled_oid garbage
>         EOF
> 

Thanks for the suggestion, I will improve this in the next version.

> Patrick
