Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18222575B
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 10:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709548055; cv=none; b=jw8oq+YeJaaF0zWh07r1hVDTWodp5mfVWdn5rmzYg2gFbp+at1AyepiWAoTypBmql32EA5/OgRHpxSMtiZiOalG7kyjw6w41DYhbL2gA2oGP2T+JVL0h6dr4FFWgxUHea+pbFWq/hspvSZ2zlNjl6Cz9J4WAW5/sdcwK4zC+ObE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709548055; c=relaxed/simple;
	bh=BNve5G4wMykfyImG5fm7DFgfHGuFhhUchzxPaSDelI4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rAuJVophu0srx7AxsqapkeRo5uBmQommL1C9tb005h9G2w0HjNUlPJAeAJX+A9RRJfoChQzdIKB2QR2m/ukME0eRWM2w8N3szwhWXxXzqxmOFUgJHWlCBb+Z63fgMr/iF3gW2EnDXPlNTyw7YeTa+JheWBXeJHGuJxVGnKWRUmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbWQpGLe; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbWQpGLe"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-412e84f501dso953245e9.0
        for <git@vger.kernel.org>; Mon, 04 Mar 2024 02:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709548052; x=1710152852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nb8IO3KDNXI62jeOK0CgbpMFWSqouOGnjjrKtHr+XUk=;
        b=PbWQpGLemgp8q+Q8q9+Tzs9z7XpMi4kvu/sL1HckHqTtbuntIsvAMS/V2lKbnDi8gg
         zhrIB4F4sjGdCbNyKoe5AjMcambWBfLU0qzXwD4ttHgVWjbX7SNoYQshnzVrJIWOvL37
         kWYe1rl736BrhvdmgbT1gEkLfaZlkXPhU/N0Lh5r4mNE+a49pME7lRy2C5dd39IZEi/G
         OiyS2sSQIw3EiOiNPY9Iw9SQwfH8wLpjO9eb6IsV9h6HEOt813XCKZsTKlC7Tr/of453
         fztOFyxExx/w/4Rh05wrK7NvW4Sqdk8pwIojzqTwudI/61u/dv3cxODmu6Vtk/KFg5G0
         44vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709548052; x=1710152852;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nb8IO3KDNXI62jeOK0CgbpMFWSqouOGnjjrKtHr+XUk=;
        b=PYxuDwtuDsl1VnP7XtwA7bRl5Udf5pu9JDe88uzyfpZWgbFkY1GpgAh8qnjBbuDmHt
         Y8KAbYcr/CKWrcPpYdT4TdcNpG+V/Iq8tuXIPIfE2rgojlFQ0qOU9DTsI0TsX3MRdK27
         ipzyMbSFmY4sccKChNaNzGzhsIh4KFVQY3xZzD+Fo4AjqAVt00zoBplO7SZIFmtfJIgN
         0xCZS43m/V6uellO4F0QikHT2Xv1+pgx3nkxdRqBoewNePMS9PQkTq3IHQGbGmTMV5Tn
         9wYFOH0vsP8jEoDBkUTeDjD5hUf1ulpdmiliGvTNOpRPCGGIzlxs7FkATqrws37Rbu4K
         2GfA==
X-Forwarded-Encrypted: i=1; AJvYcCVUynMVYr1nq3LxXdCBVVq6siArzDEBZsnrQewABxeKyR4joWhHVQGUnHByeOgmdEYaefurVZghs7tvE6iUCZg91BLt
X-Gm-Message-State: AOJu0YzOMFCWMaTPG9N6a5MNnEK+NFdrSNt5Q49ybXjwoDA0UsnLNpMV
	8ekPXWQfJYEPDpdo+NajzYl5TEnE+HCXt9B17eNsuPNsAHebS7Ml/8C9MNyV
X-Google-Smtp-Source: AGHT+IHGW8SH2Ggq8qjF4plk7HNZi6ZSmYOTyeO3ty1wGLjofFT9+HhoP0zorC2jZmzilnLlDwUEiA==
X-Received: by 2002:a05:600c:4fc3:b0:412:dc02:9824 with SMTP id o3-20020a05600c4fc300b00412dc029824mr3043770wmq.9.1709548051871;
        Mon, 04 Mar 2024 02:27:31 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6ca:8b01:80a6:cae7:d811:7244? ([2a0a:ef40:6ca:8b01:80a6:cae7:d811:7244])
        by smtp.gmail.com with ESMTPSA id n13-20020a5d4c4d000000b0033cfa00e497sm11770350wrt.64.2024.03.04.02.27.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 02:27:31 -0800 (PST)
Message-ID: <6a31efcc-c6c2-4729-80b9-eecff4ec9e31@gmail.com>
Date: Mon, 4 Mar 2024 10:27:30 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] sequencer: allow disabling conflict advice
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
To: Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Philippe Blain <levraiphilippeblain@gmail.com>
References: <pull.1682.git.1709396291693.gitgitgadget@gmail.com>
 <3df4790a-7ee1-4c72-a3da-ba8a48d546b8@gmail.com>
In-Reply-To: <3df4790a-7ee1-4c72-a3da-ba8a48d546b8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> We already have "advice.resolveConflict" to suppress conflict advice. 

Oh looking more closely that is doing something slightly different - it 
suppresses advice about pre-existing conflicts in the index when 
starting a merge etc. So we probably do need a new config variable but I 
think it should have a generic name - not be sequencer specific so we 
can extend its scope in the future to "git merge", "git am -3", "git 
stash" etc.

Best Wishes

Phillip
