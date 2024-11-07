Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0EB218306
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 22:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731018287; cv=none; b=ouk4IGdPM0tmcmzXQrSE/LUq1woSD0R8NbpV2lgyYahoZtiD7KYBu+rRYWGH41HUtUsigCey5+su3itKrIYeuOOD3IBMrtnGtxq6hkll2z2THOieYw+35fOb8eNR3/sx0zu5JM15O7owgPZhn97wyJa39r61yg7lZeDr2XVpIJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731018287; c=relaxed/simple;
	bh=mLowo3cF+mRnBHPjcUaOwl3EjLX/afZ6wXmuidrAIBU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=N1TFKfZfs9pWJzy6/ID+Rej9oKhT00wY1wqa7bPx8hxwPTz9q/dpm8EA4wtd9za9Ux8gva4CHN4obBhRdjBAjLqzwsqadwwdDFUy3Mo4qsR12Z+XHsTs/H3Wn87eeJ+y6bYFw0XrcGjLcs+npS6obWubznCghSriHgaBRReqOI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTj8aB8q; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTj8aB8q"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-84fc818f518so507556241.2
        for <git@vger.kernel.org>; Thu, 07 Nov 2024 14:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731018285; x=1731623085; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mLowo3cF+mRnBHPjcUaOwl3EjLX/afZ6wXmuidrAIBU=;
        b=NTj8aB8q2Ub/450uNfdkOH+hIHJFEPFZohaMwW5r9IMLZlC+TOFVC+ve5eofwWwGZC
         yb0I0r4Gq00UIAu2efUCpCbb36QMHCzXFLNAUlGNjbqHvtITplw0aPgRJGldOTndX/mQ
         eBFqN4sJk4v40Dxi53TFnSzP/R+xGjjFvPOkSFko2Wxwlcp1jj+DTRKIze+O+TyuqgTD
         /ugpubOBns6hAGwrPdS9bFjZCEwQcCCI9zA+sbnMZJLGvSOsZOCV8G2sMOBepkIxh1ID
         /h2V1lTQ3sdFo7JfuI0O8keRfh5owz4FTT8fw2LsGaOkXpxEIdnwph5WULJJ2t3A3fWU
         nq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731018285; x=1731623085;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mLowo3cF+mRnBHPjcUaOwl3EjLX/afZ6wXmuidrAIBU=;
        b=XnRN91r71IHYCRgvWljjXUfSONjRnm6GJRQPVQXSjEdIvU5b3yg7ZYhprAOFkt4b7v
         5ieILRVKkwaCmimx3PhBfMbcior+u/JCdB0mXEpHaUlBriNAvmyvXzAG8EUUuhfzznR8
         qVOyz+wfuACk62075Gmd5JFvcA3YTPOqGA70ZZ/A6LljIerzOWfAXtqBBjm9u5E8AlIC
         +FEWDLAPdXbQaZ/4Pb8LGvw9TKQ0t+t0AYUJ0njLIuHr1wsGoQI3RXo6xXGm8jI/Gl2F
         N2RrK+ewJvWgc+/DGz8nDbd+VC16kXw5/wNysG4tYjTCtBPE08dGKfKo6i7G/QVXoSAK
         0afA==
X-Gm-Message-State: AOJu0Yzb2YyYuHUR2JKI8/7SVD8Bo459Pu/ADbhOb8b/ApaNoVZV9q8X
	m9Ozsre/cYVb+vXZhhT4A/GclvLDNPWLB3AMxTmZErTYVNjnbGtgimuQbHIG8teBRwJ7+I97fDu
	NKM0BszBHhf3URdZdUedfsaJQog5yMV5e
X-Google-Smtp-Source: AGHT+IEzq66pJh7eJr8PwJSwCU/yJHJ3wrDHTgU+Yfbabi0gv87WevKrRwmSKiqAhkaXlfJxNgnWbjCKVIyvcMiYW6E=
X-Received: by 2002:a05:6102:26c4:b0:4a3:db98:4458 with SMTP id
 ada2fe7eead31-4aae1634785mr764300137.18.1731018284979; Thu, 07 Nov 2024
 14:24:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Evangeline Rome <kolya007.klass@gmail.com>
Date: Fri, 8 Nov 2024 01:24:29 +0300
Message-ID: <CAFBPeVD7pSOZkaCs_sWfhz6A7EWrV1SmLcCxVErK6GEs7KeYbQ@mail.gmail.com>
Subject: Crash report: git maintenance start/stop
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

What did you do before the bug happened? (Steps to reproduce your issue)

