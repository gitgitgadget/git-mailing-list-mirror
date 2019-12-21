Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05734C43603
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 04:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6611206CB
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 04:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSmp3A3d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfLUEh3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 23:37:29 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37356 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfLUEh3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 23:37:29 -0500
Received: by mail-ed1-f68.google.com with SMTP id cy15so10510068edb.4
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 20:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LBPMWdAbm741dpbjBCdXxLwaNCfvg5xq23xcwVSsDmI=;
        b=CSmp3A3dFqZ2Vyhqgre1iwmVopVQC730VYn1qNSUkRqLqVEot1BoQyuT2KTyjdZWYa
         neqN8+yRG+ny38Kql1RDQFwDlvQvU5OJ9uaojSPY1qraNcnpi7f78rJpHJfWC5g/YZKB
         /VDmXeD8PgmDCJrJbjrgcWr6DajjqFTHzKG/rtGsn6E1NjPueLhqYbXHK6zO/PLbFNPb
         ZKT6f2ASW7V3JxFfkQB7oRlkSU80dbyviqWy3JXqCalJvLldZ6PbVfiS39SPVRXWB2q/
         ruQHDl7pKVxCRdM43XRVSfLo/aM6/QhvXs2n6w0xqBMDPY16rmO+SwiC/z06wZbIfCq3
         DIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LBPMWdAbm741dpbjBCdXxLwaNCfvg5xq23xcwVSsDmI=;
        b=ZmKjCarWoA6VcTfJi8kw7EdUl4IRfaiTIOXGzWh5JeOsk9vAfgDpcp78X4H6Qx9WKw
         GoI/VEKgBel4wCq9xKJ66DUylsvOJoN7X2dQO6Ja/vbdiaKqmBbE0r3ivjQ79aIHUOge
         dF70jCAzIxYOLb6RkmB2CCLAi080Ad8zMKulYFvDl5zSE5ATr79VngDj2YHTjIjDkilR
         f/ZO9eUHLNnNI/mEpM9Zr313QkGtcZzPHzq3YlZT/5iQPYDrUb09RCZ20wpZiCqAZ1yy
         XrPY463pm9jPM5IN/HCRVypTYIgKLWXsVQQDTCKWZxAcyCfcSSJq003g99GbcbY78KE1
         fh0A==
X-Gm-Message-State: APjAAAVjDjNjmBpih9wr1z7lV5IvAxWp+McB6R2S0ZWia1URQV2Aomlc
        BSlkNpjda4kcsfdCf80D/S7mjqJGfg4+vggkDaw=
X-Google-Smtp-Source: APXvYqyI2fKSbaSVXWTVHAtrr6tRtHApQwUVmUNNA8Sj/K+KQrwfCDaUHadOzhKwpYiDMKDUQDpuoUUCFaHQvQ5K0u4=
X-Received: by 2002:a50:bae1:: with SMTP id x88mr2886625ede.10.1576903047729;
 Fri, 20 Dec 2019 20:37:27 -0800 (PST)
MIME-Version: 1.0
References: <pull.495.git.1576574242.gitgitgadget@gmail.com>
 <pull.495.v2.git.1576746982.gitgitgadget@gmail.com> <xmqqlfr8b28v.fsf@gitster-ct.c.googlers.com>
 <20191219185427.GA227872@google.com> <xmqq7e2sazlh.fsf@gitster-ct.c.googlers.com>
 <xmqq36dgayma.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq36dgayma.fsf@gitster-ct.c.googlers.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Sat, 21 Dec 2019 17:37:16 +1300
Message-ID: <CACg5j249Ttouiua7iSfMGi7ZaKOanb0TCbMFmEjVtzKsPur4PA@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] [Outreachy] commit: display advice hints when
 commit fails
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 20, 2019 at 8:45 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> That is exactly the point.  I am not in the business of spoon
> feeding answers.

Why would pointing out a typo clearly to the author be considered as
spoon feeding answers?
Rather than simply reviewing and pointing out mistakes in a clear and
a respectful way?

> I want my contributors to *think*.

Nobody is against *thinking*, and I'm sure an author who found an
issue and implemented a fix
had his/her share of thinking to get the job done.
So I hope a typo is not standing in the way of acknowledging the
author's effort.

> Any contributor working on this topic should be competent enough to
> realize/notice it once it is pointed out---even though lack of
> proof-reading before sending may cause such a mistake by
> carelessness.

I have no reason not to believe that this is crossing the line.
No matter how much a reviewer disagrees with the proposed changes, I'd
appreciate
keeping a mutually respectful discussion during the review process.

Heba
