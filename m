Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A302C35B634
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 15:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772639598; cv=none; b=l/MgHNCEQnUk4vwCvx0YaUH5f6uZkTS0nDO6AGx1JIok48e3eYPbUY0CzZ6oeKAQyFHKSCKhPr0iUCpOmvS2E4dwtVAMRBpIk1tdEqS1EZpM+bB5GzKfEGl52LxDyQNuR+zGcTHoTDrTBQqYtoT+4zR2vf0u5FfMoMZ+0Kck01U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772639598; c=relaxed/simple;
	bh=9dobW+aZ5zDmRc3x1ntmRVFS6kfe9SBM4vIT6UqTQEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YUITIBVytJmwptfns3SIbYFL7RvbgQ6O4QoUsYa0lhx/DEdHhPeubk0WvW5ujXlT9vM/sjHBbnsNA/JjoUcnPGuMiA3LgBG3bZddADeYXhXlzTpPKnnTA86E+nrZGxaEKvyevhA+JtDau7G5+Iq26+F9m2PdwaRzAjoWHF644b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpGqzPeC; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpGqzPeC"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439c5cce2c6so1087949f8f.3
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 07:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772639595; x=1773244395; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BgfdE4MxeZAG+aL+7imdFAB7FOfy99nYPTJz/J2tmtA=;
        b=RpGqzPeCoB3S8rHOrEH+4XRO9btZws69hwE4ji4yK4FHvuTg2X+KH9v1kQhOFsQGbP
         29hpLe7dDpry22V5+ddPnNS0HMsiDxdCxhC+FBXlgFHlh5TaLgsET70dFzWI2r8BqCjq
         4sHzHjHWG8O3sj0xJHrm1TVsn7ayd6seCi9SliXWDjtML9MtdP1YJ2I5chmDhqpxp1OO
         BmNU1/ljfXRq9gLixpxzKm3dVfR6dhMnHGMRnWhJzPlJ59LhTxwuhiXtT5ejE/orGuiM
         bN193oNQh0ZnQF7Xqo/oJACm+s9tGqPdq5/vYZzMrMgaU1JtEsD5kFr4M4IwYhtyNvKQ
         933A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772639595; x=1773244395;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BgfdE4MxeZAG+aL+7imdFAB7FOfy99nYPTJz/J2tmtA=;
        b=VOrq2JjbzNGYn3fsvUso+Y4Zb3n295IQV0ar42acRwcPREPh9GVa0V1e7fFO77KMTx
         bBVimpUz5OIY4ZdY/G8mvCLfFBaPejghSlW7vfHVvWQyoeOlmsiGxPPenO/LXOhoszjw
         onrdnBvcpQLpJKc4tJ1/JG8YUgqpurm0Ifblq9zlUlRmhY8cl81SL/hMKWPJrQVa8l3z
         lJoDW44ZgGtzvy2n/z7VifTgYKGYYg/IznyrCp7vo4AJMmtjoBVkii9aqIMW75Ixa3vG
         46EY1fAPKYqce1izF6Uk90+zy/pbtXRT7pGy95OqsXFOwYKi4kC5xhpMroCzjNkL6aMR
         RLrg==
X-Forwarded-Encrypted: i=1; AJvYcCU3rSzs0FdtOTCiV6hnzqstU6aiwiiFaZyGQ/xQdHzt2iQ3V4lFwLH3IRirmlCTpgap17c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzn7QB8yNiGmR0H3SvY3EhL+Mqt5mnfdfQigPV0NyEdshYoRv3
	JP4M5AftAFaZ2dt6X/1XpdrNXReK26nQZR+cRluCU4KJB0sh2/uuF1qr
X-Gm-Gg: ATEYQzzw1MPbaXG/0bHWPs1Gs4DZFBOGkG7QdXMDxZpoagKRgWD0AYOaw7phQtfKNus
	dwXE9W8uMCIR2X2meuYO6fiyu4ZIgFH0th5yofLTNAG8Nsp7shB46uIKXvWlbTPmpfW01wU270U
	oE/goPryc0wIR3Y/6dX2QjvP/wubGbAfmK5KZtC1bRPIF6F81q0235XaDSpczGPfIKYdNN7wIuR
	7Mg+TFEllEv0u1UAsFSN6A7QvcO3LfOM1hhwXDqAi8dIHMnUzEQcJhp1/N2eicAouNlbLTcGsft
	DHb2qflC3QUh+0ifNHMXxvkMSl3G9rxZxgnunMOotn10aSBpEiQ2FuNRsg/lQ7A0tSZM7Ntuzv5
	6IUg7lASShyPMX8TFmI5h6aeO7ZXhDwf9/xvpMXxSjj3LLkdOcITcDnZgiX0sA0ungeJxVBX+JR
	UzSKBrdiWAzzrzipOh2amuC8+lMXiiI6u/KW1R3uJdcAQQV1gyHhzdsGO4Wo5d+HdHimxarUhWg
	NVWtQ==
X-Received: by 2002:a05:6000:2f86:b0:439:ba75:7dab with SMTP id ffacd0b85a97d-439c7f65059mr4651162f8f.9.1772639594643;
        Wed, 04 Mar 2026 07:53:14 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b503424fsm28565866f8f.22.2026.03.04.07.53.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 07:53:13 -0800 (PST)
Message-ID: <ac09b00d-0566-405e-b7ac-b091448e0f4b@gmail.com>
Date: Wed, 4 Mar 2026 15:53:07 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v7 5/5] rebase: support --trailer
To: Junio C Hamano <gitster@pobox.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, Li Chen <me@linux.beauty>,
 git@vger.kernel.org
References: <20260224070552.148591-1-me@linux.beauty>
 <20260224070552.148591-6-me@linux.beauty>
 <824809c3-72ac-43fb-8a93-4f48e0727e6a@gmail.com>
 <22e1de8e-935d-4efa-9fa8-ef8d9b4ffc6a@app.fastmail.com>
 <xmqqqzq0boi8.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqqzq0boi8.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/03/2026 21:18, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
> 
>>> I wonder if it would be better to add the trailers before the signoff so
>>> that "git rebase --signoff --trailer='Reviewed-by: ...'" adds the
>>> "Reviewed-by:" trailer before the "Signed-off-by:" trailer.
>>
>> Why is that? Is that because that is the practice in this project (and
>> maybe others)?
> 
> I do not think it is a good idea for the above sample command, where
> we can argue that the intent of the user is to have sign-off and
> then reviewed-by, expressed in the order of options given.
> 
> If we want to control where the new trailers are added, perhaps we
> would need to match the --where option interpret-trailers has and
> let the configuration honored by that command take care of the
> ordering.

Let's leave it as it is for now as that matches what "git commit 
--signoff --trailer=..." does and no one has complained about that.

Thanks

Phillip

