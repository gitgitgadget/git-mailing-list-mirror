Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C090722A4EE
	for <git@vger.kernel.org>; Mon, 12 May 2025 14:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747060466; cv=none; b=YeX4GDNgkIxpW1Mllvz/6ADYMsTNhdvWHi87AK4ss2UJtHIFV2Pb5uuMbiMlFQJ/frP7eDAoxzCFzptFswISySmttgltFWEk/NZFChx54Lua3pUmKcyO4yzre4WNGLXyFpQg9WoYZMQDwd2rOxfdktFSY34wl/stboIA8WBWQR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747060466; c=relaxed/simple;
	bh=Tgeg6dj9ITban6Ow5CyE5SjiKmuyfEELmVZkAM2TAAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t/kyqcwymjrvTxyaqdYMSCD681yA1eL8QMQmeldRSBxFUBzP64Aw1PA0Moi3rvFc+Won0Le5fJMBeHobsBJDI+Jnt9tzgUxd93Vi9F0I9ozboedIfHQ2f0dYLL2JFZulr0xGLKyH9RK5R2vnn0hhZv9OM2nN9/m2DFwdssgXVRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lk+gxk70; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lk+gxk70"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e78e53cc349so4037002276.0
        for <git@vger.kernel.org>; Mon, 12 May 2025 07:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747060463; x=1747665263; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6pGr2sx8nw0lQoHBMwYBc5pl0UTI0JHZwA6rdRLx6nw=;
        b=lk+gxk70+dY0Qr9s4IghA/IJNPC/pxLaEpV7nP3il6IbkjmeuMXldX9dxupOeLBMaF
         6FVd+JiSdB3SLZt+8q5nYGSsQS0zgvwxMrbdqFUukDLnUPu45bz5I3M+oibsg9khqH2p
         AB5E243y02y/682ay6e4mngqjNO5R31L+eP612+F2bCKB76df5CkHDMbVYirklVJdr1z
         GIc0OTSp39rhTdkMBuu3Mp3xqksOL4Hi0YwYTkoAWlcBdNwUeAQNE6TaOxb6LaEBdqas
         4hnfw5IfC1cEGCuxxFyV2iKQkgNCpTcGJ2QVx/ejxKY2cdmlR4d5VUwmtcLm5g+a9hb5
         7tGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747060463; x=1747665263;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6pGr2sx8nw0lQoHBMwYBc5pl0UTI0JHZwA6rdRLx6nw=;
        b=Y0CW5A1xPLt9lDBerZRpHWK1zIwSKlsvbLnAIJIhjXpq/B8f6UPZiq5As1GLyITkpl
         XnMuOKpkT9wYJjCfCTrk0keDsvDznk3w8WArUbqhS9bWmiZuMSUJ5y/9cC5dUlDSE4iX
         0fJ9iXnvm/6a5wiyMO6F6oQB7/5+2r2h7iB83S/YD4E/HJQ5103VYHUa+P7Nw+KQPIHO
         ZMjjkbIpCWpLlppxA5zxGmgnEGe7Qe8RdeDTSKMYTwW0gDQxbpq6MypNbQNqk0QOy4xx
         pKx+MVDCY9iUlf4yCgsxGDIPaCF6y6XI/ywJpI+M6+ae0oo1k0OLCCCiVWgvn4KsCayh
         qWOA==
X-Gm-Message-State: AOJu0YyONtI281IbqJ10qRI2GrZDdcHtfRFXtRqVbIGln/i1RrImxbO7
	DoIj/SLIZYFXmkRl+uHH36IXS8iZpqsl8HTT2pihcfh8YeY9D8fz
X-Gm-Gg: ASbGncuJo6302DYZSGdqJPFM3NZh2O1slKwq6bLIiq4BIOQ22CCkGDuDZAaYuv8CsIs
	WG6Qa3gwkqOaT5Xc/7QMrXcmeNjPxvXktXPjbrsr2Y9JMK8IHZRcE/4JMPokzWsaT314iRUYHGF
	Mx1vZjCbuwaS8naDuUK1QVMcTxcf0Tl47a9RTt0EcmDqu+QfqPRqdv6mhpd5pR9HGK4PiOEy1Qu
	1dUrTaYAKn6fvy/tGMjZyyEmIwwoRF8DzSNXLe2L8MvHf0LZ31WiXQVclpiERmMbIPIKUhNnyLL
	AtL37QPA01GR9iob5i8wC0d3ZqfVG3jL2VPZTFypVNjcLiu/m7hix/3zZnaby2e01f0ov2UEWfr
	YhCWS4rl/uaahgGrw/3yMauZtFkqjO9QNa+G/YPo=
