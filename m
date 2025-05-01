Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9392D600
	for <git@vger.kernel.org>; Thu,  1 May 2025 13:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746105680; cv=none; b=iLXLEpPYrkH4M4LxU9uSKENzRUe/DfRKZBnc5e+mrmSAfwZ3tt/UVIm8Uf6U3eWtRUMfVITlc7Ec6pEDYtfxjzUMVVaJ4ByOVfUSuwo+pyjopv0sGHh+iAIDvO2fvYyAyKhuJIJt7m3a9E422dKzLyqrxQ685C3xSnV+0YKv43E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746105680; c=relaxed/simple;
	bh=Rlu+Zp0H7dgiPZ2KCw7gEnxm7uuxQwzH8PC7SQpebN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cVFo+SLXHtyhmiViIuiEkf8RUJNr2z185k85FCKwsQ1r2MjYujvRvUVHvSfMORiXxoSlnCe2kBlnkE8wzS3N1BsDinjrnWmrqrv8GkrW7cU9poX5JetdJfRvugwaabtCjUJokya3ScdwkD9ghjGRm3nWYSZslJ1GEz9bz2cG4fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PxqrMaOw; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxqrMaOw"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6feab7c5f96so8494077b3.3
        for <git@vger.kernel.org>; Thu, 01 May 2025 06:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746105677; x=1746710477; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pITRjZKlfDsipxxDmGlwrmfOB3Pp8iinpzc+2tKpsaw=;
        b=PxqrMaOwIagHQyPB8R74mWqbHo26+wNgTTfJlQTGcC+dk6GItXjQr7045HIqLYBSfT
         DiUOH9m07B5T8s8HJTQmzH53MNKm1Qm7UeaVpu2g/vq3ZsDcKlTVPdraSY69kP8fz3Zz
         CfGkqqpqdkcE4/07dpOfdOhPC8mF4jS3KgUpvpbs5B4rNji97RiG+uCBXZaiVVWctxAH
         H67DlvGRw9HbDoazCzkCYVYSHz1VMs0QLc+O+QMIHlOX7hWC2aJgpyfMZropghShlypQ
         B5zh8tr2OCoA+ckPR9qEjnJGwmTyap9E5euEzBoWjTzX3621oxDVo65vUreEXoYjRy6w
         8ptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746105677; x=1746710477;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pITRjZKlfDsipxxDmGlwrmfOB3Pp8iinpzc+2tKpsaw=;
        b=tZqwv/IFaR/Rl4UOkuGYflh8fgEKzoxuidMjJjpUrz2wXyMswJuTenm+H1vPgge75X
         mpAWRyIr7J97fZTAF5yhl5ky3vSPTm348xx8YZVRgGfEIjPvrik9S4A2cGiRqEagavEg
         58fSBH0cOJbjIWgXWF2CaUXfDRVaUAYO4geOj0WUDEiqzu7Bfo7t7MbnpYa/dkXIa162
         i/u9PxcPTeb8kZKxJEC7sfddQYnl7HZE+LknSItgVUhdhC/mZKQjKMwQKKsYvMzpE1/u
         sDnDzEN81RPVTkErKVEeczGSq1lna5kPtCe4gMVFFSaeu9Dht00m29ajjJ9lLJfpYk3I
         VpTw==
X-Gm-Message-State: AOJu0YwVNTa6TdnFRjEyR0CrqviMHYwr2Ew/1llTNQsi0HqFolK4Fogh
	768/rh3JeVEKlOyuWUbVmLBT76qmd7Mq23b52GsT3niQ6MGyIKRDhjb/1w==
X-Gm-Gg: ASbGnctTIRADNDMlKj3FHGA+8k7u7oW87VtRLXiL3+4z8S+JJNXAOBtF8xfUJq1b6cu
	ijk4AaE9URbCU/OGEFWMYk76iF6PItBiSsV1CuenaQFIBn+8rilnxK5aHPnP9hBQY57O2ffEZ+7
	JLhqTXDtGPEvwiOjXHdCzy8pFiIkFE4XSVtpQqTOckIM93TeT1I9FlpLd49DKf+qijC32ODL3/4
	8VL7MC0vPXMEdK7ozLkgA5zUEAIqIl2NecFPEu8FqTuynAKnuS7ukRoXQXNHHfiIhTi/IfskO/l
	+eFptlUOEFYrWEdBqRox04c4MuI1olBqNalWvpUHOnNfBO14IXfwNAY3vCmfZgoWHQnP1NrUv3g
	fMmKSAIMRn2u3ug==
