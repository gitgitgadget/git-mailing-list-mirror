Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3962FA3741
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 14:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbiJaO0x (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 10:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiJaO0v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 10:26:51 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA25A640A
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 07:26:50 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 63so13890234ybq.4
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 07:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/EPCTpjaIi3RdVAwX7PuE5TOAhK6L1251Yn8ZWxoZ4=;
        b=EMW6dELiFe95bMDKSennbEUajWjcQ5iMW+wcBV8aFF9HNtrgVkgj3rxyHbLGI/cem9
         8PFNbF/va6/LLZDb5A7xx4EkiDoZ740dg19dLUzTeU7m3m7PI9F1fg55v1dWbskYNGhn
         idTSXCmKQ9HXq+FvKR7d+TpvwbqHt2IS94Ok750Vs55zReUxtQV36YF0NnE4KskgF1bL
         G+pmWtjuW0inxx1E3ED8I/AIOoobO36WEVEShLH/anTYuE9hNEySlImho8kwPN+etiQw
         J73GxeE20zJ6HldWMgNtHc6VSMLbcBJvpuIk6OVvAEShBb3QmOAzRqR25EQd6GLoaIns
         UGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/EPCTpjaIi3RdVAwX7PuE5TOAhK6L1251Yn8ZWxoZ4=;
        b=2peHJdirSg0ApLcaXPi7s4TEirXDFyAc6cS5LbtdmqI//Yb02mN5nco1vMqDHLdGBx
         JLFyIaYx48WmxZvvtCwOca0edobO6f4jqojzmARUy8pbvIj3EDOqObv4Amojm9KQP+ZX
         fHDZrcB/m06zBbKQdQjCDCJjDnjulNYYXumH1fVFtJyBQDaFJxQuMP6Lo0GCY9V3loc4
         wgQ9jJzOf4m/Db99In/GKgPVz7eb2nr3m4Pn59uSzm7iP/iEkeOAvhqtBuLarVrQB/7w
         QFCpzKRncwKZaKbVY37K0SJTjC8iB30eiQT9+tdV8X9zCt5toGDAMJa9G2VxT4ufdS3G
         xjKg==
X-Gm-Message-State: ACrzQf3xbdnSVf666ylouCV9D+7zgj04vUMo3uUMwMt4tHv11Z0FAwRa
        q+38t2WsWLN3Y824f0ucMa9CFpTGjXU9Pt73rVxhXmzgj1x56PwXxDg=
X-Google-Smtp-Source: AMsMyM7l8ldnMdq5q5zM0VXbTujrWbwG2uJ0piGpE0x3WG01pN8gwdr9aLl3fNgrcTD7erKRZRqi5Zc/xIdSC7YRg98=
X-Received: by 2002:a25:c1c2:0:b0:6c4:318:642f with SMTP id
 r185-20020a25c1c2000000b006c40318642fmr12060633ybf.561.1667226409839; Mon, 31
 Oct 2022 07:26:49 -0700 (PDT)
MIME-Version: 1.0
References: <CA+PPyiE=baAoVkrghE5GQMt984AcaL=XBAQRsVRbN8w7jQA+ig@mail.gmail.com>
 <CA+CkUQ_pqQomaA=MO78PsC0oA8GcE0dJ415fpjcLx6k5HNaDiw@mail.gmail.com>
In-Reply-To: <CA+CkUQ_pqQomaA=MO78PsC0oA8GcE0dJ415fpjcLx6k5HNaDiw@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 31 Oct 2022 22:26:36 +0800
Message-ID: <CAOLTT8QygkMyjFqxsOo8fqh3yWE3najwv+Y8ekr8MP9d_+dotg@mail.gmail.com>
Subject: Re: [OUTREACHY V2] Unify ref-filter formats with other --pretty formats[proposal]
To:     Hariom verma <hariom18599@gmail.com>
Cc:     NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>,
        git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Hariom and NSENGIYUMVA,

Hariom verma <hariom18599@gmail.com> =E4=BA=8E2022=E5=B9=B410=E6=9C=8828=E6=
=97=A5=E5=91=A8=E4=BA=94 16:08=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> > Olga<olyatelezhnaya@gmail.com> has done great work in =E2=80=9CUnifying=
 Git=E2=80=99s
> > format languages=E2=80=9D during Outreachy Round 15 and continued even =
after
> > that [from 28-09-2017 to 04-04-2019]. Her work is mostly related to
> > `cat-file` and `ref-filter`.
> >
> > She already did a pretty nice job in preparing ref-filter for more
> > general usage of its formatting logic. It will give me the possibility
> > to make the migration of pretty.c easier.
>
> ZheNing Hu continued the Olga's work during GSoC'21. You can tell a
> bit more about that too.
>

I'm afraid I'm skeptical about the progress of this project. Yes, this
project has
been going on for too long, probably 3 years, and it is long overdue
to be merged
into master. Maybe we all need to rethink the nature of this project instea=
d of
rushing to start writing code.

As far as I know, these unified format refactor are easy to implement, but =
as we
use more complex parsing logic, there will be a lot of performance degradat=
ion.

I recommend new contributors to perform performance analysis and performanc=
e
optimization directly based on the original developer's patches.

> --
>
> I would review the rest later.
>
> It seems like you used my proposal as a template. Just want to let you
> know, you are not restricted to using any particular template. Feel
> free to add or remove any section you find relevant.
>
> Thanks,
> Hariom

I will pay close attention to this issue.

Thanks,
--
ZheNing Hu
