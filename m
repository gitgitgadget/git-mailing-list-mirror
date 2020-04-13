Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BFBC2BA19
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 11:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 323FB2073E
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 11:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wv3uvTup"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbgDMLQa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 07:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728096AbgDMLQ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Apr 2020 07:16:29 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A01AC0A3BE2
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 04:16:29 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id t10so5055542ybk.8
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 04:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DICoL1tF4+dbFc6KsBwzWE5Wu5Nt5bOnAGm3QG5ldd8=;
        b=Wv3uvTup7NcDrwFl9J6dpTNLbioaEbxMrSjT1eJ9luNqedosY8xvwra22GI9D50WU0
         hmEI+lLf2q/gUOfdaLUsElTzEMMEyRUHEbSi2tTiutvyTdsx/oAZlS8VZU/Sv3lbbEeO
         7buvb8AJJMPrQ4IIu6Nj5DpgU19fFSryZiNp8hUvjL6EtWwuZyEhqyhIH5o2m8VwkmBZ
         gfeI5bZI6QSdL4xaoyVVM5TtfzijhSdRPIfWYGd7QpuEcPeexJ060VxxmpNVdZiuQed1
         yHFRrqAOyYgw23RNbI2MowCI+Uv3+7hQxE5+sl1eA0JCI4HM3QMeGo35WON6bKNYnUbb
         4CSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DICoL1tF4+dbFc6KsBwzWE5Wu5Nt5bOnAGm3QG5ldd8=;
        b=p1bQS9yPVLk3yb0pLIH+mf1qjmIoK+kPBBGGkxB9d1zXcY4QnHg1K+QqY+x12cRYvz
         pGo4zjfkXxAYSjlDTfQf+MKUdT9d6XwbQ85iQoHQ9fTadQyasG6tuTnsamYMeoVCnA+u
         /yJUk285FMnvAVhcwAYjSdhcM9OZF53hcFPW2PDBKnIajLmrJ1y1EQLvpvzQtyv15zNG
         C1hqg3NKJ1Zle4r5oolD/xaWHB6dAKdjlq2Y/X1YOR1W2GYzREUWg3a2zcZY6s2Cfb+G
         JnsNJsDsevwMcy2zeVRWjPziKKKs7cpLoBIWMWalDlT79V8SHyM/YqG+QgvgOacx7LKD
         U8Lw==
X-Gm-Message-State: AGi0Puba73/WQpKv5vCuoXJlAmN15nPaYXQPhUBzGdGnC0rAP8KCdhIq
        kzCrU7vZrE9//Kiuc4aVFXlYW+1KbaTJ2mTpzT0=
X-Google-Smtp-Source: APiQypIyIpfSkt/S0y6Jm97hWQoaOWd4wnioNXCmceYt587ZN7gDnFJxLAH2JnB4lIb6pjQyczMioZUwCUW026Ieo3s=
X-Received: by 2002:a25:d993:: with SMTP id q141mr27445946ybg.403.1586776589010;
 Mon, 13 Apr 2020 04:16:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200407120813.25025-1-worldhello.net@gmail.com>
 <20200412133022.17590-4-worldhello.net@gmail.com> <xmqq1rose65v.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq1rose65v.fsf@gitster.c.googlers.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Mon, 13 Apr 2020 19:16:18 +0800
Message-ID: <CANYiYbFkO9H01JGwFWzqdpo7jFMU8VMNh-0H7sLz6kd8x8_Xjw@mail.gmail.com>
Subject: Re: [PATCH v10 3/8] refs.c: refactor to reuse ref_is_hidden()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2020=E5=B9=B44=E6=9C=8813=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=885:38=E5=86=99=E9=81=93=EF=BC=9A
>
> Jiang Xin <worldhello.net@gmail.com> writes:
>
> > From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> >
> > Add new function `ref_is_matched()` to reuse `ref_is_hidden()`. Will us=
e
>
> ref_is_matched() may not be wrong per-se, but I would imagine that
> ref_matches() would sound more natural.

Will do.


>
> The ancient varilabe hide_refs is probably misnamed and should be
> renamed when the codebase is quiescent to hidden_refs but of course
> we shouldn't do so before stablizing this series.
>
