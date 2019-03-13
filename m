Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 746AB20248
	for <e@80x24.org>; Wed, 13 Mar 2019 08:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfCMIP1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 04:15:27 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40903 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfCMIP0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 04:15:26 -0400
Received: by mail-ot1-f65.google.com with SMTP id x8so925246otg.7
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 01:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=p5PMt6kqdwmeLU/6q3QmOcdOLBWY/L6VvryzLkGGDyg=;
        b=FNsAC8SGp2ecfz8e1ewObW9xZLpPkI7Y1PPlzd5YkfW9eNYSXTdmg/h13dsUVywGV3
         gDa3mSqXbbHnwjc9d7CJ5oj/4iVn4XACWxHAncYyFEVK9sUWqlY52Ok7FsMiYWU46eto
         rzWmKtALfYce43Bk2UpwmsSWijTBNbYNYPXuHrHWtSDhCRBbib5IvMSwk9s5GO7hbtTv
         oiYy/QlS3vsYxMCAlXubRBapTLTAaJuEY5OJ5qRKfskNM6dN2Zh31Wr0zDldzEBFgbwg
         swVyz7dt/5GgYz7F6/3gkiG3HT/xQpH1Qswug68qVIkkughKnE6VG53zfEAos7+ClpU+
         ZaLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=p5PMt6kqdwmeLU/6q3QmOcdOLBWY/L6VvryzLkGGDyg=;
        b=NoHEFuLBeNwgYXvVaGJSE7lMpcqmRMSDI8geggC1klMmn507OyLCAy8J33jFPnOICx
         JyQexIdurGyN5nuSXJE/2RRTTjO3CkwLsACz+JihbwQDy7FoVcFLeNGq6H6SSsSZll2P
         6SURwnJGBMMOdN2SVluoTC3Q0uJLFAbeoysHqPFXP2qFnKXopMTHyAcysFSPyGxK//s3
         1Z5AKUxFGUpREiEyoV/+IXBydzRjPiHMH9KrifzI911S71jmii6w0BqpzjQoqLmJvS6R
         pPSmkjEt1Y8lRWZD/aHDa+bsM1LW5UvjfFpVVUNQ6CUPTJNs2PDGzjs3EvywLANu001g
         mZEw==
X-Gm-Message-State: APjAAAWTD7JOpNvyFp3+NAziz85sw3VQvJTBDaVAs95+3N6TvwxsXB0S
        jbkKYI8kaU+avX3UfUP8faAxyj2n7WisknhkybXF2ZJt
X-Google-Smtp-Source: APXvYqxKPc0et4kfwExXMzRUzaSTdrV9USLIJilp67su1p5I7rMCSvEn0kfHAG83jKmIbPQnO4D8e0tB6Vh4axuiQB8=
X-Received: by 2002:a05:6830:1091:: with SMTP id y17mr25418549oto.296.1552464925854;
 Wed, 13 Mar 2019 01:15:25 -0700 (PDT)
MIME-Version: 1.0
From:   Moritz Winter <moritz.a.winter@gmail.com>
Date:   Wed, 13 Mar 2019 09:15:14 +0100
Message-ID: <CAPrSTy83qh+BtQ=ur-+6p5VXbhMpy0iD2tOAiUP10c5hWwV-tg@mail.gmail.com>
Subject: Could not access submodule when pulling recursively with git 2.21
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I've recently upgraded to git from 2.20.1 to 2.21 and now my projects
with submodules show a access error when pulling recursively.

I have a couple of projects on gitlab.com that use two or more
submodules. The .gitmodules file is slightly changed for gitlab.com
compatibility. The paths are relative as described in:

https://docs.gitlab.com/ee/ci/git_submodules.html

Before updating git I could pull the submodules recursively within the
main repository. Now I get a "Could not access submodule 'foo'" error.

Example:

$ git -v
git version 2.20.1

$ git pull --recurse-submodules=true
Fetching submodule 'foo'
Fetching submodule 'bar'
Already up to date.

$ git -v
git version 2.21.0

$ git pull --recurse-submodules=true
Fetching submodule 'foo'
Fetching submodule 'bar'
Could not access submodule 'foo'
Could not access submodule 'bar'

This only happens in projects with two or more submodules. A project
with one submodule does work as expected. Additionally I have a
password protected ssh key if this is relevant.

$ uname -a
Linux box 4.19.28-1-MANJARO #1 SMP PREEMPT Sun Mar 10 08:32:42 UTC
2019 x86_64 GNU/Linux

Is this a regression in git or is there a error on my end/gitlab.com?
My workaround currently is to downgrade to git v 2.20.

I've already filed a bug with gitlab.com:

https://gitlab.com/gitlab-org/gitlab-ce/issues/58891

Thanks & best regards

Moritz
