Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D423C24E4A1
	for <git@vger.kernel.org>; Sun, 19 Jul 2026 19:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784490160; cv=none; b=i1VezjT2wiK52p6MIimShNWHObnAJHDyX7vyyqMTiYYXZ8qhapHe5bNq4fOAL3ocigteX922Rlkeiwpv9kjn0R0DJxDx3Z8v5dl3iFwoZudyR7CHEjOk8jlDFPTWczzGpYglcIwdf8XoFmJFeQ3D3KgjquYKeoUq+pZdtFC9wgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784490160; c=relaxed/simple;
	bh=kAdOnet1HmEh/KczpNvQSwG4Dj8NxTCt2pgxUt7C194=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JZSlFpQyE+nq0GIrJV2fUnnHtTcpFe9P9tpDYNY7IHM95rtWBCQQHM24DCZAvOIHH0tVT1Isx2u2El4N9kiuCLKUtt92VazzxAdPCFTbJaxmV7ywi36fvX/XxnbsYcR6UsscnbDabFemP1TbqFPU1rB7PlgQHM4YI7pQ7wqnC3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSZb/lsg; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSZb/lsg"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4954afac04bso19960745e9.0
        for <git@vger.kernel.org>; Sun, 19 Jul 2026 12:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784490157; x=1785094957; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/ZhSShaIKMU80vgAwXBj0QoeWKCEEVE8A02BzrwVJZY=;
        b=jSZb/lsglPCOztvZYu/X6KKnGfaprbAQxWs7PBBv4IU+ggct384mFTC06wNNdVAV+5
         uv9epM6LMKzplUHbJLep6BzMK0ENCZhkyEzpSK36uXj1U7u8I8SvQ5P2+jhdme2mRw49
         k4LcAlslt/3uw3/K3W/tuh8xlOnVK4XKWLAlk3ryoYzZTpAk9pOVugZ0yvIVd4ZALVSa
         0mvgPM1fP81cPk40KEg4QNY+7ndcAcihCfYrA5An9bctqEaxS7KTFNf7R2F6vYTTTUVA
         h8PRmFiFsoaTnZYZ5GVHJiq8+hNG+saW4oSwWbBrm32X7uJNZgtFG2BXKGajNmEjzo32
         /H+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784490157; x=1785094957;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/ZhSShaIKMU80vgAwXBj0QoeWKCEEVE8A02BzrwVJZY=;
        b=dV7ls9beDmLl4U97Loj77QwmRckLNpfhkvlgY7Z6EKEmHROSFI6latPWFl6PZom6iS
         2PvGAlZtuTF+kAD0oOMPnUxIq3xgTn79f4dDiDYv22kAUvhcdVBIpVjpUu9m7F3gf2BA
         qOZ41nLa1f9xZZFhMR/Q5JuBy/4t+VtodXyVVHuwrkQVzzwRxiGVQaNSuvJfrsUrvlf+
         MlbTcvJw0Sc1nOcKVHQw9wIXj4F41EjKC9WW52ng32D3/kyS/I1qj6GzstsQEoMidjX+
         Wnszn1WQ9a8PTIpFY1g+RCaMAkipd/L3b8kDkHdw5Yf7OyYYlp5UR31X8BNZA3N6egqg
         tkRw==
X-Forwarded-Encrypted: i=1; AHgh+RreZttWOntAWCD4PpugbmQfTMU3uYqW+0MMASsZ/2722xzKYknHmXEoe0sRfBdOUvfsEKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFfkRngpLDS5sldOGcGwevnq0Is3Y6MzV07FHo0WJk6B49K96F
	eijPIpCfDl9qRHJg5qBuPENQJTDW/kIgsg0/LbFNO71+8NYzr8PpqXDZb1jzTQ==
X-Gm-Gg: AfdE7cljm7QeZChoQmdy96lcJggP7kxSZggfgUnqqmJh+3ceG41MCzvaVnaIG2Sqeev
	d5wtqRti2DuDlp7q31aNtu3sWL4hc6s0USmSxEKRWKGK5eVe5QaJlsxYirTlmdEyjITo4eadAxE
	PmB42BIMR7rgtQad0avTP3r7SJp15qhxwrw5ssIYyg1wQck71/RK4df3X4PzAhG5/9cl73AmTGx
	CZ9aB1cL2M2nO1/IaMbKSpaL2scFkeQCT9MMqX3Wq/sdPb1uvqo1Mm9p4sodmZPdG0rb/xaStyG
	tCsJiQRGb9JGB2DlBwGEebwtP0+OKom9L7nJFnEup2ZYEo7qsmuzBwqEPalcuA8457mN3V+LJnZ
	ZE5PHPW9VzGvIJzguPc1AEz/g377DGvCJUbVNS42kaLZs64eIYVfHQTcJPTAm3bzvG2GROVsRZv
	Ts+Pev8S/rJLgMFb4Wm9ZhSJX/pZ7gT5FjYnHr8ewryHmUJ6H1MbvDaakZGfjITj0IMSs=
X-Received: by 2002:a05:600c:35d5:b0:493:d0f7:69c3 with SMTP id 5b1f17b1804b1-4954a749117mr133957395e9.33.1784490156917;
        Sun, 19 Jul 2026 12:42:36 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63ee0086sm25224280f8f.30.2026.07.19.12.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jul 2026 12:42:35 -0700 (PDT)
Message-ID: <9b9b9a2c-dd0f-44f8-b80e-565eed9a55a8@gmail.com>
Date: Sun, 19 Jul 2026 20:42:29 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v19 5/7] branch: add --delete-merged <branch>
To: Junio C Hamano <gitster@pobox.com>,
 Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Johannes Sixt <j6t@kdbg.org>
References: <pull.2285.v18.git.git.1782338106.gitgitgadget@gmail.com>
 <pull.2285.v19.git.git.1784053493.gitgitgadget@gmail.com>
 <a6caa5b397da8ea24eb97e6aa6dc92b437e456ef.1784053493.git.gitgitgadget@gmail.com>
 <xmqqtspvptqc.fsf@gitster.g>
 <CAHwyqnXdaPeO12+p=_+_ttrknV0-VqTMnH-suS66yZ4stsBKnQ@mail.gmail.com>
 <xmqqik6an5t3.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqik6an5t3.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/07/2026 20:22, Junio C Hamano wrote:
> Harald Nordgren <haraldnordgren@gmail.com> writes:
> 
>> I think I can fix this with
>>
>> ```
>>      -+  if (strset_contains(data->deletable, ref->name))
>>      ++  if (strset_contains(data->deletable, ref->name) ||
>>      ++      strset_contains(data->spared, ref->name))
>> ```
>>
>> I used your example to write a test about it as well.
>>
>>
>> Harald
> 
> I do not claim that the single example I gave covers all the issues
> that arise from failing to analyze the dependency graph, or from
> attempting to solve the problem sequentially, which makes the
> solution depend on the order in which branches are visited.
> 
> I have a suspicion that it may be unavoidable to employ a multi-pass
> approach that iteratively identifies all branches transitively
> needed by any surviving branch, though that is merely a hunch,
> unsupported by any proof.

I think it would certainly be easier to reason about if we did not 
mutate data->deletable in spare_stacked_base() in removed the spared 
branches with

	strset_for_each_entry(&spared, &iter, entry)
		strset_remove(&deletable, entry);

after the call to refs_for_each_branch_ref() returns in 
spare_stacked_branches().

I'll try and have a proper look at this iteration in the comming week.

Thanks

Phillip

