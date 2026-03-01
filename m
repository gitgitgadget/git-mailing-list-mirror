Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470041FC101
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 16:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772383180; cv=none; b=UE/eF//gw2eNJGF14MvrRyGrNwl/UN98Onr/5ZcUNA8bDExwhJ0aeN4XXcOwKMLX+/l2gcGBQ65nwyP+QKjaqkLWebWEVZj8CMLdEDe2K9n0WI2+iJGlC0/kODEeTfEgPlXtEp5mhdq7E8zPGQFO06wayREwdVX+RQdOJK4QO/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772383180; c=relaxed/simple;
	bh=e9rJ7MzsfF18h4yH+AFFRtjblhGVLsYiTsPHLocozE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U9ZFSk9QXkiCakwXFuRDTguobFmBtyEFNW58Mhd4SoK4egtizKtewW6NIks+Ta2cH4RlYXqz7+hCLgeZtRurVaEHG+hatzoSAFYkucL8/WT3WDuCusJ4TD559pz59qxGvMTS7xQj7/bORYjTYMBpu4erP2z/MjNa0lLPm87+2Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEYljmvl; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEYljmvl"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ae46b9c7d7so151595ad.3
        for <git@vger.kernel.org>; Sun, 01 Mar 2026 08:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772383179; x=1772987979; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X9aSlCn1Plky+jVCy5aym5V8y9bu/oxjkX1NWDSa/kg=;
        b=SEYljmvlXYXk/Dmsf/mWuv1myOxStUUfVtWiphGjlfxO+owFtLKsErBYzzMA7Dpn88
         jO+BZATFv+OwEaK/CH3+s3Yj/4pEz8SaYALQviVFXSoxx8gRDrGlErdpO3x40cDFwcEa
         AmqnPPQdt2WRCeTYjcbOkFZq+wwaJXczLOhMv/rpzptAlVlMMoBxXWgd8DhXdV4KX8GS
         xsHLjhqctiwiEor1kpI30K9rfJMbigfQeSgP5oAdf3Ef8oBcP6ee5nEQ44JE0e6SWYTv
         2IW/BYjBmfQCkjRdThBcrUsBH6sY7JbRXFm89oy+2izWz0iS436pLJK2w15wNFaxyV6O
         O1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772383179; x=1772987979;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X9aSlCn1Plky+jVCy5aym5V8y9bu/oxjkX1NWDSa/kg=;
        b=XZ5oKEMrLqBT7HVSsTWRJlCYF2hVzDae8gJQfyPPqOBFZYMkdzGPw1b/LGRw0heU4c
         f9czo4DYI7lxmXQXu48DFsjYyoteHLBufGeH89ZPwqqk3I366+2goD3wkR+lVYHZJ79c
         cNgH8t0voLUvtRwYc4CaUxsY9oRy8h7il4RRQJuE3FQsMHM7379VC/ocBPJHURuavUlK
         szamdqGr3qvfQS0Wr5TWv+pAszW1rwGBCu90dxvw+mfqlAb6l5XmH8UiKz6wujhtmGAH
         ochqXa9dUtz0A8JD6Epkl97IFtleGcxdiNmscxWLj1LkqxXBCJ8scv84rNjzQ22yDe4y
         bWeA==
X-Forwarded-Encrypted: i=1; AJvYcCWrNRSVQKH4/MmgXAPVztKOcrtCwAFZb/5uZfowPALLn9XGKkiwzSpSlWceHQODsjrS04s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1mDnSUDYS7OBrIZ56ZaCjgUBfYxr0iN3iYoJROJZaEi2GqsxX
	RrJrmkqhxKiGBylAIf8r3BuZrfFUy0aPjbqj+B+gLZQxo1v4rbSw7xNUEmSuSPky
