Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99449238D52
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 15:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738941947; cv=none; b=rYjx/XKGnUm64ss2a/g1Owb0q07PuMS6wwk/g2ZHRGLqgCBVx0oQ9rDY67W2glHrjrsJT+1LvCSh0aTv5c7Oq+C3sZZY3YLlMTz+66R8Mt12L9KYw5SIH3szru5ScCbACu7YkiiTynONT7DaoZk/PXnm6it7w7bopujaznMpWHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738941947; c=relaxed/simple;
	bh=iE0F8mhqUD/Pwxh82VLjX9wfJH2GMrLaNSiWpHiqGQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RczcSxHTo3Nmk5QF07boOxPLFEMxP2+Uco5XvT8+j/jFjGR3SKyYoD9sjW4LWYygEI5w+s4Onp5WPf/1ePzBKFsMA6Uht1CzipeFMtCz16uGNrMNg3V458elZkJW7OrJ5R55UVJDb0Fb1JayfN/DB4bSv+MlwtySPykqAKF1E1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iay5TeYm; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iay5TeYm"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3eb7ecc3c54so1122069b6e.0
        for <git@vger.kernel.org>; Fri, 07 Feb 2025 07:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738941944; x=1739546744; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fgwzu1uh7CjPCfFBrQLo8QcWfZFCdhAhszCF1WKxUoI=;
        b=iay5TeYmSTnqPguzs+bkovDf1xC5OIecc1L+872ZeeNeEJga30JwMeNhDSsfUFaxNz
         2Am22zyDdOxT6ld4AKcGzbnmtd7ye826ZCt3jtRw5HAPMr1UWvnUTe7lu8RwWdDYsLNI
         fdeMG50xCeUZz+bYGdKSwG8RxyDhKeM6nGbFWntScJ9pm/dUWpapSYLWgxNubnMQcg+K
         tj3I+CCtsIXUlb3Ob6KULee6Pj3hJ+HMvEMmr9jl/3TofteXx2ISAypfxmCDOunkuGTL
         75wGooXAf2UKkqM/vlVF8NC2BIM9KAzj+vmd9BEeaMvA/aLLAoYGyCxIq+mR/s+6jsqB
         0vHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738941944; x=1739546744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgwzu1uh7CjPCfFBrQLo8QcWfZFCdhAhszCF1WKxUoI=;
        b=F+zwsj2TKA84s/unG1UlLYE1lSlrMP/25YcUYt0vM7rH+nlJuXk8aZY4rZ37pL2cPo
         g5OFXD9rLDuKAcsuIJS/ObS2NKH/6rFAxkB8CJQ5TXkT3VAZFTdDxp+fPFx9msueV3Dn
         SxidfI3QtXSwjgaoqxAJ+rVNTmF5qhOEoG81sCAKWTvPKjf4x1aoeZYr+8l9qZX1Rk0Y
         VuNe2tDgJArGy/3EDJI4J6cDlbUUHcPH+xHMHjn5Zuaq8DWsNnKfSfQ9PwRUVspII0Mt
         Izha8G8f8ZxUGrdw/K00rJienuFzc8uYJu5MbKHjRvt7+7KylwVjOoOjjvvPYobSLNht
         D0ng==
X-Gm-Message-State: AOJu0YxeRmb4NIeUs9IkjXpajmcOC+rYj2geLC5FBp8omOF5E9cAANew
	BIuB7C2qIW2LR6Ogm7ez7RMWRt4tFLgReuQjkI07XKRag5+jU9+TdmGHzw==
X-Gm-Gg: ASbGncsNpEyPaNi2Bpr9SNs6GNXxfVLAEeoLr3BRbPLL90O/nuPYkDx9IxYMlfDpGm9
	orXs2279a3yH9ySmJFBnY5wEJLM4cQ5cTfrBLFWt4vYMu3BHbVb2KXg8Ghuxv6s6hka9sKQJ1EA
	weY4pyxK4dnWxRObYUci3p5syLQnp/NJ0ey5AE3dOsgNDmWcnwdXDQ20973cHMj3oau2rqWbSXD
	8vVz2mrZ6MBKje73Fhn21AG0I3hMEv2bn+oBCtCemZJtkV86ipi/jm9g0eRaooRlF6JVcX+2V9y
	u+M9UEfl
X-Google-Smtp-Source: AGHT+IHqNDDkom9oBkz77RCkaF8fOFPt7a77Ru7bQfzEq7l2TdRYggaShF3CuPSX7NXt9XvQEzD8qw==
X-Received: by 2002:a05:6808:18a6:b0:3f1:b0db:3f99 with SMTP id 5614622812f47-3f391ff2433mr2131417b6e.0.1738941943081;
        Fri, 07 Feb 2025 07:25:43 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-3f389fd6712sm721808b6e.45.2025.02.07.07.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 07:25:42 -0800 (PST)
Date: Fri, 7 Feb 2025 09:22:42 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 00/13] meson: cleanups, improvements, smallish fixes
Message-ID: <bmwazsiuhhf2dk2hxyl76ubpsdtzk5thxohsjry7qwr2cnow53@cm4wqrrqjqu4>
References: <20250129-b4-pks-meson-improvements-v1-0-ab709f0be12c@pks.im>
 <20250130-b4-pks-meson-improvements-v2-0-2f05581ffb44@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130-b4-pks-meson-improvements-v2-0-2f05581ffb44@pks.im>

On 25/01/30 03:43PM, Patrick Steinhardt wrote:
> Hi,
> 
> this patch series contains a mostly-random set of smallish improvements,
> simplifications and fixes to the Meson build instructions.
> 
> Changes in v2:
>   - Redo the two commits regarding PATH handling. We now only prepend
>     system-specific paths to PATH and handle the `-Dsane_tool_path`
>     option the same.
>   - Continue to propagate libcurl include directories into libgit, as we
>     need it for "help.c" to resolve LIBCURL_VERSION. Reorder the patch
>     to minimize the required changes.
>   - Fix a commit message typo.
>   - Include another commit that fixes the OpenSSL fallback on Windows.
>   - Include another commit to fix linker errors due to out-of-memory
>     situations on Windows with GitLab CI.
>   - Link to v1: https://lore.kernel.org/r/20250129-b4-pks-meson-improvements-v1-0-ab709f0be12c@pks.im
> 
> I have furthermore pulled in ps/build-meson-fixes at 7304bd2bc3 (ci:
> wire up Visual Studio build with Meson, 2025-01-22) as a dependency of
> this series. This is due to a semantic conflict with 28911f7dca (meson:
> wire up fuzzers, 2025-01-22).

Thanks Patrick! I've reviewed the changes in this version and tested
building locally. This version looks good to me.

-Justin
