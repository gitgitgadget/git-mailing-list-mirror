Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C7526F293
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 16:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773763556; cv=none; b=igtFdljMGDx7oYsSqVEiegRS1ua5zT8FrKpBT7Yu/lcCAWd2qVZoEPxdTxPkojhSmnc13/HgS9D3RLTgxSLQc9wcw3hUZPBUw6tzBL9sxNa0D8sLmzr0zENWq59iIhGAoqZHDinjroQGlLHbolpTWEVOViUauS5HSlPWg6SvpdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773763556; c=relaxed/simple;
	bh=zCH9tjZrczwEpIM4i51nh7L4lU7ibuO7FzuNWYWJZIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OJahsRPiNw9boXK27ZQhh2LQG1x7Y8Psq9GyhiKgNhXfVvMOFD5t9fEJ9KhaDODdejQdIyfeBePl83OlYRdUGY/xBTp+eyWBuB4t+ESKsR0lyitOEY7EgIUYMPWrw9NvPY5Wl3sTcnuzgCxDIvn+z1L4z+hZMPniufTvhtYKbw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YpcQMRfh; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpcQMRfh"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-824c9da9928so3793877b3a.3
        for <git@vger.kernel.org>; Tue, 17 Mar 2026 09:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773763554; x=1774368354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WlFZhoXbpaERo4bkzzIGWpL4FP71/kgcixyMiayYUc=;
        b=YpcQMRfhItxrDJbYIyGDOLUiSWeal060jbRq9iB0dsfbewK4aUN+wn9fajauvC3C0W
         DUD4ykpCxS+rDAx4k6v/fvM+zj/AS1Hx9iDL1sKu2o+b7Ka/i0VsvLvt6JyA6dm0Xu1c
         hujl3fia6m8TAKXGW/vlw3uzBtBFmLZPjQievMzf/D4Q8yYXmwP9dDkWg7IhR6w5LJd+
         oBfWTYkZGav4kD6rG1b9k4m+fYzMYxNo098gsPWhMv7N+e2fa0DdBIxAOF1ptTTmPCNm
         7/Y7PT3EShPi3lm9b+6Pc+yv6TrR3GHIsTAFDYlca6av/FQ/KUeFtUEBAWyp3GNetGTj
         uLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773763554; x=1774368354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8WlFZhoXbpaERo4bkzzIGWpL4FP71/kgcixyMiayYUc=;
        b=ciPBeSYGvqvx8rtgu6MkBSU5zKGsCPfK/5T3vNwf3AokZO9HWgg2vZSk2tu92K1r3W
         eN/b8VrJavTlq210FryobeBOr3g6XWyFqNYZdOgN/YnXyyZETabiiarWMqyMK0eHbuV6
         +WtRBFU7rg54ri5XScRvm4LZqJQnwFYFlG9J2LC9NAYuq3WtMxr6AOd0BTe5oCprGncY
         KQJxPzoP/INkEUX2HN1Rqvp73bIFqsF/YXRaRjuG21+tOe8C6B6YhMCxNHS4S2m14OwG
         Lkz9Uors8WnSWiMvhcWZZnWiGzFnIEQ9WOuk/ziZhVGlzWN4CqdO6t/eY2ea87HFqmET
         IMLQ==
X-Gm-Message-State: AOJu0Yyw3MBVTvKWB7Hlqg8hm+ol25xZD8fl1DgTw4Ck08OW3sZ4bYRk
	9j1dQo/KDoJkr3sxltZA5Lh+j5Otqhf+30qLU7lCJH6sAw85kWawwOz94/W8HQ==
X-Gm-Gg: ATEYQzx+4S5YjojSuOkMzskW59yui8U30saxn5dT74Fyr69P8AvJS/aNx8Lj318S2/F
	JCkoksMJz8bLUrxX5fmjVcbPCohxgxBYLAnk3ousiMKfd2T1XFyor1fGsb1UcyDDJhow1VRtvvN
	ext9AWwF5PK+KZe6UZrerWX4s1Dd/iS/UnUUubvxiaO4sRBSK0S0gQDHlZqDQyQoLpPT06n+Ulz
	NP/ENXf7wrZ7M4kvlbgBIbtGcsFcpVFJYal/k9to9c89OX+pubO7x7Uh2Umujv0cBOK4ha7rlIu
	b/67AUOSd3+EY8Aekx0XtmsMz8CU8NoPiZNVlfmUReEzVUeaqXPpQQVaRWFGVpPUbQrP+6SFuED
	hE2ADl0ICwvqJmemeRJlcsPzuiBxp2aUGEcE9EuZ6JOcNmdKyBGD5alQ/FQExgk0Wes17HGtZHv
	GcpAGH/3di8FMDlkT8YJss/bb5WMmmXglVnEFCSx69Z9I=
X-Received: by 2002:a05:6a00:139a:b0:827:4526:517 with SMTP id d2e1a72fcca58-82a19703a3bmr15299375b3a.7.1773763554488;
        Tue, 17 Mar 2026 09:05:54 -0700 (PDT)
Received: from Shreyansh-PC ([2401:4900:8811:4c9f:12cd:260b:8809:a4e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0725be23sm16515683b3a.15.2026.03.17.09.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 09:05:53 -0700 (PDT)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	lucasseikioshiro@gmail.com
Subject: Re: [GSOC][PATCH v2 0/2] Remove global state from editor.c
Date: Tue, 17 Mar 2026 21:33:57 +0530
Message-ID: <20260317160539.621560-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310174519.676851-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260310174519.676851-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This series reduces reliance on global states. Mainly there
> are two such global states in editor.c,
>
> * editor_program: defined in environment.c and populated during config
>   parsing, but only used by editor.c via git_editor().
>
> * the_repository: used in git_sequence_editor() to read the sequence.editor
>   configuration.
>
> In patch 1/2, localize editor_program to editor.c by introducing a helper
> that allows git_default_core_config() to continue initializing the value
> during initial config parsing.
>
> In patch 2/2, remove the remaining use of the_repository in editor.c by
> passing struct repository through git_sequence_editor() and its
> callers. With this change, editor.c no longer requires
> 'USE_THE_REPOSITORY_VARIABLE' and 'environment.h' include.
>
> Shreyansh Paliwal (2):
>   editor: make editor_program local to editor.c
>   editor: remove the_repository usage
>
>  builtin/var.c        |  2 +-
>  editor.c             | 19 ++++++++++++-------
>  editor.h             |  6 ++++--
>  environment.c        |  5 ++---
>  environment.h        |  1 -
>  rebase-interactive.c |  2 +-
>  6 files changed, 20 insertions(+), 15 deletions(-)
>
> ---
> Changes in v2:
>  - removed 'environment.h' dependency from editor.c as well.
>

Hi,

Sorry for the late follow-up, I was tied up with my college exams.
I just wanted to check if there is any specific feedback or concern
that is holding this series back. Do let me know :)

Best,
Shreyansh
