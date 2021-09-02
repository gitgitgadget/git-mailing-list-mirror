Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA19C433F5
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 21:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1527A610CF
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 21:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346621AbhIBVbL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 17:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345890AbhIBVbK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 17:31:10 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A53BC061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 14:30:11 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id f6so2764941vsr.3
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 14:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=S+KShkOmtCVPqhrF8s3eNSPgt1FqtkIuvf4exZfrsmU=;
        b=nBG/FoQ+BdHao7VTn3WPjxf7jAvdrVKwMKDMV4feDEzcHxPimSMsCJ0ZXMYI58zXHs
         prT09pmt7RlrGC5Loup86FF9Ep5gXUM++VTcPEiok7Oua5tTOvklnQyKOvgwlF9l5W1r
         nb35abBT5QEHE4WZ53cMWrXs2DTsCW4iL/r3Eyr887U5ThM1czZieU/kgSWWnSl+cggj
         4HNFp4P5OcKXfbyFUe/jFCBXV37RGddKSO++EraRZbnt41OrshXB7/ptK68bUdcv/abW
         60Qik8a0Pk4oywdWN1jBIAEsbkfQMl+gUxCwFHrUv781NBlM9O81q+t5LDHEqIGvFZf4
         tGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S+KShkOmtCVPqhrF8s3eNSPgt1FqtkIuvf4exZfrsmU=;
        b=H+LGAsSLCHu0Sr+E6UvGuBpbXTz/p39zW7dfk4zwRzk/FrBi8HegkPKTB1YRTWbuCD
         1MkVIxjVoTUbybudWPQt0cTObvOXJFVB7msykMSBIlPgMYHYB6d61YlJ+wuIE2ZgZiuF
         r4gzqvbXGiLsJYzgdnlGds/lmn8HgkuXL3GnCEDmpVc2C8EUWgrs76gntvvTsXPwPnWc
         rLo+2ZCLHo4OfHZFAIqxexeiB2rPSwMh0uB/7NetlxzDQSMpVTytf8oW7mEzc/1yKRPu
         DK5oLK/zIL4HJ3OLvw4twb0rX2qH0PyF+/ia9VQduztJF7gSNVQ2v0wNFBypKX73T2Vf
         I4yw==
X-Gm-Message-State: AOAM533s73dzqj0ufImVOpRYiQzEXvZ6elp2jua6lQZVElDz0f+2ol5Q
        JlrHLY+HE02Yng+qT6A/ZJtvzvjf+9MPKHT/ceg=
X-Google-Smtp-Source: ABdhPJyNKSn6s/PNRTho3n9O/+E40eAQeUGtxnxVyJ8woq/rEfLK7fE0P+oTK6FvFwzyc5lWV24EKeFJoTvY8ZPoIp4=
X-Received: by 2002:a67:ef92:: with SMTP id r18mr4457505vsp.53.1630618210646;
 Thu, 02 Sep 2021 14:30:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover-0.9-00000000000-20210902T155758Z-avarab@gmail.com> <xmqq5yvik8bc.fsf@gitster.g>
In-Reply-To: <xmqq5yvik8bc.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 2 Sep 2021 14:29:59 -0700
Message-ID: <CAPUEspj9YPJHcKzjGNR05-FnkzRoZJ0yKC1McA5wM06HgUPVHw@mail.gmail.com>
Subject: Re: [PATCH 0/9] remove dead shell code
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>, Prathamesh Chavan <pc44800@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 2, 2021 at 1:58 PM Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (9):
> >   git-sh-setup: remove unused set_reflog_action() function
> >   git-sh-setup: remove unused git_editor() function
> >   git-sh-setup: remove unused git_pager() function
> >   git-sh-setup: remove unused sane_egrep() function
> >   git-sh-setup: remove unused require_work_tree_exists() function
> >   git-sh-setup: move create_virtual_base() to mergetools/p4merge
> >   git-sh-setup: move peel_committish() function to git-subtree.sh
> >   git-bisect: remove unused SHA-1 $x40 shell variable
> >   test-lib: remove unused $_x40 and $_z40 variables
>
> Was "unused" above decided based solely on the presence of in-tree
> users?  If that is the case, I do not think we want to take these
> sh-setup changes.
>
> The implementation details of the remaining part of git-bisect.sh
> and test-lib.sh are OK, of course, as that is truly our local
> issue.

The removal of sane_egrep() is also unlikely to cause issues, as it
wasn't documented as a public API, and it seems similar to the
git-bisect's implementation details you refer to, except for
git-submodule.

Dropping it now would avoid having to change it to `grep -E` as egrep
gets obsoleted.

In that line, git_pager() and peel_committish() aren't documented
either; document or drop?

Carlo
