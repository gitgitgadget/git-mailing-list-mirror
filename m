Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F51B3771C
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 14:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712413751; cv=none; b=SYnqt25hw3DICm7SKgUXOPCLCDQIpO3yoAOWUu6+x5cohQiEoItKdImBD93k5z7ZvH7QP4wKijR1zCZGV8y+SDUfEiO/IZE2zlinc7mJACH9qPL6Jshv+cX1z2Q6WD5dTt9pVQn6UQqRy0rmbzziIDx2pp7NAtQ/BjQBzTRwWtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712413751; c=relaxed/simple;
	bh=2R3PWY9vsAYgg8EewIulwc/ZMJ8CXwBLyLmle3cfIQc=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=ldz9X/cOoHpNrUssnc5GAMF8mlY26DPZadX0w5MTohekDvmZERL7UZPRmGzY6zoQ9ERABRibiZulFICqgzLc8id2X1UVnAWT0gzhngl1GuNEURzT8Y9TwirulwvuXWOS4ZMWfA1h0DqxPJHW6SkGazRKyf+bAhL+CrWh72jHnj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKzHfY5p; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKzHfY5p"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33ff53528ceso2299770f8f.0
        for <git@vger.kernel.org>; Sat, 06 Apr 2024 07:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712413748; x=1713018548; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:content-language:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uY+2ZxobusVxSavx6qkTwuGz2esKFUTnJppntr/6I6Q=;
        b=GKzHfY5pHgy6qvnZPWKXzAdQJsCSbzswPVWsqNFE9KMUQree+IiaGXkQBEAkBkH0Lf
         mjywfLO9/Cd3Ga9YNKx1tFk57qrASKoJN4ZV6JVpxiNp6X8mT5v7Zw/wMQ0rxVJ3GFcO
         8DJoJSlWu5IaRDxC/obOVltIYW0O+AZJhwHAVmFuWC28Ok1ivenlUWuF5MAbonOl5gYA
         fxvDCQdZJ9OO1cfb168tcVwnwOYtVpnyDQMas0S4nKf/qxEKrW5L1VE5oQMSMNd0X2cR
         8h+MFTzbh8FpYFUmlhjYjLCi20mPWL8l0uaUg2tXsGcja4HurudEpWkepYHrjQSi0Rnv
         KxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712413748; x=1713018548;
        h=content-transfer-encoding:subject:to:content-language:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uY+2ZxobusVxSavx6qkTwuGz2esKFUTnJppntr/6I6Q=;
        b=ZVhfCt1yhAxzRRop2Ss7/oGKyd9wpJ/AAZiByqr2jktGNnK5x5LKZhKMWY+VTk7o4B
         SD6WuBZQX0j4gx+0iFsfXALOAeelWeunlxc/XByKpyvxrjftTV4e/XbkrATEa77MjCbb
         gq1SYWEa4LR2hlRKhzrm3jSym82CSI3ZsuThzfXLuUzk9PVf8n77Kfa98NOnlW0VBBfw
         meOiYGKN8jJ4RuDGkqgprOfwvITkz6QjnoO43sQ+Vkpf3cbHDyrxXmd6q0kseUDJJUpB
         ntjnhJrOk/XXNpTR/u8pcwfbvkBi400wAa/AoCsGmxje0roJlncfhzXhpzPMOnEeV4Ps
         n3eA==
X-Gm-Message-State: AOJu0YxtPymRTXZmfH9pCLC99emazfmVAOxPnxXnE2Qxdafb4DNocWT3
	bnD6zWkZX/Rlp+dPajL13nzyhBS9h8MAM0NYO8rxEVeXACZvLK87lvoWi5fz
X-Google-Smtp-Source: AGHT+IE+vBn8M7UyCWoPh6dMy6Ex88FtfljMJ44BLe0horbY+R1mqxj1otW+oRhfrAXZ3n23KCu50Q==
X-Received: by 2002:a5d:55d0:0:b0:343:8a84:85f0 with SMTP id i16-20020a5d55d0000000b003438a8485f0mr2740647wrw.29.1712413748378;
        Sat, 06 Apr 2024 07:29:08 -0700 (PDT)
