Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A85D9211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 13:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbeLDNg5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 08:36:57 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41791 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbeLDNg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 08:36:57 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so15980161wrs.8
        for <git@vger.kernel.org>; Tue, 04 Dec 2018 05:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=PP5SJ8Elu/a3d3IjtIoJoi/8EyaGJoExmFTDJH/l8gk=;
        b=Y96fDg+7J/mhC9qpxKw1NSgYJkjvPl7UvLdcW6a1j6W+itcGGjnGS1F0SkmUkigFnH
         uTreid6/8MQY+s+OOkPc36TiCy0KSJwBTVd30GZbCugghB+ZQSdW52GVINDa0Kau+j3M
         gQYLeFkWO1/l06tSYVjHsOmbkiWPs23wmYIphe9QwyqfK9MPj5aoSNxYm7vGM7J0Q3pn
         2CT+yEWPlPNKrwH9j8ACzPeW6N24EY/sklocXpi/5cMd2r/MoU8Q2I+ax0KYpyt8RD3J
         hrFVdIRLkjOu2h9YDaFOlgdwIW4VpYVRgD5u5m6p5ZdBMp+xj4LMcd710ko33TaVX0Zq
         dmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=PP5SJ8Elu/a3d3IjtIoJoi/8EyaGJoExmFTDJH/l8gk=;
        b=aF7jRARO5zxLflPECJBy9ppGO2TVs3EfqGQt5k6XxqDUsqdBvAYoCk261QAmfS9M/k
         ZL95j8Lx6imLtsppeMitDDi1S1q8ZULbafFBcBlj5pI/C4IPeppn3zrIoLUmh9k2tkM1
         zVQh0T4FpO4lizyl3zaucoeaq0btMy6FYmY6hT1CXsYjhTMcWXeiaEpEuzdlEmQWRMmZ
         5fMErheCjJbxUNY3dwlRtZ/iTT1D5RNjioGTvPCIaGV2S/ifQ18gKrZslCFP4ohNl07a
         Cu7TydimlL59FjyGQ2oQPZudc9bcA72yi5MkT3NLqZyCmcbSsqkX7B0MoVxRO/N6Hbqj
         8klg==
X-Gm-Message-State: AA+aEWYHM1opat2RMIVUvw9rmok4QHX98HVU6tuwZSCu6wrbpf71vRRd
        ap5cwshvSBhWqsx2ByUdfO21V8+k
X-Google-Smtp-Source: AFSGD/WV0IuQodbNdZZUzXdZ4l4czq4YaIeCxUQLRS7bYsSp7bpYQQSWdIHU1SeVUZXjnSgLkzl0uQ==
X-Received: by 2002:a5d:660e:: with SMTP id n14mr17774594wru.19.1543930613744;
        Tue, 04 Dec 2018 05:36:53 -0800 (PST)
Received: from kinodont-arch (ip-89-103-14-213.net.upcbroadband.cz. [89.103.14.213])
        by smtp.gmail.com with ESMTPSA id d8sm15271412wrw.70.2018.12.04.05.36.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 05:36:53 -0800 (PST)
Message-ID: <f79b421a8033d69f88547028629719ca2ba93615.camel@gmail.com>
Subject: Re: [BUG REPORT] Git does not correctly replay bisect log
From:   =?UTF-8?Q?Luk=C3=A1=C5=A1_Krej=C4=8D=C3=AD?= <lskrejci@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Date:   Tue, 04 Dec 2018 14:36:52 +0100
In-Reply-To: <CAP8UFD3cD5KtvPJK5WkWGVUT6grbL=xL2MV1YWNJGpOjD3uRiQ@mail.gmail.com>
References: <CA+YJQx72dMybGWyzNMUcNcVZnpDTHoaONcC-AQdqt=C_8aEdXg@mail.gmail.com>
         <CAP8UFD2xv6SK+qPXKr5hQ0ZctOR5K-BNg1wdBy5=fp2DVBZMHw@mail.gmail.com>
         <f9f644daa705c78ef348a4a808d88bc01e7bdbd4.camel@gmail.com>
         <CAP8UFD3cD5KtvPJK5WkWGVUT6grbL=xL2MV1YWNJGpOjD3uRiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2018-12-04 at 13:01 +0100, Christian Couder wrote:
