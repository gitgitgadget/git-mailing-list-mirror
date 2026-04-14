Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D30D19CD0A
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 20:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776197205; cv=none; b=t1OaixuXtP4t/aI4jhySUKwdzfKJNr0hmFiZNfxDLkOepTKHLLg6AiCIAHiGfyE7E3zg/qCn12YlorE8SG2cDQw+2qP+/u3fSwOuguRxpnMbENihJ3I7nkWdMY7Ybz5/4YhPF5mTmz8wY8buMpsTgZg0Z5PIXc1Xi5D6/oNkbwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776197205; c=relaxed/simple;
	bh=Qaoscr9xkhdS1lzG93e7M3RRgpFWh6tCPhSl064tyTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a7nB3EBE+3s/IkHo/PdGJ+zbIXdJ4F9MTLYXvy/p39PLoamLAWdHwmF9i6p5SRS0JDahozXNBYcBTVtZeth0Oiq6F88R/J2eTF2vOrZNzQww3ETRaCfZbFELMNxLaUhntHvV1YGNHjaVIa7n5rwPgt8GJpQweEU7mJr73LsIoWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gs0VCwJQ; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gs0VCwJQ"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38ddeb0f5abso49207491fa.3
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 13:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776197202; x=1776802002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yKFXI5SGhdqmLcpFs3wSUdFH8iaThgpwXdZfR2YB2w=;
        b=gs0VCwJQOt+hfhmmZ830MChtiZzJM+ilJk2pIeWFys0UH7scNr3+qKW3NOkq9bahVn
         MAt+T7Ocy25yYKs0mGCDM6b5qKoaoc/Yf0mgYcElguERX5Ykw4mY9SP81K7vI3mwxN4h
         pYKJopY222yCXnDKS3PNcBabR5cqmCK17YSueusDWnniJemgW6I4aT7aYwOVYSVISvsY
         4qhQ53tXzErtMzHy1q9Fw8oxN05U7UC4fktev7cn1O9lZjnFKapwHE5aBF2DpgRzbqJa
         MDM+gAq5aOAbG3Fxt4K3M+7eBR6m5DLZ8xgm7mR9dvlC7vBiHVEMfrwvcXALM92WOzKm
         Io+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776197202; x=1776802002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3yKFXI5SGhdqmLcpFs3wSUdFH8iaThgpwXdZfR2YB2w=;
        b=iXiuCOs+/dZzgRZFacDumcZuq9oGDezWE7fd1q+GfkzMi5NEajjvQlH7bjWHZA9BR5
         mEzACZkpkV/37zF7iJE5iwliVgNa7mAPGyVMkcgKTOzpQsy+VJvsucJWdt/b/mQed6kb
         jH1JnTVvkEHr2RVmSzwrHVYof/lKED2KjVbhKOZxSb5lPZTdOVS1sSuLET8Nlvmuw91D
         MgmAkXAzW4K82pHG26LxNg26PsvKwfCQKRYDNb0RO8l+Z8m1MEZSEqygFEPWCGopS5xa
         93aPEcxf/z8t92+iYZaqV/RTXa4srp7Z6UXHsMpewP7/AEwSwYmt4G8kwDYa8Hz0vgIF
         xLLA==
X-Forwarded-Encrypted: i=1; AFNElJ+BL2ukKTXi75w3d074pJMiIh0RIAxCgdjx3PA3SzFsoNyfuJSQsD+pZgXEatxINuGzYHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT2BaN2u/Ao61/MRMzwdR6624U/ZWQF8EjiqYUV0dYBWkLJBXU
	sA71Uad62mPwE0984xswvHKt9TIDajwXAsAnCCP+tU7ztaUvzYQUTbjr
X-Gm-Gg: AeBDietX75bUW7fO8jUk9l9Q8tttRlLeNKPlSeRQdjngPuN3UhuJFAqk0UFSrOTIdEk
	gRD/s+7p8AbKrK37L+nmNfXbPao1eEDjD8b13p0siMyLgzct6CnK+9gQ3XIWMNBDfvRl3XSEMw/
	pxL91n/kMu7b4dhsSyBuKFexn6aHdIab/3Fv635jl7Q4ZU6df9efXME3HR18lUYm9SVK/SR+bvI
	Bizedq2WuCDMp7QqNvLxWiUbirWXkZmp0SvAxJdThw22+L3k/OoFX2nWTrPoGPk2fZRpCPICC+s
	j8bU4NQ450TcxiQ1WjXgr5pQv9U4XRC9L9Lox5h1OdRbAq7oroEnX+74+re6sqkq1NOINsVeDHE
	zzg4SFWmLOz77hvjmOhRx95IMhtX1798tBvHxqvP3Vnab8Q91vHTzRPsjAPeFg+rbubP6Xi8juo
	HLp8UO9py98vKAsFs335vVdWkNP6yD+S8YwZingqdZ6HR+7T6P0sCVNPL6M9fYoa0ie4vsfyfbX
	jUZQZZ+ap/zvztPCE70s3q2gsU=
X-Received: by 2002:a05:651c:e16:b0:38a:8602:71aa with SMTP id 38308e7fff4ca-38e4bf6e6ffmr41329541fa.16.1776197202136;
        Tue, 14 Apr 2026 13:06:42 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38e85a550ccsm10554651fa.42.2026.04.14.13.06.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Apr 2026 13:06:41 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: phillip.wood123@gmail.com
Cc: chris.torek@gmail.com,
	git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	peff@peff.net,
	phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
Date: Tue, 14 Apr 2026 22:06:40 +0200
Message-ID: <20260414200640.50910-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.54.0.rc1.77.g97a5d87c81
In-Reply-To: <f012cc7e-14fa-40d2-84dc-7407fdceb36d@gmail.com>
References: <f012cc7e-14fa-40d2-84dc-7407fdceb36d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> The changes up to here look like fixes for an existing bug and so would 
> be better in a separate patch.

👍

> Sometimes we return "1" and sometimes "-1" what does that signal to the 
> caller?

I just tried to follow a pattern, I'm not knowlegable of how this return code will be used. Futher down in the file we check 'ret == -1' and turn it into 1, so maybe 1 is correct?

> > +                                                    autostash_msg.len ? autostash_msg.buf : NULL);
> 
> Can we create an autostash without setting a message in autostash_msg?

No, seems not. I'll simplify it!

> > +     if (created_autostash && !opts->discard_changes && !opts->quiet &&
> 
> Wouldn't it be a bug if we've created and autostash when
> opts->discard_changes is set? Why do we need to check it?

I'll simplify it!

> > +	    new_branch_info->commit)
> > +		show_local_changes(&new_branch_info->commit->object,
> > +				   &opts->diff_options);
>
> So this is a change to the output when using "checkout -m"? If so it 
> might be better as a separate change.

Do you mean to drop if from my patchset, or just make it a separate
commit within this series?


Harald
