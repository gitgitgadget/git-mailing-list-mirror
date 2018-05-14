Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A3FA1F406
	for <e@80x24.org>; Mon, 14 May 2018 01:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751992AbeENBvT (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 21:51:19 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40714 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751804AbeENBvS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 21:51:18 -0400
Received: by mail-wr0-f196.google.com with SMTP id v60-v6so10526293wrc.7
        for <git@vger.kernel.org>; Sun, 13 May 2018 18:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2Z+xiBAOT/XTnbjY10Mw1Yg3zngu01cSKLeYytsevuw=;
        b=tIW6kzSJbmUqzEUpMVbnFUa3RWuMPkhZNDTGgqbm3/vu3Clu4Ksj2MwzN3aNRzEq2f
         oOCgkDmI9s28bG/4Rr652W3celIlpOLhvs4aCOvl1OrgdJseoFQUZIJuDFHC8Ux7r7ew
         S15LBrcoHNkbA6GQSE83v2UCU7hUAVSGcsPR8KO2K2ToVCp4GbaTZ5VfloOQ6KGXGn2w
         GOziPxsBeMOWgmEW4Iv2NCCgixHGurACxIAqtfvjDV1vArIE3Epiuy3WQKevc+BbIA/U
         81pbQGyeSTiLfjM+Ntosz6VPLIOQJUqMEJhhZoMu4ruY/R6jhV3bNrwQmmyDth+aw4LS
         Lztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2Z+xiBAOT/XTnbjY10Mw1Yg3zngu01cSKLeYytsevuw=;
        b=A2bwH2yUaB5PS+v3gWSFln4GAmol5wJ3VFjC+LxUgg9z0KjRGFaiy8F+FTfZF5XofH
         E+9ogGjdNGsvN61CNUKbmDIBEksHCYubBXN8aZH2OEyp3oarHOmvFgE8ul5l2tmJyjIq
         wqR0n44nJws5YKoQarMgE9OZBBQBckz1k8QoZvXIJEyT91UEzRm7bvNBXiwUlmQvUHIc
         5KjQ+3zB0J1sgTxfy+ipyE/lZC8Nltku3DCykcDiHdQGIfnL3WV9MWPXthjNvkFVYYl1
         fSlySXH/Jxdr26knoQ9a/iMOLjUFw5bodd1JkR44VkTbKikxeWmLDROPgiZY5kK+Yf3O
         +gCg==
X-Gm-Message-State: ALKqPwdcvjMUR3ohhxsHD4yWOUFcpdcONahK2SsLWrBJVC7uMwQHAaVj
        rBIu4oE2KhfNri2MJ2q3t+g=
X-Google-Smtp-Source: AB8JxZr1jop/OWBx9XimHdzNKT+yN2mi7lrHJWjkq0XhabkrjF7FWg5ZMl/K0Gwky3UC1YrSA24AMA==
X-Received: by 2002:adf:9b98:: with SMTP id d24-v6mr5931312wrc.240.1526262676809;
        Sun, 13 May 2018 18:51:16 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 12-v6sm11028344wmn.27.2018.05.13.18.51.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 13 May 2018 18:51:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Dannier Castro L <danniercl@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH 1/3] checkout.c: add strict usage of -- before file_path
References: <1526178214-30956-1-git-send-email-danniercl@gmail.com>
        <CACsJy8DZ1QvjO+JdbB76TOLtB2wp4Ya+CgsTyD1oz2Y+ZdKdYQ@mail.gmail.com>
Date:   Mon, 14 May 2018 10:51:15 +0900
In-Reply-To: <CACsJy8DZ1QvjO+JdbB76TOLtB2wp4Ya+CgsTyD1oz2Y+ZdKdYQ@mail.gmail.com>
        (Duy Nguyen's message of "Sun, 13 May 2018 08:03:24 +0200")
Message-ID: <xmqqsh6vc8do.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>
> I would like an option to revert back to current behavior. I'm not a
> new user. I know what I'm doing. Please don't make me type more.

I can guarantee that nobody will stay a newbie.  They either become
more proficient and aware of what they are doing without having to
think, at which point they start feeling the same way as you are.
Or they leave the Git ecosystem and move to better things ;-)

> And '--" is not completely useless. If you have <file> and <branch>
> with the same name, you have to give "--" to to tell git what the
> first argument means.

Correct.

We _could_ do better than the corrent code, though, when we happen
to have a file called 'master'.  "git checkout master master" cannot
mean anything other than "I want to make the index and the working
tree copies of 'master' file to match what is recorded on the master
branch", but I think we do require "git checkout master -- master"
disambiguation.

