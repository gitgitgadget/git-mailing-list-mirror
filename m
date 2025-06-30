Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA831A3178
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 18:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751307468; cv=none; b=VqB9iB8Pcv0kGAjOvf/ptX6PynP8evD2FxW5FXqIExDYtuwIDH2G8rxAaI9S1zZq3TJLditYkIdvJmMN7ct2c7Wj+7upZvpeVP3NH20xjc3yZPy+g99wYcdq8JUQK8neG8SflFTG9GGSsSs1mdmU+KONKWI3PCqm7RN13pJW2E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751307468; c=relaxed/simple;
	bh=Mx8r2bM6NBNBu/HoKV+lW8y0XPeUp4QAj8tYsZELf3U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MwBaMotoSKjPCWwyQCPysZ1S4drSajPw02vAF1pTEvMaTkK3tQ/nAwvXfbkex/XnRX8s4eebcbca3pPzYU3rEnsaWrxFRboFgURpi/33hEmE+6NBomRpUyw5AqQyUz02sBdw3JAjMSOep74np9qLuSAbK+GmoNvhcBGL+Qz7sc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zv1+mYYR; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zv1+mYYR"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2353a2bc210so20452265ad.2
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 11:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751307466; x=1751912266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WQAB2OYUReJnh1WDthE3IiopcDoPCtYuuyVc076BbE0=;
        b=Zv1+mYYR9enZHVdZ/FszmNLEEn6e0cPMzplSZhppKKuN++739ELlFtfdacMyXZjmDA
         f3KOTX73cuFnU5xyxGqdjs/yds4WNm9ZpvXzqgDvasHSZScMRjDDZgM5qoMA/M5SK8tx
         av1+tyYKxVjpaxEl47/Xg3IfWgMI3GJnIrAY8SkQ6Uzwn8NYzd7FSja1kQX1hvgevFN4
         uU6dA5/j2PxaT+5OmbyyGTA2iZY84l83p5Yi2JxZEbtac+jKpdExdMARH4z8cu5iq0w+
         7hNGP1X/958NYhb9O+jDqJTLuxlan76JSDlVoivhVn6i8a2fcIigmmpBvhgvMIOo+ltw
         wy5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751307466; x=1751912266;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WQAB2OYUReJnh1WDthE3IiopcDoPCtYuuyVc076BbE0=;
        b=BHRXFR4xetAXGI7zPtLVeueHdHXN9lSiKwIiTacer/3DD3XqCzILimBEAS2PF7mxfm
         ZLkCY+rQazGZhiB2KzFVh7N+7QfNZ1QNdVJBs5AVRPSUVNrtvU3Phb6EYN3W9dbwkW10
         cJxd9uSRtunCfR8eDYzFpfdgIxDqTfOOAYYCbqGi+6Ft/0H9zYNb92vmPx13lvOcm0Y7
         rOfct7b1X7qtb/iZBLFMg4GH6iaKFf7I/kH5uDlIayQ4JJEkTIm5Yft5FQ+WSO2RU9lP
         lj40VZKawr6PpOcHmWLFxA9OxNPrL0eIMvIuZXFT7Y0p4Vm2nWmIwRTioahTgDZMXVr3
         boNA==
X-Gm-Message-State: AOJu0Yzc+jgZ6/OtHBPe/+WDdY8SGF2qaxilNne7w2fuKmcPU+UrZM2/
	MIvw7PuPo9M9UpD6hWt+O9ZVt+308tlVrB6mEt4TflNPJdikDltQTP7L
X-Gm-Gg: ASbGncuPyWuA/9MhRD4sX0JNQPheRZB0UydUIHnkz02AfRP0WhFpEdT4dH/YU2IPFIQ
	8oL5ObXJh90KdPRC9RWKwDUzmIqE5j0gNNjqYrdYRG05FkIGGHO9tqHXIH2iKek/c90r+CfgOLi
	XGhi3gnP+ZYwNqha3QKri6QlF/agUpYRCpgFY3UHY0tD7jVN40J7awrWz3koRcqDiLXSyM0pAT5
	1CU89xKLAImL+JxhYxzz47+av36S1JDt29BenT6LnbNxO48C+BLHAiCj75Sct/u3wsa/0y3igg/
	m/7ZLAfXeoSjRfIsoUgPDRqo15fFriwVzjLTmPAwD3VxASyuQD/YfSNz0T/DrIkjhh52uhtqF5Q
	1IvszXX98M+Ao/eE/7Dw0ELY1VAlsxmoICJ/qdw==
X-Google-Smtp-Source: AGHT+IHO85AZ12lK6ONIRJNQerLiVYL2B75pr0AJQVBQhANJkaYGjjo66nIBCkC5bebX+TDi5v9B/w==
X-Received: by 2002:a17:902:f601:b0:235:c9a7:d5fb with SMTP id d9443c01a7336-23ac3deaf2cmr227647775ad.16.1751307466017;
        Mon, 30 Jun 2025 11:17:46 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b34e31da8f7sm8650419a12.62.2025.06.30.11.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 11:17:45 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Jakub =?utf-8?B?SmXEjW3DrW5law==?= <kuba@kubajecminek.cz>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] doc: improve formatting in branch section
In-Reply-To: <20250629190445.10185-1-kuba@kubajecminek.cz> ("Jakub
	=?utf-8?B?SmXEjW3DrW5layIncw==?= message of "Sun, 29 Jun 2025 21:04:45
 +0200")
References: <20250629190445.10185-1-kuba@kubajecminek.cz>
Date: Mon, 30 Jun 2025 11:17:44 -0700
Message-ID: <xmqqldp914c7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jakub Ječmínek <kuba@kubajecminek.cz> writes:

> The 'branch' section of the git-config documentation was missing
> inline code formatting and emphasis for the <name> placeholder.
>
> Both changes improve readability, especially when viewed online.
>
> Signed-off-by: Jakub Ječmínek <kuba@kubajecminek.cz>
> ---
>  Documentation/config/branch.adoc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/config/branch.adoc b/Documentation/config/branch.adoc
> index e35ea7ac64..a4db9fa5c8 100644
> --- a/Documentation/config/branch.adoc
> +++ b/Documentation/config/branch.adoc
> @@ -69,9 +69,9 @@ This option defaults to `never`.
>  	`git fetch`) to lookup the default branch for merging. Without
>  	this option, `git pull` defaults to merge the first refspec fetched.
>  	Specify multiple values to get an octopus merge.
> -	If you wish to setup `git pull` so that it merges into <name> from
> +	If you wish to setup `git pull` so that it merges into _<name>_ from
>  	another branch in the local repository, you can point
> -	branch.<name>.merge to the desired branch, and use the relative path
> +	`branch.<name>.merge` to the desired branch, and use the relative path
>  	setting `.` (a period) for `branch.<name>.remote`.
>  
>  `branch.<name>.mergeOptions`::

Looks good to me.  Thanks.
