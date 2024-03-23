Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5F154675
	for <git@vger.kernel.org>; Sat, 23 Mar 2024 19:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711223322; cv=none; b=FHuMHdnvhRP405PXlXc1cQ8g8jhw4PMNFTYXYAd8rpWhSSfGE6aHOZMsNGXbyGMFkASS9xt10nTD4tBxZv3txs6WN0MeF9CI5CvocZGQUi05cIq5R5JEfg5cN79h8nDyHJfirGLv239vE9UaEKeYJ2PNV7txs/P3jBbgV1Ef5bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711223322; c=relaxed/simple;
	bh=5YlV/G4eY/L6VBnJ1wI3RWllrG4o44uE4543dXA4a7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXzqc3q6VTW6x3NXwSrsXOMOwOO6E2wrWDxVOxcD+NFtcO6EHMqI32P+57XzyVGxiJPM6mZIb3HmCCfwl0ViQFL9EwykDKaflcUxfeEsurHCieiRNXBcEZ68a+tv4gDelL6OoBmA+L8JnnxcFgL05BKf/diR1G+iz3M9Dv4co5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n6sApju2; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n6sApju2"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e6f69e850bso2567105b3a.0
        for <git@vger.kernel.org>; Sat, 23 Mar 2024 12:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711223319; x=1711828119; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=plDf+NMAd0qHABpxGV7/MpN3LLsJiJMIXm8kX8KDupk=;
        b=n6sApju2RUdUy7qwaZIpbbo2xNxsO/rKtOoO+n/YbA+NYqcmLRmb7neVUu7Bd1+nO/
         IEBL4RsKICqFoXzSVaNuEXjo35l1aTgHvz/dbIWTNckAkF02AIV4FwVz+LCWzsVqkDX+
         Mhxub8TFx6UoUyPosFqoq89oh01cQn1YYN2aNMbqlSUMqC4hj1zVhRx9ShA3o56XNWfL
         PeDEHB3fkROTlYdogDuSuCtRH0pSosdh4a+fdeLxUWPPIe+IJV/1VW2KohS4efoHCaSA
         hPhofev2eNEEpXC3qh9lUkiNiVjGz9VedwKYoEmJuqcDMPt3kxbmOCM+kbGR8v4k+2w7
         kK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711223319; x=1711828119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plDf+NMAd0qHABpxGV7/MpN3LLsJiJMIXm8kX8KDupk=;
        b=WzwEDnf1FK+UjQyZuMglj90MbJRQg414uFVoW97av8i0Gz7IKL7toGxKu/MzkpyFtw
         byqMPqci9vRn8klhp5GaxqMBAqBKUrTov78Sp+t5lDA7zVvws1901SmB05swiczHsLu2
         x0W/b9LU3Lb7JH+VPR/88sqhVR8L+D+NccXdQI1/84gakM7jrkj0kmVeZEanpi4LDKrW
         yugZDyD+uloHwGXyLTs4k7HpYtmnWsXM08sKr9W5nh4vaafnfOPwirNcGed6nracj/A2
         mdu51T6xmMf7+WGQ0elWN8mmTQ3N7YwKaZcDS8Z/9ycGXGL3oWd5R0kkhKcsEZUoXH3I
         zp0g==
X-Gm-Message-State: AOJu0Yx8loi9NBS/UPkfKRECJ8XVYF5lfjGqngsPg/151KImY6VGvv0/
	j1DCmJBGBBFv9EPnILYD33VTNChmGIPcsZnfd8ZtTxP5bJkyyRq7XrFwv9DAnWO1Wq+RiZ7s1N6
	Raw==
X-Google-Smtp-Source: AGHT+IH3pc4WQAVEyFXj06i+iNnV8der53XjgTdUp/lRbBuz9M/oTxzKWF2Rc0K/r1EIEWL+czPhXg==
X-Received: by 2002:a05:6a00:3d51:b0:6e8:4485:8965 with SMTP id lp17-20020a056a003d5100b006e844858965mr4239186pfb.10.1711223319164;
        Sat, 23 Mar 2024 12:48:39 -0700 (PDT)
Received: from google.com (144.44.83.34.bc.googleusercontent.com. [34.83.44.144])
        by smtp.gmail.com with ESMTPSA id lb13-20020a056a004f0d00b006e64ddfa71asm1761661pfb.170.2024.03.23.12.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 12:48:38 -0700 (PDT)
Date: Sat, 23 Mar 2024 12:48:35 -0700
From: Kyle Lippincott <spectral@google.com>
To: Dirk Gouders <dirk@gouders.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v2 5/5] MyFirstObjectWalk: add stderr to pipe processing
Message-ID: <bwm73ljwyva36idgouda53qlm7hefkpnt7nomlc5d3c2zje47g@cwkt4dtmx7le>
References: <cover.1710840596.git.dirk@gouders.net>
 <64c36dbf16108353635a7315a3bd5eb60f2aa92e.1710840596.git.dirk@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64c36dbf16108353635a7315a3bd5eb60f2aa92e.1710840596.git.dirk@gouders.net>

On Tue, Mar 19, 2024 at 12:23:15PM +0100, Dirk Gouders wrote:
> In the last chapter of this document, pipes are used in commands to
> filter out the first/last trace messages.  But according to git(1),
> trace messages are sent to stderr if GIT_TRACE is set to '1', so those
> commands do not produce the described results.
> 
> Fix this by redirecting stderr to stdout prior to the pipe operator
> to additionally connect stderr to stdin of the latter command.
> 
> Signed-off-by: Dirk Gouders <dirk@gouders.net>
> ---
>  Documentation/MyFirstObjectWalk.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
> index 981dbf917b..2e6ae4d7fc 100644
> --- a/Documentation/MyFirstObjectWalk.txt
> +++ b/Documentation/MyFirstObjectWalk.txt
> @@ -847,7 +847,7 @@ those lines without having to recompile.
>  With only that change, run again (but save yourself some scrollback):
>  
>  ----
> -$ GIT_TRACE=1 ./bin-wrappers/git walken | head -n 10
> +$ GIT_TRACE=1 ./bin-wrappers/git walken 2>&1 | head -n 10
>  ----
>  
>  Take a look at the top commit with `git show` and the object ID you printed; it
> @@ -875,7 +875,7 @@ of the first handful:
>  
>  ----
>  $ make
> -$ GIT_TRACE=1 ./bin-wrappers git walken | tail -n 10
> +$ GIT_TRACE=1 ./bin-wrappers git walken 2>&1 | tail -n 10

I think there's a second issue here: this should be `./bin-wrappers/git`, right?

>  ----
>  
>  The last commit object given should have the same OID as the one we saw at the
> -- 
> 2.43.0
> 
> 
