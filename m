Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D087B20379
	for <e@80x24.org>; Mon, 22 Apr 2019 06:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfDVGah (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 02:30:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36836 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfDVGah (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 02:30:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id h18so13430267wml.1
        for <git@vger.kernel.org>; Sun, 21 Apr 2019 23:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZqzQXaB4IlUNUsGpyhRfACjcDdz5MDMU11/v0DB7XYA=;
        b=WepPCR+QF38RO8kvDtPKnMCMEF21IW41abZx6Af/0fbZi1wRfo9P4KrfzmKeglA70q
         PvVHH/pkZmPCVUSviE2CoUU2wYCdyk/Yhh8LZCwLI5M3uKG/keJI9BUT2bUy63Dro43a
         VSHJQPJ2YH78zfwpcuCl06TmDYO3w8/qz9FXfVoDiIxA4wpJm47AtVZZFHbDfhGsUQ0f
         tWL+oMWkS94o5tdIhW01OwgwdBNEQI9pbIq8K2aXqaWMy1VncJikveqzip+6ss4vrBTD
         xHy28zgt7v7Jx4llGDit0+mfGpkYtN52b3gZb5dQtsZGzm6MFfrUooD3WUHFRRbZHGRA
         L2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZqzQXaB4IlUNUsGpyhRfACjcDdz5MDMU11/v0DB7XYA=;
        b=s0BlRu1vOk8R6awNcCq72nwSUTJn2jeV2uAmYLeZCz6hGnuRubGwi6mB7XtMmjuSku
         i2P2/n2xacQ6ufH/5kvmV9EqNTixiZist/uhwwidlujpWXuQQazYgDh+UcEWABcPfp1m
         gMaontfc0XW9Xzf4Ulqq3+3M6Mny8BB+Jux7AgU22apUidv561Cwt5UlaRXt/TOGdPsN
         7lzGDX1r6zmtbnOwxem/bLiTBg3rlTA/ueMK/gqSznng63lSj8/Ky/xQOXIJBbuiqwuX
         29zKq8pL5r1GaZzv0hviJtPljtKeNHsCtwDGM55BGSFYDrU8qYNcV54MAANO7poA9oid
         g0iA==
X-Gm-Message-State: APjAAAVmhJwB6WlSdlJl81Bsogi5S5TrLrcjsQfwux2pIfHNE7pOOcYs
        WdS7HbZiF3dBZJpGIR/et0s=
X-Google-Smtp-Source: APXvYqxrXtVnjF5GX6Qr5Xll5mCzWYIsI5wp/+dol4l1+l9waXYFgWU7J8xq0TTM3dfSvc7HgFrVQg==
X-Received: by 2002:a1c:dc09:: with SMTP id t9mr11098285wmg.142.1555914635482;
        Sun, 21 Apr 2019 23:30:35 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id z20sm10112147wmf.34.2019.04.21.23.30.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Apr 2019 23:30:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] cache.h: fix mismerge of 'dl/no-extern-in-func-decl'
References: <cover.1555487380.git.liu.denton@gmail.com>
        <9d6c51b2118b24cd94f3e2951ff0e9ee82afbd98.1555911520.git.liu.denton@gmail.com>
Date:   Mon, 22 Apr 2019 15:30:34 +0900
In-Reply-To: <9d6c51b2118b24cd94f3e2951ff0e9ee82afbd98.1555911520.git.liu.denton@gmail.com>
        (Denton Liu's message of "Sun, 21 Apr 2019 22:44:04 -0700")
Message-ID: <xmqqzhoi7drp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> After merging 'dl/no-extern-in-func-decl' into 'pu', it seems like the
> conflict resolution mostly went well except for one spot, which this
> patch should fix.

I do not think this is a mismerge per-se.

That line is not touched since this February at 7589e636 ("Merge
branch 'nd/the-index-final'", 2019-02-06).

It is just that large scale churning on a common and busy file like
cache.h is bound to cause painful conflicts with other topics, both
textual and non-textual.  As these "extern" in *.h that explicitly
marks that they are merely decls and not defunitions do not hurt
anybody, I think it is better to leave it to a cleanup pass at the
end of the tunnel after things gradulate to 'master' and start to
calm down.

Thanks.
