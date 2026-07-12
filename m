Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6F121255A
	for <git@vger.kernel.org>; Sun, 12 Jul 2026 04:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783829061; cv=none; b=kn4EsyIfP+2updP7xA9EYxENzjsc0lNT/DbLk8C+eucDvApnGCv4E1/sSmgzicO6maasb+w5zWpMAssAOu9YnP+T65q9wPephG68h7ZtjaN2Vfiq6XW+s6YZIdHFyzK4AET6evM26nxIH7+t59wrJuvjJfjUc/4lnW8HurDePAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783829061; c=relaxed/simple;
	bh=y3HedzznvjpENsbfkYX1Y8Hk79AGM+Hf2gEofGfkRWc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SPX8Hb4AwnEDW4xA6dK26Kl6feuVcZlOprTAzBSI6Xwv4YgRAHLmX3aWAUxYsn2LCt61pcCg1z3dX+eNJNpbBPnQeD/hgvmipffUrLAUl2M/rQnjjvI4memXR7z/Rbz9BZYfblboDZReIZ5//swH9cLmD3Mg7iK+hZsa8RZPLoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqyMuWZG; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqyMuWZG"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-ca00f126b7eso1173757a12.2
        for <git@vger.kernel.org>; Sat, 11 Jul 2026 21:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783829060; x=1784433860; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:to
         :from:date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NgDcUWCBzjxQUjclG36SdB4+Vq+n3qde8cz6soiLBKc=;
        b=kqyMuWZGltxMpWYf+QGwJzqmLWY0xY2Ge/AUu7MJ2aIFJVnAT+P4d3Cgx3JXuFN/KN
         mmtHYQNJYYrqbmVRDkWGNL4nBYEyEfN29eOFmAFu+vcLc+RrSFy4ojVZl8gDtRcUxpVc
         CmX0dg/QB00oXAAtHkB32s7jyjvgm/oAUTkSDFYat5bvtoRmsy3BFgYokCI9+7KDy79k
         MJ6Wo6JzKGevKat8j6cZ5Zd3kIeN+QB6FwzWD2ze0utM29XK3DVIyWwXOC6CLGTEXWBn
         ++BL0lIB82wdUJ39ObQbpP+Vizlv00LAK7BFpmT2fsS2xb2rlkpVUIcWa2G4qnIxa/S4
         bcCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783829060; x=1784433860;
        h=content-disposition:content-type:mime-version:message-id:subject:to
         :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NgDcUWCBzjxQUjclG36SdB4+Vq+n3qde8cz6soiLBKc=;
        b=REuNwfdipiKNhP4jVn30eVH8doX7cERvxQiEOy9fr5elJezSziWS51V3DnATF37niP
         ztY7LJoBfJUFC+/7jkEBQD7jFrQfbKtwSnU3/i5AcaNoFXkJeVqON1QUyAUyrcIgdRtM
         KD7dJnK53hY/NPRFicX7m+Dq3ZORvtW/Vgj9tt/9DPsFOHJlafyp56EvXYpLhiphHMmS
         H9OXcd8piz+LV8f0eyqmQHp5RLPycJPMzNSUyAvLB247v4ulwVGfwhtD4hqiaXYKhVea
         MSpHn9/hdZ+bEgSNfWTyKqYk/chM/KkJUJm7Bdvx2IeWLpSyb3gmpoLP7CWNKhUEYt5c
         ZldA==
X-Gm-Message-State: AOJu0Yz6ffO9CBOBVBoIAFIAxaPRNB1xh2Up1RdEf5ESRT6jrxN1C2uH
	G/qvWdgoJMyIcTb4PfbUoXzX4CDrcn6uSWP5FrmqCeamaXSgAXsFBPtB2BurZA==
X-Gm-Gg: AfdE7cmRfoWVrWTy8schOkVvltesRJUtpz56BprHq2qaL2Z9jJZxfJ11lr8Tdsi2Nfm
	EuW8L+fUMZypnQmjUtNKP8p6voz1Mysq09NywFaa/O9XAu2LoyoCxiATP4P1aKozTaU1ULJQRIE
	+cLba83iJFA2UYZ7f/II4QsjEexCdFn73iZJ61ZjFs+kNSo0pC5oQvEYf7t1ct4EHT4zzyjmKsB
	9ywoo4NAkYzVbV0CocvSQiapAMMp4aQGnID3ttW16yaASvijDXQKNHsl8mAJH5a+yBmg9s1OWgi
	ugLzw3hC5JOBJ6Mz+GW/L2VZVZsClShKicSGqoIUTObQnkDRHjne4n/vCVYzbiE/7TpL8SnPVUT
	/DwBCW+zT6Lmon7Qe6mru1uPKehsTF347Oue0cRw+Cv1QVsDrvURZCBtsO4bMrNSOHxYjIry8mz
	UrnWYcDPSQDW0=
