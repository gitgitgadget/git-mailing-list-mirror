Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1249C13DBBE
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 23:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731974194; cv=none; b=CTPfcqAGE3xZ59GBrFmYuIWnowob0zFNpTPAb3yNtadnGInzsggLoiUq4bftvz2biVAsfx1ODT+v+O3hMc/JpUgE50YrPjB1BWuFO+5Q29iVZ8gwh8Wy8X/oiWh57oWbpcHiC0ldZenMdV7bb2j3oMB8zRFsGVMUPN48y6g4+vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731974194; c=relaxed/simple;
	bh=gxqT3u7RYleXTahyb1RtD64AfJouwPtIrZ39OioAnBU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=Juv+aFFPHGCARPjisv6LbJiLD3lh/BEhM0MsGPXinvNg9J+ADSigp6kFrxHTz5UkOAKwzqZtAxCRkRBttg4dmwNhW0+H0DwOYCjFKcbrmEEo/zyGRmjQvZwLkwNAVIL1Ygux4/sj5hZcL3/67xwxJjC+7u3JMkAkX8UQ7mGogNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0SlnOSr; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0SlnOSr"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7240d93fffdso2992976b3a.2
        for <git@vger.kernel.org>; Mon, 18 Nov 2024 15:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731974192; x=1732578992; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tz4RHzHTNHhLJZXDG4RrvnTLD58i1jODHqU8uv4pnLw=;
        b=V0SlnOSrJzmutBeBl+U7BtV0VhAArH/yTAYkpXnGcq6FFSfjZ6qQ3i7l704r0JCxva
         APjps9sCMbz3oKFkU2KdoMcqzNu5A0ge+AtGqTDs1hTYcq6qKRVe8Q9+GYmwXzr6RKyj
         4zWhEuKXf36Z2mcW36/htdWsY8ervrJPYkBnsqvs7nAX3r4Rvje6e8zyjnR8d1dIajky
         zJ2RoJda/kBD8peEUIij6bOlz3O2iHVTgSMGOtetkb1dnbXhnZ/19cbV4VngWAZxso3F
         PDHpmu+XJ2pkEi21c+fD22CXJZFOlGpYR8YW0CtBYm+xFCIRQ/jxa/2Ws25DQk8zfUml
         HXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731974192; x=1732578992;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Tz4RHzHTNHhLJZXDG4RrvnTLD58i1jODHqU8uv4pnLw=;
        b=oPULDels6T7+4EMrhoA+2aiSnx4HslGA+6wIb93TA+viLDRPONoCXOdKdW0jqVbabo
         oeFbOkaGNw1RDgWcjXpwRHoSrnetG/pTfQs3Y4kmHtiHtmyyCEd8q/OnKvCzvYgcPx3G
         rjQt0vPth/FnaDeufI7y09PEd9qf0fSkmk9+3TCATdXb6zcfi0EaxLVUkhpNi8jASp4h
         jWS2V0D26vccFFp2HvROTN8fp1HXCkx3K97R2hWFhRZfmzecr3kHkBKA8xfLw0E6eVoE
         UXzvcntwydWqXDfmz2Z6oMxbo0dYUjm93BxJqAMIkRQWsv4KJrn+7URty9AUyX65CUjW
         eZQQ==
X-Gm-Message-State: AOJu0YyfgunvzwHbQFobCkM5E5xltHSARyLGhGVFVJPLuVJz+Kc3kY2h
	/YYx6Ogl3nQbw737683vicuiOfRo6J1o/VjFULR2Q7AYF4KZg36/6q1H3g==
X-Google-Smtp-Source: AGHT+IFpM/VZKbj+Xx4G+n0IDf88vL3cy+Nj0U62+N2iRfCcaz6gG+oJyrTsxoliQUvceCLu3pOKpQ==
X-Received: by 2002:a05:6a00:1391:b0:71e:6a57:7290 with SMTP id d2e1a72fcca58-724769ff46amr18574539b3a.0.1731974191994;
        Mon, 18 Nov 2024 15:56:31 -0800 (PST)
Received: from ?IPV6:2601:647:5580:5760:bc4:dba3:8637:2ce1? ([2601:647:5580:5760:bc4:dba3:8637:2ce1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72477202671sm6776086b3a.190.2024.11.18.15.56.31
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 15:56:31 -0800 (PST)
Message-ID: <24458598-ebbe-41fc-8517-457fa65ed481@gmail.com>
Date: Mon, 18 Nov 2024 15:56:30 -0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: Illia Bobyr <illia.bobyr@gmail.com>
Subject: Long names for `git log -S` and `git log -G`
To: git@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I would like to add long names for the `-S` and `-G` options for `git log`.
It seems that most options have long versions, though there are some 
exceptions.

I was wondering if there could be any objections.
And also, what would be a good name for each.

Both are provided by the diff-pickaxe functionality.
`-S` is already affected by `--pickaxe-regex` and both `-G` and `-S` are 
affected by `--pickaxe-all`.

Also,`diffcore` docs says:

 > "-G<regular-expression>" (mnemonic: grep)

I was thinking of `--pickaxe` for `-S` and `--grep` for `-G`.
And it would probably make sense to discuss this before I try submitting 
a patch.

`--pickaxe-grep` for `-G` seems like a reasonable alternative name for `-G`.
Not sure what would be a reasonably short alternative for `-S`.
`--pickaxe-occurance-change` seems too long, and might not be as clear.
`--pickaxe-occurance-count-change` is just way too long.

Thank you,
Illia Bobyr

