Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E5FC76196
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 00:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjDDAUR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 20:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjDDAUQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 20:20:16 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A746D171D
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 17:20:14 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id t10so123851022edd.12
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 17:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680567613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/z37p4hm/+VAnRxWPTbtuo99NnYwFGWbqOl/Pa+P02c=;
        b=Jefrh7L+rNSenyIoQx21OsqG1oihdCKiJQvc/h5WSTXReHLquhf7EmvIaogz3zLjTZ
         KxBQ7W+kQOKe7VCHeQXJX+e+A175jSVPQwFgwYpA5tifqJuEh/BqZX8dgm6OGqxJzd8/
         x6wbgmuO4pgr3PJM3ZXLWnmvwelF7lg3I7m2xTJo4PamGMw9hu4KllVMpJT0+mMdl1s7
         FUnpYWwUhPME/3Smpk9UNYEvbDuwOwss+1mTxOd3crOqogPCRr8Ze1YkclBjiFIEmh/J
         6qq01dkYVpPcNajpTbaBE+UR+FLEheJI73WwzT7Pi291OQhEJar69EAl81caynYtfPCf
         KzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680567613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/z37p4hm/+VAnRxWPTbtuo99NnYwFGWbqOl/Pa+P02c=;
        b=e90QNw+rUNQCiBZhlgZtobGk98osuNXYYUDKVPBmrsdhkyf6SpRLmCbLArzAsY47ir
         5chAk6k9K39amra9mM4n1RSd0BS0CPMazJefw1DlGycwL5V/wv1qko44AhlpQ6M81mRo
         DYuRjNbMFdaycVHThcvqeM/Zgy7yumgVEZoaaTzLXf1zinp2s4KmqwnEW3K0+RzuwT9N
         Hr8G8q/b39FIvJzWOOoPJty2LauOaXm1bvvufj6Li2UMPi/p/67VShKwxo9lfrqiMaod
         TN9f/Qqb4Ct2o7C+iNcfxl+tpK4lN7LuNIt1DNEFYKdPZ6PZvRWJDkqvb7aclxTB3aRK
         UTtw==
X-Gm-Message-State: AAQBX9fQ4H/jo2UoNel60NT6jcCvF6qX2szrRlxkA7LsOvaWTB9F5OF+
        bicOSu9rzKAjM1W7SV2B0UEEcR+zxTmwiQZaAvO0I29NqD8r4jolIzg=
X-Google-Smtp-Source: AKy350agDBanV1wsqr/7kZ9GqOtalsqr2+8tEPJ/pCvXSOgMFlVGTkWhmkHdfiMCBPz8GQmN2oDcoYq/DAseEF5SQ0M=
X-Received: by 2002:a50:d65a:0:b0:4fc:f0b8:7da0 with SMTP id
 c26-20020a50d65a000000b004fcf0b87da0mr518694edj.1.1680567612940; Mon, 03 Apr
 2023 17:20:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAGP6POLrtA_9kjCwUbVB8-F+dgQbhz==oy5SsXULfspNj_Umuw@mail.gmail.com>
 <87edp0ak45.fsf@vps.thesusis.net>
In-Reply-To: <87edp0ak45.fsf@vps.thesusis.net>
From:   Hongyi Zhao <hongyi.zhao@gmail.com>
Date:   Tue, 4 Apr 2023 08:20:01 +0800
Message-ID: <CAGP6POLVpjxO91s1dX98TLepXMrybSWq9y8qJ6b7w+e0SRJT1A@mail.gmail.com>
Subject: Re: git revert with partial commit.
To:     Phillip Susi <phill@thesusis.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 4, 2023 at 2:36=E2=80=AFAM Phillip Susi <phill@thesusis.net> wr=
ote:
>
>
> Hongyi Zhao <hongyi.zhao@gmail.com> writes:
>
> > Hi here,
> >
> > I want to revert a previous commit partially, as follows:
> >
> > werner@X10DAi:~$ git log |grep -A3 -B5 -m1 texstudio
> > commit f18fbd1e16a1ca4215621768d17858c036086608
> > Author: Hongyi Zhao <hongyi.zhao@gmail.com>
> > Date:   Sun Aug 1 20:01:02 2021 +0800
> >
> >     deleted:    Public/CTAN/IDE/phonon/compile-install-phonon
> >     deleted:    Public/CTAN/IDE/texstudio-org/texstudio.git.sh
> >     modified:   Public/repo/github.com/Dushistov/sdcv.git.sh
> >     deleted:    Public/repo/github.com/goldendict/stardict-relative/big=
dict
> >
> > More specifically, I just want to revert the following ones:
> >
> >     deleted:    Public/CTAN/IDE/phonon/compile-install-phonon
> >     deleted:    Public/CTAN/IDE/texstudio-org/texstudio.git.sh
> >
> > Is this possible?
>
> If you are comfortable with git-gui and gitk, then I would say just
> revert it, then click ammend the previous commit in git-gui, and click
> to unstage the changes you DON'T want to revert, then commit.  If you
> want to do it from the command line, then git-revert, then git checkout
> HEAD~1 -- ( the other 4 file names here ) will get back the other 4
> files then you can git commit --amend.  Alternatively you can skip
> git-revert and instead git checkout f18fbd1e16~1 -- (the two files that
> you DO want to revert), then git commit.

Thanks for your tips. I've also figured out the similar solution based
on the comment here [1], as shown below:

$ git show f18fbd1e16a1ca4215621768d17858c036086608 --
Public/CTAN/IDE/phonon/compile-install-phonon
Public/CTAN/IDE/texstudio-org/texstudio.git.sh | git apply --reverse
--3way

Because the commit I want to revert is done a long time ago, which is
not the parent of the commit I'm currently on, so I can't use the `~1`
which indicates that I want to go back one commit from my current
position.

[1] https://stackoverflow.com/questions/5669358/can-i-do-a-partial-revert-i=
n-git

Best,
Zhao
