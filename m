Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B2591F405
	for <e@80x24.org>; Wed, 19 Dec 2018 23:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbeLSW77 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 17:59:59 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:38599 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbeLSW77 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Dec 2018 17:59:59 -0500
Received: by mail-vs1-f68.google.com with SMTP id x64so13336185vsa.5
        for <git@vger.kernel.org>; Wed, 19 Dec 2018 14:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=PMKRq1zsx7LV7BSiugB3LYaSZxmQAnL7CV+bsO/UyX0=;
        b=mIupHJZKzkv1wxt7q0bfolRPj28W5GlyewxO39Vt6hZ3JlS8GsxfCGPkDwJ7b1I6Wy
         oLxknMz9iX7sFkdiQTvp0Fy/smn/+QrZRP7eWwbHVMSe4j9ckSzYydFEnRp1A7TAErcZ
         BpgnVkrZ31LIzlK5Pdo/S8lKddDlx/W4NuocCO1GtxiOi0/Yb2o9x0r5qUhNrudkwl+s
         GDqLL05jALK+lqHCY97uGDpB/QWHifghNW1MeNpBAX2T3ncJ1wG2n07A97dshgMZdyZd
         Xr2fsgLr67RLWsTt8t6pJTct/b+L/I+GOIU6dWiRMZgBwcCe4jMcGSSLtrHGkzctjBRR
         5iLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=PMKRq1zsx7LV7BSiugB3LYaSZxmQAnL7CV+bsO/UyX0=;
        b=AFOCCih1ys4+inqM/J1sBAIia04ZZCwsBGW6CGlCykN5OPYPAYdIM7ufHTAXAoIyVj
         89nddv6q6wvRWG4eBe/K8/T/aWn9zDVuSGF8FY4rORTp7hAjF+HO64xq+krCgiJw3iV/
         6M7FLDjGRapRW7y+j/oxuiOPx9XdCCA9QOevQd+aoNM8Z2+0stwP7fBXaXLCFpZCi1rK
         2hlJj4z+qPo5/BNAfw8/0NVcgSe6tN7Vl5tHNh93rQ5QM7DZpr0G3i7vnbAMWFe4Nqgv
         9xwAWsjPde8m3W8X9tkHtLuzcF0PFrHRu7nCxvsJ+Z6xqDws7d6fKk+9lvBk/7cnTavO
         jQ4g==
X-Gm-Message-State: AA+aEWZI79uUL2Qx6uNh8bs7F55KF1WN+Vm+XS1V/6mqqQgLZWOUxKXa
        aECJxnz+7wlnbd8xSWMu7OLcK1xUbmLKQsBx0D99exet
X-Google-Smtp-Source: AFSGD/XFE9MFcTxQR+f5F772795PI80IYopZ8Bomq3PQPDFfpAvocrVOuQRx6r7D8EhZjHqbVSRZHOLaEzR6E3uYRvw=
X-Received: by 2002:a67:8513:: with SMTP id h19mr10597711vsd.91.1545260396181;
 Wed, 19 Dec 2018 14:59:56 -0800 (PST)
MIME-Version: 1.0
From:   Sitsofe Wheeler <sitsofe@gmail.com>
Date:   Wed, 19 Dec 2018 22:59:30 +0000
Message-ID: <CALjAwxiB1uDfg4iPFjh2dNibEZa5mJ0RwhCzt0R2b87NTVqWfA@mail.gmail.com>
Subject: Periodic hang during git index-pack
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

While using trying to use git to clone a remote repository git
index-pack occasionally goes on to hang:

