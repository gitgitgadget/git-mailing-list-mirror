Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A804313547
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 12:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791202503; cv=none; b=r2CphOKh0Avsug4IFHIoG4DN79C1Pa15A78QNutAYnxihEuFepFhfYZLjRySRtYRKcfgVB21xRTkE3bTt7hoU1MMZLKJEZMnLzQqaCJs1U3LKUmwhLf2mzY6Cx5I9nVd+V+S84La0T9/MxrtROshM4+jXnIl509rv0dMXuraCco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791202503; c=relaxed/simple;
	bh=EGV2fUILf0LlRDJgKRVi0T/5BUO4SiSt/eMmTz4vGTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ea7mSfMUkkHq6+Llreb3MofzcKDdEXFr4HjR+3oiLi56vty4B1fwtXBxNeDMeoKzWz8F0gGCVtx2MVOkE9W+wYouUaZDyDW3gFTpb0iJoWmgRcNWCPjTw0KSPSPAhBkhUTn/me2dtZoblv8rOZ69m2f0kfQOdiUHrzbBWOEVZ84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etayPTNR; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etayPTNR"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a6f8525bfbso967725a91.0
        for <git@vger.kernel.org>; Mon, 05 Oct 2026 05:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791202499; x=1791807299; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Iq8uUNxx1hXlG2jjZ3uBU5dxKV+9ksC8bKMs1AifONk=;
        b=etayPTNRxHmu5NffSImMtPBSzYrGBhTDsBF+Kk9mOjjQi8w2GUBdTgTshX4YWPwDYM
         CIqK5AzZUU4lQzzu42nQEJxg3eEfMWXqsOWaXbjHG/lDya9L5A4HGIMxfFDHGHMhMXXZ
         CAiHVs6y71dudDH+YL4kQnMGZZdr86OYQdhdSEefg9qtyvIWPpPgEDBe/vmPBvPX9ZKP
         KRhffQdtJ6BWuo4IY2t1JyxzsXLb0Lwrl16XIElwQ7JtVrpymcgq/ErQRKTM+aHfXQpa
         l/6AoJRs5wx3lfypP8tkKdDUQkRgQB4HQu8VuJE6DoESRJ5cC/tcXg9/0MZU/M5O7T4y
         iiGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791202499; x=1791807299;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Iq8uUNxx1hXlG2jjZ3uBU5dxKV+9ksC8bKMs1AifONk=;
        b=qYWPrp/ls2S0tygMrsqWGkvroQBvON0AeNaeLfpoO3AkmJKEGJE2xEEu9Cc9GsPniH
         eBHhPjBmDUj9uLXRrLttZHU/FHoHeb7VI/DdaqDXXHtZVasYlgeMOeTkNj+qStOAkNMi
         mc/VbmevzqLpTkA/0TFD1Pa5mJ9CR3xocP/VtbcWrwwdPC2ulsKMWcMRmxOrlS63Ch4P
         ingeviu0hAIx92yec666MIFbym4ybkUgEJVHjgivyEdJkzrp5lGPfwnBB2ENDgF450yR
         rD/TlLwt9oQkxK9daftOcz3vKYABRPwW9sQ440VVCCwalCDmZDCMlWF0p+FEyaq4pIV4
         t6dw==
X-Gm-Message-State: AFq9FYIo8uAl/UhID4ZPuJ9aZJPOpnnwOarcUMcSmPywYn0KZf+ErhNv
	0W+Pk3zz2/PW+/0y9/Y7lEafDLaipSHn0ORIOICuMmKNU6f/11htu2y1+jIhTRRp