X-Google-Smtp-Source: AGHT+IFJN8MC/GdKVrhgOAWMg4uEl6MRmDCaeFc8FfSGbCsBNVknClMlxcSohksHfKq8lPBtrTx6iQ==
X-Received: by 2002:a05:690c:9a0c:b0:708:21e9:a20d with SMTP id 00721157ae682-708ad5fea0emr96550577b3.16.1746105677322;
        Thu, 01 May 2025 06:21:17 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:13f:4795:c031:83b7? ([2600:1700:60ba:9810:13f:4795:c031:83b7])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-708c3f081ddsm1691477b3.8.2025.05.01.06.21.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 May 2025 06:21:16 -0700 (PDT)
Message-ID: <d3659baa-054e-4a31-a851-5471968aed07@gmail.com>
Date: Thu, 1 May 2025 09:21:16 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] scalar: add --no-maintenance option
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de
References: <pull.1913.git.1746008680.gitgitgadget@gmail.com>
 <xmqq8qnh1jjg.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqq8qnh1jjg.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/30/2025 4:28 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> These patches add a new --no-maintenance option to the scalar register and
>> scalar clone commands. My motivation is based on setting up Scalar clones in
>> automated environments that set up a repo onto a disk image for use later.
>> If background maintenance runs during later setup steps, then this
>> introduces a variable that is unexpected at minimum and disruptive at worst.
>> The disruption comes in if the automation has steps to run git maintenance
>> run --task=<X> commands but those commands are blocked due to the
>> maintenance.lock file.
>>
>> Functionally, these leave the default behavior as-is but allow disabling the
>> git maintenance start step when users opt-in to this difference. The idea of
>> Scalar is to recommend the best practices for a typical user, but allowing
>> customization for expert users.
> 
> The feature itself I do not have any objections to and I found the
> reasoning given above very sound.
> 
> With these two patches, we still have an unconditional call to
> toggle_maintenance(1) in cmd_reconfigure().  Shoudln't the call be
> at least removed, which would mean that reconfiguring would not
> change the auto-maintenance states, or made controllable from the
> command line of "maintenance reconfigure"?

I agree that this was a miss on my part. Thanks for the careful eye.
 
> It somehow looks to me that the real culprit of making the result of
> applying two patches still unsatisfactory is the original design to
> have the toggle_maintenance() call made from inside register_dir()
> in the first place.  Shouldn't a much higher layer entry points like
> cmd_register() and cmd_clone() be where the decision is made if
> maintenance task should be set up (or not set up) by calling
> toggle_maintenance(), leaving the register_dir() responsible only
> for "enlist the directory to the system"?
> 
> IOW it feels to me that enabling (and now optionally disabling)
> maintenance is tied too deeply into the act of enlisting a
> directory; if we need to disable maintenance (and a mode to add
> enlistment without enabling maintenance), it is a sign that it
> shouldn't be a parameter into the register_dir() function that
> controls what register_dir() does, and rather it should be done by
> letting the caller who calls register_dir() decide to call (or not)
> toggle_maintenance().
I will continue thinking about this while playing with different
options for a v2. My gut reaction is that register_dir() is our
centralized way to "set up recommended configuration" which includes
config options and background maintenance. We're now introducing a
way to customize this centralized operation based on decentralized
options, hence a new option to the method.

Is the right solution to move the toggle_maintenance() out of
register_dir()? If this is the only way we plan to customize the
config, then yes. Otherwise, the second or third customization will
start to lead to copied logic through these three locations.

Again, I'm mostly thinking out loud here before I go and dig into
the code. I'll report back with v2.

Thanks,
-Stolee