> To debug I think it would be interesting to see the output of the
> following commands just before we get different results:
> 
> git for-each-ref 'refs/bisect/*'
> 
> and
> 
> git log -1 --format=oneline
> 

I placed the following snippet at the end of the loop in bisect_replay():
echo "COMMAND: '$git' '$bisect' '$command' '$rev'"		
git for-each-ref 'refs/bisect/*'
echo "current HEAD: $(git log -1 --format=oneline)"
echo "---"

$ env GIT_TRACE=0 git bisect replay /var/tmp/git-bisect.log 

We are not bisecting.
COMMAND: 'git' 'bisect' 'start' ''
current HEAD: 2595646791c319cadfdbf271563aac97d0843dc7 Linux 4.20-rc5
---
COMMAND: 'git' 'bisect' 'bad' '5b394b2ddf0347bef56e50c69a58773c94343ff3'
5b394b2ddf0347bef56e50c69a58773c94343ff3 commit refs/bisect/bad
current HEAD: 2595646791c319cadfdbf271563aac97d0843dc7 Linux 4.20-rc5
---
COMMAND: 'git' 'bisect' 'good' '94710cac0ef4ee177a63b5227664b38c95bbf703'
5b394b2ddf0347bef56e50c69a58773c94343ff3 commit refs/bisect/bad
94710cac0ef4ee177a63b5227664b38c95bbf703 commit refs/bisect/good-94710cac0ef4ee177a63b5227664b38c95bbf703
current HEAD: 2595646791c319cadfdbf271563aac97d0843dc7 Linux 4.20-rc5
---
COMMAND: 'git' 'bisect' 'bad' '54dbe75bbf1e189982516de179147208e90b5e45'
54dbe75bbf1e189982516de179147208e90b5e45 commit refs/bisect/bad
94710cac0ef4ee177a63b5227664b38c95bbf703 commit refs/bisect/good-94710cac0ef4ee177a63b5227664b38c95bbf703
current HEAD: 2595646791c319cadfdbf271563aac97d0843dc7 Linux 4.20-rc5
---
COMMAND: 'git' 'bisect' 'bad' '0a957467c5fd46142bc9c52758ffc552d4c5e2f7'
0a957467c5fd46142bc9c52758ffc552d4c5e2f7 commit refs/bisect/bad
94710cac0ef4ee177a63b5227664b38c95bbf703 commit refs/bisect/good-94710cac0ef4ee177a63b5227664b38c95bbf703
current HEAD: 2595646791c319cadfdbf271563aac97d0843dc7 Linux 4.20-rc5
---
COMMAND: 'git' 'bisect' 'good' '958f338e96f874a0d29442396d6adf9c1e17aa2d'
0a957467c5fd46142bc9c52758ffc552d4c5e2f7 commit refs/bisect/bad
94710cac0ef4ee177a63b5227664b38c95bbf703 commit refs/bisect/good-94710cac0ef4ee177a63b5227664b38c95bbf703
958f338e96f874a0d29442396d6adf9c1e17aa2d commit refs/bisect/good-958f338e96f874a0d29442396d6adf9c1e17aa2d
current HEAD: 2595646791c319cadfdbf271563aac97d0843dc7 Linux 4.20-rc5
---
COMMAND: 'git' 'bisect' 'bad' '2c20443ec221dcb76484b30933593e8ecd836bbd'
2c20443ec221dcb76484b30933593e8ecd836bbd commit refs/bisect/bad
94710cac0ef4ee177a63b5227664b38c95bbf703 commit refs/bisect/good-94710cac0ef4ee177a63b5227664b38c95bbf703
958f338e96f874a0d29442396d6adf9c1e17aa2d commit refs/bisect/good-958f338e96f874a0d29442396d6adf9c1e17aa2d
current HEAD: 2595646791c319cadfdbf271563aac97d0843dc7 Linux 4.20-rc5
---
COMMAND: 'git' 'bisect' 'bad' 'c2fc71c9b74c1e87336a27dba1a5edc69d2690f1'
c2fc71c9b74c1e87336a27dba1a5edc69d2690f1 commit refs/bisect/bad
94710cac0ef4ee177a63b5227664b38c95bbf703 commit refs/bisect/good-94710cac0ef4ee177a63b5227664b38c95bbf703
958f338e96f874a0d29442396d6adf9c1e17aa2d commit refs/bisect/good-958f338e96f874a0d29442396d6adf9c1e17aa2d
current HEAD: 2595646791c319cadfdbf271563aac97d0843dc7 Linux 4.20-rc5
---
COMMAND: 'git' 'bisect' 'bad' 'b86d865cb1cae1e61527ea0b8977078bbf694328'
b86d865cb1cae1e61527ea0b8977078bbf694328 commit refs/bisect/bad
94710cac0ef4ee177a63b5227664b38c95bbf703 commit refs/bisect/good-94710cac0ef4ee177a63b5227664b38c95bbf703
958f338e96f874a0d29442396d6adf9c1e17aa2d commit refs/bisect/good-958f338e96f874a0d29442396d6adf9c1e17aa2d
current HEAD: 2595646791c319cadfdbf271563aac97d0843dc7 Linux 4.20-rc5
---
COMMAND: 'git' 'bisect' 'bad' '1b0d274523df5ef1caedc834da055ff721e4d4f0'
1b0d274523df5ef1caedc834da055ff721e4d4f0 commit refs/bisect/bad
94710cac0ef4ee177a63b5227664b38c95bbf703 commit refs/bisect/good-94710cac0ef4ee177a63b5227664b38c95bbf703
958f338e96f874a0d29442396d6adf9c1e17aa2d commit refs/bisect/good-958f338e96f874a0d29442396d6adf9c1e17aa2d
current HEAD: 2595646791c319cadfdbf271563aac97d0843dc7 Linux 4.20-rc5
---
Bisecting: a merge base must be tested
[1e4b044d22517cae7047c99038abb444423243ca] Linux 4.18-rc4







