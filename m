Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE1918FC9D
	for <git@vger.kernel.org>; Tue, 29 Oct 2024 14:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730213743; cv=none; b=cg9OS0kAcWdXoxGlb1Dk1NvySIw7OuNHk+t5w+xShmrT5lpywzEgBMCdgBXDabXtVdD3vVn+8sucwAfIZg01wuOkcbO70CAclR/Rt63CC38EzGKP3xnh16grdJHXv/emQoiLloTPTxpCcKmBHvmhqHYnntfIbEX2H661nybDXAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730213743; c=relaxed/simple;
	bh=w1uK1+lhvIcBcvmSoRL1SggOr6/bG84M7Ua3GGuzWMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KFtqjApGN0dUWggEJJ6jkRs0oc1BzvO+xNNXgsQVHAaaLTcwP45fpuk6WYnIvKF65579/ClM+pbQGUjUVNJvrcQSnmA+7cmH3eaKmmz0QPFGiOqrbo5TmIPheEHY0Uj+/y7+VrHUzalFsT3DwJAXbhW8JA86GkpI8DuG8rBuEIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2fgOeFL; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2fgOeFL"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d41894a32so4181585f8f.1
        for <git@vger.kernel.org>; Tue, 29 Oct 2024 07:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730213740; x=1730818540; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=H4iaiIki1OKyyyXU3baIrWrbl5f4nUjj65z/gyBAdqU=;
        b=g2fgOeFL9PHMH2HbjZF7yA+bUkBZrHObBfCYBJrg5x27mSXXxcf0fSsQDrzu2wafEj
         H7fQ+Ew1FC0uCPqWZcrpmIYIeUfJM2fSBgQMNhp77rMxIaJmiwjoQAgb8AUMYezB6qIO
         5Zy4mg8aRi6tKGduJUZBS2St47BlDKqM1JaVdKqWFKVH23Gpkqwrb6S3zrs65NT+r67W
         j1reIcB5wGvNYljnP2eDX/a5v9xttzc22CkQt58woDhmf/zRv7y+TWUJZrV3Wg1cO0to
         msLDNCxq3mrVzdb+Ga/SAY504t9wFIYGv5TakfBjOmEi/XdWuIXS6R9agCLDl/Ht+YBm
         um5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730213740; x=1730818540;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H4iaiIki1OKyyyXU3baIrWrbl5f4nUjj65z/gyBAdqU=;
        b=hbMuKOQ9fxGPwAknlZPpt7e1i/RVyIogJa3Ohw8HPl8y8s8wI8irDlrZfqUAjy9USe
         kEbfal162X8I8zCKeyhNfxsNqi5u8ZqKzcPpcvxlZb1rdZWZIEB59kHM3tdMW+vP+rEf
         ytQE2ihJrE6W9+VwpGzy7zW1fA8FUH+kq5LpmmvjB26fp+V31xY+Lnz8nsshVEDmiLaf
         p2YHgmtKsV8HQccp17SqItF56sX/o+lXTz9MSEbx9opp5ogwh7oFoSFoS5oRtJ93dHuk
         CjgaGl0Du+CFL2n0K3O5/LkW+QTz7i+ymz3gyyjc9WQLFPHmLRGiTvP1LTgVRUa86GCs
         pNjA==
X-Forwarded-Encrypted: i=1; AJvYcCU5fcp/yoc/WblADRZNAEqQdRZU9BCvKoINXIMaTpbL3rnxvql0nrCk0pXKFWhFZhmeIiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPUClSu9xsd7s2jvbK3I/S2czm1YNdEKcYuXDjpljhQ4O/5P91
	LZmD06I/+Ra3mNM0ofXXqRytKnqGewncCxoqDhJHzDWN0fgrFU/Q
