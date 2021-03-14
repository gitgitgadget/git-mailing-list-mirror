Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4BAC43332
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 02:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C733164EE4
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 02:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbhCNCR2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Mar 2021 21:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbhCNCRA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Mar 2021 21:17:00 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFB0C061574
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 18:17:00 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id n23so5475734otq.1
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 18:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ablaWIPLacuG8BA2jdmoDslL5eXtuJcMt/RO+4ISU/0=;
        b=vQz4NZ9bpr5QG1chane/qhA5OQD826FsE2MLZTHAv2bMisiW+P97X7Gm20Mas9MbxQ
         7z4fJKWf5SYHRSJderNeXtBnxXi6EjtMkFtyvOZh2YiYotCN70PpF1I79VZpppK3re2r
         iAZAJFZVjO1QjZJhwcTmCvVgz+HPPbSMD0G3TcxhEgO7BhqExPYm5NFR5DwGgbyLiNtv
         zF2MAiwDlyNXCRLdjPNE2Z4/yBg1Rhd8Ir484tiVXggS4w7NQH4YH5i9B69Z59eTvs6E
         JfhoyWsTGrXfOEYOCybs6B6dvi0lFKxHe6y5iT0jV59hZTUJ1HXX0itkVJoIyePyqRew
         7V+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ablaWIPLacuG8BA2jdmoDslL5eXtuJcMt/RO+4ISU/0=;
        b=L75TVdfqangQAi1MjmgntfqoR352uSvvF89dtNmM/0moYDmFEeCmX6N/CAzAeqZfmJ
         PK/fdoou6nb/ezG7K7QYyr3JAmNmsLa+d0IK6POaL4rz4+OGISsCm95YzGXZ/+jVoBLO
         7NjYUvCGt1qJT+hhNrZiBLrSvKbHeFQFmVUiDdt0jX8h6g7ZCWZ8NvgacR+k/CDLN+CC
         OsXIcrInHZI6bDsZD3KIw7dC1oEPCGHCf1oMBm6XsDZRA5cM0kdF6j+pG8QdicyZGoGM
         i4PVafmASDDFznALVhJBRew+QpjtngEOOSeeN/4fdjhyjoCxN6llgxxEPiIGBRmw20H/
         LZtg==
X-Gm-Message-State: AOAM530bsziUgWOL948ckEwCy5Lupx73p63o4l4Icul05ZgrIAte5+vY
        1AkbM4hRBWMB/gZUph4/pRU6Ol+iLPR12rbJyvM=
X-Google-Smtp-Source: ABdhPJx+765HV7mdZdemgK7nOpJIGAYKkEZVF4CwnX5bGEnjCFLuGoELyAt/2X0SMn+9bYdG3WZ3q5NpPDeeAmcoxfE=
X-Received: by 2002:a05:6830:17d7:: with SMTP id p23mr8995694ota.164.1615688219556;
 Sat, 13 Mar 2021 18:16:59 -0800 (PST)
MIME-Version: 1.0
References: <pull.898.v2.git.1615278830804.gitgitgadget@gmail.com>
 <pull.898.v3.git.1615285726482.gitgitgadget@gmail.com> <xmqqpn0456lr.fsf@gitster.g>
 <CAOLTT8QhgeGim6ujqqyXwQ=bmQtJ43T5i3CPmNMPmBr0amR-HQ@mail.gmail.com> <xmqqwnua4ozy.fsf@gitster.g>
In-Reply-To: <xmqqwnua4ozy.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 14 Mar 2021 10:16:48 +0800
Message-ID: <CAOLTT8TT6rKdF-quS-t3X31PfQcrHPom4Rk5LcrMUBKha78MGg@mail.gmail.com>
Subject: Re: [PATCH v3] [GSOC][RFC] format-patch: pass --left-only to range-diff
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Taylor Blau <ttaylorr@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8814=E6=97=
=A5=E5=91=A8=E6=97=A5 =E4=B8=8A=E5=8D=887:23=E5=86=99=E9=81=93=EF=BC=9A

>
> Yes, it would be, but that is why you need to educate users what
> causes it, and what the right way to avoid unrelated commits from
> appearing, and how this --left-only fits in the solution.
>
> If some of the time, "--left-only T1...T2" would give you the same
> result as the more strict "B1..T1 B2..T2", that may be why users may
> want to use the "--left-only" instead as an easy/lazy alternative.
>
> But I suspect that it would give an incorrect result some of the
> time---for example, in the above example, wouldn't one of the
> commits labeled as 's' be completely hidden?  And if that is the
> case, the end-user documentation would need to warn about it, and
> explain that it is a easy/lazy alternative that can produce
> incorrect result in the log message.

Thanks, I will try to illustrate these issues in the document.

My another thinking is:
Since `--left-only` inhibits "B1..B2" and "B2..T2" ( let the user
choose the left B1..T1 ), To some extent, `--right-only` can also
add ( let the user choose the right B2..T2 ). A separate `--left-only`
will be strange to the user ( If user call T2...T1 ). Since the
`git rebase --apply` will internal call `git format-patch -k --stdout
--full-index --cherry-pick --right-only ...`, I don't know what to deal
with this `--right-only` yet, because I don't how to teach git to judge
if the `--right-only` is pass from user or `git rebase --apply`, Is there
any good way?  If can solve this problem,  the user can choose the left
or right side of the free choice. (Or users don't need `--right-only?`)