# I placed git for-each-ref 'refs/bisect/*' after each command in the file:

$ . /var/tmp/git-bisect.log 
5b394b2ddf0347bef56e50c69a58773c94343ff3 commit refs/bisect/bad
Bisecting: 6112 revisions left to test after this (roughly 13 steps)
[54dbe75bbf1e189982516de179147208e90b5e45] Merge tag 'drm-next-2018-08-15' of git://anongit.freedesktop.org/drm/drm
5b394b2ddf0347bef56e50c69a58773c94343ff3 commit refs/bisect/bad
94710cac0ef4ee177a63b5227664b38c95bbf703 commit refs/bisect/good-94710cac0ef4ee177a63b5227664b38c95bbf703
Bisecting: 3881 revisions left to test after this (roughly 12 steps)
[0a957467c5fd46142bc9c52758ffc552d4c5e2f7] x86: i8259: Add missing include file
54dbe75bbf1e189982516de179147208e90b5e45 commit refs/bisect/bad
94710cac0ef4ee177a63b5227664b38c95bbf703 commit refs/bisect/good-94710cac0ef4ee177a63b5227664b38c95bbf703
Bisecting: 1595 revisions left to test after this (roughly 11 steps)
[958f338e96f874a0d29442396d6adf9c1e17aa2d] Merge branch 'l1tf-final' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
0a957467c5fd46142bc9c52758ffc552d4c5e2f7 commit refs/bisect/bad
94710cac0ef4ee177a63b5227664b38c95bbf703 commit refs/bisect/good-94710cac0ef4ee177a63b5227664b38c95bbf703
Bisecting: 854 revisions left to test after this (roughly 10 steps)
[2c20443ec221dcb76484b30933593e8ecd836bbd] Merge tag 'acpi-4.19-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
0a957467c5fd46142bc9c52758ffc552d4c5e2f7 commit refs/bisect/bad
94710cac0ef4ee177a63b5227664b38c95bbf703 commit refs/bisect/good-94710cac0ef4ee177a63b5227664b38c95bbf703
958f338e96f874a0d29442396d6adf9c1e17aa2d commit refs/bisect/good-958f338e96f874a0d29442396d6adf9c1e17aa2d
Bisecting: 352 revisions left to test after this (roughly 9 steps)
[c2fc71c9b74c1e87336a27dba1a5edc69d2690f1] Merge tag 'mtd/for-4.19' of git://git.infradead.org/linux-mtd
2c20443ec221dcb76484b30933593e8ecd836bbd commit refs/bisect/bad
94710cac0ef4ee177a63b5227664b38c95bbf703 commit refs/bisect/good-94710cac0ef4ee177a63b5227664b38c95bbf703
958f338e96f874a0d29442396d6adf9c1e17aa2d commit refs/bisect/good-958f338e96f874a0d29442396d6adf9c1e17aa2d
Bisecting: 193 revisions left to test after this (roughly 8 steps)
[b86d865cb1cae1e61527ea0b8977078bbf694328] blkcg: Make blkg_root_lookup() work for queues in bypass mode
c2fc71c9b74c1e87336a27dba1a5edc69d2690f1 commit refs/bisect/bad
94710cac0ef4ee177a63b5227664b38c95bbf703 commit refs/bisect/good-94710cac0ef4ee177a63b5227664b38c95bbf703
958f338e96f874a0d29442396d6adf9c1e17aa2d commit refs/bisect/good-958f338e96f874a0d29442396d6adf9c1e17aa2d
Bisecting: 97 revisions left to test after this (roughly 7 steps)
[1b0d274523df5ef1caedc834da055ff721e4d4f0] nvmet: don't use uuid_le type
b86d865cb1cae1e61527ea0b8977078bbf694328 commit refs/bisect/bad
94710cac0ef4ee177a63b5227664b38c95bbf703 commit refs/bisect/good-94710cac0ef4ee177a63b5227664b38c95bbf703
958f338e96f874a0d29442396d6adf9c1e17aa2d commit refs/bisect/good-958f338e96f874a0d29442396d6adf9c1e17aa2d
Bisecting: 47 revisions left to test after this (roughly 6 steps)
[6dad38d38f20c0c8a84b5ae4f23c62b2c8758ec5] null_blk: move shared definitions to header file
1b0d274523df5ef1caedc834da055ff721e4d4f0 commit refs/bisect/bad
94710cac0ef4ee177a63b5227664b38c95bbf703 commit refs/bisect/good-94710cac0ef4ee177a63b5227664b38c95bbf703
958f338e96f874a0d29442396d6adf9c1e17aa2d commit refs/bisect/good-958f338e96f874a0d29442396d6adf9c1e17aa2d