X-Google-Smtp-Source: AGHT+IELXrFmn37TQyi3dgubBIk1yJ8pEqUnNxcL7DyTZmqmmK5qd4QJcJ+N/4QT88OXBNULYrzN2g==
X-Received: by 2002:adf:fdc6:0:b0:379:5c8:33fa with SMTP id ffacd0b85a97d-3814b5cc577mr1970183f8f.0.1730213739467;
        Tue, 29 Oct 2024 07:55:39 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a? ([2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b92f11sm12695635f8f.101.2024.10.29.07.55.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 07:55:38 -0700 (PDT)
Message-ID: <2ce3998f-ea16-4fd4-9756-c5849d834b1e@gmail.com>
Date: Tue, 29 Oct 2024 14:55:38 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/5] Allow relative worktree linking to be configured
 by the user
To: Caleb White <cdwhite3@pm.me>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
 Eric Sunshine <sunshine@sunshineco.com>
References: <20241028-wt_relative_options-v2-0-33a5021bd7bb@pm.me>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20241028-wt_relative_options-v2-0-33a5021bd7bb@pm.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Caleb

Thanks for working on this. I've left so high-level comments on the 
first three patches. As I said in my comments on patch 1 I think it 
would be helpful to re-order the changes so that the extension is 
implementation first and then adjust the implementation to support both 
relative and absolute paths before adding "--no-relative-paths" to "git 
worktree add/move/repair". I'd also like to avoid adding a new global 
variable

Best Wishes

Phillip

On 28/10/2024 19:09, Caleb White wrote:
> This patch introduces the `--[no-]relative-paths` CLI option for
> `git worktree {add, move, repair}` commands, as well as the
> `worktree.useRelativePaths` configuration setting. When enabled,
> these options allow worktrees to be linked using relative paths,
> enhancing portability across environments where absolute paths
> may differ (e.g., containerized setups, shared network drives).
> Git still creates absolute paths by default, but these options allow
> users to opt-in to relative paths if desired.
> 
> Using the `--relative-paths` option with `worktree {move, repair}`
> will convert absolute paths to relative ones, while `--no-relative-paths`
> does the reverse. For cases where users want consistency in path handling,
> the config option `worktree.useRelativePaths` provides a persistent setting.
> 
> A new extension, `relativeWorktrees`, is added to indicate that at least
> one worktree in the repository has been linked with relative paths. This
> extension is automatically set when a worktree is created or repaired
> using the `--relative-paths` option, or when the
> `worktree.useRelativePaths` config is set to `true`.
> 
> The `relativeWorktrees` extension ensures older Git versions do not
> attempt to automatically prune worktrees with relative paths, as they
> would not not recognize the paths as being valid.
> 
> Signed-off-by: Caleb White <cdwhite3@pm.me>
> ---
> The base for this patch series is obtained by applying the following
> patch onto 6a11438f43:
> - cw/config-extensions topic (doc: consolidate extensions in git-config
>    documentation, 2024-10-22, <20241021-cleanup-extension-docs-v1-1-ab02cece3132@pm.me>)
> 
> Link to original patch series:
> https://lore.kernel.org/git/20241007-wt_relative_paths-v3-0-622cf18c45eb@pm.me
> 
> ---
> Changes in v2:
> - Fixed a bug where repositories with valid extensions would be downgraded
>    to v0 during reinitialization, causing future operations to fail.
> - Split patch [1/2] into three separate patches.
> - Updated cover letter and commit messages.
> - Updated documentation wording.
> - Link to v1: https://lore.kernel.org/r/20241025-wt_relative_options-v1-0-c3005df76bf9@pm.me
> 
> ---
> Caleb White (5):
>        worktree: add CLI/config options for relative path linking
>        worktree: add `write_worktree_linking_files` function
>        worktree: add tests for worktrees with relative paths
>        setup: correctly reinitialize repository version
>        worktree: add `relativeWorktrees` extension
> 
>   Documentation/config/extensions.txt |   6 ++
>   Documentation/config/worktree.txt   |   5 ++
>   Documentation/git-worktree.txt      |  12 +++
>   builtin/worktree.c                  |  20 ++---
>   repository.c                        |   1 +
>   repository.h                        |   1 +
>   setup.c                             |  39 +++++++---
>   setup.h                             |   1 +
>   t/t0001-init.sh                     |  17 ++++-
>   t/t2400-worktree-add.sh             |  54 ++++++++++++++
>   t/t2401-worktree-prune.sh           |   3 +-
>   t/t2402-worktree-list.sh            |  22 ++++++
>   t/t2403-worktree-move.sh            |  22 ++++++
>   t/t2406-worktree-repair.sh          |  26 +++++++
>   t/t2408-worktree-relative.sh        |  39 ----------
>   worktree.c                          | 143 ++++++++++++++++++++----------------
>   worktree.h                          |  14 ++++
>   17 files changed, 298 insertions(+), 127 deletions(-)
> ---
> base-commit: 6a11438f43469f3815f2f0fc997bd45792ff04c0
> change-id: 20241025-wt_relative_options-afa41987bc32
> prerequisite-change-id: 20241020-cleanup-extension-docs-f365868711bf:v1
> prerequisite-patch-id: 60a443b24e92938b9b6f4a016a7bab87e13bf3ea
> 
> Best regards,

