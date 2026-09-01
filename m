Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1B835AC20
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 15:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788276434; cv=none; b=SWffrfzPymGRbOE/IPpTYHkCykcAIpo9Rtt3mA5fPKXIdFnAMlbCVHcoHrQPty0lP3H6gaiqKez9D6bM5UiFxxPmh2tOYaOUXFXMJKdL6tGJ27u3Pb7y0iXtqX6cc50Ui2k23V/JalU9cHwvuvuPYlmTGeo4Mmc+vzljz0ptiSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788276434; c=relaxed/simple;
	bh=tp54R5WeaWM4g+Q0x5kn2xPnHXaRXgP7I88gcnD7lbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K1eOeH2bNKVgujYyIDODeOHR4gy9GZgmG48x8ZIjNG7Sd8Ud5sV+BLMxwbc7XAPesffisE4paB4GVGGYpNKLXm9WbJN72Hje3Vq64ZjPg8NxTdtZpiGdPha4wkzNByWOjlIWkbXWz8873Rrm+JTGPMdfTIT3AiYXgH6QyLermUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcJW2zF4; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcJW2zF4"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-936dfd009d1so147100385a.1
        for <git@vger.kernel.org>; Tue, 01 Sep 2026 08:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788276432; x=1788881232; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i0HXPCqZ2OtNg6hEppx0uFcvUQ4ReJv/1I5jtaZs/54=;
        b=AcJW2zF4UQ3v7lLfDDIPnDDRUK3YMzC3IpdVeG/RcvylM5yTnbVC7RIJEZBCvQqrI3
         tc8UymvxPMpDLNenZdvzSDdQfnNiramUrgKpwT8tZjnkHzPNpqr1gcLIMkxPtprOK3nF
         E9YcB8mOT/3s4I+AHMRGbBzoHRSbZvr9JMvDGY+plImIl/YgKVzAcp7dFas8EisJpxF9
         SRgerb/4W8OGW5DxVrIhHjzpMWE15ps1tfr8QFj6kAzOK2BDakPjpnxCMD2LYpdZrIF6
         hxzd0yaj1XMHyclSXXwpYMCWRw/zt+ciZQPZF7mAf3fNul6c9wW/BltqJMRYx6DgSL+t
         OCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788276432; x=1788881232;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i0HXPCqZ2OtNg6hEppx0uFcvUQ4ReJv/1I5jtaZs/54=;
        b=KPLZVF0w+sEnUYJjs2Z7q57V8rlVBENL8gCUs10RHK6CFvfQ7pTW7fDPHCmaSJdrgp
         w7uzS7cFkPwwjCsfoJcEgKYDj2uknIrMEln66VqEFT9rzaHweZO7medN7pPz1qLfeoVP
         ncV+g31rd6IrML8toijwmLJ75IF3C4Uw8HnCVXZFGetU3nwnpY2JC2vG49w3GwjJzkey
         ORJQGLpsQrErV9U5a3aWyowSULj0fTSOYBMJkBrgtee+BwjnPbA/cjoXiagisxMQZAfl
         66P7hcRTIj8sUnbjDMcYaItrGw0pJq+dYZJWcdkv82A4S3wk3S84K3iEihCfXgZJQ3/4
         xEZw==
X-Forwarded-Encrypted: i=1; AHgh+RobwDm82rr8HwQ1RO9RvdbvI7lq/3AP8L5WN44TJsIjV7pwuchzZBRmZPN0aP4HTXRuet0=@vger.kernel.org
X-Gm-Message-State: AFuF++lVqZ7To8os7X44kcSTBpOtcPjZmGZITePG/oe406KWwcNHIifS
	NRLxC4VymrF7geYbsPZRzUD0D6pesvZTVQLhp68ioxr6X/LpqAQbTMhk
X-Gm-Gg: AR+sD11TedEgIy65W4eUsOn49wEbURlI3//ytbYtLaS2oOqMZ3LSUNCRMGUJQJW9rKs
	/E8FMnEcq5K7+moOIDKbvv627etG0FB+5knBw0kzrlwf3tcL7TOPpq+jf+ERn2qXObgbMl2rVFN
	f3DxLjPLezT7KRGDtr3OS3WP7UPWDcIrkRRTbnZBYAe7LYM690aUu618JzWJ6szjUnSEasN9MaT
	m3vPLqP2ILUdhoInltj5Ztp3TeDicJue8mOxE9gWwELzGFO+646S+OANcVNu9lTb6oJuOcHftO5
	83bzBQzGWosjy6w2bAGS93MbggiCwcCOYfZveOEWXEeiZuuuo8vm2EEqaxv2NwjK5qDeBxCpOTB
	bIrJ6Ymku53IoH0WeZ9EzIfzEY9MnpPHlrGaGrSqy19WPtLGm1kFvWW9quzM472DhYAsLYzRrv4
	AQrI0c/9Ulg1hzQm6ahDlmFllfBYaEJChh3xHiN0R4XIMPup2ijBOw473ptBwJja4oKgDjyFRi7
	k3HQ+TP9rmZbOFGDonfqDBexwvyzylY1QfsWgNESDXgNhwUHoDreSDeCbS1d/65MJZz85vgCKgM
	BkQpmOVImu635Wk=
X-Received: by 2002:a05:620a:5687:b0:939:4baf:5b99 with SMTP id af79cd13be357-9394bce9476mr666359585a.18.1788276431608;
        Tue, 01 Sep 2026 08:27:11 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93917422c4dsm1063025285a.45.2026.09.01.08.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 08:27:10 -0700 (PDT)
Message-ID: <374bffe1-47ff-4cb6-9d69-f4b7da7292da@gmail.com>
Date: Tue, 1 Sep 2026 11:27:08 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] packfile: recover when a multi-pack-index names a
 removed pack
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
 Elijah Newren <newren@gmail.com>
References: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
 <pull.2207.v3.git.1787986831.gitgitgadget@gmail.com>
 <9b0966df9a060df215d8aec7816875d42651d5bb.1787986831.git.gitgitgadget@gmail.com>
 <20260829120721.GF40814@coredump.intra.peff.net> <xmqqjyp71g9s.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqjyp71g9s.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/30/2026 4:53 PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> ...
>> Sorry, I know that was a lot of text to end up at "you have already
>> written it the best way", but it took me a while to reason through it.
>>
>> The patch looks good to me. ;)
> 
> Thanks for a very informative and well reasoned write-up in support
> of the series.
> 
> Shall we mark it for 'next' then?

I'm late in responding, but I support the series, too!

thanks,
-Stolee

