Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53FE81F453
	for <e@80x24.org>; Fri, 19 Oct 2018 02:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbeJSKfp (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 06:35:45 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34739 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbeJSKfo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 06:35:44 -0400
Received: by mail-wm1-f68.google.com with SMTP id z25-v6so3062793wmf.1
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 19:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UcCHYTsm2RSTvnyNiGNKFOflL+1ECaMgGEDvjovkGfk=;
        b=UVc7oPJzIDZ6XUYDHAZg2aoy2tm4qEp1NIk4bAeeDEBaHnbvZfd0bWYK+KbarLwck3
         7JjwlyBGtnaMlTdcdCNWDCNlISLnusoEGtcW9sQVjLM2ltEGR0y8tI34PdWlIlMGDRU9
         Ve+lwO41MP52ggXzziqDMwCrMLKkq49SVBqkFNZAktPdpdP3dZu0CA29CqM3+m1/HijV
         3Tx6ZXbDP/YNWrIxM2hYJx8n2+3/4Lszold93Aj8TJa+zONQ41eFVOPqq5kcd03KNAgg
         0vXDVFy8yDsAGp4sD/R6pyDKM8qszdbWldLXW/3EGkmhkMEOmPBNMEuoeLPP/EQD1sg9
         0KvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=UcCHYTsm2RSTvnyNiGNKFOflL+1ECaMgGEDvjovkGfk=;
        b=sZmvbxNorpummBW3yLUz4LBVMZyxiOAV31l7vbmsdYLHbUVd4UUYhdI2noQ4YJLN3r
         UrVlg/3J9fL6DtJeipqkpV78uKaVy1RAwCxYFV9/HnyX2bPpdYDEH0kiE3Cl+oAnP2uF
         YNxn/SeNbrU0mR+gXqUEyX+88Fgx1V5O/mrNNQpe4pz3JQCDnFXDZ/T/Ba9ophU3S5IV
         WV0oI9NATBdA1u7H5i9KDbFoczSf3Cl4I1+C54stpfwoiqwhe2iJqpCkM9MiNpo3TKTA
         tctWDRFLmLCjOXY1AjFFoF/6zLW+6kYWQqrfU29tWo2I5//CLuNe0da5K8S1GpqDTMlu
         dqYQ==
X-Gm-Message-State: ABuFfoi/6NxRpqRQHdLYqi78YgS6Q3UGMQ30Fb2PsaLa7rLY91QQGBN5
        /Pq56CBwu1vWJDcuBqOZW0JoG8ilB+0=
X-Google-Smtp-Source: ACcGV61+zJTh0l3EmWiNW+sE92wewHSteDT7P8LNTM5wKS0t4QbMQeyORbKFy/RkKZGURwXVYbEfkQ==
X-Received: by 2002:a1c:771a:: with SMTP id t26-v6mr2614024wmi.126.1539916304751;
        Thu, 18 Oct 2018 19:31:44 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 126-v6sm1215393wme.48.2018.10.18.19.31.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 19:31:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] commit-reach: fix first-parent heuristic
References: <pull.51.git.gitgitgadget@gmail.com>
Date:   Fri, 19 Oct 2018 11:31:43 +0900
In-Reply-To: <pull.51.git.gitgitgadget@gmail.com> (Derrick Stolee via
        GitGitGadget's message of "Thu, 18 Oct 2018 10:24:38 -0700 (PDT)")
Message-ID: <xmqqk1me3bw0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> I originally reported this fix [1] after playing around with the trace2
> series for measuring performance. Since trace2 isn't merging quickly, I
> pulled the performance fix patch out and am sending it on its own. The only
> difference here is that we don't have the tracing to verify the performance
> fix in the test script.

Thanks for sending this separately.  What's the current status of
the tracing patch series, by the way?
