Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDB1F9F7
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 01:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711501493; cv=none; b=PWV3UH4TFOvLoi53R+w4WoFX5pK7GZmL/aV8MvMwNUgp1Jr4R0gv/+HCb9OQSGPge4Xm6hILOCw3J+DTAUq7/EEEfNXKbot936wy3VR29ZXGaPeby6+uDVNJ67jPGs3D1h75KlYCdxlsbIsFDkMTZv6e586rQ+C8Dvd+s8Vw8hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711501493; c=relaxed/simple;
	bh=2RUKKAMXYwLb9S7SbMb/Ui5PSP2G5qpIA/vbM+gj7Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfGaXXK9RI6yQlCh4FT982GKQy2pUMSJEQEmIyvW+QF61zFNyuJzjc1o39B6ERtib3S3lzQsfQ4Z1quTSAB8nGoJX0fV3tQ8ADprFpdqmL1zTTRCWSPfiRHtZcl2sImb2aHJdo94QfC926wCee1qN/D80n7xxyXX8pPgszWFUkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H0jWMhtm; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H0jWMhtm"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e8f51d0bf0so4956298b3a.3
        for <git@vger.kernel.org>; Tue, 26 Mar 2024 18:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711501491; x=1712106291; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5URJBPHmfm6A9ij5ZYD9olAISa+qlkZiOFNRXEkBX7c=;
        b=H0jWMhtmKbsbOzrbz9uM5gdpv3+zWVYBrTvw9vazNFHFp+oY7ZoJ8JIzREv9IVvWhf
         5ttrrTcKiNR93XNs86/+g+QDd1H2sOX/YgnnYY4pKC7CIYzFDxWP80obrHCzkaO1iSa6
         AwxKO6XavrXtrPdbRpgftfVO6dILTo1TvxvVYOhcGIUPeGS9dgA2VJdjwqPlN3Umn0dw
         x0+j7//Oh8U+1+22+SKEaOF3yb2YYhJNDw2ODyyJKd/pRXY2+MPsOqpcDjHuClgYOwUO
         py+dLRoeRSGlOwkgO+2Cz5E570Ht/3JGeMBkAkfhlB/5IxxKOD1Ne+A3aV63isqKnjfW
         0PNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711501491; x=1712106291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5URJBPHmfm6A9ij5ZYD9olAISa+qlkZiOFNRXEkBX7c=;
        b=HXYnfY8WzpjDn/ORIJgj7btJmwt9DxGEQRoqgNeSb0LgLOQsDT5E4KImXTwshxjjYk
         vwBbP9tpITEohp+hfe5yL2QRWXtncWSEtAlj5nNc9feWmsW0ZdOjOM13AHz0Nucp2WXX
         AA/377y+j1ugJyjZ7ztIzc8uMHncowCOhHvXlxTEHRjN9A1HQ3yA8WsC2n8gyI/w4qRV
         397mvPrLBFnbfoA0gq6EtO+EkcR0+uVR/J1KQdbB3kLXCrVw1tpUoLBDNXb7AIp1if5P
         oLWeI1FRI/hDRjimzv3Q+Tix6G3CYgmap/sgerOW41eTJVCMUT28bQrQPUeuSCwIHIMu
         nFLA==
X-Gm-Message-State: AOJu0YzYE0g5ChyLgpK418zKS6TGhTfqOK+ylOCQJVrfd6qbq36kLrIr
	Y0w9bRGlUK3f/+QlgBNEJFhNU1n3WrwgO648DNP9Xra5VwyO9qasIPAZyYPwTg==
X-Google-Smtp-Source: AGHT+IFfcRN1r9DL6xw7mEEaxmMLU9xWho+jOMWXYSSdsJh0DZ1VXBElVU1o929IICEoIQMOB/MJVA==
X-Received: by 2002:a05:6a00:1482:b0:6ea:acbe:5188 with SMTP id v2-20020a056a00148200b006eaacbe5188mr4681808pfu.32.1711501490697;
        Tue, 26 Mar 2024 18:04:50 -0700 (PDT)
Received: from google.com (144.44.83.34.bc.googleusercontent.com. [34.83.44.144])
        by smtp.gmail.com with ESMTPSA id t9-20020a056a00138900b006eaba4ef1a3sm2044059pfg.64.2024.03.26.18.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 18:04:43 -0700 (PDT)
Date: Tue, 26 Mar 2024 18:04:39 -0700
From: Kyle Lippincott <spectral@google.com>
To: Dirk Gouders <dirk@gouders.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v4 0/5] Fixes for Documentation/MyFirstObjectWalk.txt
Message-ID: <ezbbu7ibxxrzogb4w46qvqgtwowtaf7e5o5y5dcb53gq7ko33c@g6eror27glzn>
References: <cover.1711368498.git.dirk@gouders.net>
 <20240326130902.7111-1-dirk@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326130902.7111-1-dirk@gouders.net>

