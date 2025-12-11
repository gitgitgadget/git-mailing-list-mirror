Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7052D839B
	for <git@vger.kernel.org>; Thu, 11 Dec 2025 19:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765481957; cv=none; b=kbyPHyagYkAG5RsO9wmA1l7f/8t+qQ5FwFpY90RK3D7No3md0rOeanwpW8kcBl0MB/NWRruVqSMCNgp72z8/e9g77mZYqBb51/K8Z1x0HwOJ+vGoXv8VnqaUFCmca1thj37UtfOIEsRt4+EzOgW6Kx7n/srCD25s0IpfgBy+7XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765481957; c=relaxed/simple;
	bh=B4ZShivCHYSpR6ggiLTY2pk5S1H56bYsAR1ZXuvKzZE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lYnK9BxQb7k7t+0nrbl9u00+YlfYxlWmtXefsnKncZLRSnrEPx+W7OxG/RMeY7v4jVnz/kOKT4g6yfO0/suWDc64wmAWYU12nyrUlALomQ/DF8O8KwviuIuHDQah85PAAvfG33H9sZ42b1iDaPyQnY9gXUaBbQxVtHOCvWm24F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYY3JO6P; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYY3JO6P"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477a1c28778so5522395e9.3
        for <git@vger.kernel.org>; Thu, 11 Dec 2025 11:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765481953; x=1766086753; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xhkT6cUUT1ZDEU7PUbbKnHBg7z7yw8H7vplZU7vbT1w=;
        b=eYY3JO6Pp0MrwhQauU4oHhOtqipf6PFbHb72lRDmI3IrgpVuUd6ukZ/RTmJdZFjoWW
         Ux1c62P2z51lTuaYrefvsCgFFWSvJk8qNZGcSHbl1GDfHj5jgziDrlFEapwtStILv4Zd
         2URr7yhtHtsPo7A2w8wbJ3srhYUQGZW5tmAzQTcK9oHlShW1a9R/NvUcmVzJ4JXkn4Bu
         rn2twPPVYp+GmttkkkuAI91b2uOTMiCJuOm7vh7j6GIGDpeUNGAIw/LksPiV6WwP692d
         gmaNn8BROReN5sy4vIxOPIhzSjHrLmuSH4sDNiohZNqkdEtExMc0QtSCMLBnV3toTsl0
         rPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765481953; x=1766086753;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xhkT6cUUT1ZDEU7PUbbKnHBg7z7yw8H7vplZU7vbT1w=;
        b=L/buwwAAiRJdejH6sxafxyd5K2oO6TZC0vH1+/WnJ8W9ncT0FGCzqphKAGpkRGWidL
         6XYb5y3BhR1uVcRNLvudtx+XR853L4rdLblb9JuNzkVLlG4M2MHQqRFYtxVmeNuhi3Yc
         2XsDteZWY0RazuhZ5/8M4DK4wQ5tv+9IBiK7AwvPnuWu1CyOdoO5C5bQR/TG1PNXWGop
         wl+oY2oX95eIVJkbfTP3vtDFPEd7/VcyDm7DeOsB0SjDTBTJjK/X/8pYTJ21k5YCFwSF
         VXUlB4b3sanxvDa5lHZYcYv9GJIA0PvBzNtHqbP0scXZzGYtaqpIs/ZDs/VwZAFJwoo7
         ooAA==
X-Forwarded-Encrypted: i=1; AJvYcCVi5y5ybQbt1wkOaCC7M3si6hCuScQc5bSkxkXIxocncsDzmvgLEezQhrGeHO1nRYCRn28=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyaom/5iB8c8EQfhQLG7zPUpLRo/sw8fSudGpbjPkSbE6O6XxTv
	emjODk5fFQ/SJF85zF17JDegYGP/xO0JxAs3Lqveo497l5W60e/PsAP2TnZnsQ==
X-Gm-Gg: AY/fxX4sGjY4vqTEtOcIx0bhah8W/gADddsXLXu5MeR28AaNhj1zXUPhvbRv7LGq6h2
	LxMpTom0pyzlVMTK4aFxYa+zQEpMmi2/x+1VyZ4F0b63b6cbMxLj03dIR4spSBn1iHh97P3uWDn
	PoZPtm4egkyC0dzouZyN3HCOue//8o6sHs6HTIwzOJJYKBvnGC1ArZHN4QWuryxEqUbM/lUz5F/
	wVJy3JiZA7maf/1Tl3/rxXrCROBUbgWqqiphd6jQdlFAEwFGHswRDuWgjdcsK2sPyHt5HQ5DVAK
	MeFTaF/CsvZqpy2tg0mM1AvPuKG3q/LAbRYFmoUwMLXs4EYVz2SQTRsXaGvbQyvRgR9gM6mtF6t
	bCR/Gl3E7UAhUoBfAJ7xY5BsNHQJX/CiL+Enh7zLh/SXBWxvNMKaJ+sbBbjtq4ByNZFcUqYfutL
	mNxUNgrk+rQJyQiPo0ICu4A0Uf2PW50/lYnQIxUIOBxF6RKf4EywIp8BozFveW6IHdSg==
X-Google-Smtp-Source: AGHT+IGOCdkwjt3Z8QuOJom7t43BtNJc+zpnkzf97ie5fuPg9Lvij1SS6zk8Dth+JViIjgiDs+MuAw==
X-Received: by 2002:a05:6000:18a3:b0:42b:3a84:1ec3 with SMTP id ffacd0b85a97d-42fa3b0015dmr9521709f8f.29.1765481953361;
        Thu, 11 Dec 2025 11:39:13 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8a741c9sm8023782f8f.19.2025.12.11.11.39.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Dec 2025 11:39:12 -0800 (PST)
Message-ID: <fd5f7f9a-8c2c-4222-9b16-309e9a6c587b@gmail.com>
Date: Thu, 11 Dec 2025 19:39:08 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: bug: `git pull --rebase` breaks in the presence of pushurls
From: Phillip Wood <phillip.wood123@gmail.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>, gitster@pobox.com
Cc: ak@akkartik.com, git@vger.kernel.org
References: <xmqqpl8lg0u3.fsf@gitster.g>
 <20251211053504.8758-1-jayatheerthkulkarni2005@gmail.com>
 <3a6f39cf-b35e-461f-84a7-85e6e7376d21@gmail.com>
Content-Language: en-US
In-Reply-To: <3a6f39cf-b35e-461f-84a7-85e6e7376d21@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/12/2025 15:54, Phillip Wood wrote:
> On 11/12/2025 05:35, K Jayatheerth wrote:
> Almost, it uses the reflog of the upstream branch to find the most 
> recent entry that is a descendant of the local branch.

Sorry that should say "is an ancestor of the local branch", it is trying 
to find the upstream reflog entry that the local branch is descended from.

> It then uses that 
> commit to limit the range of commits that get rebased in case the 
> upstream branch has been reset or rewritten. There is a diagram in the 
> documentation [1] which might help.
> 
> Thanks
> 
> Phillip
> 
> [1] https://git-scm.com/docs/git-merge-base#_discussion_on_fork_point_mode
> 
>> Just checking that I’m following correctly
>> before thinking about possible approaches.
> 

