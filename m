Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA734C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 12:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2C8D611BD
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 12:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbhFHMzn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 08:55:43 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:46816 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbhFHMzn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 08:55:43 -0400
Received: by mail-io1-f54.google.com with SMTP id b14so7014715iow.13
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 05:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jf1Mbgwcg4JoGi9C2mwXHP4HWB/AclAYYKTaVo6/sSQ=;
        b=NkQxN0IF5cD9It/0cSbJTY6qeJaWedjPfNWx2bdi1zJqb2cTISlU9GjEIwVCYT/tCV
         Fi+aRu5ES823dM3ZEQiJ0mL51S5cpDmSsqJOVETL7rl0zs+ug5QoMpPlKhsx4VHYRdu+
         gfsnctPi2cUFsJK3oKlI1Tk+40FM3OO0cW+1kEB6al9SUc8UQ3rWt5Lx4DTqEQhK7AC7
         /Qcr79+OBJAHcPbaihzzFqvAe/Ose8ayNmUkLEFc2AxWALPDwxV/OW2XoRfuFwEExbk4
         yZewCy9nQdfzYFVTGVnRjedVwKb2V+x97/fR2Iy+cT3iJnKNfbAQrqvT/uKrzA69LX0t
         hCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jf1Mbgwcg4JoGi9C2mwXHP4HWB/AclAYYKTaVo6/sSQ=;
        b=kkm8zhIxnJ6WXqER4irlwn9b6PGT+TBfh/zeJbfJSsLxucc1Ec8MlU2UKMF2d9eiSW
         2VcgHDVd9l1CZWG2ZZl1oyj8pJJUl/4OEiy+1KWzqE/Vh/VpU2Azjt5WK8E8AcrTre5q
         fQ4ux6OFBE3pSwjGNViWDj7fCC4ImbqQHzuSPpeEqX5NqzON8XJDO1Wrr2gMvPMTAr00
         U0UMbEgWq9pro0Qu7uoF8Nhg3Ly6hqu3klqsbWxNLKvsrpCyqSn32xnRJmJlS1kiEy4Y
         SkH0Uy6VpZ+23uZ9CtmD4Y42BBEvcmZGnZT8xIjcyzHfbSgBsAGW/bIZPyq0tBmtv8uC
         UXHA==
X-Gm-Message-State: AOAM533C2vZPu4b7Nl/Yd1duUiLmNHyn4mq9D0pzXiuXmXK+RbKu7/L9
        vj9XjehXu0hPT6X8n5qoaCjl/8UQ+kveKuBLsSY=
X-Google-Smtp-Source: ABdhPJwcTV9RnuH2DlWQAyqQzMx+3g1UqnBZCYZXhK+xg+aEOfQaDAWyYvcpSYj8FAG7otCCFTar/hFKcN3kmeSUcec=
X-Received: by 2002:a5d:814d:: with SMTP id f13mr18427693ioo.203.1623156754238;
 Tue, 08 Jun 2021 05:52:34 -0700 (PDT)
MIME-Version: 1.0
References: <pull.972.git.1622884415.gitgitgadget@gmail.com> <xmqqtum8q2lm.fsf@gitster.g>
In-Reply-To: <xmqqtum8q2lm.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 8 Jun 2021 20:52:23 +0800
Message-ID: <CAOLTT8ThnwfrbMxWaFptK=6Eh7EE-qavRWxyq3FWy3vVCVva_g@mail.gmail.com>
Subject: Re: [PATCH 0/6] [GSOC][RFC] ref-filter: add %(raw:textconv) and %(raw:filters)
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

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=888=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=882:42=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > ZheNing Hu (6):
> >   [GSOC] ref-filter: add obj-type check in grab contents
> >   [GSOC] ref-filter: add %(raw) atom
> >   [GSOC] ref-filter: use non-const ref_format in *_atom_parser()
> >   [GSOC] ref-filter: add %(rest) atom and --rest option
> >   [GSOC] ref-filter: teach grab_sub_body_contents() return value and er=
r
> >   [GSOC] ref-filter: add %(raw:textconv) and %(raw:filters)
>
> I haven't gotten around looking at anything after the %(rest) one,
> but
>
> https://github.com/git/git/runs/2770688471?check_suite_focus=3Dtrue
>
> seems to tell us that there is "size_t *" vs "ulong *" type
> confusion, possibly around the textconv thing.
>
>

ok, I will change it when we use %(raw:textconv) next time.

Thanks.
--
ZheNing Hu
