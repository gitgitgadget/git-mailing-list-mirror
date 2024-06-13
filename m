Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52A91E49B
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 13:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718285712; cv=none; b=M9XursZg1rYE3360Bx58Q+63N2FbxiMqdZYou24DcXqiN+ZoZjJAzDTF2wM8ZWWosBEWqk4DsQGt8xyr6lic/V50+KyIOVDynaFUdmmU+L7KGh7SrBvwiLUVNkZ+d0sbPyd+lAOjn0STmHGH1b/CXooWLaxImcIn3RCcmnyiCBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718285712; c=relaxed/simple;
	bh=MFaUtUjzP1GuB/nN1O9e4ufAHOexMINoRnrHo0vLC48=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uy8oAOsOiQbYKrrIKrgdQfd4oRfj4ATplMt+9cCmq/v0KVkxN42je21ZV0Sup8nW1zeOMUXF+1YR+ioF08hn3uXdQkFEPSUD7h106Lwkn3SDe03fUT6JGNR1Pa51WBOTgDzLMWvlJzBie70JAvaiGBKr59mxVS0Rkj3QhgeW/G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EexvZswA; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EexvZswA"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-421820fc26dso9212505e9.2
        for <git@vger.kernel.org>; Thu, 13 Jun 2024 06:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718285709; x=1718890509; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lUnBXpgTqPssJY39dQj9dUJVBhQr/RiWD81TN2AW6RQ=;
        b=EexvZswAV61fuIq1laFe9g5IFGDXcz3RZ+1A5aDx4dwEF9Ygr0pNjHBavRRoxSZ3zA
         znSUfMPqunm1RHCMvxwGIBsLyPvBgT7wuxOZvfHLkDVbtynwZ6o8XpPM6p3ygz6exsuH
         BGpWSIuXRabmmon5rmi5I38KHFp4AbjtMYNH4VzGbwQyrn2IhAiwVe5Lniv1dsRWK6Fi
         S6gC5piWrytvan4JiyiZAhO7bQHGk2qFSyxd509HTQtb/SJnOIbCRhLJXNA6Gi7qRaMP
         Q3gjmINol25ORspuCaBLS0g05GwfqyWm0rKsk1+XEY7ePZfAilG5hKBMpbAGFFNgXWGR
         5DWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718285709; x=1718890509;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lUnBXpgTqPssJY39dQj9dUJVBhQr/RiWD81TN2AW6RQ=;
        b=u0C3bNuF/YK6DMooAqvYK0q2Tumnw4LlcYeLmPyRYT/OVc9naBePChcfNHOfPEE7cS
         iNTVJ8QRDYBwjbrvOooRXXRsstSGRhTnNkk9Ksceo271Kxx6p7AQJZZT6axsuXrR0Lri
         JveIctXYrtbDx1x56le8s+azsJdAKvruNbmOy9vxXD6SNA8rNTLlA/zXg7BohHQFbrtM
         WJ3ktucgieIgzsVpyiOapSitL+ozdDitSseF0x0YlhELFsc6sgg59b1Ot9Jv8iuUVMks
         eHEqr1WALHmV0zQubWjF4J3qIlIJ63tLtW48hwLkqXgHXZ23xpxNZSIvcjlLuFu7QFGz
         x/Ow==
X-Forwarded-Encrypted: i=1; AJvYcCWkh14Wj7hRz1P37N5MmYoNHIKR66/0R6gd38DBXYnE0sdMQnZVkNU3znI/gqHBOdrybyk/SSWNAZyr5MtcQR518j08
X-Gm-Message-State: AOJu0Yxthn/BsQBMflGAMBOzVDJUCSEr/Mt7mDgxlokYV/uptLDzuVbb
	HhuEsfvP3Qudsqej/Vuq5dlRiDx1pQ9Dh8dvqalYYiygbYFocKsozlelPA==
X-Google-Smtp-Source: AGHT+IGWTG6grwi0DP3iGdn3npBMZN5khGp0717x2MtBTIikPsb5qskN0ckPNoE7PeX91Fovm028KQ==
X-Received: by 2002:a05:600c:a08:b0:421:f4da:f60 with SMTP id 5b1f17b1804b1-422866c63efmr41670025e9.37.1718285708964;
        Thu, 13 Jun 2024 06:35:08 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476? ([2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075103237sm1744383f8f.92.2024.06.13.06.35.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 06:35:08 -0700 (PDT)
Message-ID: <9f4aa9cc-fa63-4137-acba-14e41ea8fe78@gmail.com>
Date: Thu, 13 Jun 2024 14:35:08 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Jun 2024, #04; Wed, 12)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqcyolofar.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqcyolofar.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 13/06/2024 01:30, Junio C Hamano wrote:
> * pw/rebase-i-error-message (2024-05-30) 2 commits
>   - rebase -i: improve error message when picking merge
>   - rebase -i: pass struct replay_opts to parse_insn_line()
> 
>   When the user adds to "git rebase -i" instruction to "pick" a merge
>   commit, the error experience is not pleasant.  Such an error is now
>   caught earlier in the process that parses the todo list.
> 
>   Expecting a reroll.
>   cf. <88bc0787-e7ae-49e5-99e8-97f6c55ea8c6@gmail.com>
>   source: <pull.1672.v3.git.1717076630.gitgitgadget@gmail.com>

I think this comment is out of date. c.f. <xmqq7cfbp6pb.fsf@gitster.g> 
where you said

     Thanks, will replace.  Let's see if we see comments from
     others and then mark it for 'next' soonish.

It has been a while and no one has commented so maybe it is time to 
merge this to 'next'?

Thanks

Phillip
