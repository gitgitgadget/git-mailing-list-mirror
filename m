Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D871E7E625
	for <git@archiver.kernel.org>; Tue, 26 Sep 2023 11:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjIZLdX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Sep 2023 07:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbjIZLdR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2023 07:33:17 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09ADBE
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 04:33:10 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-578d791dd91so6283327a12.0
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 04:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695727990; x=1696332790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B967XQCexmBR2AUguCpF7vSJD5McPTDIGBd+avNYr1M=;
        b=R683P/b1X7VdbAZdxLBQZWh2ulByWLcm6Z+9Y97TjpfxK0+RQiKZC47I0+XLMpinc2
         Q7nQNvPnVw4A9Vmc73OoGF0KgfXIdqQUaJuo9K4zD+V9jo1ws7Ntg92MLa0lMMxm3E6+
         hiAyf5hcW1cvQt+050HD4LCLyHZPpShdqlb6SlNkZTc5XDblO7r2TXZXn9jrxNC7KEwt
         d8ShPvwNbf88TwowpVW5dFdm20wjtSYCs+nuFbO9erJMfTfr/fIK4gNvEMDS+RLSjt6G
         H+zJGCBlG19rGEDCqFdYDFSG5sh5HiILUwThJ92XeGQ+GlPBAxNMb4qgVB7Zu2O0cf5m
         /S1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695727990; x=1696332790;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B967XQCexmBR2AUguCpF7vSJD5McPTDIGBd+avNYr1M=;
        b=lzk02r4xQkZV6oexHVTCw8+qjIQk63Z8bYOICW4Ld3nowndmGJmIuoGgiFMCD92Kj4
         gs66IDAd08dhUGOHLZnjWulEkP9kH9CRFCWo6gpwoP5xZl7emnWFFamxwdzczqTQiJlu
         /gjLeoFI4cgB7GwvkdJkIYvxMTzMLm9Zn2sOufADnMxbg4dhBHqVk3OlOw8N4e3ifj7f
         8ydTN+yQ+rcRzMdcM7JZAJuQJnl13ZQAr5cPnx+91kR+zoGrH9Xs4SqSDQkyRgEBV/kh
         KyLB6cJaZyE1ExTkGd5ZMGlkFdyXVi1FSwIBIrSRhVIgoA9me/UIr5KNxEo3TFAeNY4m
         Byyg==
X-Gm-Message-State: AOJu0YzDvRiREHcjOs2mg5SCBV7pDCOOSTm1g89zFFQRsnxe7xuS+tSy
        8hrHKQVloxzbyhgtcdJGxW8=
X-Google-Smtp-Source: AGHT+IFOFkVjFH/LkECiONGrw17J78atRCIPWDaeIsE1SSFRKkSUlYvRHcEqeMvZ7bVVg1PFXettmg==
X-Received: by 2002:a17:90a:c70f:b0:276:78f2:5d31 with SMTP id o15-20020a17090ac70f00b0027678f25d31mr3389951pjt.21.1695727990247;
        Tue, 26 Sep 2023 04:33:10 -0700 (PDT)
Received: from [192.168.0.106] ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id u4-20020a17090a518400b00268dac826d4sm10714973pjh.0.2023.09.26.04.33.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 04:33:09 -0700 (PDT)
Message-ID: <f5c6a72b-f888-4d43-8be8-3ce2c878c669@gmail.com>
Date:   Tue, 26 Sep 2023 18:33:02 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] uninitialized value $address in git send-email when
 given multiple recipients separated by commas
To:     Jeff King <peff@peff.net>
Cc:     Michael Strawbridge <michael.strawbridge@amd.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>
References: <ZQ1eGzqfyoeeTBUq@debian.me>
 <20230924033625.GA1492190@coredump.intra.peff.net>
 <ZRE6q8dHPFRIQezX@debian.me>
 <20230925080010.GA1534025@coredump.intra.peff.net>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20230925080010.GA1534025@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/09/2023 15:00, Jeff King wrote:
> Do you have any other send-email related config? Can you show us the
> output of "git config --list"?
> 

Hi Jeff, sure here is the output from my git.git clone:

```
$ git config --list
core.abbrev=10
alias.am-failed=am --show-current-patch=diff
alias.fixwhat=show -s --pretty=fixes
user.name=Bagas Sanjaya
user.email=bagasdotme@gmail.com
user.signingkey=D0A10F5A447A37A42A63419FD7B55A665D5C863D
format.signature=An old man doll... just what I always wanted! - Clara
diff.algorithm=histogram
sendemail.smtpencryption=tls
sendemail.smtpserver=smtp.gmail.com
sendemail.smtpserverport=587
sendemail.smtpuser=bagasdotme@gmail.com
sendemail.smtppass=<app password>
pack.deltacachesize=225M
pack.window=13
pack.windowmemory=460M
pack.threads=2
pretty.fixes=Fixes: %h ("%s")
pretty.fixup=fixup for "%s"
pretty.kreference=%h ("%s")
pretty.upstream=commit %H upstream.
pretty.upstreamsasha=[ Upstream commit %H ]
merge.conflictstyle=diff3
tar.xz.command=xz -c
tar.zst.command=zstd -c
diff.algorithm=histogram
filter.lfs.clean=git-lfs clean -- %f
filter.lfs.smudge=git-lfs smudge -- %f
filter.lfs.process=git-lfs filter-process
filter.lfs.required=true
core.repositoryformatversion=0
core.filemode=true
core.bare=false
core.logallrefupdates=true
tag.sort=creatordate
remote.origin.url=https://git.kernel.org/pub/scm/git/git.git
remote.origin.fetch=+refs/heads/master:refs/remotes/origin/master
remote.origin.fetch=+refs/heads/main:refs/remotes/origin/main
remote.origin.fetch=+refs/heads/next:refs/remotes/origin/next
remote.origin.fetch=+refs/heads/seen:refs/remotes/origin/seen
remote.origin.fetch=+refs/heads/maint:refs/remotes/origin/maint
remote.origin.fetch=+refs/heads/todo:refs/remotes/origin/todo
sendemail.sendmailcmd=/usr/sbin/sendmail
sendemail.envelopesender=auto
branch.master.remote=origin
branch.master.merge=refs/heads/master
branch.next.remote=origin
branch.next.merge=refs/heads/next
branch.seen.remote=origin
branch.seen.merge=refs/heads/seen
branch.maint.remote=origin
branch.maint.merge=refs/heads/maint
branch.todo.remote=origin
branch.todo.merge=refs/heads/todo
sendemail.sendmailcmd=/usr/sbin/sendmail
sendemail.envelopesender=auto
branch.main.remote=origin
branch.main.merge=refs/heads/main
remote.gitnode.url=git@gitnode.io:bagas/git.git
remote.gitnode.fetch=+refs/heads/*:refs/remotes/gitnode/*
```

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

