Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11447211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 14:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbeLFOnj (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 09:43:39 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:36088 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730693AbeLFOnh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 09:43:37 -0500
Received: by mail-wm1-f43.google.com with SMTP id a18so1330378wmj.1
        for <git@vger.kernel.org>; Thu, 06 Dec 2018 06:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=OVCV3Odej0l/8Ig9GxTRzDCxgGYgVC4VkVO20P6bha4=;
        b=EjQYcPgkHE4YkHdCHRtmA93lr5FafsMKIui6/vW3+6ULgxN1MDnEiqa7m70aF7fcOD
         SAItR57evLP3hfssxmqgynT0OYkWqCaHHOya5hYxmEwmbKYzd2KeRWJsSHvzAQwUIQ1m
         DRou1f5d7k+D5cCN56NOTrEYCVZPCTt8wqKSnNHQR+1/Ok9qWBmjlPkUIIv2zyP6SSAv
         qatZHosDEobySgQEkexxWUguFCHiJQzGOZAwcCBFXwCT3GNAauMc9tcICKXo0jZ1MpJ4
         j8VLwvAc477D/paX8LIvFdHfMvjFhgw6TqPWipJLTOjlrxslcdoltpUvlf9MeWc5YAEu
         LmHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=OVCV3Odej0l/8Ig9GxTRzDCxgGYgVC4VkVO20P6bha4=;
        b=uKw3EDz8PXowesXqqv0URR67by5zug4aRjsVJU8sbG9QOnVeEbFDVYZ9tnLE8gXeZE
         /R4jNLPBslD6B+uguZJWx3aV6Bq7fY1UeFP0caBnRzpZWvYpQtRxdfDwQc/pulitDiTG
         Dlhax14ubfM9EI9pPnUezGLv4LvVetE8MKuGjWCTOQe1T8wd2A3/3aua7SuJ3hSp3He1
         NXm09vatrLjTOZC/R/Cijr8zcidRajdgbF+oH3jzM//fp0NSbJ+ySupP633OO42Ed7b/
         c61XNCU/mkE7Atq0nf3KWKH6u+A1TEwh+5AcOcl24gdQjE2Z2qs7YVTf8/1NK50HcOVw
         ZEJg==
X-Gm-Message-State: AA+aEWbwVl/DX7i4fuibsxEuAEvO+7GYnKs0tlp51NYr3ZsfSYF8LnUP
        Grue9IO75n48jkSUp7MalAI=
X-Google-Smtp-Source: AFSGD/XSIEqQcyWjmf8+kom3iryC8tZ10vOQvWTblmDswiwQNE7MxBUICrjx8vDTAt5QSw621VxvxQ==
X-Received: by 2002:a1c:1b86:: with SMTP id b128mr19386604wmb.30.1544107414679;
        Thu, 06 Dec 2018 06:43:34 -0800 (PST)
Received: from kinodont-arch (ip-89-103-14-213.net.upcbroadband.cz. [89.103.14.213])
        by smtp.gmail.com with ESMTPSA id v6sm776833wro.57.2018.12.06.06.43.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 06:43:33 -0800 (PST)
Message-ID: <278123655fbdb565aed16bba804711774716c554.camel@gmail.com>
Subject: Re: [BUG REPORT] Git does not correctly replay bisect log
From:   =?UTF-8?Q?Luk=C3=A1=C5=A1_Krej=C4=8D=C3=AD?= <lskrejci@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Date:   Thu, 06 Dec 2018 15:43:32 +0100
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

Hello again,

after looking into this today, I'm not sure if this can be considered a
bug - it's just that I expected Git to check out the exact commit to
test that was there before resetting the bisect. That made me uncertain
whether Git restored the correct state.

When I looked at what Git actually does, it became clear that the
behavior is not incorrect but perhaps a bit surprising.

When Git replays the bisect log, it only updates refs/bisect/bad,
refs/bisect/good-*, refs/bisect/skip-* and reconstructs the log in
.git/BISECT_LOG. After that check_good_are_ancestors_of_bad() verifies
that all good commits are ancestors of the bad commit, and if not, the
message "Bisecting: a merge base must be tested" is printed and the
branch is switched to the merge base of the bad and all the good
commits.

Basically, some state is lost because Git "forgot" the first good
commit from the log already was an ancestor of the first bad one.
In other words, it's as if I just started the bisect with the following
commands and just pasted the whole bisect log to .git/BISECT_LOG:

$ git bisect start
$ git bisect good 94710cac0ef4ee177a63b5227664b38c95bbf703
$ git bisect good 958f338e96f874a0d29442396d6adf9c1e17aa2d
$ git bisect bad 1b0d274523df5ef1caedc834da055ff721e4d4f0
Bisecting: a merge base must be tested
[1e4b044d22517cae7047c99038abb444423243ca] Linux 4.18-rc4

(here's the full bisect log again for reference)
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

And indeed, marking the merge base as good switches to the correct
commit after the bisect. Marking it as bad will fail, so at least you
can't make a mistake after replaying the bisect log:
$ git bisect bad
The merge base 1e4b044d22517cae7047c99038abb444423243ca is bad.
This means the bug has been fixed between 1e4b044d22517cae7047c99038abb444423243ca and [94710cac0ef4ee177a63b5227664b38c95bbf703 958f338e96f874a0d29442396d6adf9c1e17aa2d].

Once again, I'm sorry for the noise. I guess it wasn't clear from the
man page that something like this could happen and that made me think
that this was a bug.