X-Gm-Gg: AYBFou0Xeis8EInLdf3NVaAf0owIV+5R6a91V9dXxQ4A4VEwfieT19BWQUlOgWeM509
	YQI2QWQeqjV6tcE5wBG8OlhQ0kBSm9mWrbpQAI4Tuc+GAfBm3LCVegagGa127XSVaVMsZ1sdOUW
	o2ciaVb088PWN96LZqVmio4jLMzs6H8+MYuDsUCpaejlhw7nhVt/yABqCeEv6aqSYQOn3qKEO6r
	6sTG2+pV7K7g2bQC13L132ii9oFYoe4KwIinXMhC3o36lhrgQykrOW46sa5XROFzvROeEzgcs/K
	AVDsmjr5wYZYKtYRV0Z6eoA7tIkXTJUTsYmni8bzH+3zymk7uqgQhoZCrv13SxIe/9N/bLSWxJL
	i0XzfzKRicPh313FcU3fOa9tvYmwMAl+9WO1uJTwoMOuwPB1lFGnnLFmq9KiIZf3a6u+CvnHTvW
	s1UsP4+uVm9FTmQfy4ae5ydgHtqXqvJIWHzhYeFJ37DuOTOAedYhdo2LY3BbJSouktjq5GTrHID
	15DyYpTZsc/0A==
X-Received: by 2002:a17:90b:3a0f:b0:3a4:7bd0:2821 with SMTP id 98e67ed59e1d1-3a6ce64fa95mr4531362a91.6.1791202499558;
        Mon, 05 Oct 2026 05:14:59 -0700 (PDT)
Received: from [192.168.25.219] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78e4262cfsm11014503a91.6.2026.10.05.05.14.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 05:14:59 -0700 (PDT)
Message-ID: <168ac5aa-a05b-43df-9cf4-78c4295e4faa@gmail.com>
Date: Mon, 5 Oct 2026 17:44:56 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 3/4] setup: introduce new helper
 'is_git_directory_verbose'
To: Patrick Steinhardt <ps@pks.im>
Cc: Git mailing list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <20260924120502.2642141-1-kaartic.sivaraam@gmail.com>
 <20260929102513.712181-1-kaartic.sivaraam@gmail.com>
 <20260929102513.712181-4-kaartic.sivaraam@gmail.com>
 <ar0yutZ9ksSvaVmM@pks.im>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <ar0yutZ9ksSvaVmM@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/26 21:33, Patrick Steinhardt wrote:
> On Tue, Sep 29, 2026 at 03:55:09PM +0530, Kaartic Sivaraam wrote:
>> diff --git a/setup.c b/setup.c
>> index e9a9ecda19..a0fb68f7f6 100644
>> --- a/setup.c
>> +++ b/setup.c
>> @@ -347,7 +347,7 @@ int get_common_dir_noenv(struct strbuf *sb, const char *gitdir)
>>   	return ret;
>>   }
>>   
>> -static int validate_headref(const char *path)
>> +static int validate_headref(const char *path, struct strbuf *err)
>>   {
>>   	struct stat st;
>>   	char buffer[256];
> 
> If only we had structured errors.
>

Indeed.
>> @@ -356,14 +356,23 @@ static int validate_headref(const char *path)
>>   	int fd;
>>   	ssize_t len;
>>   
>> -	if (lstat(path, &st) < 0)
>> +	if (lstat(path, &st) < 0) {
>> +		if (err)
>> +			strbuf_addf(err, _("could not stat HEAD at '%s'"), path);
> 
> Shouldn't this also include `strerror(errno)`? Otherwise you're still
> not that much wiser what the root cause of this is.
> 

That would of course be an improvement as it helps provide more context. 
Will check on it.
  >>   		return -1;
>> +	}
>>   
>>   	/* Make sure it is a "refs/.." symlink */
>>   	if (S_ISLNK(st.st_mode)) {
>>   		len = readlink(path, buffer, sizeof(buffer)-1);
>>   		if (len >= 5 && !memcmp("refs/", buffer, 5))
>>   			return 0;
>> +		if (len == -1 && err)
>> +			strbuf_addf(err, _("could not read the symlink HEAD at '%s'"),
>> +				    path);
> 
> Same here, we should include `errno`. Other sites should probably be
> updated, too.
> 

Noted.

> 
> It would've been helpful to move the function up in a separate commit.
> Like this it's hard to see what exactly has changed.
> 

Indeed. I will improve it in the next iteration.

-- 
Sivaraam