Here is the output of the first command with GIT_TRACE on.

$ env GIT_TRACE=1 git bisect replay /var/tmp/git-bisect.log 
14:30:26.859355 git.c:659               trace: exec: git-bisect replay /var/tmp/git-bisect.log
14:30:26.859422 run-command.c:643       trace: run_command: git-bisect replay /var/tmp/git-bisect.log
14:30:26.893410 git.c:415               trace: built-in: git rev-parse --git-dir
14:30:26.898676 git.c:415               trace: built-in: git rev-parse --show-cdup
14:30:26.906487 git.c:415               trace: built-in: git rev-parse --git-path objects
We are not bisecting.
14:30:26.928736 git.c:415               trace: built-in: git rev-parse --sq-quote
14:30:26.935080 git.c:415               trace: built-in: git rev-parse --is-bare-repository
14:30:26.941601 git.c:415               trace: built-in: git symbolic-ref -q HEAD
14:30:26.949947 git.c:415               trace: built-in: git bisect--helper --bisect-clean-state
14:30:26.961001 git.c:415               trace: built-in: git rev-parse --sq-quote
14:30:26.970945 git.c:415               trace: built-in: git show-ref -q --verify refs/bisect/bad
14:30:26.979838 git.c:415               trace: built-in: git for-each-ref 'refs/bisect/good-*'
COMMAND: 'git' 'bisect' 'start' ''
14:30:26.989878 git.c:415               trace: built-in: git for-each-ref 'refs/bisect/*'
14:30:26.997573 git.c:415               trace: built-in: git log -1 --format=oneline
current HEAD: 2595646791c319cadfdbf271563aac97d0843dc7 Linux 4.20-rc5
---
14:30:27.012658 git.c:415               trace: built-in: git bisect--helper --write-terms bad good
14:30:27.021663 git.c:415               trace: built-in: git update-ref refs/bisect/bad 5b394b2ddf0347bef56e50c69a58773c94343ff3
14:30:27.032023 git.c:415               trace: built-in: git show-branch 5b394b2ddf0347bef56e50c69a58773c94343ff3
COMMAND: 'git' 'bisect' 'bad' '5b394b2ddf0347bef56e50c69a58773c94343ff3'
14:30:27.045300 git.c:415               trace: built-in: git for-each-ref 'refs/bisect/*'
5b394b2ddf0347bef56e50c69a58773c94343ff3 commit refs/bisect/bad
14:30:27.055905 git.c:415               trace: built-in: git log -1 --format=oneline
current HEAD: 2595646791c319cadfdbf271563aac97d0843dc7 Linux 4.20-rc5
---
14:30:27.069302 git.c:415               trace: built-in: git update-ref refs/bisect/good-94710cac0ef4ee177a63b5227664b38c95bbf703 94710cac0ef4ee177a63b5227664b38c95bbf703
14:30:27.080205 git.c:415               trace: built-in: git show-branch 94710cac0ef4ee177a63b5227664b38c95bbf703
COMMAND: 'git' 'bisect' 'good' '94710cac0ef4ee177a63b5227664b38c95bbf703'
14:30:27.091229 git.c:415               trace: built-in: git for-each-ref 'refs/bisect/*'
5b394b2ddf0347bef56e50c69a58773c94343ff3 commit refs/bisect/bad
94710cac0ef4ee177a63b5227664b38c95bbf703 commit refs/bisect/good-94710cac0ef4ee177a63b5227664b38c95bbf703
14:30:27.101268 git.c:415               trace: built-in: git log -1 --format=oneline
current HEAD: 2595646791c319cadfdbf271563aac97d0843dc7 Linux 4.20-rc5
---
14:30:27.108474 git.c:415               trace: built-in: git update-ref refs/bisect/bad 54dbe75bbf1e189982516de179147208e90b5e45
14:30:27.117641 git.c:415               trace: built-in: git show-branch 54dbe75bbf1e189982516de179147208e90b5e45
COMMAND: 'git' 'bisect' 'bad' '54dbe75bbf1e189982516de179147208e90b5e45'
14:30:27.126344 git.c:415               trace: built-in: git for-each-ref 'refs/bisect/*'
54dbe75bbf1e189982516de179147208e90b5e45 commit refs/bisect/bad
94710cac0ef4ee177a63b5227664b38c95bbf703 commit refs/bisect/good-94710cac0ef4ee177a63b5227664b38c95bbf703
14:30:27.135195 git.c:415               trace: built-in: git log -1 --format=oneline
current HEAD: 2595646791c319cadfdbf271563aac97d0843dc7 Linux 4.20-rc5
---
14:30:27.143550 git.c:415               trace: built-in: git update-ref refs/bisect/bad 0a957467c5fd46142bc9c52758ffc552d4c5e2f7
14:30:27.151005 git.c:415               trace: built-in: git show-branch 0a957467c5fd46142bc9c52758ffc552d4c5e2f7
COMMAND: 'git' 'bisect' 'bad' '0a957467c5fd46142bc9c52758ffc552d4c5e2f7'
14:30:27.157688 git.c:415               trace: built-in: git for-each-ref 'refs/bisect/*'
0a957467c5fd46142bc9c52758ffc552d4c5e2f7 commit refs/bisect/bad
94710cac0ef4ee177a63b5227664b38c95bbf703 commit refs/bisect/good-94710cac0ef4ee177a63b5227664b38c95bbf703
14:30:27.163749 git.c:415               trace: built-in: git log -1 --format=oneline
current HEAD: 2595646791c319cadfdbf271563aac97d0843dc7 Linux 4.20-rc5
---
14:30:27.171138 git.c:415               trace: built-in: git update-ref refs/bisect/good-958f338e96f874a0d29442396d6adf9c1e17aa2d 958f338e96f874a0d29442396d6adf9c1e17aa2d
14:30:27.177118 git.c:415               trace: built-in: git show-branch 958f338e96f874a0d29442396d6adf9c1e17aa2d
COMMAND: 'git' 'bisect' 'good' '958f338e96f874a0d29442396d6adf9c1e17aa2d'
14:30:27.186531 git.c:415               trace: built-in: git for-each-ref 'refs/bisect/*'
0a957467c5fd46142bc9c52758ffc552d4c5e2f7 commit refs/bisect/bad
94710cac0ef4ee177a63b5227664b38c95bbf703 commit refs/bisect/good-94710cac0ef4ee177a63b5227664b38c95bbf703
958f338e96f874a0d29442396d6adf9c1e17aa2d commit refs/bisect/good-958f338e96f874a0d29442396d6adf9c1e17aa2d
14:30:27.199439 git.c:415               trace: built-in: git log -1 --format=oneline
current HEAD: 2595646791c319cadfdbf271563aac97d0843dc7 Linux 4.20-rc5
---
14:30:27.210832 git.c:415               trace: built-in: git update-ref refs/bisect/bad 2c20443ec221dcb76484b30933593e8ecd836bbd
14:30:27.219812 git.c:415               trace: built-in: git show-branch 2c20443ec221dcb76484b30933593e8ecd836bbd
COMMAND: 'git' 'bisect' 'bad' '2c20443ec221dcb76484b30933593e8ecd836bbd'
14:30:27.228918 git.c:415               trace: built-in: git for-each-ref 'refs/bisect/*'
2c20443ec221dcb76484b30933593e8ecd836bbd commit refs/bisect/bad
94710cac0ef4ee177a63b5227664b38c95bbf703 commit refs/bisect/good-94710cac0ef4ee177a63b5227664b38c95bbf703
958f338e96f874a0d29442396d6adf9c1e17aa2d commit refs/bisect/good-958f338e96f874a0d29442396d6adf9c1e17aa2d
14:30:27.237583 git.c:415               trace: built-in: git log -1 --format=oneline
current HEAD: 2595646791c319cadfdbf271563aac97d0843dc7 Linux 4.20-rc5
---
14:30:27.246265 git.c:415               trace: built-in: git update-ref refs/bisect/bad c2fc71c9b74c1e87336a27dba1a5edc69d2690f1
14:30:27.257213 git.c:415               trace: built-in: git show-branch c2fc71c9b74c1e87336a27dba1a5edc69d2690f1
COMMAND: 'git' 'bisect' 'bad' 'c2fc71c9b74c1e87336a27dba1a5edc69d2690f1'
14:30:27.268181 git.c:415               trace: built-in: git for-each-ref 'refs/bisect/*'
c2fc71c9b74c1e87336a27dba1a5edc69d2690f1 commit refs/bisect/bad
94710cac0ef4ee177a63b5227664b38c95bbf703 commit refs/bisect/good-94710cac0ef4ee177a63b5227664b38c95bbf703
958f338e96f874a0d29442396d6adf9c1e17aa2d commit refs/bisect/good-958f338e96f874a0d29442396d6adf9c1e17aa2d
14:30:27.279037 git.c:415               trace: built-in: git log -1 --format=oneline
current HEAD: 2595646791c319cadfdbf271563aac97d0843dc7 Linux 4.20-rc5
---
14:30:27.287349 git.c:415               trace: built-in: git update-ref refs/bisect/bad b86d865cb1cae1e61527ea0b8977078bbf694328
14:30:27.293680 git.c:415               trace: built-in: git show-branch b86d865cb1cae1e61527ea0b8977078bbf694328
COMMAND: 'git' 'bisect' 'bad' 'b86d865cb1cae1e61527ea0b8977078bbf694328'
14:30:27.301385 git.c:415               trace: built-in: git for-each-ref 'refs/bisect/*'
b86d865cb1cae1e61527ea0b8977078bbf694328 commit refs/bisect/bad
94710cac0ef4ee177a63b5227664b38c95bbf703 commit refs/bisect/good-94710cac0ef4ee177a63b5227664b38c95bbf703
958f338e96f874a0d29442396d6adf9c1e17aa2d commit refs/bisect/good-958f338e96f874a0d29442396d6adf9c1e17aa2d
14:30:27.307179 git.c:415               trace: built-in: git log -1 --format=oneline
current HEAD: 2595646791c319cadfdbf271563aac97d0843dc7 Linux 4.20-rc5
---
14:30:27.312767 git.c:415               trace: built-in: git update-ref refs/bisect/bad 1b0d274523df5ef1caedc834da055ff721e4d4f0
14:30:27.318559 git.c:415               trace: built-in: git show-branch 1b0d274523df5ef1caedc834da055ff721e4d4f0
COMMAND: 'git' 'bisect' 'bad' '1b0d274523df5ef1caedc834da055ff721e4d4f0'
14:30:27.323911 git.c:415               trace: built-in: git for-each-ref 'refs/bisect/*'
1b0d274523df5ef1caedc834da055ff721e4d4f0 commit refs/bisect/bad
94710cac0ef4ee177a63b5227664b38c95bbf703 commit refs/bisect/good-94710cac0ef4ee177a63b5227664b38c95bbf703
958f338e96f874a0d29442396d6adf9c1e17aa2d commit refs/bisect/good-958f338e96f874a0d29442396d6adf9c1e17aa2d
14:30:27.329725 git.c:415               trace: built-in: git log -1 --format=oneline
current HEAD: 2595646791c319cadfdbf271563aac97d0843dc7 Linux 4.20-rc5
---
14:30:27.332326 git.c:415               trace: built-in: git show-ref -q --verify refs/bisect/bad
14:30:27.342139 git.c:415               trace: built-in: git for-each-ref 'refs/bisect/good-*'
14:30:27.348466 git.c:415               trace: built-in: git show-ref -q --verify refs/bisect/bad
14:30:27.355160 git.c:415               trace: built-in: git for-each-ref 'refs/bisect/good-*'
14:30:27.364281 git.c:415               trace: built-in: git bisect--helper --next-all
Bisecting: a merge base must be tested
14:30:27.491498 run-command.c:643       trace: run_command: git checkout -q 1e4b044d22517cae7047c99038abb444423243ca --
14:30:27.497822 git.c:415               trace: built-in: git checkout -q 1e4b044d22517cae7047c99038abb444423243ca --
14:30:55.290141 run-command.c:643       trace: run_command: git show-branch 1e4b044d22517cae7047c99038abb444423243ca
14:30:55.292168 git.c:415               trace: built-in: git show-branch 1e4b044d22517cae7047c99038abb444423243ca
[1e4b044d22517cae7047c99038abb444423243ca] Linux 4.18-rc4

