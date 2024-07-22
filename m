Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7768116A38B
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 12:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721652888; cv=none; b=mHt0q/vrb73mNA9BET7XsYJsL5/XqFp6UZJsbmqr/XXTkNPtAclCrEiwTOS5ZvSuCEwVYcjR79n9j5o9yQrPkG1iMugd2jd8o/YkpIGzivfxaXHDUprIhJFUArn2N1Lpk7TFBPiRPp1brRQU75n1iHG646n55ZpTTS66GNBy+dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721652888; c=relaxed/simple;
	bh=7b/zjmW5ofgvM35buLpQqaTMKMbn80wj3pKICvaLBgo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=i+OE657w45vGZcqMlCd0ZfrT/zK1YolkXg/jltrb8ahtlK+KFampkqQrEh4PxLxO54kFAkHVAiEzqVYHbvrNSPWY5ldLa4LgwnA6zE7TDECeso1S6LSAABTPQmrXNrCUXL4nYR9SDpSGMPZLyIN9y2TMkO9FmmvH6OAXMqcNkyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnsnOJqd; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnsnOJqd"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fc569440e1so34114525ad.3
        for <git@vger.kernel.org>; Mon, 22 Jul 2024 05:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721652887; x=1722257687; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/yHYRnH1n/xlioOKW67whMY3Lp3VzP6Wrx4517dTIsk=;
        b=UnsnOJqdMxHmZZKEhAiBn525vCTnIkHmY2cubGlQi1ihd6mGZ8U57TDl++zkjdylUd
         7qh3pgukXVcEPYI8gzLhX98blmiPrs25Bvy6GFm3TjTcYrrSakQiOkRRBeh/dEO6ltcB
         DQdyTIp6PNeHR+GoXzdfJKnuve6dEllIF51NAtuw9IfXS23eXGmw4M3pSyln39WhnVEf
         pPN8x2fb3ipEM/63tpLBYXcAsnZ9U3VBd6wNCenyyCPlm5lLNktAiwJEQR6XUkAkpP4U
         zOb9LXom+xL8KpDwM0/DVWVQpk9id33wXGAlGYq+ZXHzYoptydLedf4fFBT37wCF6Ukx
         bEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721652887; x=1722257687;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/yHYRnH1n/xlioOKW67whMY3Lp3VzP6Wrx4517dTIsk=;
        b=tJj3aMm0aJlkZg8a5m2u4eZdXYamWF/clzITfsOT1Y4pBG63sNxUPI+/yzbv2EAcL/
         ii7PPkPR5nL0VJEe7XfkeQglDNlRS7D7BpY/rg6bKWNf1pGYBcRjrRRzcrjjqyzrNrDD
         PFN3SPyGl6HXfjjtIlaL/JR27UUSE2VYTHWWmcSqELkhmD4JG24LMyULW+XtgNTNAjwk
         O1XHxXht/zW101RxxoQq1MjsbIcLBTQC6npjkz85FM2o3JKs3/gakmXFuc92LTNPBGxX
         ZALw+WjgZ8mlyN30Uc4Vjpi2hFCkw1RSeJTn9Z2EqGEyzZWadJT56ZtOYyx4mrK6PblU
         mpAA==
X-Forwarded-Encrypted: i=1; AJvYcCULaMT9enaQWLZoUPdvzDhP4NeWQ9eUuZ614DNL4f3vZlYF+3vMnqKGUrlHyKNXlJmodR561+7sG2Z9BcoAdZw7O/3K
X-Gm-Message-State: AOJu0YxfMyGaWdInjqUGpINLvk/xuJtWXZEv+6vn7gD/RukJOKZQ8tD2
	jiHaSpJkQ6wp2LGmaJj95fGkn7R3Y+bBpceOa9vdC6ljSouaH06P
X-Google-Smtp-Source: AGHT+IHbOsLfxp/rw1hCopFSnt1yDNG2HVEeMEiH0ZsobkX4slXKolNhaqSq+X1KGXpiNmb/OHnCXA==
X-Received: by 2002:a17:902:e548:b0:1fd:88d2:4804 with SMTP id d9443c01a7336-1fd88d24a9emr55254115ad.34.1721652886556;
        Mon, 22 Jul 2024 05:54:46 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:f2ea:632f:a3b5:7795])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f25ac9esm53605645ad.20.2024.07.22.05.54.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 05:54:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Jul 2024 18:24:41 +0530
Message-Id: <D2W30F19QN7J.146CV16OMTO6M@gmail.com>
Cc: "Christian Couder" <christian.couder@gmail.com>, "Phillip Wood"
 <phillip.wood123@gmail.com>, "Christian Couder" <chriscool@tuxfamily.org>,
 "Kaartic Sivaraam" <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC][PATCH] t: migrate helper/test-urlmatch-normalization to
 unit tests
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: "Karthik Nayak" <karthik.188@gmail.com>, <git@vger.kernel.org>
References: <20240628125632.45603-1-shyamthakkar001@gmail.com>
 <CAOLa=ZQ8fuCksk+CGP2thMqKnT_KME4goLwEt6hKYvt+Gbn5tw@mail.gmail.com>
In-Reply-To: <CAOLa=ZQ8fuCksk+CGP2thMqKnT_KME4goLwEt6hKYvt+Gbn5tw@mail.gmail.com>

Karthik Nayak <karthik.188@gmail.com> wrote:
> Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:
>
> [snip]
>
> > +static void compare_normalized_urls(const char *url1, const char *url2=
,
> > +				    size_t equal)
> [ 5 more citation lines. Click/Enter to show. ]
> > +{
> > +	char *url1_norm =3D url_normalize(url1, NULL);
> > +	char *url2_norm =3D url_normalize(url2, NULL);
> > +
> > +	if (equal) {
> > +		if (!check_str(url1_norm, url2_norm))
> > +			test_msg("input url1: %s\n  input url2: %s", url1,
> > +				 url2);
>
> check_str() checks and prints the values if they don't match, so here
> since the normalized urls will be printed by check_str(), we print the
> input urls. Makes sense.
>
> > +	} else if (!check_int(strcmp(url1_norm, url2_norm), !=3D, 0))
> > +		test_msg(" url1_norm: %s\n   url2_norm: %s\n"
> > +			 "  input url1: %s\n  input url2: %s",
> > +			 url1_norm, url2_norm, url1, url2);
>
> Here we use strcmp and hence, it won't print the normalized urls, so we
> also print them. This is because we want to make sure they are not
> equal.
>
> I don't understand why there is inconsistent spacing in this message
> though.

That is for alignment purposes, so the ':' matches vertically between
them. I.e.

#  url1_norm: https://@x.y/%5E
   url2_norm: https://x.y/%5E
  input url1: https://@x.y/^
  input url2: httpS://x.y:443/^
 =20
Thanks.

> Apart from this small question, the patch looks great!
>
> Thanks

