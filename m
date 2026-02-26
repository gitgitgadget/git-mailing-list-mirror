Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C30D372B3A
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 20:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772137027; cv=none; b=KmdBVKM92TpNsc3e0nEZM8aD/fxDDi5+AsIidJ6SeksH2MSONc3qfDJfzHjT6feSSHlytSqFDGCOzPVm97JPjcWMqm/Y4HLOv7KMGt270ZAyc1ZwdM1tO9Hg1tCNuInYSRzL9Crngvk3QEXbRLl3lO8qn+jGVXUacsBqxOhgDhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772137027; c=relaxed/simple;
	bh=wNkQbvk5Iv/GU9scOugtFfOLFiRqI00xh11+WbYG20E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UK+4FQKHcje6r/4PWZM+t+c+wiTtNKYrorH2DPz6E4Ho/4uw8zOh21QUQmBbhKdBT2kAGxPZfVotPWpXFQhUcYrxCVR4mah3tTiywnVMWi66yzw+LIyihTJoHUdmlMaYGhOLIKT7gXLLNjKfzuJv90jmv2dM2Gmvb4nVdnJXtsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VhmFd+jj; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhmFd+jj"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ab46931cf1so17385055ad.0
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 12:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772137025; x=1772741825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsWHtZYthV6CT9Gd3DiMf97UnO5LGXpfClvp6aPQTYo=;
        b=VhmFd+jjRTPHFS2NvzglKBPU/kLxOUO0ln3A/iAq6Xg1sUpsc4Z61oKA4shnVI+H4i
         xkF94kUMFLRY4W1FEDfr0m/rHxv06gqEU67i9+d7o+EIZyPK0PgeTStvfGstQ3dd3oYp
         kRQ1ldctcMgDJGitOebsgJKK3XKbRD2V33LiD1PiWf46hJxyIoumNF55KszrgHLtN9ah
         qnc3garakLqwN7rz0tUF837VIV5RMVv0KLx8Qdhs0q+MHZbR0BfCwB9ZY0MBLzGR65n1
         wjhtKNeD/MwyiiIqL02WmES5EV532IqJSn5pQteN7iGha0ULh+x756VHN9WfDmKgajcV
         NaYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772137025; x=1772741825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vsWHtZYthV6CT9Gd3DiMf97UnO5LGXpfClvp6aPQTYo=;
        b=HrXo1YyhPyNc2ukBjvXfSy7yGSgrrTG6s9Fl4OeAaL9Jj6j99YAGig1bAIU15mFQiW
         myWGAkHzAkxnnRo2LJ/vVl4VeHJxJFBAnSJ+1QA02I/uBo6KslLyXNWCC1dJdMMtJrIa
         1XWuGeQESxVKieoJhHL4cobcQQh2wdQx2wbuHPxUEavX8jk9VL42x/LyzY38IZGvyoBj
         6F9om2TvZkcLhiED9NFYo7AqqoVqm5ev8jYDO53ajymq5dSxDBA9udosxjUfWJcO3Ffi
         7H5+lG/pqUP7peMglYgNjpUQkWvx5aUHX0rFLMrLqvp5Oq5yU7Xk4BaEc85Ueuowm1yd
         sFGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVj1QZDn3+VNrqvyilPfSkP/gfscdeefLlKLAR/5/1kIMrPUufCSZNSmdGvEO/o4w2btgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YytzuWR0uLfZvKddI9y5euieJhu2toIi4lpIUxuMnm8bxers5Vx
	ddUfD/pluylhZaFcqJ5OJSDMcs7Ltiz+2CwbRfpQ5C9XWvJ67W2NuKVZ
