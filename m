Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05C6C433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 13:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 980006108F
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 13:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbhJ2N5z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 09:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbhJ2N5x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 09:57:53 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3EAC061570;
        Fri, 29 Oct 2021 06:55:24 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z20so39275904edc.13;
        Fri, 29 Oct 2021 06:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wPMpf/v+GQEdtJ4v0im5OPSlxsRrjiiCKA2oJgDao4c=;
        b=TcEE3ljlQ7ZX7jl8JKB/DyhwlhXh+jJ9RZXHhCpSlz2fLplt/gjLeWj+ZwOIRfH+O9
         UPOKgAxJbedT7IyseQ22kWoxkahx81vVOLJ/7NdkPp2lw+Uj5T1k/+zBVai2/PHd8/c5
         cnu0Nf4JQHngvj2cW+zEBzqmVgq7e69f5GTzkPLIOLRnbsAeHxn3ytTMjDbydBv8yI8T
         FHXZsOqfI9q0XrRu9KuI9diXrla6OzmebSgyaTLCtIVQSQ4u/6YS7LObFvAOLQ495uJt
         b+drRq9V4P7n8BCO1dciX1w6sKbir9s+rJYSFraCDUHP9d0uXu0VyrP6PHfJrEL+lHOO
         o9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wPMpf/v+GQEdtJ4v0im5OPSlxsRrjiiCKA2oJgDao4c=;
        b=p2oJS9Z9ORVWi5gzwDVUNvCh3dTxpv7CRKpugRZrawJRfX+7YwQ74gJ/wv3FI3G+mY
         PmneBC4uLMOlcgI+CcuiHzg/Ua3/0BtJSqu8EISNi0SpVklnhOlihmFV6uIYa06xYgCY
         bUkjXAGHHmHg2UAi4VNwhA0d/whDAhCSor/9LInVxOwNfSzhRSz2eS0o29iHcEdG+hxx
         6EjX5W/xCa4Ged2k8L2XKbjHltMI7lcEQ5iTQOjcGyeh8hvRGgnBnPZSNb5vLqQzzbbl
         OwnhOkq6jf5II+ovfizCqePGHWk2azfq47nM/xLcUBJ39lxDPrhEMoOqzZ/0K40Cmho0
         TYkg==
X-Gm-Message-State: AOAM530L1N9UFg+CBXQhJJzMM2buzYal50ZbSYSJmh9eSXUHyNtUNrzd
        L38VjXLpFBmNMLPprEAsbOqn+Hed/F4p0qlscDM+NZbDAHg=
X-Google-Smtp-Source: ABdhPJw5CO+YTNZ3UDxLzowrvu0npcyZ/RKaL2AjURWYs/N7DR5ksO8lZVaC02wMPI5yJ286EWuFmxwTQ8xha1a7KQ8=
X-Received: by 2002:a17:907:628f:: with SMTP id nd15mr14048416ejc.389.1635515723540;
 Fri, 29 Oct 2021 06:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <a0371f24-d8d3-07d9-83a3-00a4bf22c0f5@gmail.com>
 <73ac38a2-c287-4cc1-4e9c-0f9766ac4c0c@gmail.com> <00d501d7ccbe$0169c340$043d49c0$@nexbridge.com>
In-Reply-To: <00d501d7ccbe$0169c340$043d49c0$@nexbridge.com>
From:   Eugene Syromyatnikov <evgsyr@gmail.com>
Date:   Fri, 29 Oct 2021 15:55:07 +0200
Message-ID: <CACGkJdsdK_mgEH_v73NnVwQ2RA6cHtuyP4p1nvKveTEYnRhSBw@mail.gmail.com>
Subject: Re: Is getpass(3) really obsolete?
To:     rsbecker@nexbridge.com
Cc:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>,
        Libc-alpha <libc-alpha@sourceware.org>,
        linux-man <linux-man@vger.kernel.org>, git@vger.kernel.org,
        tech@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 29, 2021 at 2:40 PM <rsbecker@nexbridge.com> wrote:
> getpass() is obsolete in POSIX.2. However, some platforms still are on PO=
SIX.1, so replacing it instead of providing a configure detection/switch fo=
r it might cause issues.

POSIX.2 is not a newer POSIX version, but rather a book (=E2=80=9CShell and
utilities=E2=80=9D) in pre-2001 standard revisions, and it has nothing to d=
o
with the system interfaces (that is POSIX.1).
And the only mention of getpass() in POSIX (at least, since the 2001's
edition) indeed seems to be [1], in the list of functions that have
not been carried forward from XSH5, the 1997 revision of =E2=80=9CSystem
Interfaces and Headers=E2=80=9D (that is, SUSv2)[2], where it is inherited
from SUSv1[4] from XPG[5] and, as Alejandro already mentioned, marked
as obsolete, per XPG3 to XPG4 migration guide[6]; the previous, 1988,
version of POSIX[3] does not mention getpass() at all.

[1] https://pubs.opengroup.org/onlinepubs/009695399/basedefs/xbd_chap01.htm=
l
[2] https://pubs.opengroup.org/onlinepubs/7908799/xsh/getpass.html
[3] https://mirror.math.princeton.edu/pub/oldlinux/download/c953.pdf
[4] https://pubs.opengroup.org/onlinepubs/9695969499/toc.pdf
[5] https://bitsavers.computerhistory.org/pdf/xOpen/X_Open_Portability_Guid=
e_1985/xpg_2_xopen_system_v_specification_2.pdf
[6] http://archive.opengroup.org/publications/archive/CDROM/g501.pdf

--=20
Eugene Syromyatnikov
mailto:evgsyr@gmail.com
xmpp:esyr@jabber.{ru|org}
