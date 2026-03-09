Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5993AA1B1
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 14:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773066138; cv=none; b=NEZiVz+HgCtDWeQaYrw53ex/tZ7JDqXq7d7XxIKw62Zkb3bLKrlrZW+7IszVQXdCUZK6NZlf7NZGaDDjFn2MemoqA63EawIGYT91Xhrnm4CsmLsh9hQMamtR2qiTXCNQjbvhZ9x1tRBcndzC0ASprZing0+Qbl9sufZSKjVV3T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773066138; c=relaxed/simple;
	bh=QPOdDtSU5FvJPV9PVTjLlsjJIl2ofiAeeIhfl86UtlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7OkbnCr0JdsPLP4vcQWu2N0JTPhH6MzjGJ9q4uzFAkcdrDGaI/FJXlgdM9oNZpeM9o4ewL7oDJ/laTBoG1+bGGxNhUxu6H4VY5Gm4ZYftu6lp37GBzv8E6DfRm3rjEe3J1fgHflDJtmSVHx3elRQC83O9YJpMJARvU7qszpWs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=McWcOMyq; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McWcOMyq"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35990245493so5216035a91.2
        for <git@vger.kernel.org>; Mon, 09 Mar 2026 07:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773066136; x=1773670936; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QWnAmlfpWTIqaKE8yG34lhiLgyfJx3vYh1ABgoGSAqU=;
        b=McWcOMyqMm3vm0ljW7WsAWDhFyZDEQhw4ncsT3NwMlmpgAVZGghLC0kUj81+pr+ztU
         6m3XcWjAmLNkNceCw6xDXtlOssb6C+FyFOUChLKC6nr6fRJZ6ivMz46gArCaiLJzW1zm
         ij6kh58EDoAUFSdivz+l8JfeT8TziSmYQgO/pJk80DmnE7zxByijy+ErYNqeE2O+TR5j
         VTY0G1oth5EK1U3t7CvDnNoy2nemGAXiNH3hcFEJxvyuRy0jzAcQO2rShkViE1JgT8qD
         4CHEOfJssICwfjwPi9WS1bRTQvFAFb8ysD1cpl0F25+QCCvkqjvTHGo1UCpUA1vo+2F4
         p69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773066136; x=1773670936;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QWnAmlfpWTIqaKE8yG34lhiLgyfJx3vYh1ABgoGSAqU=;
        b=OZgl2IC99M+whICcQRv2RFdergtirN+AGNxwpkM2KUpc6Btp4FphqFuYhf2DYn6TgV
         K3N/Uy34jruLCvsbaefZuJpoX13L+YE9ADwsa3tbznG1I1oSxIsW1qmEVrI3OgGi72I3
         3hHngj3e5BjMNJfNzi92UJ3NM+FRUjEHyCeKIiZQNPHmBKdhqqeR5r3UIdpew/08YtpX
         Akcd9EJgU2sVP+GW6/RaTwMh6dg7HkHUoEadsAeHhAXwjoVF5PEnHckDze7DiRBiC8dc
         Y4CkfoQsWi8R9OLANhTZJWQOplDrRzX716nBwvMMmfYqeVaAo0jZ14Wq5wXhU34+UFB2
         z21Q==
X-Gm-Message-State: AOJu0YzruukWV3j7iVZKOT0vMEuS/zAwLXOMDuKpyPVP5vOEaLu9b130
	E+Fq+ZtxGwG22qgd4ZI2l0172dUMnBAHCIXbSEmoLMSzEpyC12i9oStMBAPz01SA7J0wCA==
X-Gm-Gg: ATEYQzxDf1x0XoqV/oqpF94c4OAkZXvYM1RxNNVZXDzqsRfka4PdT8rcp0GDYiGzv0m
	IFQNjgd7Ly+XHrwI+yVDthXxZ6pLNbUI8n3w7om4dq5CsBqqqH5JyqE6AmK6KmQqF0CQw7d7g8X
	Fe/WNsjgeCFRjQ8NOIMJfNZWVv9fCWuKMDIQZFn70FtfHtzFmIMcOMJCbczo8g6mf24+kj4cDYj
	ESqT+nVsKjfhB1ZnrZE2EzwCDu190khJTJG4KFWrgS20YO8Mk3iHAA/yg0JxYIkFIk6CG8TkA2b
	98f83bJ5S2gzZMU4k6PGJwuZrxoQJuM+LTV/5P6pAB+aqADMU19MpGtpEFn2PyEssZi8doqsi+w
	Osu1otFmh1fQpDkdARJeE7SUQNHukESoBnpYPqf90SYXcmyHr9ojjXJDfd0KXF5sgL0e/gE3OMT
	aUVg6EUSSBTPwtZvsIhM5rLFbKX4hK3r+/BNQvYAwunCk6FclluYm+3ElzjRGvzihYz4Xozspe9
	hqGGmHIR5ef/Y6cUkGkGop0nKywaOGX9J2qqaPPXVlGGC7vEFnd5/g=
X-Received: by 2002:a17:903:2287:b0:2ad:cf11:5048 with SMTP id d9443c01a7336-2ae823a302bmr119348075ad.22.1773066136144;
        Mon, 09 Mar 2026 07:22:16 -0700 (PDT)
Received: from ThinkPad-E14-Gen-6 ([220.158.168.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e78d48sm124081475ad.22.2026.03.09.07.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:22:15 -0700 (PDT)
Date: Mon, 9 Mar 2026 19:52:10 +0530
From: Yuvraj Singh Chauhan <ysinghcin@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [QUESTION] Improving disk space recovery for partial clones
 (GSoC 2026)
Message-ID: <aa7XkqhcG6Kb6IhN@ThinkPad-E14-Gen-6>
References: <aa65h6Z_TrpJbmkj@ThinkPad-E14-Gen-6>
 <CAP8UFD3sicsPd903FU8bsj2B_4Q1DE1xB+--OxryY_jhL=sHdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD3sicsPd903FU8bsj2B_4Q1DE1xB+--OxryY_jhL=sHdw@mail.gmail.com>

On Mon, Mar 09, 2026 at 02:46:06PM +0100, Christian Couder wrote:
> Hi Yuvraj,
> 
> On Mon, Mar 9, 2026 at 1:14 PM Yuvraj Singh Chauhan <ysinghcin@gmail.com> wrote:
> >
> > Hi,
> >
> > I'm interested in working on the "Improve disk space recovery for partial clones" project.
> > I am studying the codebase, particularly promisor-remote.c, builtin/backfill.c,
> > and the partial clone documentation.
> 
> Thanks for your interest in Git and this project.
> 
> > I have a question to clarify the scope and direction of the project.
> > The project description mentions that git-backfill vs git-gc vs
> > git-repack vs git-maintenance is still undecided.
> > Has there been any recent discussion or consensus on this?
> > I want to make sure my proposal aligns with the community's direction.
> 
> I don't think that there is a consensus on this. It seems to me that
> someone said that git-backfill was likely not the best command for
> this, but I don't remember where and when this happened. It could have
> been in a private discussion.
> 
> Best.

So should I understand the all the different ways and create a document for the command
I think would be a good fit and why. And then the community can give their opinion on it?

sincerely,
Yuvraj
