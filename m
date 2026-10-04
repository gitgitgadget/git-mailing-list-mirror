Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC53613CF82
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 10:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791108224; cv=none; b=ns6O9jRNW2fb7JE5tX/+CkvRj+tXkVNByaCkmGFrUnzaAYGHmHiSiBCi0IhWwzDjSEUdtI1FxAjoBleJWgreyVF4HBhFM/8dnBURuuwmtBsxZ8HsrupLp1bT9JWUW5255qslXe8ijc3ncpzNm/6fdEy0E/q5BjJL/9lTNpo2Uqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791108224; c=relaxed/simple;
	bh=nqxu65u9Uztik3k608st/0cSihPBUNUVrUXpIWFAD+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G03Ld5wO0Op1qwmAdfTmFuw0uxWLrNjwzLqvagDl207sap5cd6iot3kve0clvJtbnE1FhuHvOo+1YxvARQKp+TQ7Tjx6+fReKia/T1KLvVrcV2pVacmm4H7F4Mr4Zk2yU8383UbpbLnea3yyWL1/iTTWnQvadYHHjgdRT2kWPjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cC6SWY26; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cC6SWY26"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49fff6f0f87so9369875e9.3
        for <git@vger.kernel.org>; Sun, 04 Oct 2026 03:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791108221; x=1791713021; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/XTFxe0+OkrO2XintCgAxst4y3L3LLuiCEo5jluxk+4=;
        b=cC6SWY2667Kjntap8I49XgUxf8jX7OQkoCSLI7czalMNYQmCbp7r7FrPZx4kz1o05Q
         FkyWaK5T1DfUT+zVwz6JgMC/dSrFGR6uVgQ5Zj5ulDWOmAgpRHgwVANrAMXhYGZEGZma
         MnIfhEKN7P39o1+9jCE5JqTiIGnjmsulthlAeOhwr5adkyFpiWo/cK3r3EE7PdqWigy9
         XttNBo7QTzMrow2iZ3w/PWn/FV5bmCvyUDV2srT0DK5SU+YrXEW1sLaSVwvpnWnzOaMv
         oRGyP+waF1EuBCuvLU50Hnu0tDcdLe8ehtrnwO6vtUCgaXKf3xIH3cOYiM8gyOjFC5Hv
         /8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791108221; x=1791713021;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/XTFxe0+OkrO2XintCgAxst4y3L3LLuiCEo5jluxk+4=;
        b=mCatWKDoKNHMjyamRpUaacvQawmfvVOu3HCNkuVhvG1hNPEb4qVJFjBNqbV7I3IRTH
         MBDs3bMU/vkyRCfmiQgLNC0939x6LXFdFb2xo8vb6vvlHGh83+Fk2zN85Dc/4OpdpXSt
         4xd+aE91EMCa1suCanX9bljbLN8Vze+hDZ7xBwpecdTDBQqy+0sdUb/3DkN1vdaY21VX
         ytodPk7mIgZd5Ax3Ooh9FymlCl8UzokLvzD0vKRt32XhgRe34aHSzWlLCHREKkNkgIQZ
         NNVltKNiOnyZG6Id1uQQczlEP0+n67+EwHL+20mxWNIoG2MsFqZVURM2htRazreu4sn6
         3lzg==
X-Gm-Message-State: AFuF++lIDBeNNlkA8w9XwbTz+wvt/LQCsdfDhpjZmK7Hl+brilhsQ4vY
	h6Gurr/jkYfQL4xsHxrhnUeQhGfeJb3vO+80unkO2geIqYGJ8IA9ZyNR
