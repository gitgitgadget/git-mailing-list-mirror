Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3C017996
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 03:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719978166; cv=none; b=QvzLNniHr2mZLAFp7+RpgX1gGC6aSfFGeVtpiYzZGXCOTRqx5fW0AzO5N2Zz18KMYpUC6AeG1Rs4f9KbkIslmanSkkDr+aYw5ue55yeq1YR0UpIsj/E+YaDr91FEADL++5qEQJlXvjurB0auB4klO1FiLI519isG5djGTQvYUTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719978166; c=relaxed/simple;
	bh=ynUHYJOWSVoOhN80tNrOzX5Puf6c0JsbL1FgcY7VTMM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=MUSxhJCz09Ziwb/sIH9Dm6OKju4wcCKa7ty+4/j/S1GJ5Zb9zLltO1AwJpiQjZguRWCeRltFoH6XXGMWioDHedYUE3USEMSQrMnwoKSNXbcFNYaL4zgIBxE8f+xwrLrIaM+dgpmeqckziej8X9VuEXDPScZ8giQnP1RhQFpdqkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SnPnQ8ij; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnPnQ8ij"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70abb539f41so2636071b3a.2
        for <git@vger.kernel.org>; Tue, 02 Jul 2024 20:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719978164; x=1720582964; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIyXR3bzfLT7moeDV4WOX17o/Qi//QPxJinzvlzzAvU=;
        b=SnPnQ8ijbvxD14Vh/5aNQMYrVvBRaYUpLI6fw3IA1yvLFxFpgBywOemptvw5cZJoUl
         bEmVdZdH3M3hBmbH5ivDHy4i+8PvezW38n9uFbSN3IlReps+BUoes2TWmIcSWuziWEno
         00q7m8JcTMnTNjFKu4APE5S8tiODqyDDqUa7aoR08oGtW+T4goYCU7Vk2HZUhh56XYz3
         JsPtoSTflcOltOB3N/6VWFheZ/rn+6VWJkMmW6Cha73BlFwTLhiXitcW49+w+GBzngl4
         b6mTTh3S9Zoel8s1LlyzD4IxxsSrvhtiqYlgZRJcfiHxW0SvBvBaP5ygcFDjPDk+orYE
         Sdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719978164; x=1720582964;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CIyXR3bzfLT7moeDV4WOX17o/Qi//QPxJinzvlzzAvU=;
        b=EjyatfcN4OuCqfpTzY4IBaAhilkQ80/UqZkNRUBpwsZMmm+hvEdMhbJQZS3/bUnvVI
         nV2I74o/SnnyBhCLppajG+rWx+RtqILmWtfUT0QZBIcuZidUTIb2Gi+ObjXVEkKzNTLd
         C80jcJ1YHWE/W7EezD647YuOF/QTDWBKCm4OPBSjKkoWVUGjXK/k62pf3zgk/JRW2f3I
         bhaurKiP9mP9+Pi+Mt4yX7GfMGlflX/go1sU4XgoeYWv3BW2a+CTTnKl1NTsBcABmd1q
         J4QYimPJUbG/zRTwUPLBO0xXRiACJ7hvd7+DCYoGquvdmdglGjusKfzQl+vSembEpUME
         1U4A==
X-Forwarded-Encrypted: i=1; AJvYcCWLEbwa0a3VCDEV/kSqw/gcT4KSJ6pjDhPxQF+M7u0FmCIwiaVedJMllzPSDpNA8Hvnde1IUu3FnEbobE7xrRB0ZDx8
X-Gm-Message-State: AOJu0YwHFKjOrpI1LcaOfzPqzy1UYA084NBBn6DpLPYC0+zsqulc/1IM
	zmPKSOFLfAC2D6X13xDxcSJTl8XVj/yQvW4VzWWijdRx6X/aN7YfF4jXsfJT
X-Google-Smtp-Source: AGHT+IE3iFqN4rS+Wx3UxxFtvuV6naytMd13g7AMCqIlwgnCXSIQVRIjgwd6Q0Bfm7grxfjfLKRqZA==
X-Received: by 2002:a05:6a00:1801:b0:706:68fc:8299 with SMTP id d2e1a72fcca58-70aaaf08daamr13164356b3a.27.1719978164188;
        Tue, 02 Jul 2024 20:42:44 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:b1ca:de8:cd9e:bf98])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70804a97ae3sm9337272b3a.206.2024.07.02.20.42.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 20:42:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Jul 2024 09:12:39 +0530
