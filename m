Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8E22E62D9
	for <git@vger.kernel.org>; Tue, 23 Dec 2025 23:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766531534; cv=none; b=QK/HnJlnbULzl0jXbT9IfshGm6urgzG5u39Y0LqhZxcnECxoqUzukl4A4EuNHCSJa8PqoOewiqHM1oSxeOVyCOOQfHZrbI+BqIzbER4FPVEWD5QlmIrzGrFPN/F7tOIchmB33wPlXuJViZDb/V5EQYDlo/G6nK1YkxHPhHmkvf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766531534; c=relaxed/simple;
	bh=Nw9y+nuauAPpGXXVNBMTs8gqouGFMQFLHb7Y0IMeezk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mfSTZE7v6GdM0xwSDCLzIxRmeOEAO7u7Bi9DPmhDN3DsIF4KsrFRPF/Ph5fDSPLqAzxgW0aQf8CdxNZDl8JpIaeXrsPK53ie3oKy3trSnJu3/uNw0T7skYA6KWg1Vz/vXkT8zMZAw08O5kDzMC8wPynnrvq7ivdn8J7gJKsqa78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZhf+z6q; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZhf+z6q"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4775ae77516so48751675e9.1
        for <git@vger.kernel.org>; Tue, 23 Dec 2025 15:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766531531; x=1767136331; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nw9y+nuauAPpGXXVNBMTs8gqouGFMQFLHb7Y0IMeezk=;
        b=hZhf+z6q//ITEpdH5BeDSYFTAZ6cMGlA6OI6ieomnN9Bhw7+g1e9Pe2svs51gk5339
         /F0udX6k9rVOoowhFSDdnzAocvfCz+LpcPTzGCT5tkIowYLAVn+oXDIBZB3aNvB//tF4
         kwku9i9mDKalHYMgcIn7bl8A/U9IAUa0J04GBtAOzURVQBjVXW4TXIgBBMn6LXbxepK3
         mXaAJDv8EvWRTp8E3lHAYAdfJyUFuEGM6M8Np9aRqITsg8rLCXcjBuvqGW2VLMOLQy+b
         U1RKH7ns3peajvSgkBAFjxI8xhiuwdzcc7H5z4PsS6r7dqlv+/xJO4reI1dJoktsqufV
         5zhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766531531; x=1767136331;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nw9y+nuauAPpGXXVNBMTs8gqouGFMQFLHb7Y0IMeezk=;
        b=Igx7mub3r67JTu2jLzCr0J7ejUQRqpgkfagFElPqOc4zj/64rrA2xsqqVlS5XuwRPY
         lmAA05mTnMLNkcX5I4M7reUzOzj8IMAeh02ZUahpw05r8We2xbXoIJoHzYVkIT5aj9U4
         ZusZD+wZyvv2GmpfuBXP2TZ8v2g4xKJbuRspIGqMKHYYjd2Yk2wILb+JdUz3cX99Ym1t
         HE5BCrozuIGgj7HmqF7mVaB4Rx6b8uY+xdq3Ol53+kauCcK1AwTXujuHh/c0pecQSsfj
         P23Nrdhf4f9i3Vc4jT+ayP0pSAI3WQnM6LMsf/izuUGtq9udZXHKoT+F3Yg/DwBwXn83
         k65g==
X-Gm-Message-State: AOJu0YxtzPK8uTt73r3j6JRT1CHn9Bwmd0YI/SYWVIvNsgQLfGSmmGsF
	c8+sXOK/bCp7txgbygutADGxHBsbPuOH6rh+iYNmRNW8i7xlLTGk6FYYwco2X2+qJqXqIcXTKLU
	7eUFZDlgQChMd6YW5IHriCzssng4xZBo=
X-Gm-Gg: AY/fxX42x5VRMHcO1huAW6cnpeoJ2FHWcIBbRNaHTSYufHknLSDGLu6DHGuJze77Bps
	Ua4rTUx1xicDpUEzeUq9Z4MBGljXJDin2TqSpjP3txXtJGRoObLa84SwKgsC+WkupT7rc9xMU5y
	LRJQQYgdox3JMiEbTRpPddzam0LxHo8LskDTJfRHUbF14vNHzQN0rev1k1Bnvy6NmUfLx5G3Co6
	FQoqZdHSkW6L0wKysAT5Ixk6CsT89r9RQ2t2bYrsjw7RBuw5iBaqe4z5T/COhURvBqUVpDLK2Tk
	zqapMQ==
X-Google-Smtp-Source: AGHT+IGEt0aP7SRdaqnXZdLR0RhZ1ZDXWvX2lc1ZuI4ooDW/ze7yKT9XPVgC4XVHOfOK0X2zi/4fXWRuoRA9360fIn0=
X-Received: by 2002:a05:6000:2203:b0:42f:b707:56f0 with SMTP id
 ffacd0b85a97d-4324e4fd97amr17874723f8f.37.1766531530809; Tue, 23 Dec 2025
 15:12:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2138.git.git.1766451217075.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.git.git.1766451217075.gitgitgadget@gmail.com>
From: Yee Cheng Chin <ychin.macvim@gmail.com>
Date: Tue, 23 Dec 2025 15:11:34 -0800
X-Gm-Features: AQt7F2rD_fQECFnbksdsfoVlkSO0MrprnNIaSBRMxrsweGspRDcjD2BdBoDLZNk
Message-ID: <CAHTeOx_kSX7RhVvjjffSK849MMQbjNreqrq=ezHazw0GjMO2Ww@mail.gmail.com>
Subject: Re: [PATCH] status: show default branch comparison when tracking
 non-default branch
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> The default branch is determined dynamically by checking:
> 1. refs/remotes/upstream/HEAD (if upstream remote exists)
> 2. refs/remotes/origin/HEAD (fallback)

I feel like this is making a lot of assumptions regarding remotes.
"origin" and "upstream" are not inherently special names for remotes.
I personally have different Git repositories where they could mean
slightly different things, and I don't use the "upstream" wording
myself (I sometimes use "official" for the upstream branch, and/or
"ychin" for my own fork's remote). Feels like we should not be
imposing such a hard-coded value when nothing else in Git enforces it.

Also, when there are multiple remotes, it's not always clear which one
the user actually cares about. It's not always clear if they care
about the upstream or the downstream remote, of a third one that
actually matters more.

This would also work poorly with detached branches (e.g. the popular
'gh-pages' branches in a lot of repositories), or permanently foked
branches like fixed versions (e.g. v2.x legacy branch when the
software main branch moved to v3.0). Seems like for this to work well
it would need to be configurable per branch. Even on a repository
level there would likely be lots of edge cases with each branch having
its unique circumstances.
