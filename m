Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85A8C433E2
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 16:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF9172067C
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 16:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISp02lvq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgIBQ0r (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgIBQ0m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 12:26:42 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2523AC061247
        for <git@vger.kernel.org>; Wed,  2 Sep 2020 09:26:42 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id y4so6663377ljk.8
        for <git@vger.kernel.org>; Wed, 02 Sep 2020 09:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=4MRQc4u7B2sIPd5b0VNogjJ4uJIPbLfSjQmUL/3TUVs=;
        b=ISp02lvqyy5rPFVXDNnyD1a4OaYNYs9X4RvYv/UV33gB5z661uuNzDQlWDckmhAgxR
         mztf6mnP6UTDZpt+jkg60K2+E5p7HOg+ol3x8bLsVHWdYvdeXW1RnxcTc7FQkOtHwapW
         PJnDPdzAQpp8uHVwbxCDsfoUId49hEnmpQkH7PWBqwJpoB1nB3GpX/kKt+OCt+9K16yE
         pL90rUJXKh+ULr1m7f10Qhdu5a43UYebtIyIUFeh0+EL9bEFUaqg+3ehafFKxeTriX0w
         Of05kTTJSQZ/CDEzyTq4dcLckt2mseR87mV3wO0OxCuKJcUOjVfhQP3ilF6rDzKRF9ny
         mrkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4MRQc4u7B2sIPd5b0VNogjJ4uJIPbLfSjQmUL/3TUVs=;
        b=TNgKoKHujkDFMXknGkbQbSHZX023VvGX685SlV5N++jg0gAKnGI8TrtzlssWnSHrf9
         9mOiPLdWnF0PEdHG0vsEEsk59UGQuK+b7ppvm37e3R+Mp5uIKQbwukWDLJjyU0DXwqZO
         9kFtXje3iFUzj3TPrctsB2YkmyaCTIMq7JLaL2lc7L4/wtf4vhGzDrAVNsksSDPPK/nz
         7BmbhhCckAAH2gGf/M/B/GLDtb+z9ES6IkMZte+l9tvYfjmRRBwlTPeh9o+MSFAGQ/8e
         bJiF/1r5UoCg9hqWHG+QpHI6hLVL7fwuJ3mvaB2M0YxNNgPc87kzNdwcOBcz/j2fCjlu
         SoMg==
X-Gm-Message-State: AOAM53314CfuhzouWUk89BhH5wWRnUaAUMaJ3VZ6xGvOWkq79mwaD6kT
        uZuzvz2MEZ9NgdXOVvJ8XLFXK3B46R6rvEMGmnUy6pPJk+lY5A==
X-Google-Smtp-Source: ABdhPJzjCEEWvk8zAtwi5GVD0qJULH08C6a8RrRcVWso1NWiX/9jyyNwc+qu5odNC50diDTzNrhUvAtNXffFSyxZ6F4=
X-Received: by 2002:a2e:911:: with SMTP id 17mr541698ljj.207.1599063998761;
 Wed, 02 Sep 2020 09:26:38 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Rafa=C5=82_Grzybowski?= <aguyngueran@gmail.com>
Date:   Wed, 2 Sep 2020 18:26:27 +0200
Message-ID: <CANG6M-ri1uvEPCcssP=Q0iM25Vhr5QZ220zUUhMdH4AVR9OLSw@mail.gmail.com>
Subject: Repo state broken due to mismatched file name casing during merge
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)

mkdir repo
cd repo

git init

"sample file" > file.txt
git add file.txt
git commit -m "Added file.txt"


git checkout -b other_branch
echo other file > other_file.txt
git add other_file.txt
git commit -m "Added other_file.txt"

git checkout master
echo Other file > Other_file.txt
git add Other_file.txt
git commit -m "Added Other_file.txt"

git merge other_branch
git status

What did you expect to happen? (Expected behavior)

A clean state, no unstaged changes.

What happened instead? (Actual behavior)

There is always an unstaged file other_file.txt which case changes if
I try to discard and the unstaged change stays.
If I try to delete the file, I get two unstaged file removal changes.

What's different between what you expected and what actually happened?

The state should be clean. It looks like the merge process broke
something due to the casing.

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.28.0.windows.1
cpu: x86_64
built from commit: 77982caf269b7ee713a76da2bcf260c34d3bf7a7
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
uname: Windows 10.0 18363
compiler info: gnuc: 10.2
libc info: no libc information available
$SHELL (typically, interactive shell): <unset>
