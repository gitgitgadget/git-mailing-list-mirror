Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC88C433F5
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 21:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbiDGVzm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 17:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiDGVzl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 17:55:41 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A81F173B0F
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 14:53:39 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id p15so13586784ejc.7
        for <git@vger.kernel.org>; Thu, 07 Apr 2022 14:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=justinsteven-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=NUX5jruMt6hKYe4DdBVqps7I4uOWw+PXMqnjs5KuvA8=;
        b=BGreG1g0bw+xml5eg/OFTVi84HTpMEizMEJN/tTrrJwvcEszlTq2i8ee7ekg3tKWg0
         eCzhvLT6K3eUbpWMnXEM+86eCXbrXh/BzaYClUPwQUj5UIWXIfsH55J8E9BwCdhLeR08
         friC74/fCN1fH5UVflRq+Kk96VcFDHJBmj6Pr0FM8nnmlF0Nk4Gq5Jfyp8uMGjVu7DNu
         qAPZGWy0HA3TMiqCHc/AlFw9SZGKC/EhON9V1U15Oea6RBQaHm6VklqJTiypTDTTaGac
         RiQv6ZF3UF7ojjUn3/lUJR71EkS9CKxlU20cRb49kd0097FnOgsIZ7fpy5VuXtzyI/pV
         rQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=NUX5jruMt6hKYe4DdBVqps7I4uOWw+PXMqnjs5KuvA8=;
        b=ZYkMFCeqIybix8AhXoRc2dpW27Bc6YsqQUpT3s6h0aIVLOlHQG6sLMAG8y9i3P95CM
         M6Nz0tSDojy8UDF3zo1jvSC0yIEK4Z3Xn/4VNAzOWcVZFzYyR0MbQo+Dj3RYqsaaSDu9
         APYB4yoKppwM31RbQKs++mEfiIE7lnBThIPLrxuNqEG3l0O2BegmzQXvROn8bG/bJguv
         QxGjM/vrpy/o1Swrg4fHudI6VmfcTwExwTxJCSb5+CYJ790+LfD8YUgUSrCPk32f3cNE
         xSmt698M2cJxYWlLTyHCet2hncX1qYJQb+SeLYdBZtJ/G6WLAZJwvGu++MQI28Rdfqlh
         yUug==
X-Gm-Message-State: AOAM531tbQtslqJQicjMB6+jGHbVxcaLPgZCOkQFM1aCk8hKnauzuR5i
        6//2mIHd5VmZiv8oziHNO07PDT+5Uafxtv1lIyE+qA==
X-Google-Smtp-Source: ABdhPJxP9bKerUROSh8dqS+/JT1f2Pq5ccGbV56NttYOyjdvzJz4UDh6tsUrEH0HHruElXTJrnX4upx4U6QkUI0bAqs=
X-Received: by 2002:a17:907:94cf:b0:6e4:a60b:bae5 with SMTP id
 dn15-20020a17090794cf00b006e4a60bbae5mr15303347ejc.476.1649368417659; Thu, 07
 Apr 2022 14:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com> <Yk9Wcr74gvhtyOi7@camp.crustytoothpaste.net>
In-Reply-To: <Yk9Wcr74gvhtyOi7@camp.crustytoothpaste.net>
From:   Justin Steven <justin@justinsteven.com>
Date:   Fri, 8 Apr 2022 07:53:26 +1000
Message-ID: <CAHZU0ySHqc7f9qB0+ZrMWHHJiWsS-_hsUzomwNrGNMTF6qwcOw@mail.gmail.com>
Subject: Re: Bare repositories in the working tree are a security risk
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        Emily Shaffer <emilyshaffer@google.com>,
        justin@justinsteven.com, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I'm the author of one of the articles linked in Glen's mail. Thank you
Glen for summarising the problem beautifully and pushing this forward.

Brian said:
> As mentioned elsewhere, git status doesn't work without a working tree.

This is correct. However, it is possible to embed a bare repo that has
its own core.worktree which points to a directory within the
containing repo, satisfying the requirement of having a working tree.
This is covered in the article [1] and looks to be accounted for in
Taylor's reproducer script which admittedly I haven't run.

> Instead, I'd rather see us avoid executing any program from the config
> or any hooks in a bare repository without a working tree (except for
> pushes).  I think that would avoid breaking things while still improving
> security.

Due to the fact that the embedded bare repo can be made to have a
working tree, this won't be an effective fix.

I'm not dismissing your examples of uses of Git which would break
under Glen's suggestions. Thank you for describing these.

[1] https://github.com/justinsteven/advisories/blob/main/2022_git_buried_bare_repos_and_fsmonitor_various_abuses.md#poc---regular-vs-bare-repos-and-adding-a-corefsmonitor-payload-to-a-bare-repo

--
Justin
