Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 014F11F803
	for <e@80x24.org>; Mon,  7 Jan 2019 17:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfAGRAe (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 12:00:34 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35015 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfAGRAe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 12:00:34 -0500
Received: by mail-wr1-f67.google.com with SMTP id 96so1195712wrb.2
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 09:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QYg21opHye26YSUMmeBrbVYjsZ9gJmXzd250trd8zVE=;
        b=igUc+yMKrLqMBwmYSSgU5kPBmqMV4fILhwP/B3XFV94Du9GqOnDIqOGQ3VsIOnWkVS
         RjS5/YOTqSLgu5egEj15vKsO7zN2uWtr0R6PGlgROQ3jnMmhm9xSKDcNwjeGNGHcHc3b
         gL16zeGu6pKF3aA9CjGGRpRxxgDSW9Ak2+alulaoyHmChi4jyR/OWDqESTujfad38/cZ
         kk7so5JQQDvdOa+rnIyQZ5znIARwdqOTlv0ZBEwKumzUQiV5ILq697AMbBlK8uuWpTCB
         CA0fmLZBqlrij1L5Y6ZsPQWjRvUmSpz/JCyfgyPeY5oYwzXMWYy267GKTxh6nTZ8B6oH
         +vIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QYg21opHye26YSUMmeBrbVYjsZ9gJmXzd250trd8zVE=;
        b=M+Dj3MRAe2MHHv/wWfQLPQFLTqjYMoWrf9o9YrUdjhteiNEs2XX3Bkw02xpmdNBGaf
         AVufC3/IPPy66HZVMYOqDRmfEVx3VQokY4P4BNFuPE4l6s2VJICpZ9jYHTlD7QDGtflt
         pR7NJxMs4+5wqlmteEdZTxNFi/3AA82HplxPUpdjH2S4Gl7MZVEJsPCeeeqi8rxh4Xvc
         oNZO+oIHYdsWpsyELxylK4pl2wx2u4Y8zNdA3QCw0P/97BWRiPyFzRPF8yacyi6EKmiM
         rK9VmtUpJTSasijkokwqpe6Y7jV3aOPVA5CtJRXX8GjXewyVKYowUO2nWuUOoTEr+dM3
         P2zg==
X-Gm-Message-State: AJcUukfJ7qmOfUP0R440d8GVHaXDFr2RrvPI/U4NM5cGHp6QBwwh9txV
        YiFyVD0KNwV0uuRUEKuPHPs=
X-Google-Smtp-Source: ALg8bN44W2fEAKuvr/ojQ6+vF1H2OhTQfOaqutbXj+BLdoHrM9NTioMW66cbLmyzLGrS0BGyfWBoyA==
X-Received: by 2002:adf:b3c3:: with SMTP id x3mr52451809wrd.294.1546880432578;
        Mon, 07 Jan 2019 09:00:32 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j33sm78024478wre.91.2019.01.07.09.00.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 09:00:31 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 8/8] checkout: introduce checkout.overlayMode config
References: <20181209200449.16342-1-t.gummerer@gmail.com>
        <20181220134820.21810-1-t.gummerer@gmail.com>
        <20181220134820.21810-9-t.gummerer@gmail.com>
        <xmqqo98yiq8i.fsf@gitster-ct.c.googlers.com>
        <20190106183225.GH25639@hank.intra.tgummerer.com>
Date:   Mon, 07 Jan 2019 09:00:31 -0800
In-Reply-To: <20190106183225.GH25639@hank.intra.tgummerer.com> (Thomas
        Gummerer's message of "Sun, 6 Jan 2019 18:32:25 +0000")
Message-ID: <xmqqy37w9zdc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Maybe it would be enough to say "... `git checkout` never removes
> files, that are not in the tree being checked out, from the index or
> the working tree"?  It is more technically correct, but dunno making
> the sentence harder to read is worth it.

Yeah, I share the same feeling.  Let's say the text in the posted
patch is good enough and move on.

Thanks.
