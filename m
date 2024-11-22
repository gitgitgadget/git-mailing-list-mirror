Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFEF13B797
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 15:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732291043; cv=none; b=X8oYh3IS7qRDGIWpaYYKyToR5Xj/jgFN/ErrdiBQAE7+3H6f8xSzMVp08N6HVqB35DMcQS/U/l6ocwvXKzTb9XibTUp428X5XxTKoGxGt1lmy1rl4i8LEScV2hgzTRjIpXqP3PWGaiHMghFoa1qMhyHcalKXyTG07qlZ2uVpbko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732291043; c=relaxed/simple;
	bh=4JH08TCLKD0vL5U3NJ3rrPkTBg20LJs1otJq54jnIsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SKn2oZLwrbUdVkjezZpdzvwap7s6XfqB7bweE8Hieja0sgQ//VkU7V+NefGByFGt2VulpL5JBRUq6HVLoth2yani6hvkUbviPbpRwonHNGeDocIVygGV01btEQIodoarqISqrc3RH1eU19bFB5YwqjAQT1s9npigwgw7DEfqbAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3q/OFcJ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3q/OFcJ"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-382296631f1so1659517f8f.3
        for <git@vger.kernel.org>; Fri, 22 Nov 2024 07:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732291038; x=1732895838; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=d1P9yze3+F/Avd/rtK1EggArJ9Bcwon4NLVvoGHluEk=;
        b=N3q/OFcJr98ad+ba25E2ES0WKl3v60nKxUlQBCZn+jNrVg/ruZD+gGvnNRgC/B6kbP
         fKrSZvJM2OL++OhpW5PGaY0URaWNpHY+Z5iaSz8rsEt52KUBzenv9pVuYUHjX9qzhZU5
         WJ7mqnD4fYRi1y7WXF38TTHNl62xszU0XjQ48JRDvcEy5UWmYeaF031mMpnEzY72bAe9
         pqVkq+JANZJpZr01ty5DnRaCNWu5SbEar8t6Bgk3s+PI/4Cdiy8WkVnyskE3SfGssY0Z
         IDmC/1lCNdcKuKAgVcYk36fW5zMVirGOtEw1auU1pXHIAFW86W4yaEsd2EMjzk/pTwzW
         pAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732291038; x=1732895838;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d1P9yze3+F/Avd/rtK1EggArJ9Bcwon4NLVvoGHluEk=;
        b=Y0KYPt376nAYCS1HIiFKR6jOq28QrYmQPVEGYyB1mdLeXdkrA45zKT/nNCXzAKbHZT
         YXTduPHMIIUTXaHOWp/iW55DQtWPQFz1VTMP9Bznr4DVfpjPPjrdLcPQ1LEcC+1mx0rD
         qDsITg7YX/nBkjN9eocTsQRUt1IB2hUIPP40lVTA3b1nNLpZcApd8JdnaIDOn5kzG2gJ
         kaikU7teaNagny9ctbY9fykTLCx7GN+5niYyRRPu9nph21+o4Gs9YfG6zG+sgZMqEFaI
         29jTAIHx9Q3TiBGSr0n+u+AA2I6BA9I3uXVYhip4KrU74euZAc5Z4fx+juewFs40u39w
         8Zzw==
X-Forwarded-Encrypted: i=1; AJvYcCW2lrPTAz0hWuMtlvi/uK9nTP+DqfllXXm0mZTB1apF0jjwjN7iKrIYyHCPDlOO2EeclgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZeNiSHWMLJIEJt/Mesl4f6oKL8RlINq+sb9RMP4Snxfte18zv
	hrerr27scDWFmBcM+czY/BOTvPKQW4elg/B6QQrZCQ2MlDGR3V/lbx1tMQ==
X-Gm-Gg: ASbGncsjSzRk6kV2TcsRxkvb1yBgWUH3XXYhPl04JGzvKgs71sIgDPpKKpzyiCvkdR5
	YvESTdgLxUtJmCHU/052IV/8F9EtBg0aFNT9JSwSMeFWBoEMaSpq8l/hKKwSEjToteCM+CJ/66x
	jZbj984gpv5EyLmt3HsYEQdxqVFU6oHP+Sfx0lxw8vBGIMXT1UXvQrB0/Xdp0h5HemFPGUddSWl
	rPwTO86Rqx3qxvePrChaZKJUCHmu56I1BZISWYIMMNtzSZi2N2/8ba9MFzGYa8vmQWX6uuSxIb0
	OiaWXlQGibIpUlXJwc2B1AC+yg==
