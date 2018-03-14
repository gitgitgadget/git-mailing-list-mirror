Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 809C91F404
	for <e@80x24.org>; Wed, 14 Mar 2018 22:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751302AbeCNWBj (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 18:01:39 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37072 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeCNWBi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 18:01:38 -0400
Received: by mail-wr0-f195.google.com with SMTP id z12so6310247wrg.4
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 15:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2YaOPhGJbOOz11oFb+485klz0PDd26UHcOZTpqR/xCg=;
        b=WiCUncJ+ob+S2cCHL7nz6M2MiOpBgtyD+z/aOjoqBlKCyKNfwsC7ZwLXO/JGNizhfp
         m/kWmzFLj3FFrwsT8fO4CKcWLwTSQ3m+BWlVWrXHPkopF3QAHyYxWhzdoU2tUM98aqqO
         hKURLjwsQpIo9aeQZgoCntL6JRM+lVVJjTu7qPcV2B5RSQ6yp4K1Z9sinqavUxk09IxM
         Hl09jtCzpXtmed5J9gL01wKmI1gijLcXZhl5zaglCeuh7Xn3oEFjqCRwr1I/2NmUiKkL
         G2u3tqUFP+44lx+x+ugMIBPwQyhpi+OjsWOhsvH/k5v7jCFNzJ1KR8rREieUCrUv9Cx8
         SEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2YaOPhGJbOOz11oFb+485klz0PDd26UHcOZTpqR/xCg=;
        b=Zd8nUZ3j1+BIkjHF3WexKwc6YmApW9WDBhgIzjBwLjqeaI9Hwn3nUbobqwVWXJZige
         w2VxdP4Zk39h2WVt+N9YNygoiwnhvBOA76aaqWktMOvAOMyM08iQ1dpPeGHdKjwthxao
         lytcyw393UKgoOgkhLdOY4rKhepvhiMaHThAq7uBiBG2mszxoRp2+uKmT6kww/iAD0uh
         gknrXXiEYWJ+Vzd1HmUfhpZ4wq+KGJM2JsUvQQjPahE0up/cw9Vj/zHA4rckOvCjtfxb
         QyIX3gD8+ue6iG9yPppcCjLD6Td+J9VvtAptXQ1aYwIrg0qHF1rF7KmFdXY3tp2cY9p0
         q5CA==
X-Gm-Message-State: AElRT7GikOLG/bizpc/aYplbGf0SPL3IH3U8gq25PZVd23dwMHyCr1BK
        riAp919COpi2V7cRJRkebA9Q2rs9
X-Google-Smtp-Source: AG47ELsMmtbFT8grDq9CQmz5w82F1iyWdyraqadKaMzGIf2nRDNft2V50/KMuWZhgQXkJVo6Lb6OeQ==
X-Received: by 10.223.136.248 with SMTP id g53mr4808612wrg.78.1521064897098;
        Wed, 14 Mar 2018 15:01:37 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 69sm2985230wmn.9.2018.03.14.15.01.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Mar 2018 15:01:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, jonathantanmy@google.com
Subject: Re: [PATCH v5 12/35] serve: introduce git-serve
References: <20180314183213.223440-1-bmwill@google.com>
        <20180314183213.223440-13-bmwill@google.com>
Date:   Wed, 14 Mar 2018 15:01:36 -0700
In-Reply-To: <20180314183213.223440-13-bmwill@google.com> (Brandon Williams's
        message of "Wed, 14 Mar 2018 11:31:49 -0700")
Message-ID: <xmqqsh92xqnz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Introduce git-serve, the base server for protocol version 2.
> ...
>  Documentation/Makefile                  |   1 +
>  Documentation/technical/protocol-v2.txt | 174 +++++++++++++++++

asciidoc: ERROR: protocol-v2.txt: line 20: only book doctypes can contain level 0 sections
asciidoc: ERROR: protocol-v2.txt: line 374: [blockdef-listing] missing closing delimiter
Makefile:368: recipe for target 'technical/protocol-v2.html' failed

I'll redo today's integration cycle to see if I can move this topic
to a late part of 'pu', so that I can at least keep the part of 'pu'
that is beyond what is in 'next' and still usable a bit larger.  The
bw/protocol-v2 topic has been merged immediately above the topics
that are already in 'next' for the past week or so, but I cannot
afford to leave the build broken for majority of merges of 'pu'.

