Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04732C43460
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 10:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5D17613A0
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 10:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241443AbhDFKgX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 06:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbhDFKgW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 06:36:22 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028DBC06174A
        for <git@vger.kernel.org>; Tue,  6 Apr 2021 03:36:14 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id b10so15011467iot.4
        for <git@vger.kernel.org>; Tue, 06 Apr 2021 03:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VbfGpRTMBG1cw9gsTy43ex7MfGNO0UXPal22JHVecyE=;
        b=G9zANK41J25TV25c4ISUF75duYnj1WM+uH9jf5wT+ywwaeVUjbf8zx9etxpPtGxlec
         TGbFhK/nx0dUlA5GWhzk/0MzJScCC7QlYNBtGWO8gp3duvK0cLx8ifX50lnYGE1GeSpr
         LwcLLeIrUn1LPteuDpKSdHVRPd+bJugok4f9EiWm+iDW6qFqdgpolAm1amZugPEVOx6W
         ESCH989PEddv5kYW83RXlEtO+dtt2Fu/BUxA/55ycAtdsvMl2JcGZrBm7E/N6PXCiZQo
         VwoAnBk344YMiUUNUKUe5RogZDwb6Fi+kRw9ZJfglr8Zspe1Q7wAkvAA6EN8LdGsJrDT
         sFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VbfGpRTMBG1cw9gsTy43ex7MfGNO0UXPal22JHVecyE=;
        b=lpLiJZw1cUfNBgOIm1LdN5fFRc/nEHJwQQvQoVG9CIBpQt404KEGbZ2uaCABiCPRnk
         Q3mjhmdlYMCJML/yaZt1IqBTzy65i+43jBIJNa+QnD2VUmiFLc/E1OAisbEhcdIpne9J
         9t+qekG8ejoS2V+BGlJkcsGJ8qQRrxk4PfkNrwxyl44lHoRVuPEvLzb2vt0yqU2fVK/B
         EgTnpvsS5Xrbi1bgitZQE0zaHJLbs28mJIQxD7dGZlanSTBRF8ETyssyi6M0uOuTVlUf
         FgyQRkxkRn/QHLqDgnxDrBYw9VLNXLZwHPpNKO7qz3JQBppFIQwppp9o36hWb/cYlW8A
         oqSQ==
X-Gm-Message-State: AOAM533JfRZPSTBxbFew/Tqfrm0835/siAq/8gHzKD/PZEivJNIWhxdA
        SrUxdqQQ+eKO1YvaDgci2zOEsj1o4cFmAvKg4dk=
X-Google-Smtp-Source: ABdhPJy8tqimaoOS6k0SaPwa3iMQThPFJT2j8M971rje6Gjs2nMUgT1hGGBCZNPJdhgSLQ8LS6ejs/GKqbD2u6amOgA=
X-Received: by 2002:a6b:7302:: with SMTP id e2mr23193935ioh.106.1617705373475;
 Tue, 06 Apr 2021 03:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.927.git.1617631280402.gitgitgadget@gmail.com>
 <YGuMaxoYgRkUR1sa@coredump.intra.peff.net> <CAOLTT8TwjRyT6MK_ekEx9APBv7jn17JRKj=mJQMO5Sk-DgHA-A@mail.gmail.com>
In-Reply-To: <CAOLTT8TwjRyT6MK_ekEx9APBv7jn17JRKj=mJQMO5Sk-DgHA-A@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 6 Apr 2021 18:35:57 +0800
Message-ID: <CAOLTT8SzDsoScFaGe5emQc6V5QDJD=osdE5OMAz2Xs8=AvrfVQ@mail.gmail.com>
Subject: Re: [PATCH] [GSOC] ref-filter: use single strbuf for all output
To:     Jeff King <peff@peff.net>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Hariom Verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=886=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=885:49=E5=86=99=E9=81=93=EF=BC=9A
> But this is the first time I use `t/perf/*` and there is a little problem=
.
> It seem like whatever I run single script like `sh ./p0007-write-cache.sh=
`
> or just `make` or `./run ${HOME}/git -- ./p0002-read-cache.sh` , these
> tests will fail.
>
It's because I don't have /usr/bin/time, solved after installation.
So best have this:

--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -152,6 +152,10 @@ immediate=3Dt
 # Perf tests require GNU time
 case "$(uname -s)" in Darwin) GTIME=3D"${GTIME:-gtime}";; esac
 GTIME=3D"${GTIME:-/usr/bin/time}"
+if ! test -f "$GTIME"
+then
+       error "command not found: "$GTIME""
+fi

Thanks.
--
ZheNing Hu