X-Received: by 2002:a05:6a00:4b55:b0:848:5bd5:6e86 with SMTP id d2e1a72fcca58-8488978c0d5mr4340805b3a.53.1783829059600;
        Sat, 11 Jul 2026 21:04:19 -0700 (PDT)
Received: from localhost ([14.191.220.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8482b333d4fsm8003916b3a.54.2026.07.11.21.04.18
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 21:04:18 -0700 (PDT)
Date: Sun, 12 Jul 2026 11:04:17 +0700
From: =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>
To: git@vger.kernel.org
Subject: Git 2.55.0/next/seen NO_RUST fsmonitor BUG_vfl crash
Message-ID: <alMSIcJRZ6fBQ4vz@danh.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

With Git 2.55.0 built without Rust (NO_RUST = Yes), also observed
with seen and next branches.

Running ./t7527-builtin-fsmonitor.sh will run into crash on:

not ok 43 - Matrix[uc:false][fsm:true] move_directory_up
#
#			matrix_clean_up_repo &&
#			$fn &&
#			if test $uc = false && test $fsm = false
#			then
#				git status --porcelain=v1 >.git/expect.$fn
#			else
#				git status --porcelain=v1 >.git/actual.$fn &&
#				test_cmp .git/expect.$fn .git/actual.$fn
#			fi
#

With backtrace:


#0  __pthread_kill_implementation (threadid=<optimized out>, signo=signo@entry=6, no_tid=no_tid@entry=0) at ./nptl/pthread_kill.c:44
#1  0x00007fad081c724f in __pthread_kill_internal (signo=6, threadid=<optimized out>) at ./nptl/pthread_kill.c:89
#2  0x00007fad08177fe2 in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/raise.c:26
#3  0x00007fad08160efc in __GI_abort () at ./stdlib/abort.c:73
#4  0x0000561637c48e71 in BUG_vfl (file=0x561637fc98b0 "compat/fsmonitor/fsm-listen-linux.c", line=144, fmt=0x561637fc9890 "double remove of watch for '%s'", params=0x7fad03929b38)
    at usage.c:343
#5  BUG_fl (file=file@entry=0x561637fc98b0 "compat/fsmonitor/fsm-listen-linux.c", line=line@entry=144, fmt=fmt@entry=0x561637fc9890 "double remove of watch for '%s'") at usage.c:360
#6  0x0000561637f490bf in remove_watch (w=0x561675350240, data=data@entry=0x56167533b050) at compat/fsmonitor/fsm-listen-linux.c:144
#7  0x0000561637f49f22 in rename_dir (cookie=<optimized out>, path=0x561675352260 "/home/sgn/src/git/t/trash directory.t7527-builtin-fsmonitor/T1/T3", data=<optimized out>)
    at compat/fsmonitor/fsm-listen-linux.c:246
#8  process_event (path=0x561675352260 "/home/sgn/src/git/t/trash directory.t7527-builtin-fsmonitor/T1/T3", event=0x7fad03929de0, batch=<synthetic pointer>, cookie_list=0x7fad03929d60,
    state=0x7ffdb01840c0) at compat/fsmonitor/fsm-listen-linux.c:559
#9  handle_events (state=state@entry=0x7ffdb01840c0) at compat/fsmonitor/fsm-listen-linux.c:661
#10 0x0000561637f4a73f in fsm_listen__loop (state=state@entry=0x7ffdb01840c0) at compat/fsmonitor/fsm-listen-linux.c:728
#11 0x0000561637ca8e65 in fsm_listen__thread_proc (_state=0x7ffdb01840c0) at builtin/fsmonitor--daemon.c:1194
#12 0x00007fad081c5579 in start_thread (arg=<optimized out>) at ./nptl/pthread_create.c:448
#13 0x00007fad0823f858 in __GI___clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:78


[System Info]
git version:
git version 2.55.0.551.g10ab9bd069f7d
cpu: x86_64
built from commit: 10ab9bd069f7d523b2392c7b471a6a7af88a5740
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
rust: disabled
feature: fsmonitor--daemon
gettext: enabled
libcurl: 8.21.0
OpenSSL: OpenSSL 3.6.3 9 Jun 2026
zlib: 1.3.2
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Linux 7.0.14_1 #1 SMP PREEMPT_DYNAMIC Sat Jun 27 23:57:22 UTC 2026 x86_64
compiler info: gnuc: 14.2
libc info: glibc: 2.41
$SHELL (typically, interactive shell): /bin/zsh

-- 
Danh
