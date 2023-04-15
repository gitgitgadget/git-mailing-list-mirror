Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5286EC77B71
	for <git@archiver.kernel.org>; Sat, 15 Apr 2023 01:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjDOB10 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 21:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDOB1Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 21:27:25 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE153A8E
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 18:27:24 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4ec8133c698so781834e87.0
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 18:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681522042; x=1684114042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlz9WZDCwa4TjDaTaDW/u3E4Ug5AWs1JVUowgc1Z9QA=;
        b=rapFamRU/+37524RG9on+mR6r7M9EWWEenkgrgFx8FwewsOoBqBa0vfH+CRXaw/p0h
         vLkGL8+AEL0EKF7JTp6xhY/YPj1O74N1NaZD8WSvYoGqapgzkTC8jRZtvkEjG5xcHywb
         5UoWBvZYns0dz6scV7qhPgbl2eSQQT281ha8BeWC8fLbCPla11bu3dWnE3ecBdotWHGR
         DWzZu7td2rhuk33MnS4zRR+lrUXRiOP4dhj9uCFiqrkNWBBw+m2vJMbhkaaAtDABeyXU
         pPpB4dp0ZNp3E7thRzYnIpGxxLXjVgtQJBx12YBKjrzigdeWBJGYlka+7eTbkAGLq7Hy
         GIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681522042; x=1684114042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hlz9WZDCwa4TjDaTaDW/u3E4Ug5AWs1JVUowgc1Z9QA=;
        b=fYrDj5YFvg465eH/RF0c1jGLbpQRrqqMA/UHofFEfGaRH4VRdwy9oIZ80APV9G3lN2
         yaDb5O8jXYQJuk02mwr22BoMdYluLJsIvVny61ZdK1HU5AVB3bfMe1D6+qd6f5WTxJlY
         NDQCj1Vcl4bX6WbpVASsKEqt7TBh+Dz4pVHtBLGt0ueAZbL1l4/zB0eyP+Nk+dR6jDtQ
         dB1Bt4egdk5nH0J1NK83uiUGPCGfq5oQXmrMsDC5qoPOn69U/RL06ElBlbqi+nLFiD2n
         LbbUOxIaXgUdLULlIhsz5OwsyDRw1v99WW2XpaC5dIbZkdaqUZSEEaFcGuwinwWTMUQr
         2zzQ==
X-Gm-Message-State: AAQBX9fAEv4BPed1ADOThR46k599eagntLgaNOMoyJpjqaE5k7mEjzEi
        QeSK3xBpmdFBeFUp7KJS49Yv5CGyKlNQBtiYEN0=
X-Google-Smtp-Source: AKy350afIiu71ikLQC/thiE2YP73CF8Sf0msmiQqW2I4bYPmsscodlxCvuCuX8pa1d32EgxLSJbplTMS4FzFgZ7BwQY=
X-Received: by 2002:a05:6512:10c5:b0:4e8:4409:bb76 with SMTP id
 k5-20020a05651210c500b004e84409bb76mr338636lfg.2.1681522041937; Fri, 14 Apr
 2023 18:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1495.git.git.1681329955.gitgitgadget@gmail.com>
In-Reply-To: <pull.1495.git.git.1681329955.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 14 Apr 2023 18:27:09 -0700
Message-ID: <CABPp-BEWaojwSpMaYT1VqNBYuhETm-QB9UyFsC-ePsu9B_e_aQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] cocci: codify authoring and reviewing practices
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 12, 2023 at 1:05=E2=80=AFPM Glen Choo via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Here's the followup to the discussion in [1]. Sorry for the delay.
>
> I've tried to incorporate most of the responses from that thread as well =
as
> suggest some guidelines that I think would make the authoring + reviewing
> process smoother. I've opted for stronger wording to make the guidelines
> easier to follow, but I don't feel strongly about the specifics.
>
> [1]
> https://lore.kernel.org/git/kl6l7cuycd3n.fsf@chooglen-macbookpro.roam.cor=
p.google.com
>
> Glen Choo (2):
>   cocci: add headings to and reword README
>   cocci: codify authoring and reviewing practices
>
>  contrib/coccinelle/README | 33 +++++++++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 4 deletions(-)
>
>
> base-commit: f285f68a132109c234d93490671c00218066ace9
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-149=
5%2Fchooglen%2Fpush-lsxuouxyokwo-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1495/c=
hooglen/push-lsxuouxyokwo-v1
> Pull-Request: https://github.com/git/git/pull/1495
> --
> gitgitgadget

I read through both patches, and I generally like them.

I'm a little unsure on the "To give a Reviewed-by" bit of patch 2.
For example, it could be possible that .cocci changes might apply a
few different kinds of changes, and say only 2 of the 3 are reflected
in the current tree, and those 2 types are handled correctly but the
third type of change is buggy.  The .cocci files would then be a bug
waiting to happen.  Maybe that's just a risk we take and it's okay for
folks to give a Reviewed-by even being unfamiliar with cocci.  Maybe
the wording should instead be "It's okay to give a Reviewed-by: on a
series that also contains cocci changes when you are unfamiliar with
coccinelle; just state that your Reviewed-by is limited to the other
bits".  Or maybe the instructions should just be to give an Acked-by.
You should probably have someone familiar enough with coccinelle that
they know what is worth worrying about weigh in on that aspect.

But you can have my Acked-by on the other bits.  :-)
