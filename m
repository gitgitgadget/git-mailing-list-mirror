Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B4931355D
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 14:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291211; cv=none; b=HcHSDFCpI13CkDQjx/zuXpZO5BP8jQ4AjvVBBzJLy0hH7D7+E1F7mjDIYC8wr7TEN7eLGbW1MjqAWnvHn/Zt3mugQSNMom6x2eYvHv8Oyu7s2pCyrHRC9xG6uGbsQOyWmbCg1Kmffwn33Hhou+od+jOSqyrkitSG61TLpGRPmRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291211; c=relaxed/simple;
	bh=WM1R8/0SwGqDRncEggPvQtdKtgU8TIdZVCusKy/hS4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T6HHS8AUz5CiZoKE0pcl+4jJbteAu8Yd2fRdz6zoTxb+ciN8Y64bn9RSoe42S+SEg2Dfo1DgMhv2WJe32gCP0Eyqkm8KcXxwD+Mv0r+SYltMmFy2QOIHsh2tcB16M2OLahjhyVKbh0l5RqdhGH3NCdB39M7II7QppDzkJ7USpms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEyzZAj1; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEyzZAj1"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3d118d8fa91so915961f8f.1
        for <git@vger.kernel.org>; Fri, 19 Sep 2025 07:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758291207; x=1758896007; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sBz37VJ1iQj2cmm2/I+K9ZG0mUmC4FsHJ2Z0mxHt+pw=;
        b=HEyzZAj1NLo/WbuHiPzOJm5BjNzDMuu0wg/4oF+dUXBaiZG1UaGISrFdK5kmnsM7H4
         KnFRfgRuOBrmwdn1L9zu1T+NorqTjlS632cqBhS4ewEc0qAM42I8T01T4i1WK7fVF+Ea
         iI+ni82ACR+WWfqxTZ2DHg9lRAs3IdT/Z7zOnUxoiPcrijdbGwHBap4EiNei/2rk2ss3
         y6jbMAUxUf6yoFPaGWNCmbotVD9cMRB128J4C7DkohPVGIhAEQqI6ZH48OwdolpJPquU
         rjaUxRlJTyq1V9FQ2reeksppTTGhQWqYMyKjVe7BsIQB44R0o3C+X3NfCOMIFgXc296Y
         rcZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758291207; x=1758896007;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sBz37VJ1iQj2cmm2/I+K9ZG0mUmC4FsHJ2Z0mxHt+pw=;
        b=HjuiTf3hSRW4nQ6Jwk6CxDNlC2kCwwGYL87JylelA3L5I5DgKlckVoLrS5N2SppnIn
         FjwlBnVZeqnSXmiitncGFzqbrz2b8JHw2oP9PsblY0BiVE1ZexAPtuPfWg8P/x+R7snx
         1wvqKep3pQZbZuNiXmgHoUJdzj/l0T6ErBW9nJtilSi8iYgUh3h2ZxaJI2TX3o0FbPXr
         FV9dhM2MGs6BfXHgMnbqCj1Ls5GpiVQGSh6JhzC5EiTQiuC8guGBJL5CtXFiOlhzAo2x
         2Xwxoge274eVeh2irnjYnYKfK0D4nGXoHy0ASxCKp6fKMdtQ+CppsOuZaq9z6+aNPX3n
         9haA==
X-Forwarded-Encrypted: i=1; AJvYcCUTf28MK98/ewQf4d13DTnhyi4crt1ccJhBbH/03JNza9cXnQ2tGH8nDsUDlhFuTorZUUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwldoRal6j1MYU7nK5C6oypYYbNo6MvV3AVSqfbCtH3VlFGfH/8
	V41VqKmzu16x3kewZHS9rY4vUGicDTr/1Nqe8lhODTP/MzwEaQQ4ldnZ
