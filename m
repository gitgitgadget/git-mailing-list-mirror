Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799BAC47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 06:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 537F7611BD
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 06:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhFHGTP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 02:19:15 -0400
Received: from mail-il1-f176.google.com ([209.85.166.176]:34530 "EHLO
        mail-il1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFHGTP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 02:19:15 -0400
Received: by mail-il1-f176.google.com with SMTP id w14so8926609ilv.1
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 23:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PlXrM4dtEQ+bltNwyCnQEv+LBKNXwtlX8+Zw4Nsod0E=;
        b=JqBx6nQ7Kay+ivgBThast8AK0zhdhKjUJfmwS9aaf2aFahMBdYBGfBp9ugZspC+gGa
         eMinDgxLXfHBv89g3hoN2EAnI52pbsBJBwQCJDy8TiCPKu9foMtcELVXQxUVPnon92Dn
         SWMdgoTLqKcdQ6VPiY3UCibWq2VB0YNoYBHD8IQ2A6LIfZJJ7RWaSUUteVgZR+0Ov5ft
         bDBgw5H/ks/BMuO0prs2sM51L26uT1BsEEH+HU2Q1Mc4Jaf0JqHEqz+lpbjnAMc5Ba/7
         YuY/CkIDQxVlBzeZ4Yum3I8RUvGdv2846I+9lGwzMwnuYMdersw51LhaoN8h+lDEJuvm
         QJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PlXrM4dtEQ+bltNwyCnQEv+LBKNXwtlX8+Zw4Nsod0E=;
        b=O+1Iard3LLjAO/R0Xuk9IF9Mq8FQc6xgfeea8M1EjezMV47fz/E1EtmEb2o4P59mbz
         q74WHr6IUIF82YPBkUPf5gUgpeHJEq14daGmPJXRDZttmyXc3iVXRhzvCKO0p0To7vDR
         NSyYFSwGfouwKZ7mEpXiREu8vbmiSnw50KS56MfOOE/qhjMnHLzjBgORqFbuyRpqC2Fc
         F0cPp3TgRbWN9khWM4e1nd4+16pUiSqz6+6YngAmDOJllfxkSM6KiIaIavSzeuviqIef
         1wrENopYmiDv3CpztfDLSf949+IGkMKiFa60k6JOibHXS0ThdMtjEG7nNiRe1BORLQCO
         RxAg==
X-Gm-Message-State: AOAM533INVqoojGSBP57EXwRBzXtv0aEcWH9fGZ0XLf/V/rfFIrj/9hS
        x2ATvUkgwj7F5QILNc06Tu/RQTJHQY1miT1n4Q0=
X-Google-Smtp-Source: ABdhPJzkzLkTwALYrbrKoWUuYH6/d6NQxYnnMdle43CnMD3CHThmvXutY5/dRCQvJlhBOt6Z9GgNsQchuoJuc89WMDQ=
X-Received: by 2002:a92:cd4c:: with SMTP id v12mr12611923ilq.259.1623132982967;
 Mon, 07 Jun 2021 23:16:22 -0700 (PDT)
MIME-Version: 1.0
References: <pull.972.git.1622884415.gitgitgadget@gmail.com>
 <ccdd18ad508824aa206a02c479229d0ede69522d.1622884415.git.gitgitgadget@gmail.com>
 <xmqq7dj6w7a6.fsf@gitster.g> <CAOLTT8S+5m+-XF-AcQi9t8njTvyDYzHt=BU+4OPcvTT27RP6dw@mail.gmail.com>
 <CAOLTT8QE7pafPmhnz-6=5zuyjg9n1FNbu_k6bA80jE1e5vYCmQ@mail.gmail.com>
In-Reply-To: <CAOLTT8QE7pafPmhnz-6=5zuyjg9n1FNbu_k6bA80jE1e5vYCmQ@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 8 Jun 2021 14:16:11 +0800
Message-ID: <CAOLTT8TSue=Cx8xos20vnGSi3oOd8+=jTfTw2h82gXmmd4KyLg@mail.gmail.com>
Subject: Re: [PATCH 4/6] [GSOC] ref-filter: add %(rest) atom and --rest option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=887=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=889:18=E5=86=99=E9=81=93=EF=BC=9A
>
> ZheNing Hu <adlternative@gmail.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=887=E6=
=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=889:02=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Hope we can reach an agreement:
> > delete `--rest` and add `--reject-atoms`. ;-)
> >
>
> I forget one thing: %(raw:textconv) and %(raw:filters) can use
> the value of "--rest" as their <path>. But now if we want delete --rest,
> they can not be used for "for-each-ref" family, Git will die with
> "missing path for 'xxx'".
>

If we actually delete "--rest", we will have no way to test %(raw:textconv)
and %(raw:filters)... So now I think we can keep --rest (or use
another name --path)
and let "git for-each-ref" family reject %(rest) by default.

Thanks.
--
ZheNing Hu
