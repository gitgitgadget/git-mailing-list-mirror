Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B99A2222D1
	for <git@vger.kernel.org>; Fri, 16 May 2025 10:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747389882; cv=none; b=p81BZP1S01glMb0391+pfqlVzovKx8YzG16jAbj8YkkrUXZGFVuFM7Z6uqiBhydtUPxbgxCpJcPWTfMT7RuvPCyX09iZU35SexXL/cQbf5ucCO9J3xOqKs6EqUhC5hb8jQw3pTPfQJxTqmQ0I1vxy6vifDeBWjJXnHki5ZPr5l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747389882; c=relaxed/simple;
	bh=vTQkqVuKA51J6bmaq8JjJg11bhEQian5SrqpMlGEMQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pATiEZv6f71IKbj67XHO6yDeA3pFbF6AWogZDnY0WTuMrCaxvTKW/5C/xlfwSkFLZcb6WFybiKrps8QGnA9n8AdAYvSXHvrolOqVb8/1TqmkVfK9nfG1SSYv2CcKrmcUlAYgeuCZIM0X74DBryBqFTt4bycE5Yxou9IHbyXdJq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOF9PT0g; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOF9PT0g"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so19574765e9.3
        for <git@vger.kernel.org>; Fri, 16 May 2025 03:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747389879; x=1747994679; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0kVB/BuzPo2OLOqA/s2wP0GzbAGtypaO/FTW2cEGJqc=;
        b=HOF9PT0ga+s5HvaAReFI9VTBKxF9vCDaG8fM5iyhxyqWyBAwWGxp7wYmsM8a8mpjOm
         RhvhGesRrAybaCAkwXrePtcniEP7J3kpmR5jkFDBE/CpvpQDSCY2+mpjRS3Fg5fWEBNw
         DNBqLuQYiIIUgczTciIYAvyw+pkolkySazSDgehCqld5+1IRrfyRS43ELnNJ/ebQz9bf
         sHCYp2SU8gZLWHyNHm/XdkH0HYXBE+Ir0zFv3DZkp8fT/qxEgvYyihWhxWsSQEWZxDvH
         n+tR/7588sMb1kvpkkQ7FNXbPUWBa5ZflDOkezrdWp9e7VBt5GfK3UCD5wyRf3BuCq/9
         j1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747389879; x=1747994679;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0kVB/BuzPo2OLOqA/s2wP0GzbAGtypaO/FTW2cEGJqc=;
        b=p4gckDGB9OGWzdpBhZDCEdDL4Z7QnC+d3XEhqsq/iBmXNGWjQWaE6vnArYnyatM+qD
         fbpKjBJ+MT4VG9fsZPUXP6QmEomLEF2wu+br4mA01l6pD2IlOxmEtP/o3K7fVwqhgVPv
         wuVkyJdA1olp1O8kX1BJi9d9bqBq/bcTKmDMDhHnCTRb9wPZPMoYf0Oa/MZ6Ok4yc6vn
         UUxIqM08H5o0wOjQ6H8vek4HLU5VfHBWSp9mwgDsWAdYFTXYBBpGcixBVG3ZD7NT1qMc
         +LbEDerSnOFdHNIOSPHnJqBhuzkYov4oBqePnMH2vXAdJGSk9ZREszakU5e8FRVwNAMF
         heww==
X-Gm-Message-State: AOJu0YyApOIjzqJWq+AX0LUMRo0d+OszI+BishNjvMDDkvJ9jlEqNUi6
	oAe/vJVie66U9Z8C9RdcSznZI8zJHRn9wniluXU5ksa/fw0Dft4GgunC
