Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12573C433E1
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 14:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB95B20786
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 14:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/DHcBwt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgHROSW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgHROSV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 10:18:21 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0A4C061389
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 07:18:20 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id f26so21607567ljc.8
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 07:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=SZ8+6Vx/VoW3H2yO3bgmZnHiWDLNqZFWbco/8tOOCOE=;
        b=L/DHcBwt9xKFyqsGlSg2oaPSFP/Jyq/N4Q0OJLFtWOYfKnkGeyIZjmrILFDx1GV9O0
         4KdPiljImtqv/R1DqQrTn8SOZJbPGYzr9/QI8qyoOR2CP5KHNczQXUQyr+idaQMYq68Y
         q4F/PRLqP9HmnX9NYRtg/pPRgpcAXzNfto+nMEYnwFHbCsMZFCfhnkoDllX1lxeDNFPE
         w4m2D5IoE8Px+SA3AKWALCZtM5inrj57XppmL56uopIV/Vngr6FSXDhWreZ6cCoABiS5
         gr4pNltYmv0bUraMdZSt05vYb6nOMeWZAUVc1ga6VYiSgvLdGzH5CM05NnsBMZxkw/YG
         bYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=SZ8+6Vx/VoW3H2yO3bgmZnHiWDLNqZFWbco/8tOOCOE=;
        b=DaGg/Zgd85eQErFgWcTejaEJbGcN1xGnOjkEVE/Y5yCxnsTVGViS4qnbnpn5Tr3WO6
         Y1rQe70P8IEfsdloJIQFLu0GfG+SsxSTDUciBy1f1/qaAOM4j1EjkBNoMs5MWJ5oJYJx
         oBYc+XGBU/kOFbD4LQSoPd6CvDbd3uFrMlExhgahKeSLHjKztaKTxP17E2uPbz7h87X/
         fGlkQtQ7QRCRHTFGw24kvupNwDZzmck0VU1HtydauYdxiwLRzXkltuhSFRN7peUqqIi7
         tsheB5ud6+t34B2PuXecIVLcnEQOCK5o2orB59zoguueMx5xAO0QEUdKRKnXNJe/8ony
         elYA==
X-Gm-Message-State: AOAM531z+Yp7qI0Iucy3BdEqfJrbcH6rvsDEgUy5rv+hzHOToX8wMnZF
        64iREFSNxnitrt3etwA5Qt8=
X-Google-Smtp-Source: ABdhPJzc15u+lnZGS0vvy2PZ5iL3yGV7gBYpBasHjCGpIlbMCPiDVZ52K6OHaCb5VfIrqYPeXTqnEg==
X-Received: by 2002:a2e:b708:: with SMTP id j8mr10166479ljo.375.1597760299119;
        Tue, 18 Aug 2020 07:18:19 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id j6sm5974856lja.23.2020.08.18.07.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 07:18:18 -0700 (PDT)
From:   jnareb@gmail.com (Jakub =?utf-8?Q?Nar=C4=99bski?=)
To:     "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v3 02/11] revision: parse parent in indegree_walk_step()
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
        <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <e6738672349254c6405f7dde48f612b82af9299f.1597509583.git.gitgitgadget@gmail.com>
Date:   Tue, 18 Aug 2020 16:18:17 +0200
In-Reply-To: <e6738672349254c6405f7dde48f612b82af9299f.1597509583.git.gitgitgadget@gmail.com>
        (Abhishek Kumar via GitGitGadget's message of "Sat, 15 Aug 2020 16:39:34
        +0000")
Message-ID: <85imdgxck6.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Abhishek Kumar <abhishekkumar8222@gmail.com>
>
> In indegree_walk_step(), we add unvisited parents to the indegree queue.
> However, parents are not guaranteed to be parsed. As the indegree queue
> sorts by generation number, let's parse parents before inserting them to
> ensure the correct priority order.

All right, we need to have commit parsed to have correct value for its
generation number.

>
> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> ---
>  revision.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/revision.c b/revision.c
> index 3dcf689341..ecf757c327 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -3363,6 +3363,9 @@ static void indegree_walk_step(struct rev_info *rev=
s)
>  		struct commit *parent =3D p->item;
>  		int *pi =3D indegree_slab_at(&info->indegree, parent);
>
> +		if (parse_commit_gently(parent, 1) < 0)
> +			return;
> +

All right, this is exactly what is done in this function for commit 'c'
taken from indegree_queue, whose parents we process here:

	if (parse_commit_gently(c, 1) < 0)
		return;

>  		if (*pi)
>  			(*pi)++;
>  		else

Looks good to me.

Best,
--=20
Jakub Nar=C4=99bski
