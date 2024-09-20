Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957C52D05E
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 13:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726837956; cv=none; b=C0PkxLX91L1m4jq4vdtdVSrotgi9WRd/oqhaTuwata8lmxdkXHCKs9hbplDIvXOE++G9LFT2UYOHaFMQxwCMNDEUt/8ThrBWY3cEdoFExanOpI8qbvTFkHngj11dod3StOewNJAC9ahwHplNtRn+9TkP6orAaHXhd00UsHcGM10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726837956; c=relaxed/simple;
	bh=HHlihKpu8znybER33ao8FLAs5+qzLEpnJna6vwz7wyk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jhih3lrmsMQ6gaRoxdPgcb1MZ3aAF2G1OrMRzUXeeBRuQh+61tRRXmgET5TUrj3EzQ1nzGjfODVgPbmRqksWwN7E6MvbTzINx9wSroCMJNYoFJgBWzHd6gKKO0PJTnBgc1OPbbK+ABnMsk0Fhe4VaWjeU2ssQPw7HBZwsHgIp20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXKzx9v7; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXKzx9v7"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37a33e55d01so1567297f8f.3
        for <git@vger.kernel.org>; Fri, 20 Sep 2024 06:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726837953; x=1727442753; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5aTEb/WyXBUoHPjqMuTwgY2vfZTuG0GUvhC/QxJW8N8=;
        b=NXKzx9v7rNN5mMzhW2bYblWYn0mmU83SIyeDmM/dksO5ZoI2Zt0VooEzcLYP7jhWgA
         uuDZctpOSizvW3C4axcci/jYzCHqZitebucBMOrPe4uJ/O3RMv1w7s76HBfy9wm881ry
         SwPYWBhAysz7q4f3pyiKMdDCEv3ssbBdMe3IRAqWoZiguoGL0bpDcuTUuvU00ZygMiMm
         u/VLrGQTzkWLFTnbDGOjvl3VpbEQYyFuZn5/JzycwQHxIt7M22hsBX7PLneAtfAzWBSd
         EKUY7NDNkpPrWyEEgFOPL613kkVU522phjNobXBuC0P1ETZqgQC9p3lILkufYOz/MYlc
         4smA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726837953; x=1727442753;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5aTEb/WyXBUoHPjqMuTwgY2vfZTuG0GUvhC/QxJW8N8=;
        b=R85dmTsAlbkxDxBGnqZbFpwAWHr9yZuvoP22smXH2yhXJuNQbG6ApC1u5RnDrP5kRu
         E6IZp2qbdbSdBLEA4hPmVp4qbyOSl/6Qg2egEFmulWa3DHu0w32X2OSstvL8zj8hiC/u
         TQNdjdu1GnixLuExG/DyNK5qFLdOq2iVIDHv9khFYueYkv/T1h8hsaye7w6nKW36+mRJ
         7lqv2Za6lbqfpmYcEWll4F8wgs3lWMbeWgsKjDrZ0tTFJJcCPEblyokWbmGhuzyF3b3f
         o4naN4yTUThjg3UEJhjuUKi6kymSOlYk7bTNwAhxnTpAfm62mmw38duPYAqsUMxvMH+V
         hq8g==
X-Forwarded-Encrypted: i=1; AJvYcCVok1PjM7Lpx8OKGkSOR9dgXcNbARfFgiT/qHCSTWAXVsBmvnDMflsSVg6pCePob9Cvpe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YysyxXDnt0TV2IBuHHbQE8v8IunPr5J7uyovK7nrhBevYVLSAUH
	PfN2WgJZU0fNwrv2U4RsNNI9c8xtjOSd1SQXzut3B6obuQ8usiAK
X-Google-Smtp-Source: AGHT+IGZyoCLBu78sObFC2qrnYs+S0Awm9f/IiAGrfOAzAWY9EHEjLQyfkQMmoK9CAmdItrKXaYAOg==
X-Received: by 2002:adf:f7c9:0:b0:374:c651:4abf with SMTP id ffacd0b85a97d-37a431be88cmr1806157f8f.52.1726837952554;
        Fri, 20 Sep 2024 06:12:32 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6ba:6501:244f:f1e2:145d:427a? ([2a0a:ef40:6ba:6501:244f:f1e2:145d:427a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7afd8219sm23012595e9.29.2024.09.20.06.12.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 06:12:31 -0700 (PDT)
Message-ID: <c2ce33c1-b9d2-4798-b91e-4e0a55e97052@gmail.com>
Date: Fri, 20 Sep 2024 14:12:30 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: fatal from submodule status --recursive when used with grep -q
To: Matt Liberty <mliberty@precisioninno.com>,
 Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, phillip.wood@dunelm.org.uk,
 git@vger.kernel.org
References: <CAKDm0rNaHbzoiPg=DeuCoxzooNAsxw2BJfc0wg7fC_-=o9uJ7w@mail.gmail.com>
 <7b4ce2fc-3763-4881-8459-e0c1f2cbc69d@gmail.com>
 <CAKDm0rMsXUpFSWRWkW0J0FUpEbot6wQqdzYTT5CLZ=3TGbV-OA@mail.gmail.com>
 <467f6fb4-5f83-416b-bc09-572a82f210ea@gmail.com>
 <CAKDm0rO6H4RTa5EXMrNvSy2swVegHveasY1koZXF5V7HvZzK0Q@mail.gmail.com>
 <xmqqsetv795s.fsf@gitster.g>
 <CAPig+cTDFcJiig7=Sf5vxsgzc8_ax5t7Vqy+-_x8OK_U5U6Qnw@mail.gmail.com>
 <CAKDm0rPNLtv48P4JOKNicMcrz=ZZwr9PwE207D_foj1r-pn5UQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAKDm0rPNLtv48P4JOKNicMcrz=ZZwr9PwE207D_foj1r-pn5UQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Matt

[please reply in-line to avoid breaking the flow of the conversation]

On 19/09/2024 21:10, Matt Liberty wrote:
> On Thu, Sep 19, 2024 at 12:40 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>>
>> Regarding the exit code, it's not even clear how that factors into
>> this discussion considering that, in the presented example,
>> git-submodule is upstream of a pipe, thus its exit code is lost
>> anyhow.
 >
 > The exit code matters if you do "set -euo pipefail".

When you use "grep -q" you know that if it is successful the upstream 
commands in the pipeline are likely to receive SIGPIPE. Therefore if you 
want to use "-o pipefail" to check that they do not fail unexpectedly 
you need to remap the exit code associated with SIGPIPE to zero. 
Something like [1]

	hide_sigpipe() {
		status=$?
		test $status -eq 141 && exit 0
		exit $status
	}
	(yes; hide_sigpipe) | grep -q y


I've posted a patch[2] that fixes the error message you were seeing.

Best Wishes

Phillip

[1] 
https://unix.stackexchange.com/questions/582844/how-to-suppress-sigpipe-in-bash
[2] 
https://lore.kernel.org/git/pull.1799.git.1726837642511.gitgitgadget@gmail.com
