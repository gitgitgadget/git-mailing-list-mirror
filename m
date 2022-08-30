Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530A3ECAAD3
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 02:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiH3Cxx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 22:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiH3Cxw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 22:53:52 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826F298C83
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 19:53:51 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id j1so7771567qvv.8
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 19:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=8wjgd91do9BQwshqZamA5bXQ75o+bQ/2AudBv/eA5aw=;
        b=VjvqqDfEfwrqMnpYyAVXdpj6QlpVH1xv1qANoC87IwCunj+Dkl29TLGWDiGuEOa1xv
         PG0vIM/L9wSnFStsJQb60yD6R57CLVzRyeldRGSSg0l0rJuLJ83LIMFDuT0TtGr18Go0
         hGdqw3KzGZ51bobUGgzq4pV0VOGIrYoESvFyf1Zy7MbIsEgeYSEv8qfwO1SBNBU/feKs
         XHMv4f1ypTX7Lh8pn8WXLAPMjiTrc9k9M0fhIuEC8Z2habmNSx7KFjM+4TjiwZtDlr9Y
         QuuBhWkyrklRak4pWSjLLDL9Qg7zqO4z7q2rMKpBXvau6hd95W3Fz1o27xWL/N5jFWLr
         kM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8wjgd91do9BQwshqZamA5bXQ75o+bQ/2AudBv/eA5aw=;
        b=IrViDXgIzJWILix6ziQhYr+lXkT2kcGwrb7C72k3IkqryF/+pigrJfk0OZrYZnzDk5
         74JgeanErkDZA1wQ9Pdccbz4HGCuXYLA1mHaA8TOzY/PwEOJzaWpv9UxZcpIyDS2sss6
         O02xTWMSc/tIO3CWYM/k+2nfRYtbBIG0AOhphP3j2P8Nz5Tjt3F4X3ekRErxd/LDQrLj
         1iLEjPBL8iqmJbpwG9m2kT7ANtwkYI0jBTwktka5PQjoUXA9wi/PKEq99Gw/4k7sPiWU
         wCLvDsnO5tMaH8ASy7e1od7UpYYAXOfaoMYBoCxIstqGZuymV2Sq2y+HpOLv5uI7fIfP
         9Vbg==
X-Gm-Message-State: ACgBeo2ib4DfD8HFVuVaHltC4LPpnJD2snIAByKYdGrvD44s19Mq3HYE
        ZLwHt0O362cVj+A2bz3BhUBSBn0p7eYiNuRIFww=
X-Google-Smtp-Source: AA6agR4eC8RMwfRR4LMHTkWwYEaCcSMcYOb5HeTN6WvB1wec2CfPQuaBfKfnG+2CcskPQ7pKpBHavmSHkO4UPv5aj+I=
X-Received: by 2002:a0c:f24c:0:b0:498:fd2b:328d with SMTP id
 z12-20020a0cf24c000000b00498fd2b328dmr8173657qvl.69.1661828030673; Mon, 29
 Aug 2022 19:53:50 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1339.git.1661663879.gitgitgadget@gmail.com> <xmqq35dgt9ph.fsf@gitster.g>
In-Reply-To: <xmqq35dgt9ph.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 29 Aug 2022 19:53:40 -0700
Message-ID: <CABPp-BGTdqo9rBoWYeOp+ATU1NS+GFzBcdPnMPGgH0_Jksr7zA@mail.gmail.com>
Subject: Re: [PATCH 0/3] fix failing t4301 test and &&-chain breakage
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 28, 2022 at 1:05 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Eric Sunshine (3):
> >   t4301: account for behavior differences between sed implementations
> >   t4031: fix broken &&-chains and add missing loop termination
> >   t4301: emit blank line in more idiomatic fashion
> >
> >  t/t4301-merge-tree-write-tree.sh | 24 ++++++++++++------------
> >  1 file changed, 12 insertions(+), 12 deletions(-)
>
> The second one is off by 270.

Apparently Eric knew what you meant, but I'm perplexed by this
statement and what it means.  What am I missing?
