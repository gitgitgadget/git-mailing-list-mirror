Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_BL_SPAMCOP_NET,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36DFE1F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 21:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932709AbeGFVz6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 17:55:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44261 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932671AbeGFVz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 17:55:57 -0400
Received: by mail-wr1-f68.google.com with SMTP id r16-v6so5419687wrt.11
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 14:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=DPsUtfTXzrs9PiyuoPTRsnLsXD0xx/bvCFwYgADA93Y=;
        b=ZdR9XZwxtpjGFbJ5Qp+nGV8eXsIfDdFhjRK4vLS0GkPaw4eLyavAm1vRdWrpR4HO6s
         /mr3zC4YIUJO+jLk/TG0GGs6i5Pf9n0AQI7hylGOkUW+JICoM+xVsWKBdq0983cjZh/9
         qennn4abd91dVAsXQIh6NjG3riQRL7Km2G808bJnRd2vahLWn2jW0DujMm3b4PEyBKim
         EYLLSnO2v3G/JtIx1peby+AY32oFRYtfol37tMs8XHHCZGbalNLPzZ9f7qcAD7Qg72DJ
         PNRkxra8yn7PUqc/op6vSzJ6H56OSY4hgQLuP/7fEl5AVNCz1C87KO+NnovBNXB99dIc
         52Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=DPsUtfTXzrs9PiyuoPTRsnLsXD0xx/bvCFwYgADA93Y=;
        b=AN4mlENW+s4xoRRjp6a3sUTe1kAyfGNp2Pv9uHKanfnXCaJZvofT0V9IpVOC55neqd
         XLpqAIq5B7QyMHhlNbtV40Ju/Nt+iHUiRDBxkTyuiLH8g5Kgqw5S3e2AjP2V38OHShVs
         5GNf7t6VbMMf4IvltAolIpIRxOy9fZIdeVJaBqGgVTHhGxc+xgAdgUEhcB4Sm5psncQG
         UHm1r1ADCQsbEy0sVoslAW+K7sCNPgmbrhPKBw7abUw4lXIfrAqrCzCBfacGg/mMuvok
         QWDcvttfRh5ittvfLjD6UgDEMUGX+JuPnEY0hQN0EyC9HVFQOdA4sC9G+NvGzjXwKP60
         NoIA==
X-Gm-Message-State: APt69E2lXPicemdve8FH54fkgUORWASZOVTbZJNyJy3irLG8sMnASCRT
        9o4hrM9mY6UVGa0yBbBTiZs=
X-Google-Smtp-Source: AAOMgpdPNZrKbXELG5IhTZtlvcVTYJdHYP/fZMpErbbhJUZL220fugItX5A1jarF+h1BCjbj45g5JQ==
X-Received: by 2002:adf:ad45:: with SMTP id p63-v6mr8249102wrc.222.1530914155980;
        Fri, 06 Jul 2018 14:55:55 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t10-v6sm11002887wre.95.2018.07.06.14.55.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 14:55:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v2 6/7] rebase -i: rewrite setup_reflog_action() in C
References: <20180702105717.26386-1-alban.gruin@gmail.com>
        <20180702105717.26386-7-alban.gruin@gmail.com>
        <xmqq8t6soy2f.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1807061457250.75@tvgsbejvaqbjf.bet>
        <xmqqy3eommq2.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1807062052230.75@tvgsbejvaqbjf.bet>
Date:   Fri, 06 Jul 2018 14:55:54 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1807062052230.75@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 6 Jul 2018 20:54:35 +0200 (DST)")
Message-ID: <xmqq7em8hvv9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> You recently also suggested this if...else... dance to Pratik, where it
> was not at all about doing the same thing slightly differently, but rather
> two different things: 1) return an error because execvp() returned an
> error, 2) indicate a serious bug (and you did not even suggest using BUG()
> IIRC which is also wrong).

I was going to avoid wasting time on this topic, but I happened to
have a chance to review the execvp() thing.  

I actually think that is a good example of doing the same thing
slightly differently.  We want to abort the process when execvp()
gives control back to that caller, and we want to do so with
die_errno() when we know we have errno (i.e. sane_execvp() gave us
negative).  When sane_execvp() gave control back to us with
non-negative return, we cannot use die_errno(), but we would want to
abort the process regardless, as it is an indication that the callee
is not sane after all ;-)  It is a bug in underlying execvp() that
we cannot do much about, though.


