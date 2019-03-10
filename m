Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C854520248
	for <e@80x24.org>; Sun, 10 Mar 2019 22:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfCJWmC (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 18:42:02 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:34454 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfCJWmC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 18:42:02 -0400
Received: by mail-wr1-f53.google.com with SMTP id f14so3054106wrg.1
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 15:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to;
        bh=5psiXeTA4waIc0cv9tgua/XwCQuYy0N1QlZPeAHF9/U=;
        b=E7cx+mebrKKJXdJNyDSRwsvb4+1tQ8Ebwxkn96WxVPTP0ggfD5yhsYKxtxTxzpEQII
         ncRNlNWgMxK+WibbeIQnKj7Dc25s2h8lQeX0dnvF/iDTaMBfahjhTjHBWcG07FCTvOsS
         JCwsTX/3n/XCnns+DmdfSMx8CRZnoHebRRLx0GJ0jTF5zQ25TCdpV1y0csDly/j433mF
         Sa4iTJ4zzysJEJCeYevmvPaBHCFcg4dpRh2ob7saVA5AByIgkMsZkk19aQvyanKJhGPB
         zB6C8nv+6Z5DLuVKegy1L/ny8qPGHdw8p1hV8OozcQl7hXzSwxIremnKPOpUjWR+gszX
         Ippg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=5psiXeTA4waIc0cv9tgua/XwCQuYy0N1QlZPeAHF9/U=;
        b=ql2NQ7An8u6q+Rr3wR0Y0Ns1NNZKikMBwcFW3m+XW/dI4zJpBtukaJf+SwKvgK49Ir
         2PhkE6TMZREcyvrtA8CMea6uhQe48lj3wMOQor9GiLcebcCdfLLkmv1Mi7J65drsFSiH
         tpaIbyX8jgE0UbpLolup5YS7BvBsKXJ8i7vd9ZjAHZuElPCaM3S0bYdhAbis5VOD06Je
         Zik0KrwMmoiFxF65uC0ggDtyYaeKLIAk8IbRUbIduwzplVf4ZO41+ByLOTOoDn6bU2We
         OzC98C6uNBx2fVm/qCHwBuFt/YuQngJQ8lbwNQelh/cu/uEz3ggMb6M/ICHeF4PVlhni
         G1vw==
X-Gm-Message-State: APjAAAX/TjoqkyYuDPZrUzq5BDucc8l+YAnkBj7ohIkFItCW1qjmLgyX
        bwTUEHcp+gxUui4TJ9tXOsQy4YKakV1qj0ZXl0xW1uGSpKc=
X-Google-Smtp-Source: APXvYqwMQSBlsVS1FkPKaXUyb03OQfDBbOYF60EdDVzP6AWJLY8bi2W0jHIDtpEvsUXV7mDOAVcbtk6ifd2tdaAYnZQ=
X-Received: by 2002:adf:ffc3:: with SMTP id x3mr9211826wrs.111.1552257720254;
 Sun, 10 Mar 2019 15:42:00 -0700 (PDT)
MIME-Version: 1.0
From:   Anthony Sottile <asottile@umich.edu>
Date:   Sun, 10 Mar 2019 15:41:51 -0700
Message-ID: <CA+dzEBkkbQj0rCjvPfcET2Uvt6fP_v+wQE52ZkAND2Mps08SNQ@mail.gmail.com>
Subject: `git add <<windows 8.3 path to file inside repo>>` results in "fatal:
 ... is outside repository"
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(In case 8.3 filename isn't a familiar term):
https://en.wikipedia.org/wiki/8.3_filename

This is distilled down from an actual issue to a minimal testcase.

The original failure involves an automated test while running on azure
pipelines: https://asottile.visualstudio.com/asottile/_build/results?buildId=254

I'm using git on windows

>git --version
git version 2.21.0.windows.1

Here's a minimal case:

git init longname-repo
cd longname-repo
touch f
git add ..\longna~1\f

Here's the output:

C:\Users\Anthony\AppData\Local\Temp\t\pre-commit-hooks>git init longname-repo
Initialized empty Git repository in
C:/Users/Anthony/AppData/Local/Temp/t/pre-commit-hooks/longname-repo/.git/

C:\Users\Anthony\AppData\Local\Temp\t\pre-commit-hooks>cd longname-repo

C:\Users\Anthony\AppData\Local\Temp\t\pre-commit-hooks\longname-repo>touch f

C:\Users\Anthony\AppData\Local\Temp\t\pre-commit-hooks\longname-repo>git
add ..\longna~1\f
fatal: ..\longna~1\f: '..\longna~1\f' is outside repository

It is however inside the repository:

C:\Users\Anthony\AppData\Local\Temp\t\pre-commit-hooks\longname-repo>python
Python 3.7.1 (v3.7.1:260ec2c36a, Oct 20 2018, 14:57:15) [MSC v.1915 64
bit (AMD64)] on win32
Type "help", "copyright", "credits" or "license" for more information.
>>> import os
>>> os.path.samefile('f', r'..\longna~1\f')
True

Anthony
