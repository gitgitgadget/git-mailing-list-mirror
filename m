Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CB3262A6
	for <git@vger.kernel.org>; Sun, 29 Mar 2026 15:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774799964; cv=none; b=jc7ebVhrjw5ybRa/CZFDKz3YAly8XLMoRM/9xp2n9aX7xqYeRR6nL9CaY+NRujtyDCv4pDYM/rU/D5hWwOqW9e1Y64oFP10sKwhRA4t8l62iXYXQJ30jdwkzk0iRy+4iGISJRnegju8+ct8lP5i0x/vDIcQfciCuCUk6R4enV7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774799964; c=relaxed/simple;
	bh=jrrR3hMG+VMpKroSRxqyddqb53EmzdmuUQIpN3NsUY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ya1MSGC6VExeZgrBYrIjm6MIpRmrrsY9Wh/2Ar0f1yH1HSfmsl0qrJ7nXOI768qUTmuGVXJJjgqGmN+7cM1Zabt/P6naIjacssSf/FCzz4qy+fqsQmkERL3D0qfH2p90FAE66T6auIeH2dwOK/xP0f4PrftDlnn1BMen5Qdm62E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8e/pknb; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8e/pknb"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-824b03d9787so648684b3a.2
        for <git@vger.kernel.org>; Sun, 29 Mar 2026 08:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774799963; x=1775404763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BjyuoX9d1a9gpNGQ1DVKIqGKNeMvXfokkPsKKO5TBMQ=;
        b=f8e/pknbiQWsf6A8KPSZWBKWFTYN0vfvp1OgjFDNk2VY+tR/kAeVwT/CEezBWupWaJ
         qg2ebOqdTxi+3MrPZEoQIn2Q1kyzjSsMP95wBVpL0iEBfgUq0441c7zqCazFHiU4qTcR
         /Y22u5/uHnPJadlcqZPcC1Px7wots9PVa2OSNSnG54r9odrfUD0TQCj+Dk61l/7H40zM
         rPQwoR7BUr3xT/NJONaAiygDmVN6CfZDVBFgEXO+tzkgZu2RCEWWnVpPPIdYoGdmXu0I
         sFrKrL3iNlA/+O3q1hidYA8yCNpSveZ2oAWu8dPw+ToGtb4hC1ulmhjZbTSsgpVkfk+b
         zLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774799963; x=1775404763;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BjyuoX9d1a9gpNGQ1DVKIqGKNeMvXfokkPsKKO5TBMQ=;
        b=cWCEyBkaLXdMHN4gYT5kD4G0JUSssLfkVzeoJQsZer4QWpe/ft+iymbTg5JwALBuB3
         fUxHl2PlB37bCMfdrZtc7FjCj+xh2GSZIkRFtGhxRbxktauslHy4uFn3OjRUgAJ+rYbd
         T4X4+0an7avkG294vKTLOv7bwsVwtc83KPa15vxG8Qy9OjWzpHVGzA/4sZWjV6JSx+Pw
         P24rjyLklLLe0citJ5MTghJ77nw6oFq8xbqOgbEEp137I7M72ALF3HAYXHpgRdr+jfFV
         oJoOM2L2memxXTkMV83jNXdQHbaPkQUYNyRcuxstI+B2hFzb5pNBrj1UySRNtyh/9dni
         LJfg==
X-Forwarded-Encrypted: i=1; AJvYcCXdykKB2RK33ey1nKeS9aHz5IguxKvG8J+xhz0CiizfUeUPUfhfNQ7SPV/hIF3QvoA5mQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEHhJYWEhnTX+L8sVRzq05SgOsEXUqNrA6ZBppaMJHUnZTHUVv
	BxBcidbeOCbPNHrSJLA67uVNcQFDX0pmi/5WZUeShpckN4+s8oU7MxtCI5FBDtUv
X-Gm-Gg: ATEYQzxzUfJGeJ5F/WZovyOYEFnQySYexCq67jTnsb1l5fdBvcvhHUQOd3u3hlJ8lzk
	yoqRWCDvKb/5oVTc3T/2SjLuUi0dYRUBSoaBF55tlpAtQ0+q3uEly9jvrFqAe55jq64JNyrCUsL
	i4H6fUSZBQmJ+8UkdMvm9BFmZ79SIMGH5BpaDG70ALUj53DlEo12WgT5YSD6TUSjqjWIoYYr23D
	pMCNedoAIZ0v5SF3RUQfT9AOnv1EjYP2llC61p7/ftUTXplJuItsqOI3U5tNzKpgPPosV8rtWFu
	Z5R74LHJFD0i2fXfSJ6wziI9KV+N1wgI37N0TKfu5nBNzcbFEovnNwIWjIWTiNmizn63PtzyTru
	545aAe8TRiZd31v3RXALVtaHeYDbhBub9+yLIo4GylVI+q4O+I8D1GXp4QE54TSNP/9tSq4OLN4
	niDUzQ2GjtREnngVSF6j/5K0X9xMIjE4NB+9LK+I8ezw48/oEb/yySBd7zg4uUx/cnbekv5BHFA
	twCxnl+soY=
X-Received: by 2002:a05:6a00:600e:b0:827:2b42:10ea with SMTP id d2e1a72fcca58-82c95e895d5mr5561590b3a.1.1774799962944;
        Sun, 29 Mar 2026 08:59:22 -0700 (PDT)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca85ef1bfsm4565257b3a.44.2026.03.29.08.59.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2026 08:59:22 -0700 (PDT)
Message-ID: <3575e53a-a675-4e55-bc17-cce9cff1423f@gmail.com>
Date: Sun, 29 Mar 2026 23:59:19 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC PATCH 07/16] t4153: avoid suppressing git's exit code
To: Trieu Huynh <vikingtc4@gmail.com>, git@vger.kernel.org
References: <20260328200255.247759-1-vikingtc4@gmail.com>
 <20260328200255.247759-8-vikingtc4@gmail.com>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <20260328200255.247759-8-vikingtc4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/29/26 04:02, Trieu Huynh wrote:
> Update t4153-am-resume-override-opts.sh to redirect git-cmds
> output to a temporary file instead of piping it directly to
> not hide the exit code of git commands behind pipes, as a crash
> in git might go unnoticed.
> 
> Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
> ---
>   t/t4153-am-resume-override-opts.sh | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/t/t4153-am-resume-override-opts.sh b/t/t4153-am-resume-override-opts.sh
> index 9bec989a0e..30137aec20 100755
> --- a/t/t4153-am-resume-override-opts.sh
> +++ b/t/t4153-am-resume-override-opts.sh
> @@ -81,7 +81,8 @@ test_expect_success '--signoff overrides --no-signoff' '
>   
>   	# Applied side1 will be signed off
>   	echo "Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" >expected &&
> -	git cat-file commit HEAD^ | grep "Signed-off-by:" >actual &&
> +	git cat-file commit HEAD^ >commit_raw &&
> +	test_grep "Signed-off-by:" commit_raw >actual &&

The behavior of 'test_grep' is the opposite of what you might expect. It 
does nothing when the input matches, and only reports an error when it 
doesn't match. Therefore, 'actual' is empty here...

>   	test_cmp expected actual &&
>   
>   	# Applied side2 will not be signed off

...and this test is bound to fail.

Regards, Yuchen
