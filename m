Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328CB1BC099
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 18:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751482747; cv=none; b=X4+VlipVy9THN3YfeIYdXfmuJJqRqhr06IXmQwzVl8+Ris7vxclikMaryjSq2h1oZrJac5Yt1tJuAiL1rmqaUFmuZdWibtQQeh7gebbEy0vvha9Gb/o5i9FiJrRWOdsG+B1Ebz0TuKqIYo6/26DA1p8S95rF/xjeeYZ50s0d9B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751482747; c=relaxed/simple;
	bh=HXoJLm5pqg04uuiiaHlM0QaT5rkdOcB63hts76zq6ZE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R2ufkhT4TK6nrExBsr998LucXrb26xICi7XzLqDaD81ygGS1A2WRbgDn3syN+9wGZMJhoogkPo1stuDlUqMw7VaoHMR73+dPrIg72z5sbS8SL/GERDVDG6wA1mbICSy7GEtSq0SCup5ERrf3pm66MBCLyWgv5m9Uuxcd8Kq+0D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFOvwY4N; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFOvwY4N"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-234d3261631so52291815ad.1
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 11:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751482745; x=1752087545; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YN7a2ta23W2TQ1xs5OzNNCT1AqRJsFkU9zM1U3eEdVU=;
        b=LFOvwY4NuoFLucvO9BBq4VUwT9Q+qKQhPsCQjh2iWow2rsd3AXluzR7IilYHiMhDg4
         M5drpKgC9AQOC5nOvxS2qGfBbv2aqv5e+yZyoUi+QjiJ8OL+mUUg8U+xDnzHzUTfmo5j
         W5f19GxqTQcZB5xG/+N4Xudwy5wYdGjKcxMveHmTX0aBk3gjF1LsRk85GPa1JwZ/wr2g
         LBDDjaBGqgsF1y8lWmlT2S7iWaDMsDNoOCJnL2ySUOj87H+FPMd+vNbYifo8kUbGi/ye
         D+Bfbc84hIropozY8MRC52GGiWDUwAVuEh8ZDw4tR7I8yhiLDAyDsMXCmB0FOmXth6fD
         7Baw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751482745; x=1752087545;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YN7a2ta23W2TQ1xs5OzNNCT1AqRJsFkU9zM1U3eEdVU=;
        b=oaSIiMW2ryJND+NvshBYMn3XYHLuX40Mwh82k61O8RikCA0M41lS+15XMTjc2wtZ9D
         WvoHEPyZjLZY+P3/yFg84CdQW67EberRCHnr1mYm6aBqwor/HkEejG56derifBR1r7EQ
         8UdkLS6a9pll45hSu3yGdCF+iJSHCgyvDr6ANPtoLKMgsVE4CnLMbD0EipWMwG0r+xpA
         mThOpWO2oEYmQzZh1wTlcUdkx2t7aAlldkNTJnizoaUFzFPCzJYB/YOxhjMULPjmHPey
         Cv8T+344ckth/0Szjsq/zprnaJPDUJze0KmiEx7lv/2KMeZnR6E4J62PAdk1N74v6ubh
         H0+w==
X-Gm-Message-State: AOJu0YxGNSVXFuXFgGBni7S+ZzpWHtxYFdbAl90EdAiLBQB/OJiA1636
	Fx8EJxUBC372YJevkp2jIL68GbPkXM3yo4b7Mx/+2JsjP8o85I1pK3fA
X-Gm-Gg: ASbGncus0HMldknedXa3RZ5dgciW4WXoSz2kugiGgDDCXjKxYGGvZmH7EcAeXCBXape
	QLa8yATG7oiOYIAwWvZWzrIp+pb7lbaPI3qc/xjSYIozeRavA8TSNggISQRt3Yhw9EpDTnAzvTu
	6fxb/WSpfDZBxTdAxGB2xZMg07MVQ8NwJaxxg5pnoZja2nOxioT+dLNSpkMNAE/LcTvwVB6lVea
	TYur8fG5EL7NprRFPRSF3Fs6CMWnlBZukeEizxe3Lee5vKkR6lQHjlDgXgvKmV/fUFTCOKRmraU
	O1wtYcOFGDZqHqdpXWV0C11YUNNY7mctnZuCw94VtdGMZc4RHH5gHEshhXJwP6MMhJYgJMT4+dl
	7PD2oPNmUIALkFTTVbJLVwmpY3eI=
X-Google-Smtp-Source: AGHT+IH+cx1puBc0iKnsL6mAtpoeKhhuprs/IjI5i7RM9uaWkr8EaQ0MX6FGPqmwsVapDHqLlvSRcA==
X-Received: by 2002:a17:902:d48f:b0:22f:c19c:810c with SMTP id d9443c01a7336-23c79842fb1mr5473195ad.51.1751482745264;
        Wed, 02 Jul 2025 11:59:05 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb2f1d0csm132611345ad.56.2025.07.02.11.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 11:59:04 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Brett A C Sheffield <bacs@librecast.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] gitremote-helpers.adoc: fix formatting
In-Reply-To: <20250702161951.22908-2-bacs@librecast.net> (Brett
	A. C. Sheffield's message of "Wed, 2 Jul 2025 18:19:52 +0200")
References: <20250702161951.22908-2-bacs@librecast.net>
Date: Wed, 02 Jul 2025 11:59:03 -0700
Message-ID: <xmqqecuyctc8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Brett A C Sheffield <bacs@librecast.net> writes:

> From: Brett A C Sheffield (Librecast) <bacs@librecast.net>
>
> Add missing colon to fix formatting.
>
> Signed-off-by: Brett A C Sheffield <bacs@librecast.net>
> ---
>  Documentation/gitremote-helpers.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/gitremote-helpers.adoc b/Documentation/gitremote-helpers.adoc
> index d0be008e5e..39cdece16e 100644
> --- a/Documentation/gitremote-helpers.adoc
> +++ b/Documentation/gitremote-helpers.adoc
> @@ -498,7 +498,7 @@ set by Git if the remote helper has the 'option' capability.
>  	ask for the tag specifically.  Some helpers may be able to
>  	use this option to avoid a second network connection.
>  
> -'option dry-run' {'true'|'false'}:
> +'option dry-run' {'true'|'false'}::
>  	If true, pretend the operation completed successfully,
>  	but don't actually change any repository data.  For most
>  	helpers this only applies to the 'push', if supported.
>
> base-commit: 16bd9f20a403117f2e0d9bcda6c6e621d3763e77

Wow, that is an old typo that dates back a bit more than 10 years
;-)

Thanks for spotting and fixing it.
Will queue.