X-Gm-Gg: ATEYQzz/r7/1dLMPrYP4NRm7cCIVqVy00ef+Vc+X8p9PEXa8jg7KC1ewdkLKYIAjQ3Y
	lds9X5LgIN+BonCr97GznesF+iDXvwAiy1lHq5gCvh9lDjOoM277ylBKu7A+7F1uwQCbupJnrlc
	rM91fI+HAFQtu8aTHNw5StyDd8oDRG62qSVS4PcOMqh5Zr/U9t2UazV2hYCfm9vdU9S7r9F/KJw
	wOb8PadSrVy6ngHIQfLDQvF/St/O+q81oRSoFEy635M8sPUG9e3zLpmoMbwO6LsvE3RfL5JYLaF
	JsiHI/p2/xzihMpBSiTemJzjqOgkDz7XukBl/MktP3QIT4iUmu88X+uG6awxoqcR6QPDei2r4ud
	ktbbi5UfZ1pcZD5W7C2T8Wq5I4WMWj4/tpAozepDfmI6txrJGQ2kwYM1BhJqr9UauADA5Wxk7B6
	8xGJyF04v08isUmmuIXy4ZvXdp7F+3gAH6yh54hXNiT/fZ1/Q8NGshYBF5760A5SZMR6KH1rdvd
	Qz13ImcPdEYduxOhvenVz1pP2ipvmOduTGJ7ySJ4wifIFbk90Jkdf9qJMcJIt9yGJp6irsAeDKW
	2A==
X-Received: by 2002:a17:902:e74d:b0:2aa:d327:beff with SMTP id d9443c01a7336-2adf78dad4emr39769015ad.6.1772137025432;
        Thu, 26 Feb 2026 12:17:05 -0800 (PST)
Received: from localhost.localdomain ([2409:40e2:1a2:3fa8:218a:e947:db9:2504])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6a0409sm50770805ad.44.2026.02.26.12.16.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Feb 2026 12:17:04 -0800 (PST)
From: SoutrikDas <valusoutrik@gmail.com>
To: lucasseikioshiro@gmail.com
Cc: ayu.chandekar@gmail.com,
	christian.couder@gmail.com,
	git@vger.kernel.org,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	siddharthasthana31@gmail.com,
	valusoutrik@gmail.com
Subject: Re: [GSOC RFC PATCH] builtin/repo: add path.in-worktree field
Date: Fri, 27 Feb 2026 01:46:43 +0530
Message-ID: <20260226201643.5152-1-valusoutrik@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <05C28DD8-251A-4990-BBB2-26C144CAD982@gmail.com>
References: <05C28DD8-251A-4990-BBB2-26C144CAD982@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Makes sense, but this way you're re-writing `is_inside_work_tree`
> inside `get_path_in_worktree` but without using the is_inside_work_tree
> variable. I don't know what's the cost of doing this.

I also dont know for sure, but the is_inside_work_tree in setup.c has a
lazy cache ie a 'static int inside_work_tree' ... but this lazy cache
as far as I understood, does not survive after a command run. 


> I'm not sure if it should be in git-repo-info. I mean, this information
> is more related to the current directory than the repository itself.

I see. Very well, I was searching for something small enough to count
as a microproject. If I may ask, can you give some directions ?
I though about doing the group key thing : 

> Use the category as key (e.g., git repo info layout would return all 
> layout-related values)

But its already on the SoC 2026 Ideas , and I dont know if I should do
it.


> Something that I would question here if isn't it possible to make
> is_inside_work_tree accept a repository as parameter and then use it
> here.

Like change the function in setup.c ? wouldnt that break every call of 
is_inside_work_tree ? Or make a similar function , along with a lazy cache
just for repo.c ? 

> I think 'path.is-in-worktree' would be better.

Got it.

> Also, I did run t1900-repo.sh and it was failing one test case,
> which also ran with an ok when I added the new field to REPO_INFO_KEYS.
> 
> [1] : https://git.github.io/SoC-2026-Ideas/

> Everything above is not meant to be a commit message. This way, it
> should be placed after the scissors mark (---) or in a cover letter.

Got it.


> Test missing here.

Yeah ... I missed that. Suppose we were adding this path.is-in-worktree
to repo.c , then would the below test be sufficient ? 
1: cd .git and then checking if path.is-in-worktree is false 
2: cd .. and then checking if path.is-in-worktree is true

> Thanks for your interest in contributing to git-repo-info!

Thank you for the feedback and all the encouragement in the other thread
as well.