X-Gm-Gg: ASbGncvckCmVje0sx/Rk1pmQUF+weM3HaSPzlpYsafqESFsM0QjR0VU6Rk4N27mHCd2
	sxIf3AoMPVJeUlFicsv3jvFlP4ev9nrgR2/F06ynJPUiIR29zcpEIQHKbNRaqQuUKN8pY2CTKq7
	J4wPBHpdu/bB3Ia22OiKXsmFSMUNwWKUif+r8z3ZLSZ/uulUfeQtMNBWNPN1igDovndi8HHZNkc
	CQUySlX0Fimt87732vR2Go/HRiFuCAHarcLUeCjzBDfJLJvYZGltbrvsAJ/qH9QfFU676vtacSX
	1JJ63tUqhM3LHSGn5NMmtHQBV/y2wy1krniv2ZIVzgzGXYpRb0qgvGLKmRF1JGWYkd7i4yflKbm
	k79d77aUpjcQlbVL3jo5N0BXOBPZ8Sf5PgDmazW/G7A==
X-Google-Smtp-Source: AGHT+IHT2AJVSsRaaYBLBcW9HExZSBvSr11S1Lb7nX1cr1+l/Y3wb7ZSlvkceU1NRl7wr/OOgf5yPQ==
X-Received: by 2002:a05:600c:3d11:b0:442:cab1:e092 with SMTP id 5b1f17b1804b1-442fd618f88mr27112355e9.11.1747389879116;
        Fri, 16 May 2025 03:04:39 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:8d23:ce23:3b:22a8? ([2a0a:ef40:700:a501:8d23:ce23:3b:22a8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fd50b983sm27412125e9.11.2025.05.16.03.04.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 03:04:38 -0700 (PDT)
Message-ID: <8b431310-ff03-424b-b24c-672d9b492057@gmail.com>
Date: Fri, 16 May 2025 11:04:37 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] rebase: support --trailer
To: Li Chen <me@linux.beauty>, phillipwood <phillip.wood@dunelm.org.uk>
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <196a5ac1393.f5b4db7d187309.2451613571977217927@linux.beauty>
 <196a5ad7fff.c587c495188189.5980390754046003962@linux.beauty>
 <951d3343-fe97-4e7e-bb73-1c569ff10ee6@gmail.com>
 <196d79d922d.127d7eb7f870411.3309775784450179401@linux.beauty>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <196d79d922d.127d7eb7f870411.3309775784450179401@linux.beauty>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Li

On 16/05/2025 06:42, Li Chen wrote:
> Hi Phillip,
> 
>   ---- On Thu, 08 May 2025 22:17:17 +0800  Phillip Wood <phillip.wood123@gmail.com> wrote ---
>   >
>   > (c) Only adds the trailers on the commandline. I'm a bit confused by the
>   > various trailer config options - the man page reads to me like "git
>   > interpret-trailers" can add missing trailers that are configured but not
>   > passed on the commandline.
> 
> About part (c), just to be sure I understand correctly:
> 
> Do you want the trailer implementation to completely drop any handling of trailer configuration
> (i.e. remove parse_trailers_from_config() and related config-based behavior from the codepath and man page/documents)?
> 
> Or would you rather leave the config machinery in place, but have rebase --trailer explicitly
> ignore all trailer.* configuration and only append the exact trailers passed on its command line?

I think I had misunderstood what trailer.ifMissing did. I was concerned 
that it could add trailers that were not on the command-line but I don't 
think that's the case. We certainly want to respect the config for 
trailer.<alias>.key and trailer.<alias>.command as they make it possible 
for the user to set "trailer.review.key=Reviewed-by" and 
"trailer.review.command=git var GIT_COMMITTER_IDENT | sed 's/[^>]*$//' 
#" and then run "git rebase --trailer=review" to add their Reviewed-by: 
trailer. I think it makes sense to respect the other config as well - 
that does mean that trailers that the user passes on the command-line 
may not be added because they already exist or are configured not to be 
added if they are missing but is consistent with "git 
interpret-trailers". It means that the user can set 
"trailer.myKey.ifExists=doNothing" and then run "git rebase --trailer 
MyKey=value" to ensure all the commits have a MyKey trailer without 
duplicating it in the commits where it already exists.

That's a long-winded way of saying that on reflection I think respecting 
the trailer config setting is the right thing to do after all.

Best Wishes

Phillip

> Please let me know which you prefer (or if there’s a third path I’m missing) and I’ll add the patches accordingly.
> 
> Regards,
> Li