X-Gm-Gg: AYBFou3Rcjods1PXeKF0o8vU9QT+Zveyy5e0j8BpHTtOgKyVowvRfiXFgfSCfKE7WO6
	T11b/dDQi0rJChuPJQihsGqf1fRG2T1Ef0gGWLjoBgPCoWG6zBPaa0IsTM6igFkTD2W0ivSKmpm
	TbcnHH5SRCrr3dm/n39Wqe3e3LCHPNqY6PIohi7wH1QvZTSwuQeZWXNT2e6cZTAvmSnCRtnCYmS
	IxgI/U2HREBWVdktLGC9JbmNFuknNPNTJhK2SIX1F/CxNo0qC73RExlv2RpWjT3yxkFJlEU2tlq
	TaKDUCgvTedvk+3G9fFjVN8exlxOzWm3xVI73pypjMlXJKbszAA1bmdHvngyOQmbV83X0Nvx2WO
	BzS6b7R4xzGLVwg4+c6NGYNJrHUf91LM6mD1bz5sg558hNQLGxXQQXyUbA9ETe0VgKSfYAD9+/G
	mCm5+0o+ISkMXPmHSDrUMhWEo39UnBTCEMj+NBpLcRo2me1bLYUW/A1fMcJ/807W6EOJjft02X4
	oIthiwgTm0w5XTnb6mHA3I1IbN7fwrVx5llcm3PtS1ftYz8+12cSA==
X-Received: by 2002:a05:600c:3510:b0:4a0:c4:a1e0 with SMTP id 5b1f17b1804b1-4a02756729dmr136797825e9.9.1791108220842;
        Sun, 04 Oct 2026 03:03:40 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0276fa954sm245101955e9.3.2026.10.04.03.03.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2026 03:03:40 -0700 (PDT)
Message-ID: <95796d0d-5928-4108-bc27-b7ace4459d2a@gmail.com>
Date: Sun, 4 Oct 2026 11:03:39 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: git-rebase-walk
To: Patrick Steinhardt <ps@pks.im>, Alejandro Colomar <alx@kernel.org>
Cc: git@vger.kernel.org, Nico Williams <nico@cryptonector.com>
References: <ar5KL4_IKXYbx3Sb@debian> <ar5eereSq91xldo-@pks.im>
 <ar5-7ZtM6C23H-8m@debian> <ar9TTB5nmPPAdABE@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <ar9TTB5nmPPAdABE@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/10/2026 07:46, Patrick Steinhardt wrote:
> On Thu, Oct 01, 2026 at 05:51:58PM +0200, Alejandro Colomar wrote:
>>
>> My script I use it in shadow-utils and in the Linux man-pages project,
>> and is in use today.  I was wondering if there was interest in
>> integrating it to git(1).
> 
> I guess the answer is "maybe". The fact that multiple folks have solved
> similar issues over the course of many years is an indicator that the
> funcitonality may be more generally useful. But it probably shouldn't be
> a separate script, so if we wanted to integrate it I'd think the best
> way forward would be to integrate it into git-rebase(1) directly.

I agree that would be the best way forward. Adding an "--incremental", 
or "--progressive" option to rebase would be useful I think. For ease of 
use, I have a strong preference for an implementation where "rebase 
--continue" handles rebasing onto progressively more recent bases, 
rather than the multi shot approach where the user has to run "git 
rebase --incremental" multiple times. Having a multi-shot approach makes 
it much less clear when we've successfully rebased onto the desired base.

Thanks

Phillip


> That's of course more involved though, so I understand in case you're
> not interested in doing that.
> 
>> If not, I will likely provide it in the man-pages repository as a help
>> tool (which might end up packed by distros as part of manpages-utils).
>> Is that okay to you?  (I ask mainly because it's using the git-
>> namespace for commands, so you should at lease be aware of it.)
> 
> I mean overall this is our primary way of extension, by picking up
> utilities that have the "git-" prefix. So arguably you don't have to ask
> us for permission to do that.
> 
> Whether it makes sense to distribute such a tool as part of
> manpages-utils is a different question, and one where I myself am of a
> split mind. But that feels more like a question for distributors rather
> than for us in the Git project.
> 
> Thanks!
> 
> Patrick

