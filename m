Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 838A71F516
	for <e@80x24.org>; Fri, 29 Jun 2018 18:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965363AbeF2SXX (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 14:23:23 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36093 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934686AbeF2SXW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 14:23:22 -0400
Received: by mail-wr0-f196.google.com with SMTP id f16-v6so9676346wrm.3
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 11:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wcOOsDgAmn7pW5majn3HTdJo7fgpAbh9cq3XQwHEgKs=;
        b=H7WdMZMuloba+hHpl7GIYMeIknNYz+TjWwRRZ/+GotEC/4/oxozzkgpNi0J6aeR4uE
         +MPoeWAkxvWDBVcyaUs1RMO8Rj4MhYShkq4zOrPMjV3HEpa3UVex3l9yTVNtO6yeEVzr
         GWzETnyRFDU1GxdYJyJ5UAD23aibfHyRH6zOyp/9Q8LJ5V3jPhrDBe7xAmmzMyAjZQws
         MwuvSVCDkRBJJIM5fJrxcnGuaRcUbN4PyjLExdw+6DipI+OPru1d8YAaex2iASqmCwuY
         sMMn1ldgNApAl2ODbZeclR6jV+4SVF/HBNkToVrqANpGFA+FDJBo1Q3s378cTPNz3e0Y
         LykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=wcOOsDgAmn7pW5majn3HTdJo7fgpAbh9cq3XQwHEgKs=;
        b=uYAUFx/G0urgapz1ihCFuJ4LF88WYAc8jUP/DCvk+gQ+mlc3iGBzpB5/RwPHO12caD
         W/IlD4rtH3xg/p+Gxtzp5nCs7OKqM3nyCQJScsyanhQWjLWMV6AzKbErdtUcY1oW2/V2
         rFBzQqiTgB9/F9xgaCwPwNgrv7Tw65o8YlJjPo/nwW77tzjbHNDiM0bRrmBw0P8c+m0V
         ts+tcJOQR0N07II6KKTYH1XJeiVCzLgv+g8Q494SXr0gcYjj5FJFtygMD2Fy1H0d/LF3
         1UrmdOM/bY6alY66s8+Rfu7QsgM/kxSNWeJgl1WVkUI/Q1Xn3zh3cvC3AK1faaq4jlay
         PTag==
X-Gm-Message-State: APt69E0BpJFqNMB1Toa+oPZPfCUg4LKvnh8m6VcsYSijmmjWG9AIYO3V
        fcD5IAXlUqSK9TawzgNuzov6HmRR
X-Google-Smtp-Source: AAOMgpc9dEq8xUO9zBJDaiDFuz7YrkMdBTmqQtCEU4DRDuVyfBywfXTeIA9uuZzexuK9aew+E87D6g==
X-Received: by 2002:adf:fc8c:: with SMTP id g12-v6mr12892590wrr.216.1530296601229;
        Fri, 29 Jun 2018 11:23:21 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c128-v6sm149922wma.17.2018.06.29.11.23.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 11:23:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v5 0/3] rebase -i: rewrite reflog operations in C
References: <20180625134419.18435-1-alban.gruin@gmail.com>
        <20180629151435.31868-1-alban.gruin@gmail.com>
        <xmqqr2kpv8ft.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 29 Jun 2018 11:23:19 -0700
In-Reply-To: <xmqqr2kpv8ft.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 29 Jun 2018 09:55:34 -0700")
Message-ID: <xmqqzhzdtpt4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Let's aggregate these topics into a single topic, and perhaps call
> it ag/rebase-i-in-c or something like that.  Pretending as if they
> are separately replaceable does not make much sense, as you are not
> rerolling the earlier one and keep going forward with producing more
> parts that depends on the parts that have been submitted earlier.

So here is what I tentatively did.

    $ git log --oneline --reverse master..ag/rebase-i-in-c
    4d303fb608 rebase--interactive: rewrite append_todo_help() in C
    b4ffe143a9 editor: add a function to launch the sequence editor
    4ebe39cef9 rebase--interactive: rewrite the edit-todo functionality in C
    0ff6bf7646 sequencer: add a new function to silence a command, except if it fails.
    36784b351f rebase -i: rewrite setup_reflog_action() in C
    415cac57ee rebase -i: rewrite checkout_onto() in C

In several hours please fetch from me and look for "Merge branch
'ag/rebase-i-in-c' to pu" to see how they exactly look like; some of
the patches might not be the latest ones, in which case you may need
to prod me to get them replaced (resending them as a whole with
incremented v$n header is probably the easiest if we need to do so).

Thanks.
