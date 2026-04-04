Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB4F20DE3
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 17:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775324224; cv=none; b=t807tBwL4FqlFUBi43Zj4MdM0ZfIxsDoBtvXYF3pWhnjoFtlulCOoSwr1Ld6lmfrk+n3JvI7u0e/gIF6zsnOyiVe+4xn1hm3oZe5gNJe1w18efM2lPQqJ8d1WCVQt0Jt6MB5uWqbi9iEVlSSySkpMwlqWJgmt466w5cBaXqkjLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775324224; c=relaxed/simple;
	bh=Mgp5mnRM3Ph1QJBXJQadQ/gL9fr/wtAIJVhz+Vz0FfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e5eXpjVwFdYLKX24RNOY0YVutuk9U4VInyOoezffIaufUnLo5GDxFcnhVRMJG58ntdbQib7eOWbtVbttbRrNy9fu84jX/aSbW9NBz+y1Q53v4eDdONnm+Da7z1Ykn32pMFjSDG5x53DXVIoC2B8W0Fblo7NXPDL5HsyYn/BgeA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PID5Vi1Z; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PID5Vi1Z"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cfd44fa075so378607285a.0
        for <git@vger.kernel.org>; Sat, 04 Apr 2026 10:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775324222; x=1775929022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zm5h6SM6VwnI6JxufRJqVXQOot+wM+Y+1x1RMiCNuFA=;
        b=PID5Vi1ZFLXKYTGqQ4jK2/H/z8NxVfZY5UibMpBNDLhC1c83xjcn7L1fMS7XzQqqe8
         sfp6QZWT4Mh3nPZnW4GN+WQRmuXX++FYI0NUoGI+Gq8A4UKowzkOKk34ybwchrg0Wqb7
         czGb1pw3J8tXvbmqjksqglSeW4F7KXNTp3qySJ35sjerMekc2FkQpzP+XtviWfddhY06
         MP5Ml0iCwR9/8xMUYtuw2Q4lwhis7c+jvh++hJ7bkpAFZiat+m8NeGaP7/aa8GUuVKP1
         Qv7WmkSTUY4irEQGmp8lGsiWVqaFMZLmMNnsTee08VNsmWIX/T4WyRUESPXopmKK5Pu1
         VqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775324222; x=1775929022;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zm5h6SM6VwnI6JxufRJqVXQOot+wM+Y+1x1RMiCNuFA=;
        b=GaaJJ8gUppGXZR/En++e0u568GeiLRPv8bRyKvvyjtBE1LZ9enus1dBJfApec0gMJ4
         oesIsUDkxFgO0LegRTDI+HmSdoYpYgtMYwbAy8M0kHNzKZT/m5b073frQxXdt4YgTPo8
         1s+a8eyOgldZ1ivpY7VbYCFylBtsXU6+uKtFeLPVrmVtZdVDOKk5cxVthVZGx1zf3+41
         kQAd63J6aHVjW8/sDfqPI+1AS5HHlkiqcghqXGfq+j8qTErjzZnsbGnnvD+Uvp3qtx3s
         SV9sUxtpAqaNT9A+kPRCjsecxxOU48/B7sgiETrWWqHimhyKVScyMZnNRT1UFAHUtDUv
         aW5w==
X-Forwarded-Encrypted: i=1; AJvYcCVjFqWeAAj8oyQQRRVrfdIAlnNGMdj79j0z9NWKrft8Cb5X+YWxjznbOB2EyCLVXqXZ0Rc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZYjRK9iHUFY8fcB5Wz47xNS3ZiHcj+igYEBdIDygauwzthGK/
	j1zuS8sFPobiydAtQD7w8UkY3EvJtUearafHtmqXeG5fiwAcmrPH/sP+xJu9Bg==
X-Gm-Gg: AeBDieuHpu1J9UlxpcpdrbkbYi4nDRayFOGI67xBXRQkVLP9cOufKEmLlU4LUBA9EM7
	kWrSLE1rV7FZykzW+fMn0mcTpfZYNeOY/wW0w43GvG66CLXyn+zmzqZ3XpCSNnf86hCazC1iRXj
	dc4SIa3k5toGwQPTRCpPTZfphUOXNHpoKha+v0rrppYrUqbHnXNyS/ZApQEDcGbxtSyFrS59FrF
	tJWeLIjQL01eQHlgXPZpxMcN8H5q5Jmm9pRk6j60uOdSWyRrAsbQYZwgGvcFTZVsJfaStZftWzu
	TswwZq+HJfXjUcNjXOG+KgIoPRGuo8ZdarBzLcW9hUyKN1Qh9Y74yU3JxRfjKZEhGSIYtuC8vZu
	EKpppu24Fe0TfGvV61b9AOW7zLuyWKTkN7utP8qA5G9qRvvN6jP4VpajK6cJeOL7bURY2huCemN
	MqvFB4GxpbvdEmrJXdP4UpQc8+YE6aaEqHq8v1TyfGDwXjeCAKlinNd/V36/S2k1TvFDDx8JA=
X-Received: by 2002:a05:620a:201b:b0:8d5:bb98:f3f3 with SMTP id af79cd13be357-8d5bb98f8a0mr311112285a.15.1775324221582;
        Sat, 04 Apr 2026 10:37:01 -0700 (PDT)
Received: from [192.168.1.254] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d6339bc438sm99296185a.26.2026.04.04.10.37.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2026 10:37:01 -0700 (PDT)
Message-ID: <e16edc29-a281-42f8-a712-4114d6a3288c@gmail.com>
Date: Sat, 4 Apr 2026 13:36:52 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC PATCH v2] backfill: auto-detect sparse-checkout from config
To: Trieu Huynh <vikingtc4@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com
References: <20260404111557.17220-1-viking4@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20260404111557.17220-1-viking4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/4/26 7:15 AM, Trieu Huynh wrote:
> From: Trieu Huynh <vikingtc4@gmail.com>
> 
> Commit 85127bcdea ("backfill: assume --sparse when sparse-checkout is
> enabled") intended for 'git backfill' to consult the repository
> configuration when the user does not pass '--sparse' or
> '--no-sparse' on the command line. It added the sentinel check:
> 
>      if (ctx->sparse < 0)
>          ctx->sparse = cfg->apply_sparse_checkout;
> 
> However, the ctx->sparse field is initialized to 0 instead of -1,
> so this guard never triggers. Consequently, the repository config
> (core.sparseCheckout) is never checked, and the command always
> performs a full backfill even when sparse-checkout is enabled.

Thanks for adding this context. This patch LGTM.

nit: it helps to reply to your previous version [1] so the history
of your patch series shows up in a single thread. No need to fix it
now because this version should be final. I'm a fan of using
GitGitGadget to avoid making these kinds of mistakes, but you can
use 'git send-email --in-reply-to=<id>' [2] in the future.

[1] https://lore.kernel.org/git/20260402191359.11304-1-viking4@gmail.com/

[2] 
https://git-scm.com/docs/git-send-email#Documentation/git-send-email.txt---in-reply-toidentifier

Thanks,
-Stolee

