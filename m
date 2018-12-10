Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69A1F20A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 01:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbeLJB0K (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 20:26:10 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:42630 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbeLJB0K (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 20:26:10 -0500
Received: by mail-io1-f67.google.com with SMTP id x6so7481195ioa.9
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 17:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=m0jtiFaSRBZdgt1+g2fij//JbpO4308q7jn9Xe22Kqs=;
        b=LaLV2WUVq9bfsotSQxp6pSzh4YYTOic/ZpDNOBF31UipEkWaTJTG0yev+6j7Ht2EkI
         6c4VZU9bdq4Jwyh9ITNg9ZXtFm1YT/5dbJcw13dj0Mwad2ccDfaK9xhnk/+83dhL9tJQ
         gnML5+9lxGmlTv9AV9V2GDduyLhDno3zf50gqOBZ2QUs/YMOXFZ3fEDO2gSo5HQwB5Ym
         86ahhKSLpLIWIwE1D77bppThI7cnMWb058q/Aw893LmdOeYPavORFGngtMsbMrIfyTsS
         qaCNSKzGqRhKv+8Ve0H/eHIL/NCqCiMpz+3IevKFXpSvHy+gaYZXHhQWA0cmcenXaiog
         jpxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=m0jtiFaSRBZdgt1+g2fij//JbpO4308q7jn9Xe22Kqs=;
        b=UO9cVOVyiQoqZSo0fG8uBejJuvdh8OnWezyHGfIr4ZwSckXNAfgm7JMMbM/ePUNuZr
         lmNKWJylzsuJvTCJxSiQEMpA1HF1JaZppaLJWD257+Lke5kVP7tdct3U6rLrS26EFrtB
         h5jKGE+71PUAFqf82hHN2lHPPq1WISxmypF8kXpsNNOUI5H9mHXOjHmLd3IewOgxAL1J
         kd9DDIotgjKLuYYPOIeONbFjhU1CenpWqRHB3r3pijPToDJkNib25aKX6d69nZ1k/4H4
         PD5cJplFoeQM2E87tc6LwGt964DoQVRdtXmSlQYHdCK+xYDJbeVcefmBSC/xf5mKy4TG
         MCiQ==
X-Gm-Message-State: AA+aEWZ5zgSSH6bBNqTpVLuxCYioZRufrybZZtX2ERSU9fH8HhURcVmi
        niZxzWpIVcs3s9FPX4YJUT6XDMRHrI9fI+aSusI=
X-Google-Smtp-Source: AFSGD/UBMff4zgKJmle24hOBiRMv7k2hmlOVXp6JrA+qGPCLTL28gIOLxeAJ9zWQoUU8m/nwPsUR/lRgTKBpRtXS7BE=
X-Received: by 2002:a6b:2b07:: with SMTP id r7mr8221165ior.169.1544405169367;
 Sun, 09 Dec 2018 17:26:09 -0800 (PST)
MIME-Version: 1.0
References: <20181209230024.43444-1-carenas@gmail.com> <20181209230024.43444-2-carenas@gmail.com>
 <87r2eqxnru.fsf@evledraar.gmail.com> <20181210004252.GK890086@genre.crustytoothpaste.net>
In-Reply-To: <20181210004252.GK890086@genre.crustytoothpaste.net>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sun, 9 Dec 2018 17:25:56 -0800
Message-ID: <CAPUEspjApDZ3MQr1D1Qu9UNq0QSB_9BKMUUogvABo2VJqao+xw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] grep: fallback to interpreter if JIT fails with pcre1
To:     sandals@crustytoothpaste.net, avarab@gmail.com,
        git@vger.kernel.org, pcre-dev@exim.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 9, 2018 at 4:42 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On Mon, Dec 10, 2018 at 12:51:01AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
> > Obviously this & what you have in 2/2 needs to be fixed in some way.
> >
> > Is the issue on SELinux, OpenBSD, NetBSD etc. *how* PCRE is creating th=
e
> > the JIT'd code? I.e. presumably Google Chrome's JIT engine, Java JIT an=
d
> > the like work on those setup, or not? I.e. is this something upstream
> > can/is likely to fix eventually?
>
> From the cover letter (but without testing), it seems like it would
> probably be fine to first map the pages read-write to write the code and
> then, once that's done, to map them read-executable. I know JIT
> compilation does work on the BSDs, so presumably that's the technique to
> make it do so.

and that has been implemented (sljitProtExecAllocator.c) as part of the wor=
k
triggered by the bug I linked about [1], deep inside sljit (which is
what pcre uses for JIT)

the code AS-IS wouldn't compile for the BSD[2] but that is easy to fix
and sure works as expected but I am under the impression that is not
something that can be considered as a solution as explained by the open iss=
ues
described with crashes after a fork()

note that changing the map from read-write to executable will be
prevented by the
same policy so you have to create 2 maps (and therefore a backing file) and=
 I
don't think there is a way to solve that in a foolproof way in a
library which is why
I mentioned more work might be needed to define the right interfaces
so it can be
solved by the application, and that is unlikely to happen with the old libr=
ary.

Carlo

[1] https://bugs.exim.org/show_bug.cgi?id=3D1749
[2] https://bugs.exim.org/show_bug.cgi?id=3D2155
