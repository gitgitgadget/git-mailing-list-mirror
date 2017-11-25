Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58BC320954
	for <e@80x24.org>; Sat, 25 Nov 2017 20:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751439AbdKYUf6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Nov 2017 15:35:58 -0500
Received: from mail-it0-f41.google.com ([209.85.214.41]:37593 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750819AbdKYUf5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Nov 2017 15:35:57 -0500
Received: by mail-it0-f41.google.com with SMTP id m191so17042242itg.2
        for <git@vger.kernel.org>; Sat, 25 Nov 2017 12:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=mK3YK7O4+SMHGYFxLAMayeii0/Kr0wh6gHFeSFcBP6I=;
        b=B/KLpZM5uXcEwX+D2fNO7pXCYikNA530XPn90icbqe5+Iu2L4aeRyXLljOYEEhr+6K
         Un5KgfSkFM7eC5Unh3OYd924BFRCr04hKZmqy77nik/gus11ddZK8a7P0Ta1jZeboEx6
         Cx0hvfTRasUF61OcdEh/+3aoGDoHb3ae5kp/Ul2vMOUxdNNDeKQVd5sb0Zyauxanw+az
         jJUwpFj/q1OQRM4dqS7tF5IBWTPKcZXh8Nq2MHPrgqLShDkhaIULJQt8vZ2BmH/U+X7k
         /d31mRDTeIM3rxMo5Gg5lkhu4UtSmydIcRJRAh3Tagw4XmLNK+7rlsgGIPLuQthELVgq
         MvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=mK3YK7O4+SMHGYFxLAMayeii0/Kr0wh6gHFeSFcBP6I=;
        b=cXErdPZfIwU0iYf1j7Ca7YTU1U4+M/uqFip37YZFFTvULzM5KpHma9Z2KN3TYnQztP
         Cnfea8cxwKvC6KEHjXp2xwbwBigxoUaz+aqxgHC0mTYZydKf/RxNXMNqEufjUXP1B6Hs
         X7ccsl646XnLAQLBJFkqXQhTScNggLe8jjxNSaAykXCKRPLKMzX9fVxrTrMiNB5lofIP
         a+Rx067+tIQSoKyRpyo65O2MYCe8m+9O03qDgtGI5/oMlqhPSnOH+f32TSq+vnPMLIsk
         mP+5anEq0YWXegoaHAU44qhPIV9siZV6fVv8b/AAvYomg2rRehza/o3iu8Sbene5rT8Z
         mL5g==
X-Gm-Message-State: AJaThX7ooaj9lihZKOQl+G9nBbxp6qzjE5x2ihDVw5QLa9Jl+7hd1H0A
        PowihWKisl9W4/bmJ8u96xtbl3lx9spU7KB+TJY+fulh
X-Google-Smtp-Source: AGs4zMZ/g5rFzwkOWiQcDEVrblJh6V27qSvNFbLMKc0uqBRmxUKvpqaekCoWOgOP/AMlQVgHJWkNmvJbPb1+TQSl0nY=
X-Received: by 10.36.108.81 with SMTP id w78mr22862282itb.140.1511642156834;
 Sat, 25 Nov 2017 12:35:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.36.169.76 with HTTP; Sat, 25 Nov 2017 12:35:56 -0800 (PST)
From:   Patrick Rouleau <prouleau72@gmail.com>
Date:   Sat, 25 Nov 2017 15:35:56 -0500
Message-ID: <CAL1_K8AYf1jKDO8+czcqkUxDAuOODgKv9avaiikWi+4zpqenMQ@mail.gmail.com>
Subject: git-p4: cloning with a change number does not import all files
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I created a git repository with these commands:
  git p4 clone //perforce/path@123456 repo
  cd repo
  git p4 rebase

Some files created before the change 123456 do not exist in git
history. I do see why,
but those files were not modified after that change number.

If I use "git p4 sync --detect-branches" instead of "git p4 rebase",
the branch contains
all the files, but not the main trunk, and they appear to be added in
the first commit of
the branch.

To avoid the problem, I must clone with "@all" or with the change number when
//perforce/path was created, which is significantly longer.

Regards,
P. Rouleau
