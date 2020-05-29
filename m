Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03ABC433E0
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A77B32072D
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEraI1dX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgE2Ih3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 04:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgE2Ih2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 04:37:28 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4725BC03E969
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:37:28 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id l10so2464353wrr.10
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=iIUNTzQRAT8cNIRuwjCAO7B6pkGngE9B4eiQyMNETII=;
        b=XEraI1dXZgArI2+OB2WJFxXVGTA9Qk3yDnWIqwRgzsr8jHa/xD8RN5FzrDGpZT8ihQ
         LeMLaNP0b0opiDlOVPIYlnlpDAtuJ4AKbUT14ml7z+rMImIaU/UYDUR711MiVhxU/iGH
         lYOzDrhbJwyhn42nZM5RKH4XawZg5C2yV1i2UwIe4O3wnt4ecS/IFL57F6LFGxdPbt+0
         3vAsVVDbwSI2lgbIhGI7M83eeZESBMkRHIKcSTgGIINYPMS++k1JfcKzj1WzzguQxc1U
         wP8LRauFTjSBuBpe6QbVwFu09UZeid3oGIOa9//vQkVg4k3rK3cgGeWALrEaGInIcQW3
         MHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=iIUNTzQRAT8cNIRuwjCAO7B6pkGngE9B4eiQyMNETII=;
        b=biU4FpBF9cGjfVtwbePG+CXr0I1W70R6/bJ0dRxEm5iYHZzahBL3rQ+RVZ/Y2cnzDU
         DklJ43OX0P7CvdvhM2KbkdcaUnDd4ZqWYifrpLCxhLu8oaAyihQBtQARK0xhJUAOtuMp
         8gvTO/tUDJINaDnbyk0/7XwcmNFNuUtdti6taKXLIG2D6iJ1b596Cj+wbMhaANEiVM3/
         UtEh18BTfsB0NC/IPBzL6ioUyFJxgEFnavy80MSu3Top9j+j64VbfWFhrw1gvRenjUqs
         uscViHK4M0OVDvtwzAwJG+9/sy9m1FNTi9Q2Fwq5p8OMrgS7vYw8uzB/5pllXgUToVlj
         BZLg==
X-Gm-Message-State: AOAM531bp39BV+tl1JjDYMq3TMaG7w10IJftr1LsxB/b6z19Xp2vUjTa
        xuHlKqSLUQWCbAdP2vkHvlJLTghB
X-Google-Smtp-Source: ABdhPJyRrS/Jba4VEu/dhDlic1Yn6Ze+83c1ChwZwRKTLVgiUjhCJoC0jUJYi8l8n8pscJ3MrIFN3g==
X-Received: by 2002:adf:97cb:: with SMTP id t11mr7561408wrb.314.1590741446120;
        Fri, 29 May 2020 01:37:26 -0700 (PDT)
Received: from ?IPv6:2a02:c7d:ca99:ce00:3db7:e240:d1a8:b96e? ([2a02:c7d:ca99:ce00:3db7:e240:d1a8:b96e])
        by smtp.gmail.com with ESMTPSA id t14sm2406887wri.7.2020.05.29.01.37.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 01:37:25 -0700 (PDT)
To:     report.jensen@gmail.com
Cc:     git@vger.kernel.org
References: <CAHgM7c4PQQvTrfn4fqKy8evQ2ydbO7ggBn4hPUTF5e2G+ApMvQ@mail.gmail.com>
Subject: Re: Git gui freeze on ubuntu 18.04
From:   Peter Jensen <home.jensen@gmail.com>
Message-ID: <76f5b3ff-21a7-bff7-4785-b56c34eda644@gmail.com>
Date:   Fri, 29 May 2020 09:37:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAHgM7c4PQQvTrfn4fqKy8evQ2ydbO7ggBn4hPUTF5e2G+ApMvQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

strace from the very beginning until crash

