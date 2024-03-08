Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD6C25774
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 16:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709914053; cv=none; b=cU4UWvHa+x20ASiNnhYmTbqfiOFjbcQLPey6nInFE5uQHwJF4REMt3SNUcu6xuqhSpOsBycWbNX60jgXkXxlqcoinYd7JVrH+Dko3iqMQewS8p4Nn8Qz8gkMi2az3lHhz0nPGjf9CH9lGXaUmwNHZsV9uDVpF0vJ7r6luvhl2NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709914053; c=relaxed/simple;
	bh=PqXSbvwo/8Ryk1+qXtyxkvNKxfqVmzdAHOFqCeiokXU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=NmI6iz0l2vRf7oF90FuuLqWxPWqGPrQkIKIbu9qNzKcd+doBB4Ghh75xA6p3FpJXqkBfds8G+lYZmm11ctsOiGj2/AtiJQIJsON2N05rR85kg1c0YaI8ohf/mrw8UW1twy7FD3sOhDOdHKHoUK5TcnWK06Xa4gLNQPZ3qxfaOfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfOT6bA4; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfOT6bA4"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dccb1421bdeso2179473276.1
        for <git@vger.kernel.org>; Fri, 08 Mar 2024 08:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709914051; x=1710518851; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YokL6tgH7jAY3cYhviw7zo9t0da9CZFQqLoLZb972h0=;
        b=jfOT6bA4lg9vNWM7f9/9w3JskD5RrNcl/UqM7epV4CDJvco5BL6VhcieAqOLrt5SRE
         Hd1/Z8lYg2IAXHXVXseiItWjoA8ytNh/2irK65jgX6LafOQa16D7a96TDST9aQ9bym0G
         J8lh/3TKEaPQ0X3JJhTRIsRF8rTYyJqYAYXBuwoMBGvroaMfzvlAfm6GEyPe41o2HZ+K
         k1mbrv6eByNuk0AZoyUbBhyAeA+bBmk59bLXpwd/bFqeieOs9864XwuX8QhvUFusd/Ko
         Co4GNo+N4p4o2AzDpyMfIbv/M6m6h68OBtvqhvRml6LXtOB8weJDOQgAMq4iOGtipOLm
         Phzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709914051; x=1710518851;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YokL6tgH7jAY3cYhviw7zo9t0da9CZFQqLoLZb972h0=;
        b=VklOWciZlpKia5EBzBiPNo1ndIjO56qUBSzjzpChNI/vkp3WeGDj6TjlBXpLP0Uz8L
         tEJ9j40iKPSIO8vI9dkRtGG87Gy+Erdk9WT78ycwq+coNqoX1MXodjxI8kIh1svGwWQ5
         2GBT7HK13vptCtGmUMoj9Ok++VTxeV8sFDzRDzsxfsegmtBAeZW0OAss+IWIDyeqtrFa
         NFjfc5vhnd+cjPuIxOpFiVsBslPkV+5zxwcSKXIwcgQ3eziD2VHE5+Cpv2JC+CbUSt0j
         neyDBSx5EekWA5xCWe+Vc6dFtST+7EjIjtaxjwkqFLHUEcPzpPqrCIgq6q02GmpZT2eQ
         SNsg==
X-Gm-Message-State: AOJu0Yx98JPDBGwFebkUVKLm6NqADacEJqCwobuWGIWEIva9gZ5eWNle
	2dQ9E4/i8P/1z5IAMfc+SGgSFBA9jXv01J2dFaI7fL0gh2hGEfVb
X-Google-Smtp-Source: AGHT+IFN4iHkAqc9TgwLFmorhG/UdO+3pAG/rhp7OBS6n+VW90WbJn5U7IOPLqK0BZhHP089cpSnyA==
X-Received: by 2002:a25:b222:0:b0:dbd:1dfd:8b8 with SMTP id i34-20020a25b222000000b00dbd1dfd08b8mr19776458ybj.24.1709914051093;
        Fri, 08 Mar 2024 08:07:31 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6ca:8b01:80a6:cae7:d811:7244? ([2a0a:ef40:6ca:8b01:80a6:cae7:d811:7244])
        by smtp.gmail.com with ESMTPSA id t33-20020a25f621000000b00dcda90f43d7sm4148230ybd.59.2024.03.08.08.07.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 08:07:30 -0800 (PST)
Message-ID: <585668d2-2097-4e90-b5f0-abfdff633af6@gmail.com>
Date: Fri, 8 Mar 2024 16:07:28 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/4] checkout: cleanup --conflict=
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
 Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1684.git.1709907270.gitgitgadget@gmail.com>
 <xmqqplw4hgnq.fsf@gitster.g>
In-Reply-To: <xmqqplw4hgnq.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

[cc Johannes for the gitgitgadget issue]

On 08/03/2024 15:44, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> Here is a place to say why this series exists.  Saying things like
> "'checkout --conflict=bad' gives a wrong error message, as if the
> inalid conflict style were given by a configuration variable, and
> this is to fix that bug".

Sorry, I'm not sure what happen there, I definitely entered a 
cover-letter on the gitgitgadget PR:


Passing an invalid conflict style name such as "--conflict=bad" to "git 
checkout" gives the error message

error: unknown style 'bad' given for 'merge.conflictstyle'

which is unfortunate as it talks about a config setting rather than the 
option given on the command line. This series refactors the 
implementation to pass the conflict style down the call chain to the 
merge machinery rather than abusing the config setting.


Best Wishes

Phillip

>> Phillip Wood (4):
>>    xdiff-interface: refactor parsing of merge.conflictstyle
>>    merge-ll: introduce LL_MERGE_OPTIONS_INIT
>>    merge options: add a conflict style member
>>    checkout: cleanup --conflict=<style> parsing
>>
>>   builtin/checkout.c | 40 +++++++++++++++++++++-------------------
>>   merge-ll.c         |  6 ++++--
>>   merge-ll.h         |  5 +++++
>>   merge-ort.c        |  3 ++-
>>   merge-recursive.c  |  5 ++++-
>>   merge-recursive.h  |  1 +
>>   t/t7201-co.sh      |  6 ++++++
>>   xdiff-interface.c  | 29 ++++++++++++++++++-----------
>>   xdiff-interface.h  |  1 +
>>   9 files changed, 62 insertions(+), 34 deletions(-)
>>
>>
>> base-commit: b387623c12f3f4a376e4d35a610fd3e55d7ea907
>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1684%2Fphillipwood%2Frefactor-conflict-style-v1
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1684/phillipwood/refactor-conflict-style-v1
>> Pull-Request: https://github.com/gitgitgadget/git/pull/1684
