Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05A011F453
	for <e@80x24.org>; Tue, 12 Feb 2019 02:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfBLCii (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 21:38:38 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33307 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbfBLCii (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 21:38:38 -0500
Received: by mail-wr1-f68.google.com with SMTP id i12so1000873wrw.0
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 18:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=papzx1sz+9EIprodIMSMWGc6E5k3SCeCbffNAdGpuc8=;
        b=Gcec1Rg5kBKJgWFARytg6uLeNMWW6qa0M87yV1XY+gkHHwSFVoMk0YdpmIWHKkaDSP
         uQQDxnn5Lr8CsmVLJFkvRWvzkqSV9HdbFxPCQ5OYoLigYukMe9X9+nAYbNvo1GDqOa1f
         y33iTIVq/mf1++LnMdP+flRA4BYOn6hu6AjfopJtaY21E0bsyiNQXIGyyoZuqkBUAlNp
         DM3Id5gTSjsnSgLdRU3VaLMINKTDYYoP8IqiIDVRob6zCH5cZ59+H1sSLwKv7MC6JMnq
         OXrojlUyEXsOUlw6pPO4iYXuEZ8X7UPwv1yWj2+lab2gZeaHBM+q3nneebYz/Ynyiw2v
         vFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=papzx1sz+9EIprodIMSMWGc6E5k3SCeCbffNAdGpuc8=;
        b=bW1wtW+mWH2FtzKNiPADr+F2xiRKRqfPQKmsOETbQnTnust7pzVqR8zijxNQjGmAik
         yQKIAc2rzoISEJWdbvpa+xm+Wz8J8yhxg1jsq10fbrzlaZh8oIsv7tW2ghVVJbF4vClh
         O5cC+Mb9QYXmPM6cvMo5lpbLdcCvHH1WLl3s0uflLas3H7Ym2MPK2+3SdTl5eGhd9oZ6
         sQFToyGxVjdEcOrSqd5LSQ/VCntz2Hdx6KmpiWk2nd1QRJ/oF4N0Y3y2WdVHTuQc8BlS
         koo1WsWyY8kJ9sVkqp13UHnyJvRkIeSW02LcsPrAego+Wnygq2sPwxtGvg2FaIn7CQM/
         WaCw==
X-Gm-Message-State: AHQUAubDu5wCPZeNEL3p3qqVqQtysnL4Gxyk86tZpvqlY/5xavrh4KXd
        JfzA/EQWLpqcQmG4Ki5VefA=
X-Google-Smtp-Source: AHgI3Ibnlg/dWg8ALCp6C0BbAtLcKPCFR8y6Oqrj1qkoP6dH8508fwCJdSbvxxG1U0pVR7WmY4tsRw==
X-Received: by 2002:a5d:5285:: with SMTP id c5mr831930wrv.167.1549939116014;
        Mon, 11 Feb 2019 18:38:36 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u75sm1420117wmu.15.2019.02.11.18.38.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 18:38:34 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org,
        Henning Schild <henning.schild@siemens.com>
Subject: Re: [PATCH 0/2] t/lib-gpg: a gpgsm fix, a minor improvement, and a question
References: <20190208031746.22683-1-tmz@pobox.com>
        <20190209140605.GE10587@szeder.dev>
        <20190212004433.GJ13301@sigill.intra.peff.net>
Date:   Mon, 11 Feb 2019 18:38:33 -0800
In-Reply-To: <20190212004433.GJ13301@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 11 Feb 2019 19:44:33 -0500")
Message-ID: <xmqqlg2lg28m.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> But it looks from the output like it just mentions every prereq that
> wasn't satisfied. I don't think that's particularly useful to show for
> all users, since most of them are platform things that cannot be changed
> (and you'd never get the list to zero, since some of them are mutually
> exclusive).

The only thing that could be of interest is "We are skipping tests
around $SVN, because your Git was built without a feature that
requires platform support of feature $SVN, which in turn was caused
because NO_$SVN=UnfortunatelyYes was in your config.mak.autogen
file.  You could 'apt-get install $SVN' to lift this artificial
limitation in your Git if you wanted to".

But the test prereq is probably a bit too roundabout way for that
kind of information ;-)
