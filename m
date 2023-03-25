Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2639FC6FD1C
	for <git@archiver.kernel.org>; Sat, 25 Mar 2023 13:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjCYNYj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Mar 2023 09:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjCYNYi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2023 09:24:38 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF17755AD
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 06:24:36 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 31so3549959qvc.1
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 06:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679750676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgkjY7+B8eGC4dsNn1LK92zetHNFY8fFG0h4LKoSxXQ=;
        b=OVc9C6RdNQz1StpvfSii7jU6/347CJQgK1VLpFSsBUj1uF+4GyIJpBIDrQewurXURM
         bUN6jwjL1BLFtSGmTsH8/qMkNCCawVPxk7lstvutE+6pGW+LUOr3qbbDzpvTH2VIkPNL
         VIorbmrIp1bsojao2P2+6vWtWFGW5ncG9YfrBddNQteo8js2H9lLK5MMHWHPobt0CcEr
         5CF1DtUs3KUPeH1LdXF57SfR0RYKGt6mMf+W5Der0c9+c73kY5SO2uIOcXqWGM9bVC41
         RfQci98ihKECBFdYeBpyOu4VZGRaVbNUjNjsDahbY25tmgrp5N1eKvUuuT82YTwioe6D
         5Wwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679750676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sgkjY7+B8eGC4dsNn1LK92zetHNFY8fFG0h4LKoSxXQ=;
        b=uZgqNijJxC2VyRZeDznpITrjq4dXo9ZXbPgpi7fxsgxQglVWOCpLyWTldH9O+iSoJ9
         ulMiRvE0aQR/bEb5xlexvFomqok/mHrdQuXtvhIZ8GKJrmAAT1GmsjyDnxUEOuQZ/mXq
         tuc9ebsYUhmw+gza0b//KY06X4h7MJ7AXldCX2QiisL2R0YgnfuKEC5huu2+pN6vL0xd
         a+94nDU3JkAsoqAJbPOtcHGalTKor9IN2WmRi4ra25zYSpyZ1ROtpCVHTZVZvufpGVuG
         kx9G+mu+UmsERR7bAlBnETlwjGL0SERGDEDqBwoXTs85HESLWnbaM2vktDs2Sg659Cw5
         pzUw==
X-Gm-Message-State: AAQBX9dTIvnI2UDV8FUe1SLYY8l1zXzuU4V/MQkJh1nLwt4jP6K+jhXH
        Z8lWVRyodQHvvm0J//XPh16AnQQ6sGu+js9tuXQ=
X-Google-Smtp-Source: AKy350aVyVtSLJv2HTvXz8R+x/QnZY0NT3KmsLuxaDYS2Iv2BgAwDBAw3sqhPS+w8JpwIfC61+SGgFoqXY1x3qBCIZ8=
X-Received: by 2002:a05:6214:b90:b0:56f:80e:701b with SMTP id
 fe16-20020a0562140b9000b0056f080e701bmr1151304qvb.2.1679750675851; Sat, 25
 Mar 2023 06:24:35 -0700 (PDT)
MIME-Version: 1.0
References: <MW4PR20MB5517583CBEEF34B1E87CCF1290859@MW4PR20MB5517.namprd20.prod.outlook.com>
 <CANgJU+Vn8ZLGcAYbuDeNkv6T5YdX6t20BqGQDPB0VL_TzoGSWg@mail.gmail.com> <MW4PR20MB5517888E63C13099E284B97590859@MW4PR20MB5517.namprd20.prod.outlook.com>
In-Reply-To: <MW4PR20MB5517888E63C13099E284B97590859@MW4PR20MB5517.namprd20.prod.outlook.com>
From:   demerphq <demerphq@gmail.com>
Date:   Sat, 25 Mar 2023 14:24:24 +0100
Message-ID: <CANgJU+XWUkJhJW3b+gmU3xdkVV+2rA9hKBzQDKFhdJn59T+v9A@mail.gmail.com>
Subject: Re: git bug: Perl compatible regular expressions do not work as expected
To:     Mario Grgic <mario_grgic@hotmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 25 Mar 2023 at 14:10, Mario Grgic <mario_grgic@hotmail.com> wrote:
>
> The lowercase -p is to print the output in patch format. You can rewrite =
the command line as
>
>  git log --all --patch --perl-regexp -G '\bmain\b=E2=80=99
>
> I still get no output in any git version after 2.38.4

RIght, sorry about that. My bad.

Yves

--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
