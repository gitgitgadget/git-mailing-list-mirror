Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087062F6182
	for <git@vger.kernel.org>; Mon, 29 Sep 2025 10:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759140064; cv=none; b=PvADch5J25tSocnYn9Zsride8snV7m70DbY19HEH1+5LmeXsYhGHz3/YtWeKEpF68HeWfL0yVJomiQxhYcT/Lphk9SXdMhjNg2ZmiDEvMxY2m5gkgwKowfIr90ipScAZSRPrlu9qIS9AJOSFO28rYDiu//66bE+T+OSRvn0ZAOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759140064; c=relaxed/simple;
	bh=krDbw7jElPhAudVLfeQ8ghbooyHzkLFph/NswnP5jI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d62AVkXbkPtpjBoYmKCEvHv5IWNQjO1kYss8Aj7x8eP++gh7iI+eI+Pslbie8+EhIqcMSd072//XD/jHmbNxqOEItYobjW7K3aFJwzUmp1C2u8Bigr1Az9xYm+6Z6jgqwMJ7HT3RK4thuiWOstMl5ByVhzmILc3FFCCvco4DhW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iXv5O45C; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXv5O45C"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46b303f7469so29962915e9.1
        for <git@vger.kernel.org>; Mon, 29 Sep 2025 03:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759140061; x=1759744861; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ij3zQk+NJH2Wgeg10olacx35vmMH/VWT87eQNxt6wiI=;
        b=iXv5O45CRqnQ0Oyx0R0SMs9pyKCgCpn0Tg9FKs12eNnh8n1cfateRw+x/DV0yRrpJs
         gEliGgeE6KCDIrTkRCPvYukT4OTjgXyDLaP5TZX3h8cixj3ss4ElWlyx4rrhcVMDqr5O
         gvs2vVpyeHJb+eRRmtN9YaHOJNo7O1QV4CRB6FxLb1osBB703J+d3iX4QbkNbunrznNB
         LSjsPnU1C+a1j7ZE+EMMZcaxrLYWA0S4IOBlZGxN9lute7JC5oByd24tdV/ftOSC/cMK
         pAnoWXEiQ9OVqFb05WTtIGF6CvQY8bgknZWNql3y7BmHcrSWXDPP1/PyJ8MjCp3Ii/qQ
         mExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759140061; x=1759744861;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ij3zQk+NJH2Wgeg10olacx35vmMH/VWT87eQNxt6wiI=;
        b=lrDBYgq35XwvOC7ubZjnSd4oV7wOtRqO9kfKV2ZtD/ss5xRX6BaJK8BqMo5Gtyxj3i
         bJ+cM4u+xsEn8eY+jyF7eN3JLB3gWdqroOVDgHUmQsD195X0EXUdhJF5jvHNCdM0apPd
         IBZaXy+oY6MWfVyLSDpm78zSt1HOJcZZHJ5czIIZ3REzRAJM7nPF312tspxgLGZbgubh
         4kJ0nJIlXK5kRmBkSUAkZRRpx/3JD0CdtUCQWcy+sz/X+iMvFuIl6/jHNuB56SDGRoq/
         +hcIT4EEY73+rmUJjUcntTmqgDLVPovGR1wZ0zTOLJGDTKdpH7EZ2XmbtbgVQZiSSDMY
         sQAg==
X-Gm-Message-State: AOJu0YxJvxqpZg/mHBGMgBFjT052oQfZofLvg3y9ySlDHq7YNb6f+xrR
	HznaEpFq01AoRgY9PCCek3+msGSdqrOEhBZMMJIU2jPic5ssBBIHPYEY7UItMMBk0cs=
