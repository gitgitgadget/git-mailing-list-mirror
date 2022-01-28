Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FA4C433F5
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 15:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245534AbiA1PLa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 10:11:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245354AbiA1PL3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 10:11:29 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C85C061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 07:11:29 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id k17so19340667ybk.6
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 07:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yb38KhIEDw+K31Mk0HQwEde8/zpOT8MrpKNrn9wYai8=;
        b=Db/aIKisljVH5YTWxQxtAA7SngI/i+kxZXvZcWvRLWBknJYEtWgZPVFZopXFyGCOzI
         BnhhqGhazJlHG6xGrzf76WPwTjoDS7Z1sR/COso8Mu6uev8khM8iX4F4CFbioSVcs2KR
         zHPLRmvjfmLdKImG5rgsXLbbD2pY5PKnRew3bN7VRA78pYLwUrTIt7X6N/tAjGW+jZmK
         9XDaTWXQqR+1k3S/eAtU7DLw9sPnNhGYqSEyxMEYyAbHMuUZBMifvbTodtAFBlo3vEwm
         ey5o4Xr4DaSwFTTJoF8/QgKpZmtP+TW8QlQrHmi11aZe0ruUVauwDNc5DBXsITPbXrbP
         ikNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yb38KhIEDw+K31Mk0HQwEde8/zpOT8MrpKNrn9wYai8=;
        b=qxCbu2ozLDws+WVMOuuP3VjdQrx/yrgRqGeKAJ1vvf0jIRhdenOurssypAohNnzsMv
         YboC6rGLbI5PBlVnORewplntx2wxm8nQiWLvgQ+VUJqdk/XN87zCZEGRUP3TY4vvepWy
         wx2jvz/xNe/A2LB6Jm7FK3GOWLJOPK2pDABtaBgKchHjPWdhQIbJ01Ht6qAdcA/ePibk
         yzCL7qPcwRFbbrIWgl0EU0H/ZtTB6/57QhXK7yYIWRoQG8rpRhuJmiUMwOC/hwv1zPR0
         J/OYFDLl4DlqQ+t+8v++wncC6j0HljzRHXmUDY+hpYJa10W4g3R4N9Yrt3GLi/I9L1AS
         Pvwg==
X-Gm-Message-State: AOAM530veA5WBr4kUKD6raG5LDXNm1j9X2PhPI5HFaTQ8f7XRUlODfEg
        ETF9yNlxuuRu3FCsA0pZ6iZMdXzteqHbvPltfYY=
X-Google-Smtp-Source: ABdhPJyRbWW7mMyjfevdgzlit3wR2NiUQUKyv5T/B2BsSw8XROdI+DxIyVdiDLHcU32b1udde/G8sCpnYLxMcoLRsE0=
X-Received: by 2002:a25:ab24:: with SMTP id u33mr3379133ybi.59.1643382687839;
 Fri, 28 Jan 2022 07:11:27 -0800 (PST)
MIME-Version: 1.0
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com>
 <CAN7CjDC+O883DB1iaJAXF5ZCis7FP2Z9z0y2qS2-JVAKfQA8aA@mail.gmail.com> <nycvar.QRO.7.76.6.2201281336410.347@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2201281336410.347@tvgsbejvaqbjf.bet>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Fri, 28 Jan 2022 16:11:16 +0100
Message-ID: <CAN7CjDC+A08tq-6bfxMUH_VcEZHVOr=BpWEiuuinBj7ufnch3g@mail.gmail.com>
Subject: Re: [PATCH 00/11] Finish converting git bisect into a built-in
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

El vie, 28 ene 2022 a las 13:42, Johannes Schindelin
(<Johannes.Schindelin@gmx.de>) escribi=C3=B3:
>
> Hi Miriam,
>
> On Fri, 28 Jan 2022, Miriam R. wrote:
>
> > I had done the last commits to finish the porting of git bisect command
> > since my Outreachy internship two years ago (
> > https://gitlab.com/mirucam/git/-/commits/git-bisect-work-part5-v1), and=
 I
> > was planning to send them in the last patch series during this February=
.
>
> Oh sorry! I specifically went to look at your fork before starting to wor=
k
> on the patch series, but had not seen that branch. Now I updated my
> remote-tracking branches and see it as a new branch, so I am not sure
> whether I missed it or whether it simply wasn't there.

Hi Johannes,

the branch  ..part5-v1, I think it is from the last month, but the
commits were done like two years ago during my internship and they
were also in this branch
(https://gitlab.com/mirucam/git/-/commits/git-bisect-work4.7). But
don=E2=80=99t worry. Of course your patch series will be way better.

>
> All in all, we did very similar things. I have a slight preference for th=
e
> more concise version that does not use any command modes (and therefore
> also does not duplicate the commands in the output of `git bisect -h`).
>
> Maybe you could find time in February to review my patch series? Not a bi=
g
> deal if you're too busy.
>

Haha, I could review it, but I am sure they will be perfect.
Ciao,
Miriam.

> Ciao,
> Dscho
