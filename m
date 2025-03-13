Received: from mail-oa1-f98.google.com (mail-oa1-f98.google.com [209.85.160.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779E01F4603
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 20:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741897158; cv=none; b=Qop2H8d1+9PE5IdIkhbFj++IRZ8UYU3XDdwmfExtMwXXC/VdPIFwM0pOZ2LjgODki4Ond3lflH2JFL5jA4o2qWYHAAG8lLfj8pjDJ2/pvhcpiNba+KJCqOY/vqyagvoY6PrND4NZUu8/QmDHZZaxf1zQO399m+rBMNEMwnI8Fc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741897158; c=relaxed/simple;
	bh=dpCO3/KlOlMylRIaYF2i9UQIb5vXMvX79KS44jSQ76Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YMF3+fVBMgSAumV+o8oTsYaxG9SHy7/KvN82YCaDbRgbGXuYDrLPxu5FkscFMzD+IHLw73xWgP1Z1CV0ByACos3qbyNUS2WtmI3eC1hUGfvclqj5o1ND0ninIv1Y5JNp+uPEwDd5PqzqJ3+IlzoD86N5X96TJH5eHi3qAfvJU1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mandelberg.org; spf=pass smtp.mailfrom=mandelberg.org; dkim=permerror (0-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b=7iSVxVEC; dkim=pass (2048-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b=LJkBmUqK; arc=none smtp.client-ip=209.85.160.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mandelberg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelberg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b="7iSVxVEC";
	dkim=pass (2048-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b="LJkBmUqK"
Received: by mail-oa1-f98.google.com with SMTP id 586e51a60fabf-2bcca6aa8e1so460955fac.1
        for <git@vger.kernel.org>; Thu, 13 Mar 2025 13:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741897155; x=1742501955;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :dkim-signature:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tDpRHH9OuabRXgxlMA/2shzKDrELipn3pjZm2JQ/F74=;
        b=uCmCpq2S98zYgJHapluGtnS7qOWaUImgARqU8C9rFTUmqjTALlOdF13WHrSmVOTYvs
         vzcruLU1qsET32y06LsSByisTdS5t3PKX2u7F1KERUnYlbzJjxPk7KPDPuyvvU40zvpo
         8DP/rxeTTzBBSp+UXi982gNc/JN6lbmEI0QybjSy+Qc79ctP2oI7esy43KaIrZPSWJU/
         zdG9shdXKpzaw3eKFfX3kxrD0lRegz+lIzXqvmGN8x6HBNQBZnWniyBmPt20ljdUW8Eh
         kj0Wnr8B+tyq71vwG0nWXNj2QGcyJzkdoO2FiGzgXUOe9PnOUdp5rn01YvJ2nAk1/+TA
         6jqw==
X-Forwarded-Encrypted: i=1; AJvYcCUnwcLPhMyHqEY6zT5mTDMrlbdJN63PnLUNnYNxpPRZOV0nBbQwZfegWSiaCbWQS4W6iB8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz981844kTaYvCjPlexYcRQUforvBcmJ4pLc5NXLDzi6+vdJOEw
	K5fvADgbCbsANbdq1KlP9IRs2Z1lCd7boj64q2iRiYXznuFaSrYi0MlkIWRAkjnZD6Q7TeWIWYg
	6FfSUPkdl25Boj2sPynnAXvzy8MEnBjXWHHaTAP/yNwOKWkWP
X-Gm-Gg: ASbGncuCtox+76/gTUU6jJecrxUCEB6WvttjylP1AnJunKtzFwR3Hy/2py1PgmjnF0w
	3UvVFeZEuXH/iQG3kp4K5qYRmU1wPbdwJhGLqrMF+HIHY1DevoEW7pD502lr7i7Zm+H63ipPrRJ
	0IxPzc4/oulMcAhyQDGD2b8dlF6poi1aBEe9qTN4kXxZMliU/RmhZl8NJBocRhg7R18qsfCFNFv
	NY7JrF5UEkw9X1oyF3moS56gvsqUbIBdEIOJ7uvC62Cwt6ziqEj9p7zI4xbqtRHhyzvEK0b7T98
	XUS7Z8QR5aoDJnIO+qkCCPI9660ksUWk4OFEFOed
X-Google-Smtp-Source: AGHT+IGIok429W2un6it8CUwQ+IJuSGHywU4B0FXHLd9zn5niSERMEQFg+ZG2+inh5P5pIpBVLUUNf4EN/Ge
X-Received: by 2002:a05:6870:700f:b0:2c2:30e9:b15f with SMTP id 586e51a60fabf-2c68b27af63mr555499fac.20.1741897155264;
        Thu, 13 Mar 2025 13:19:15 -0700 (PDT)
Received: from mail-outbound-e14cf917.virgo.mandelberg.org ([2600:4040:52f1:f606::8])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-2c670fc7e7csm83865fac.4.2025.03.13.13.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 13:19:15 -0700 (PDT)
X-Relaying-Domain: mandelberg.org
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple;
 d=mandelberg.org; i=@mandelberg.org; q=dns/txt;
 s=mail-outbound-e14cf917-597d7abb; t=1741897154; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding : from;
 bh=dpCO3/KlOlMylRIaYF2i9UQIb5vXMvX79KS44jSQ76Q=;
 b=7iSVxVEC/vfkg1/gPsCPaZCn38L+8gJSbiaZHJJvCfXkQnLkKOb8WUwWbl0xHh9bYftG5
 FlG2AVclwG4UQxRCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mandelberg.org;
 i=@mandelberg.org; q=dns/txt; s=mail-outbound-e14cf917-e56dad1c;
 t=1741897154; h=message-id : date : mime-version : subject : to : cc :
 references : from : in-reply-to : content-type :
 content-transfer-encoding : from;
 bh=dpCO3/KlOlMylRIaYF2i9UQIb5vXMvX79KS44jSQ76Q=;
 b=LJkBmUqK4rSgDSaZFf69+2vEZM9V+oGC1/POpPCWp04uwkPWcPN35ER1t6vhm/QjZJHU9
 gPZA24VIAJRe+4i5dthEvPyeIIU+JqMhvG7OZdZbaeuFDkSE4RNjzNReTpBCNxR42hGGpV3
 yPkqn+Av6YNzDDbFoEtNqZ0tMUjTOqkK17aatb5+tFY0AtgOxmNsI2IfTdUPCChN/bjjpmc
 kbqW9MLGTNu+RL4r/dADP0VsuBDeV2ogC15YKzchJ70GbUeoP8Aio6z5bXvELp+ZQPyInph
 8osJeebv3Ihi4Q/qRsdgUBrySUO90jq07Btfap7/f0PnDu3+mLHpLVruqoIA==
Received: from [IPV6:fde5:2b79:35f0:2::166] (unknown [IPv6:fde5:2b79:35f0:2::166])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1))
	(No client certificate requested)
	by mail-outbound-e14cf917.virgo.mandelberg.org (Postfix) with ESMTPSA id 4ZDJkB2QmYzySw;
	Thu, 13 Mar 2025 20:19:14 +0000 (UTC)
Message-ID: <68251fa5-ec70-4eb4-80df-111ec3843536@mandelberg.org>
Date: Thu, 13 Mar 2025 16:19:13 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] completion: fix bugs with slashes in remote names
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: phillip.wood@dunelm.org.uk,
 David Mandelberg via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
References: <pull.1901.git.git.1740901525.gitgitgadget@gmail.com>
 <95ffa62df6ce394249a8ddabb84fb2b517825fe3.1740901525.git.gitgitgadget@gmail.com>
 <c03192bc-68d3-4645-9bd3-93a338a7496f@gmail.com>
 <2323bb52-f43d-4f40-8955-4c648677a93e@mandelberg.org>
 <65d903c0-6b4b-4a55-b7e4-4a277417f0f1@gmail.com>
 <42dfc06e-8eb1-46da-9971-9d102f1390ad@mandelberg.org>
 <CALnO6CBDjQgc2TNaXbBWiUNqWV=RgrL2Ry-7HzRu3Ozuqazzvw@mail.gmail.com>
 <e06caa06-0176-4340-958e-4c43650b40e3@mandelberg.org>
 <CALnO6CBurvi=gXzSdYDqSWDj9+R_uXY0rMZvz+dVKa+Bcfe=6A@mail.gmail.com>
Content-Language: en-US
From: David Mandelberg <david@mandelberg.org>
In-Reply-To: <CALnO6CBurvi=gXzSdYDqSWDj9+R_uXY0rMZvz+dVKa+Bcfe=6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Op 2025-03-13 om 13:40 schreef D. Ben Knoble:
> On Fri, Mar 7, 2025 at 4:46 PM David Mandelberg <david@mandelberg.org> wrote:
>>
>> Op 2025-03-06 om 15:24 schreef D. Ben Knoble:
>>> I'm willing to manually test the patch if I can understand how to
>>> reproduce the issue—it sounds like having a remote name with a slash
>>> is sufficient?
>>
>> Yup. I was able to reproduce it with these commands:
>>
>> /tmp/tmp.zOjfmdMx1i$ git init foo
>> Initialized empty Git repository in /tmp/tmp.zOjfmdMx1i/foo/.git/
>> /tmp/tmp.zOjfmdMx1i$ cd foo
>> /tmp/tmp.zOjfmdMx1i/foo$ git remote add with/slash /path/does/not/matter
>> /tmp/tmp.zOjfmdMx1i/foo$ git commit -m 'test' --allow-empty
>> [main (root-commit) 4b95a99] test
>> /tmp/tmp.zOjfmdMx1i/foo$ git update-ref refs/remotes/with/slash/main 4b95a99
>>
>> Then type:
>>
>> git push with/slash :ma<Tab>
> 
> Thanks; in Zsh the results after :<Tab> are HEAD and main. After
> :ma<Tab>, just main. The results with _no_ colon are HEAD, main,
> with/slash/main. I think that's all the expected results?

That sounds right to me, thanks for testing it!
