Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600FB1519A1
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 03:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739505201; cv=none; b=f4SPBARPhk9XBb/n9PkVpI0xaJ/al1kLjho4WPI04i8ccPCoA58AmHt7MeVFqh0xpsZa8BHguh8YkBPCm2FjIihge6gxPetEmJSlNGHdpZfwH8FFJXO+uS5YLil6VrCMNe9sWVJKf/UkEbzsmMfMtlJEs5e9PN2QrBkJa2KWQVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739505201; c=relaxed/simple;
	bh=nGlMQgW5qCAC0jBUdlDIjsQWaCNpTnfiykw+p7Tv2UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ou+iOjGyzMH4d+opDLjkLWNxFKIVUrGZvcomlJSV1g9kf80AYQO1yF2JCqI4uO/Oeyiiy4SDVIRGWsXsZwM0jVyhj4D+xk8YobStNyaDI07PWwuA6ndoaE9AuoAq84EPfm6hXU3PlK0F91uSG2uSQAvJd6akVK0Wi+VrwInsZLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHMYB1fM; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHMYB1fM"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e5dab3f372aso1281774276.1
        for <git@vger.kernel.org>; Thu, 13 Feb 2025 19:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739505198; x=1740109998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fDLx181elDyE14U8jt/lwpp/wsavjJE/sem3ULM2Kak=;
        b=KHMYB1fMUe8TtA1+TgP08h/idK6wvzXqzR8+edNvChe6aIHv0RVZzbH+eV2njqNznt
         oTc+PjsfMnzIyP2Ie9cGCLxQGyelwfzitVsokiixBoaQJhzs5B9Km9bxzx122t1fDGI1
         uWO+sl3gEOBXv0X4VifAcAJ+FvnKrouCBt6PlOtru9js6hb8ajZDedXwCY1PHDFgoGKM
         C/khmHLqJoXFOvVDNKC9ayYYg5nJ25DXwgdDiTOu/BG+zHJyEn9UBgbU6/boCwE3LzMI
         gOQDtf03q4xwMlBptaqWh4YEWCewqvm8JcbJyLFnEkJnDZoxVCGlj0fAZoJPXBSQbKV0
         xL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739505198; x=1740109998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDLx181elDyE14U8jt/lwpp/wsavjJE/sem3ULM2Kak=;
        b=gadeaW39DMnoYpbCkk9IhQapJxZKsC46B/RGhqFXAqhkVcxCOCbCkMftQp15rjEKgY
         2kqZBR+05NQ53FuMKIJnXdb6cpuAmvf7+lPWnDDDrTxb7YByMeMQeTi7YJoZ1/vHaVxp
         WpvZopyUBSBDY+RzkkaAPuc1741BJeqo/YbzA+rzQPy3SVfFbk4D7MfmZ4UuaKeDhKgr
         TCQqqK1c7gH0cZDC0pFddQ7ZkwKOY965RzTeyxbzBAOo5vqVHI/9TE9gYcJIF9vevcr+
         C1wAExIbchZR+IoASwuj7NDpHdYwawl5sKKckT/0WQFGrfF7S7l91ZcutdLyeqaZBneI
         bz0A==
X-Forwarded-Encrypted: i=1; AJvYcCUCclDM3GmG9fHXKZGicFTc1CnBYJIlDcmeGHlONUFMmHLD1d/A6oObCoX+2Fy9TtWIgOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeSjBeCMYWY7RsRexDSYrskeQpi4EbEWaief4F481cVW1WVPMv
	il25UVnCQa2M7v5C6xzKxL3z6JLA11sdu+Efd1wMd5LsXErdwMZkf5ads19g
X-Gm-Gg: ASbGncvd4+oVs6YxIgAXeepNoAhMCBudoJ6Tq0JH4qai4SZ5J/9l+J5Old0Q2w6rwGk
	kOqPB9eJtnptLgrHb8npd9udqWPkWR3qLTvluRLW2R1p00xsMUFWkVFRH6XsgEflUalaDc85Kft
	OsibFQtird9lnzXIzhMZAz70uMbbRzShuQnNykXtBPErvyu8UIgxo/Op44QI97QKCeID9AjYNgj
	gcF+4DF59IgLkEWvVMu60BJ2sHULz6VKYWqzRdsrddTHkyAZbKSwHXAOKcgSdQfeg8b/w==
