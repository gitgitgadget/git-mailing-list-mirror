Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA23C4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 16:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6223160F14
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 16:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhHPQ6w (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 12:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbhHPQ6s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 12:58:48 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BC1C061764
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 09:58:16 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id l22so11164044vsi.1
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 09:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=v2VQoCJjSt+erG8BkmTkrHgkMFnfhF7EMGqHMZYbUS0=;
        b=CVd2hE9qe+L0ZmNB5Xs1w1HmhKxYKCdF983NPfUcntv7c2odza2ItAucPtAXEbEHYz
         QarrhMfPPGMm4H47i1KNOElM8cm3tYvdgCc8gtLBfzNZZ7/h8WSREJluUkGUs6Z64ulA
         9WLqoPRBNyULljgvoPu3HbUJb6WCVA5HEEevgoDbmoyICVk2Q4ef6Nv7SPOoVfd+NeoS
         PC8rK5A8kioieHuRC1roz+eE5UAdb2GZkN/fv/pb5umUw5jE+tO6zTrzpEM+GLBCLLLg
         mZbsNmMExQZusC2y3WA0dCuajETSyf7jjbGZ5EAtYQzLy3ZvhpymAPSZHtLblP2L/CKf
         7Izg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=v2VQoCJjSt+erG8BkmTkrHgkMFnfhF7EMGqHMZYbUS0=;
        b=NZDv+N5xIjFALYQWnt6T80OEz1flJ0+1G5C1+GVC9kO0xLziS8TS3kdotwCKsyBSfh
         gVUk19oQQdmtmLcc3mDp95iO7+y3aM03pYCqpcX4hvHuvaBmmof1wSgh3x+QF5r9QoN9
         BIWlgTEMIV9yCsHaaknpHL07SyMJalT4posK9BNoPedyUIxIEQIA5Y1nGZtIXRjop83M
         PoZzkumnamDnqNRjxcbhJ4uX13LusrEGQ6iQoJ+U/XlgS5T9ifsVYJe+Cn3WaqAF9DG9
         kJIM3mXz2JleXidT5qdu64RskVVj5K/fyh+K2EIaCS7GJeMFR8YNin+lIL1w/v//KAu4
         Kmsg==
X-Gm-Message-State: AOAM532uypGiyPUZekcd8rybnLVOd7k+AqqgzDbSLinfr0y/eHaAjBVw
        z2SYP7QSuOU4Y8XQYN3tL6HyzCTI2EaGvbtMnZ4=
X-Google-Smtp-Source: ABdhPJzXvWp+yUmjwN1OM5rXeZUb+JPCsXaE1hUTj7/3IJVlv0TAS8Pq29j29zcIc6e7oVpfYe7F1E1lkEnjX/cMgsE=
X-Received: by 2002:a05:6102:11e3:: with SMTP id e3mr10976216vsg.49.1629133095666;
 Mon, 16 Aug 2021 09:58:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210816045750.36499-1-carenas@gmail.com> <444e7410-c9c9-1b90-da5f-d6862a35c1fc@gmail.com>
In-Reply-To: <444e7410-c9c9-1b90-da5f-d6862a35c1fc@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 16 Aug 2021 09:58:04 -0700
Message-ID: <CAPUEsphsyxdjf7WfqQQhBbVYt_URAdj4Cg-OT+dJenO7vpfOJQ@mail.gmail.com>
Subject: Re: [PATCH] ci: add job for gcc-4.8 to GitHub Actions
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 16, 2021 at 9:06 AM Derrick Stolee <stolee@gmail.com> wrote:
> On 8/16/2021 12:57 AM, Carlo Marcelo Arenas Bel=C3=B3n wrote:
> > it adds 2m to the current setup, but gcc 4.8 is hard to find in modern
> > developer workstations (or even non EOL enterprise systems)
>
> Forgive me, I probably missed a discussion about this
> somewhere else on the list, but...
>
> Could you describe why we want GCC 4.8 in our CI? Is that a
> compiler version that we officially support?

couldn't find the specific thread I seem to remember, but AFAIK it was
because it is the compiler from RHEL7

Carlo