Message-Id: <D2FLDECC9DTC.3KYX81M4JKOAR@gmail.com>
Cc: "Phillip Wood" <phillip.wood123@gmail.com>
Subject: Re: [PATCH 6/6] t-strbuf: use TEST_RUN
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, "Josh Steadmon"
 <steadmon@google.com>, "Git List" <git@vger.kernel.org>, "Phillip Wood"
 <phillip.wood@dunelm.org.uk>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <1bf053ae-957e-4e9a-90f0-11cc76848ce9@web.de>
 <bh5ectgtwdaeltflggzwnwhobewvcqqelforr4sfcmq47rnnrl@mzspptlhpofx>
 <D2F8BS39IFC4.WJ9TNK3IDFBV@gmail.com>
 <c690e0ad-21e1-4b51-b594-70f4b2527df8@web.de>
In-Reply-To: <c690e0ad-21e1-4b51-b594-70f4b2527df8@web.de>

Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> Am 02.07.24 um 19:29 schrieb Ghanshyam Thakkar:
> > Josh Steadmon <steadmon@google.com> wrote:
> >>> -	TEST(setup(t_addch, "a"), "strbuf_addch adds char");
> >>> -	TEST(setup(t_addch, ""), "strbuf_addch adds NUL char");
> >>> -	TEST(setup_populated(t_addch, "initial value", "a"),
> >>> -	     "strbuf_addch appends to initial value");
> >>> -	TEST(setup(t_addstr, "hello there"), "strbuf_addstr adds string");
> >>> -	TEST(setup_populated(t_addstr, "initial value", "hello there"),
> >>> -	     "strbuf_addstr appends string to initial value");
> >>> +
> >>> +	if (TEST_RUN("strbuf_addch adds char")) {
> >>> +		struct strbuf sb =3D STRBUF_INIT;
> >>> +		t_addch(&sb, 'a');
> >>> +		t_release(&sb);
> >>> +	}
> >>> +
> >>> +	if (TEST_RUN("strbuf_addch adds NUL char")) {
> >>> +		struct strbuf sb =3D STRBUF_INIT;
> >>> +		t_addch(&sb, '\0');
> >>> +		t_release(&sb);
> >>> +	}
> >>> +
> >>> +	if (TEST_RUN("strbuf_addch appends to initial value")) {
> >>> +		struct strbuf sb =3D STRBUF_INIT;
> >>> +		t_addstr(&sb, "initial value");
> >>> +		t_addch(&sb, 'a');
> >>> +		t_release(&sb);
> >>> +	}
> >>> +
> >>> +	if (TEST_RUN("strbuf_addstr adds string")) {
> >>> +		struct strbuf sb =3D STRBUF_INIT;
> >>> +		t_addstr(&sb, "hello there");
> >>> +		t_release(&sb);
> >>> +	}
> >>> +
> >>> +	if (TEST_RUN("strbuf_addstr appends string to initial value")) {
> >>> +		struct strbuf sb =3D STRBUF_INIT;
> >>> +		t_addstr(&sb, "initial value");
> >>> +		t_addstr(&sb, "hello there");
> >>> +		t_release(&sb);
> >>> +	}
> >>>
> >>>  	return test_done();
> >>>  }
> >>> --
> >>> 2.45.2
> >>
> >> I think this commit in particular shows how TEST_RUN() is more
> >> convenient than TEST(). (Although, arguably we shouldn't have allowed
> >> the setup() + callback situation to start with.)
> >
> > Could you expand a bit on why the setup() + callback thing shouldn't be
> > allowed? I think it is a nice way of avoiding boilerplate and having
> > independent state. And, I see the true potential of TEST_RUN() in
> > testcases defined through macros rather than replacing functions. I
> > actually think that the previous version with the functions was not
> > particularly bad, and I agree with Phillip that the previous version's
> > main() provided nice overview of the tests and it was easier to
> > verify the independence between each testcase.
>
> Each test uses its own strbuf and the t_ functions don't use global or
> static variables, so how does the doubt about their independence creep
> in?

Ah, apologies. I should clarify that I meant in general terms about the
future uses of TEST_RUN() and not about this particular patch. But I see
it being less of a problem now that I think about it more. And for the
record, I see no problems in this patch. But on a side note, with what
Phillip was suggesting to remove having TEST_RUN() inside if(), it
would definitely make verifying state independence more harder.

<snip>
> > But, I also don't mind if patches 4, 5, or 6 get
> > merged as I don't see any difference between using TEST_RUN() or
> > TEST() in those patches, besides moving everything inside main().
>
> The difference is that in the original version test description and
> definition are separated, only linked by a function name. The new
> version brings them together and does away with function name. A small
> change, for sure, just to get rid of the artificial divide and the need
> for that link.

Yeah, but I didn't mind that divide (and I don't mind bringing them
together either). :)

Thanks.
