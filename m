Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB65D221F1A
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 14:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742223065; cv=none; b=EPlGiUEQibfXIWDFBTlTbFKSmRjxG8hkLtzgMSWNjZpSsv1TGXCdaGQAZXJnhBBtr1Sl0rNrRKDJcXTKZHMuQkJauLoMQm3u2/57mPRZMQNByrWsIe2UHo+5WYaS7rcqqNbbis4AwJCdm7IroQ3UZdrGxkOHNvRci9WyS3eBErY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742223065; c=relaxed/simple;
	bh=sZV/efoURznTXBZlTe7OBiWBP5GH01Bd9JuBAnyFoDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nVUUTTaw92r+hjM0dS+omnSNtEUz79Btc6cvI3nPPTTS3ECCSKM++/5YjO8NXqZW7KrJgLRC/SIh8oLyEnsTH1/odB+pgb41nooWCmHxS9l69/+R9e9xAfDb2b6coV51zfEk8HHaL0adGxohz4WJCWYROlfLke4TDmbXYAIjWvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alo4F/5B; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alo4F/5B"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-391342fc0b5so3796200f8f.3
        for <git@vger.kernel.org>; Mon, 17 Mar 2025 07:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742223062; x=1742827862; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mNiSvv7tmS67U4mY0MIyQ/WhNVekCMnd9SxFM5PCqVU=;
        b=alo4F/5BQ2jJlZ/JUHFuakXqeSSRqwP9qCxmq4v++n7juj2ni3Kfl0f/7knxLb5Oof
         alHBDLUDikxfhHVnZun/xYsRUwQYK9LASjE/KLGUiHfD4PVIgmIGeCih8/oPspJMg3zG
         WdQTESlSKkO8wgx0jEVK2KFIrOJDgp3tDtXixLMHCZBFv/3jIUs5SXB2LaAE4R4K9gzm
         Ks+5Y+dw/QknBvAu1r+4B0r3bNWpeEGU1+PUVPVdee1JDHdDwL6gDM6BUJirVw7jf89+
         c5RSBEkKpwweMZUVaMriYqoEV7XVIib5aMY8Z/pRpkn927aGRBPh2IzRNYfMaAPcRFhv
         s/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742223062; x=1742827862;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mNiSvv7tmS67U4mY0MIyQ/WhNVekCMnd9SxFM5PCqVU=;
        b=hZY4H0Ft+33bxGZEVKoQ4ABiLmbNhsKm4+1zM6kMdGLpOz9ZqbgJLLAUP0D74Swv72
         UPYhuUIbIRT0fgNNV6RYQa48zySw4y9ZmC6hJaazjJukQzf4hu4Cq97bWyXbUhO2MlRK
         AB6xtNcs0rlmSyCgzjFIJgpVFiMziKdf3Jc4+kpRD5Jr629wXxWnwZAOsD3vLAvf8cqp
         7DxqQYhKkqxjv91jKqrLKv8QYMBN7AtOMxEmx5evwEz3BWwggIUJ7KMtMWIShZiAdg11
         zW4ew7pClvXQkJS0htp+/xk+pZcG9qsFNXGV2WZNKp30KukSBWG6xVy2E67z47CTXbGv
         N8KQ==
X-Gm-Message-State: AOJu0Yx2HoQO3Yot8NTwF48O8dPYhkvBzSpqBX/iXY9w0in4+9b/+Qup
	m+MNhldZ1Y1LSk1u4nMGQzCp5H48fr7Oty1XJPJ2khw7sM8yPBEg
X-Gm-Gg: ASbGncsvSZHQg9ozetOi0P1yxS7VJ4OxmIjYrSJZbqEtlu3KK9sbxfTDNkAd7vxqWAe
	lGTNmrRqINBLic0Qfgnz5NHSxEg9O1C2tPtKxE6D7ksSbj26Qz6rtGjD+5wduz/vOsDI4Zw+ZPq
	JOV/zE7mD9sZhnPb8tbS9pcF7LAOY+7OImIbGuqJwf+JY9HKXflvcbwrculQrPV8rZjjZ+jD5o5
	ltC30KpP/InAIvjTycpJm4IABIJhOADk1dpqV4aPlZDyXB3G+cIJzmTaoPEMNbTJoq6jm/9eUod
	siloZ91HVcxhZESNeSjq3GMJ6G41cA8MUvfJOigEnY0P0XMVS6W+PVdfVDlo70UFgrxehYslsOp
	PhRrTHymjBsVWUrdzWO4C
