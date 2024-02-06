Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4591DFFB
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 13:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707227808; cv=none; b=MKlAHqMDPXAcbcoQgO1f0PhjAOrITsSeCyGQH2kF41iNmIokGv4zlIA7h0QkncPvxLdQ176Pu8qAMZh7k3W6nD/A0+gOA8JN4kNt6VV0U0Y2NNvddK/Sv93xb++D+81ixB+mJKuvTOQ32d+h4yo8SeENUJog3SPkasUxtRUyBac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707227808; c=relaxed/simple;
	bh=vyMcZ+8ia3v1SxgdQ8IWZnoUteXlqlh9VQx1r+3qOG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XwNYAMW8N0Ov4w1sTJIhePp+pe9Zbeexxv6lVeXhIpLAmw4t4GbmidX1HNBkXetxrUIAyl1EY4opq4ht53XchFrnNiKN2+i1SmAiGNrSdOnyORvJ6a9G1mSohaRGqIZ4wo+eRuA2kFJFS8xjfBbvdkKSAGQPusXMvCFUeg48mfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4SCf4Zj; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4SCf4Zj"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5114cd44f6aso2650653e87.1
        for <git@vger.kernel.org>; Tue, 06 Feb 2024 05:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707227804; x=1707832604; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TZxcspTo6sU7LWoFcUU59dhsGkAfFUR8V1pHCo+Rd6g=;
        b=g4SCf4ZjlLGA23kuf4u4sfHgIzWTBvv1t5auLieLWZenn9M0lqeR3yF0emCmZck4lW
         tpLt4gXufJlIemGI7m45aXPX1zcQda2WXe30sdyYdVhMNMXKuJ790Or7zJOBUPZaiDm4
         GxDKFFWOWh/t1O1lkrzRFG3jbugL7blmpGuguHpzueMZwWKfadSDXEH8wtfVdaLMXB36
         YyH8tCD8XQPpIpRG4d3pDpmLW2mIW501OdSOiiTelCcCjek4cBsA4XBEgc4xaCDdwteT
         0lcOEc6joLJu2RcB7EO7Ig7klcTtHxmfroFfIXpIcamreYPw69Q4BISg6xCtbKlw6oid
         1hFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707227804; x=1707832604;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TZxcspTo6sU7LWoFcUU59dhsGkAfFUR8V1pHCo+Rd6g=;
        b=XD1imq6P5S3my5+m5PLt0Gcj1cmS671wEP9QMaANsV/rqbGm/6ycu/GUjTU4+Pnt19
         CXbqThjnLUh+yP6H0o8v4TxpIxi4vWtvN71lslfykcLxdd1+G2Mxs133qlZDu69/IMxU
         rl/jxX9WoAU8/flH2LJFH/t40gTqtyrEaBXXxaCx7mtau/ghuB6zISlSyK+l+JiC/3lk
         CKoun0nD8GQPFvU+hcsrI3/wtpe8GZIDWwdP6OJLtpKIyD0c2CXRMLHkSXYf3Unj07ca
         VWWXqVQgljKTo+DElWer43gZjatL2A8eYrVeQoaJl3R8lFyiFTL880qRXPYAsDuulGbH
         VmdA==
X-Gm-Message-State: AOJu0YxztszUiFpp2vUgLHdxT56nVSeXkKhQ1Cu3nGU6QDHhSuh4SLCG
	0KTzBoa9WYqjYfnkZTXnCM/x8rIlzVL0z+GUN0oiNVEUve/F20SUgxmWptvJ
X-Google-Smtp-Source: AGHT+IFM3RT0Niwg2QQ8oZMGk3sgk9eK5OavpnfbkrSI9Efwijzh1+dgtL6s1NZberMzLMNu2YXLBw==
X-Received: by 2002:a05:6512:1195:b0:511:4a79:7d83 with SMTP id g21-20020a056512119500b005114a797d83mr2394033lfr.54.1707227804380;
        Tue, 06 Feb 2024 05:56:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX1ndpyau8bIsucDJJ/6DWvw6CGmNP4yuzbf9R0cNDfNC2cRfGuGcxZykoGnLq/eyMcw7x+1Pl7R4r4DQoGYMcjkvdM7TrG5B6PeJJiCcuB7g==
Received: from ?IPV6:2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1? ([2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id gt26-20020a170906f21a00b00a37b795348fsm1154280ejb.127.2024.02.06.05.56.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 05:56:44 -0800 (PST)
Message-ID: <a94a5ddf-c36f-4125-96b4-a4534b67d762@gmail.com>
Date: Tue, 6 Feb 2024 13:56:43 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Feb 2024, #02; Fri, 2)
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
 Karthik Nayak <karthik.188@gmail.com>
References: <xmqqmssirm6t.fsf@gitster.g>
 <087d3438-98a1-46fe-89d9-8e7e1662151b@gmail.com> <xmqqjznimrbe.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqjznimrbe.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 05/02/2024 23:20, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> I'm concerned that the UI could use some improvement. If I understand
>> correctly the proposal is to make
>>
>> 	git for-each-ref
>>
>> and
>>
>> 	git for-each-ref ""
>>
>> behave differently so that the latter prints the pseudorefs from the
>> current worktree and the former does not.
> 
> I would actually think that is perfectly sensible.  The optional
> arguments for-each-ref name "filtering patterns" and you can view
> the behaviour of the command as using "refs/" as the default
> filtering pattern when nothing is given.  But it is easy to defeat
> the unfortunate and historical default filtering pattern, by saying
> "we do not limit to any hierarchy, anything goes" by giving "" as
> the prefix.

There is a logic to that if one ignores 
"refs/{main-worktree,worktrees/$worktree}/*" not being shown. As Patrick 
has pointed out the change in the handling of the empty prefix here is a 
breaking change though [1]. To me, the handling of the empty prefix 
feels inconsistent with the rest of the pattern space. The patterns "*" 
and "*_HEAD" don't match anything and there is no way to filter a subset 
of pseudorefs. If all we want is a way to show all the refs including 
pseudorefs in a worktree then I think an option to do that which errored 
out if a pattern is given would be a better approach. I'd prefer an 
option (say "--include-pseudorefs") that included pseudorefs in the list 
of refs to be filtered and allowed the user to filter them as they 
wanted. That way we could later add a "--all-worktrees" option that 
included refs/{main-worktree,worktrees/$worktree} in the list of refs to 
be filtered as well.

Best Wishes

Phillip

[1] https://lore.kernel.org/git/ZcHEmyvvMR_b_Idl@tanuki/