X-Google-Smtp-Source: AGHT+IFpnui4egFL3JalsDxglSnFWIlCPpUym0j4nt9VSRoakGElQNaaQbcmlZ2yKw2MVNmVEDZe7Q==
X-Received: by 2002:a05:6902:1007:b0:e5d:c1b9:4a7 with SMTP id 3f1490d57ef6-e5dc1b90599mr86966276.23.1739505198149;
        Thu, 13 Feb 2025 19:53:18 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e5dae10e0dcsm775521276.53.2025.02.13.19.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 19:53:16 -0800 (PST)
Date: Fri, 14 Feb 2025 11:53:12 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 4/8] packed-backend: add "packed-refs" header
 consistency check
Message-ID: <Z66-KHC4SP4yqmnW@ArchLinux>
References: <Z6RPJI10-2QkwyqH@ArchLinux>
 <Z6RPqE64ScsjzUg7@ArchLinux>
 <Z6xwW0N7GG4NhCzZ@pks.im>
 <xmqq4j0zuk9y.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4j0zuk9y.fsf@gitster.g>

On Wed, Feb 12, 2025 at 09:48:09AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > On Thu, Feb 06, 2025 at 01:59:04PM +0800, shejialuo wrote:
> >> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> >> index 6401cecd5f..683cfe78dc 100644
> >> --- a/refs/packed-backend.c
> >> +++ b/refs/packed-backend.c
> >> @@ -1749,12 +1749,76 @@ static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_s
> >> +static int packed_fsck_ref_header(struct fsck_options *o,
> >> +				  const char *start, const char *eol)
> >> +{
> >> +	if (!starts_with(start, "# pack-refs with:")) {
> >> +		struct fsck_ref_report report = { 0 };
> >> +		report.path = "packed-refs.header";
> >> +
> >> +		return fsck_report_ref(o, &report,
> >> +				       FSCK_MSG_BAD_PACKED_REF_HEADER,
> >> +				       "'%.*s' does not start with '# pack-refs with:'",
> >> +				       (int)(eol - start), start);
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >
> > Okay. We still complain about bad headers, but only if there is a line
> > starting with "#" and only if the prefix doesn't match. This addresses
> > Junio's comment that packfiles don't have to have a header, and that
> > they may contain capabilities that we don't understand.
> 
> We'd want to also ensure that there is a single trailing whitespace
> after that colon, which we have always written after "with:", no?
> 

As you have commented below, I don't add this check due to the reason
that "create_snapshot" method does _not_ check this.

> >> diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
> >> index 42c8d4ca1e..da321f16c6 100755
> >> --- a/t/t0602-reffiles-fsck.sh
> >> +++ b/t/t0602-reffiles-fsck.sh
> >> @@ -639,4 +639,29 @@ test_expect_success SYMLINKS 'the filetype of packed-refs should be checked' '
> >>  	)
> >>  '
> >>  
> >> +test_expect_success 'packed-refs header should be checked' '
> >> +	test_when_finished "rm -rf repo" &&
> >> +	git init repo &&
> >> +	(
> >> +		cd repo &&
> >> +		test_commit default &&
> >> +
> >> +		git refs verify 2>err &&
> >> +		test_must_be_empty err &&
> >> +
> >> +		for bad_header in "# pack-refs wit: peeled fully-peeled sorted " \
> >> +				  "# pack-refs with traits: peeled fully-peeled sorted " \
> >> +				  "# pack-refs with a: peeled fully-peeled"
> >
> > Instead of verifying thrice that we complain about bad header prefixes,
> > should we maybe replace two of these with instances where we check a
> > packed-refs file _without_ a header and one with capabilities that we
> > don't understand?
> 
> Yup.  I also notice that refs/packed-backend.c:create_snapshot()
> would accept "# pack-refs with:peeled" if I am not reading it
> correctly, which is an unrelated bug.
> 

Yes, you are correct. Let me fix this in the next version.

Thanks,
Jialuo
