Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C84B41F597
	for <e@80x24.org>; Fri, 20 Jul 2018 09:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbeGTKRs (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 06:17:48 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52532 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbeGTKRs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 06:17:48 -0400
Received: by mail-wm0-f65.google.com with SMTP id o11-v6so8799206wmh.2
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 02:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=eKlqsqQ6/tMwlEIRagFlT14MbmpyCnsGGFcd5rnsJD8=;
        b=oq7CqU13Zp3euM16ciKt5qYt0JbyK3jn//wEkHR/dj+rafPTwwQRC6wHN2kkKe3Grx
         uqRcpc2PXaV3sf2x3ddRbxPk0O79SNjBsWTJdKboYRpKcopR0SUFKv643SxT16VTAfRq
         2oA8EQD93cOmD9MsGGzLfpwrs58or2+RPNBphy7DL+FBMO/qIjarIndesci/rQZ7b9ft
         0h0gVvKBM/C0zA6V6dBjKteugKFay4kuvZ6FOMQ78ArTe12BEyxyqI+NQMzjhDgXezCp
         JmGxeDE4sMsHiasjmbVAq1dqhST0MUL2tpYDGFuP1LNgmxwpWFSkLky5NiRiPJes76u9
         JWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=eKlqsqQ6/tMwlEIRagFlT14MbmpyCnsGGFcd5rnsJD8=;
        b=UwnhJc3VxeOZjJ1Xnp7GgghI5MNtinB0/851kkqBYeUyDXXiS09C/kMIolDqTws+M3
         wnB/KWcVr6Iwp204xaE5QxGGOZSxzztUS27DrTrliL09/0Qust+IZoYOC/u++9G6JGm4
         5piC0FXS/nQSGHHHM9mUJU/E2uOxogGkw6GWfAuQwojt1DYvETGdm0Z00sakOgIV5Cqx
         Qmrn7NlrETXwP9Mxu5C35Miv/RMvKNkJkLd1wW0KPW0NWnQXYwitkOLzIzuGCJQ6cuis
         NrS0+Ln5CqmRX/rpANK7hAA9XzY4+SZ4rtjQN9YnDhS/HB0wWwVTjtgiHS+nFuiSXExy
         Goug==
X-Gm-Message-State: AOUpUlG8XpCIkGRkXWH348ovh+LZhnKjHKYwpyw76ED/ZwwwBbylpUxG
        nQc77jm0P8+vk7e5eoK8dAQ=
X-Google-Smtp-Source: AAOMgpeIVtTZA+mT+aPdWFfU9zc2245RLk54GIS7d+uaKw/yXEX5x//Jyx+PZDCn0T/1ei+w3BGXlA==
X-Received: by 2002:a1c:647:: with SMTP id 68-v6mr1074891wmg.82.1532079024714;
        Fri, 20 Jul 2018 02:30:24 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u4-v6sm2110620wrt.31.2018.07.20.02.30.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 02:30:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] repack -ad: prune the list of shallow commits
References: <pull.9.git.gitgitgadget@gmail.com>
        <b4e01a963fd16f50d12c1f67c6e64bec8b1e9673.1531513093.git.gitgitgadget@gmail.com>
        <20180713203140.GB17670@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1807142351100.75@tvgsbejvaqbjf.bet>
        <20180716173636.GA18636@sigill.intra.peff.net>
        <xmqqh8kxrfrf.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1807191840490.71@tvgsbejvaqbjf.bet>
        <xmqq7elrdk8x.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 20 Jul 2018 02:30:23 -0700
In-Reply-To: <xmqq7elrdk8x.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 19 Jul 2018 13:49:02 -0700")
Message-ID: <xmqqeffycl00.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sorry, but I do not think I can relay that as an explanation why it
> won't cause problems to a third person.

OK, ignore this. I was being stupid.

> The entries in shallow file says that history behind them may not
> exist in the repository due to its shallowness but history after
> them are supposed to be traversable (otherwise we have a repository
> corruption).  It is true that an entry that itself no longer exists
> in this repository should not be in shallow file, as the presence of
> that entry breaks that promise the file is making---that commit
> ought to exist and it is safe to traverse down to it, so keeping the
> entry in the file is absolutely a wrong thing to do.
>
> But that does not automatically mean that just simply removing it
> makes the resulting repository good, does it?  Wouldn't the solution
> for that corruption be to set a new entry to stop history traversal
> before reaching that (now-missing) commit?

The above is overly pessimistic and worried about an impossible
situation, I would think.  The reason why a commit that used to be
in the shallow file is being pruned during a "repack" is because it
has become unreachable.  By definition, no future history traversal
that wants to enumerate reachable commits needs to be stopped from
finding that commits that are older than this commit being pruned
are missing by having this in the shallow list.  If there is a ref
or a reflog entry from which such a problematic traversal starts at,
we wouldn't be pruing this commit in the first place, because the
commit has not become unreachable yet.

So a repository does not become corrupt by pruning the commit *and*
removing it from the shallow file at the same time.


