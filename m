Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB6A31A55E
	for <git@vger.kernel.org>; Mon, 18 May 2026 10:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779098574; cv=none; b=YLfu7VV2SdtF4Se8XPtXlp4u20Ruxgknec68keoVrMkOkSU8mdLxreA7B1BuP+CAbZ9PPYlMKRgzz7i9Mj7h/s/0sIJNSrWDihzMMcdzZMjxMxUyV8g+LqvrSA5oWDCI+hsLoWq5Np1KXqXlnODkK/H+4uARs4BFuH/W3BXnj0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779098574; c=relaxed/simple;
	bh=pOS+ECBJx90i+QANZ/f1kdXecx0zC93p7OX6W8DSs7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=uRUNtMTdWBgxdtTkXaGGOgYVxHAiGtp1ngR7RyPs4GFBFVTJwAERMLxQCqtcdIyhYEvNU04x3aw84PQRS26eyv7WeJ8uCpikJSGve7bTOJ638hkdJua05L1NTcIUgvaxl5MqKrw/VEwHdf3IZb/7BOy581eOKYamdLiqRXh2aNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h22M5CnR; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h22M5CnR"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48e56c1bf5dso9289935e9.3
        for <git@vger.kernel.org>; Mon, 18 May 2026 03:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779098571; x=1779703371; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1cq0da1vmhhQNX5jzfD+h/tBIyfG7FcOw8TWQzTYTOQ=;
        b=h22M5CnR4jhVK7e6oL+5bjwS5cV448uaSyXBFOBMboSMPNLgi0i4oDTXLaL8URq6tG
         g92v1uWSSs/MO/7/FjchKFVp45ykFxfa+jnY7fTOv6GXltAZ8Fu0JA4ZpRXoTFIRaovs
         w+7pISXv/exNJsWufjZTHUuQV6NGMiJlwHSg7tVY169bk4r1tDVGKOoAKsokgiEW3Mrq
         hjojumSUV7Ue+2Y5u+wKO0TW6pk/Cqxp4+1c8gmvRqvBnaEYs/ai4j0Gdy1SqipkDo8+
         mQETzozrLmgqs2BrARKoXJLZpGKQiS/xUL6Ru7DzJ/XwpLNYIasYbiwGIb250Tf3e4FA
         LCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779098571; x=1779703371;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cq0da1vmhhQNX5jzfD+h/tBIyfG7FcOw8TWQzTYTOQ=;
        b=SRdgCpEgCH9YGs+8iQ/RHXniWHakNrZ7rP+Vp/GpNfahipGyQjs33sOYr41NA44KOt
         z2x5N0DDSj46JuG+TtlYHtbD3I8rijj3wC+cHco9q4FFkaIBjmfPqjCVqPHLULuhhbUA
         4akeKFaeoS8QgQrJFnEZTbmZoggds2nAvES4l0bm0Lo50gtAL/v5ZwSheFyjeo5BbHzr
         43YzbBRsUoDaxmdDXW06/6p0TA3l+GKt7tbR1QhoHKWoZYsINrQHSX64fiSzHm+M1YPP
         THwZxeEPQJtPhMAoS0rSpqNzDhS0DMhHnjU+BJw6yp6Qr60/xLFq1MJai/ZC91acBxdZ
         w/Ag==
X-Forwarded-Encrypted: i=1; AFNElJ/ECdQJfGJnOkFV5A3HrvkkFr7Ms20Hqqww1ftv6U8w9fuceIUIN7rXjzdwQIDnFAtc6cA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0c5Hzh8WfTv97YL9ylUqjXZX2bCAqMsKVIiwL0u5zAumirAct
	ozFGxG+tOURU4g0p1tqSaChLMR0vMXcY/Sp8xKB7/mpl1jddVgFc+Fxsl+TmZQ==
