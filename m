Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBFF2C198
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 16:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709914953; cv=none; b=bIResjlOu04md2Ke6Wx7ovWSVS3njP6pL1IKDa27JAUH5qfhRjA87E52dy2QPbEtLfE+3ckZp6RYe1j3veyMX3oDxFurlMhBfolPD2xHCoQkRTf6vMPUu5e1/K61wmzK/HidF0JlpU++W/BPD6Mr1DPVp2lVBAqfnx3KFGbhB0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709914953; c=relaxed/simple;
	bh=3KHdA1ft9OuxL/908jfCfFCkgNQTAWPfPVPLLWCZaR8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Tedqd5AMoasPQvxb9SEHWNH/9DbyRmHyzjS9xmKR8a7Y3P8/5V0GSBviUqhcQyddJpjDwuqq+M2G9tkeOdX9eGZPJBvGSr+daCn7jdpwe5c/AbGHePC6LAFcdKuUNbsAho+ePRU1MWgXNeWfuPv25LMcV1RQFypdY6Ya43LQN7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAHpfNJZ; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAHpfNJZ"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5131c48055cso2573034e87.1
        for <git@vger.kernel.org>; Fri, 08 Mar 2024 08:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709914950; x=1710519750; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DCBLGrdpZ118EeClenl1G5I4jnpQ70iwaFyACJFbr9A=;
        b=WAHpfNJZ4lxrx126Dd8yCLF6/va9IcltXlaidDQJTxWger5pdARFyiTGEIUrnx8+aT
         QCtd3xirZ1CcajbmbsZK2GsppQzbCxwi8JA2fI9kzCe5Ars86ZOUMbdEqfwkLxakb/4r
         LKkvbEYhd+qLfl840TDHF9NCufhHgjQaFNy5NtWuac67CY0TXv7Izypu9UA/k5mqpvmG
         VgPW37g+AP/6Cqlqao0xWuTO0no+nivtVor+9cHJduMhzG2ZFPck0rIslk+BGia7Gftp
         eoKtHpPpQ8qK5iMkgKOEz+mYTc7vPeH1d3HOmUE5WCn7BGH0z0cKXUwZD7oJ6ChTMXOG
         KRNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709914950; x=1710519750;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DCBLGrdpZ118EeClenl1G5I4jnpQ70iwaFyACJFbr9A=;
        b=hL13pwmzrIZtH5nOsGQh2vT8cDCCuvQupkr3N459B/un6ojzsHYiHxoeORnAusCClX
         KRoUpxjLCgKYGiOFdTGI/9PMXUjVSutj9CV7M7T6TuBBEXXlCGcPNu6w7205RJeuy4BP
         Jfd2TZk0fQf6bYz0JO3514Mu7ihlF2w9Y3vbRi1vhEooCZzLOcDcJ8Vt1eYPUecuLZXi
         Q/jSS+iCRNn/8hvzrANFv+uGn8uA1g2acgGFrf/3N60T/40pt3oZRQEHbQS2hZb866an
         0he5pJAp1esJ7PqcZEg3j4xCm4DcnPzz9PEHxxexAW3Qg+MsHSQLo4ttZyK+DZbsLx/Q
         E/zg==
X-Gm-Message-State: AOJu0YyGkpsSnpUAD4SyUkRPyd0qJMbWDuhsYSu3kdas6UduJZ7bBZCC
	baWvYNWlmc/uYjalJ2GVtSbFAP2XGVCahD4fjJ+ms7c3IPx3gSRL
X-Google-Smtp-Source: AGHT+IEyPRBosw1ee/AqDmh6zdIWXdweogFHLfFlh7nd02Rc9N38OnlMcIyfO8rtdkjPjUP09mjixw==
X-Received: by 2002:a05:6512:324c:b0:512:b0a7:2943 with SMTP id c12-20020a056512324c00b00512b0a72943mr3305381lfr.5.1709914949711;
        Fri, 08 Mar 2024 08:22:29 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6ca:8b01:80a6:cae7:d811:7244? ([2a0a:ef40:6ca:8b01:80a6:cae7:d811:7244])
        by smtp.gmail.com with ESMTPSA id dx13-20020a0565122c0d00b0051255cbaf06sm3552396lfb.14.2024.03.08.08.22.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 08:22:29 -0800 (PST)
Message-ID: <1fb1c84a-b6b3-4e3e-896f-5fb93cff57a6@gmail.com>
Date: Fri, 8 Mar 2024 16:22:28 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 4/4] checkout: cleanup --conflict=<style> parsing
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1684.git.1709907270.gitgitgadget@gmail.com>
 <317bb7a70d023278087f4370b843d7f28f9ee2f6.1709907271.git.gitgitgadget@gmail.com>
 <xmqq1q8khf8t.fsf@gitster.g>
In-Reply-To: <xmqq1q8khf8t.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 08/03/2024 16:15, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> We could use OPT_CALLBACK() to accept the incoming string, parse it
> and store it in opts->conflict_style and that would be a way to
> avoid the extra member.
> 
>> +		opts->conflict_style =
>> +			parse_conflict_style(opts->conflict_style_name);
> 
> When I saw the change to xdiff-interface in an earlier step, I
> thought parse_conflict_style() was a potentially confusing name.
> You can imagine a function that is fed a file with conflict markers
> and say "ah, this uses diff3 style with common ancestor version" vs
> "this uses merge style with only two sides" to have such a name.
> 
> parse_conflict_style_name() that takes a name and returns
> conflict_style enumeration constant would not risk such a confusion,
> I guess.

Those are both good suggestions - I'll re-roll next week

Thanks

Phillip
