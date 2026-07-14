Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D1145BD6B
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 13:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784034101; cv=none; b=Nmyn8o5q4ZCDT0J5h3+8xsxg5+7+qRmoSGfAjlWmuPqNba7Z9YmnOcnvHg7i2VVM40Wca+fBF7IGD5LbrEKnn99D+IPNl0js+deLensPmPguBxU7ciiH1UwJqPC38UNMsMLkcYDg5qn09KLxhfTS48bkzav6YjPlh8Ihv3JkgmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784034101; c=relaxed/simple;
	bh=LoJg4om8B9f6QLZ8z59p7OEhSrZjcK3NqFPfScIVwv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X//tLCHWPnGLhaOVbl8aty0ucLy7JMUXn5FYimnZLrjrksCh2pTmdDbruCY7BV4Xf0RoXnHcHuaEom6E3n+PC97qCJPqrCg+SJj+JhU1zx7FN742EzBNQLEhKIs/BGfDl6nV7oRQB4A7lHf6/cHpAWjUCNuyI537i73FMqdOboY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BW83H+PI; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BW83H+PI"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6974a6e54dbso1248156a12.2
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 06:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784034098; x=1784638898; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KwzUksHFbUKqB8Wbmj+Sz9DPTo7hACl/Y0WzMz9zKz4=;
        b=BW83H+PIsob9E78DH7arhAUleMMsFDaKjYsNyau/JM3xE69y0vaedwnr2V1IYb7tk4
         RCr//fpLYoNcEGe3suvjra0WTyxUICHqaGHrW7G07SegGSCw2ZPUCd5Uc+kBuAOtzWk/
         rQXn2pZN4IQlXPYBdJiq4TsdkEiG1XeXODoSpGrHJwr1QrHrT5udoKYCBAQXqrtK8VEB
         ExLA/LdwcR+ReKpJIxcP6LSIZ095svHEHzz6MaK56QAppXvAfOt4co0Vp9ChEWzDMsHq
         BoWgUJPVTi1UWEJRvtwcsPWz+UejYLa2JNppgu8aPGs00/p1NwGpYK1FqSvfG53PAY7t
         Ba5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784034098; x=1784638898;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KwzUksHFbUKqB8Wbmj+Sz9DPTo7hACl/Y0WzMz9zKz4=;
        b=Bq7OFAnj7gySON1fh7h9wzOdTa1JfYQOF+HSpa49IGeWgwPWcluRdg738KjM66SYhD
         z3X1PrdFsILhmsHKTYNKRXu9fBiD04bMVZ0I/6UhKyeTIEnOHLuuxSnUJWUnVTKRmEay
         dOPCbF3+337Kf6pOlGw6YQ+Sb+F+nvXWFxleC3Of8j5SDzQeIEFWneQYnbc62oh9n4SF
         Il0VtJeFXlMh3ixxavNo+5ZcSkDJw9YQlwT4Ux3V2y+XvpaudQVJsaZlKpsGELwBbPAx
         WNP9/rvBumNKyVEH6b4e7CvfQbiqxKTOW/Edz4WZmAHSklWePdwVNDVHSpLOZxXsaGXa
         TqlQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpivgz684pYPnJlEAVgEOA45hum/hIyRhUUYZ/+Vfqn+QJcNpRHU3nIsAxrGA5K0fi958g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDIo+NiRroBqXZJ53cz5sF1qoC490Pp+fhvZ7J48uQSs6//o7J
	t4Uh6KZChipX6/Ar8tL/mSwO9ykxazCeVhSnuUEtY5Y20NWB6CAbB1Gz