X-Google-Smtp-Source: AGHT+IEFxVVfFoqyRqTZztI3EmLoY9haSh5HFqjgCqRT2Wsmzw8h7q/ZBlMG4to1E4AhKQ4+TKIGdg==
X-Received: by 2002:a5d:5f4b:0:b0:382:1831:f7db with SMTP id ffacd0b85a97d-38260b59bc9mr3068925f8f.19.1732291037482;
        Fri, 22 Nov 2024 07:57:17 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6a8:b801:610:d596:f87c:e591? ([2a0a:ef40:6a8:b801:610:d596:f87c:e591])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbc3a47sm2807053f8f.73.2024.11.22.07.57.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 07:57:17 -0800 (PST)
Message-ID: <db700d82-c775-4e0d-a171-9caf6489a3d8@gmail.com>
Date: Fri, 22 Nov 2024 15:57:16 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 0/8] Allow relative worktree linking to be configured
 by the user
To: Caleb White <cdwhite3@pm.me>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
 Eric Sunshine <sunshine@sunshineco.com>
References: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Caleb

Thanks for working on this, I've left a few comments on the tests and in 
the last couple of patches there is some distracting re-factoring of how 
which strbufs be use but fundamentally this series looks sound to me. We 
should certainly try and get this merged before the next release.

Best Wishes

Phillip

On 01/11/2024 04:38, Caleb White wrote:
> This series introduces the `--[no-]relative-paths` CLI option for
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
> Changes in v4:
> - Fixed failing test in ci
> - Link to v3: https://lore.kernel.org/r/20241031-wt_relative_options-v3-0-3e44ccdf64e6@pm.me
> Changes in v3:
> - Split patches into smaller edits.
> - Moved tests into the patches with the relevant code changes.
> - Removed global `use_relative_paths` and instead pass parameter to functions.
> - Changed `infer_backlink` return type from `int` to `ssize_t`.
> - Updated `worktree.useRelativePaths` and `--relative-paths` descriptions.
> - Reordered patches
> - Link to v2: https://lore.kernel.org/r/20241028-wt_relative_options-v2-0-33a5021bd7bb@pm.me
> Changes in v2:
> - Fixed a bug where repositories with valid extensions would be downgraded
>    to v0 during reinitialization, causing future operations to fail.
> - Split patch [1/2] into three separate patches.
> - Updated cover letter and commit messages.
> - Updated documentation wording.
> - Link to v1: https://lore.kernel.org/r/20241025-wt_relative_options-v1-0-c3005df76bf9@pm.me
> 
> ---
> Caleb White (8):
>        setup: correctly reinitialize repository version
>        worktree: add `relativeWorktrees` extension
>        worktree: refactor infer_backlink return
>        worktree: add `write_worktree_linking_files()` function
>        worktree: add relative cli/config options to `add` command
>        worktree: add relative cli/config options to `move` command
>        worktree: add relative cli/config options to `repair` command
>        worktree: refactor `repair_worktree_after_gitdir_move()`
> 
>   Documentation/config/extensions.txt |   6 ++
>   Documentation/config/worktree.txt   |  10 +++
>   Documentation/git-worktree.txt      |   7 ++
>   builtin/worktree.c                  |  29 ++++---
>   repository.c                        |   1 +
>   repository.h                        |   1 +
>   setup.c                             |  39 +++++++--
>   setup.h                             |   1 +
>   t/t0001-init.sh                     |  22 ++++-
>   t/t2400-worktree-add.sh             |  54 ++++++++++++
>   t/t2401-worktree-prune.sh           |   3 +-
>   t/t2402-worktree-list.sh            |  22 +++++
>   t/t2403-worktree-move.sh            |  22 +++++
>   t/t2406-worktree-repair.sh          |  26 ++++++
>   t/t2408-worktree-relative.sh        |  39 ---------
>   t/t5504-fetch-receive-strict.sh     |   6 +-
>   worktree.c                          | 163 ++++++++++++++++++++----------------
>   worktree.h                          |  22 ++++-
>   18 files changed, 331 insertions(+), 142 deletions(-)
> ---
> base-commit: 6a11438f43469f3815f2f0fc997bd45792ff04c0
> change-id: 20241025-wt_relative_options-afa41987bc32
> prerequisite-change-id: 20241020-cleanup-extension-docs-f365868711bf:v1
> prerequisite-patch-id: 60a443b24e92938b9b6f4a016a7bab87e13bf3ea
> 
> Best regards,

