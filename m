Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B50C2BB41
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 10:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbiHPKWW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 06:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234452AbiHPKV6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 06:21:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E054C04CF
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 02:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660641785;
        bh=05rRtTed4CH4JhKUDDFRjKMIjth/ayo+KliVlozswzc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jGQBSiF/CajdUCX77CKhgHDU9jpNiYg5xuPrLWjUktbrX0ChYUoYv3gO49oasPquy
         HBkVHWmBDo3m8UG4gV6mXk6sEv4CD5RnoyNaGRum1DVy7od4zjxxTdRwWRcXH2V5Qx
         9LeEJSsRuynDHdneYcHdfyhK9yvCIYrFGCXtVgLo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.183.122] ([89.1.214.151]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvsEn-1nXQze2Ddn-00sy0u; Tue, 16
 Aug 2022 11:23:05 +0200
Date:   Tue, 16 Aug 2022 11:23:05 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 0/5] rebase --keep-base: imply --reapply-cherry-picks
 and --no-fork-point
In-Reply-To: <pull.1323.git.1660576283.gitgitgadget@gmail.com>
Message-ID: <5o8oon84-sqop-o269-30s4-71p72or31r20@tzk.qr>
References: <pull.1323.git.1660576283.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5SZNr0hbjN0Yh6nOZOI6t3T2gXewVlDcbpo/71q72GCJpTJv/1/
 JANrY2q9KefI5FOsKJRgQ6kbrL8GpI3x+hESj2z7fGfnxOXNqTegpEer1hpasP/glfu1CLV
 nlXQV+LkeQzPFqHCf1RUaTQ9zEHPevyP/xT3w7O/ksJ9NBHYMJAW/IKUOUDuEftHvb8yghw
 P4NCxqlv4i6vw4qtrXFlw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:i2piPYRNlyc=:6bwd0QGaiZAHVJb0z5X09d
 7KDqfPDBq0OZlQJd3+5CcfvzeoGYp9a16h/KEtJpoIfMMFf7MVUceQvCfVFVr5Crg6cahZ1yt
 Ne9nRZxCcOAnguM7FlIn09HL6hCMPPTSrJzVuhSZiKARnFz+t9itvwGGb2orSZPQyoBnLQip4
 dNBylv+y6L0QSsigjJVNt3Syybft3gPzkr/RCOmxqCwQ9ofcGz7CzVE5izZzxYTDHmC4ekGYv
 R8t9upexilZrxj53hMftaXm22oClvRsQBGJKG3b3FLwIeG69i+vFkqfljzUwk+CPFmg9IOAHu
 8wzT3tK1pzRRAIhTvs33XgGxZXyJNewj/U6War1HG+YY4cJnIJw08Ly58SyG1MjyWSIb8606g
 tCDsw9jU0o0oD536U+KkA8cTJzGmXwNA7vcINTO2kWtLR6ux4c8r/hiXEYN4YwD6eRX6JHlH0
 BeLkT9xkHLUDx3fXPm5t1h3z4Dil1VsX2oYPOZpX3C+ydNWjhUOEO0vWT0/Pn1Bpe7tWqzPaD
 02xusg1yfhE/6bWtNboKFIXh9aY3kd51intgJDrD4O9Cx8tHEBMpyIrL9Cve+lHAo4hLY7Czl
 uf3O9VTjIWE71UhB9VG9hnnigLjJ44CePkmwY7XCtl3DwFF9ZXzwtcf2dn954RyT+70J+k+kg
 sNgWuYqNnrh5CBDNrwLJwGBhQp0VzpX3LevNg0YCD/bRTnnFLS5u5+QTD8XSGlgJ11dGsywk3
 ZrasnD2cUc3t68K5/CEaxMJuCSV5oeePydetm77K5jfpJzgTBXi30gEEN9G/L6UrgTG6XoeSX
 sxRjNqozj4d5lKLsAX8MyXx1c2DS2lVVaR5q6/Um8M31uLowhQzJxMv4Xfkqc54KWrdbmJX0l
 QkuJlzvcuKrZ6M408URZbFSo3/Ln8UmO0BTXgChSGk45gUOk9yRP91mAVxPtmL/eYNB9xhtGA
 m6LRsKpHwzJghQ3X87pf5dAW2o5nz/d9sKx7U1F4UBh4ZpmOT00b2n7fk9Pk3tNHxxs4FS3Fd
 XHpAiaOvQEBQHeRGDglXH5qIt2Vf8M6h84Xsyqz2LZktromLvRqLgj5IxM+ztFwdR0nWf3PxI
 u6TKPArUFQHF0kwBeBx8Wr0P3YQKQN9LLYQWJahwnbbTMuocj8XTKL/hw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Mon, 15 Aug 2022, Phillip Wood via GitGitGadget wrote:

> A while a go Philippe reported [1] that he was surprised 'git rebase
> --keep-base' removed commits that had been cherry-picked upstream even
> though to branch was not being rebased.

This has bitten me, too (I did just not get around to reply to Philippe's
mail).

> I think it is also surprising if '--keep-base' changes the base of the
> branch without '--fork-point' being explicitly given on the command
> line. This series therefore changes the default behavior of
> '--keep-base' to imply '--reapply-cherry-picks' and '--no-fork-point' so
> that the base of the branch is unchanged and no commits are removed.

In my mind, `--keep-base` should always have adjusted the `<upstream>` to
point to the base commit, which is what patch 4/5 does.

So I am very much in favor of this patch series.

Junio seems to be on top of the code review, so I'll avoid stepping on his
toes by adding mine ;-)

Ciao,
Dscho
