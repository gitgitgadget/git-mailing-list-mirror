Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3ABA1FC0E6
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 09:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749115550; cv=none; b=ez4aaX6qh2FYtDnkJlcy/+EWW/f578UqW/BXDS6Fyot765qLXHlKoLRdbAGGUDU3vRNx8cAyxAn1MxRpYwaZGKKwgPZznzLJHro3U4gC9sErUUkWIXFc9AALb21yHNfynMtfGaNCEMyhz0YaRrxPFsF2r8uKr8R2teVL9f07F9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749115550; c=relaxed/simple;
	bh=YuGqQhloHgXTbXiQmLgVjkegoE8A9VSQILSqv4Vds4k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=S++4yC9BZM3by1L3Bs/TBPUzBgwBdpESuGFx++0xUfymeo48eGEnm1lhjvRiiVTnh+WdNyPIf2CeF3bQVxfO1JdHNq/9ozlT3m7dpZuQ5nRQ35JvTjtN7neeh2nkcxRHP2Apy9+B4QDdtGD4eW4C4Gvow44BPCMA5H0ziaF6Zq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eeHInrJp; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eeHInrJp"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-450cf2291bbso2402085e9.0
        for <git@vger.kernel.org>; Thu, 05 Jun 2025 02:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749115547; x=1749720347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UFXAENxNfMURfSdRs+aOBA0sjG7Duih40zSJqoU2ZIo=;
        b=eeHInrJps25nB1cs1rYXHyvhkyXn+eggCqJ/C4gDR0Ht/e2dwCtCw1vxGrKqMAr177
         tX8df4bFZggS+xra22mh5i5RwIpOUpVX94QZW1xiFnbirJdixj+S4CL7yqJWAVn3sX5j
         PuwecaDPunSPLDOj1OzqDKlRbVxwE46uzqBW1DGi7tXOqoQakSNDC7LMid1wklsz9sby
         Qcxdhz17kptKxYIDd0eGaJrrW0PfOoifYL4NynjwxUJcVOQGpmoW7ddKlkP187yHLh6I
         R8IYvQbl2mdaly2P1+X3HzgRnrHkDKFhz3iI+QIAycDzspzsn7Ceioa0qVfUmEB+mGws
         mkeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749115547; x=1749720347;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UFXAENxNfMURfSdRs+aOBA0sjG7Duih40zSJqoU2ZIo=;
        b=fiPQW2e9JYOBGGDbZFQsYiCumSL/WdDSxKL3bFGYmtzbJpQhmQWA+Kq1UpgMvxkY+v
         w+D4kYjjKMHNeV/pBpl2AQ8JTl94Bz67ymGtK1BczqrewkjQzo9vN7Z50KOGTQn5wQ7k
         soaVOtjc5cwK+pipPS5xWK+OX6EEGLwYH/GoNHH2t9UM6N7Ru4LYu7kJWwKBueixplln
         89clR8C0sGkleFAnXrj0AZ2ViLcfOOSV9jK2rxN0Q9Ydom0Ai/7ov5gbHD2UydmEbcAU
         z5X1NmT1NEEiM8HLASyrTSai8dDPAdWA7hvq7K+BDpbuCBR1vOzkMncZVP5Y2UMbNexR
         GL3g==
X-Forwarded-Encrypted: i=1; AJvYcCUq+GRauNNCkZD41Nr9zBlTkojy6z5jV0wF8KFCsahVCR7SEeKb5jPl80/7FD0CkihjkpM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo8YvPFcPr0k/amsqY0DDFvWUnFRSFPO+DAc+7/hMA4CUA70gq
	WE1D7dp/2uTc7K9G/SUTE3WbW7qP8se7Fai8kau7ndJ7jg6xBmrxhPQwEHg23g==
