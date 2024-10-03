Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937762747B
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 15:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727968555; cv=none; b=PBT6gEjv5wiMJqIrHylhTY9EeF4rkDMXWjVXyy2i/ZXsTu4HttroP13g0O0m34SyUiJSBzJXCfKafofEgBPnO5qmTzM0Xz/fXhTdX7d/t9Pk3osb+WlbzrR0T4U95uhsyS08CNPoiQFQvgoTkEgBrcLSsjU2SYI9qVtumR9xv8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727968555; c=relaxed/simple;
	bh=c5b/Qk0bF2sWdyTjassLEs15XsEUI2bWixrOlucGm6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EaLQC1qCIA3AWWf4tLxqzP4jbVl7x6SOczsdtJT41/MuXdJ127u+nLXJbQ7LW4ZNqu/rf4z7+MEzW/jlCJTayeVMV4LA+hMeFc+7s3ASPX8eWIigo0VGR6wVyhTWUeEDPNIyDDhG26+L8wlit5tE+hWCzE8WBLMb8Mco4FR/U0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kiJTq/mY; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiJTq/mY"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8d3cde1103so142513466b.2
        for <git@vger.kernel.org>; Thu, 03 Oct 2024 08:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727968552; x=1728573352; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bd+r2AMiaqzWVXruEnMMgj2aiAKe/snmUFNsxclfQDk=;
        b=kiJTq/mYrC5Ota1nv/Xm135o7nPogGJ/f4sg/5mCrfyshbS8D2OCz7iHiPIUgP3bl/
         5lNedmcjIWabgSUQDV95F0eB/lUaxvfhdDkwdTLnhb54JGOw95R1UxwTJYlXsRE+vQCR
         8miIcKCgVwxBWCynFNXdGVCTFLfD+1mvFnxWPfSfABE6uvyq5XJFXnkJcxxt1A9kauoC
         j2KMV3W2/4ov3BJEJnv+KuJDk0sx2SCHz1Pf6QIjUUaGUb/AsZYOPa+9gXbpXbIdwWc4
         e8FVNjpz1V50tfdsn8MmUEnIioCV+jQA6f9n5HZg7Ur/PHKukPJHl1NcupAnPS6V8DRK
         U8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727968552; x=1728573352;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bd+r2AMiaqzWVXruEnMMgj2aiAKe/snmUFNsxclfQDk=;
        b=OC1Cps/9okcUlPfv84NuTN99Tvq8U1Z3ntf80j1pu/+ndOnPhzJqAORlCHPFBB6cIX
         Ns/N1vWay0AxFvKCfWPMLIP04pNMY20woF7ijRUDIM1VTFnNb6Nb8a95ec+xQtuOkzAP
         NmqKG3vWIxccIZf6iu5R2xnVWizHRZQjXY6t89C3SAAGoQgvfE/kZbCTrHtBoaiwAlgu
         i0GsKaGKlLb9pyID70EOurW0PfnHPbeITD9S935gONOzUi0RnWqj8w8f8T8rYn570lIB
         ELInITc1snuCpr5In537kzdptRgTdJ6Z/rHDpqQoWA7qmnbIWYVo0Rnrxzi9fQbqfws6
         fIlg==
X-Gm-Message-State: AOJu0YzablCH7veZedPhiU2dV7mNOw+41+PQWUFFhfJD/phgOHF+5HN6
	AfK7z6yz0+eRNcaSTy6rRYfxBCotGdCFipv1vpUbHN4ojhJOsnLE
X-Google-Smtp-Source: AGHT+IHEuM5E6Hp1aP6PspjiWxoXorpH1ob+OJwlDIF9uDA2lnZ0aMX/tzs5uut4LM7JxAkRapFRGw==
X-Received: by 2002:a17:906:f591:b0:a8a:837c:ebd4 with SMTP id a640c23a62f3a-a98f82600famr752150866b.27.1727968551587;
        Thu, 03 Oct 2024 08:15:51 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:61a:f001:1402:4f50:9447:3e15? ([2a0a:ef40:61a:f001:1402:4f50:9447:3e15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99104c6785sm96074266b.204.2024.10.03.08.15.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 08:15:50 -0700 (PDT)
Message-ID: <cf2ad192-928d-4bc6-974f-da5b217fba30@gmail.com>
Date: Thu, 3 Oct 2024 16:15:50 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 05/21] t3404: work around platform-specific behaviour
 on macOS 10.15
To: Eric Sunshine <sunshine@sunshineco.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>
References: <cover.1727881164.git.ps@pks.im>
 <00fd829833cae1d192d6c42237aa13427156e3ea.1727881164.git.ps@pks.im>
 <CAPig+cSqeKJX99jbxouJZHdGZuyAgNz-wOgt+0C5OPvW3MHgLw@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAPig+cSqeKJX99jbxouJZHdGZuyAgNz-wOgt+0C5OPvW3MHgLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/10/2024 22:43, Eric Sunshine wrote:
> On Wed, Oct 2, 2024 at 11:17 AM Patrick Steinhardt <ps@pks.im> wrote:
>> Two of our tests in t3404 use indented HERE docs where leading tabs on
>> some of the lines are actually relevant. The tabs do get removed though,
>> and we try to fix this up by using sed(1) to replace leading tabs in the
>> actual output, as well. But on macOS 10.15 this doesn't work as expected
>> and we somehow keep the tabs around in the actual output.
> 
> I presume this nebulous explanation is due to the fact that the reason
> why macOS 10.15 exhibits this anomalous behavior is not yet known?

I suspect that the problem is that we use "\t" which is non-standard 
rather than a literal tab character in the sed expression.

> Although this works, the problem with this change (and its sibling
> later in the patch) is that someday someone is going to come along
> (say, for instance, a GSoC applicant doing a microproject) who submits
> a patch to (re-)"modernize" this test by using `<<-` to (re-)indent
> the heredoc body. A better approach would probably be to retain `<<-`
> and use q_to_tab():
> 
>      q_to_tab >expect <<-\EOF &&
>      Qrefs/heads/first
>      Q...
>      Qrefs/heads/third
>      EOF

I agree that using q_to_tab is a better approach here.

These first few patches all look like useful fixes in their own right. I 
might be worth splitting them out into a separate series so they can 
progress independently of the build system changes.

Best Wishes

Phillip

