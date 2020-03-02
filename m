Return-Path: <SRS0=ovBw=4T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D671C3F2D1
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 19:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D6A20842
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 19:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzVD4ecU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbgCBTRz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Mar 2020 14:17:55 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38730 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgCBTRz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Mar 2020 14:17:55 -0500
Received: by mail-pf1-f196.google.com with SMTP id q9so182791pfs.5
        for <git@vger.kernel.org>; Mon, 02 Mar 2020 11:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PiOFtz1Iud0I4gID1zl1nKrizdpVYcK7ZYOzs6KWAD8=;
        b=lzVD4ecUyf1Vc4Xobc0uyCvgg2CQxw8THbZnMaDD0CkQsZAl/Vue3QNlEyIZ32HOzZ
         J3bv2yWXdUSVWbgzwfmfnkqQA/LDAb7NEwlTPjpdqRC1IVLRwWw2MW6M2L4Qvwj/TQtp
         3MIefAoyr6N28F1owL0RX1LkRx+AqTHmGRhLJdvxY+gimD/kN++qy46tGxQ+m9BYDXM3
         jyk1hDlX6ku060u+/ngiFPIhKE42tkW8otD3dkK+qhCHfl76Sl/b8yrWNbucDSdAaw0H
         doWAgLEbka/qpLgF1MKGz92Rge6H/oBKVj4EuOLV32vxfBFGsFadRo0MkD9K/CMKg/yh
         Doyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PiOFtz1Iud0I4gID1zl1nKrizdpVYcK7ZYOzs6KWAD8=;
        b=phy1uba1rmjatHHdAKJl5yHlKL6N5NmTVui8cdpQqqE56qMqhD+qGclAXMqWFIhbT9
         9Ujea7K95VV15iq9vBgE6i85aKiKgSrdnmU0YfORTcc4K9FU0D56riIN8Uci/1KJuQNl
         GtuRxPajcrkZk0T2/jUgmksYjQ7bMq8Tk+cOZXxa96Wz2sORulh1BAZ8ac0r8QRM7rtI
         MGTr2XtB3JOPdKK2cJssrhczYBk39hca1i78/TAeSN/dfdzemLaCnXYjg2aWgK0+syHo
         HLNallLHObO7EKLtFR6tTwaF0VTZh/XuBxbxDCwc/6ZppuDh+l7+LtHB80WIhFrpkwiw
         txFg==
X-Gm-Message-State: ANhLgQ34BTTN9Geqb2h0B0xW8LkLm3L0Hu8nKPPMER1h2nO2qp5dTsPl
        24ksmsevbvEqK0rX2VfF2sQKQwCA3hv4P8BLGuXqMTrO
X-Google-Smtp-Source: ADFU+vuF/I1HypN52XSs6cU8sl8nJy/4JBRDLKOs0VPqJVp9b2KLQU9BphmfzNRTQop3vfeoZB427i5Fh88FZnbei6Q=
X-Received: by 2002:a63:1e57:: with SMTP id p23mr410827pgm.316.1583176674207;
 Mon, 02 Mar 2020 11:17:54 -0800 (PST)
MIME-Version: 1.0
References: <pull.568.git.1582981677312.gitgitgadget@gmail.com>
 <20200301155937.7168-1-martin.agren@gmail.com> <7330146a-5a4f-17cc-cb26-f90d4060c0ee@gigawatt.nl>
In-Reply-To: <7330146a-5a4f-17cc-cb26-f90d4060c0ee@gigawatt.nl>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 2 Mar 2020 20:17:42 +0100
Message-ID: <CAN0heSpvyTtLouSvocBVXKz-67nvb_58mXJ8jpXr=zE8YsX=1g@mail.gmail.com>
Subject: Re: [PATCH] show_one_mergetag: print non-parent in hex form.
To:     Harald van Dijk <harald@gigawatt.nl>
Cc:     Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Harald,

On Sun, 1 Mar 2020 at 21:27, Harald van Dijk <harald@gigawatt.nl> wrote:
> On 01/03/2020 15:59, Martin =C3=85gren wrote:
> > But I also wonder if we even need the "bar" commit. Similarly,
> > "--detach"-ing when checking out master seems unnecessary, unless we're
> > afraid of "messing up" master, by modifying the expectations of later
> > tests? Was that something you were concerned about?
>
> The "bar" commit was present in the test I based mine on, where it was
> equally unnecessary except possibly for making the test easier to
> understand. I have no feelings whether it is better to have it in or
> leave it out, other than that it should be consistent across tests.
>
> Not messing up the master branch is what multiple tests in this file,
> specifically the test I based mine on, do. If the test I had based mine
> on and my test had both done
>
>    echo aaa >bar &&
>    git add bar &&
>    git commit -m bar_commit
>
> on the master branch, whichever test appeared second would fail, because
> git commit would not detect any modifications. This seems needlessly
> fragile to me, so I agree with the pattern used by the existing tests.

Yeah, that makes sense. Thanks for explaining.

> > I realize the test you add is similar to the ones surrounding it. But i=
t
> > does look tempting to squash in the diff below. The test still fails
> > before and passes after. What do you think about this? Does this
> > correctly capture your scenario?
>
> Yeah, the test set up is literally a copy of the test immediately above,
> except modified not to use conflicting ref names.
>
> It could be simplified, but in that case, the other tests should be
> simplified the same way, and I did not think it was appropriate to make
> such changes here.

Ok, fair enough. I could see the argument for doing a preparatory patch
to simplify and use "test_commit". But I won't be the one to insist on
it. This is a bugfix for maint, so it makes sense to minimize the
rewriting.

There is a (minor) cognitive burden with "create contents, add it,
commit it" compared to "test_commit", beyond the larger line count.
Because "test_commit" adds a tag to each commit, seeing such an
open-coded variant of "test_commit", one may wonder if this is
deliberate exactly to avoid those tags interfering with what the test
wants to do. Especially here, since this is about tags, that suspicion
might be even more motivated. (Spoiler: In this test or the one it's
modeled after, this is not the case. They might just as well use
test_commit.) Anyway, all of that is just musing.

Thanks
Martin
