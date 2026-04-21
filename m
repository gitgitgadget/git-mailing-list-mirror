Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC783D6CC2
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 14:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776780814; cv=none; b=s1D+tCjqMVh2NFJ+7CgXhnX4bZ2gEC7kQKaac6eVMICVHXoT+1kO0hOqD+SymGEAqp+nrNsNRfBJQuMzWO3Cz7XCs7Ld5mDrbb9oVIfx3TAV5bH2yo51d9GwhWnuHDgSh/s0MnYvSXNF7bYO6w2WD6ir1KQ5T8/9DgPdqSINlc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776780814; c=relaxed/simple;
	bh=h1BJ+tY1GwVjEzi0S58QxPtqUW8xZvaF8Zd8BK54PV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GlmzXdOVFP3I3q8wWHI80Q/lV3OogCUo55t+Zj6nR3ZGg6A0tuLBasJ6HuqhYDu+x8bYHqG1o7aXMZrmVhTOlUReds7j85QKuyAw86A3+PZpZouB8aoR2mNDGxct5Vj0TREGeg/VouNcSvTQQMfsfQnQ/S4DMatIOXtlYIQjnuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLV+El4C; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLV+El4C"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50fb1ad3734so7253491cf.1
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 07:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776780812; x=1777385612; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KZHXpMSDv/RZXl2By92i+uWITvJUJG7B8CneHFLRGvU=;
        b=NLV+El4CVah5UjRYih9KX6FhplZMBKFNVSW4VEzraONYiuiSe70SqQgsURfB9Ewhd7
         GRZYaT17neNPN+WG1UWxq3PojsMZVle6o8PskTPZeQaP4OS8AXdS8uSBdwb9J4QQbwgw
         pxZibFLleaZ3g0cUnmkjuP0d5Hv4iz76G8k5FsmSi9AWe84//oybCmKkeo1lnS+vnd1A
         /JpvvK1ZHWIXNwELuh3O6UJbxcspp370iUi1YOQV4btYW67eMikZS+TFVFwnpj3zPQbN
         C6JjqiKvBzbJyCWRU32SlO0PU7UWcr8eQm17SccpSc1XNKjFWVbsNp2l0Ho9a2v/QHYp
         bugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776780812; x=1777385612;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KZHXpMSDv/RZXl2By92i+uWITvJUJG7B8CneHFLRGvU=;
        b=SDJR48fsEirHTtBtlRDDZNLdLvU8g2O8Uxcf9tCDn3T/u7W8R1yVBxhFt40X+3jPkZ
         lLlPq8K2oY2FwGFUZ8BxSEKXMAvbcD/EsThJ7B5emZWPqJFqahEkxslFP46qtKcpTKS0
         SquyTc9REX58NWfi/Y02MpjDo142rXYG5/FDzS45tMTwaNASGgtWNUGWFHSCsJiDJ5jR
         biUEaZVTgkSWIQ2f5IxBhNqG73iZQ4EUQHxvP5AuaDZmf+eguXJps2EP8okT2zDDiOKf
         Gct/T9Q/awYt5G/ckoWvd/bSGCZPrGwOzJachtCDS/1up9p6XZqaScoOYfVKB6Fxs9AZ
         vYjg==
X-Gm-Message-State: AOJu0YwVgLEkLmGaQqRnGaFV1JRV2KdROfk+kalrwkHqgtweXNnrARcs
	52D7EUTUaLNuCq9mbZyvZUNQ93RaWWaAQeJwS/B60CImr7NuKe8ej89k0rojqA2Z
X-Gm-Gg: AeBDiesRrQXAraT+aH0r3g9cAmkTVliZ4Im7b2Lc0OIaqclADXCj2szMaG882QRszSl
	fuuIASor1G/nja72JRMKlN/2/hXTHf9Y8glpv/yuIhfKpXJtqAxlIqd0EZYwx1qv+sbwXCVnOOL
	VV37VmInrxfFwNGj2KiAbEMZK985HS/AxNy4F5mUe64zRXb1UOmpSRpf+5UqB2LUa1D8Ahf/MMb
	pvzIi7yTb6zr4ziCDenbIi0duWyoCHpGYqtCwWFBiFaAWbBtrSmBh2+tIfFvdxS4b0Vw7/vlJ3o
	iEZPwExkjRO58hIvbKpZG8v+JLRZyI7jAdGTB8/A4tBvy3TenqoYFDA+1O5wJzQZva8nSZGhg4r
	gUZ/zK3uIiUXRhH2bOft0pFX6v9a4/7X7H3Z3C5fR5Ff5H9j1CphKYUaOZ/cMEAOi1JTyzRiNI5
	0MntezdsHk9NMVM/LB7obHoohtIU1FgTSJ2xgeBNKKzEZfoQSlCfOkfPA73ahduiKQhCZvtNR64
	3U9O93A
X-Received: by 2002:a05:622a:199a:b0:50d:84ce:e339 with SMTP id d75a77b69052e-50e36739144mr233566801cf.19.1776780812462;
        Tue, 21 Apr 2026 07:13:32 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e5d5ecffdsm53012401cf.29.2026.04.21.07.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 07:13:31 -0700 (PDT)
Message-ID: <4199e58b-d0fc-4240-9717-16c89ae73322@gmail.com>
Date: Tue, 21 Apr 2026 10:13:31 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/2] Move libgit.a sources into separate "lib/"
 directory
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
References: <20260416-pks-libgit-in-subdir-v1-0-03afc731df55@pks.im>
 <55bde257-ee25-4a7c-a17d-c902aa4f0324@gmail.com> <aecRW_nwBVM21CPF@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <aecRW_nwBVM21CPF@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/21/2026 1:55 AM, Patrick Steinhardt wrote:
> On Mon, Apr 20, 2026 at 08:03:44AM -0400, Derrick Stolee wrote:

Thanks for your thoughts on the earlier parts of my message. I think
you're moving in the right direction and I don't have further comments.

>> Did you consider moving these files, too?
> 
> My initial version was moving around remaining ".c", ".sh" and ".perl"
> files, as well. These are (almost) all related to top-level commands
> commands, so I was handling those by introducing a new "bin/" directory
> and moving them in there.
...
> So I still lean into the direction of doing things one step at a time,
> because it focusses the discussion, and every subsequent step is
> significantly smaller. But if it helps I wouldn't mind also going the
> extra mile.

Upon reconsideration, the files that are left probably have less churn
in the core project, so are less problematic to shift to a new directory
as an independent update.

I think the forks are more likely to have issues with these core files,
especially when they add new commands in git.c. But it's still probably
better to reduce risk wherever possible and this is one way to isolate
the risk.

Thanks,
-Stolee