X-Gm-Gg: Acq92OH8iRQi5xKXOI9wqIwmQtN4zrcJSripVN3TwDMaoKdgLw7OhqLQaNjpVqptNNg
	VbKMp0yCpV924SqYXIuEZ2ltqHbh3g2uR/t52M1nXxm/kZ4SllIc0p9GhgJde1IkZXOJYd0QniF
	kSnHAtRCTEkibzc1F2gKhqbooxxw15xGKL41wuv2zq6lhb6GjJt2bGw/1gdBlGSKyMiR9FX3ebZ
	+cYWOiW1i7tTzj3/YddiF0mEhn/k5fMD0VEH3eo29EBQuIaxI7BZw9eqCq0ZNeSkCo0zcMRIRT4
	5x6CbZ9EObD/YLDy+zl9Ff/CrnF2NLmpodm5UTm8tVPfiWzyC4ysZZ1uXOSr6dVpjgcWKdfJRev
	iYiEpBD8jq+1jERjadXWmGNTvvFF4ygxdV+3Ju0xJgS9rALrKd/TLbTq0u6tOKOtjNEQr0TzT6b
	Ux2A2gDNMaFbNagMhZDKJ24V5RX1J2POlWz/TOXjF4XVMWhl2Y5RIFUOH02repfUitpESavzSDr
	Oi77g==
X-Received: by 2002:a05:600c:8b6e:b0:48a:6fd4:d3d3 with SMTP id 5b1f17b1804b1-48fe61ed21amr230874125e9.20.1779098570729;
        Mon, 18 May 2026 03:02:50 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:662:5a01:509f:d84a:9a5e:1263? ([2a0a:ef40:662:5a01:509f:d84a:9a5e:1263])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4900c16c744sm59124165e9.3.2026.05.18.03.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 03:02:50 -0700 (PDT)
Message-ID: <e4b85275-e6e8-4610-a452-e25a554a3726@gmail.com>
Date: Mon, 18 May 2026 11:02:48 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: git rebase --continue segfault
To: Alex Naidenkov <admin@leshe4ka.ru>, git@vger.kernel.org,
 Junio C Hamano <gitster@pobox.com>
References: <eaa03980-fbce-4402-88b8-0f260f2927ab@leshe4ka.ru>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>
In-Reply-To: <eaa03980-fbce-4402-88b8-0f260f2927ab@leshe4ka.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Alex

On 17/05/2026 10:19, Alex Naidenkov wrote:
> Hi, ive encountered on segfault when ran `git rebase --continue`. 
> Hopefully this would help
> 
> - i was in the middle of big rebase
> 
> - entered pin for signing commit
> - segfault happened

