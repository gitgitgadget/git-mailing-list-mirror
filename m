Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B3FC7EE22
	for <git@archiver.kernel.org>; Mon,  8 May 2023 15:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbjEHPZU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 11:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjEHPZT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 11:25:19 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB2A2128
        for <git@vger.kernel.org>; Mon,  8 May 2023 08:25:17 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f00c33c3d6so5313268e87.2
        for <git@vger.kernel.org>; Mon, 08 May 2023 08:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683559516; x=1686151516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzkQRw98v1TvBxMjM6HF9mJnKU9M+6qc+EnLDGslFl0=;
        b=BioySZVMmQ8HGpsIjT/URoRLToTEl79F4hR5HsijcYaZcAY3yF7JyIkuF4aLYDF2Dj
         BPNsHD0ppQwhhZu2CsMPR7F4b0m0CEEoT2zBJyTm8VSqASDAvx9MBtlOVsAGcQM+UARa
         7LIbp12UF//MOdsdTrqgm5a/OkhsxWUFqINchZxLjT7QNyMZenkocyLo0vOtZRLKxlBa
         DP8e/ibht+yGiwrxbF6/VFiHd+29VmQIF0pMMQIMZTJwtG8vAAm7to7EUcJlkOx40jUi
         3dV+GhLrhXn92TMz+VKPjb3AYaUUr5fAtcRj4CQv1u3p2xiAPYN3LK6wPuMldb1lKDn3
         F1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683559516; x=1686151516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lzkQRw98v1TvBxMjM6HF9mJnKU9M+6qc+EnLDGslFl0=;
        b=LlfESp0l6tkze1Y0MY8+jdnUrRqJGP0NlHV2D/t3SRq6zX39v2eGGrQoQABrQTkAr/
         owxXsdX2ItuDHuoei5532DLrCPHlJO6e5YXqi6SmPDB5NOaqq4jdZRz0BfHQ75BYqgnQ
         BIbztvdcCnU93emVXGPbjc6JISXTypNZ+IegBDAzPC+eG8FBXlTmPEcwAWyDryITni6X
         Z8pBSB/ymmKzbQ5gOIZKBS6o6e9WWC51B7kvABT8vvs3TEqluulPIaSXzkO2THo8qUnC
         fu5FOM93Q7FfYjxzdG8aUsJ8JUVBz7VEwzLc+pGyXcVJ60keSqhsz/Po2hLb+WV3vPjg
         ef6w==
X-Gm-Message-State: AC+VfDzuIBS62/BUUX/IfSSYjIFWwAoJKzjAoYVkp+eCPhUPdmsHp7Xf
        YkonhvDDpytNBkD0gv9nfva00Rm9oWCftHpJciU=
X-Google-Smtp-Source: ACHHUZ676M3t88EMCF7ORrGNOu5XpNrIqUgjQa5L6jDjUpBBa2rFUYdf3KPgJgHlcSeiEKrRD4k2A+VlZYrUYCxSsg8=
X-Received: by 2002:ac2:5962:0:b0:4f0:345:6ceb with SMTP id
 h2-20020ac25962000000b004f003456cebmr2944315lfp.14.1683559515979; Mon, 08 May
 2023 08:25:15 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1505.git.git.1683295133304.gitgitgadget@gmail.com> <CABPp-BE50neqaQbE2tTq_=fEM9j_8-cxgj7xKcSfAunoWjsigw@mail.gmail.com>
In-Reply-To: <CABPp-BE50neqaQbE2tTq_=fEM9j_8-cxgj7xKcSfAunoWjsigw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 8 May 2023 08:25:04 -0700
Message-ID: <CABPp-BE4X=uk5E37KYWMZE5W-myRgXMj8fTpVZ7=FF05PoR5iQ@mail.gmail.com>
Subject: Re: [PATCH] doc: merge: improve conflict presentation docs
To:     Adam Johnson via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Adam Johnson <me@adamj.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 6, 2023 at 4:40=E2=80=AFPM Elijah Newren <newren@gmail.com> wro=
te:
>
> On Fri, May 5, 2023 at 6:58=E2=80=AFAM Adam Johnson via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
[...]
> Everywhere else in the manual we have referred to these as "conflict
> markers", not "merge markers".
[...]
> If we're updating this documentation, perhaps it's time to drop the
> mention of RCS?
[...]
> I dislike the whole "yours" & "theirs" thing.  [...] I'm happy to see
> them used one less place here.
[...]
> "Using real values" [...] seems more likely to confuse them than using a
> descriptive term or even a fake hash (such as "aaaaaaa").
[...]
> The comment you added here about zdiff3 is correct in context,
[...]

I realized I also failed to note that I like the patch in general and
think it has some good cleanups, even if there are potential further
improvements to make.  Looking forward to your reroll.
