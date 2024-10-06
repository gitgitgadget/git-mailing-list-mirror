Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6A1171E5F
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 11:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728213166; cv=none; b=dLw3H1Jl2Eq5YOMRSP0Krn6itC1ZV4tYddk8atkC+rTA8WO+cgr0rKF98TPc6IJNiuphXr8KbccJDVy4pn5iqumZw7t1UF2T2FjpEhdAhU2ZwqE9Oprw2syZWC/Qa3/CCwa8VupbFvKVL16Ga+NGHap2ReY+C8Cu6v5R00ZYhmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728213166; c=relaxed/simple;
	bh=TKJHOtsTurIoJ/PAMKcfwmhXd6taLdIvkL/6dGAI3SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIXL0WjjHCHjWoDKW5Y2nnuWsBuCY4KWQEUPwuDe8TdwylvFULTYh6eu5nyZV6JW2h2lGoNsRXWtgb3LbZ/Mw19U1/3DjxLZp5OPzE1pQNOxKnnc7WzAf9uckmct+78Db3FloVd+tY2Y94N8yCr1jWy1j0WbaFATFVuftL+A6T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rh0gqhdx; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rh0gqhdx"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20b64584fd4so33642305ad.1
        for <git@vger.kernel.org>; Sun, 06 Oct 2024 04:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728213164; x=1728817964; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TKJHOtsTurIoJ/PAMKcfwmhXd6taLdIvkL/6dGAI3SM=;
        b=Rh0gqhdxAfh0Qfn8mVCWaXYEdGASj3hdnX/3ovOVFrfqaph5ruAZkl9/leh6/Jr2q9
         OK5j0R4wyq4exWWfAzhvd3x915yPg/5zKUIxLYeOBFkQT2asWWKC1ob53/vqgf1O7d0R
         uxzuP1yTYzcN5eivobYWNMa6qDOlWNTajxdwMAGHkHjYyFTloAtYA8RmAwt4Dbde+M6F
         5VxOlvLCMsMaJrSfvZNK/1E+mQ7wmIwHYUfxd7tnZavC0ysLWkblXY++rQUueAZdbdT2
         yzxaYUd1eUU5FJWuwZjkG//VfWSv/JY7WbalkM0iudLrdwY2UpO+oNAvRrYFtKfu51KP
         3CVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728213164; x=1728817964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKJHOtsTurIoJ/PAMKcfwmhXd6taLdIvkL/6dGAI3SM=;
        b=jthQ6DRgZn0ftKTZBetBDm0B/0wPXHlGT8URighwSa9ZiW/iwJxsVS1yTdYUs4MPVl
         1Ije9FjwGDsppkv+K1e/OIs9H3GWMgWE4xnRfIdplqNeiCv6S1WQxW9ehmysrYsnXtCN
         y44oxC0H2tdY7FeCzxZBndSTTuOF2kgPulmljHMr0vAOB2JK6AniNYHGEIMqEjYTqIRC
         0LK+FCt+A6XI03HBkNV0C5e95jGuW1vTV94WauL+lhLNFX7TyQd4buxNJD6Z3iDfgNYy
         +Gph+ch8iG6abw/CTeB3kWEUaTcIB6idnaidwHvKLzmOyx1vQXo2zEtqT0ZMTl4KcscX
         KZAA==
X-Forwarded-Encrypted: i=1; AJvYcCUmKt7Sk7qzi5DDFEyxeuQYqKyNt54xVQNFCSEKDj9U20rkUZy1hreSZJQhaHxf+UAsSrI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/crtQYnmNEsAMNWr/nOgFr1PAdPF8P76HysGEUY8SePBhNTGQ
	iSEryDwaOXCxq+pFQShvqNFcd+qhCHgnukeqjHsSdSVd/GkrfBXE3vWWRQ==
X-Google-Smtp-Source: AGHT+IH2mVij6GwRm22cmh9aCXdIGAXyGEuR8CB9j9Nt/+26HQJcywoLNJnRe2Jj/EbRT50qWhYYZg==
X-Received: by 2002:a17:902:e851:b0:207:1708:734c with SMTP id d9443c01a7336-20bfe022d08mr122088405ad.11.1728213164338;
        Sun, 06 Oct 2024 04:12:44 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c13930fecsm24196835ad.165.2024.10.06.04.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 04:12:43 -0700 (PDT)
Date: Sun, 6 Oct 2024 19:12:50 +0800
From: shejialuo <shejialuo@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Usman Akinyemi <usmanakinyemi202@gmail.com>
Subject: Re: [PATCH v2] [Outreachy][Patch v1] t3404: avoid losing exit status
 to pipes
Message-ID: <ZwJwsuf5ZOKiWbS1@ArchLinux>
References: <pull.1805.git.git.1728192814.gitgitgadget@gmail.com>
 <pull.1805.v2.git.git.1728203495287.gitgitgadget@gmail.com>
 <CAPig+cRePbX6OyE6WhFp1GEZenZyC7HFeA3188F_nErt7Gin6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cRePbX6OyE6WhFp1GEZenZyC7HFeA3188F_nErt7Gin6A@mail.gmail.com>

On Sun, Oct 06, 2024 at 05:19:13AM -0400, Eric Sunshine wrote:

[snip]

> It probably would have been helpful to reviewers if the patch's
> commit message mentioned that it only converts some of the
> instances, but it's not worth rerolling the patch just for that.

Except that, the commit title should not either include
"[Outreachy][Patch v1]" here. From these two reasons, I think we should
reroll the patch.

Thanks,
Jialuo
