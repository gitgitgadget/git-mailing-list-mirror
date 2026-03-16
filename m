Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF60138F658
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 10:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773658370; cv=none; b=XoM2SftPIeryp+PY2/entaZWnC+0Gn/JgXD5Smq+6Ut4KMtJ2wjOPAc4IsA5J3ThfvFXqTolhqwDvq/WXRnqUXPToHT8+Qxe/cBNKhciOTMltKx4ldo+yHpzmp276jao5bRx0ViRIqla44AgTQVFJEEtujfFfg4xyJyZjFkHCTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773658370; c=relaxed/simple;
	bh=MZV+Bk9Qa/kb3gcGuHBXiD790TfbHZQ8ZpTru2DSgkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T7hn4yI74ACLl1ujUZKZJIPXQlVqlRJaOglCvVAWrSXjwM5KPrWGP/29fgKK2hfIlQMGdHjE5a1mhA/KS8F37NjGN0e2bUDtKQv80UtRi7WfboEZNMCdiG5kmItQqHl0m6LvFm6oyMXI01BRGCJojm+zYTJVnzUwLIAMQOe9hR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gruIFlOy; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gruIFlOy"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48534237460so48997905e9.3
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 03:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773658367; x=1774263167; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4Wkv9OVG/qTyQzryiBa7HgFXSm8qL8wZhgZ4vKgzgHc=;
        b=gruIFlOyu/lklOOkHRytbHYHOE9cm9prAVEKA6XwE+R57YfpenOzIpr4SVH7MoOjLE
         lEL+vFF8zF72jjwVMJw9ESt2Da1A18UgbWtjqziNWruj1wo+KLpi9I9eRPBhqCD0c/lc
         bClVR3uwq3we9BA5Sh3pw/Zvs2CJEkQDRHu9N2H1oxQDZM3BCaXGv+flcE9J76QlQfak
         T+06Y29E7D+bSIrhYDF6oin4P5DnEX8275U7VWa2Yzav8niLIl+RGEewwkYLw1MtAtly
         DR0FAztPxmMBKmnl68bX3BvSw6RsMtaJE7IA3aF29oRf53OBQCM8wJGlq7C63shBaJEK
         8H7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773658367; x=1774263167;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Wkv9OVG/qTyQzryiBa7HgFXSm8qL8wZhgZ4vKgzgHc=;
        b=pGKk2hRAJJHL2itVtaFIpLeoQHEdJAqtm7YFVljSB+PY2NxJYuL1Kx3fJ5w0EjEqjB
         AzCGfUjSjFdHWmgI1fKrLcRmlZbXP6Sycu5MFq9ihfRHAgRd7j8ISWvGDvhi7wghw67F
         eodqVTRsDMtSjmJgEt+ouqHyjASFiwprU03eax1WQ7TuWeraFdybLiVLG2AHXZl0iQ7U
         nJhH6YG+7AjcHnHzGnJLZWafMLhOrW8Szb1spjwZdVAnkzpD66ikiimfN11BMI9xSqZu
         qLy4nNihMfaY6nP0KHZkQoLbB6rYJXFqXwPEwV9KhCCKodIADN3SLj6pltadpgKy0Wc5
         cNcA==
X-Gm-Message-State: AOJu0Yy+/t0axsYi0KCcP1Cye4bHr6+lmY4DBHfXcbKVQ+5qyPCQT/7P
	E8cNo6+8AQTLSpkOQd/9H9vqaBUPM6ePDdMK3/ZWRBE0lz0e71qVf2ts
X-Gm-Gg: ATEYQzz7pLi1l+uDNYID90Eui4kNgxw6+f25zRApCpHQHhn33K4hA2jux3KEGDpV4Wp
	K2YbQ4fdTU7GPfHgo/tB+KRPCqFM7vSSzGYO21etiwAn7urNF/NfSmD3YB6JoVbj0B3xph1U60Y
	v+g2viFas3PI6u2iUHPelaOGU/7SZfF+Fu+Nr7STNj9HkvjhtRjTgHRlzA0iBRMAISEFwc7fWuA
	w8sBtWnf/bu7xedgiW6pR1iiaAKlTMfF2DwE5moMMruJ5nUZxVT0eI0zIGdbMi4v5B60viM2oMa
	kM3d8eYmUQwImds2DdGJi/k9HoBsinZhIoVNADq1vGGeWqr2XW4zgr6Smj6u06oNmD4MvfDlmgJ
	pSnj2xShZpY0DRbNNQ12kqJ5izr8YbfnXIaB/K4lXxL7IGgFnDpFPC48ZI3CSoDQEFQY2+0Lh5r
	Yawx8tqBngMpTr8z0M9aHbDEdXSbLblKbVWVf2beyns4kYs1jhEubF34FYF9u5jhTNUuOI9Z5c7
	70a0A==
X-Received: by 2002:a05:600c:8b72:b0:485:3c2d:d02b with SMTP id 5b1f17b1804b1-485566f7a1bmr190719075e9.22.1773658367192;
        Mon, 16 Mar 2026 03:52:47 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe1a72cdsm44291533f8f.9.2026.03.16.03.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 03:52:46 -0700 (PDT)
Message-ID: <204db12f-daef-47c7-ab71-efd8c20ab10f@gmail.com>
Date: Mon, 16 Mar 2026 10:52:45 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 7/8] meson: compile compatibility sources separately
To: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org
References: <20260310-b4-pks-build-infra-improvements-v1-0-ec75d0710d6a@pks.im>
 <20260310-b4-pks-build-infra-improvements-v1-7-ec75d0710d6a@pks.im>
 <a5d1ea70-12dd-461d-b5c5-a1127e017d01@gmail.com>
 <debb89c9-2fab-4922-af1a-6048094baf9f@gmail.com> <abJbir7NocxmBuAo@pks.im>
 <2fe87868-dff5-4b3a-95e3-d4b6376b59ed@gmail.com> <abe6pVAzMEY60rJ8@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <abe6pVAzMEY60rJ8@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/03/2026 08:09, Patrick Steinhardt wrote:
> On Fri, Mar 13, 2026 at 10:33:20AM +0000, Phillip Wood wrote:
>>
>> It does mean we're using different includes when compiling with pre-compiled
>> headers compared to compiling without them though which means contributors
>> using per-compiled headers could accidentally depend on functions that are
>> not included when compiling without them. Wasn't the idea behind
>> "compat/posix.h" to avoid including "git-compat-util.h" in the reftable
>> code? The commit message for 75a044f748f (git-compat-util.h: split out
>> POSIX-emulating bits, 2025-02-18) says
>>
>>      This intermixing is a bit of a problem for the reftable library as
>>      we don't want to recreate the POSIX-like interface there. But
>>      neither do we want to pull in the Git-specific functionality, as it
>>      is otherwise quite easy to start depending on the Git codebase
>>      again.
>>
>> We could precompile "compat/posix.h" for the code that does not want
>> "git-compat-util.h"
> 
> In theory, yes. But in practice we'd notice this quite fast via other CI
> jobs, and it feels a bit ugly to split out so many different libraries.
> So I'd propose to keep this as-is for now, but iterate in case we notice
> that it _does_ become a problem.

Fair enough, getting feedback via the CI when it could be given locally 
by the compiler isn't great but we don't expect this to be a common problem.

Thanks

Phillip


> Does that work for you?
> 
> Thanks!
> 
> Patrick
> 