I'm sorry but i can't remember exactly. I learned about cool new feature ca=
lled
maintenance and tried to apply it for every cloned local repo I have
using shell scripts. something went wrong. I'm not sure if its my fault
or not. I tried to reproduce it:

```bash
cd $(mktemp -d);
git init;
echo '# header' >> ./readme;
git add .;
git commit -m 'initial commit';
echo 'line 2' >> ./readme;
git add .;
git commit -m 'second commit';
# All commands above prepare basic repo successfully

# I initially have no timers
/sbin/systemctl --user list-timers --all;
# output:
# NEXT LEFT LAST PASSED UNIT ACTIVATES
# 0 timers listed.

# And also I initially have no cron jobs
crontab -l
# output:
# no crontab for nikel


# git maintenance start crashes first time:
GIT_TRACE=3D1 git maintenance start;
# output:
# 00:11:17.328757 git.c:479 trace: built-in: git maintenance start
# 00:11:17.328808 run-command.c:666 trace: run_command: systemctl
--user list-timers
# 00:11:17.328835 run-command.c:758 trace: start_command:
/sbin/systemctl --user list-timers
# 00:11:17.336026 run-command.c:666 trace: run_command: systemctl
--user list-timers
# 00:11:17.336066 run-command.c:758 trace: start_command:
/sbin/systemctl --user list-timers
# 00:11:17.342491 run-command.c:666 trace: run_command:
'H=EF=BF=BDLH=EF=BF=BD=EF=BF=BDH=EF=BF=BD=EF=BF=BD=EF=BF=BDL9=EF=BF=BDr0H=
=EF=BF=BDCH=EF=BF=BD=CB=B7' -l
# free(): invalid pointer
# Aborted (core dumped)

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# !!!!!! Notice those strange symbols: 'H=EF=BF=BDLH=EF=BF=BD=EF=BF=BDH=EF=
=BF=BD=EF=BF=BD=EF=BF=BDL9=EF=BF=BDr0H=EF=BF=BDCH=EF=BF=BD=CB=B7'!!!!!!
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

# After the crash, git maintenance with {start,stop} fails with
# different error

# No new timers were created
/sbin/systemctl --user list-timers --all;
# output:
# NEXT LEFT LAST PASSED UNIT ACTIVATES
# 0 timers listed.

# No new cron jobs were created
crontab -l
# output:
# no crontab for nikel

# can't stop because it didn't start (?). Here you can see new error
GIT_TRACE=3D1 git maintenance stop;
# output:
# After that running git maintenance start fails with different error:
# 00:13:48.005648 git.c:479 trace: built-in: git maintenance stop
# error: another process is scheduling background maintenance

# restarting also doesn't work because previous start created lock file
# `error: another process is scheduling background maintenance` is forever
GIT_TRACE=3D1 git maintenance start;
# output:
# 00:14:31.483902 git.c:479 trace: built-in: git maintenance start
# 00:14:31.483951 run-command.c:666 trace: run_command: systemctl
--user list-timers
# 00:14:31.483990 run-command.c:758 trace: start_command:
/sbin/systemctl --user list-timers
# 00:14:31.491288 run-command.c:666 trace: run_command: systemctl
--user list-timers
# 00:14:31.491320 run-command.c:758 trace: start_command:
/sbin/systemctl --user list-timers
# error: another process is scheduling background maintenance
# fatal: failed to set up maintenance schedule

# No new timers were created
/sbin/systemctl --user list-timers --all;
# output:
# NEXT LEFT LAST PASSED UNIT ACTIVATES
# 0 timers listed.

# No new cron jobs were created
crontab -l
# output:
# no crontab for nikel

# After first crash it forever fails with "another process is schedul..."
# until I delete lock file
rm ./.git/objects/schedule.lock;

# then `GIT_TRACE=3D1 git maintenance start` is able to crash with the same
# useless error again
# Here are the most detailed logs I know how to create:
GIT_TRACE=3D1 gdb --args git maintenance start --scheduler=3Dsystemd-timer;
# output:
# GNU gdb (GDB) 15.2
# Reading symbols from git...
#
# (gdb) run
#
# Starting program: /usr/bin/git maintenance start --scheduler=3Dsystemd-ti=
mer
# [Thread debugging using libthread_db enabled]
# Using host libthread_db library "/usr/lib/libthread_db.so.1".
# 00:32:49.043634 git.c:479 trace: built-in: git maintenance start
--scheduler=3Dsystemd-timer
# 00:32:49.043720 run-command.c:666 trace: run_command: systemctl
--user list-timers
# 00:32:49.043760 run-command.c:758 trace: start_command:
/sbin/systemctl --user list-timers
# [Detaching after fork from child process 30180]
# 00:32:49.053174 run-command.c:666 trace: run_command:
'H=EF=BF=BDLH=EF=BF=BD=EF=BF=BDH=EF=BF=BD=EF=BF=BD=EF=BF=BDL9=EF=BF=BDr0H=
=EF=BF=BDCH=EF=BF=BD=CB=B7' -l
# free(): invalid pointer
#
# Program received signal SIGABRT, Aborted.
# __pthread_kill_implementation (threadid=3D<optimized out>,
signo=3Dsigno@entry=3D6, no_tid=3Dno_tid@entry=3D0) at pthread_kill.c:44
# 44 return INTERNAL_SYSCALL_ERROR_P (ret) ? INTERNAL_SYSCALL_ERRNO (ret) :=
 0;
#
# (gdb) where
#
# #0 __pthread_kill_implementation (threadid=3D<optimized out>,
signo=3Dsigno@entry=3D6, no_tid=3Dno_tid@entry=3D0) at pthread_kill.c:44
# #1 0x00007ffff7d7c463 in __pthread_kill_internal
(threadid=3D<optimized out>, signo=3D6) at pthread_kill.c:78
# #2 0x00007ffff7d23120 in __GI_raise (sig=3Dsig@entry=3D6) at
../sysdeps/posix/raise.c:26
# #3 0x00007ffff7d0a4c3 in __GI_abort () at abort.c:79
# #4 0x00007ffff7d0b354 in __libc_message_impl
(fmt=3Dfmt@entry=3D0x7ffff7e992f5 "%s\n") at
../sysdeps/posix/libc_fatal.c:132
# #5 0x00007ffff7d86765 in malloc_printerr
(str=3Dstr@entry=3D0x7ffff7e97082 "free(): invalid pointer") at
malloc.c:5772
# #6 0x00007ffff7d88c4c in _int_free (av=3D<optimized out>,
p=3Dp@entry=3D0x555555822b16 <strbuf_add+38>, have_lock=3Dhave_lock@entry=
=3D0)
at malloc.c:4507
# #7 0x00007ffff7d8b5ce in __GI___libc_free
(mem=3Dmem@entry=3D0x555555822b26 <strbuf_add+54>) at malloc.c:3398
# #8 0x00005555555d3ec8 in is_crontab_available () at builtin/gc.c:2349
# #9 0x00005555555dc248 in update_background_schedule
(opts=3Dopts@entry=3D0x7fffffffd0cc, enable=3Denable@entry=3D1) at
builtin/gc.c:2897
# #10 0x00005555555dc46d in maintenance_start (argc=3D<optimized out>,
argv=3D<optimized out>, prefix=3D<optimized out>) at builtin/gc.c:2937
# #11 0x00005555555cf61f in cmd_maintenance (argc=3D<optimized out>,
argv=3D0x7fffffffda20, prefix=3D0x0, repo=3D<optimized out>) at
builtin/gc.c:2984
# #12 0x000055555555e454 in run_builtin (p=3D0x55555596efd0
<commands.lto_priv+1584>, argc=3D3, argv=3D0x7fffffffda20,
repo=3D0x55555597de40 <the_repo.lto_priv>) at
/usr/src/debug/git/git-2.47.0/git.c:483
# #13 handle_builtin (argc=3D3, argv=3D0x7fffffffda20) at
/usr/src/debug/git/git-2.47.0/git.c:749
# #14 0x000055555555ead9 in run_argv (argcp=3D0x7fffffffd7cc,
argv=3D0x7fffffffd7f0) at /usr/src/debug/git/git-2.47.0/git.c:819
# #15 0x00005555555597eb in cmd_main (argc=3D<optimized out>,
argv=3D<optimized out>) at /usr/src/debug/git/git-2.47.0/git.c:954
# #16 main (argc=3D<optimized out>, argv=3D<optimized out>) at
/usr/src/debug/git/git-2.47.0/common-main.c:64
#
# (gdb) quit
```

I hope it would be helpful. Let me know if you need anything else

What did you expect to happen? (Expected behavior)

`git maintenance start` doesn't crash.

What happened instead? (Actual behavior)

`git maintenance start` crashes.

What's different between what you expected and what actually happened?

Crashing vs not crashing.

[System Info]
git version:
git version 2.47.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
libcurl: 8.10.1
OpenSSL: OpenSSL 3.3.2 3 Sep 2024
zlib: 1.3.1
uname: Linux 6.11.6-arch1-1 #1 SMP PREEMPT_DYNAMIC Fri, 01 Nov 2024
03:30:41 +0000 x86_64
compiler info: gnuc: 14.2
libc info: glibc: 2.40
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
