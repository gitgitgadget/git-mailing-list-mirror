Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1712111
	for <git@vger.kernel.org>; Sun,  2 Feb 2025 04:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738472247; cv=none; b=CoSE5D4g+ebDLX2S0zSiluPZqomXnMGjJzSkIrrceaD3fC57s9wFTQDqHMBH1SjoNQcj1O/iBV02UIsNXQaOb4nW80lDnoTCuyw8klaC5VLFL2zVjRXDi1GwZCHr19UYijUC0lVYFLAQHlP3jkyxU9w3YkyBZEGbcEzMWfG5Qqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738472247; c=relaxed/simple;
	bh=goYapYJ69tE4mrB6jNOqhr/R47dzVmCTvzgtGksBWQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=KAdF9rjweqX7H9ymFsww3wXwAc8nddAVmwhk8wdmY4I+2oHGp4hAXHbYvs37CvLbf85jiD653KHJJ0mI/P9R0XAMEEIHLypwUgT2nbqJGgCLwfTDjNGmyqUiJaNKFY0/9ngZDKy7Jw6a6dVgVHttQ6mmOYSH/0BjO4E0Vfg80UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gebLOnWi; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gebLOnWi"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2a3d8857a2bso1743933fac.1
        for <git@vger.kernel.org>; Sat, 01 Feb 2025 20:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738472245; x=1739077045; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wbjSXUx9A+k3WEcebC92OV3KxYeXqd8WH5CvD7eJ7kg=;
        b=gebLOnWihfV9UjEdA+H+TsR4NHRZZNAt8Hu8V+r94joA43EeTyid50um6MC7apd+I/
         rLN/D60m1WNuWnmi3iZ75YF50G3Szgmxd47nCTVdoVm70di0aOGMKhl4qQmKGDxXLsGV
         TKrBqE7Nny5yrPWVC/4JFs9QfX+0fp/FQElPGzuteimAwh+I8MQLCTJIRDiOxxCI/WFB
         IwmzbR6c1QvPE32k+S6pGpPja0eziJOTfxgh2jR1aR1b4YKGtxZt6Prab0K1zcfmbtpU
         XmMDbBAyZNBFCkhIeioTFbg2TQkEwM/dxoKYRK105q4FO8hF2/wRufOLcI79rXueoxNk
         jL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738472245; x=1739077045;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wbjSXUx9A+k3WEcebC92OV3KxYeXqd8WH5CvD7eJ7kg=;
        b=TzJgRvdYMTAIbYMMAdY+90Zs55BmBG8s5tp7+hHI+y837kKQx+1VoSGxh+wWOfdSCR
         KQch8renNhKfn9TWe8U6gEqQ8VlKGwKGwV0PB9gOYb3nu2Tflo/Lzoui6/dmR3f7tdH2
         U2SLE5DhUTOFvAIOIKnasJCnidtIn6IrVlbWVO0wxexe7HJCBbxAhUf6DymLQvHI8vYs
         z8qDxnMsNXQiSL1NsSciLMOi7+d+7zcX0GzIKO9OvMJsW1yKW4y8INKqRq3TxPUGvYu3
         15IVmTMcxXp03LBordT7CegKUQOoDebVIhk8uvs6QPTyBeJq5ZmtL9Vudu2LGBgyTn+p
         cB1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXnHraCKi6HFK+TovWD3zpWBh327xd8dFfiiDRr4Sw7Q6w60A1J7zjAYQ0nTgLvdZHFPzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWWlMVjt81G66S3DuvoM+4moUl7NFsgNbmM4SQz1lo4MaKhYOn
	HZvZCPra3kdAEyi121xHScIkiQ0tw4wOEIitDDb4HsAblb3rfy7isBotXkyyXgGjt5bDTcUi0ye
	irm3Y0OaxqfBOcmVKAcu79oxs0bM=
X-Gm-Gg: ASbGncvfNLW3EZsI21jvXMpm7g+TJii0Kn7jKIBd4ItbVgaLGlhpfvT2gQdxHl+/bit
	dCoPFrusPZfqhW8OxtYOuOHslhxi/+2maMn9bCVj37ZPmdLSKa7T4EMKO5f+j5sPRnd2LJgGKjh
	8hlG4s79jVhIqUJqgvxgZQiAtwaHHihA==
X-Google-Smtp-Source: AGHT+IHUe6JD6vB5LF5cTgrWKCLTtADDlxbNzBcbm4u4dTfoXwrz2H9RTffRawISiGAwLi0L98pLGj7YamI+Sst1t34=
X-Received: by 2002:a05:6871:3327:b0:295:ed0a:8061 with SMTP id
 586e51a60fabf-2b32f3554d2mr9717235fac.39.1738472245256; Sat, 01 Feb 2025
 20:57:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250201131331.23233-1-dhar61595@gmail.com> <Z57OCCqtQ0JK2I6Y@tapette.crustytoothpaste.net>
In-Reply-To: <Z57OCCqtQ0JK2I6Y@tapette.crustytoothpaste.net>
From: MOUMITA DHAR <dhar61595@gmail.com>
Date: Sun, 2 Feb 2025 10:22:16 +0530
X-Gm-Features: AWEUYZkOe8PJcX9LBio_IEPxlLB3UTvlqcQqkzXSE8lvKfB7XfChny3XoxqedLA
Message-ID: <CAF=ncLZ560xs8jzz-MWV9++rHtNMQkR-D3UOJrV=0cZoWKps-g@mail.gmail.com>
Subject: Re: [PATCH 1/1] Renamed all *.txt files to .adoc of Documentation
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Moumita <dhar61595@gmail.com>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 2 Feb 2025 at 07:14, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2025-02-01 at 13:13:27, Moumita wrote:
> > All the .*txt  files of the Documentation directory has been
> > renamed to .adoc except the files of the RelNotes directory , the
> > includes directory . The needed changes are also made to Makefile and
> > the meason.build of the respective folders inside the Documentation
> > directory.
>
> Hi,
>
> You've sent me 11 copies of this patch, which I've explained on the list
> is not needed, and the way you've done so (in violation of the list
> convention) has caused it to end up in my inbox, which notifies my
> phone.

> I sincerely apologize for my mistake . I will probably try something smaller in some other project and be careful about my email.
> Thank you for your patience and I am sorry .

> Could you please refrain from sending me anything related to this
> series, effective immediately?

> I will not send any further emails regarding this patch series.

Thank You,
Moumita

> brian m. carlson (they/them or he/him)
> Toronto, Ontario, CA
