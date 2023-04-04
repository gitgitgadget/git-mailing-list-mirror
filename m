Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C7BC76196
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 00:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjDDA2y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 20:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbjDDA2t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 20:28:49 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A040F5262
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 17:28:38 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id y4so124118905edo.2
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 17:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680568117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=naAqBM8E2OFkZmg4IMO8eHskLQa/ib2V28AZPKj2OAo=;
        b=BPV9iT4Y1OlWT3Z3M0tHFaUIXg7UngkTZg+WJOrroLLPUfaigI7/0gxP2VLwlGAtSC
         Xk5bt8F6uj+1P67i8W09lqQ8gRXXqT6WFcs6mJAJ60ux7bIZK011D4DJrT7Uw3X51YeC
         yZlHvGNTlUCEHxGngewg0f1svQQ52JS9EyCeQ7mflgKlVUUKnKqDKZ0jHUS4mkHP0dMO
         wgkaqAgYs03BTkYfVigTBco4AI/fm8rVgrVdFBWR3sRIVZczglTTP3sts2qEx9eA83QZ
         Bl4bRZuvDbknnyp6oWyDB4XkwKhgOfTd3S/G+Bhg+xLLSLEAIka7h5RX8iluugMr/nH9
         7P2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680568117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=naAqBM8E2OFkZmg4IMO8eHskLQa/ib2V28AZPKj2OAo=;
        b=eP4YHwCuJpsXrP1LzqNydZnk/aW85DI4tkNhUSyiq/jfz9cWK/ASD6oJSpNmwEhH2e
         OH/eP+f6ozntuBET/dnqDYmsFJHZ2YSwgFzLEnt6oRaCwBvDAxJzjisOv//U0dELH60u
         HVYdJogmlbCSr6gHJmfAnyPHQ10FNWM8YpEscXgCOwyGTaX+aSAnC/zEOJZ1hgdMUqTU
         w6/BoBIqu9h1VUGSA1qw1utJV7zy0/1zDctPi/wnKP8sfeVVXSW2LHm5j7miy8fXozgc
         K97iGMA4jqdo6j9eT+2h7m0exyczAsC7b/aK5xweuu1vQiUGRasFiNuItWIRMic3tb3P
         DaTw==
X-Gm-Message-State: AAQBX9dIP3gy0XHp5Rk2K4BWJ7pt3x9LHnc3GqAnEGMXmN0CCIqokfQr
        NnYj1klMY/ZsAB8EUMXJIB5pFnSTOQ0yTIQjiSM=
X-Google-Smtp-Source: AKy350ad69jvC2fWqyuNvEYDyMHmnqG9OWZtvmLE9R5Sjd+HvwHY2/QSMqIlMY+1HLmMuvh6r/SNy+WmREhhFbGZ+9s=
X-Received: by 2002:a17:907:6c17:b0:924:efbb:8a8b with SMTP id
 rl23-20020a1709076c1700b00924efbb8a8bmr276618ejc.6.1680568116934; Mon, 03 Apr
 2023 17:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAGP6POLrtA_9kjCwUbVB8-F+dgQbhz==oy5SsXULfspNj_Umuw@mail.gmail.com>
 <20230402141613.yeseo5fj3lafuf7w@tb-raspi4>
In-Reply-To: <20230402141613.yeseo5fj3lafuf7w@tb-raspi4>
From:   Hongyi Zhao <hongyi.zhao@gmail.com>
Date:   Tue, 4 Apr 2023 08:28:25 +0800
Message-ID: <CAGP6POLmDtwCnqZN3yBaiYj3VpdpH=bNnKhX6Dfu0NfyVVzYCA@mail.gmail.com>
Subject: Re: git revert with partial commit.
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 2, 2023 at 10:16=E2=80=AFPM Torsten B=C3=B6gershausen <tboegi@w=
eb.de> wrote:
>
> On Sun, Apr 02, 2023 at 05:17:30PM +0800, Hongyi Zhao wrote:
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
> It is.
> Find the last commit that had those 2 files, in other word the commit
> before f18fbd1e16a1ca4215621, say it is xyz.
>
> git checkout xyz -- Public/CTAN/IDE/phonon/compile-install-phonon
> should get the first file back into your working tree and staged.
>
> (Of course, this is out of my head. And you should be able to "restore"
> both files in one go.)

Thanks a lot for this nice trick, and it works like a charm.

> Good luck.

Best,
Zhao
