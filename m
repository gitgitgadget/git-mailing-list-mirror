Received: from mail-ej2-f40.google.com (mail-ej2-f40.google.com [74.125.228.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB49D4BD0F2
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 08:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790844346; cv=none; b=vDde6bp9GotCV2PqJqvNmf05fuuinD2R3QlhIJMCxUzXKtI8/CUduN+695YtQreT/pt9D/kPxKKZtYt5d6disO3cDtysoAMZa+jxanm3ZbRJImqCe6vwfD8oapaezQ03MjuHYq+Jt3yVwt3RYdMTUQAkOKhonfWC+PWhjYVF4KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790844346; c=relaxed/simple;
	bh=5HE0p26TND/CHzFNVsd8z8AR9i7gKtwKLwm+9r8vnQk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dWgr93pYJee8qdB72nBPvCX+1UTLqyxBovMAqK2Qt6kfvjKXR6TDUdvYO5YebX0pasYEk90hPvnX06sQ1ZCETKp65WRtZHRLOdTORpeiAF2A71euh55K/t+Hy5L0s6n35q/DZIUl+Kklw0bdX9vlOnIrkLvkvTo+jHJv+Wfqvkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OAvt0ZQP; arc=none smtp.client-ip=74.125.228.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAvt0ZQP"
Received: by mail-ej2-f40.google.com with SMTP id a640c23a62f3a-c2e402001e8so35743966b.2
        for <git@vger.kernel.org>; Thu, 01 Oct 2026 01:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790844342; x=1791449142; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=S+Opfzo4lLo2WE2k+F7L2lqjHK36FMVk5FF35AYGtAg=;
        b=OAvt0ZQP+GvbAebHnQ9wWKvfju5Atd+3j3ksWjEdwZf8Z5l86DPkG9JGAXJU0+dAK4
         xuG02WtawoT2CscGqfMCOimhMmJ3Rcv/EB7AHOCZ8LUHL1xXqd1T5cr8QA+1EKfh6jhZ
         shW7DzrupibkjpzO+rrx2crNG2Q+89vtUV6/JnCtXLXqTbbBNU6aWAw05NlR3zuzKfZD
         BVJ9x7LIP+5vZ5IABS6A9PiJujcvEzfp2U0yAjse/8tDhyD9HBhsqaR0l7ElAFmgO6H0
         cTY44SiFzht+WeAT7CIs9hGzjxBdOYTK+8qDNm5uWI4PV/ocStnRUHoayQ55wd0RE42A
         dfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790844342; x=1791449142;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S+Opfzo4lLo2WE2k+F7L2lqjHK36FMVk5FF35AYGtAg=;
        b=IU6QEL9o+tBZKBvwkh2c/vI5ydDiAhc/nwwZPeEiAmD33sjYmgIJ85aGNHAJYvm1K4
         kxtXhxJBGcAjCXH3m4bU2YXV5o7yt+1YCpUM93k73ViTVuhPMt5BBM6NnGS2ajAkj+7/
         jPJ4rYhB+6YbjjqhkH+py/CYOdrYp6B/6AMsKa+31AlI5ThiqMNtrNVXveiBPoKoUBlV
         xXipN+lOO/hHszCZpPjoxQq13m/7qituv0/DZZFjj+9LZRcIxq7t1aHE5vAu3gTuGMFT
         PLOhSlezLUOCmTS4qRvf9XwWS9aPTpgKp2mPa5UYy2q8W3oqeEu5WIA6k3SZ3xHk6uDp
         Oeyg==
X-Forwarded-Encrypted: i=1; AKwUvBxhV7h2IMDXpV6qwTKraRV3piBWP80lzRUn/m9vfGBZaA/eJYOtAj88k2AjfSIkZKgetfI=@vger.kernel.org
X-Gm-Message-State: AFuF++mzYMaWNRKfKXpIg6T2awj9P+Oxs2l5GEmpO9/XoY/pyG+COtxo
	dqF7XEkBolg1D/8GkqX4NC1DnazcofsuTfyufMZ6lr4Tih1kWAsPg7dc
X-Gm-Gg: AYBFou2no0ZCUpuIuUKZprnuS4+w+sOvAwEBHQU5Ho/QMyc0gdW9ndonFcps5frsFlh
	0MEeaYyx0vfPO7/75fuBo53rTfyYondYxBscMQ8uprobQ6R10sUrJHDHYwyByxJr4ZU6jJpFaEi
	eoNRdw8VLYl5i1NLAeoAX6lyXcPDksYLwri4hfx2o0G0ZtRPSO65FPxhsOemDfER3wOkjJ1SsqC
	AqwwJ4lUHr9PQksshMiuokP9QJtf6b7OMdmWdDupkrxmy/pO8Bk6jaPWBK7XtjzNXvbwlhcmdnA
	osUzKuI6X9bRyuHUD5xSgEtmmyEdxms9pzzN6GpfKt8bWXmhl/u9tSZCpuUbeYrPvknPjfs2L53
	kW+Q4WtkZ6kgSTvHdLnCtBiiy7gjHQkZaiakPrMYM99WIAs7gfiTjgJaNevLUbj8xXgkmDL8WgW
	ZnBzrQFY1GYE+ZXRqEcWmA5DWg8n0MQKLCgbSMPrPb/YClxH4+XHJAvYJBZhsosnPW/CA+5wIzv
	ro6NnopaBc4Huq6Ns7/nvwtw8hZecTbqaA0MLUQOyd/kq6/4Tewlw==
X-Received: by 2002:a17:907:9703:b0:c2a:f360:1c67 with SMTP id a640c23a62f3a-c2e23dd96b0mr296380566b.35.1790844341776;
        Thu, 01 Oct 2026 01:45:41 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e31ce9e4fsm110743266b.31.2026.10.01.01.45.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 01:45:41 -0700 (PDT)
Message-ID: <f5397a5c-3482-4207-9501-fec431fa34a0@gmail.com>
Date: Thu, 1 Oct 2026 09:45:34 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/2] checkout -m: recreate conflict labels
To: Johannes Sixt <j6t@kdbg.org>, Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org
References: <cover.1790761727.git.phillip.wood@dunelm.org.uk>
 <223c99ea-64d9-46da-9631-ed8035f1a062@kdbg.org>
Content-Language: en-US
In-Reply-To: <223c99ea-64d9-46da-9631-ed8035f1a062@kdbg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/09/2026 21:24, Johannes Sixt wrote:
> Am 30.09.26 um 11:48 schrieb Phillip Wood:
>> When "git checkout -m <path>" recreates a merge conflict, it uses
>> the labels "base", "ours", "theirs", rather than the labels used by
>> the original merge. This short series teaches the ort machinery to
>> write the labels to ".git/MERGE_LABELS" when it switches to a merge
>> result containing conflicts, so that "git checkout -m" can then read
>> that file and use the same labels.
> 
> Would an index extension not be a better place to store auxiliary
> information about merges?
I did briefly consider that, but it makes it much harder for other merge 
strategies such as git-merge-octopus (which I should probably update to 
write MERGE_LABELS) to store the labels. We already have MERGE_MODE, 
MERGE_RR and MERGE_MSG storing various bits of merge-related information 
so this series just follows existing practice.

Thanks

Phillip
