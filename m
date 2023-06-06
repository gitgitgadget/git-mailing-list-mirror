Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522B4C7EE23
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 01:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbjFFBXX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jun 2023 21:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjFFBXW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2023 21:23:22 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72925102
        for <git@vger.kernel.org>; Mon,  5 Jun 2023 18:23:21 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b04706c974so48044565ad.2
        for <git@vger.kernel.org>; Mon, 05 Jun 2023 18:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686014601; x=1688606601;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UmWBxLINXODbM4JQomc88pwq0Q2W+Y+41PHVmbBcGLw=;
        b=pfrdx99GbsL9hv9tJsbWOMZkpiTi62Ni/bRABFhJbYquBiyGYh1VF1+OmnyvUYC6Bd
         Brc25nMCjYXRlsDkRzaIVu3aTZG07scgiy/xEN1XhJam1Kv5RudrWylmKcegJkrjLdj9
         FLBPgJDkRIpG01l+9hOxRpmWQ8wEShYkC0qm002GQ3OuldNeT5Rm06uIvuJU1QXwkiqm
         vnUYRs+s/8ReXnNC+QF/mp84RILdZcttWCPTF7I7YTlJYV52ACKFEj7FJKvd50ATp9XO
         khELu/E6GK86SrTRFXgvFRRrfcp/EzHIjn3pMdYm4664LXA44wBQP4KZ5zcpe6EKUbyF
         b97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686014601; x=1688606601;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UmWBxLINXODbM4JQomc88pwq0Q2W+Y+41PHVmbBcGLw=;
        b=FdB70zq5cc2s4wEhw6OtqQBlLmtO00swDjwBFoY84T21D7rMkfijgsS5+MkRxBA3CY
         gIiwp3HnzB5Y9JwHEJWpxBz5uzeMsgXNHlPeoLbxCvBKZMKSJ48pLz/cqyWqkJCHB8Ra
         8ZYPxQqibMR1HV1KypObFUvDsdTqLq93WmroBsWob/YzyeiI723L36qHhkLVnVPGZABh
         tS1VeP13RdhAtc8ig/pG48w8vxgLjDRUWTNME3ILMCC5osJWD+qEpeFtmlLdPjOagH7i
         m5DH1tzNEEl9pL/KAX0VZy4STWdwyNVtxwmYT+3e3NiV44vHYC0+mQbllEy0qgO/c/1i
         J6Qw==
X-Gm-Message-State: AC+VfDxsgsGIDtMxoEt5w4FfI1rD+RW/V3HbWpNJUXmEg78EXhm/apdj
        a5sSP0y2syTYlqdgWXa4UJA=
X-Google-Smtp-Source: ACHHUZ4gOHIcY4+gvRBCiNoZk5RjpVYwPzEpe2fDKnrNMyNOXabeLFhlOlUWQRdj6c7qipjym5AgJA==
X-Received: by 2002:a17:902:7b8d:b0:1b0:295b:f192 with SMTP id w13-20020a1709027b8d00b001b0295bf192mr764578pll.3.1686014600806;
        Mon, 05 Jun 2023 18:23:20 -0700 (PDT)
Received: from localhost (217.195.118.34.bc.googleusercontent.com. [34.118.195.217])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902ea0a00b001b03ae38496sm7218146plg.48.2023.06.05.18.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 18:23:20 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Toon Claes <toon@iotcl.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 5/5] cat-file: Introduce new option to delimit output
 with NUL characters
References: <cover.1685710884.git.ps@pks.im>
        <07a7c34615ec68fa42c725fd34d6144b6b191f03.1685710884.git.ps@pks.im>
Date:   Tue, 06 Jun 2023 10:23:20 +0900
In-Reply-To: <07a7c34615ec68fa42c725fd34d6144b6b191f03.1685710884.git.ps@pks.im>
        (Patrick Steinhardt's message of "Fri, 2 Jun 2023 15:02:46 +0200")
Message-ID: <xmqqjzwh4c53.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> Subject: Re: [PATCH 5/5] cat-file: Introduce new option to delimit output with NUL characters

If you are going to make "-Z" and "-z" not orthogonal, then this
should say

    cat-file: introduce -Z option to delimit both input and output with ...

or something.
