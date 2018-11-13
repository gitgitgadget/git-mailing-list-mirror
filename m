Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4ADDD1F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 18:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbeKNEv7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 23:51:59 -0500
Received: from mail-pg1-f179.google.com ([209.85.215.179]:40485 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbeKNEv7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 23:51:59 -0500
Received: by mail-pg1-f179.google.com with SMTP id z10so6110500pgp.7
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 10:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=8SM/lfp+jywJU0mgHLygARWcNU6Bb35m/ZO+vIPStmU=;
        b=phvRXpJ7jateyeCXDKJE4cj/sVsRb4Qj3XyL+95eTUexKBptOeWNR19RWJigns5KcH
         2bQCVlw5jf7ntT/vAW004B9yWgUWBdvnNttOovFVDz7tFGBi8sfFx8OigQv33WB9L8hg
         Kgg8P5uaOYWW+KjoZlLLImuJCIMGiXskX8kTUB9DA0AAd3k+wu7jRdIgMOZ1RNiTMRay
         l54fcCZTQ6HZiRtjPam7x+UBrnBSeLomwjTDLiOBqs12Ado/esEtmQ/XdpnXebyFv/n5
         dz0IHU1WVwslU0s2CDZfHQr419uyBiDaIJHEqiANcSg76K8o560RHu4gHq9MkJe+7rEA
         vnLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8SM/lfp+jywJU0mgHLygARWcNU6Bb35m/ZO+vIPStmU=;
        b=JAv4E+vKFywzKgwR3r9WD8nPqSSG5l0y0C2niMYKo9R8KAyqFARocWdtj28t8qWxYF
         zquL7ICYwJo+88V0JTcvSaAsQvHTWS75xq1EavVl9Qr8xao2UVYmU+uIshnLDGTMUNQf
         H+tLVhC3eC5QNVYUUZz2sR/4c7O++W7LQ/eaVvLFzq/VFo+SY+BYNSlYuLzKKqpEWTID
         dHo3XNuhQ4VnXkMv9F5updyHXbop1Ph0LLfdapC9fq2wTY/cnsfl9m3JgK1JVeZ8nkK0
         AWcZQyaPc8wn2rzr2JRK+RCFMgihtcc0Vlr2OE9v17wWIXTYK44rspBaPNwesaWWEArL
         Xy9w==
X-Gm-Message-State: AGRZ1gLOBMbc/sMPc+UOyIU9LhU70wUbLqVY6enNE7ZifJ3y6Si7i6RP
        Bp/iqFtqKA3agJ+jEmH+HEvY2vXM
X-Google-Smtp-Source: AJdET5fMMuWxsj5DWQTGWQy771HFiRbfmck+n8Meu5WXHMnoeLTf3/gByhAUhHQsA5pcMWuo0VEZPw==
X-Received: by 2002:a62:5793:: with SMTP id i19-v6mr6515135pfj.158.1542135155036;
        Tue, 13 Nov 2018 10:52:35 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id q8-v6sm31548092pfa.18.2018.11.13.10.52.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 10:52:34 -0800 (PST)
Date:   Tue, 13 Nov 2018 10:52:34 -0800 (PST)
X-Google-Original-Date: Tue, 13 Nov 2018 18:52:31 GMT
Message-Id: <pull.80.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] win32: modernize pthread_cond_*() shims
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

And yet another patch from Git for Windows' cache of treasures.

It was challenging to emulate the functions related to pthread_cond_t as
long as we tried to maintain support for Windows XP, which has nothing close
to that feature. Now that we require Windows Vista or later, we can make use
of the very nice functions associated with the CONDITION_VARIABLE data type.

Look at how much code this deletes, and how little it introduces. This is a
maintainer's dream.

Loo Rong Jie (1):
  win32: replace pthread_cond_*() with much simpler code

 compat/win32/pthread.c | 138 -----------------------------------------
 compat/win32/pthread.h |  28 +++------
 2 files changed, 7 insertions(+), 159 deletions(-)


base-commit: 8858448bb49332d353febc078ce4a3abcc962efe
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-80%2Fdscho%2Fmingw-modernize-pthread_cond_t-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-80/dscho/mingw-modernize-pthread_cond_t-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/80
-- 
gitgitgadget
