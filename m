Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01A45211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 11:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbeLDK5h (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 05:57:37 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:41239 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbeLDK5g (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 05:57:36 -0500
Received: by mail-wr1-f51.google.com with SMTP id x10so15430524wrs.8
        for <git@vger.kernel.org>; Tue, 04 Dec 2018 02:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=hI4LbCfdwCC6zxgih5yEilB8bOFDHs13W8z3QrlQ914=;
        b=ELGE5Sfdr8v1ou4Th3bvR8BwtEjj6Q3bNsP4ZmHq1aViHOv8p62KmsH1Eshkn+QZ6f
         eIZSogVgFGz/w4mKLdJ0KgHHtd6/4EE4UzyQxJFMhCJfJ3wQxQzP8Nd/LVwSc56+grjR
         zUxsLfa4lRMTHDOuoj53yB5qtpKSFFWutOTYekEVjOf6fTRui6SX0Vcmm0m+DqqQmnqJ
         4Alpwjn0+nFR4vsTvOLn+ggP7j8lLSpWOjJl1aEH60249LYul8m8fFbpej/gtQOFtMoi
         omkmTSqJjBci9zAwfBN44jxCdnbVipZmFkbka+CkvOeJl1MX1BJlCRh6yCK0biEPA1lE
         eN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=hI4LbCfdwCC6zxgih5yEilB8bOFDHs13W8z3QrlQ914=;
        b=li1O0/63AhCvt51MAbMvKH0/zouShCpMkSIdqbc6mstyzNyhQMiQbn4HBALYQz9jRF
         ewEYd5nN2+FOPzsVNKpQB7qagxPvM93uAwZnVQrWpm+b/cVJdLkLtfiHpBypC2UrT18d
         p+fotmgbaJOKP7+mdwsAeN6e+KPFRma4UkFSF04jCQPfmONl77Riit4o760XKLzzf4Dm
         lNvdnP6FWuzne79pp3o9dhDZKOrptaGjxRgiq8f8a1lO7qCk/5DfwGW4o+13yvgFekIw
         uQyTOjLEpi7GrUeFqc05j7upwbeXHkzyVjZRHCf1hoG1jbFWXdT+oJhiyYjt7s3+I30/
         yWHw==
X-Gm-Message-State: AA+aEWYztrCgQN801tkIupwfd6RxoL0+yCFBiW1ppCI3DUY2nF8sKjLF
        7b/gwAYLws50yoF9SXQTKd/atSW9
X-Google-Smtp-Source: AFSGD/VKLws2UdbBFASStYEbPppLwRL1BDuE6U2hwwqt7anJ7COo0Fit/n+KdFGzB/zaSsLjLqnFCg==
X-Received: by 2002:a5d:6549:: with SMTP id z9mr16857685wrv.116.1543921053384;
        Tue, 04 Dec 2018 02:57:33 -0800 (PST)
Received: from kinodont-arch (ip-89-103-14-213.net.upcbroadband.cz. [89.103.14.213])
        by smtp.gmail.com with ESMTPSA id 5sm11155147wmr.37.2018.12.04.02.57.32
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 02:57:32 -0800 (PST)
Message-ID: <79d309e1312bbff8739c146d2348ea8788d6235d.camel@gmail.com>
Subject: Re: [BUG REPORT] Git does not correctly replay bisect log
From:   =?UTF-8?Q?Luk=C3=A1=C5=A1_Krej=C4=8D=C3=AD?= <lskrejci@gmail.com>
To:     git@vger.kernel.org
Date:   Tue, 04 Dec 2018 11:57:32 +0100
In-Reply-To: <CA+YJQx72dMybGWyzNMUcNcVZnpDTHoaONcC-AQdqt=C_8aEdXg@mail.gmail.com>
References: <CA+YJQx72dMybGWyzNMUcNcVZnpDTHoaONcC-AQdqt=C_8aEdXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(I'm sorry about the formatting, here's the message again.)

Executing git bisect replay reaches a different commit than
the one that is obtained by running the commands from the bisect log manually.

Distribution: Arch Linux
git: 2.19.2-1
perl: 5.28.1-1
pcre2: 10.32-1
expat: 2.2.6-1
perl-error: 0.17027-1
grep: 3.1-2
bash: 4.4.023-1

no system /etc/gitconfig is present
tried with no ~/.gitconfig

$ cat .git/config 
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
[remote "origin"]
        url = git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
        remote = origin
        merge = refs/heads/master

$ git fsck
Checking object directories: 100% (256/256), done.
warning in tag 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c: missingTaggerEntry: invalid format - expected 'tagger' line
warning in tag 26791a8bcf0e6d33f43aef7682bdb555236d56de: missingTaggerEntry: invalid format - expected 'tagger' line
warning in tag 9e734775f7c22d2f89943ad6c745571f1930105f: missingTaggerEntry: invalid format - expected 'tagger' line
warning in tag 0397236d43e48e821cce5bbe6a80a1a56bb7cc3a: missingTaggerEntry: invalid format - expected 'tagger' line
warning in tag ebb5573ea8beaf000d4833735f3e53acb9af844c: missingTaggerEntry: invalid format - expected 'tagger' line
warning in tag 06f6d9e2f140466eeb41e494e14167f90210f89d: missingTaggerEntry: invalid format - expected 'tagger' line
warning in tag 701d7ecec3e0c6b4ab9bb824fd2b34be4da63b7e: missingTaggerEntry: invalid format - expected 'tagger' line
warning in tag 733ad933f62e82ebc92fed988c7f0795e64dea62: missingTaggerEntry: invalid format - expected 'tagger' line
warning in tag c521cb0f10ef2bf28a18e1cc8adf378ccbbe5a19: missingTaggerEntry: invalid format - expected 'tagger' line
warning in tag a339981ec18d304f9efeb9ccf01b1f04302edf32: missingTaggerEntry: invalid format - expected 'tagger' line
Checking objects: 100% (6428247/6428247), done.
Checking connectivity: 6369862, done.

$ cat /var/tmp/git-bisect.log
git bisect start
# bad: [5b394b2ddf0347bef56e50c69a58773c94343ff3] Linux 4.19-rc1
git bisect bad 5b394b2ddf0347bef56e50c69a58773c94343ff3
# good: [94710cac0ef4ee177a63b5227664b38c95bbf703] Linux 4.18
git bisect good 94710cac0ef4ee177a63b5227664b38c95bbf703
# bad: [54dbe75bbf1e189982516de179147208e90b5e45] Merge tag 'drm-next-2018-08-15' of git://anongit.freedesktop.org/drm/drm
git bisect bad 54dbe75bbf1e189982516de179147208e90b5e45
# bad: [0a957467c5fd46142bc9c52758ffc552d4c5e2f7] x86: i8259: Add missing include file
git bisect bad 0a957467c5fd46142bc9c52758ffc552d4c5e2f7
# good: [958f338e96f874a0d29442396d6adf9c1e17aa2d] Merge branch 'l1tf-final' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 958f338e96f874a0d29442396d6adf9c1e17aa2d
# bad: [2c20443ec221dcb76484b30933593e8ecd836bbd] Merge tag 'acpi-4.19-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
git bisect bad 2c20443ec221dcb76484b30933593e8ecd836bbd
# bad: [c2fc71c9b74c1e87336a27dba1a5edc69d2690f1] Merge tag 'mtd/for-4.19' of git://git.infradead.org/linux-mtd
git bisect bad c2fc71c9b74c1e87336a27dba1a5edc69d2690f1
# bad: [b86d865cb1cae1e61527ea0b8977078bbf694328] blkcg: Make blkg_root_lookup() work for queues in bypass mode
git bisect bad b86d865cb1cae1e61527ea0b8977078bbf694328
# bad: [1b0d274523df5ef1caedc834da055ff721e4d4f0] nvmet: don't use uuid_le type
git bisect bad 1b0d274523df5ef1caedc834da055ff721e4d4f0

$ git status
On branch master
Your branch is up to date with 'origin/master'.

nothing to commit, working tree clean

$ git log -1 --format=oneline
2595646791c319cadfdbf271563aac97d0843dc7 (HEAD -> master, tag: v4.20-rc5, origin/master, origin/HEAD) Linux 4.20-rc5

$ git bisect replay /var/tmp/git-bisect.log 
We are not bisecting.
Bisecting: a merge base must be tested
[d72e90f33aa4709ebecc5005562f52335e106a60] Linux 4.18-rc6

$ git log -1 --format=oneline
d72e90f33aa4709ebecc5005562f52335e106a60 (HEAD, tag: v4.18-rc6) Linux 4.18-rc6





# Running the commands from the bisect log manually, however:

$ git bisect reset
Checking out files: 100% (18326/18326), done.
Previous HEAD position was d72e90f33aa4 Linux 4.18-rc6
Switched to branch 'master'
Your branch is up to date with 'origin/master'.

$ . /var/tmp/git-bisect.log 
Bisecting: 6112 revisions left to test after this (roughly 13 steps)
[54dbe75bbf1e189982516de179147208e90b5e45] Merge tag 'drm-next-2018-08-15' of git://anongit.freedesktop.org/drm/drm
Bisecting: 3881 revisions left to test after this (roughly 12 steps)
[0a957467c5fd46142bc9c52758ffc552d4c5e2f7] x86: i8259: Add missing include file
Bisecting: 1595 revisions left to test after this (roughly 11 steps)
[958f338e96f874a0d29442396d6adf9c1e17aa2d] Merge branch 'l1tf-final' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
Bisecting: 854 revisions left to test after this (roughly 10 steps)
[2c20443ec221dcb76484b30933593e8ecd836bbd] Merge tag 'acpi-4.19-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
Bisecting: 352 revisions left to test after this (roughly 9 steps)
[c2fc71c9b74c1e87336a27dba1a5edc69d2690f1] Merge tag 'mtd/for-4.19' of git://git.infradead.org/linux-mtd
Bisecting: 193 revisions left to test after this (roughly 8 steps)
[b86d865cb1cae1e61527ea0b8977078bbf694328] blkcg: Make blkg_root_lookup() work for queues in bypass mode
Bisecting: 97 revisions left to test after this (roughly 7 steps)
[1b0d274523df5ef1caedc834da055ff721e4d4f0] nvmet: don't use uuid_le type
Bisecting: 47 revisions left to test after this (roughly 6 steps)
[6dad38d38f20c0c8a84b5ae4f23c62b2c8758ec5] null_blk: move shared definitions to header file

$ git log -1 --format=oneline
6dad38d38f20c0c8a84b5ae4f23c62b2c8758ec5 (HEAD) null_blk: move shared definitions to header file