-------------------------------------------------------------------------------------------------------
strace git gui
execve("/usr/bin/git", ["git", "gui"], 0x7ffc195900c8 /* 59 vars */) = 0
brk(NULL)                               = 0x55c206a34000
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or 
directory)
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or 
directory)
openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=96441, ...}) = 0
mmap(NULL, 96441, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7fa7e6533000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or 
directory)
openat(AT_FDCWD, "/usr/lib/x86_64-linux-gnu/libpcre2-8.so.0", 
O_RDONLY|O_CLOEXEC) = 3
read(3, 
"\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\360\36\0\0\0\0\0\0"..., 
832) = 832
fstat(3, {st_mode=S_IFREG|0644, st_size=530984, ...}) = 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) 
= 0x7fa7e6531000
mmap(NULL, 2626312, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 
0) = 0x7fa7e60a2000
mprotect(0x7fa7e6123000, 2093056, PROT_NONE) = 0
mmap(0x7fa7e6322000, 8192, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x80000) = 0x7fa7e6322000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or 
directory)
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libz.so.1", O_RDONLY|O_CLOEXEC) = 3
read(3, 
"\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\220\37\0\0\0\0\0\0"..., 
832) = 832
fstat(3, {st_mode=S_IFREG|0644, st_size=116960, ...}) = 0
mmap(NULL, 2212016, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 
0) = 0x7fa7e5e85000
mprotect(0x7fa7e5ea1000, 2093056, PROT_NONE) = 0
mmap(0x7fa7e60a0000, 8192, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1b000) = 0x7fa7e60a0000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or 
directory)
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libpthread.so.0", 
O_RDONLY|O_CLOEXEC) = 3
read(3, 
"\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0000b\0\0\0\0\0\0"..., 
832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=144976, ...}) = 0
mmap(NULL, 2221184, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 
0) = 0x7fa7e5c66000
mprotect(0x7fa7e5c80000, 2093056, PROT_NONE) = 0
mmap(0x7fa7e5e7f000, 8192, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x19000) = 0x7fa7e5e7f000
mmap(0x7fa7e5e81000, 13440, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7fa7e5e81000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or 
directory)
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/librt.so.1", O_RDONLY|O_CLOEXEC) = 3
read(3, 
"\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\"\0\0\0\0\0\0"..., 
832) = 832
fstat(3, {st_mode=S_IFREG|0644, st_size=31680, ...}) = 0
mmap(NULL, 2128864, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 
0) = 0x7fa7e5a5e000
mprotect(0x7fa7e5a65000, 2093056, PROT_NONE) = 0
mmap(0x7fa7e5c64000, 8192, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x6000) = 0x7fa7e5c64000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or 
directory)
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, 
"\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\260\34\2\0\0\0\0\0"..., 
832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=2030544, ...}) = 0
mmap(NULL, 4131552, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 
0) = 0x7fa7e566d000
mprotect(0x7fa7e5854000, 2097152, PROT_NONE) = 0
mmap(0x7fa7e5a54000, 24576, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1e7000) = 0x7fa7e5a54000
mmap(0x7fa7e5a5a000, 15072, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7fa7e5a5a000
close(3)                                = 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) 
= 0x7fa7e652f000
arch_prctl(ARCH_SET_FS, 0x7fa7e6530080) = 0
mprotect(0x7fa7e5a54000, 16384, PROT_READ) = 0
mprotect(0x7fa7e5e7f000, 4096, PROT_READ) = 0
mprotect(0x7fa7e5c64000, 4096, PROT_READ) = 0
mprotect(0x7fa7e60a0000, 4096, PROT_READ) = 0
mprotect(0x7fa7e6322000, 4096, PROT_READ) = 0
mprotect(0x55c204d21000, 16384, PROT_READ) = 0
mprotect(0x7fa7e654b000, 4096, PROT_READ) = 0
munmap(0x7fa7e6533000, 96441)           = 0
set_tid_address(0x7fa7e6530350)         = 21766
set_robust_list(0x7fa7e6530360, 24)     = 0
rt_sigaction(SIGRTMIN, {sa_handler=0x7fa7e5c6bcb0, sa_mask=[], 
sa_flags=SA_RESTORER|SA_SIGINFO, sa_restorer=0x7fa7e5c78890}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {sa_handler=0x7fa7e5c6bd50, sa_mask=[], 
sa_flags=SA_RESTORER|SA_RESTART|SA_SIGINFO, sa_restorer=0x7fa7e5c78890}, 
NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) = 0
prlimit64(0, RLIMIT_STACK, NULL, {rlim_cur=8192*1024, 
rlim_max=RLIM64_INFINITY}) = 0
openat(AT_FDCWD, "/dev/null", O_RDWR)   = 3
close(3)                                = 0
rt_sigprocmask(SIG_UNBLOCK, [PIPE], NULL, 8) = 0
rt_sigaction(SIGPIPE, {sa_handler=SIG_DFL, sa_mask=[PIPE], 
sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0x7fa7e56abf20}, 
{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
brk(NULL)                               = 0x55c206a34000
brk(0x55c206a55000)                     = 0x55c206a55000
stat("/usr/share/locale", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
openat(AT_FDCWD, "/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=10281936, ...}) = 0
mmap(NULL, 10281936, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7fa7e4c9e000
close(3)                                = 0
access("/etc/gitconfig", R_OK)          = -1 ENOENT (No such file or 
directory)
access("/home/peter/.config/git/config", R_OK) = -1 ENOENT (No such file 
or directory)
access("/home/peter/.gitconfig", R_OK)  = 0
openat(AT_FDCWD, "/home/peter/.gitconfig", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0775, st_size=170, ...}) = 0
fstat(3, {st_mode=S_IFREG|0775, st_size=170, ...}) = 0
read(3, "[push]\n\tdefault = current\n\n[user"..., 4096) = 170
read(3, "", 4096)                       = 0
read(3, "", 4096)                       = 0
close(3)                                = 0
getcwd("/home/peter/git/gh_code", 129)  = 24
stat("/home/peter/git/gh_code", {st_mode=S_IFDIR|0775, st_size=4096, 
...}) = 0
stat("/home/peter/git/gh_code/.git", {st_mode=S_IFDIR|0775, 
st_size=4096, ...}) = 0
lstat("/home/peter/git/gh_code/.git/HEAD", {st_mode=S_IFREG|0664, 
st_size=23, ...}) = 0
openat(AT_FDCWD, "/home/peter/git/gh_code/.git/HEAD", O_RDONLY) = 3
read(3, "ref: refs/heads/master\n", 255) = 23
read(3, "", 232)                        = 0
close(3)                                = 0
lstat("/home/peter/git/gh_code/.git/commondir", 0x7ffd14998020) = -1 
ENOENT (No such file or directory)
access("/home/peter/git/gh_code/.git/objects", X_OK) = 0
access("/home/peter/git/gh_code/.git/refs", X_OK) = 0
lstat(".git/commondir", 0x7ffd149981a0) = -1 ENOENT (No such file or 
directory)
openat(AT_FDCWD, ".git/config", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0664, st_size=834, ...}) = 0
fstat(3, {st_mode=S_IFREG|0664, st_size=834, ...}) = 0
read(3, "[core]\n\trepositoryformatversion "..., 4096) = 834
read(3, "", 4096)                       = 0
close(3)                                = 0
access("/etc/gitconfig", R_OK)          = -1 ENOENT (No such file or 
directory)
access("/home/peter/.config/git/config", R_OK) = -1 ENOENT (No such file 
or directory)
access("/home/peter/.gitconfig", R_OK)  = 0
openat(AT_FDCWD, "/home/peter/.gitconfig", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0775, st_size=170, ...}) = 0
fstat(3, {st_mode=S_IFREG|0775, st_size=170, ...}) = 0
read(3, "[push]\n\tdefault = current\n\n[user"..., 4096) = 170
read(3, "", 4096)                       = 0
read(3, "", 4096)                       = 0
close(3)                                = 0
access(".git/config", R_OK)             = 0
openat(AT_FDCWD, ".git/config", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0664, st_size=834, ...}) = 0
fstat(3, {st_mode=S_IFREG|0664, st_size=834, ...}) = 0
read(3, "[core]\n\trepositoryformatversion "..., 4096) = 834
read(3, "", 4096)                       = 0
close(3)                                = 0
stat("/usr/lib/git-core/git-gui", {st_mode=S_IFREG|0755, st_size=105779, 
...}) = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) = 0
clone(child_stack=NULL, 
flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, 
child_tidptr=0x7fa7e6530350) = 21767
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGINT, {sa_handler=0x55c204a01810, sa_mask=[INT], 
sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0x7fa7e56abf20}, 
{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGHUP, {sa_handler=0x55c204a01810, sa_mask=[HUP], 
sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0x7fa7e56abf20}, 
{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGTERM, {sa_handler=0x55c204a01810, sa_mask=[TERM], 
sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0x7fa7e56abf20}, 
{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGQUIT, {sa_handler=0x55c204a01810, sa_mask=[QUIT], 
sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0x7fa7e56abf20}, 
{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGPIPE, {sa_handler=0x55c204a01810, sa_mask=[PIPE], 
sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0x7fa7e56abf20}, 
{sa_handler=SIG_DFL, sa_mask=[PIPE], sa_flags=SA_RESTORER|SA_RESTART, 
sa_restorer=0x7fa7e56abf20}, 8) = 0
close(4)                                = 0
read(3, "", 8)                          = 0
close(3)                                = 0
wait4(21767, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 21767
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=21767, 
si_uid=1000, si_status=0, si_utime=8, si_stime=2} ---
exit_group(0)                           = ?
+++ exited with 0 +++
peter@optiplex[ master* ]>
peter@optiplex[ master* ]> strace git gui
execve("/usr/bin/git", ["git", "gui"], 0x7fffe2ceb3d8 /* 59 vars */) = 0
brk(NULL)                               = 0x5555e3e40000
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or 
directory)
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or 
directory)
openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=96441, ...}) = 0
mmap(NULL, 96441, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7fcb00ac3000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or 
directory)
openat(AT_FDCWD, "/usr/lib/x86_64-linux-gnu/libpcre2-8.so.0", 
O_RDONLY|O_CLOEXEC) = 3
read(3, 
"\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\360\36\0\0\0\0\0\0"..., 
832) = 832
fstat(3, {st_mode=S_IFREG|0644, st_size=530984, ...}) = 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) 
= 0x7fcb00ac1000
mmap(NULL, 2626312, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 
0) = 0x7fcb00632000
mprotect(0x7fcb006b3000, 2093056, PROT_NONE) = 0
mmap(0x7fcb008b2000, 8192, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x80000) = 0x7fcb008b2000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or 
directory)
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libz.so.1", O_RDONLY|O_CLOEXEC) = 3
read(3, 
"\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\220\37\0\0\0\0\0\0"..., 
832) = 832
fstat(3, {st_mode=S_IFREG|0644, st_size=116960, ...}) = 0
mmap(NULL, 2212016, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 
0) = 0x7fcb00415000
mprotect(0x7fcb00431000, 2093056, PROT_NONE) = 0
mmap(0x7fcb00630000, 8192, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1b000) = 0x7fcb00630000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or 
directory)
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libpthread.so.0", 
O_RDONLY|O_CLOEXEC) = 3
read(3, 
"\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0000b\0\0\0\0\0\0"..., 
832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=144976, ...}) = 0
mmap(NULL, 2221184, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 
0) = 0x7fcb001f6000
mprotect(0x7fcb00210000, 2093056, PROT_NONE) = 0
mmap(0x7fcb0040f000, 8192, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x19000) = 0x7fcb0040f000
mmap(0x7fcb00411000, 13440, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7fcb00411000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or 
directory)
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/librt.so.1", O_RDONLY|O_CLOEXEC) = 3
read(3, 
"\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\"\0\0\0\0\0\0"..., 
832) = 832
fstat(3, {st_mode=S_IFREG|0644, st_size=31680, ...}) = 0
mmap(NULL, 2128864, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 
0) = 0x7fcafffee000
mprotect(0x7fcaffff5000, 2093056, PROT_NONE) = 0
mmap(0x7fcb001f4000, 8192, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x6000) = 0x7fcb001f4000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or 
directory)
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, 
"\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\260\34\2\0\0\0\0\0"..., 
832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=2030544, ...}) = 0
mmap(NULL, 4131552, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 
0) = 0x7fcaffbfd000
mprotect(0x7fcaffde4000, 2097152, PROT_NONE) = 0
mmap(0x7fcafffe4000, 24576, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1e7000) = 0x7fcafffe4000
mmap(0x7fcafffea000, 15072, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7fcafffea000
close(3)                                = 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) 
= 0x7fcb00abf000
arch_prctl(ARCH_SET_FS, 0x7fcb00ac0080) = 0
mprotect(0x7fcafffe4000, 16384, PROT_READ) = 0
mprotect(0x7fcb0040f000, 4096, PROT_READ) = 0
mprotect(0x7fcb001f4000, 4096, PROT_READ) = 0
mprotect(0x7fcb00630000, 4096, PROT_READ) = 0
mprotect(0x7fcb008b2000, 4096, PROT_READ) = 0
mprotect(0x5555e1e2a000, 16384, PROT_READ) = 0
mprotect(0x7fcb00adb000, 4096, PROT_READ) = 0
munmap(0x7fcb00ac3000, 96441)           = 0
set_tid_address(0x7fcb00ac0350)         = 21805
set_robust_list(0x7fcb00ac0360, 24)     = 0
rt_sigaction(SIGRTMIN, {sa_handler=0x7fcb001fbcb0, sa_mask=[], 
sa_flags=SA_RESTORER|SA_SIGINFO, sa_restorer=0x7fcb00208890}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {sa_handler=0x7fcb001fbd50, sa_mask=[], 
sa_flags=SA_RESTORER|SA_RESTART|SA_SIGINFO, sa_restorer=0x7fcb00208890}, 
NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) = 0
prlimit64(0, RLIMIT_STACK, NULL, {rlim_cur=8192*1024, 
rlim_max=RLIM64_INFINITY}) = 0
openat(AT_FDCWD, "/dev/null", O_RDWR)   = 3
close(3)                                = 0
rt_sigprocmask(SIG_UNBLOCK, [PIPE], NULL, 8) = 0
rt_sigaction(SIGPIPE, {sa_handler=SIG_DFL, sa_mask=[PIPE], 
sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0x7fcaffc3bf20}, 
{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
brk(NULL)                               = 0x5555e3e40000
brk(0x5555e3e61000)                     = 0x5555e3e61000
stat("/usr/share/locale", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
openat(AT_FDCWD, "/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=10281936, ...}) = 0
mmap(NULL, 10281936, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7fcaff22e000
close(3)                                = 0
access("/etc/gitconfig", R_OK)          = -1 ENOENT (No such file or 
directory)
access("/home/peter/.config/git/config", R_OK) = -1 ENOENT (No such file 
or directory)
access("/home/peter/.gitconfig", R_OK)  = 0
openat(AT_FDCWD, "/home/peter/.gitconfig", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0775, st_size=170, ...}) = 0
fstat(3, {st_mode=S_IFREG|0775, st_size=170, ...}) = 0
read(3, "[push]\n\tdefault = current\n\n[user"..., 4096) = 170
read(3, "", 4096)                       = 0
read(3, "", 4096)                       = 0
close(3)                                = 0
getcwd("/home/peter/git/gh_code", 129)  = 24
stat("/home/peter/git/gh_code", {st_mode=S_IFDIR|0775, st_size=4096, 
...}) = 0
stat("/home/peter/git/gh_code/.git", {st_mode=S_IFDIR|0775, 
st_size=4096, ...}) = 0
lstat("/home/peter/git/gh_code/.git/HEAD", {st_mode=S_IFREG|0664, 
st_size=23, ...}) = 0
openat(AT_FDCWD, "/home/peter/git/gh_code/.git/HEAD", O_RDONLY) = 3
read(3, "ref: refs/heads/master\n", 255) = 23
read(3, "", 232)                        = 0
close(3)                                = 0
lstat("/home/peter/git/gh_code/.git/commondir", 0x7ffd6bbf1280) = -1 
ENOENT (No such file or directory)
access("/home/peter/git/gh_code/.git/objects", X_OK) = 0
access("/home/peter/git/gh_code/.git/refs", X_OK) = 0
lstat(".git/commondir", 0x7ffd6bbf1400) = -1 ENOENT (No such file or 
directory)
openat(AT_FDCWD, ".git/config", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0664, st_size=834, ...}) = 0
fstat(3, {st_mode=S_IFREG|0664, st_size=834, ...}) = 0
read(3, "[core]\n\trepositoryformatversion "..., 4096) = 834
read(3, "", 4096)                       = 0
close(3)                                = 0
access("/etc/gitconfig", R_OK)          = -1 ENOENT (No such file or 
directory)
access("/home/peter/.config/git/config", R_OK) = -1 ENOENT (No such file 
or directory)
access("/home/peter/.gitconfig", R_OK)  = 0
openat(AT_FDCWD, "/home/peter/.gitconfig", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0775, st_size=170, ...}) = 0
fstat(3, {st_mode=S_IFREG|0775, st_size=170, ...}) = 0
read(3, "[push]\n\tdefault = current\n\n[user"..., 4096) = 170
read(3, "", 4096)                       = 0
read(3, "", 4096)                       = 0
close(3)                                = 0
access(".git/config", R_OK)             = 0
openat(AT_FDCWD, ".git/config", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0664, st_size=834, ...}) = 0
fstat(3, {st_mode=S_IFREG|0664, st_size=834, ...}) = 0
read(3, "[core]\n\trepositoryformatversion "..., 4096) = 834
read(3, "", 4096)                       = 0
close(3)                                = 0
stat("/usr/lib/git-core/git-gui", {st_mode=S_IFREG|0755, st_size=105779, 
...}) = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) = 0
clone(child_stack=NULL, 
flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, 
child_tidptr=0x7fcb00ac0350) = 21806
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGINT, {sa_handler=0x5555e1b0a810, sa_mask=[INT], 
sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0x7fcaffc3bf20}, 
{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGHUP, {sa_handler=0x5555e1b0a810, sa_mask=[HUP], 
sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0x7fcaffc3bf20}, 
{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGTERM, {sa_handler=0x5555e1b0a810, sa_mask=[TERM], 
sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0x7fcaffc3bf20}, 
{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGQUIT, {sa_handler=0x5555e1b0a810, sa_mask=[QUIT], 
sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0x7fcaffc3bf20}, 
{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGPIPE, {sa_handler=0x5555e1b0a810, sa_mask=[PIPE], 
sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0x7fcaffc3bf20}, 
{sa_handler=SIG_DFL, sa_mask=[PIPE], sa_flags=SA_RESTORER|SA_RESTART, 
sa_restorer=0x7fcaffc3bf20}, 8) = 0
close(4)                                = 0
read(3, "", 8)                          = 0
close(3)                                = 0
wait4(21806, 0x7ffd6bbf1684, 0, NULL)   = ? ERESTARTSYS (To be restarted 
if SA_RESTART is set)
--- SIGWINCH {si_signo=SIGWINCH, si_code=SI_KERNEL} ---
wait4(21806, 0x7ffd6bbf1684, 0, NULL)   = ? ERESTARTSYS (To be restarted 
if SA_RESTART is set)
--- SIGWINCH {si_signo=SIGWINCH, si_code=SI_KERNEL} ---
wait4(21806, 0x7ffd6bbf1684, 0, NULL)   = ? ERESTARTSYS (To be restarted 
if SA_RESTART is set)
--- SIGWINCH {si_signo=SIGWINCH, si_code=SI_KERNEL} ---
wait4(21806,



