Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C2D1D516C
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 13:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729000607; cv=none; b=DpYan7ZxHFnUZqVXqPx6y+M4JtgDxx9WypjnkJSaT/z/QIV5S9rWP/Tn/0R510oTt9UpJZKBlbWG6XHNFXqLMO/81W5SYvAoYeFZMpqyIa41PikliaPpdKnItCAd5sRzdpmQv0NRVxWXXARxeX2LvVgYs4VGksEB+rVukUqAbKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729000607; c=relaxed/simple;
	bh=bw07uYBdh3IK2j55pnOyGJ+T1rEobqZdkScVZNFnHhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8pOFC8MAdhM2GjFT3mDHJnmPlVo0ssnay1wMA5l5sDxjGt+gPL2LfwbywZ3ETbOmnQjCXF+sxKYY4E893w9sHpSU+dqi6gJ2Rw0Gp0msC+9rDf6iSkM2NWtI74eXzLyta6NrDT+CLb7LfAHWyWxVLmJhxveuI5l6cOsLkhyX2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=jXIaCY2L; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="jXIaCY2L"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e290554afb4so5108876276.0
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 06:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729000604; x=1729605404; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bw07uYBdh3IK2j55pnOyGJ+T1rEobqZdkScVZNFnHhQ=;
        b=jXIaCY2LSl+bZDX7yBhTYs2wcq1putWosoJyaFb+NJBIAA60OLUSYsmw4Man73xBpK
         BHEssJ2zbSDWWiUqnUldAp9K+rulEZcEgsdFxB1K97+6SroyeTv3kta8SXGJpE16720X
         mJj0TOZl2+ro6mB/iIiXfL7QHKlJOpbfrTDo334Kqok3OoFhk/RjAQmn6P8FPGxr5o0J
         ssLejyqSptihX9Qlx+vpYzOxL29d+3Av1rEu3El1QCLNRdmDmasIQeU/WcpnKAgPkE8t
         iGH0H2f9WWzYynZeujQzLfQMaT1wMGUtiKPDA4h+NpFXtiOUY3If5aZPGrNObHnRELr0
         ln7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729000604; x=1729605404;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bw07uYBdh3IK2j55pnOyGJ+T1rEobqZdkScVZNFnHhQ=;
        b=ZNHj10LOMWJcadPMR7Jn2Sxrahmt+BefG9hgyB9YlA9LJE2mhIP/UMzQ7Om5cw4Zlb
         v/MHML4YN7Rih5MQcK+n+nSWsaGF0hmL6fF4J79SQyTPjRifimEBJUUbrxQjZFyLNBXa
         JPsm5MD+J9R1Vj7PpY0a8kWEINTErfV4BO35wczADl2W+qjvVX1vVoQUQmX/R55RfGdP
         7nBpP3ggMQAnS2vfPAoGAz/+LrYl4UJJRZcnFqm2u23N8Y1Odn0y/av9cSkrbr/oawuM
         L9r5/52en5oDgtonlj3kFnnPmSoaudMdRPJUACH6Mj+U2sdMvw5rAxBKKhDO39exclz/
         bshQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbaAwc10UJZUDrDSUmzFT/jnQ58zWExeOoSUvv/Urtsp+OsBQLIHiPCVYTn4Tpd9IvYBk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwl9NGzgmW0Qpoh5B9HwWvSWyQQXAl2CFkW8miQGrsj5VGUw0l
	eS90SiOrxNz5IPmHmIXFDwvoufYkqfdznJYkHHBjyn4+74xLf5gs00c1HzRV5Z/Q7BYnvYPUEM2
	+
X-Google-Smtp-Source: AGHT+IFDxLKgQDHM+KoW9skTcMn3wWSc4ESnOSny65ecktKO5Z8Xj3bo0NX+a8T6TPlCspGrq7Gp9g==
X-Received: by 2002:a05:6902:c0b:b0:e29:1768:8c2e with SMTP id 3f1490d57ef6-e2919ffa305mr13316992276.49.1729000603818;
        Tue, 15 Oct 2024 06:56:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e296cbfafc1sm238783276.8.2024.10.15.06.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 06:56:43 -0700 (PDT)
Date: Tue, 15 Oct 2024 09:56:41 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Luca Milanesio <luca.milanesio@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Martin Fick <mfick@nvidia.com>
Subject: Re: Should object repacking only update server-info for packs
 instead of doing it for refs?
Message-ID: <Zw50mSKuyvlMDTAQ@nand.local>
References: <LV8PR12MB9407CB282D1FD4998C659D29C2442@LV8PR12MB9407.namprd12.prod.outlook.com>
 <569E3AEA-AC68-4186-B38C-2E47DAB9890E@gmail.com>
 <Zw2MVqi0FLcMuR8Z@nand.local>
 <Zw5LwB2ap1QnmG6L@pks.im>
 <428B24FB-A648-43BA-9381-1B46D99E2F37@gmail.com>
 <Zw5cvnkBQ1MzIS79@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zw5cvnkBQ1MzIS79@pks.im>

On Tue, Oct 15, 2024 at 02:14:59PM +0200, Patrick Steinhardt wrote:
> > >> I think it's reasonable to skip this step when repacking, but of course
> > >> we would still want to update info/packs (assuming that the repack
> > >> wasn't a noop, of course).
> > >
> > > It certainly may be reasonable. But in my opinion, it would be even more
> > > reasonable to not use the dumb HTTP transport at all. If you don't there
> > > is no reason to run git-update-server-info(1) in the first place, so
> > > you'd neither generate info/refs nor info/packs.
> >
> > I don’t believe anyone uses it anymore, but someone *may* still use
> > it, and therefore, Git should update the info/packs during geometric
> > repacking. However, why not introduce a “kill switch” in git config to
> > disable it so that all tools can automatically skip the expensive
> > info/packs (and info/refs) updates?
>
> We already have those, see "repack.updateServerInfo" and
> "receive.updateServerInfo". Not quite a single kill switch, but it is
> possible :)

There is also 'git repack -n' (which I know GitHub uses) to disable
updating info/refs and info/packs as a command-line flag (if for
whatever reason modifying the 'git repack' invocation is more
convenient than touching the repository configuration).

Thanks,
Taylor