X-Google-Smtp-Source: AGHT+IEj8M1gFBBQq/CYQwfhz6aeDOLGbv09fZOX/6rVFYhC7yw3Hmn0WJwDO1sNc39nf5Oyzkb8UA==
X-Received: by 2002:adf:e04b:0:b0:391:3915:cffb with SMTP id ffacd0b85a97d-3972029e6e1mr10338604f8f.43.1742223061777;
        Mon, 17 Mar 2025 07:51:01 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6b43sm15411456f8f.35.2025.03.17.07.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 07:51:00 -0700 (PDT)
Message-ID: <d341777a-a6e5-46fe-8004-9fe885321905@gmail.com>
Date: Mon, 17 Mar 2025 14:50:56 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] meson: don't install git-pack-redundant(1) docs with
 breaking changes
To: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
References: <20250312-b4-pks-meson-breaking-changes-v1-0-b89e9a59d228@pks.im>
 <20250312-b4-pks-meson-breaking-changes-v1-3-b89e9a59d228@pks.im>
 <44a3ad4e-fb50-447f-bb66-f43b5c5ae012@gmail.com> <Z9gqP3ng0a9Zfpqc@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <Z9gqP3ng0a9Zfpqc@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 17/03/2025 13:57, Patrick Steinhardt wrote:
> On Sun, Mar 16, 2025 at 03:19:48PM +0000, Phillip Wood wrote:
>> On 12/03/2025 13:17, Patrick Steinhardt wrote:
>>> +manpages_breaking_changes = {
>>> +  'git-pack-redundant.adoc' : 1,
>>> +}
>>> +
>>> +if not get_option('breaking_changes')
>>> +  manpages += manpages_breaking_changes
>>> +endif
>>> +
>>>    docs_backend = get_option('docs_backend')
>>>    if docs_backend == 'auto'
>>>      if find_program('asciidoc', dirs: program_path, required: false).found()
>>> @@ -479,7 +486,9 @@ endif
>>>    # Sanity check that we are not missing any tests present in 't/'. This check

I think this part of the comment must have been copied from somewhere else

>>>    # only runs once at configure time and is thus best-effort, only. Furthermore,
>>>    # it only verifies man pages for the sake of simplicity.
>>> -configured_manpages = manpages.keys() + [ 'git-bisect-lk2009.adoc', 'git-tools.adoc' ]
>>> +configured_manpages = manpages.keys()
>>> +configured_manpages += manpages_breaking_changes.keys()
>>> +configured_manpages += [ 'git-bisect-lk2009.adoc', 'git-tools.adoc' ]
>>
>> I don't think we need this hunk as we add manpages_breaking_changes into
>> manpages in the hunk above.
> 
> We indeed need it: it's required in case the 'breaking_changes' option
> is enabled. In that case we still need to have the man pages here in
> this variable because we use it to check that the manpage is handled at
> all. Otherwise we would error out because Meson thinks that we forgot to
> wire up this manpage that we found in the source directory.

Oh so if we have selected breaking_changes then manpages.keys() does not 
include "git-pack-redundant.adoc" but that file exists and so we need to 
add it to the list of configured man pages. If breaking_changes is 
selected then don't we end up adding "git-pack-redundant.adoc" to 
configured_manpages twice? Does that matter when we come to do

actual_manpages = run_command(shell, '-c', 'ls git*.adoc scalar.adoc',
   check: true,
   env: script_environment,
).stdout().strip().split('\n')

if configured_manpages != actual_manpages
   ...

? Also I'm confused as to how that comparison works without sorting 
configured_manpages. Even if manpages.keys() sorts the keys (the 
documentation at [1] is silent on that) we add some out-of-order entries 
to the end of the list.

Best Wishes

Phillip

[1] https://mesonbuild.com/Reference-manual_elementary_dict.html#dictkeys
