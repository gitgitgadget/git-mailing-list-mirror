Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C5F2E499A
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 18:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751481053; cv=none; b=PPLXy6jJv2fDs7EmSmmnUn05ZHtBoPJhzpHc4lL0VFw6bq0wHOj8a5YnZHRJdKXl+ZC6f/uopj/gkPPFECuzVSuzRsziO9guSB5Uuv23oUbliUQsdEf0PR+WMglcKtCkYOglFLhLJycGDGD9EuVz2V94CS4xLTINvko7h16Mos4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751481053; c=relaxed/simple;
	bh=ROPrEOGCqXgIBftgTdL+fp3+THqYxO1f5BBLICfOtF8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=jhAzkAah5TuibwcB4/Cx86pYVLdur6mL/q/pGQxXua1bejYP9Dkrp8o3rsA/8jiF7PSG+IGKNo21vuwwLIda9HrD6IUve/CBv+O3HHoiwAJt5wRHBFSiKCQ89fuvvn1zeT7XD4uEIeeQ+lfSjfASBiuQtvJ8+DmSYkzVx0c/qrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQuPwOJv; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQuPwOJv"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-610d86b3da9so1777663eaf.0
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 11:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751481051; x=1752085851; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TRUONTKuPRUlDXbc3AG7c7g0ijdQZq6k6uqe8+zPYyw=;
        b=XQuPwOJvdDeCn6l9ZwoBEyrRD5cl3yxUSCiD4wpd44VUxObI2rlL4OudXmj8n1c42u
         oHLtzRv1REeo78ZKomBybxaQ+8ZwFMLJOoEXY1ABZKWK5DO3Ez9v3FfWfSD8qgpmipsu
         +RLu+nxW9KnSgKXYM0Op7GVzwN1uy1SLtRT74Px7Pd8mkFg+v/irPYlrj/Id18vk/ftd
         /IC7swZk2uxm8yV2uwnllwBPAHb+3pGnsIR204lE6pZi2dsgkVe4HeX845NN3k+PxfS+
         CDFfrFxLo2dHEJnkBVgzQCba2ijxuwaTH/sCO7F0W0PG33rxkEnzu//We26/QWR7FH8l
         VjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751481051; x=1752085851;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TRUONTKuPRUlDXbc3AG7c7g0ijdQZq6k6uqe8+zPYyw=;
        b=e+m77/wrKdfk7jgBXm4qvOI0sMHwcYYVqbPSqijDw7xjbj2rEupJx2UmaMJrfVOa3h
         TKoLUDxwB1rAftCN4eXqmtZDKEvdfcQQdE7SrfAC9W/2+akgmv46IazEwWpBgi8Iggpl
         pKPqSUI3m9h7XBGywxDQNs383ucXn6Oom034YVfUv3ldf1uEC3EsK3dZMDB0+W6IGoZY
         TcwoGxV8zXOAnIQGTi9c7RV48xGF55KrHtepnCd1/NrTfRf+Wb1OjHbK39rS7dHe9Ir2
         +QxreKb+okLauazwLwn59lkoXFfUXJt/upMjRjVkNAt15YcGwAAItQoXaaHOiwRRDAzE
         +oIg==
X-Gm-Message-State: AOJu0YwSoQND7SSwPP7YAW9WgFpstNFRNbRXxzBTlzNIagWoExb4F8o+
	vsO80Z4RC1AHHAu8oqMuHp6YFbB42z7IadxtqGYVqK/T9b7sspPnya9waxMQA9g3Jdc0vm8jxAL
	f4sqD5h3YGPmiFRG8yPNV9/LMU3U3Ehmlh9lO
X-Gm-Gg: ASbGncvJbQi/CZd5D3J6TL+N6SPmqb56lpAURGHmzlPM4g7wv4iwYm597jR7Yj1Btp3
	QCIIZR7SAkce8etdoqr9VKB2AHDtDfIG6iPk80ogTZg9e/xuB7+aZl2I+BVJGfEeqY+6ZeSRA7U
	YPG9s/MZPOP4FxoBzTPKSfeaY9tq3bVeYGtdIYO44tB/3mHQ==
X-Google-Smtp-Source: AGHT+IH+MW06JHQE/F4YN3Un6A7ZFGByraMnuoK3lBOPdsh0BY2m8iJrqUx8gA3EGMKKQakoxUmt+2kAGV5EPDR99+c=
X-Received: by 2002:a05:6820:1994:b0:611:9a4d:fc44 with SMTP id
 006d021491bc7-61201244fcfmr2806223eaf.3.1751481051030; Wed, 02 Jul 2025
 11:30:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Suraj Bhadrike <surajbh2233@gmail.com>
Date: Thu, 3 Jul 2025 00:00:17 +0530
X-Gm-Features: Ac12FXxraAfmESId8zwBfE-o_hIF_vjoZGCgjqlVqKGfVD2ayfzGb-9WfFZ5vDY
Message-ID: <CAPGv+4ZT774b-LGMFpyv3cJYUrpWPMpkCGn25AfwD7MHskbV=g@mail.gmail.com>
Subject: Feature Request git snap, Lightweight Commit Workflow for Iterative Development
To: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Git contributors,

This proposal introduces a new command git snap  designed to support
highly iterative development workflows nowdays  influenced by AI
coding assistants.

The rise of AI assistants and agentic AI workflows has changed the
pace and nature of coding. A developer might cycle through dozens of
variations of a function or component in a short period while
collaborating with an AI.

This feature would provide a soft commit or snapshot capability,
allowing developers to save their work state frequently and create a
new commit every time as a snapshot or checkpoint without a commit
message and flag where We can provide an option for developers to
include files at the start of snap Session.

The current Git workflow presents friction in this type of workflow.

I've created a small Git repository with documents to help illustrate
the concept.
Please review it at your convenience :
https://github.com/surajbh123/git-snap/tree/main

Your feedback on this is highly valuable.
Thanks,
Suraj Bhadrike
