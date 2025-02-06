Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8ABB1E5B9F
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 16:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738858354; cv=none; b=Rfndt/+z5xCI+amMB0KiRBiCVUwduxvlKMvijOO8whcAw7DdoQ7URg4jVjEMWBlR4A2Pa+7XnzHiil1InDLJIhmRGOSjeE+Wlh5SWrpXY9TX+5zvwrTD+CcjdyxgrNsfdP5CVn8rx0aoE4vKD7k6qRHyu0F+cXFkSinnVVnMXSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738858354; c=relaxed/simple;
	bh=+kE/GGIdnEE6861BpvPjO2zCe1TEeO9DRJg+IGtABxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EhmZV+okVDK1AwS1ZsnXfv9NMTDJcSFRul7mT2eMyq660X3G9YS1HumhiKXeoK6UGvK1KX5+qyV5PBqyB7KwF9kAlnti9OsnpB0Vz5vtmclIqxEVroWd6MoSzAwCzoesXdYIwBUhUF0fl6w6D5OKf2i5SHPEVjzPq3hMiD1z/pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZPhC4ub; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZPhC4ub"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2166360285dso21353555ad.1
        for <git@vger.kernel.org>; Thu, 06 Feb 2025 08:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738858352; x=1739463152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FpYtNU7KEGMJAF9FYeTAcgnDZSKEgP6npMmg9qTvG5c=;
        b=KZPhC4ubPx4vvQP02/YLQ3MOTifMQ+pdqQflIAgdNH5itKLrr4gUFaK/mdpTzryxP2
         LYNF3Uuu/TS7sL11TelcUc2XVpAuj4Qt40RYpKUqNGi4ySEwLgblusLpIMXo1YVwTfAF
         nBBUmMTZr7EjxhXFvjDPh5SOJM35He5j0DGz8smBMajR9Dmg6bO1bAurlSqcZVvbkEvS
         5B/S1F8E2kAdWZRsGKkGZ2w41l/pDZ2Ow9gf79ewgA/Mktp2UQ0Yu0G0T4Q136cVq/vc
         +UdOvNVliyeAmyFXYxC3A08VAc9XT7IZYV5moYq2+DM7aOgGhbX8lmdsB1PU10JZ5inp
         9cZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738858352; x=1739463152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpYtNU7KEGMJAF9FYeTAcgnDZSKEgP6npMmg9qTvG5c=;
        b=bimt3FpJUFc7YsixOaTPW7AVpIcJzKVMeHwVVfx5KiPXEEI1wOPWPR33s9GUR8yA+c
         VToU34o6r/tER5sAFBhwCcGvWLVl1rdIMiIfGweqXD/YHDWRNzxpXxmaF63akjA0Pc0L
         njTre8UW+kRX5pUxvRFIlccrcTNgy0OuFg+j2DlY3vpgwAYG2RdFnWfBqQM6K0cQ+qDB
         LBUjhqPEZ57X9+73KfzpdCy7wB0PpUarCzdcZGdCGOnqzlzQB2m4pPVVPxJftj3tb+BW
         a208RYe4323ACzor8FwbvUnY8r5o/B2s4RzbsYL2RDusUZJVfOX7N2ylYBwHlZnljjPl
         TWBw==
X-Gm-Message-State: AOJu0Yz+geksOhp9dWqiGPtv1gOHsAnoKjegifZjgfQDjfsbbb4PU4CD
	kIBc6dsh3ZTYvA4d1aTNF9YC3Q0pvi8R5K6JJqBddfYKxJJ003LnQ52iZg==
X-Gm-Gg: ASbGnct/THHFzAArSgoYEV64fOgr7a+inKquPZnFnisDhdcmz/KfdbZu1A96e/eAYLS
	4wIVAk8sWPK6BpZmL+svFcf6MLVydTt59E9wjHQzckK4jS3QiE9wfTk2/OZZkOspZDjpqL5uguY
	3vYB9cSmYUhn8zscM9Xq7Q77rnrmMd75nJIKB+cLkg4Q9mOeFe91vtMCDmnb8nka19jao7c1K0a
	2xi9URsGPksKbvbDOjM0pcxGWqn4a12PA0VF7P1ppVQrLyY2L3yDmGHSmnFr59gNeJ7xQ==
X-Google-Smtp-Source: AGHT+IHRmsQJIS0ScaawSyHgStmYi4BMIEB1zQtXyTsRJC3o8+40B+2C9XiBSiZlbSiXnF67MYJK0A==
X-Received: by 2002:a17:903:2350:b0:21f:4c65:6290 with SMTP id d9443c01a7336-21f4c656330mr839265ad.1.1738858352085;
        Thu, 06 Feb 2025 08:12:32 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21f3655164bsm14834955ad.85.2025.02.06.08.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 08:12:31 -0800 (PST)
Date: Fri, 7 Feb 2025 00:14:14 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/16] path: remove dependency on `the_repository`
Message-ID: <Z6Tf1uSjKpXsg9aO@ArchLinux>
References: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>

On Thu, Feb 06, 2025 at 08:57:56AM +0100, Patrick Steinhardt wrote:
> Hi,
> 
> this patch series removes the dependency on `the_repository` from the
> "path" subsystem. The series is structured as follows:
> 
>   - Patches 1 to 5 unifyf the interfaces that can be used to retrieve
>     repository paths (gitdir, commondir, workdir and submodule paths)
>     and adapts callers accodringly.
> 
>   - Patches 6 to 12 drop repository path functions that had an implicit
>     dependency on `the_repository`.
> 
>   - Patches 13 to 16 refactor "path.c"-internal code to stop depending
>     on `the_repository`.
> 

Thanks for working on this. However, I feel a little hard when reviewing
the code for patch 13 to patch 16. They are not so relevant to the
previous twelfth patches.

One thing I want to recommend is that we may combine the first and the
second step. It is a little wired that we first refactor the code then
we use the new one. When reading the code, I have to step back to the
previous patch to understand something.

Thanks,
Jialuo
