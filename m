Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D34CD37B1
	for <git@archiver.kernel.org>; Sat, 16 Sep 2023 03:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237842AbjIPDXE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Sep 2023 23:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjIPDWo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2023 23:22:44 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C79219E
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 20:22:39 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2bfc5218dd8so43896321fa.2
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 20:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694834557; x=1695439357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQCv0zIGB/De+HWNNYf3vnZQyQzhWsNG+2XZ1h8vWf4=;
        b=Xi0k+SAW3WYAYUj9cgrqyhRMLbn+cUrLt9uOau022YbFf4mQ64vsTq7NTwV6JDK4hz
         MX//yvzF9DwVYJ96/9cvigQ+wK/R7Ls4Qw8eTnz5i/rXeAGX/prOttXoKMlJUIgZv7Us
         qEK3kL3cZdUhtvITD6bw4lRwMjsKd3LqaSmtMRDYNFNGdP47M09Ia/paSuIIS7SYBpQX
         mPuRLyFm+CmlwQsZa0jA5/igYB6gJPkiUn4r5iSmPAy1lLK5DbQxmG5LGrfErfs62MSM
         HL9HqWvkmvdm/koN2a8VSvAcU6j9pypVx1N5tX3ypfHsaoWmjY69Ldlk8Kn43wA5Xqhi
         wUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694834557; x=1695439357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQCv0zIGB/De+HWNNYf3vnZQyQzhWsNG+2XZ1h8vWf4=;
        b=WvZS0obKVbQ+aXWa7zn+kP8mQ5j2jaDke5wY8HzqqNebKL2xFK9R8MYDAIy1DeLFrC
         fQ13IzA7z/TRfYqRbPEhfWSyDw0lzR+9KSGtWF8tEt2J3Co/NIRmbN4Ff/LsmFFH6+L7
         eH9TE9tmSTVSLkKkYbaohAOMPbrZbD88F8UifpaTz10UOAi/RqUKbFIMwvaSo7jJFeRt
         jrwqDSLdc4RtaHm+nslyFVMb/BYwPlQeoky8EbdMhpukJXv01YHGZ/Ryx/S056rUEwoH
         wOBAzHORXKXcpL8I5ysCgzNfBUhgqOtIFimd3Ghx+Rz73Dt6xUC4YeJEhn4Ls44N20Ec
         Nu+g==
X-Gm-Message-State: AOJu0YzAitPRK+zSV7VtMvR2MMokZkTdrQGVQZtEfpFEDSSSq3EMtvMm
        OjVU6q/HVZyKgtunoCGKZA+/BkSQQuudeylES0M=
X-Google-Smtp-Source: AGHT+IFmc9dAf32XhS+bE+Sa3awdf02jzrmWc241xNEHut2IVBTVUuihY6IeVZVAqK98E88uOEmomT9yCpqTSGbNHms=
X-Received: by 2002:a2e:8517:0:b0:2bd:1615:f9f8 with SMTP id
 j23-20020a2e8517000000b002bd1615f9f8mr2901517lji.45.1694834557084; Fri, 15
 Sep 2023 20:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1565.v2.git.1691818386345.gitgitgadget@gmail.com>
 <pull.1565.v3.git.1694830462463.gitgitgadget@gmail.com> <CAFWsj_UeK-5uyCtBfLYeRZXRMdAD_eFassxEo6FvgeVzmwqLNQ@mail.gmail.com>
In-Reply-To: <CAFWsj_UeK-5uyCtBfLYeRZXRMdAD_eFassxEo6FvgeVzmwqLNQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 15 Sep 2023 20:21:00 -0700
Message-ID: <CABPp-BFDzn=3NzCKyL6aHK0ADbXXBoDhF_sGF8DRdj_VLKQ3SQ@mail.gmail.com>
Subject: Re: [PATCH v3] merge-tree: add -X strategy option
To:     =?UTF-8?B?5ZSQ5a6H5aWV?= <winglovet@gmail.com>
Cc:     Izzy via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 15, 2023 at 7:27=E2=80=AFPM =E5=94=90=E5=AE=87=E5=A5=95 <winglo=
vet@gmail.com> wrote:
>
> Thanks for your advice!
> I've fixed those blocking issues.

Thanks, you did fix most of them.  I left a comment on a few things on V3.

> However, regarding the global variable issue, I'm not familiar with C
> and git code and don't know how to solve this. I think perhaps we need
> something like closure to parse opt into a local variable?

You could merely make xopts, xopts_nr, and xopts_alloc local
variables, and pass them around as needed.  Closures would make things
look cleaner perhaps, but certainly aren't necessarily.

But, I don't think the globals thing is a blocking issue, especially
since we already have a number of unnecessary globals in that file
already.

> Our usecase is to achieve something like 'range-diff', we first use
> merge-tree to merge new patchset's base commit with old patchset's
> source commit, then use the merge result to diff against new
> patchset's source commit. So we only need to make sure conflict's are
> handled automatically, leaving other diff features to the second step.

If you're trying to do something like range-diff, then I don't see why
there's any point in creating a merge at all.  I'm afraid I don't
follow your explanations about the steps you are taking and more
importantly why you are taking them, and how it helps you achieve your
goal of doing "something like 'range-diff'".  Could you elaborate?
