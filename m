Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC99C77B7F
	for <git@archiver.kernel.org>; Mon,  8 May 2023 14:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbjEHOyf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 10:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjEHOye (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 10:54:34 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F49133
        for <git@vger.kernel.org>; Mon,  8 May 2023 07:54:33 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64115eef620so35035498b3a.1
        for <git@vger.kernel.org>; Mon, 08 May 2023 07:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683557673; x=1686149673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujD2F2r8nullnV934vhLAPvdwMrJQ86bNB3gDG1YYPc=;
        b=LOIhJ/7oeyfb3P8KtPJ0RF3x6jiK4kGPpESB6xkXNrp0rrmhOiXAUuII0bMaZr7s2r
         Zx8P70vmk5oS26nkdiSoYmZjP7+aThSCjmJ2rSr+hbwAwn4mhNnp0pWfripaa4dV3El1
         9ei3D7UPj8Tb0WtKDV0KaWxv4c9e16r9uUoKqplzUki5N0qpIv2s/RwIumEHvQAOYACZ
         IsOHr2vxHe+ycq4bKH6rlZR9XaivX0NRSY0M2iOW3hBYkw5yTP9KtszyNFFVUzSoxQeu
         RJbSC2LSKm3IHS6IHSjv9GTpMFNlEbVFTAR/5Gy8xIg8ZFRVTemFbhCOkOhi63sFoNG8
         INyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683557673; x=1686149673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujD2F2r8nullnV934vhLAPvdwMrJQ86bNB3gDG1YYPc=;
        b=Km4LUxPgINHmmj3u6Rk1VF8G3HuRNbjr+as38wXZ/HbXcdRZGm8HBovh55x13IQ7yo
         c4NpWe+myT2jAMzqobsm4Kf+NQRUZoeIbP2WQSs8mTSeO0PfeLJU8R9aKyZUh+tddDkp
         uk4h8ErP0b707SFcgjq7stcEyeroW0xqM/UBUb49n4ntikkNc9fv5kIebSkm+fOh/Fgf
         WxDQ4axs6FSxsAGPFBYZTAi83/RMgSgjCD1Dy6oMxAGtnCQpF8rdvsCrnWskL/O4dpvq
         Mx+M7+tfrR/G7Sfdq3Nbw+LQGJe4eN6nRkrKTN56l5y1CkJWMDB0Z0dS74kUdAIpU28r
         W5DQ==
X-Gm-Message-State: AC+VfDyeMaewOZrN/Vaem3dxfaa3sy1Wtia+VYFU6XDkLkKYtQXQnijg
        haIu7wK+njX4hK4jHOd65Lv4kIoTL642tcMWu5ocqpug
X-Google-Smtp-Source: ACHHUZ5Rz+aq56slcykVNBJXUbKKGlqVhzV7d0L1AC/kw1yt/C8GT+maJn8PC+lMXgTRkxKvzjoNZtntsEx10TysjRY=
X-Received: by 2002:a05:6a20:144d:b0:100:8258:167f with SMTP id
 a13-20020a056a20144d00b001008258167fmr3578897pzi.30.1683557672974; Mon, 08
 May 2023 07:54:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAOvKW55oWs+atYyy-cTb=H0VhJx-V+M7_7FsqjdJ_jU9bR+8LA@mail.gmail.com>
 <a611877f-c515-033c-e015-f3952b520c08@gmail.com>
In-Reply-To: <a611877f-c515-033c-e015-f3952b520c08@gmail.com>
From:   Dan Stromberg <strombrg@gmail.com>
Date:   Mon, 8 May 2023 07:54:22 -0700
Message-ID: <CAOvKW571cxj6XBSBtmUzS-i9w_MfR9p2BOVMHS1Mc3d6CrWO-w@mail.gmail.com>
Subject: Re: Weird merge records
To:     Thomas Guyot <tguyot@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 6, 2023 at 7:43=E2=80=AFAM Thomas Guyot <tguyot@gmail.com> wrot=
e:
>
> Hi,
>
> On 2023-04-28 11:34, Dan Stromberg wrote:
> > I suspect the merge records may be coming from this small bit of shell
> > script I've been using to pull from the master repo into my personal
> > repo:
> >      git fetch upstream
> >      git checkout "$branch"
> >      git config pull.rebase false
> >      git pull upstream "$branch"
> >      git push origin "$branch"
> >
> > Does that snippet look responsible? If yes, how might I change it to
> > stop creating all those merge records? If no, any guesses what else
> > might be causing it?
>
> It is, indeed. This is IMHO something the developers should do
> themselves, in particular the pull may fail on conflicts and you don't
> seem to stop when it does.

It should stop on an error - because there's a "set -eu" in effect.

> Also note the first fetch is redundant, pull already does a fetch.
>
> So you could change your script to:
>
>      git checkout "$branch"
>      git pull --rebase upstream "$branch" || exit 1
>      git push origin "$branch"

I'll keep this in mind.

Thanks.