X-Gm-Gg: ATEYQzxE22OlGHZV7uFsql/PTy3TKu8oQxAUDgk6liKs+AawC4Cbo4gw9xMfoNLcxWk
	S1bCkDc7WuJxAmKi7wsu3xJILNf1mI/3vr+DIRZBgOYKldu/kUE7DDhh0Xd8lIkqlDFNPjWXTcT
	Pm5ZoOL+rj+Ry7PPoac7yA7RHqkQc8XXCu6CmTSZ4kd7t4G/NPpdLRwbcVpgOwIlf3wHRqfPsXQ
	023FRagngm6FL0aw+rQxdG7gwJhs74wTTnLByB6eLZ2vSyg5FkaoxwPFVk0AZnu9QFPXnoVUNf9
	0S6Lk2tFWzuNjEFZR6Gdy5cgA4NNQmKKY4wUTzmLudvR6yDbOL0AUryKV1NJ01kfIflhRrf81q0
	ROnFRE5r2ZxwHTSfewZGoX7oCXAQZWFpCdSY9msnCmLy0NQO6L/0RUaLO/XTqwhg7mWzHwpU6Y6
	I5608+Kczp2msxDkCwglNEc2lIRM9G1QQ6PIevfShXIumAl1FSPGYVUtXKlzNnIWo3lkeLx3UC1
	qDPPF9ETT0=
X-Received: by 2002:a17:902:da8f:b0:2ad:ec0a:b946 with SMTP id d9443c01a7336-2ae2e47a168mr70094935ad.3.1772383178563;
        Sun, 01 Mar 2026 08:39:38 -0800 (PST)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6b416bsm117126135ad.61.2026.03.01.08.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2026 08:39:38 -0800 (PST)
Message-ID: <feafa9bf-b1a3-4067-8b2f-5dbad1940578@gmail.com>
Date: Mon, 2 Mar 2026 00:39:33 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSOC][PATCH 0/2] Remove global state from editor.c
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, christian.couder@gmail.com, karthik.188@gmail.com,
 jltobler@gmail.com, ayu.chandekar@gmail.com, siddharthasthana31@gmail.com,
 lucasseikioshiro@gmail.com
References: <20260301105228.1738388-1-shreyanshpaliwalcmsmn@gmail.com>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <20260301105228.1738388-1-shreyanshpaliwalcmsmn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Shreyansh and Burak,

Thanks for the patch.

Reading through discussion, I think both of you highlighted very valid 
constraints:

> While moving the global variable from 'environment.c' to 'editor.c'
> doesn't cause any behavior change, it still relies on global state.

Yes, changing an extern to a static variable doesn't truly remove the 
global state, right?

> More importantly, my intention for this was to keep original behavior as-is.
> As noted in earlier discussions [1][2], maintaining early config validation
> is important so that invalid core.editor values are caught early. Moving to
> a repo-based lazy lookup would change that.

This one also makes sense to me.

However,

> I believe a process-wide setting rather
> than something tied to a specific repository.

I have reservations about this, and I believe this is the most critical 
issue. For instance, we can run:

	git config --local core.editor "nvim"

where the configuration is written in the .git/config of the current 
repository. If core.editor is process-wide, git should not permit the 
existence of a "local" core.editor at all. Since it can be set for 
individual repositories, it should be tied to the specific struct 
repository, right?

A more intuitive case is:

	Repo A: core.editor = vim
	Repo B: core.editor = nvim

For users managing multiple repositories (submodules), it's perfectly 
reasonable to use different editors in different contexts. At least for 
me, I use different configurations for Vim and NVim, and I switch 
between different editors when writing with different languages. (like 
set textwidth=72 for Git? _(:3 ⌒ﾞ)_)

I recently faced the same dilemma migrating git_commit_encoding and 
git_log_output_encoding. I personally believe that adding editor_program 
to repo-settings.c is the best approach.

By doing this:

- We truly eliminate the global state. Each struct repository gets its 
own editor setting.

- We maintain early validation. The config can still be parsed early 
(e.g., during prepare_repo_settings()?)

Thanks again for the patch.

Regards,

Yuchen


