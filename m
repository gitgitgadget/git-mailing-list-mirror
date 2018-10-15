Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 776991F453
	for <e@80x24.org>; Mon, 15 Oct 2018 05:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbeJOM4O (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 08:56:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37001 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbeJOM4O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 08:56:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id y11-v6so19615929wrd.4
        for <git@vger.kernel.org>; Sun, 14 Oct 2018 22:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wXAnSRK8/ewc9JexsH+dDKW9GhHVBiBqRWtXeVHdgTY=;
        b=JYwv8DYkpGHAUj4S7ymbBBx5ASH4SVMvF5sl9Db9AF34ZIG5pSiQReazFc+a7OwMTX
         EegQtCX4eWp5XLteIfsGmef4xgSfNEJiFcIyql9Uf1w56exdxawZfnxLDHs9oDRFsa/a
         TMC7oSB0kkX9MUODkYAOoQziGXFyN5HdEXIOucoMW5n5c4VzPdntOXU9LiFxDycswHyO
         fYpZPDJwhbd47ueq5JlsvL9u1yV5r1ZasiYg1/3AZqCYstZgAStGfJ46ve+Mf1RjJVGp
         gNfP3xePRbh82Nz6rEy7fsHv2t6J7xqt3Hj038CEgdRgfNFsFAy6DLyFVgok7F+gbCDc
         7t0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=wXAnSRK8/ewc9JexsH+dDKW9GhHVBiBqRWtXeVHdgTY=;
        b=WBUFz4d/HaLGFb+V1JQFSofc33/O/SWKPS5hs6q3Hj2rY0kAwsMM9nNRwtIv9yhipj
         tP6Ztmpywi+3iR1x5V8E2MuNgMXE7JKDEK9q5ed3XTENT701vlkJfo5NETI+nJBf++GL
         ThfGw1/OhlS6+8FSR83w2r8x4aJzz8iw+OdELv+Qa6dRFm0qoniINVQSp0Ei/4QEI1jq
         hirO1nMnqiJixp01VzwHWypa69kb0Uq4DKH9I6aB2HDnOEEoIFG/3iUP+kdBMrQ/5O9x
         VF6VLyo/Z5g7EtLKz4j+L0O3wjek4LIlVnmYFq9Rf4Bn8maRYHSFmWaqlmGO+Yd45Omy
         XfWA==
X-Gm-Message-State: ABuFfohO2Y9lVNi675+3+TA/+vijwk4ztIvJ8K/iKcuHqiLSXfqXQ7NP
        Uh9Uogm3qN7Tfz62Kv/LEAY=
X-Google-Smtp-Source: ACcGV62P2FWnpatI9iSCwVK4zJ1lxCEzU6TtAojhmv2Cjh0rbEzzXghYf7j0v4eC0enaOS/62Mj5cg==
X-Received: by 2002:adf:f00d:: with SMTP id j13-v6mr11992127wro.88.1539580356559;
        Sun, 14 Oct 2018 22:12:36 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h63-v6sm6528679wmf.31.2018.10.14.22.12.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Oct 2018 22:12:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH 2/4] merge-recursive: increase marker length with depth of recursion
References: <20181012212551.7689-1-newren@gmail.com>
        <20181012212551.7689-3-newren@gmail.com>
Date:   Mon, 15 Oct 2018 14:12:33 +0900
In-Reply-To: <20181012212551.7689-3-newren@gmail.com> (Elijah Newren's message
        of "Fri, 12 Oct 2018 14:25:49 -0700")
Message-ID: <xmqq8t2z6bem.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> When using merge.conflictstyle=diff3 to have the "base version" be shown
> in conflicts, there is the possibility that the base version itself has
> conflicts in it.  This comes about when there are more than one merge
> base, and the merging of those merge bases produces a conflict.
> Since this process applies recursively, it is possible to have conflict
> markers nested at an arbitrary depth; to be able to differentiate the
> conflict markers from different nestings, we make them all of different
> lengths.

I know it is possible that the common ancestor part that is enclosed
by the outermost makers can have arbitrary conflicts, and they can
be even recursive conflicts.  But I fail to see why it is a problem.
Perhaps that is because I am not particularly good at resolving
merge conflicts, but as long as the common part of the outermost
merge is identifyable, would that really matter?  What I would do
while looking at common ancestor part with conflicts (not even a
recursive one) is just to ignore it, so...

Not that I strongly oppose to incrementing the marker length at
every level.  I do not think it would hurt, but I just do not see
how it would help.
