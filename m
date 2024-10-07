Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5561D4353
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313149; cv=none; b=Ewty3cL5WPikWuZNlhU2Ea44RpqIPX4VmCsKvIIRKJO/lDW0OhAevTUp77Mn+g6i1TyFrpo4rFD8xVREoIbyvZHzoamh8Qh8v8I/5IlVZwinCAOpRDEpdusZ0+G3PfokidcWke6GWtmgEQSzpN2n5PJbJB0w9/Ccyv7FuxaU7v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313149; c=relaxed/simple;
	bh=QXfHdr+PezLdwCoFQFxsX4vvIZN+tiik3vDue6D7NNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dLqMssyU7/ruvhHAUTFe6OiCArFwWPD94+/kZdZaBVJum9+JU1d81oBGFVYYHXWCB/a4d+Tw9al4Z/hLrRth1w4oqt7pZpdtxJ2A1QDp4qfnDdmKkNBsTvpqHe/x4ylYy61IFD9MExyU32Zlo3OpUHw6Fvhwy/JlUu9P9YmoiJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Buwx9OOJ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Buwx9OOJ"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8ce5db8668so718461666b.1
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 07:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728313146; x=1728917946; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DDwZHcM3sBQ29s/vcqAAQIfo3Wgr/zcCeKSl/f4l3pU=;
        b=Buwx9OOJztZHEqTAB4qCUnJMG7jokQnlRcuJ2UOdUOb27H54WeGLQ20wUqJyP1Mrko
         nduwMieshBdfTNJdFNQ294JI8M50H0/A7AR7vkvikxy3yWIXkeLgSyY4iO+aTCUrzfL7
         i1286zBwRiILlCJP+tMgWL90MaNfATikwZZUyB40XITxe1A3Afw4mQXUcFFJY3zCxHPl
         p7z7ifNhP22ifnjeJFP8dlTX1KTDJTbxEbNT3gCIyo+ReyAUwOnXmiIr/WOyILZkfuCT
         u9T+PQwwLbfPMq1msygM2J3PWaRMBwmT4CGCkkyBHry+gmDKYP7INUSWpg2ZKDdG4YkG
         tkeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728313146; x=1728917946;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DDwZHcM3sBQ29s/vcqAAQIfo3Wgr/zcCeKSl/f4l3pU=;
        b=HEb6WCf/y2CEcH1Whz8GNFmCMGYCl/6d8ch665JH0Fp299hOHF+UD2/vyfSnNT53NT
         BpIaJqAyZ1rH2D7CzXH9LSHOBshjqGBc8PsbtR+5VKBZq2ErGc9UXpK9h+kOJRucoNwr
         NPXf40dZ9WH1W0AC7Wq+OPqj2Vvo3lexO1x8QhcBrNCE8oiXtkriNlFDP+BxGw8akZmh
         b6rnvr/TJJZxwN4/dP8PGwsJYluXaPV515j3iwdOw4NKsEl/CPZ4Uf9Zbeq4aDBXeScc
         6bGa3zCKr592PKAmST8h4dj454vRbg7k87jg262EamDJkQWmUDWUwtHm9hTahiJdHBvf
         O7hA==
X-Forwarded-Encrypted: i=1; AJvYcCVuvl/Z1k5EcE97TlQQZy5XCTeh7AbpzbLM00ggjnXssyjUmXuVRzw/mNh1daPlQz13Aoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUOeSBl1ENV1S542amILIHkDYPm9ERxW2ZJpVqneAcalH96v0W
	OJcymJYSgBZoyAIv7S0UHm+2Tee2KMGKWunl3gGXp8Rv1yLbp4yI
X-Google-Smtp-Source: AGHT+IEblkijy00Aka9ogrXjzOR7ao3DzQhAMoVJhih4IXYLihTLWv4/qKy6UFDzacsQPgvjZQ4JfQ==
X-Received: by 2002:a17:907:1797:b0:a99:43b2:417e with SMTP id a640c23a62f3a-a9943b242fcmr715566366b.62.1728313145787;
        Mon, 07 Oct 2024 07:59:05 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:61a:f001:1402:4f50:9447:3e15? ([2a0a:ef40:61a:f001:1402:4f50:9447:3e15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99347bfdddsm367232966b.70.2024.10.07.07.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 07:59:05 -0700 (PDT)
Message-ID: <3ce39bec-24e4-4850-b947-e6476fac5132@gmail.com>
Date: Mon, 7 Oct 2024 15:59:04 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/3] doc: merge-tree: improve the script example
To: Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, newren@gmail.com
References: <cover.1728298931.git.code@khaugsbakk.name>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <cover.1728298931.git.code@khaugsbakk.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Kristoffer

Thanks for working on this. Patches 1 and 3 look like clear improvements 
to me, I've left a comment on patch 2 as the improvement is less clear 
to me but I wouldn't object to it being merged.

Best Wishes

Phillip

On 07/10/2024 12:10, Kristoffer Haugsbakk wrote:
> From: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
> 
> 
> Kristoffer Haugsbakk (3):
>    doc: merge-tree: provide a commit message
>    doc: merge-tree: use lower-case variables
>    doc: merge-tree: use || directly
> 
>   Documentation/git-merge-tree.txt | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> --
> 2.46.1.641.g54e7913fcb6
> 

