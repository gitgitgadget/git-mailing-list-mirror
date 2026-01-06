Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11E741C63
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 08:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767686948; cv=none; b=mtAAKndCnFjgicfNMhADM/mJduoHNsPt54nOJJ00rXnJ/7iq4l1t9G4ILIaicqohNGhWe8d55LduEaPiXIjQUrszCIGL9RQYAbtMOU6SlBt7slWWJfVFnBhclC651nG6qciylwl6TwHL4wp78KoRluBpqRzwRVCppygOxcWwhoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767686948; c=relaxed/simple;
	bh=mhrmwkZIJt3qWOzZM6jmWQRG74TR3k9H/pcladw/d+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nwdGPXrkQllWsMrz8gEmAUIg9xrV6zTAnQf9buXl1T3TxShVKd+2bjPKh5SFK0bG5siKIycVsKALMG4wRC15//+YvnMxHsS8A8aW41tCaVyfLZzgTesw7awlWKresYIRBsna3VB93/ZJQt7F0LRmWqlrhnmjxQUIonkR7TTWQYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SP6PkHUG; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SP6PkHUG"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34aa62f9e74so913384a91.1
        for <git@vger.kernel.org>; Tue, 06 Jan 2026 00:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767686946; x=1768291746; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mhrmwkZIJt3qWOzZM6jmWQRG74TR3k9H/pcladw/d+Q=;
        b=SP6PkHUGQO8r+LbfXnK5NkDR3lxiDGfPe9pzkxhDn0xvvY00H6SzrNTgaiKZO190Id
         UDCmb+a27Yb95hsrdYne6O3npVVTDrfhs+2P/xAlJUEG/k57qnhaBoEqLnSaT1YY/VaB
         LVfflBr2kgCPjrTsWKggVZ2QYy2fDAxojE0H5bfc7M94zDXw8fneYlHqQ3dnpCf8Iiiy
         Z2rX4AZRhfHeZVFbAN1DgdExTi/bl5d+HGLpHINTFWJ5vcwb7ennLaTxD2j8OAMRDlDG
         NzDjEMfpDqssjY9QvVQnGlApZtIL6+l1eFRpVK3Y4JKx/TMu1pcALCvVbim4Vqm60CFo
         v7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767686946; x=1768291746;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhrmwkZIJt3qWOzZM6jmWQRG74TR3k9H/pcladw/d+Q=;
        b=K6whyQICI0NXEK0DLhgKeVfziaeAgYFXPXVMOCyqKM0gBivgHFhr7ytQX6eqA5FrGe
         PCjxy5c6r46/9RV6cY25Lc8zLDsdaNatJTXa+E/5nTfNd46F5P+o/lOLr482Hmlo9ZtZ
         Ecvbqrg4eu0ozRLYS/TDN69UEP1Cvtb+GwWf4glJ9GRgd2hJ363qsvm9y15AozT+rnu0
         l7L3FEyW7L109d0XYqWJzGt0TNOmnJch5TZyPhAKXhGgD9mT9NWJQNVzF6tPIORsqW+s
         Tl6TkAhyXrUKLCeu+Rq1QPlDvwVQ5piBAhiZt1SVkDBwoGxkQbL1t1sXXRDI/5HtWjHW
         viEw==
X-Gm-Message-State: AOJu0YzFureNbksiucEMkNP799BvEcGmU4RLpIIPdxFxq13MIg4dBp22
	iJYJQSFZd9JSJoPkTovdygCyLQS2e0SwarPAK6EBtRQsTJB3oMZYSp3SN08LQscpkGTKR9k4LxQ
	s9kkBb6e5aL5cv1t6yyrwYYOAdioiB3U=
X-Gm-Gg: AY/fxX5nk3J6ucOnsFU5aeBwMWjO1bp4VKNUCVSaTcBAbbSsZfiGQqn24eB6f1tKQF4
	8Iq7N5OtRsqyVcjBp7bU8+NLRQ9GCEg1DCPWw0Y+lUHs9nLzRck6PI7WmoxDQkMzYVujokU+QsL
	tV+il7b4TWeYEWyS5Uo1vrsZP75/Dt0skmwE5VOwDbcUf+RMV64C6g0C78F1nVe1CmmO84i5ANY
	TA8SrsPCDJ1ZCSJZGWqks0AG3QWDKEBK6aZxZ/l6ySuO/pfcCQ0QGANoP4ghByodnqwgdEs2mY=
X-Google-Smtp-Source: AGHT+IFRLjGzAhWYuk7uxgEpBPNd14hIFJ04viAusOnwe3HdL9wEKN7mg3JfNPau/9/C8g8X8NmbuLOf7XrOwLBbdYE=
X-Received: by 2002:a05:7022:fa03:b0:11a:4525:5361 with SMTP id
 a92af1059eb24-121f18a3333mr2061788c88.6.1767686945997; Tue, 06 Jan 2026
 00:09:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aVfzMsN2ouY3UBFG@ubuntu> <a881499d-e236-4f8e-a217-b6bce69e3e3c@gmail.com>
 <3947f777-e08a-4c17-81e3-c4711fe666a0@gmail.com>
In-Reply-To: <3947f777-e08a-4c17-81e3-c4711fe666a0@gmail.com>
From: Bello Olamide <belkid98@gmail.com>
Date: Tue, 6 Jan 2026 09:09:07 +0100
X-Gm-Features: AQt7F2q2GkfDIoVQSV_GuXfrsp18ZUbfAAaMghBtb1d8SyWCxJVfpfB8VPF8oZ0
Message-ID: <CAD=f0L8aoddeekws0vemTuWL7vb1eJv0kRhAGvEUTVG+17qtDw@mail.gmail.com>
Subject: Re: [Outreachy PATCH v2] environment: move "core.attributesFile" into repo-setting
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, gitster@pobox.com, 
	Christian Couder <christian.couder@gmail.com>, Usman Akinyemi <usmanakinyemi202@gmail.com>, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Jan 2026 at 16:00, Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> On 05/01/2026 14:23, Phillip Wood wrote:
> >
> > It is quite common that moving from parsing config settings eagerly by
> > calling repo_config() at startup to parsing them lazily via 'stuct
> > repo_settings' causes regressions like this. We really should find a way
> > to address that before moving more settings into 'struct repo_settings'
>
> See
> https://lore.kernel.org/git/d61c966b-61ae-4ba9-b983-c8dab6e2c292@gmail.com
> for some discussion about a possible solution.

Yes, thank you.