X-Gm-Gg: AfdE7cmSp/HTaXEKdyQ27QCHHA/PU9y3CJCeW5dJGbIjfl+ZWS+UOaNGdPo/i4Zc4ZQ
	gHE4qA3RrnLvQig/4StqN/rEnqvWig13P31o5hiO1im2R8Wn1EqhyVS0kJol5hkfD45CoT2bOt/
	FkytULssPLs7XBYJ9r6hIYd+33trjifkEAfgf7Pzu3nelxy6DREEQRCz6GCNh9ZKN4WV9/trzAk
	dOZ+mHaypNkRy1P6ADmz03RPcQ2coxhLWlmxrZryZLvODjwt2k238z7ATEKuCJFHLH0i+eqAL2F
	Yk6e/lQQlj0VDbFUM/N9tQoh5/VVn0ImtzXeKxGtDloeKBpICrQ8Kw1A0Kj3LXMYXlhm2o3YuhZ
	QSY4qJ7VqUG7c7S6nZ4cDDKMYrNkFbH+W0oADJ7jqXshAAPvebqUY6rdKfzQuTtXh48oWGsCjxu
	4tY7hBxCY5410ywyQSkothe7K+rizHA4x46N7AJ8adqA90IjbUaL2UoF3q2XXVgFgnL770jF+r
X-Received: by 2002:a05:6402:158c:b0:695:572a:7abb with SMTP id 4fb4d7f45d1cf-69c5f1040b6mr6169733a12.22.1784034097033;
        Tue, 14 Jul 2026 06:01:37 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:79cf:bdf1:be6e:e3d6? ([2a0a:ef40:69a:b801:79cf:bdf1:be6e:e3d6])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69cd295663esm1500368a12.30.2026.07.14.06.01.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 06:01:35 -0700 (PDT)
Message-ID: <2fe8c5e0-96d1-46ce-8fda-1b8f521d3c4b@gmail.com>
Date: Tue, 14 Jul 2026 14:01:43 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 5/7] branch: add --delete-merged <branch>
To: Harald Nordgren <haraldnordgren@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Johannes Sixt <j6t@kdbg.org>
References: <pull.2285.v17.git.git.1782113388.gitgitgadget@gmail.com>
 <pull.2285.v18.git.git.1782338106.gitgitgadget@gmail.com>
 <a84c555d99c98abcd4618833c14fa35b191fbda2.1782338106.git.gitgitgadget@gmail.com>
 <e35f1268-2518-4a44-9c7c-28ba13ca7b7b@gmail.com>
 <CAHwyqnU0ifHu0+GfMR9GqWKgFrTOyQn-FbUH0wTm_07nCa26tA@mail.gmail.com>
 <CAHwyqnWspUTSnqmkMyXtWuAnENDSzrRLhhUR=Ljtt1xer3tphA@mail.gmail.com>
 <5212d968-6121-466c-8225-36b4bad6b211@gmail.com>
 <279e6d69-191b-437a-b1b1-ecd879343f3d@gmail.com>
 <CAHwyqnUKSD=G1jkdc6n5mVA-NvCgL+c9zCEW_Lr8OBP5q2fKkw@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAHwyqnUKSD=G1jkdc6n5mVA-NvCgL+c9zCEW_Lr8OBP5q2fKkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/07/2026 19:17, Harald Nordgren wrote:
>>>> This exposes something that I don't love about this feature,
>>>
>>> by "this feature" do you mean "git branch --delete-merged"?
>>>
>>>> which is
>>>> that when using a pushDefault (like we do in the tests with 'git
>>>> config remote.pushDefault fork') if not adding a special case for the
>>>> main/master branch (like 'git config branch.main.pushRemote origin'),
>>>> then it will get cleaned up as a forked branch.
>>>
>>> Oh, so because the default push remote is not "origin" we need to
>>> override that for the branches that we do push to "origin". That's a
>>> pain, but even if we did add a special case for the default branch, it
>>> would not protect other branches like "next" and "seen".
>>
>> Thinking about this a bit more, rather than protecting branches where
>> $branch@{push} == $branch@{upstream}, perhaps we should be protecting
>> branches that are merged into their upstream but
>>
>>       git push branch.$branch.remote $branch
>>
>> would update $branch@{upstream}. So we'd apply the push refspec to the
>> branch name, then apply the fetch refspec to that and check the result
>> did not match the name of the upstream branch.
>>
>> Does that make sense?
> 
> This makes a lot of sense and fixes my major gripe. Seems very
> possible to implement as well, I'll give it a shot.

That's great
> Are you done with the rest of your review so I can push out the next version?

Yes, though I've just remembered that when we were discussing protecting 
branches that are the upstreams of another branch Junio was keen for us 
to extend that protection to "git branch -d" as well.

Thanks

Phillip