X-Google-Smtp-Source: AGHT+IFNwrd6uP3iBTcG8wq60heTrEloOSruoTwfU7K1vWgy/EjEEb4pveqnAStL8/xiT3CuvL2k3Q==
X-Received: by 2002:a05:6902:1b85:b0:e7a:b192:e5d8 with SMTP id 3f1490d57ef6-e7ab192eeb6mr8870374276.15.1747060463457;
        Mon, 12 May 2025 07:34:23 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:f8ea:fa3f:d07b:1009? ([2600:1700:60ba:9810:f8ea:fa3f:d07b:1009])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e78fd6518b1sm2120481276.45.2025.05.12.07.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 07:34:23 -0700 (PDT)
Message-ID: <35ecaa1d-589f-4d28-9d97-78bae8de2d41@gmail.com>
Date: Mon, 12 May 2025 10:34:22 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] scalar reconfigure: add --maintenance=<mode>
 option
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de,
 Patrick Steinhardt <ps@pks.im>
References: <pull.1913.v2.git.1746458844.gitgitgadget@gmail.com>
 <pull.1913.v3.git.1746582637.gitgitgadget@gmail.com>
 <684f04aaf7e87f22ab0b00a4fd42d2943304ef04.1746582637.git.gitgitgadget@gmail.com>
 <xmqqcyckayb4.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqcyckayb4.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/7/25 5:46 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> Add a new --maintenance=<mode> option to 'scalar reconfigure' that
>> provides options for enabling (default), disabling, or leaving
>> background maintenance config as-is.
> 
> Hmph, this is a bit unexpected.
> 
>> +--maintenance=<mode>::
>> +	By default, Scalar configures the enlistment to use Git's
>> +	background maintenance feature; this is the same as using the
>> +	`--maintenance=enable` value for this option. Use the
>> +	`--maintenance=disable` to remove each considered enlistment
>> +	from background maintenance. Use `--maitnenance=keep' to leave
>> +	the background maintenance configuration untouched for These
>> +	repositories.
> 
> If I understand it correctly, here is the only place that the users
> can learn what the valid choices are, and it is not even an
> enumeration.  They are forced to read the entire paragraph to learn
> what the choices are.

I suppose this could be fixed by changing the `<mode>` to be of the
form "[enable|disable|keep]".

>> +		OPT_STRING(0, "maintenance", &maintenance_str,
>> +			 N_("<mode>"),
>> +			 N_("signal how to adjust background maintenance")),
> 
> And there is no hint what are the right <mode> strings are.
> 
>>   	const char * const usage[] = {
>> -		N_("scalar reconfigure [--all | <enlistment>]"),
>> +		N_("scalar reconfigure [--maintenance=<mode>] [--all | <enlistment>]"),
>>   		NULL
>>   	};
> 
> So "scalar reconfigure -h" would not tell readers what the right
> choices are, either.
> 
>> +	if (maintenance_str) {
>> +		if (!strcmp(maintenance_str, "enable"))
>> +			maintenance = 1;
>> +		else if (!strcmp(maintenance_str, "disable"))
>> +			maintenance = 0;
>> +		else if (!strcmp(maintenance_str, "keep"))
>> +			maintenance = -1;
>> +		else
>> +			die(_("unknown mode for --maintenance option: %s"),
>> +			    maintenance_str);
> 
> Those who say "scalar reconfigure --maintenance=yes" gets this
> message that tells 'yes' is not a known mode, without saying that
> they meant 'enable'.
> 
> The --opt=<mode> interface is good when we expect the vocabulary for
> <mode> to grow, but I am not sure if it is warranted in this case.
> Is there a strong reason why 'reconfigure' MUST enable the
> maintenance by default, even if it were originally disabled in the
> enlistment?  If there isn't, initializing maintenance to -1 and
> setting it with OPT_BOOL() would make the UI consistent with the
> register and clone subcommands, and also we can lose the above block
> to parse out a string.  Also the code below ...
> 
> 
>> @@ -758,7 +776,8 @@ static int cmd_reconfigure(int argc, const char **argv)
>>   		the_repository = old_repo;
>>   		repo_clear(&r);
>>   
>> -		if (toggle_maintenance(1) >= 0)
>> +		if (maintenance >= 0 &&
>> +		    toggle_maintenance(maintenance) >= 0)
>>   			succeeded = 1;
> 
> ... which does make perfect sense, would still be applicable.
> 
> I dunno.  I just feel that 3-way "mode" interface is too much hassle
> to get right (e.g., give hints to guide the users who forgot what
> modes are available and how they are spelled) for this code path.

My intention was to bend over backwards to prevent a behavior change
in the default case. However, I'm coming around to understand that
we don't need this background maintenance to be redone every time
and can become a no-op by default. (Other new configuration will
still happen.)

In the case where we're fine changing the default behavior, then
the standard --[no-]maintenance option will work, though it is a
three-way switch where the lack of its existence means "don't do
either mode".

I've got a new version of this patch doing what you asked for in
the first place.

Thanks,
-Stolee

