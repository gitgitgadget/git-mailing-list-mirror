Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FB1EC8748
	for <git@archiver.kernel.org>; Sun, 10 Sep 2023 09:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbjIJJrf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Sep 2023 05:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjIJJrd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Sep 2023 05:47:33 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C94CC9
        for <git@vger.kernel.org>; Sun, 10 Sep 2023 02:47:27 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-573449a364fso2285672eaf.1
        for <git@vger.kernel.org>; Sun, 10 Sep 2023 02:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694339247; x=1694944047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ym6O2cxj3q8PRKo1rF0NgqREVQD6IN7n2Psv70geA30=;
        b=XMs0zKax33HOrafVPbGhKi6oNUrzoQ/68eaJPqw6iH5OxKYQ/9UIRqgfQ5HqxN7xIP
         9NzgifkWCXnqaALraastVhuY4STABuaWd84Arkp+z50f+xG964OgEV27EiRTrC6++Bp5
         4B4tRApYwVNAZdu8xJnN7OkuOknnvYoSHrfgORszynyGsJU6t4fka/zWRPLsD0/V+NDW
         ccPAukh4CkWeLlDxWUWJXEBrOt2+BRrncglTEupu/MOJjE6TtWpc1iCW6ATsg/LidI+w
         CZKnuqxAcCqXPKa11o8xB8zBI0WuSROlDxWawd7yGoE3jq0w7kllutiZ8dNCuvLVvlKH
         b19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694339247; x=1694944047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ym6O2cxj3q8PRKo1rF0NgqREVQD6IN7n2Psv70geA30=;
        b=FcQrL2hu3G/ZbJyZZwZUT9Miwuy/jat63D+2l+8Ikngk9WWxhBEqKtAaOezOtF0k3n
         /wS8GyW/gBRvwt7reUTOi9CgYyulamOWsELTo4CE2R0gozISn86ha5ciuNcfhLbh1B/Z
         WLSEzVAYHlZp6BWZTbrXYsDILEMY2oprjFV/R5mcNrPQLpgy0EnaZbW3AD4Gu9yTjMCf
         gsbS3Vsly1VKomPbOxPZSLtFqQIQyhFVKYCHhc1Nw2XPC7m/p8HanRulkdqSx+JGVljK
         aFHq58DjB+adfKx/dUPycfiVnDC5WTn1kGWtKgBnz9JPI+01fPqdlo8Rt0T+CDO7qmto
         8NUw==
X-Gm-Message-State: AOJu0Yym7CsSEYo9E6Si1J6acNqOME7uGnqVBJh6jZCsxhtmIDKlrpRs
        sVQ2TzRn8VR3XoGqpo+0+UvuF1//uvmx8sIxO+MedhtIdiA=
X-Google-Smtp-Source: AGHT+IEdL/Z8zm4n5g0k9bPtsNCLVLf4DbegEsY2o4L4TFGPD7s36/B447/5+HaeWtWVwBpypLZ+Ogvlrh3UMtnp3Cg=
X-Received: by 2002:a05:6871:292:b0:1be:f7d8:e7a2 with SMTP id
 i18-20020a056871029200b001bef7d8e7a2mr9272169oae.21.1694339247042; Sun, 10
 Sep 2023 02:47:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAN47KsV0E+XC2F+TVKXnnJnkATRp7eM7=-ZJFyZcoTz9SJmcHQ@mail.gmail.com>
 <ZP2DaQMA_aFvjQiR@debian.me>
In-Reply-To: <ZP2DaQMA_aFvjQiR@debian.me>
From:   Max Amelchenko <maxamel2002@gmail.com>
Date:   Sun, 10 Sep 2023 12:47:14 +0300
Message-ID: <CAN47KsUe=qicr4wZWd33EV+cciUr8ztP2veoOkcw0JBtvsBGjw@mail.gmail.com>
Subject: Re: [bug] git clone command leaves orphaned ssh process
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org,
        Hideaki Yoshifuji <hideaki.yoshifuji@miraclelinux.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Output of first ps aux command:

bash-4.2# ps aux

USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND

root         1  0.0  0.0 715708  5144 pts/0    Ssl+ 09:43   0:00
/usr/local/bin/aws-lambda-rie /var/runtime/bootstrap

root        14  0.1  0.0 114096  3088 pts/1    Ss   09:43   0:00 bash

root       165  0.0  0.0 118296  3392 pts/1    R+   09:45   0:00 ps aux


Output of second ps aux command (after running git clone):

bash-4.2# ps aux

USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND

root         1  0.0  0.0 715708  5144 pts/0    Ssl+ 09:43   0:00
/usr/local/bin/aws-lambda-rie /var/runtime/bootstrap

root        14  0.0  0.0 114096  3088 pts/1    Ss   09:43   0:00 bash

root       167  0.5  0.0      0     0 pts/1    Z    09:46   0:00 [ssh] <def=
unct>

root       168  0.0  0.0 118296  3408 pts/1    R+   09:46   0:00 ps aux

See the added ssh defunct process.

On Sun, Sep 10, 2023 at 11:50=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.co=
m> wrote:
>
> On Sun, Sep 10, 2023 at 09:38:54AM +0300, Max Amelchenko wrote:
> > What did you do before the bug happened? (Steps to reproduce your issue=
)
> >
> > Run the command:
> > ps aux
> > Observe no ssh processes running on system.
> >
> > Run git clone against a non-existent hostname:
> > git clone -v --depth=3D1 -b 3.23.66
> > ssh://*****@*****lab-prod.server.sim.cloud/terraform/modules/aws-eks
> > /tmp/dest
> > Observe the command fails with:
> >
> > Could not resolve hostname *****lab-prod.server.sim.cloud: Name or
> > service not known
> >
> > Run:
> > ps aux
> >
> > Observe a defunct ssh process is left behind.
>
> On git current master on my system, I got sshd (server) processes instead=
:
>
> ```
> root         835  0.0  0.0  15500  3584 ?        Ss   14:38   0:00 sshd: =
/usr/sbin/sshd -D [listener] 0 of 10-100 startups
> 165536      3865  0.0  0.0   8488  1408 ?        Ss   14:39   0:00 sshd: =
/usr/sbin/sshd -D -e [listener] 0 of 10-100 startups
> 165536      4039  0.0  0.0  11308  1920 ?        Ss   14:40   0:00 sshd: =
/usr/bin/sshd -D [listener] 0 of 10-100 startups
> 165536      4374  0.0  0.0  15404  1920 ?        Ss   14:40   0:00 sshd: =
/usr/sbin/sshd -D [listener] 0 of 10-100 startups
> 165536      4399  0.0  0.0  15404  1792 ?        Ss   14:40   0:00 sshd: =
/usr/sbin/sshd -D [listener] 0 of 10-100 startups
> 165536      4732  0.0  0.0  15404  2048 ?        Ss   14:41   0:00 sshd: =
/usr/sbin/sshd -D [listener] 0 of 10-100 startups
> 165536      4943  0.0  0.0  18004   848 ?        Ss   14:41   0:00 sshd: =
/usr/sbin/sshd -D [listener] 0 of 10-100 startups
> bagas       6841  0.0  0.0   7668  1092 ?        Ss   14:43   0:00 /usr/b=
in/ssh-agent /usr/bin/im-launch /usr/bin/gnome-session
> bagas       6908  0.0  0.1 162780  5488 ?        Ssl  14:43   0:00 /usr/l=
ibexec/gcr-ssh-agent /run/user/1000/gcr
>
> ```
>
> What is your ps output then?
>
> Thanks.
>
> --
> An old man doll... just what I always wanted! - Clara
