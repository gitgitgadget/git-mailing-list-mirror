Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A3F3BBEA
	for <git@vger.kernel.org>; Wed, 15 May 2024 19:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715802118; cv=none; b=MzKSy6M8/VMtq+tI3g1UcpFw5KhC47ZIMbdx5PM9tpG8oe8uV8MX6pAszvZA40LoA4YXzN6ae7meZU/NDZc24ZmzIq2881Qb/Mx2LEjB/+Y0r7sV/q4dMBZHtNT9CeG+bjhA1hoq5xIiESYWYhXi45d0ZSapd7tU3UJpAIEuqQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715802118; c=relaxed/simple;
	bh=2pCqnS/UsYAIvTCcycZF/UlLSnL103hLVPy1JwI/b2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IFwzZlDTvzYgCFYoWWx5bWVleMSxd3hLx4gla/dqQFCC1JfQYqHU5XRGsIAFLJFNdTcrzNYV4tok//JE0GX10bdeMZvQS8AzFnRFoDOXe4qb93BHHcm5ZnOVPHHoPTn2PLymf98ogmOWrcXIWgTE3cdd7FIkeZUSFwUy/bMUEkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net; spf=pass smtp.mailfrom=gree.net; dkim=pass (2048-bit key) header.d=gree-net.20230601.gappssmtp.com header.i=@gree-net.20230601.gappssmtp.com header.b=1l3wMaen; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gree.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gree-net.20230601.gappssmtp.com header.i=@gree-net.20230601.gappssmtp.com header.b="1l3wMaen"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-61e0c2b5cd2so56652137b3.1
        for <git@vger.kernel.org>; Wed, 15 May 2024 12:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gree-net.20230601.gappssmtp.com; s=20230601; t=1715802115; x=1716406915; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2pCqnS/UsYAIvTCcycZF/UlLSnL103hLVPy1JwI/b2c=;
        b=1l3wMaene+ARQ/YXSW/K0LZpotFwwwXrrENi8CGQQXxHtf1xFdF0tCTzxlTqruqI6W
         q58LFXIOZ+9yobZaZf9lkEJ/UGbuQjzlx8HtzWwDdACEPrCGDHc1Wt1ugtiC7Zvw6OQz
         iK9GQFnUJm1xj5+BKvy5iWeU4AWp2kkQaQS+GLeaUAZ+5wuSOpo5jdq+/K8awiqbSue8
         yGGvDD2fXehaJUZVz17ZKKbx80K0uPIrFwhaOEE1SMeSvAh2u3XficlBaDMqpqMXg9QV
         UnbPrZNrVKHZlQAIUX2NCLFHnUtsoLGUX2dUeuA7c5xOdlvXzgEIkae1SGD17fhHYcgq
         YFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715802115; x=1716406915;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2pCqnS/UsYAIvTCcycZF/UlLSnL103hLVPy1JwI/b2c=;
        b=VROZDMD52wGMc5GYW0clBs9G4oSttSwMhy31Gt2ZefNcwKTXWDtvL6tbDMIN9iCI/R
         Zxab7kRwu9F9dyrAWonhcfd1e0U+v8eSf3//oPpvmntEZIlE39llK2wsZaJkWzxLlJXV
         0EVsCMagUjXsedWLJFGghPuGiJYxpi8wEb1ICOUoTBNGsizpaCGc/xSWZxpjReiQIBe9
         TE2g6p594dAa1ndIsy98jRITy7pa56SEE8pGKmwfz2p0pVngS9fbUNMAZiGPr9Gbevzf
         G/PkihWKbx4N0jY33wn+KR8fXs9n/8arvBYoyWUGAMKrsj9czXG7ZEszyVQxK759eSqW
         mtzw==
X-Gm-Message-State: AOJu0Yxtf7OS1N7Xiw9ozQI+VAkuCyZ3Oz8Fqnx/RQ48s3taEAcS2cj2
	PY9hwzvZhxCcjK+fotCuJF0GgtnHQ2u3WHopYu8qdCZl8Qx6ismgXgz2f383OFJRgalquk8BQxv
	RZOh2W+e03RumMHk93wkEIrkukdf/g5nBFFPAEdeAib5gk1Y/FFKFxFB5ZYqtIScyIC5ppEIoRS
	MD3Lpil0T6pYZ470IEoMVdPgnkH+w20/DZ38pZUK2KFOSC7q30drBKodQQcUUjj85ubDhOURI0R
	YzXsiDIHOkRXFb65MnioW4RR6YoWXORSCM/wbZt7RZBFVP5S2DhR/sVp02LuZxstjYvWEhe8HAk
	vZBDS2u/jKM=
X-Google-Smtp-Source: AGHT+IFTAfKWlXhQkyK65/lQEU1aeyj8DnSXGqy5/T0X9pLgE5LZQI+oXrBqfHXHPH1VFVyyNPWMlhfoDfhyjI2iKBI=
X-Received: by 2002:a25:dc92:0:b0:de5:4b29:22e6 with SMTP id
 3f1490d57ef6-dee4e47850emr12882939276.1.1715802114627; Wed, 15 May 2024
 12:41:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1729.v2.git.1715428542.gitgitgadget@gmail.com> <pull.1729.v3.git.1715800868.gitgitgadget@gmail.com>
In-Reply-To: <pull.1729.v3.git.1715800868.gitgitgadget@gmail.com>
From: Koji Nakamaru <koji.nakamaru@gree.net>
Date: Thu, 16 May 2024 04:41:43 +0900
Message-ID: <CAOTNsDzpCs8fiLn4u8z-MH3sRp=G97ZSy--An=i8DpxkK6ec0Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] osxkeychain: lock for exclusive execution
To: Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Bo Anderson <mail@boanderson.me>, Jeff King <peff@peff.net>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

I thought about the issue further. The approach with the "state[]"
feature reduces problematic "store" operations a lot in most cases, it
is however not perfect to avoid the original issue about parallel
execution.

For example (though quite artificial), let's suppose if two git commands
start simultaneously where the credential is input automatically by
"expect" command. Two "osxkeychain store" commands will then run
simultaneously.

I hope new descriptions are convincing.

Koji Nakamaru