Thanks for reporting this, if you run

	ls -l "$(git rev-parse --git-path objects/pack)"/*.pack

How many pack files does it show? If there is only a single pack file 
with a modification time matching when the rebase failed then I suspect 
you've been bitten by the bug fixed in [1] which corrupted my repository 
over the weekend (ironically I was rebasing my local git to include that 
bug fix, but accidentally started the rebase with a build including that 
bug). "git rebase" runs "git commit" to reword commits and commit 
conflict resolutions and each time "git commit" calls 
run_auto_maintenance() so with that bug it stands a good chance of 
starting parallel repacks.

Hopefully there will be a 2.54.1 release containing the fix soon

Phillip

[1] 
https://lore.kernel.org/20260513-pks-maintenance-fix-lock-with-detach-v3-0-f27a1ac82891@pks.im

> ```
> 
> Debuginfo Build ID: d98c557aaa4baa2e6da8a12cf5a76d241c5af104
> ```
> 
> ```
> 
> gef➤  bt
> #0  repo_parse_tree_gently (r=0x557e86b43780 <the_repo.lto_priv>, 
> item=0x0, quiet_on_missing=0x0) at /usr/src/debug/git/git/tree.c:193
> #1  0x0000557e869161bd in repo_parse_tree (r=<optimized out>, 
> item=<optimized out>) at /usr/src/debug/git/git/tree.h:28
> #2  collect_merge_info (opt=0x557e9bf793b0, merge_base=<optimized out>, 
> side1=<optimized out>, side2=<optimized out>) at /usr/src/debug/git/git/ 
> merge-ort.c:1745
> #3  merge_ort_nonrecursive_internal (opt=opt@entry=0x7ffe20ae9eb0, 
> merge_base=<optimized out>, merge_base@entry=0x557e9bf793b0, 
> side1=side1@entry=0x557e9bf79430, side2=<optimized out>,
>      side2@entry=0x0, result=result@entry=0x7ffe20ae9e80) at /usr/src/ 
> debug/git/git/merge-ort.c:5256
> #4  0x0000557e8691a6b8 in merge_incore_nonrecursive (opt=0x7ffe20ae9eb0, 
> merge_base=0x557e9bf793b0, side1=0x557e9bf79430, side2=0x0, 
> result=0x7ffe20ae9e80)
>      at /usr/src/debug/git/git/merge-ort.c:5419
> #5  0x0000557e869e0e8a in do_recursive_merge (r=r@entry=0x557e86b43780 
> <the_repo.lto_priv>, base=base@entry=0x557e9bf8b800, 
> next=next@entry=0x557e9bf8b850,
>      base_label=base_label@entry=0x557e9bf627e0 "parent of db33c0f 
> (fix)", next_label=next_label@entry=0x557e9bfab130 "db33c0f (fix)", 
> head=head@entry=0x7ffe20aea160,
>      msgbuf=0x557e9bf1b710, opts=0x7ffe20aeb990) at /usr/src/debug/git/ 
> git/sequencer.c:782
> #6  0x0000557e869e355e in do_pick_commit (r=0x557e86b43780 
> <the_repo.lto_priv>, item=<optimized out>, opts=0x7ffe20aeb990, 
> final_fixup=0x0, check_todo=0x7ffe20aea35c)
>      at /usr/src/debug/git/git/sequencer.c:2445
> #7  0x0000557e869ebe75 in pick_one_commit (r=<optimized out>, 
> todo_list=0x7ffe20aeb330, opts=<optimized out>, 
> check_todo=0x7ffe20aea35c, reschedule=<synthetic pointer>)
>      at /usr/src/debug/git/git/sequencer.c:4921
> #8  pick_commits (r=0x557e86b43780 <the_repo.lto_priv>, 
> todo_list=<optimized out>, opts=0x7ffe20aeb990) at /usr/src/debug/git/ 
> git/sequencer.c:5030
> #9  0x0000557e869ef336 in sequencer_continue (r=<optimized out>, 
> opts=<optimized out>) at /usr/src/debug/git/git/sequencer.c:5487
> #10 0x0000557e867d536e in run_sequencer_rebase (opts=0x7ffe20aeb7a0) at 
> builtin/rebase.c:376
> #11 run_specific_rebase (opts=0x7ffe20aeb7a0) at builtin/rebase.c:755
> #12 cmd_rebase (argc=<optimized out>, argv=<optimized out>, 
> prefix=<optimized out>, repo=<optimized out>) at builtin/rebase.c:1910
> #13 0x0000557e866e9e65 in run_builtin (p=0x557e86b35530 
> <commands.lto_priv+2352>, argc=<optimized out>, argv=<optimized out>, 
> repo=0x557e86b43780 <the_repo.lto_priv>)
>      at /usr/src/debug/git/git/git.c:506
> #14 handle_builtin (args=args@entry=0x7ffe20aed760) at /usr/src/debug/ 
> git/git/git.c:780
> #15 0x0000557e866eb30c in run_argv (args=0x7ffe20aed760) at /usr/src/ 
> debug/git/git/git.c:863
> #16 cmd_main (argc=<optimized out>, argv=<optimized out>) at /usr/src/ 
> debug/git/git/git.c:984
> #17 0x0000557e866e77e4 in main (argc=0x3, argv=0x7ffe20aeda58) at /usr/ 
> src/debug/git/git/common-main.c:9
> 
> ```
> ```
> 
> [System Info]
> git version:
> git version 2.54.0
> cpu: x86_64
> built from commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> rust: enabled
> gettext: enabled
> libcurl: 8.19.0
> OpenSSL: OpenSSL 3.6.2 7 Apr 2026
> zlib-ng: 2.3.3
> SHA-1: SHA1_DC
> SHA-256: SHA256_BLK
> default-ref-format: files
> default-hash: sha1
> uname: Linux 7.0.5-arch1-1 #1 SMP PREEMPT_DYNAMIC Fri, 08 May 2026 
> 09:29:23 +0000 x86_64
> compiler info: gnuc: 15.2
> libc info: glibc: 2.43
> $SHELL (typically, interactive shell): /usr/bin/zsh
> 
> 
> [Enabled Hooks]
> pre-commit
> ```
> 
> 

