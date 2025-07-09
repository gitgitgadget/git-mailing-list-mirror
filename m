Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22641237713
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 10:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057678; cv=none; b=jqsgqKnLtQCa4nGpjgbLYNgfElZLLZ2cgZhmCGwCWPy6SzgCeleCBtkxq/eLbgb1fSo3/SXHQdd7YajPQawb4Vv3m2/zj/BSCjNNAaKPhEY0k0j2ydFvuzwQ3GAWor+uoRHiv1Edl5ElmheXp9xfkW7Xrcrzj7fUknIlx1cBnxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057678; c=relaxed/simple;
	bh=daIlC5NJ8Pp+B+T/6yrpTaPjgZij84yQlGU0l5fR29M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZKKBv5XeqRl0rjoYqylC6iD5qvBM18AcH5pmhKo0J0IIbItmkwmJC6mvT56uG6SnKmLgGtHpvgYFgYsDLaBqEg8Pu25tITiyDLKzIq5JycaywFQt2LC8jNwVPIYwFN38BMWiZQy4QhMTCPvKH/M4FkJe868SU3NXLfJN9cCyis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0MdnOUL; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0MdnOUL"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-74ce477af25so3278053b3a.3
        for <git@vger.kernel.org>; Wed, 09 Jul 2025 03:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752057676; x=1752662476; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KVgoTehqznH1Mf+y6CGrKgp081qg1XVPP1pkX//UpQQ=;
        b=f0MdnOULokDEq4ppUOtMuIL6h1J8jLC3E9o+lBG5WmomTgwL6MfYeOVldba8ADUEZh
         jFAKN1xszxjqhdPoWY61xiRkVzByprRwv48g9QZ6v8SkyoOforUq8psmV6oRjaF0lFbA
         nqXvzxn97WA8iKYGI9n7BQ3TyX+GV8jHExDpLTUIroOc0b1dZqlrglw+CafeliAVSsug
         VFNdSTPCKB385VR/VKrvuKtcAqqHi6+/AJM6g8TThCICqmYDY1/UWmD/Z0mH0BteJWYw
         PWfzxrjuMIslBClwnVauKVyBAtWsTg306ZXq3vCAP3FQQz7bVMC/mDFIR2+1DOvc0rE3
         STWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752057676; x=1752662476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVgoTehqznH1Mf+y6CGrKgp081qg1XVPP1pkX//UpQQ=;
        b=kwCBYgWI3gyLWGd9SzEs0MLAgV6C9ZW3K033BWg+bFxtw/raWDvPauQaSiFFX3xv8z
         W80f5PX0nOyEgzmRH4YXXrVRYYBtVIUKNVtUf9hDmXd65rfanI9/nZJG0z5fMvQYpadS
         lXIguukQLZakJow7FpyByxozNANht4PeO8KnPvbLvtOoPLMJXdYRt9NhVAO+tx2z2xUq
         ywTiZcQ8oFTskMwK2IDj3J97UzRsS/J2gNxD3oDufpoXvKo4WxEZMeFtI3x/tc/nnzYP
         PumYbQGee/BcfVctTtXKiYJsfY69NputQTMxstk9iCpp8G3maCE+mBWSu+8sJ86EmGHx
         4yyQ==
X-Gm-Message-State: AOJu0YxTHgoxhl3HrTmZq5YCx9nGUfuseclUL8hiaUZb6+F6yAGpEYY/
	2hfsmPAy++rEN+I+cAjRQV+S77XdGRJLSDBCAw1katVw9lk4AppmZzGs
X-Gm-Gg: ASbGncteyrB95R9XwmsMA+SgMCruk3DjoflpMhx0zmtWkyH/nB33YIr1hToMxENXsxR
	A9zsceP60xuLuWDHKEPtee6p5n43bd86L9LwPa8lwi1ic1RMhHmqR0KniojBuz4Mj0NbuB+PrhE
	k4xHt7g9ezxEun9ijthO/dMn2alD7fJ2roSHxUg1GA5stEeQ3afTxnC0FCOHLkgQX1HtatSREcr
	UbBAwHxoBnB1krG1M6wzYypvPrHD4/1jXR4YTUedqcevKUQcNKE2ZCJzOyUKEzmGW7p1H0Jh4WI
	YA5J+sXzRq+AqVSKGiHZtyNHhtA+xWONCTxoOncxt+gMGX1Gp4rnwDc9mkHZMYK80vni/7EED1N
	niPzN/Uqp++ohov2/KAV8ITY=
X-Google-Smtp-Source: AGHT+IGuMDw0y8QzRyUgUrWYZxNFKHz+YG9Wyi1Z1/TpFHet90EBQpAjoTGoMahUfy0f9TufhjkwxQ==
X-Received: by 2002:a05:6a20:a11d:b0:1f5:6c7b:8920 with SMTP id adf61e73a8af0-22cd68be3f4mr3238510637.9.1752057676153;
        Wed, 09 Jul 2025 03:41:16 -0700 (PDT)
Received: from Carlos-MacBook-Pro-2.local ([2601:640:8e80:3680:ed82:7a2e:d82d:94a6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee62dd54sm12539194a12.52.2025.07.09.03.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 03:41:15 -0700 (PDT)
Date: Wed, 9 Jul 2025 03:41:13 -0700
From: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, j6t@kdbg.org, phillip.wood123@gmail.com
Subject: Re: What's cooking in git.git (Jul 2025, #02; Mon, 7)
Message-ID: <vl7ahhcqgci3xemqhtdugdhar24ewl7mu4wqwxnc3jag5blpoo@l7b24mahadyi>
References: <xmqqplebzgm7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqplebzgm7.fsf@gitster.g>

On Mon, Jul 07, 2025 at 05:11:12PM -0800, Junio C Hamano wrote:
> 
> * cb/daemon-reap-children (2025-06-26) 4 commits
>  - daemon: explicitly allow EINTR during poll()
>  - daemon: use sigaction() to install child_handler()
>  - compat/mingw: allow sigaction(SIGCHLD)
>  - compat/posix.h: track SA_RESTART fallback
> 
>  Futz with SIGCHLD handling in "git daemon".
> 
>  Stalled?
>  cf. <dba9ae0d-1e43-4345-a7ec-b57a07d45a07@gmail.com>
>  source: <pull.2002.v3.git.git.1750927988.gitgitgadget@gmail.com>

I don't think so, but definitely missing reviews (specially for patch 2)
and slightly controversial.

I wasn't planning any further changes, and while I have some for the
"related" patchset which enhances the notifications by using a self pipe
was holding them (as well as the related feedback) to allow for this to
mature on its own.

On the rationale on why this is independently useful, note that we are
currently relying in at least 2 "unspecified" behaviours:

1) using signal() means that it is implementation defined if SA_RESTART
will be enabled or not for that signal, and
2) if SA_RESTART is enabled, it is implementation defined if we might get
interrupted in poll().

both are resolved by using sigaction() instead, and it is up to us to
decide if SA_RESTART is enabled or not (which might make patch 4 obsolete
if we decide against).

Carlo

CC: Johannes Sixt on feedback for SIGCHLD in mingw which uses 17 instead
    of 22 (cygwin and others) and therefore seem to cause signal to err
    without setting errno as it should.