On Tue, Mar 26, 2024 at 02:08:35PM +0100, Dirk Gouders wrote:
> The 4th round of this series.
> 
> Chances are that I just waste your time with my attemt [4/5].
> My appologies in advance, should this be the case.
> 
> Recently, there was a discussion [1] on the groff mailing list and I
> guess I couldn't resist to try to practice what I read in the linked
> resources ;-)
> 
> [1] https://lists.gnu.org/archive/html/groff/2024-03/msg00014.html
> 
> Could be that the remaining controversal part of [4/5] should just be
> left untouched, because it is consuming so much time -- I summarized
> all those versions, so that all incarnations can be compared in one
> view:
> 
> * Original:
> 
> Asking `traverse_commit_list_filtered()` to populate the `omitted`
> list means that our object walk does not perform any better than an
> unfiltered object walk; all reachable objects are walked in order to
> populate the list.
> 
> * v3:
> 
> Note that this means that our object walk will not perform any better
> than an unfiltered object walk; all reachable objects are walked in
> order to populate the list.
> 
> * Junio's suggestion (with minor rearrangement):
> 
> Note that our object walk with this function will not perform any
> better than the previous unfiltered walk, because all reachable
> objects need to be walked in order to populate the list of filtered
> objects.
> 
> * Kyle's suggestion:
> 
> Note that requesting the list of filtered objects may have performance
> implications; all reachable objects will be visited in order to
> populate the list of filtered objects.
> 
> * My new attempt (v4):
> 
> This list of filtered objects may have performance implications,
> however, because despite filtering objects, the possibly much larger
> set of all reachable objects must be processed in order to populate
> that list.

I agree with the issues Junio raised on this phrasing, and trust in Junio's
judgement to get to a clear phrasing :) I'll be unresponsive to email for at
least the next two weeks, so please don't block awaiting my response on any
future rerolls.

> 
> --
> Changes in v4:
> * Used the proper `git show` for references in [1/5] and [3/5]
> * Another attempt to write clear speach in [4/5]
> 
> Changes in v3:
> * Reword the description in [4/5]
> * Add a missing slash in [5/5]
> 
> Changes in v2:
> * Added Emily to Cc in the hope for a review
> * Remove superfluous tags from [1/5] and [3/5]
> * Replace bashism `|&` by `2>&1 |` in [5/5]
> --
> Dirk Gouders (5):
>   MyFirstObjectWalk: use additional arg in config_fn_t
>   MyFirstObjectWalk: fix misspelled "builtins/"
>   MyFirstObjectWalk: fix filtered object walk
>   MyFirstObjectWalk: fix description for counting omitted objects
>   MyFirstObjectWalk: add stderr to pipe processing
> 
>  Documentation/MyFirstObjectWalk.txt | 37 ++++++++++++++++-------------
>  1 file changed, 21 insertions(+), 16 deletions(-)
> 
> Range-diff against v3:
> 1:  0eeb4b78ac ! 1:  102cbc54c4 MyFirstObjectWalk: use additional arg in config_fn_t
>     @@ Metadata
>       ## Commit message ##
>          MyFirstObjectWalk: use additional arg in config_fn_t
>      
>     -    Commit a4e7e317 (config: add ctx arg to config_fn_t) added a fourth
>     -    argument to config_fn_t but did not change relevant function calls
>     -    in Documentation/MyFirstObjectWalk.txt.
>     +    Commit a4e7e317f8 (config: add ctx arg to config_fn_t, 2023-06-28)
>     +    added a fourth argument to config_fn_t but did not change relevant
>     +    function calls in Documentation/MyFirstObjectWalk.txt.
>      
>          Fix those calls and the example git_walken_config() to use
>          that additional argument.
> 2:  3122ae2472 = 2:  5fb7953f31 MyFirstObjectWalk: fix misspelled "builtins/"
> 3:  f21348ab80 ! 3:  b88518df0b MyFirstObjectWalk: fix filtered object walk
>     @@ Metadata
>       ## Commit message ##
>          MyFirstObjectWalk: fix filtered object walk
>      
>     -    Commit f0d2f849 (MyFirstObjectWalk: update recommended usage)
>     -    changed a call of parse_list_objects_filter() in a way that
>     -    probably never worked: parse_list_objects_filter() always needed a
>     -    pointer as its first argument.
>     +    Commit f0d2f84919 (MyFirstObjectWalk: update recommended usage,
>     +    2022-03-09) changed a call of parse_list_objects_filter() in a way
>     +    that probably never worked: parse_list_objects_filter() always needed
>     +    a pointer as its first argument.
>      
>          Fix this by removing the CALLOC_ARRAY and passing the address of
>          rev->filter to parse_list_objects_filter() in accordance to
> 4:  cfa4b9ce50 ! 4:  11510630af MyFirstObjectWalk: fix description for counting omitted objects
>     @@ Documentation/MyFirstObjectWalk.txt: points to the same tree object as its grand
>      -reachable objects are walked in order to populate the list.
>      +filter, like with `git log --filter=<spec> --filter-print-omitted`. To do this,
>      +change `traverse_commit_list()` to `traverse_commit_list_filtered()`, which is
>     -+able to populate an `omitted` list. Note that this means that our object walk
>     -+will not perform any better than an unfiltered object walk; all reachable
>     -+objects are walked in order to populate the list.
>     ++able to populate an `omitted` list.  This list of filtered objects may have
>     ++performance implications, however, because despite filtering objects, the possibly
>     ++much larger set of all reachable objects must be processed in order to
>     ++populate that list.
>       
>       First, add the `struct oidset` and related items we will use to iterate it:
>       
> 5:  c571abb49d = 5:  8920313ee2 MyFirstObjectWalk: add stderr to pipe processing
> -- 
> 2.43.0
> 