export GIT_TRACE=1
git clone -n remotehost:diffusion/LIBEDIT/libedit
22:43:48.948378 git.c:418               trace: built-in: git clone -n
remotehost:diffusion/LIBEDIT/libedit
Cloning into 'libedit'...
22:43:48.951196 run-command.c:643       trace: run_command: unset
GIT_DIR; ssh remotehost 'git-upload-pack
'\''diffusion/LIBEDIT/libedit'\'''
22:43:49.130517 run-command.c:643       trace: run_command: git
index-pack --stdin -v --fix-thin '--keep=fetch-pack 13914 on machine'
--check-self-contained-and-connected
remote: Enumerating objects: 178, done.
22:43:49.132535 git.c:418               trace: built-in: git
index-pack --stdin -v --fix-thin '--keep=fetch-pack 13914 on machine'
--check-self-contained-and-connected
remote: Counting objects: 100% (178/178), done.
remote: Compressing objects: 100% (81/81), done.
remote: Total 178 (delta 95), reused 178 (delta 95)
Receiving objects: 100% (178/178), 539.36 KiB | 16.85 MiB/s, done.
Resolving deltas: 100% (95/95), done.
22:43:49.209193 run-command.c:643       trace: run_command: git
rev-list --objects --stdin --not --all --quiet '--progress=Checking
connectivity'
22:43:49.211276 git.c:418               trace: built-in: git rev-list
--objects --stdin --not --all --quiet '--progress=Checking
connectivity'
Wed 19 Dec 22:43:49 GMT 2018
Wed 19 Dec 22:43:49 GMT 2018
22:43:49.220996 git.c:418               trace: built-in: git clone -n
remotehost:diffusion/LIBEDIT/libedit
Cloning into 'libedit'...
22:43:49.223462 run-command.c:643       trace: run_command: unset
GIT_DIR; ssh remotehost 'git-upload-pack
'\''diffusion/LIBEDIT/libedit'\'''
22:43:49.491004 run-command.c:643       trace: run_command: git
index-pack --stdin -v --fix-thin '--keep=fetch-pack 13925 on machine'
--check-self-contained-and-connected
remote: Enumerating objects: 178, done.
22:43:49.492988 git.c:418               trace: built-in: git
index-pack --stdin -v --fix-thin '--keep=fetch-pack 13925 on machine'
--check-self-contained-and-connected
remote: Counting objects: 100% (178/178), done.
remote: Compressing objects: 100% (81/81), done.
remote: Total 178 (delta 95), reused 178 (delta 95)
Receiving objects: 100% (178/178), 539.36 KiB | 17.40 MiB/s, done.
Resolving deltas: 100% (95/95), done.
22:43:49.569331 run-command.c:643       trace: run_command: git
rev-list --objects --stdin --not --all --quiet '--progress=Checking
connectivity'
22:43:49.571431 git.c:418               trace: built-in: git rev-list
--objects --stdin --not --all --quiet '--progress=Checking
connectivity'
Wed 19 Dec 22:43:49 GMT 2018
Wed 19 Dec 22:43:49 GMT 2018
22:43:49.581282 git.c:418               trace: built-in: git clone -n
remotehost:diffusion/LIBEDIT/libedit
Cloning into 'libedit'...
22:43:49.584019 run-command.c:643       trace: run_command: unset
GIT_DIR; ssh remotehost 'git-upload-pack
'\''diffusion/LIBEDIT/libedit'\'''
22:43:49.818490 run-command.c:643       trace: run_command: git
index-pack --stdin -v --fix-thin '--keep=fetch-pack 13936 on machine'
--check-self-contained-and-connected
remote: Enumerating objects: 178, done.
22:43:49.820477 git.c:418               trace: built-in: git
index-pack --stdin -v --fix-thin '--keep=fetch-pack 13936 on machine'
--check-self-contained-and-connected
remote: Counting objects: 100% (178/178), done.
remote: Compressing objects: 100% (81/81), done.
Receiving objects:  64% (114/178)

Most of the time cloning complets fine but every now and then it will
hang indefinitely in the receiving objects stage. This happens with
git version 2.17.1 from Ubuntu 18.04 and a hand compiled git version
2.20.1. The remote end is running through Phabricator sshd scripts
(both 2.17.1 and 2.20.1 have been tried on the remote end). ssh
multiplexing is on:

ControlMaster auto
ControlPersist 120
ControlPath /tmp/ssh-%r@%h:%p
ServerAliveInterval 60

Looking at where it is stuck, git is doing read of a pipe:

#0  0x00007fd1b845034e in __libc_read (fd=fd@entry=0,
buf=buf@entry=0x55ab81e19d40 <input_buffer>, nbytes=nbytes@entry=4096)
    at ../sysdeps/unix/sysv/linux/read.c:27
#1  0x000055ab81b51b23 in read (__nbytes=4096, __buf=0x55ab81e19d40
<input_buffer>, __fd=0)
    at /usr/include/x86_64-linux-gnu/bits/unistd.h:44
#2  xread (fd=0, buf=0x55ab81e19d40 <input_buffer>, len=4096) at wrapper.c:260
#3  0x000055ab819d1069 in fill (min=min@entry=1) at builtin/index-pack.c:255
#4  0x000055ab819d123a in unpack_entry_data (offset=268408,
size=size@entry=14675, type=<optimised out>,
oid=oid@entry=0x55ab837cff40)
    at builtin/index-pack.c:445
#5  0x000055ab819d1bc7 in unpack_raw_entry (oid=0x55ab837cff40,
ref_oid=0x7fffee137440, ofs_offset=0x55ab837ce350, obj=0x55ab837cff40)
    at builtin/index-pack.c:526
#6  parse_pack_objects (hash=0x7fffee1374f0 "\001") at builtin/index-pack.c:1113
#7  cmd_index_pack (argc=<optimised out>, argv=<optimised out>,
prefix=<optimised out>) at builtin/index-pack.c:1775
#8  0x000055ab819934e1 in run_builtin (argv=<optimised out>,
argc=<optimised out>, p=<optimised out>) at git.c:421
#9  handle_builtin (argc=<optimised out>, argv=<optimised out>) at git.c:647
#10 0x000055ab81994515 in run_argv (argv=0x7fffee137690,
argcp=0x7fffee13769c) at git.c:701
#11 cmd_main (argc=<optimised out>, argv=<optimised out>) at git.c:798
#12 0x000055ab8199318f in main (argc=7, argv=0x7fffee137908) at common-main.c:45

Does anyone know what might be wrong and/or how to debug this?

-- 
Sitsofe | http://sucs.org/~sits/