X-Gm-Gg: ASbGncsAzIwiRRsKAH2/Zbpkpjm63KLbpRuBKqbC+zkdhXI684qLnmJuHBEXgiDiOsT
	syH3pz0wBCkQ5pTMedIdl7ad6A4YBfAXFOJ885oL4xqc+gFyD1I+W0wncZIWu7ROtvHw4824skE
	aVKSXh+g3MLjVAoq+czkahUhoMn4V7Jz5Zguvmucq8BPUz3mpqzeaUi0stXYDNk6TYyLTP2lidI
	8u5xmJCWfvAgG6Iy/Rd0oId6BmGdEczJqD57dM/37vlZFLC8fSSdJMu6MkQXXNgo4ZyoJqIxpPs
	MRjZR83IFpatFk70VUvC5yYAZYuOilNw9R0cfYs06ceMddaMJlwy/Ot2ksPM8ch7kC8WrbrBeeY
	jzRJfGYTU5kZapzlWzFa3XXLOOng/IdAjVIaZtgxKXOF0Dr88IJA1ntFWWGHGFXRneG3VdNvI/M
	mHnDMXu4ihu1DC2lU=
X-Google-Smtp-Source: AGHT+IFEF5kG5Wkh1NbpxcW1oyUjiMNBbnpUiyZKWO8umsNCiUcBcYu2vjKPl0m3OfPf6+kIIjrUxg==
X-Received: by 2002:a05:600c:1c8e:b0:46e:1f86:aeba with SMTP id 5b1f17b1804b1-46e329f819dmr161386455e9.17.1759140060900;
        Mon, 29 Sep 2025 03:01:00 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:8237:372f:a3d9:7aa3? ([2a0a:ef40:62a:101:8237:372f:a3d9:7aa3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc82f2ff6sm17474476f8f.56.2025.09.29.03.00.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 03:01:00 -0700 (PDT)
Message-ID: <b36d2dbf-7cf4-46cd-81bb-b502e0eed380@gmail.com>
Date: Mon, 29 Sep 2025 11:01:04 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] stash: honor stash.index in apply, pop modes
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 moti sd <motisd8@gmail.com>, Denton Liu <liu.denton@gmail.com>,
 Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
 =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
 Glen Choo <glencbz@gmail.com>
References: <cover.1757982870.git.ben.knoble+github@gmail.com>
 <cover.1758505011.git.ben.knoble+github@gmail.com>
 <8e6cafbf3a01b968663b65559acf3df615eecbad.1758505011.git.ben.knoble+github@gmail.com>
 <d7721018-3b2f-4764-b33d-4fc6bdc034a1@gmail.com>
 <CALnO6CA9z39rgGd673p-ZMzMOBM_G37YPOs4ysNtPHGGCDVM-A@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CALnO6CA9z39rgGd673p-ZMzMOBM_G37YPOs4ysNtPHGGCDVM-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/09/2025 21:40, D. Ben Knoble wrote:
> On Mon, Sep 22, 2025 at 10:11 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> Hi Ben
>>
>> On 22/09/2025 02:39, D. Ben Knoble wrote:
>>> With stash.index=true, git-stash(1) command now tries to reinstate the
>>> index by default in the "apply" and "pop" modes. Not doing so creates a
>>> common trap [1], [2]: "git stash apply" is not the reverse of "git stash
>>> push" because carefully staged indices are lost and have to be manually
>>> recreated. OTOH, this mode is not always desirable and may create more
>>> conflicts when applying stashes. As usual, "--no-index" will disable
>>> this behavior if you set "stash.index".
>>
>> Thanks for updating the tests, they look good. As I said before I don't
>> have a strong opinion about this change but I certainly don't object to
>> it. I think this change will also affect the behavior of "git
>> merge/pull/rebase --autostash" which we should maybe call out in the
>> commit message. I don't think that change in behavior is a problem as it
>> is probably what the user would expect when they set this config.
> 
> Agreed, I hadn't considered that here. Should we also update the docs,
> do you think?

Good idea, we should certainly mention it in the documentation for the 
new config setting, I'm not sure whether it is worth mentioning it in 
the "--autostash" documentation for the individual commands.

Thanks

Phillip