X-Gm-Gg: ASbGncuzsth0jNzXmxZPX4mJ8BaRB1l+m/8sBjcsm0ZslL7GpaOLPIyfWV9GRopO9gP
	umulTTF5/EqAnnUMf0c8565oIKVgN8yqtH/YB8KNS3f2diVgBHbNJ3G/I88UFVpKFgmAlPjzYni
	O9Fx4Dll4ki83K9FlBCYI0dF1Veekeuj7iMOIA/jV8pQSGj77hprrfh+E6BRjp6qCbHLGJndOoD
	ZoEeho42oYD3f7xBo2hxLFbzCzWCk5ANk5XgUPimDl5c4QIuZYWyOmsix4dfcfwstZAd+P1Bejf
	bml6yz+rFH9afIZTSbUnPsXlyEHmFknKL49EaEw+FcH1T5995cEQUT27KIfuwAk9SPpx+2CD34/
	7DxZHN/tBhZI+ciSIN2i5Wy0RTYw=
X-Google-Smtp-Source: AGHT+IGMC5dlQGjwBFYtwOtOxYQCKOuu8LPUJ9U2zF0RPueCra09YyAVtJy0bmSHiyC1FlNZdBhb/w==
X-Received: by 2002:adf:ed0d:0:b0:3a5:2b75:56b3 with SMTP id ffacd0b85a97d-3a52b7558fdmr1021635f8f.24.1749115546878;
        Thu, 05 Jun 2025 02:25:46 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe5b8besm24285353f8f.16.2025.06.05.02.25.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 02:25:46 -0700 (PDT)
Message-ID: <127d9d03-e94e-4928-9c6d-07a5396ca325@gmail.com>
Date: Thu, 5 Jun 2025 10:25:42 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v7 3/4] builtin/stash: provide a way to export stashes to
 a ref
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, "D. Ben Knoble" <ben.knoble@gmail.com>
References: <20250522185524.18398-2-sandals@crustytoothpaste.net>
 <20250601223225.464076-1-sandals@crustytoothpaste.net>
 <20250601223225.464076-4-sandals@crustytoothpaste.net>
Content-Language: en-US
In-Reply-To: <20250601223225.464076-4-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi brian

There are a couple of points outstanding from my last review. The first 
point below about the option handling definitely needs fixing, the other 
is more of a matter of personal taste.

On 01/06/2025 23:32, brian m. carlson wrote:
> 
> diff --git a/Documentation/git-stash.adoc b/Documentation/git-stash.adoc
> index 1a5177f498..e8efd43ba4 100644
> --- a/Documentation/git-stash.adoc
> +++ b/Documentation/git-stash.adoc
> @@ -23,6 +23,7 @@ SYNOPSIS
>   'git stash' clear
>   'git stash' create [<message>]
>   'git stash' store [(-m | --message) <message>] [-q | --quiet] <commit>
> +'git stash' export (--print | --to-ref <ref>) [<stash>...]
>   
>   DESCRIPTION
>   -----------
> @@ -154,6 +155,12 @@ store::
>   	reflog.  This is intended to be useful for scripts.  It is
>   	probably not the command you want to use; see "push" above.
>   
> +export ( --print | --to-ref <ref> ) [<stash>...]::

--print and --to-ref are documented as mutually exclusive but that is 
not implemented in the code.

     git stash export --print --to-ref refs/exported-stash

creates refs/exported-stash but does not print the object id. We should 
either ensure they are actually mutually exclusive or just allow both. I 
don't have a strong preference either way - I'm not sure it is 
particularly useful for the user to be able to specify both but it 
doesn't do any harm so long as we honor both options.

>   
> +static int write_commit_with_parents(struct repository *r,
> +				     struct object_id *out,
> +				     const struct object_id *oid,
> +				     struct commit_list *parents)
> +{
> [...]
> +out:
> +	strbuf_release(&msg);
> +	repo_unuse_commit_buffer(r, this, buffer);
> +	free_commit_list(parents);

I think taking ownership of function parameters like this makes the code 
harder to reason about because C has no way for the function prototype 
to signal to the reader that the ownership is transferred. It would be 
easier to see that the list of parent commits was not leaked if it was 
freed by the caller.

Best Wishes

Phillip

