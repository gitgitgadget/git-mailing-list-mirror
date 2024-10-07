Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4B718B462
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 08:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728290560; cv=none; b=iR4zP1EssKYVCfrU6wbf5yq2ArEjePivgPvSdiKbQfdV/G0rH3ltRhoRLxDxs66hCFXNaaGk/7n64mYqk87Iq3+ISclMaxP44ToU10CgbimFUj53lS0eIhVEmhMPNd6WvFHPYm+ivTulkKfYh1mJ5T2G/n1vYqkcCJSGrZ5oCT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728290560; c=relaxed/simple;
	bh=7L3Bpwd3Ofqy2OU9XVaoikeQsHrBdQz/wCEbe0rNQLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9oJ7Hm/A0Gkv4Sb4VvR55A/H/+dT78UiCL2QRhduhtr3R37O8yvf5lRQHbKknqsoAjurTfhqPZm2kW7zHzAtO9DLIvmOZUeSR9nCqxLJgcBGhvshN7iOh1dzidpe7Vl7HPQpoVBuh0SQanFWCTac1doEYTgcno/qQsBa831P78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YzgaGBJB; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzgaGBJB"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e188185365so3403386a91.1
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 01:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728290558; x=1728895358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nNrGO8rFU0/IyfUA7pVRC8X4qZ9XRFyUAYhQqXowYnE=;
        b=YzgaGBJBXGriNqwhV7H3KR2LZNFK/P6Tg93YgNPPzJRZpLMLU5ZOHDhGrPhhaWKfOS
         5Px1HGkYBADhYLdYqd5KEJR6sVNZmRQ908kSxE3GT0BtjziyqD/MqEBYnNUWs4jknQ2W
         FD5IGELRymV0fVLrMAEztnKRnDiIYosNm4wh4/GoeCG4ucBIhHxCoavEahkbTd8hraoh
         HfHM33tt7KhnS3qBqhHeJkwbOBeWvbAuzxz1LQZ6ssSHO+GWTlcHkxEE4Bzw1Slfw3de
         RS8uflZDsI4A2CQ2C7dpBiq5EsdvE4GyLHdFfDwgi/+KVS8jvN7EoICdfuRniD2qSdo2
         Y18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728290558; x=1728895358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNrGO8rFU0/IyfUA7pVRC8X4qZ9XRFyUAYhQqXowYnE=;
        b=UtpfxtrC3SZ+LETktOpnN55ufRzRxc/ZW1tALJsakzrGWXmNsfw70cUIa7jkmv3+gS
         TF8UaWvbdC+/Qp5UHTIIIkHnQtPQAOlKhP82nqTsMBi21ihouKSA+FIqZW6zHsQkLwtk
         vrD1e+UnOa7BpEsUE0K9An1p45QYa9+jtolzaJkZzm2wZvOm6xkRn83Lx+sY/eAoR9Qu
         ld+KR2HokUrExgvRfqaGOuTfHZ2xwHP5Lqh6yIoDibjdEhGx+7xdpyWrsoc3ikzc+kNz
         ZbM36hcppxiS2qtkPOhWiru1ZUy5lVc1+FlVyqJxoizApgMyO+pyS+AZnrDoOkWN2qod
         YPKw==
X-Gm-Message-State: AOJu0Yys+YjS5GV+1ZxpZ/IaQ8+WsqPTq6bSJ48A9vQuBK6Z4D985zYz
	m0F4vD9ogY0466f4VV34/YlORHrKoDA55/M/TauSk3llUgSQtRo1
X-Google-Smtp-Source: AGHT+IH9/d6+FVaGFOUoUSRl0v56rO6Ag6Ul31ggVSSZA0nLU++U1SfTnGwOCgHaxYVzBWuyDZ7mSw==
X-Received: by 2002:a17:90a:cb04:b0:2cb:5112:740 with SMTP id 98e67ed59e1d1-2e1e6354248mr12750680a91.26.1728290558145;
        Mon, 07 Oct 2024 01:42:38 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20af64d33sm4804268a91.30.2024.10.07.01.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 01:42:37 -0700 (PDT)
Date: Mon, 7 Oct 2024 16:42:44 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/9] ref: port git-fsck(1) regular refs check for
 files backend
Message-ID: <ZwOfBCSTO4Qvtos3@ArchLinux>
References: <Zvj-DgHqtC30KjJe@ArchLinux>
 <Zvj-osCNDMrUQv83@ArchLinux>
 <ZwOGmoX5ner_F3Ac@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwOGmoX5ner_F3Ac@pks.im>

On Mon, Oct 07, 2024 at 08:58:34AM +0200, Patrick Steinhardt wrote:
> On Sun, Sep 29, 2024 at 03:15:46PM +0800, shejialuo wrote:
> > "git-fsck(1)" has some consistency checks for regular refs. As we want
> > to align the checks "git refs verify" performs with them (and eventually
> > call the unified code that checks refs from both), port the logic
> > "git-fsck" has to "git refs verify".
> 
> What's missing here is the actual intent of this commit, namely why we
> want to align the checks. I assume that this prepares us for calling
> `git refs verify` as part of git-fsck(1), but readers not familiar with
> the larger picture may be left wondering.
> 

Indeed, I will improve this in the next version.

> > "git-fsck(1)" will report an error when the ref content is invalid.
> > Following this, add a similar check to "git refs verify". Then add a new
> > fsck error message "badRefContent(ERROR)" to represent that a ref has an
> > invalid content.
> 
> It would help readers to know where the code is that you're porting over
> to `git refs verify` so that one can double check that the port is done
> faithfully to the original.
> 

I am a little confused here. There are too many codes in "git-fsck(1)"
to check the ref consistency. How could I accurately express this info
in the commit message?

> Patrick

Thanks,
Jialuo
