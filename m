Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D577820248
	for <e@80x24.org>; Tue,  5 Mar 2019 05:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbfCEFuP (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 00:50:15 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41172 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfCEFuP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 00:50:15 -0500
Received: by mail-wr1-f65.google.com with SMTP id n2so7996714wrw.8
        for <git@vger.kernel.org>; Mon, 04 Mar 2019 21:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FnfOT2ragySPlMwF8iCHUrzZp56CCZNWaJ58n0cBfGE=;
        b=ImsneCXOyqmb88AZ3BQ0i3jFsVAKX/gK1NKNtoZaC49HnlQ6vnWaqFe2Mhzysus6ig
         Ux8oGx1D5VZGJzuiLrbUxPvIm/PtKhOcbWQRx6Dt5mQ8FplWY5HOB+Zn7UBM7kHy4eeB
         mKuBdZEtF8gx9/7YOUwfHGYW9jbH3eo/xfof2kJY0sOn6UxmZjlt/C9MceETuGmDy1kG
         jVH5B2Uxart4U5aI75i8/WlLABaF/SQYZP0m6ZLE2aieqBRZQLBOqwynE3s5bC7y8b8a
         ZsaX9X9M003JvI2w6mMXTPEGpqO0JP98rY6/GgCIjOPQBz/BYEqalmFdnJRd4PTa7IVH
         VtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=FnfOT2ragySPlMwF8iCHUrzZp56CCZNWaJ58n0cBfGE=;
        b=QApuzEYGbtyLtuYGc0rl2aMPenIbwtpWkn4utgXq6xIsNBhJUeX+4IIC6f1XH11DeD
         ZenXOOsQ50odhYMbiCYbNO5On3L5+SSvd7ySodUylbYuTsxVbovr0uLwzvx+hFI5SWXs
         jgv1u+CjeSUPwQTRxj2PfbiznZG5slqhY1wz4lqsBbk4aevXWmTMmUqYeMjY9vOB27Mv
         L0E1Ft+hVpqMzRe2/lzFYyrLT1fFhcSmIQ/ToeJkhOZjCSXsaLOxAMIJyfa/TDNkKlS4
         l5pmzYzVNSgxbqzOQ9RaXbWTOgYxFzoPTdOwD0anaRd/AYdTr4kzvaQdeI1QU+hjxE/q
         DdpA==
X-Gm-Message-State: APjAAAVw6m9EExCkSKHxnKpKxQ51g/uCPMN7iuFO4kGGyLnJxqULkaDA
        IW3TVDv7jQSiULhIkPDlVaY=
X-Google-Smtp-Source: APXvYqyWXkbwoC17FwyQFaDmqAYz8lCPr7JVu7TFMvbkAVCpgp0jNY/PCGTp2B6dMsLcVBK/TGy+vw==
X-Received: by 2002:adf:c7c6:: with SMTP id y6mr14647796wrg.217.1551765013330;
        Mon, 04 Mar 2019 21:50:13 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r15sm8312691wrt.37.2019.03.04.21.50.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 21:50:12 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] Makefile: use `git ls-files` to list header files, if possible
References: <pull.130.git.gitgitgadget@gmail.com>
        <0b5529406b9458d37f3f5cdf38baa2d6a0a70a65.1551470265.git.gitgitgadget@gmail.com>
        <20190301213619.GA1518@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1903022058230.45@tvgsbejvaqbjf.bet>
        <20190303171951.GD23811@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1903041206300.45@tvgsbejvaqbjf.bet>
        <20190304214155.GB3347@sigill.intra.peff.net>
Date:   Tue, 05 Mar 2019 14:50:11 +0900
In-Reply-To: <20190304214155.GB3347@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 4 Mar 2019 16:41:55 -0500")
Message-ID: <xmqqzhq9vpik.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This makes sense to me, though as you noted elsewhere, it doesn't fix
> the gcrypt problem, since that file unconditionally wants to look at the
> system gcrypt.h (and we control at the Makefile level whether we
> actually look at sha256/gcrypt.h).

Hmm, is that because the header check target does not know which *.h
files we ship are actually used in a particular build?

After a normal build, with dynamic dependency checking on, we would
have sufficient information to figure it out.  Would that help?
