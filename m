Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D72C433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 06:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75E01610CE
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 06:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235281AbhIKG6c (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 02:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbhIKG6c (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 02:58:32 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D46BC061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 23:57:20 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id q14so4468676ils.5
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 23:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=sti45xNZeGE2ypankAK0req/nnWKemPlUoTGJlGeJi0=;
        b=qc//tA9VqipNiFEv+vpAXygm/Jgsib8pPImJln2HN/WhW8JZz8yROTFfNSiNNuW3iy
         fh7fVgjNAtHUEbbYy01Lu3Wfex33LUYYUTLHgvlbrXAdkgy6w6yEHcjxySqGtT5o1oIB
         Ur+rFwHLbnkm4126gtzxkabb6b6STbiuT0L9rseTyKIIN6xSQtxJUAjtuFqcIfcCvkA3
         1+QhoK22Ts989yJLsKtd+WNs5RQKBRmcgylS1GwpQ2vf8LZ5BtDkcvvlkgztKVBNUbW9
         /ZcINUFcqESAF1jWXwnUnltmAQpf2F18PzsxEKsOIT2hZ+vJuxzzGBD7sYrgcYkveXD6
         Px+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=sti45xNZeGE2ypankAK0req/nnWKemPlUoTGJlGeJi0=;
        b=ZU6rx4xhfSflzloQljQ4mMppsgIrQXttMWzHBIU5Btr78glUtSF/UhZJCsHeoo4Xcn
         edfZLMci1AkrgnAC23w7RjNfHpQhUJLv3K/RCbUcMKWZJQVcSg0oWVonGVAELZm8+r0F
         w2aIi/6ycHUx+gAy8pZ84BbPVMPgoQLqFjJMXykfgM6rNxEshfdthNMBx0eK8gQtDuUx
         FuVd0inoaiokXLzy1Dj+OCTdUX+kMbIL/C266ZiUqCtN5u6ZstwxRDoajr8hYun2Vgvk
         YhTLUe/V3NrQPk+JfGCOm5PRW6z1rHYLaFn9sK2+Rxmo5GA++qI5yPh0n1SOKyhRs0PQ
         NZSQ==
X-Gm-Message-State: AOAM533cdYmrqblSUT7BEngcfvFM6ioEsVZ8mFdxfTd2J8NlJw5NGLxn
        VLLd6h4rXnbT+HlYXH92bo07d4dxbrqoVD6scyh1PL0=
X-Google-Smtp-Source: ABdhPJx1IiN7dVa161qLwAbk2Ywma9csT03asfSK16HytGl4GDTvga64Xi7qTQVtXiJs8tnvAMtG/7IurVdHLKyBPts=
X-Received: by 2002:a92:c70e:: with SMTP id a14mr929093ilp.299.1631343439171;
 Fri, 10 Sep 2021 23:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAA9rTucw0wzghy_onKgSWt=QmVoB1qsV108V7NYApJyV8FCpNw@mail.gmail.com>
In-Reply-To: <CAA9rTucw0wzghy_onKgSWt=QmVoB1qsV108V7NYApJyV8FCpNw@mail.gmail.com>
From:   =?UTF-8?Q?Gabriel_N=C3=BCtzi?= <gnuetzi@gmail.com>
Date:   Sat, 11 Sep 2021 08:57:08 +0200
Message-ID: <CAA9rTuf+AwPJYki6O_hEPAS=aZta3HuvQOWLHnRfv5FV0DfYSA@mail.gmail.com>
Subject: Fwd: Bug report: Githook reference-transaction does not change
 working directory on git clone
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear all,

With git 2.33.0, the "reference-transaction" hook does not change the
working directory to the worktree (or GIT_DIR) when launched on `git
clone`. It is just unchanged in this exact scenario.

MWE:

cd temp
git init A
mkdir -p templates/hooks && echo "CWD: pwd" >
templates/hooks/reference-transaction
git config --global init.templateDir templates
git clone A test

Wrong Output:
CWD: temp
CWD: temp
CWD: temp
CWD: temp

I have seen this problems already on other occasion with other hooks.
Probably the problem exists also there.

Thanks for fixing this if this is really a bug (??).

BR