X-Gm-Gg: ASbGncvJRJ4pLlzK9LgrNC2wV/ED0kipIDSIuK7wIdS5Ov52hmVQcdkns/puAQoUpg9
	Rqk49QOxNKWmjOwes2BaQIiWcmcouJOaYZPOEkM2m9hhH7oJRqwNxaRMpxoJ5fI/LmY5MQf+SoV
	IKP/BwiTT+9X9E2UD1xBlidm17c9LBLcK4OeFSKqPuXYU5KvT/aR5Vgf8nD8q4zFE8LKOP9u95D
	HFDXgDYapver+Wh/x8x5HcwKX30aTSAJi1yDQV/01h9bmySs16wDmok5kpF9BvpG0hR8wX7OWuC
	xQ3T6jLWPjUVF3S3ZQxbzDRgVevuBspF5dl63ePgnPtY+oiFHl48Dx8J4PYpDOoIsAYLfrHspLt
	hQPZrKLH0UlGT37oGvoK3dMbtCvMzLa52MMJMKLRnpdqaKGQOZriMRvnyCQdXOgIcAQAfcJEfsD
	WxT6fa3qBpPg==
X-Google-Smtp-Source: AGHT+IGKDOG/htkg88QurgEqahiheGSgbLgkX72OZRCdDB7aWwdm+ljZ0o8LrdaoJpmZBShwLpIL0w==
X-Received: by 2002:a05:6000:2501:b0:3ed:8e48:640f with SMTP id ffacd0b85a97d-3edd43b5ffbmr6074067f8f.8.1758291207306;
        Fri, 19 Sep 2025 07:13:27 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f0aac3fdsm84247105e9.1.2025.09.19.07.13.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 07:13:26 -0700 (PDT)
Message-ID: <19aebe91-a266-430e-a9ac-881cd782f3f4@gmail.com>
Date: Fri, 19 Sep 2025 15:13:23 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/3] checkout: provide hint when failing due to another
 worktree
To: Gabriel Scherer <gabriel.scherer@inria.fr>,
 Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20250913141327.2775228-1-gabriel.scherer@inria.fr>
 <20250913141327.2775228-2-gabriel.scherer@inria.fr>
 <be510685-3be1-4f71-806a-6b580bb1cf21@app.fastmail.com>
 <d44109a1-0ff5-49f8-885b-9aae195ec492@inria.fr> <xmqqikhkhzbm.fsf@gitster.g>
 <0dfe3e31-5486-446e-8af5-20669c06ea64@inria.fr>
 <a27a8191-55d7-4b60-ad90-59ab946340bd@inria.fr>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <a27a8191-55d7-4b60-ad90-59ab946340bd@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Gabriel

On 17/09/2025 16:25, Gabriel Scherer wrote:
> Dear git developers,
> 
> On 15/09/2025 21:52, Gabriel Scherer wrote:
>> (This gets me to wonder if a desirable behavior could be to 'detach' 
>> the other worktrees that had the same branch checked out, instead of 
>> failing on checkout. Users starting to use the other worktree again 
>> would possibly notice more quickly that something is amiss.)
> 
> After the new feedback from Junio, I wonder if I should explore this 
> suggestion more actively.
> 
> For now my goal has been to make --ignore-other-worktrees more 
> discoverable, for people who are willing to take the risk. (I am 
> comfortable doing this as I have used this workflow for years without 
> much trouble with the 'workdir' script, but clearly you want to be very 
> careful in how exactly we suggest that it is a possibility.)
> 
> Would you prefer a different option to detach the branch at the other 
> worktrees? This could be
>    git checkout --detach-other-worktrees <branch>
> for example.

In general we try to avoid having commands run in one worktree affect a 
checkout in another worktree so I'm not sure we'd really want to go that 
route.

> I did not originally consider this as it requires more expertise in git 
> internal data structures, but it may be easier than finding a way to 
> advertise --ignore-other-worktrees that you are really comfortable with.

I think it comes down to the same problem that we're not that 
comfortable with the idea of having the same branch checked out in 
multiple worktrees. I'd have though having some advice that suggests 
using --detach should be relatively uncontroversial. Suggesting 
"--ignore-other-worktrees" would certainly require some kind of warning. 
If it is hard to come up with a concise hint maybe we could have an 
expanded discussion in the documentation and have the hint refer to that?

Thanks

Phillip
