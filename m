Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2C6C433EF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 19:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F06BF60230
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 19:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbhJYTDC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 15:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbhJYTDC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 15:03:02 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBA2C061745
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 12:00:39 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id f24so5087749uav.12
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 12:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KY0RHGMiSlwdjGinJmVtFDVxr4A9HEMFFjCmeRqa/xM=;
        b=lpfVW99aoCmboZrdnpvWvPugSSy7R4HrUgZBix68z+Jmt7gzqDfr5FDqqrAobuC2/8
         lIuXXbRwlSiOJVMIxYSc7/6jwNgoBk6+vPq1A+ymkc774bDr80rHNt92fxVfnUsNvcJu
         tpYRy+DHCRM5UY1evE+AQMFPzN62B7JH0k9UG+ddBAZEGP8r978qnhNXJkO6wbzLufwn
         8IjU9U2tjzgmOZSjHPBSQ9iGA1xQ5Y3po0gHjHs4cFTXzbvUPPJDYmlaeqyTuQkCaiJV
         imVHTFOrEeN4Z5emYO5tAoZOwPtqxajEUqEfuj5ZrvUqON5JuCSJKMVCUaSMjlj5SQwd
         mJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KY0RHGMiSlwdjGinJmVtFDVxr4A9HEMFFjCmeRqa/xM=;
        b=G10wXZ2OFZF424UIrUG/g68bs0I6W9ptfp5MYSucsKB786PkCr3T5SYjO14r9niKyN
         BMNTUNr97r8J6KNTr6OsrmUunrPbyrSp66ih3y9fi5jvat9KDmEn/tiXej3Yf+1T8Uug
         75hzwJVN/ZnA60PZJJ6aYhkcP2Sjak/LsvdP0IDKPzwLZsL9YPHltFgadFHl+q0LYUcc
         O8wNkIuwjBH5AqAz/BIBKx+1GCrpJVaEJr9yeETxAnQUreCmtjXj2h+h0qQ4kwcHFjeB
         k5po4Ye9vQTNirNVoo5PfVi2bFE006CtacnP++z3JUrM0XMq7km6noqRLO/dRa623OKS
         MAdg==
X-Gm-Message-State: AOAM530HdQlNfFEYYU7UJSbBtDfEAhrqSzbHq/tBUkhbbUy9Uhj00StC
        Y/J3kXko+yS36lWbV2Fu05KzTJa7BZbmys/rM56JRm2gGEM=
X-Google-Smtp-Source: ABdhPJzmoXi5je84Q3D/FvsLoCYY9In4kKFRjEE1hscysstBPTnR9OsZOA38gf/KP3pLdF8vsswDcFWx9yvU7uUeo/Q=
X-Received: by 2002:a67:c394:: with SMTP id s20mr6876810vsj.39.1635188434601;
 Mon, 25 Oct 2021 12:00:34 -0700 (PDT)
MIME-Version: 1.0
References: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.2110211148400.56@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2110211148400.56@tvgsbejvaqbjf.bet>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 25 Oct 2021 21:00:23 +0200
Message-ID: <CAFQ2z_NBOC5sDSL6AjCe-5mPVhU1B_guJEsHwVT3=AK1aAt8UA@mail.gmail.com>
Subject: Re: [Summit topic] The state of getting a reftable backend working in git.git
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 21, 2021 at 1:56 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> This session was led by =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (on behalf=
 of Han-Wen
> Nienhuys, the driving force behind the reftable patches, who did not
> attend the Summit). Supporting cast: Jonathan "jrnieder" Nieder, Johannes
> "Dscho" Schindelin, Philip Oakley, Jeff "Peff" King, and Junio Hamano.
>

Thanks =C3=86var for doing this. I wanted to be there, but I took a much
needed 2 week computer-less vacation .

>..
>      9.  Reftable has a set of files that go together. May want debugging=
 tool
>          to dump the content of a binary reftable file. But we can
>          incrementally add those


The patch series includes a test-tool for dumping both individual
tables and a stack of tables. It's not super-polished, but it gets the
job done.

$ touch a ; ~/vc/git/git add a; ~/vc/git/git commit -mx
...

$  ~/vc/git/bin-wrappers/test-tool  dump-reftable -t
.git/reftable/0x000000000002-0x000000000002-327b23c6.ref
ref{refs/heads/main(2) val 1 ab21c324503544acca84eb55f5ee7dce24b23e15}
log{HEAD(2) Han-Wen Nienhuys <hanwen@google.com> 1635188263 0200
0000000000000000000000000000000000000000 =3D>
ab21c324503544acca84eb55f5ee7dce24b23e15

commit (initial): x

}
log{refs/heads/main(2) Han-Wen Nienhuys <hanwen@google.com> 1635188263 0200
0000000000000000000000000000000000000000 =3D>
ab21c324503544acca84eb55f5ee7dce24b23e15

commit (initial): x

}


--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
