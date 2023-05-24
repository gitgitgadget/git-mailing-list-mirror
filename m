Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC39BC7EE26
	for <git@archiver.kernel.org>; Wed, 24 May 2023 00:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238828AbjEXAL0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 May 2023 20:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbjEXALZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2023 20:11:25 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26D1B5
        for <git@vger.kernel.org>; Tue, 23 May 2023 17:11:23 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2af316b4515so5256781fa.1
        for <git@vger.kernel.org>; Tue, 23 May 2023 17:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684887082; x=1687479082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JkBmgKxvYNxFcLMRV9ClpH2ge7I0CzwRIbNvcXigBo=;
        b=WJ7wWoJ7I6QcegqdZbNjVI9Nh4TS2aSqeQX3X7r1nvKd62CqTWZ5N3gcg3MGujzboH
         q1xHdmRrKKOWeQ/UOrjHqnEA1o9G1usFaxSfNEYzoEKOCyv4ndHNiEJ79ckEcefTPW4F
         invE3RV6ORoIHqUDKQde4NduAOdc822XtR8RvIhT5SZR7GDS3vPKg1OMvVs7pb6rERKT
         PLz8kHHK1QGdOUZsismbHWJ9Xs64YE1dx35Z52DsXGJUJDPw2fj+eIjzuDeJY70Xaj8p
         aZ14eE9z81nWrXLpYPuHNp1RadSuHW+HsFDHkdjCaupC7ka1BWKZoG6f4TuzJN184VPw
         f0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684887082; x=1687479082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1JkBmgKxvYNxFcLMRV9ClpH2ge7I0CzwRIbNvcXigBo=;
        b=Zxp5Fnp1B5GXfPqCuNpAzSuUu4wU5b1N6s2G8/C1b/ZQU/dQ21p2oj6G7FHHnFb0S8
         pN8gfmCCK3BpOpwxxoZn9t2ypZUzYC9IwqaOYnGUEC6dLPiVJPRC/wSk7CpUIvsILdQ4
         P3fCS+nudV9MPiX7CjQkI4NM9lW4TbyWPCThDMLzuTEfrrkPPUwyIk66RFa7F+3Qr9ti
         n6ed5FlKdQ3YYDZOuUSD/nI+b5U767CElRaRXJLhfpvsU1xpm7mnbZnwBfgBDmO4YL2v
         mTdNab9gX0E0wxieZdb/8BsZwywcyd30oMr1rus4zmgmU5cgoYN8lIhhlE756jRAfGBZ
         bGcQ==
X-Gm-Message-State: AC+VfDz9YdLUY4wEmiV8WW9+PhAnfoiVLwrocj++pb4cvICl0I6p8yhy
        ELAG+PEVhSp4YZqe19UbpZis6QHhQTSuxuAEdS0=
X-Google-Smtp-Source: ACHHUZ4Yg12rX3PiHT0O0vAB9DDespPHpQ70YyDtloRJn/RHB1itxGBBjB5PsyulXFmw9Nhlx2nBe17EHqivqV/WZeM=
X-Received: by 2002:a2e:9b81:0:b0:2a8:e53f:c174 with SMTP id
 z1-20020a2e9b81000000b002a8e53fc174mr5000564lji.26.1684887081695; Tue, 23 May
 2023 17:11:21 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1525.v3.git.1684218848.gitgitgadget@gmail.com> <20230523194949.1285748-1-calvinwan@google.com>
In-Reply-To: <20230523194949.1285748-1-calvinwan@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 23 May 2023 17:11:08 -0700
Message-ID: <CABPp-BG_+TYDcL0sRMLOWwncXWPBp2RrUaK0CNvVLruPkqC+0A@mail.gmail.com>
Subject: Re: [PATCH v3 00/28] Header cleanups (final splitting of cache.h, and
 some splitting of other headers)
To:     Calvin Wan <calvinwan@google.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 23, 2023 at 12:49=E2=80=AFPM Calvin Wan <calvinwan@google.com> =
wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> >  * a textual & semantic conflict with cw/strbuf-cleanup (affecting strb=
uf.c;
> >    to address, delete the conflict region and also delete the include o=
f
> >    repository.h)
>
> In patch 19, you also include path.h into strbuf.c because before my
> series, strbuf.c had a dependency on repository.h. Since that dependency
> is removed, there is no need to include path.h anymore.

The path.h include is shown within the conflict markers, thus removing
it was already part of my instructions ("delete the conflict
region...").

It looks like Junio merged your series to seen first, as I was
assuming in my instructions, so this suggests there was an error of
some sort when he merged my series:

$ git show --oneline --remerge-diff
862248e47048c9282bc00ac6d9dcc7a21bd11ab1 -- strbuf.c
862248e4704 (gitster/jch, gitgitgadget/jch) Merge branch
'en/header-split-cache-h-part-3' into jch
diff --git a/strbuf.c b/strbuf.c
remerge CONFLICT (content): Merge conflict in strbuf.c
index dfaf41d2f18..37fd5247b32 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -2,16 +2,7 @@
 #include "alloc.h"
 #include "gettext.h"
 #include "hex.h"
-<<<<<<< d1af2a2c773 (Merge branch 'la/doc-interpret-trailers' into jch)
-||||||| merged common ancestors
-#include "object-name.h"
-#include "refs.h"
-=3D=3D=3D=3D=3D=3D=3D
-#include "object-name.h"
-#include "refs.h"
 #include "path.h"
->>>>>>> d677f7e76ab (fsmonitor-ll.h: split this header out of fsmonitor.h)
-#include "repository.h"
 #include "strbuf.h"
 #include "string-list.h"
 #include "utf8.h"

Junio: Do you want to fix/amend that merge to remove the entire
conflict region (so removing the line involving path.h too)?  Or are
you preserving that line for some reason?

Anyway, not a real big deal; it'll still compile with the extra
include.  If Junio doesn't tweak the merges to clean this up, then
I'll just add this into my follow-on series dealing with extra include
cleanups.
