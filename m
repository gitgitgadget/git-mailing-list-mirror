Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270C710A18
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 18:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726512761; cv=none; b=Kl/sNxd3KqrpNh2rmerGhti3eiowq5Qeit4W8ZmChPwNgxc3WYiv925u/BJBP1IdqG9VjpuIjxNNWx2D4mv2PTkrcgCG95rbr5M+aL7C8qsXaCxuiLqcbe0ibALMITfesRGOgS0QOxJFtLNY9McQWLmjVJT8t+k3xRyfrTtqK2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726512761; c=relaxed/simple;
	bh=mc8UeSBhgGfgNo0+79uDvkvkYQnOaF3R/Okcif1F6zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvnlmhlH+KN8WZQQNFrIER/159qmgto49V9uNeHVLMiONhfQCk+P8GSjqMdtQo9Po3+mcDeFQcEN+yLvrsR0zqltri20P4HD+WYNPKy086AQURss4QvqJ9lO9LuyTFq8PoIaX6pMMaw/sh0g3fSKl9XoSZf9LQ61qa5cvSkN8BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSMvB6vD; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSMvB6vD"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3e04a6feef3so2403635b6e.3
        for <git@vger.kernel.org>; Mon, 16 Sep 2024 11:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726512759; x=1727117559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=98r7CC/4y92hBGcfWja4vJ/7fS6vYUNHL4SoEFvbYfg=;
        b=QSMvB6vDpHEHAYp6fcB01Dpsil5ybnEoTWY8RRcliVKWWjNYASOl74M7a18flkK0Zk
         ob4lca5XHl/EfJwwF5XC50362rU0iK4YwkaqqbQupSUVKBIvelB7yDynYsY35vW6Q6Y9
         8EEhF46ml2M6OhlRZpjXWSUMu9Ob5BXm8KcrEqbU0F8FmWTTTAXMSXSZFmbuJaW/t4O6
         AjkfcXUcEj8svJauef4cmYRj0i8Y8PpCqTbmfLf2anayexjsroLfLbA5U3CAO27pY3bX
         08sSUsmU3dSP1oHfXk7xltGBlkpD39lM7g6BEb/XkujJU3+yrc/nDePzKtZoug+AAiQt
         5PxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726512759; x=1727117559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98r7CC/4y92hBGcfWja4vJ/7fS6vYUNHL4SoEFvbYfg=;
        b=g5cSFdAkLV44tGKk59RuIXjcPByxBBqiYCJjAQjE+iMQYM4oIFzvCmq0aq9vzcN+47
         vNqi0hsNh4kd6eumJ7RAW3R1ipreP60K7nIexxAga+6fFNL2N0raK8A0AvYt2zN0OTKc
         UYQ0/kmmPf8D54W8wWHEJeQ82/Fwfvrk3RhRkkyO3xKq1F7pg/q3HxAtbI2ozVDs+5IT
         ussjlp/Gn/DIPOG2G8FyCXskQi0Kl3soHV5ewZ/zOEjt9kZOhuMUq+C+zzTgKKW/ZBtD
         gBIPn1PG53ZS8Hq1hT8PaNP3Xl9SuDkjGOEjdRNrBVX+i6TAXN1elkLnKObFCpabv2AD
         kSGQ==
X-Gm-Message-State: AOJu0Yxm161TcSPwwVr5LJtTav+/+ZaZZ2H8fb2lkIG+1kxT9Gf59k2T
	2p1xKkRLsPBTwV++EZbKlIjYjFjOdIE2gx8ZLXa4YJvVCvxrv8gi
X-Google-Smtp-Source: AGHT+IEPX44trMNMS3742wgs6lSJiNx5YYaybjMTAVsjT6EOyFyf8E3WfW8bpVfUFWooNsW24r2QjA==
X-Received: by 2002:a05:6808:3c8e:b0:3e0:3aa5:2b6a with SMTP id 5614622812f47-3e071a84906mr11636883b6e.7.1726512759011;
        Mon, 16 Sep 2024 11:52:39 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e166fc55casm1112396b6e.58.2024.09.16.11.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 11:52:38 -0700 (PDT)
Date: Mon, 16 Sep 2024 13:51:21 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 08/23] builtin/submodule--helper: fix leaking remote ref
 on errors
Message-ID: <l5aljv4zlvkfpjsizofsypgfaxdzkihwghd3voxin5oxibuixz@fesroo5tihzi>
References: <cover.1726484308.git.ps@pks.im>
 <d088703d317a8598e1cc4eb068234c105cdeffe6.1726484308.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d088703d317a8598e1cc4eb068234c105cdeffe6.1726484308.git.ps@pks.im>

On 24/09/16 01:45PM, Patrick Steinhardt wrote:
> When `update_submodule()` fails we return with `die_message()`.
> Curiously enough, this causes a memory leak because we use the
> `run_process_parallel()` interfaces here, which swap out the die
> routine.

Naive question, is `update_submodule()` itself being run in parallel
here? Is that why the die routine gets swapped out so a child process
dying is handled differently? Also is it correct to say leaks are not
considered when we "die" normally? 

> Fix the leak by freeing the remote ref.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
