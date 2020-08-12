Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AC9C433E0
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 19:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60ACC2080C
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 19:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWh+Ahv/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgHLT7I (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 15:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbgHLT7H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 15:59:07 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D14C061383
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 12:59:07 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id h3so2909743oie.11
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 12:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=OxBH99/AjHmrfNm3RZt+d/V57tWOX7E8Cbw949jcueM=;
        b=CWh+Ahv/z+m1qROSXF5CS69D5ysAJGhN9b8bloVDtVRekmlUaIZI/r7KKIozwkkNry
         WpB8dS4FFxtk6SCIHQw5+B3Ld3+mqdILtLxxuP9DpTDgCQHPtPAppbtHIO+c5rLwTjSl
         oiXRS6/IMgt31ln6RFmiQcImt2y/r3qN9QJmgr4+JdXGQw4Wo2MUTTfO8/mWk57wqS8v
         GMGnJHRPwiqtWq1+nk2JOvp/dLCFPfk7ke+5/6nLt2ISoW+zudAC9mua0xWt4KjOOzIw
         pY3zpJB8yvgSiO+ch+Yw81uEzEB1bM71ItPVIjNcUp4bGlm40ATBO0MJc2N0j6XYYb8Z
         MlwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=OxBH99/AjHmrfNm3RZt+d/V57tWOX7E8Cbw949jcueM=;
        b=dgJvqYnw9j3n+YuAaL0i32FODP18JydWK5IhF3+4m+sAeo7lDfJ2CxsbHhjC4FODuX
         59IE1ZlgVPNyHyJm2Auxv943sv8xHyIBRINaJm1AJGhUyQ6H55TPYh2AaZA2owdQIQT3
         ar7agLZ70jJwaWXzlqDC6ss+iUXpwh36tKhT1F9vwDyJUWNgP4hHU+B3dLyIBzjA3ZHz
         wSrgQoLis+dyQic4Mwj3Z4XO09L1bnhGWZ7QLDBsVG0lBGqBd377WSIhrmblMdZWwWzW
         vQ+Ns/q4GP9VfV3HERlXtfBtloxlWZQq/OvLv2kaFcJ77ab1V8Ri9f8MSWBD1RHMFwyS
         eeXA==
X-Gm-Message-State: AOAM5334umyWBIJXeI+CjoyH9PtBcDbe85DdGo/g6HeY1pK5DFOf/5mQ
        FZhP33clisfJdzQTagy4VxzPytI7GEn1I3rd/7KddA==
X-Google-Smtp-Source: ABdhPJzed2dxNA7mekKBpU3bX7Cj+A3voOAYI/DxhuVbDMpMUo/M5Yf66X7oMPlRrCvaUSxfflvGYXItv59+qdMJZRs=
X-Received: by 2002:aca:1706:: with SMTP id j6mr707495oii.60.1597262346405;
 Wed, 12 Aug 2020 12:59:06 -0700 (PDT)
MIME-Version: 1.0
References: <DA41ECC7-D5D4-4E85-A4C3-C55CC2A73D53@hxcore.ol> <27608194-0D85-4D71-8D88-C1278D8DA173@hxcore.ol>
In-Reply-To: <27608194-0D85-4D71-8D88-C1278D8DA173@hxcore.ol>
From:   Viktor Hozhyi <viktor.hozhyi@gmail.com>
Date:   Wed, 12 Aug 2020 22:58:55 +0300
Message-ID: <CAAkwws_Y56QF8XnsBgG+HSF_mRpetJGh6TnTbjCgdwZ88kov=A@mail.gmail.com>
Subject: Re: Files 'Test.txt' and 'test.txt' are different in Git database,
 but are the same on Windows file system issue
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 12, 2020 at 10:56 PM Viktor <viktor.hozhyi@gmail.com> wrote:
>
> Hi,
>
>
>
> I=E2=80=99m not sure whether this behavior is on Windows only, so it=E2=
=80=99s up to you guys.
>
>
>
> Repro steps:
>
> 1.         Having branch (let say) develop with empty working tree and em=
pty repository =E2=80=93 create 2 more branches (=E2=80=98foo=E2=80=99 and =
=E2=80=98bar=E2=80=99)
>
> 2.         Commit file =E2=80=98Test.txt=E2=80=99 with content =E2=80=98T=
est=E2=80=99 to =E2=80=98foo=E2=80=99 branch
>
> 3.         Switch to =E2=80=98bar=E2=80=99  branch and commit file =E2=80=
=98test.txt=E2=80=99 with content =E2=80=98test=E2=80=99 (pay attention low=
er-case)
>
> 4.         Merge =E2=80=98foo=E2=80=99 to develop
>
> 5.         Merge =E2=80=98bar=E2=80=99 to develop
>
> After it when you switch to develop =E2=80=93 you always will have =E2=80=
=98local changes=E2=80=99. You can perform stash, hard reset, commit =E2=80=
=93 you always will have local changes (and many following errors on other =
git operations due to local changes).
>
> Reason =E2=80=93 we have different files in Git DB (=E2=80=98Test.txt=E2=
=80=99 and =E2=80=98test.txt=E2=80=99), but when git restores them onto Win=
dows file system =E2=80=93 it just will rewrite 1 file with another, becaus=
e for Windows file system =E2=80=93 it is 2 equal names.
>
>
>
> Best regards,
>
> Viktor Hozhyi
>
> Skype: vitia444
>
> Phone (Telegram): +38 067 276 29 85
>
>



--=20
Best regards,
Viktor Hozhyi
Skype: vitia444
Phone (Telegram): +38 067 276 29 85
