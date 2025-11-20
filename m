Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E13E18C008
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 14:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763650622; cv=none; b=gycUkFXXkHqmKNd5y0m65KMaIu9iLeCZjqsw+XnsgD1446pRax+dLtJF9QlJfciWCYRnsh3M2sdDiEVBeQXLmR1AKg/k93acAELq/d23HxcC05ZvMqbvQEENjHMiv/MFya4PIKoFppL8xd3zb4D5ATJg31kSpogWjbaRmWekDqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763650622; c=relaxed/simple;
	bh=S6HvUnb8sg+P9P0slHnc5kwE3gaa3gWKA625Ya4Gi8o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=XKqdE0rRWzAiLCDpQN9+bcDFwKw/m/evBn1AyTxOofF58eXLTv7OVHWAmldmtK0PWCfQQZ7gYhh/Ghsyv1uPEXMgclfhlV1tZSRqJ2Jj0/5gPqQiFox7sUAstADZnYFgol5engp313H8ZcFg2/k5EVmoUb8Mv3vRNUp/+9wVIBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EfribluC; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfribluC"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7c730af8d69so600318a34.1
        for <git@vger.kernel.org>; Thu, 20 Nov 2025 06:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763650620; x=1764255420; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V4tlXUjUB6dTRWNKj0FOmloBMdV0pbRMvxl8Vq0wtsQ=;
        b=EfribluC810zCXvITa1Il3t14PJjNafc5wG7mO9d3gDyMjII/PzLfZVNIOzpyfB0PQ
         Qt2jlkXDUXm4Jx8NqlL5j3PZzMthmB1u4Qu69S/hlDSk2KBV7s7dF6xg2mn4087P22N2
         lEpkMLGTjLuJbT5m1gAOHIGVUbe5EoAwJwV/mbBexRTD4E9ZG9F1V3S7XDrLChqLqOL1
         LDDtv/N614bXGtf4qN5PVD9ixAHR6aIa3CMc9gEl14eTgS6W3/u2nQYwQQMdvQ5hd/Q8
         gLdaXrbCGJ6Hjg0wmQMT8lM3ea8aTaJgg+PoYmk52H76pspLJt3+QpNJeRluN0NA5v7g
         wE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763650620; x=1764255420;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V4tlXUjUB6dTRWNKj0FOmloBMdV0pbRMvxl8Vq0wtsQ=;
        b=qXhfnZxtR/aAHL10YyvGwxRqalO6L2OVUkrxyAmD5GEj/q8EtQ7GNdSXOsQSNMptQm
         lvtFj24s18wLNTxckU5K+2lahvvc28f9+ffmQMSTVlKHk8AgbUsRlPh9SLVEaSs0tRx6
         dxGSeyjeKWxEWsNuFLQ4xztiMaixYcEI7a/nQQ0It74uiHWfQKz55PKgvuTLJclv4Jhz
         qyLtXqnlbGwZpLnW20UWPuGiYavBw4ChE4C5hXwYXCp+1LQPDhRASHxT1SP+yGw/5wAm
         JiWeVyID+JPn6J9idis/Kld32gMKU/ulKkZh5ycysBA91omIBTAgUjJGpbRGVzUiKo7c
         eaMA==
X-Gm-Message-State: AOJu0YzGzVn0cOtiNnjkPcmFUjgs/8TQuRlI+wZqOSdHP47rmbQFW5SZ
	sYdQW4z7BiZAXD0UXJ0P4OGswApomB21hFLDgjWzGzArixT+g/9eCg//JbCW2MO3qPaDxEuMuqj
	2M/zpWJ0nysFgxNtqnm9ivLkt+7pqQqeNcQ==
X-Gm-Gg: ASbGnctHs2/wt6rku78rhU8yd+VvG1JdHu9I0yrKefXT5MGtSEurVBb9t/PZBJTK07W
	sNOWVPXUQrTsnh2PBDIliorB6Sp3elF9DnXcVx2WFtoGZw2kv9M348YAjmd4PdlOZuvbJefepuE
	naKMaiH/ZI5CuZeccjmwAnUO8myJxYQWMnIJa8gG1bQ8hZy6di0ZIpxvGsaOWciXVM7yFiwXqho
	k/mMflJmWVq8kPeftNLw0iPt4LCRhfUr6OYTpcqYDxjGcd1Ch92rcIv3h7YnpbGqiplgZ00z/5G
	dTYVSL++5vuhkdYsP8h73Uw=
X-Google-Smtp-Source: AGHT+IEFYWxL3iZAIxwI+14MajF+vRGlBRq0O33temQEs4iIx2HxwN1XWN/XkQGmqG6az5sQQWXrIh/uKk4qxBa7PWg=
X-Received: by 2002:a05:6830:3808:b0:7c6:e92f:41e1 with SMTP id
 46e09a7af769-7c78d263c05mr2452222a34.14.1763650620032; Thu, 20 Nov 2025
 06:57:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Martin Guy <martinwguy@gmail.com>
Date: Thu, 20 Nov 2025 15:56:47 +0100
X-Gm-Features: AWmQ_bm18AnssDJA8zXEjluAQfGC2izlJ3fXc1rqfyRu97toB1jb52gNLS-9AlE
Message-ID: <CAL4-wQrgD3nnW2BfNf6e9d7tDANE60dYBRRP_0FW3Z-LvQrZmg@mail.gmail.com>
Subject: Feature request: git cp
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I am splitting a large source file into three smaller ones (mp3.c into
mad.c, lame.c and twolame.c)
and would like the history to track the relevant lines in each file,
like "git mv" does,
but I only seem able to do this with one file by "git mv"ing it and
copying that to the other
as a new file.

So what I'd like is "git cp" that is like "git mv" but where blame for
both the resulting files
goes back the original one, if that's possible and unless there's a
way to achieve the same
effect that I haven't figured out.

A fairly rare thing to wish to do, but may be useful in this case.

    M
