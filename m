Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0C601F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 22:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754377AbcJKW6S (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 18:58:18 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:33296 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754263AbcJKW6R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 18:58:17 -0400
Received: by mail-qk0-f169.google.com with SMTP id n189so10406890qke.0
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 15:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7aN0DS9fOvY+0ui03Zo4YhqregdN6sXcjnx/AmodZ5w=;
        b=W2tL2Exy5aOn739/gGcKmhViYpvYFjRID92/dGds4YuiO1bhUaqA/fS4Vqlo1GLUTy
         f51c6wtPd1o0VQFoZwuZ+Oe6aRkfpm5hvSHwbbcqcMAZE/SP93f/LhF7mPtgDn9fNipv
         TOqEtruLOXAe+mKFksWY2C1U0/b1QYKq7P4iqi7gKTsY72ni9lxjtNfUGAyW5bemx0pz
         aSsbG6bza6KcbyalYw/ahD1gG0txLUvstXRgYP0wJfbflgTooW1p4+ylOrTWGHdxuYPw
         Z+SDWUnc/DHte5PG3L6S7ReiFkVNJsnXM8aPYSQk25gmz6i/ji8Zb+YLU65x0DJq2fD2
         lLZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7aN0DS9fOvY+0ui03Zo4YhqregdN6sXcjnx/AmodZ5w=;
        b=c3SWftIpeykFjYu62fb9LFtXgmczwiURIIBPXBgo8ZSajduu1+Kgld8NYec9uCQSL4
         YhNYm1hTuHA6HcurbxYZ+krprXjWXhNjugAh6T4RFYv+Bfabgt+c5IKkttOOjbVdaz6L
         PUIVZ96wFKf7xo0sVgplXlf/UDMWtYk+KvrTFi7VBAUh9eAYa2MnyeSwPIxTbn7P52SJ
         hjG5RwYFGsDlm/iMDTfl+MzIBqubh0cUEbS77Gfq+9LXs9aKSvXyYUlIiZHteLQ3Qccd
         5VU34zuxLT+RNZm1rVJp37JSMdhe/ubbwAkZvch0uS+qZmGFe0AjXqmOUwpDs8DFziMS
         fEpA==
X-Gm-Message-State: AA6/9Rm8v3EUWQK/+ZBCsacekg3tpZko5HDKNTCMv/w6v8+mG72lIwJOqjPIUsIxM2O9qhIiidMmSlVD/g8h/Cbm
X-Received: by 10.55.45.193 with SMTP id t184mr5311647qkh.58.1476226696911;
 Tue, 11 Oct 2016 15:58:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Tue, 11 Oct 2016 15:58:16 -0700 (PDT)
In-Reply-To: <CAGZ79kZNvTvk4uZa8xhxZABKtzS9A5HoumJ37AacuZnHaZ4+Xw@mail.gmail.com>
References: <CANXboVZvfPkTQ10PWop+LgPFpc2bD3-u-e5ix0itGawiwCxOuQ@mail.gmail.com>
 <CAGZ79kZmrYZqi4+bSkRykn+Upt7bEyZ0N8VhiQ-h8DhSMym-FA@mail.gmail.com>
 <xmqqa8ea7bsh.fsf@gitster.mtv.corp.google.com> <CAGZ79kZNvTvk4uZa8xhxZABKtzS9A5HoumJ37AacuZnHaZ4+Xw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 11 Oct 2016 15:58:16 -0700
Message-ID: <CAGZ79kb_-k2B=+3dFw=AUS=mWafKObAiGDMShfekmW=37hSYJA@mail.gmail.com>
Subject: Re: Make `git fetch --all` parallel?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ram Rachum <ram@rachum.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I dunno, if documented though.

http://stackoverflow.com/questions/26373995/how-to-control-the-order-of-fetching-when-fetching-all-remotes-by-git-fetch-al

We do not give promises about the order of --all (checked with our
documentation as well), however there seems to be a
grouping scheme for remotes that you can order via
setting remotes.default (which is not documented in man git config,
but only in the git remote man page)
