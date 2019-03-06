Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC21020248
	for <e@80x24.org>; Wed,  6 Mar 2019 00:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbfCFAI7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 19:08:59 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36523 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbfCFAI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 19:08:59 -0500
Received: by mail-wm1-f67.google.com with SMTP id j125so4240312wmj.1
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 16:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0qcgx62WWCKsyonWnZSmwoVI30qcasDFuxa0yglboq4=;
        b=uj+E3GfmN0bdVvIcKfQUK11WwmkMFm2nYeQV1O8ODSCEW96n4+Py28J/WuaQ7WK/q/
         l0k2bQOfsMoex6R52stTJinbBzhBR1093jW1Wk1YApecxv1Ib1aKB+5u2MSMN9xo47CD
         VhrqJl7XsdnLGNvk/3V8cRtFTmvUxfwnPf0WcFzpE/OTU5bUMxC70gYQdzrsEmPht/s+
         gCAI4ALFRye2uj7i9cCy/wqN+qEl+ww5kisAwJya7nuYfvcPASaTG5Nm3GLWnXLEy4ga
         nmeQVPA1gifoTBOkcumfUnCUqN1Yjde2ORzQq+U1ehBIyyPpLId6KrnYDgQv//4uvFYg
         Pdkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0qcgx62WWCKsyonWnZSmwoVI30qcasDFuxa0yglboq4=;
        b=Rccl9QwpqmvPuPvCRvHljdTH/QHoq6y+g8waUVD/U38usHcVr50pZCbZxRP8Zn+Cwv
         oHdLJI6fx65euhSVYsUHEcli3+sQ9x8OAA7fyxECxTEvuH79Rl+8dEk6u7ayfBC9Tm34
         T1WSWLUq+J8Ft8e7oFJQfApzO9RSdtmUr5VTkmKDjyGqBrD1gmFMdNORq6mSGVeyL0oq
         Dail7iFf7BfB0m4YCGVlzzYSPEmfJwRqE8/BfonGHjU26MhyTSvTthc9B23SVkGE76YF
         rP60wArm0cSfj1opP/b4C5QJ5dk5iIogbcK2iJBYz05ynZQIS6CViC3FL0HwF1+/Nuns
         K0gQ==
X-Gm-Message-State: APjAAAXRsYTKaAAA/o0fHiSbHNN3oD9T67JDPOvUALDdWJDj2oT8sf30
        2dMagBHEbhJ0j+e7AVWLceA=
X-Google-Smtp-Source: APXvYqwJcz83wsCv7inte9cSAeHhhfm9km5o88dFmNATInPL5c68cY4U8KDrSyEbrriIe46v2URk4A==
X-Received: by 2002:a1c:a817:: with SMTP id r23mr584429wme.110.1551830937277;
        Tue, 05 Mar 2019 16:08:57 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p16sm11802695wro.25.2019.03.05.16.08.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 16:08:55 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: is it "git gc --prune=now" or "git gc --prune=all"?
References: <alpine.LFD.2.21.1903020323110.16672@localhost.localdomain>
        <20190305050326.GK19800@sigill.intra.peff.net>
Date:   Wed, 06 Mar 2019 09:08:55 +0900
In-Reply-To: <20190305050326.GK19800@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 5 Mar 2019 00:03:27 -0500")
Message-ID: <xmqqef7ksw2w.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ... I do think the documentation
> should recommend "now". Possibly builtin/gc.c should be smarter about
> recognizing "all" in the conditional you quoted, too, though I don't
> know that it's all that important (especially if we tweak the
> documentation).

Yup, as the placeholder for the value is labeled as "<date>", "now"
would be the one we should be encouraging.

Thanks.
