Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDEF32C8E
	for <git@vger.kernel.org>; Sun, 30 Mar 2025 09:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743326886; cv=none; b=IM5gUf7NQfmszCxmyiY0z0Xno90TJ6cvSO9xCz1xibYCX85SZ02eocz74Gp/pdJQCh5/sbHbOV5GRSmYyFI+6dJv4ctFHwZZTRnWe4+hhk+alY1Rjd22F80c5762E9alw+vptefe/C0s5kX7sH53fMkj4ww4gEKbEM8d1RgBzw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743326886; c=relaxed/simple;
	bh=vUGhgHwF5h061NB/e2qZznAMt9ZNygkRwbYXDbIrKr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wt94MMCoD7KZOCObOHeWrH/VvpjC/gKv4rcXbODnjG0PKw3oXOWjm2R/D2YJmNpnAHvBJm3Me0aOopQxA1COy6s9JM+WRXXoRiObH4z35bEHElAYFEiZJ/LWYVQ2JG9u/IM6tmO2JuJ5DYIuJR3vVjT2+DY85/f+NuKeXk/F6L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NEVdYKUs; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEVdYKUs"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3913d129c1aso2573815f8f.0
        for <git@vger.kernel.org>; Sun, 30 Mar 2025 02:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743326883; x=1743931683; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TC/mmHfM2QuMe4OXKaQjbEwNEGBPJDTLhGuNVqMQ49o=;
        b=NEVdYKUsf4EVmIG1Fkb0Xjsa5vtbHBPnI0YPW2IpLT3LmNTvfB9CPPl17BsBAz7gKT
         6vmh0R90ESRMDNGaliFP8T6ZEKsGypEw3pL65siReQjcxOY651W4bJhNKS90ojkoPe+X
         vT2iQZaSH9cPyu7Kk1XT+EptTGYUnEetfJrAfwAGIaHYJo5Rt1XWe/2anOuJyaKzuY+k
         1Brh81FQN3MoeW9hEYSvhX96YxXSQwMITzMk/0IyghW8KJAo9QbpUJLrQE5bD3vbVfoM
         k0kv4hzInuhuiR2oXPXkNMDppbc6B64984nwUlLTQnvoEJV96YL4yMsirQaW/Sa/wy3L
         dGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743326883; x=1743931683;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TC/mmHfM2QuMe4OXKaQjbEwNEGBPJDTLhGuNVqMQ49o=;
        b=XnMHaHDQzLnnjJgBSfNNQMpIjO7+dMriEqY+6iqIYqcclcDAWbFovG1pWXBFpfUESU
         pt4YZD1jdMV2WJNW+EYUHzqIjlllFAzbDlFvjHi8P18QQnhBgKbkc/Rre+ILXQV/t7lC
         p2lZmFJzGcDXDoFTBoa1hRSCKINU7EluHdjTQtz4gx82PtP20LK6y4y/iQEIufsk5rLv
         onSTYMCBt98Y1nybKfdoTBzZOK7RTqpw5utlDAFh0VFXk0NifGbJzcaG09k7+1Dn+Xlc
         wShSDujHW8+Qvo8N4jGTntE8BqglorLGHpkea/sm2noRmIGJJLc3GURXWCsstVYUkHkG
         REJA==
X-Gm-Message-State: AOJu0Yz4PQdRO3m6fbhj8XT5Iw0sbLkkHGmAWllHHz4/jVImQ9jIAcza
	homxALy373p85TjVR3SPxhtOnmfld1CXyRDJ0R2l6MICZuWYCp7y4tmi5A==
X-Gm-Gg: ASbGnctH3/JntpSYdC6grpaIIOFn5PdeoCK3OBVW4zaoybEXXO++1qBVl8llI9gucw4
	ZNm34pHOj6+u4xSOY5L6dweM2pAMCFlo7Yt1rWh8QFAejNHvEhWbTIgUE0zODOGH4403byDY8p1
	TClaDAsiVq6LOoj4D9lgEYZGp4fIF+BmXT519jKTTecMDQJKQUtqM9gJuSfR6H+Ol2UH7P5dJwZ
	F/r+rlcvnfRJK4chAbTaOVjBwKQmjqFAEFFrrfF6bRk9Htv9FAI1XssIlcOyliUHYTaMwsALzNT
	iIZ6cLt018bLiTkgXjpYGP1IN4QBxu9CqHZC3eYDhaTnXacGRA6t1Az2ZY2fHrhOmbCnysTmAcm
	hSJ+d9C9aj32cxLe8th10
X-Google-Smtp-Source: AGHT+IGlMGSq4rhaJ2r88Quij+VGzPlwVwOCKit7dfVWw7yw7zBWa4DAq34kCDt6rb2IEQD/ZzuBtA==
X-Received: by 2002:a5d:5850:0:b0:391:3207:2e68 with SMTP id ffacd0b85a97d-39c0bf2990emr6754128f8f.9.1743326883186;
        Sun, 30 Mar 2025 02:28:03 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b7a3d66sm7998034f8f.81.2025.03.30.02.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Mar 2025 02:28:02 -0700 (PDT)
Message-ID: <be0ca59b-2daa-4089-8948-d04fcdc3bfa7@gmail.com>
Date: Sun, 30 Mar 2025 10:28:00 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] blame: print unblamable and ignored commits in
 porcelain mode
To: Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, toon@iotcl.com, sunshine@sunshineco.com,
 Patrick Steinhardt <ps@pks.im>
References: <20250321-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v1-1-44b562d9beb8@gmail.com>
 <20250329-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v3-1-10f695ae519a@gmail.com>
 <xmqqecyfazg2.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqecyfazg2.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/03/2025 05:56, Junio C Hamano wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
> 
>> +static void emit_porcelain_per_line_details(struct blame_entry *ent)
>> +{
>> +	if (mark_unblamable_lines && ent->unblamable)
>> +		puts("unblamable\n");
>> +	if (mark_ignored_lines && ent->ignored)
>> +		puts("ignored\n");
>> +}
> 
> Doesn't puts(3), unlike fputs(3), add its own trailing newline to
> stdout?

Indeed. Perhaps the regression test would be more effective if it used 
test_cmp rather than

     test $(grep ^ignored actual | wc -l) -eq 2

which misses this bug and gives no output if it fails.

Best Wishes

Phillip

