Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1ECC433B4
	for <git@archiver.kernel.org>; Mon, 10 May 2021 13:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D51861421
	for <git@archiver.kernel.org>; Mon, 10 May 2021 13:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237532AbhEJNmO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 09:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350734AbhEJNFb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 09:05:31 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AA8C06138C
        for <git@vger.kernel.org>; Mon, 10 May 2021 06:04:26 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id m12so24417179eja.2
        for <git@vger.kernel.org>; Mon, 10 May 2021 06:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=VHpMyZPhYwArKtmgLDoiMkWsaNCSsUtj7Pql1tzsrJ4=;
        b=lDmQzcfztbms/wqXF77YH/3GY+40CxI0SPm1FMV+pYKT81IK7XxsGpytd1YuT2CTya
         RqM1t4Oh464oYeY90lDgiKfPCY0mHvrVpPFALlLYlmyzXN3sAyOB4X4eLlJERlpamPZO
         JnfUomHGLtEuKXoHXoB5K9fEaNu6sSwvGaMmpsYBj0bRuz0wmpX419HlrYJEtGCpEpIv
         CYH+tQBpXhsQZlXnZjIbVDExvtrgv6H0chZGCTZ2LtHLzvOlMAEzqtsx60HC0bTm33lw
         H92Yz9AWXxuI4xaJ4Q02e/uTMgaaFcbfZoaSmgwvyrPZ/IFQwmGnRC9tdxuIVw9Jwtn/
         /ZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=VHpMyZPhYwArKtmgLDoiMkWsaNCSsUtj7Pql1tzsrJ4=;
        b=WlCnTDtaqUgnSw36qk+uSPYQZ1iG/TMD+QJLOzJQIhAg4JDXhohqk++5GYpjZs32xG
         vWNPzq/2qZP9u01c165roX/Jo3AnLkX3GK23xEJ58stEa8q4UGrRnN62cdmzF4u7NP6I
         nWapUCamVkbm7v7mUpeS1BnirusT2wD2HCyS6bOA0x9Bxl8sXDoRsTennKzUNQYeYEEM
         /qhE/SC/B8wrc0uz1O0KQO9EHTdVCApwPhPw74tc5NpvITsujVQnHJXmwMDGl98xoWiV
         z5ESFRaOlyaa3zk//fcRmI/lRnZYcfhwzAqsVls3eBXoajnFMFGkYF8J7rbUe9xsUKjO
         EwHA==
X-Gm-Message-State: AOAM532t3VOvZaldoGLriCuMjBia6BU1tsnNfOXd5oOLMvBDwtvv1tcr
        p0C0wlxWL5mT9URDIOiXClo=
X-Google-Smtp-Source: ABdhPJxGJ8oSYnSM+H+LIjjePGKmu/jxz7b0IFeGvoZ+BHuqM7WXuvAMJx/e84zWdBtf6V98g9FiMw==
X-Received: by 2002:a17:906:8a78:: with SMTP id hy24mr25975216ejc.39.1620651865376;
        Mon, 10 May 2021 06:04:25 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id h13sm5725402edb.65.2021.05.10.06.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 06:04:24 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] maintenance: use systemd timers on Linux
Date:   Mon, 10 May 2021 15:03:50 +0200
References: <20210501145220.2082670-1-lenaic@lhuard.fr>
 <CAPig+cQks0_nL1J4YUbEUjmWYLKrhuHX-f8PkWM2zFE4gybWMw@mail.gmail.com>
 <871ralwfo8.fsf@evledraar.gmail.com>
 <2224656.qFoTrlakfJ@coruscant.lhuard.fr>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <2224656.qFoTrlakfJ@coruscant.lhuard.fr>
Message-ID: <87fsyuu4dj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 10 2021, L=C3=A9na=C3=AFc Huard wrote:

> Le mercredi 5 mai 2021, 14:01:25 CEST =C3=86var Arnfj=C3=B6r=C3=B0 Bjarma=
son a =C3=A9crit :
>> On Sun, May 02 2021, Eric Sunshine wrote:
>> > On Sat, May 1, 2021 at 10:59 AM L=C3=A9na=C3=AFc Huard <lenaic@lhuard.=
fr> wrote:
>> >> +       strvec_push(&child.args, "--now");
>> >> +       strvec_pushf(&child.args, "git-maintenance@%s.timer", frequen=
cy);
>> >> +
>> >> +       if (start_command(&child))
>> >> +               die(_("failed to run systemctl"));
>> >> +       return finish_command(&child);
>> >> +}
>> >> +static int systemd_timer_write_unit_templates(const char *exec_path)
>> >> +{
>> >> +       unit =3D "[Unit]\n"
>> >> +              "Description=3DOptimize Git repositories data\n"
>> >> +              "\n"
>> >> +              "[Service]\n"
>> >> +              "Type=3Doneshot\n"
>> >> +              "ExecStart=3D\"%1$s/git\" --exec-path=3D\"%1$s\" for-e=
ach-repo
>> >> --config=3Dmaintenance.repo maintenance run --schedule=3D%%i\n">=20
>> > I see that it's in POSIX, but do we use this `%n$s` directive
>> > elsewhere in the Git source code? If not, I'd be cautious of
>> > introducing it here. Maybe it's better to just use plain `%s` twice...
>>=20
>> We use it in po/, so for sprintf() on systems that don't have
>> NO_GETTEXT=3DY we already test it in the wild.
>>=20
>> But no, I don't think anything in the main source uses it, FWIW I have a
>> WIP series in my own fork that I've cooked for a while that uses this, I
>> haven't run into any issues with it in either GitHub's CI
>> (e.g. Windows), or on the systems I myself test on.
>>=20
>> I think it would be a useful canary to just take a change like this, we
>> can always change it to the form you suggest if it doesn't work out.
>
> Based on this latest comment, I left the `%n$s` directive in the v2 of th=
e=20
> patch.
>
> Let me know if that=E2=80=99s still OK. Otherwise, I=E2=80=99d be happy t=
o implement Eric=E2=80=99s=20
> suggestion.
>
> Note however that this would be a =E2=80=9Cpoor=E2=80=9D canary to check =
if that directive is=20
> supported on all the platforms on which git has been ported.
> Indeed, this code is executed only on systemd platforms, which means quit=
e=20
> recent Linux systems.
> Should this directive not be supported, I suppose it would be on more exo=
tic=20
> systems.

Indeed, although we compile it on non-Linux platforms, so we'd expect to
get complaints from smarter non-Linux compilers if fprintf() is given an
unknown formatting directive.
