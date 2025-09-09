Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA70322DC2
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 10:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757412928; cv=none; b=a6lnGUXFpxwL7ui2swUhxPcxTNVSXSrcQKj5C7LNcuVotCNg7ZM+DHUka/I54c8WQJzksb+qFSB8dsHmGgvmFifQ95mUQSF+C60OEB+pARBh0x9gmdfcCu3KNDPexxieOq+KY39+j78nhRcIlkTciMSLdtYfuv845Zp06MhAnzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757412928; c=relaxed/simple;
	bh=D6wFP+SawhB6nhdbA+uDjn/c132mcBM0WqNZXJN6HS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TU2fNlZ+WDuUJgHcdA534dSmAj8Dece9MfAZL6Yn+6EcUp5pQTjlSByidu0E7M94kAQJZjaTVCMptlTOGNBbQe2xGnfcggYrdfjEZYjhUEyp6sI8y1Yn4eFr7Ql2utPsQ6Tna7zMVbMNenJO7XLYN4yyzw8qmZRJOgl4RAXHRC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=C+rn2EpU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SjkVxxV6; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="C+rn2EpU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SjkVxxV6"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3D4C4140001D;
	Tue,  9 Sep 2025 06:15:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 09 Sep 2025 06:15:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757412925; x=1757499325; bh=kCARkuPuOr
	0m0+wcvmQNwZdkTXfyfov4KY06w/+dOD0=; b=C+rn2EpUjT/wFFWRfbfJ5E1vsa
	QldV6CJ8uPeeN1spJDCO1I/qrU/vJ+ak27cQaJ8rBhKTOs8bNXySc3XWIkxFibdr
	FcWFPzsa0zNrq4mBymQWdV+aonb0WDczuWi/k1Yi5A0qhDJtK2vg8KHJYjc1LE4D
	D3IWMC8J8FMQ5vRZ6xuxMQ3mdUxnDlp0reCwWXKqs24nO6RtmmHwXOConDk5SLGq
	1cp+kUzY/d3VEVRMhpi/h8Ly0TS8jZ5swHdG6jV8B62GKM4Fo8VXWys4vh4nbF94
	cq2sXmaeM+HmODdkQH/+01hs022O8qQdgOfUNM1ecRFqPRgR+CTZ3aFO+0jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757412925; x=1757499325; bh=kCARkuPuOr0m0+wcvmQNwZdkTXfyfov4KY0
	6w/+dOD0=; b=SjkVxxV6SjfldPi3d1xKfHHuin9Xc+MvEO+idofym6r2RK8E6VE
	dqbpH3XjOrp1hWWii5h8296S7Bj91AJK2S4M4yQfrI8AldQRTqgr9OglOcgREjlm
	Et3bCfgM+G4FXnd9bDWmAg3CtDT1ZlSsevjoQOSNPhimo/oXZuxUhvketYhcTStY
	tmS5iumNQX40kNPAw7wYP25LvHfMv7apW3WZyhdNv/a0O0ufJhImZ8cf3egqIhyj
	0VzQsXz5lly3e43oskI4YGTY26yBMJZ5vE7rd9/fF625H+OTxpOMtsdE84n4D3ZP
	yiEVcqqdxRSXHlQW9p418Wx8CPHbdQoCMsg==
X-ME-Sender: <xms:PP6_aByRPVs9j4w-fOhTEG0474nrTN0uVTWpeDljIzeIVUZDgTDBkg>
    <xme:PP6_aEj542s22EOiPE90UBO8iqZESNYS8f5l9c7725YJdM0eWP-UrBUJDaKh7Ec7S
    OTa04iuJbiX3vadWg>
X-ME-Received: <xmr:PP6_aExXMumPOD8nGwCm_ZJ1D2h4whutEmm85vYbs44s84a5Ef5K4b1-aD65LSWhLkubljiF6ehGDtRY66oiTUWOMK6VazbY9a3bZuzB4_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    fhiefgvdffvddtuefhlefgleehgfefveeuteffudfgheetgfevlefhueeuveeuvdenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhi
    tghhrggvlhdrohhsihhpohhvsehinhhnohhmohhtihgtshdrtghomh
