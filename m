Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48C42F2E
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 12:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728217792; cv=none; b=RJmt4UpRgwLD22hoisnODRZzMlmj4AQKiK53H7j6QtHjuNh8wJrVGvK+f2UrnZxTGlx33yfqOlodKtPo90X/BIet66zXRFikutgPtekPxyqhZ9hNxhRqS8pbE2mOw9aPOf0JL8joKJZ3sNALQdxAChyR6AsYBm9Fu5yHSVNCzdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728217792; c=relaxed/simple;
	bh=JUgrzeDhVMV55Ft6GIM56IxYx9dfPn5UVeF9Br/gpV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXKqaCdf0YnYU0oXbnDTiN0vw68iQCs8GAtkzGDn9n1FDbKnHiykyrRSP2Jio0NhXtbzdSUaRQ++yCuCCCMAu9zkDJRaKLe1+6fc3VzxuMYGh+skICN3ItM7MA/VfNj7yj2HhD/izyvZPkk/uSuovWd3VOSVWAPaePajPeShtkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mjRncHOp; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjRncHOp"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7db238d07b3so2975427a12.2
        for <git@vger.kernel.org>; Sun, 06 Oct 2024 05:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728217790; x=1728822590; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JUgrzeDhVMV55Ft6GIM56IxYx9dfPn5UVeF9Br/gpV4=;
        b=mjRncHOpRw9qUoCfeGMNB24oLpeW9xWvWzneZEgtcHBnZ60xQRB8NbjSJAMmmNgN+v
         tIPBXmqp7Xxf5PAwDGutrIuvduHvIPjT9jd+QQ74GzrheNz2lNrLqXBEhIn5h+NF2qfK
         i7qwsSB4kSalL91N0D+Z6bEBSeK8DGg1Ha7FI8YHH+vkTCGjR2xQspbLiiJElyAuycYz
         MAWe519cV+7KYqxAOdngpDMiiT4SCafhNsuS5GZ7oCD7jowgJ+XQ8TlqAuB988xt/DU6
         dK1Fph8a6fDtbhZ+a1M15PLyoWQd5lYFMGJZ4hQgri7kidOCskxpApWZuvlpLRWyyO1J
         fUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728217790; x=1728822590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUgrzeDhVMV55Ft6GIM56IxYx9dfPn5UVeF9Br/gpV4=;
        b=PT5C8HZjuiN6yteGum8EXUDZsp+vMyaEYDiGZJYyveOAC2faiisJOkLV2xEkXH/MRj
         DI6ojA/cfiRMTOoAP7xdiFsHA6q/IcgUqlNSiZXsWXGaZ+G84jOo59XRYcieGmYqh8N0
         xMIojGpvv0CMeG2c/EjXrsm/UKLYTgBD+tkAJxX1rN6Pc7rjraRTbl8DnOwvhQT1Bl8u
         Jr+TQQBKTkxnH1bLunkBqfbAKnwI2GR7Z7CeuEb1+9eO9TNnvS+cWJXz2ltK0Z5YQqtA
         /1Yh/waV65OvDwCJCSbPytVeQV2Gx7KeRALubeD+ItvSeyS8KEtN1HA3nYTnZ0byJji/
         3A8Q==
X-Forwarded-Encrypted: i=1; AJvYcCX98678Q23Zoh7duUSsHk9o11qSBIi1na9jK3bWlGVpym+rOoUdLuCUWjHEzZ4Lc89E+1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfXVXlAML7Ksrta3Q3QrlMtlczgLExyWw7h/ITAU1EJ0oRwgNB
	u3ph7BRQSG2CbavmhZiFcZGpuoYsMyu2xU0+u4T8sTXXRKGhztlD
X-Google-Smtp-Source: AGHT+IF9G4EW86/sYEzebaovipwc/0tKiNlpjXMOj7e9unvXzbnFtMUE8RduXMQeSbhcXW/HUenIJA==
X-Received: by 2002:a05:6a21:2d8a:b0:1cf:3b22:feca with SMTP id adf61e73a8af0-1d6dfa3697cmr13189617637.15.1728217790061;
        Sun, 06 Oct 2024 05:29:50 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d47804sm2723833b3a.137.2024.10.06.05.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 05:29:49 -0700 (PDT)
Date: Sun, 6 Oct 2024 20:29:56 +0800
From: shejialuo <shejialuo@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Usman Akinyemi <usmanakinyemi202@gmail.com>
Subject: Re: [PATCH v2] [Outreachy][Patch v1] t3404: avoid losing exit status
 to pipes
Message-ID: <ZwKCxHzbWxNQ92KR@ArchLinux>
References: <pull.1805.git.git.1728192814.gitgitgadget@gmail.com>
 <pull.1805.v2.git.git.1728203495287.gitgitgadget@gmail.com>
 <CAPig+cRePbX6OyE6WhFp1GEZenZyC7HFeA3188F_nErt7Gin6A@mail.gmail.com>
 <ZwJwsuf5ZOKiWbS1@ArchLinux>
 <CAPig+cTVf=W5KXkE2iTxCSPmZjOSbmf90J_JugDuTH_xudcW2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cTVf=W5KXkE2iTxCSPmZjOSbmf90J_JugDuTH_xudcW2g@mail.gmail.com>

On Sun, Oct 06, 2024 at 08:06:10AM -0400, Eric Sunshine wrote:

> Your observation about outdated/confusing "[foo]" annotations is
> certainly something the submitter should take into consideration for
> future submissions, but does not seem worthy of a reroll, IMHO. First,
> `git am` will strip those off automatically, so they won't become part
> of the permanent project history anyhow when/if Junio picks up the
> patch. Second, asking for a reroll for something which does not impact
> the correctness of either the patch or the commit message just makes
> busy-work for the submitter and wastes reviewer time (which is a
> limited resource on this project). Third, the point of a microproject
> is to expose the submitter to the workflow of the Git project and to
> the review process, and for reviewers to see how the submitter
> responds. That goal has already been achieved in this case, and
> rerolling for something so minor provides no additional benefit in
> that regard.

Thanks for your detailed explanation here. I don't know that "git am"
could strip those off automatically. I thought the maintainer would
delete "[foo]" manually. So, my main intention here is that I want the
submitter to make it more perfect to reduce the overhead of the
maintainer and also pay attention to this for further submissions.

And from my perspective, the reroll would not bring much overhead for
the submitter, so I expressed my words in the previous email. I know you
concerned that my words would frustrate the Usman. And I wanna say this
is not my intention here. I think Usamn has already done a great job for
this microproject to understand the workflow of the Git project. So,
actually we are on the same boat here.

Let me withdraw my previous words ("We should reroll the patch"). This
patch is good and don't need a reroll.

Thanks,
Jialuo
