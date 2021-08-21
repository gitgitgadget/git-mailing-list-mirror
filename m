Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A91C4338F
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 05:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C23016115A
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 05:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhHUFRJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Aug 2021 01:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhHUFRJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Aug 2021 01:17:09 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B75C061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 22:16:30 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id g9so14930545ioq.11
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 22:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y/dN7oTXXBvNlrqA3vkPbJbO3DxnGfECi1t87XuA+RM=;
        b=QGKOG9C0umbAvsfC+bx2FeCmL9GLE5eB4INEUBs0oaXnN3A1P+5rFTyolGByxpXp42
         ZdAtbDXMXALUX1d6m9tTd+xE2goI9zu5V6L6zkh9PKS1O4f/ffNfLu6gJDSJVAIRA3GD
         YvdJoEimHKxPtK6uO19Vzgh+B5ie7vazeMrTgJdtn1ZnQnw4YrE2TtcmU+/cjdtHqaH+
         pSMkOFePZT1fNNj9xSHWzjkqu+lVhtAokT0kBkXw9I40DuxBLEj+w2OboWfpzLx/jos7
         HCbixu0+djRqF1x1UR7r2WOqsj+xN1kpLEsN4yNiHVWkewx0ptOdQYQOG4SlF73W8/16
         LEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y/dN7oTXXBvNlrqA3vkPbJbO3DxnGfECi1t87XuA+RM=;
        b=ID/W5cIjMi69tvBziKaUTw0CHrykH4u+nL1BPqKIte61PZbuU3wrbcTVdscCcQfRHi
         zaJODavkgLQCboP0TjvRi7L9N/bO7jvyTK1hPYsV9HEmyFCsQr8gRLdwG8bTIdFZleyR
         kWDL4ophSq66VVajR0BnaONREnVGZhkvW2YbNLhbvictOgVinc1BXY5mDDMf940k19bk
         PnSfuG51Je+JHYWNII2BzBfj1qM8fDkDLUufcyuvLJUJf1KCxvHeIsGAGEdPxJ3cGuN4
         zDwmndkRE0chQjcMgk1/a6LSiWyK0NDL7W6Yw2uiU5MLHXBVKWO71yKqo+Xzluv5Ke8l
         JWAQ==
X-Gm-Message-State: AOAM530K+eV+QjJQ61qP3XESkSgVVIF+epWIlvTvWi0I7Zgkp02cFQhB
        K+Y8d3IjPYBuehiKjk6SCr/8xrjohtpVEgEQSXQ=
X-Google-Smtp-Source: ABdhPJwBEwz9s404zVGHSarhNfsU+U4niUBHC8W7Z10Ty1mHLDpLsvff7rq4V4tYs/teWWU7hCLioovDUFthUVe1Ku0=
X-Received: by 2002:a02:1dc9:: with SMTP id 192mr5764836jaj.92.1629522989684;
 Fri, 20 Aug 2021 22:16:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210819091433.348-1-chenan.xxw@alibaba-inc.com>
 <xmqq4kbl2sre.fsf@gitster.g> <CAHLXgnYsQcfgddNHdH+geoczq8isgLaf-b3oLzjNS+m96N5ESg@mail.gmail.com>
 <xmqqsfz3sa0m.fsf@gitster.g>
In-Reply-To: <xmqqsfz3sa0m.fsf@gitster.g>
From:   Xiaowen Xia <haoyurenzhuxia@gmail.com>
Date:   Sat, 21 Aug 2021 13:16:18 +0800
Message-ID: <CAHLXgnYZ9Ae2+3oRxwMVtyCFAq68OCH-AcV41MxAfUzd2_GFKQ@mail.gmail.com>
Subject: Re: [PATCH] add http.maxReceiveSpeed to limit git-receive-pack
 receiving speed
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net, worldhello.net@gmail.com,
        Xia XiaoWen <chenan.xxw@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Got it.

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=8821=E6=97=
=A5=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=8812:21=E5=86=99=E9=81=93=EF=BC=9A
>
> Xiaowen Xia <haoyurenzhuxia@gmail.com> writes:
>
> > But this patch is similar to the `http.lowspeedlimit` and `http.lowspee=
dtime`.
> > And `http.lowspeedlimit` will not error out the negative values:
>
> An earlier mistake by others does not make it OK to make the same
> mistake knowingly, though.
>