X-ME-Proxy: <xmx:Pf6_aPLuTlGzRS6Ocr_YAG3fsFilLVxJ6dFrjcUJEIRzxb3g7dBU8g>
    <xmx:Pf6_aDSq8racGapgknhGafVYaREhfzE_SzI9R3xc0Er5ytwd9ZQzAQ>
    <xmx:Pf6_aPo5AFj91xypk0M4ntEr-eD4LeByGgmnCvXy-DmJTNoqXiMIPQ>
    <xmx:Pf6_aAoM1k1_59MaLNzQEm8bYtYxIKLEdsFCUy6trusV6BmfdhSMwA>
    <xmx:Pf6_aP0j6fvSXkOjrNriH6c3M4sTjrJCil9i_Qud6ktZ5nGzVgOOI0yq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 06:15:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bc2d339c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 9 Sep 2025 10:15:22 +0000 (UTC)
Date: Tue, 9 Sep 2025 12:15:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "Osipov, Michael (IN IT IN)" <michael.osipov@innomotics.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [Bug] Compat objects not added to CLAR_TEST_PROG
Message-ID: <aL_-My5lxRQiOPmh@pks.im>
References: <d8d4266e-838c-488e-9aaf-4a1be0169795@innomotics.com>
 <20250905213708.GB612697@coredump.intra.peff.net>
 <aL_bAxZubXMOGWsu@pks.im>
 <50da35ac-71f8-49dd-bcd8-83726f1954a9@innomotics.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50da35ac-71f8-49dd-bcd8-83726f1954a9@innomotics.com>

On Tue, Sep 09, 2025 at 10:00:54AM +0200, Osipov, Michael (IN IT IN) wrote:
> On 2025-09-09 09:45, Patrick Steinhardt wrote:
> > diff --git a/clar/sandbox.h b/clar/sandbox.h
> > index ff43159..5af36f3 100644
> > --- a/clar/sandbox.h
> > +++ b/clar/sandbox.h
> > @@ -164,7 +164,7 @@ static int build_tempdir_path(void)
> >   	if (mkdir(_clar_tempdir, 0700) != 0)
> >   		return -1;
> > -#elif defined(__sun) || defined(__TANDEM)
> > +#elif defined(__sun) || defined(__TANDEM) || defined(__HPUX)
> >   	if (mktemp(_clar_tempdir) == NULL)
> >   		return -1;
> > The `__HPUX` define is pulled out of thin air, I have no idea what
> > preprocessor macro that system sets. But something in that spirit may
> > fix that issue. If so, I'm happy to fix this upstream and then pull
> > the latest version into Git.
> 
> I can confirm that your idea works and much better than my idea:
> root@deblndw002x:/var/tmp/ports/work
> # diff -ur git-2.51.0 git-2.51.0.patched/ | grep -v "Only in"
> diff -u -ur git-2.51.0/t/unit-tests/clar/clar/sandbox.h
> git-2.51.0.patched/t/unit-tests/clar/clar/sandbox.h
> --- git-2.51.0/t/unit-tests/clar/clar/sandbox.h 2025-08-18 02:35:38 +0200
> +++ git-2.51.0.patched/t/unit-tests/clar/clar/sandbox.h 2025-09-09 09:50:07
> +0200
> @@ -128,7 +128,7 @@
> 
>         if (mkdir(_clar_path, 0700) != 0)
>                 return -1;
> -#elif defined(__sun) || defined(__TANDEM)
> +#elif defined(__sun) || defined(__TANDEM) || defined(__hpux)
>         if (mktemp(_clar_path) == NULL)
>                 return -1;
> 
> Can you make that happen upstream?

Merged upstream now via [1]. I'll send a patch to the mailing list later
today to bring us to the latest version.

Patrick

[1]: https://github.com/clar-test/clar/pull/120
