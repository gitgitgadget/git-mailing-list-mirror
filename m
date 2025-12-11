Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0D923AE62
	for <git@vger.kernel.org>; Thu, 11 Dec 2025 15:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765468481; cv=none; b=PXBxzgcieD/oaCwgpxFPk2F619n7XqXsQXZtrxwxd2n41ScuLVk0ii3jZfUi6NJDX+JZ2FAl3EPsXU9xF98VShQEpGdtVuCaZAR9+fsf0dLYKXXseGPsV2fI2ggaZKkcc/p7Bhv7ywLRpTfXdtYQxSoJPJaohQNERZ6IbyQ6b9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765468481; c=relaxed/simple;
	bh=r+sbnqLC0bSyogweO+S/i1w1Oe+wKVMJiGbi/pbtLdQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=OThS+eKCRMxw/T0f6c9DjOt9fobfuRxGL+TANxElJtC412v9lfqPdZRg7pn9vQo1J365BFejsjLT93Vyt4+5NH2m3o/p3MJCRb7Nd/WxZtCz3ZaU4G81880RAEvmmJYUy962YR42WJmSYcZdpVMI3u3Hy72nG0aFOvACyjP9xxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LrkrByi6; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrkrByi6"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42b3c5defb2so176634f8f.2
        for <git@vger.kernel.org>; Thu, 11 Dec 2025 07:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765468478; x=1766073278; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NtFl7ipicuiJ7HtPJGo9a6ZDIIdIxcMr37m8s7JGYHU=;
        b=LrkrByi6PDGqQtNI5klbhH+zb1oVWbUEB7K4YIa0DOR0TX1iKFJ87K1H0OsjJJ5QP5
         0eSCyoyYlhyT/TZYmJp4yCeOMl8pCoyK/YNuvj/9V2lRH2/xAOZgjYonJri0kSeZxalh
         lq53i3BnqiQZ6Qq0X5JUFB1xdq2Zj7ksFZ4oftxEr1cuM/NitRwTp4PcvKu87/MTcOx8
         f4aOz/cte1G6ypBEYK/e31pI19s7bOIxYY1OP8xm3BhSCfm0Mjnvqt1V+6uEldwlwg3I
         QztnHrR9683um5QNoGn/+BhZ1l2YnDXrEg6oKDKrhU94wRUInDJ/3yk8wa8YStBqVnwg
         iV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765468478; x=1766073278;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NtFl7ipicuiJ7HtPJGo9a6ZDIIdIxcMr37m8s7JGYHU=;
        b=X8TO2wcs4qBNnI9MfkkQDQagCtQNHt9MykAr+IEJih1O6CWKaYXzYDo1UhLOwi4Ljd
         tVw93gdr1w5J4TFyfv7a46HQnhHrNKjzactPF7h4TSZPKP7GE2ZOyUSjc+v/XDUjSXhY
         B0ofVcR6Mnw51FqWFySLLNbNbVupZ6UXtW6MfLeHjHDJxkRogOXCbhqbfzZRLc0quhvD
         zjPRYIBBirhxTRi6YUejRUebWjGkIK0Q9Kr9u9tKS6LPBq4GmHZRHWyXuwljc1HcpIPU
         Xp631lxIYP4rpl/zpJb8EdLDKdnKTY/bSnueHn94PxqCMzJZb9Yfm60bg6BDkI7d6HVO
         37Bg==
X-Forwarded-Encrypted: i=1; AJvYcCU5qRRrMA9ByJqUDogOY3g6QU7RGHz5byTgmATQ9cF4z6F6eQpxGvEzujCGoYERwTf6qu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YywzwNaD2t3hxaxPxlz28y6GR9rrLwxduAO7oI8ZU7fHqJ0JWQH
	e0Af8Ge31yacSIiKzh816xMyuKqUtBJVkEflL74CdNHWobplhZLKJJAz
X-Gm-Gg: AY/fxX7UlxSrcgnTPvFEy1kqmO9hIZd1XcryFyOq6n+1wmRQgYn/5ViQiw6T4Ynok7a
	ojh8qDu8IGgRutbnBM5GHZ7AmJxsUVInCEBA01C+SdhRj0eSd+hmaALnFfdeXY6bJHPiVBCNw39
	9/p5xwkAMWCQWTwd0L8/kTeFecuOvHD+sQHP06dPvXcyK4S/4GbjRtjNViMsFDAgChjUbFa9U/Y
	kV6D/vy6+INJidRiX+OLAFwQMvOAndPwxX04DCVk8YsRdDIp+TQOqaKGPza3u6/FVDp3lhgr1uQ
	D5pE0Vs/N0VegjcNuSOc/HLXZto8k+ANC/xeZ0v+kgmVwicEtZsGZq/IUAbVyZF+lqg6gELX1R+
	FaE6oictsbnNTBtG0JzuPK91aT7HwjsRmf0L4WP11H2jLd/0Z38L2q1kZiyTmeOObKU7/T5Ebh4
	XfiMiO3RwqLh4AunbXHvZvAff4ISNAKWebFnvVTYoma3MKOSq0I+F/Va8BOzDiwxf0CQ==
X-Google-Smtp-Source: AGHT+IGzLK0ihqvO8T4djQlm+VBwI8MJU4Pf1bZM/C9RcIipeZ913gKSaGhlmVpZT7hLwOfssEVdcw==
X-Received: by 2002:a05:6000:25c5:b0:429:d33e:def1 with SMTP id ffacd0b85a97d-42fa3af7d8fmr8075167f8f.29.1765468477596;
        Thu, 11 Dec 2025 07:54:37 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8b85f81sm7191937f8f.21.2025.12.11.07.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Dec 2025 07:54:37 -0800 (PST)
Message-ID: <3a6f39cf-b35e-461f-84a7-85e6e7376d21@gmail.com>
Date: Thu, 11 Dec 2025 15:54:33 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: bug: `git pull --rebase` breaks in the presence of pushurls
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>, gitster@pobox.com
Cc: ak@akkartik.com, git@vger.kernel.org
References: <xmqqpl8lg0u3.fsf@gitster.g>
 <20251211053504.8758-1-jayatheerthkulkarni2005@gmail.com>
Content-Language: en-US
In-Reply-To: <20251211053504.8758-1-jayatheerthkulkarni2005@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/12/2025 05:35, K Jayatheerth wrote:
> I’m trying to make sure I fully understand where the fork-point behavior is coming from.
> I'm assuming get_rebase_fork_point() and get_rebase_newbase_and_upstream() are responsible.
> 
> And when we talk about the “fork-point heuristic” here,
> we mean the logic that uses the reflog of the upstream branch
> to detect whether the user has previously rebased or reset,
> and uses that information to choose a
> different merge-base than the raw merge-base HEAD upstream, correct?

Almost, it uses the reflog of the upstream branch to find the most 
recent entry that is a descendant of the local branch. It then uses that 
commit to limit the range of commits that get rebased in case the 
upstream branch has been reset or rewritten. There is a diagram in the 
documentation [1] which might help.

Thanks

Phillip

[1] https://git-scm.com/docs/git-merge-base#_discussion_on_fork_point_mode

> Just checking that I’m following correctly
> before thinking about possible approaches.