Received: from gmail.com (4.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.4])
        by smtp.gmail.com with ESMTPSA id p17-20020adfe611000000b003433e5cab4bsm4559866wrm.103.2024.04.06.07.29.07
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Apr 2024 07:29:08 -0700 (PDT)
Message-ID: <f4af1e88-5bd9-4b3c-8691-84dbf0ca3ee2@gmail.com>
Date: Sat, 6 Apr 2024 16:29:04 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
To: Git List <git@vger.kernel.org>
Subject: [PATCH 0/4] fix a leak with excludes_file
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Having ...
	[core]
        	excludesFile = /some/global/path/.gitignore

... this triggers a leak:

	$ GIT_EDITOR=: git rebase -i HEAD
	Successfully rebased and updated detached HEAD.

	=================================================================
	==...==ERROR: LeakSanitizer: detected memory leaks

	Direct leak of 60 byte(s) in 1 object(s) allocated from:
	    #0  ... in realloc 
	    #1  ... in xrealloc wrapper.c:137
	    #2  ... in strbuf_grow strbuf.c:112
	    #3  ... in strbuf_add strbuf.c:311
	    #4  ... in strbuf_addstr strbuf.h:310
	    #5  ... in interpolate_path path.c:771
	    #6  ... in git_config_pathname config.c:1352
	    #7  ... in git_default_core_config config.c:1588
	    #8  ... in git_default_config config.c:1791
	    #9  ... in rebase_config builtin/rebase.c:801
	    #10 ... in configset_iter config.c:2161
	    #11 ... in repo_config config.c:2540
	    #12 ... in git_config config.c:2663
	    #13 ... in cmd_rebase builtin/rebase.c:1187
	    #14 ... in run_builtin git.c:469
	    #15 ... in handle_builtin git.c:724
	    #16 ... in run_argv git.c:788
	    #17 ... in cmd_main git.c:923
	    #18 ... in main common-main.c:62

It happens because we parse twice the configuration: 

	$ GIT_EDITOR=: gdb --ex "break git_config" --ex "run" --args git rebase -i HEAD
	(gdb) bt
	#0  git_config () at config.c:2663
	#1  ... in cmd_rebase () at builtin/rebase.c:1187
	#2  ... in run_builtin () at git.c:469
	#3  ... in handle_builtin () at git.c:724
	#4  ... in run_argv () at git.c:788
	#5  ... in cmd_main () at git.c:923
	#6  ... in main () at common-main.c:62
	(gdb) c
	(gdb) bt
	#0  git_config () at config.c:2663
	#1  ... in sequencer_init_config () at sequencer.c:291
	#2  ... in get_replay_opts () at builtin/rebase.c:161
	#3  ... in do_interactive_rebase () at builtin/rebase.c:271
	#4  ... in run_sequencer_rebase () at builtin/rebase.c:339
	#5  ... in run_specific_rebase () at builtin/rebase.c:705
	#6  ... in cmd_rebase () at builtin/rebase.c:1830
	#7  ... in run_builtin () at git.c:469
	#8  ... in handle_builtin () at git.c:724
	#9  ... in run_argv () at git.c:788
	#10 ... in cmd_main () at git.c:923
	#11 ... in main () at common-main.c:62

We call twice to git_config(): first to get the main git-branch(1) options,
and second to get the ones related to the sequencer.

Due to how git_config() works the global configuration is parsed twice,
therefore if core.excludesFile is set, it will be allocated twice.

A free() before the git_config_pathname() can be a simpler fix, but I
think this series offers a better approach, perhaps applicable to other
potential similar leaks.

Rubén Justo (4):
  path.c: introduce strbuf_interpolate_path
  config.c: introduce git_config_strbuf_pathname
  environment.c: convert excludes_file to struct strbuf
  t7300: mark as leak-free

 config.c         | 12 +++++++++++-
 config.h         |  2 ++
 dir.c            | 13 +++++++++----
 environment.c    |  2 +-
 environment.h    |  2 +-
 path.c           | 20 ++++++++++++++------
 path.h           |  1 +
 t/t7300-clean.sh |  1 +
 8 files changed, 40 insertions(+), 13 deletions(-)

-- 
2.44.0.697.g9b33b46f29

