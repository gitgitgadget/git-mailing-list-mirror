Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64E991F453
	for <e@80x24.org>; Thu,  1 Nov 2018 05:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbeKAOah (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 10:30:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40356 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727355AbeKAOah (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 10:30:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id i17-v6so18781537wre.7
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 22:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=cWLW7kkQHdyi1T48Jv3E8UNXc5EkXaR7ZlUDrWCLWA8=;
        b=JPSBJsJUnUUOSiEBy7nzLOobBs6E4+5Yr5/j6AgJJzutHLEcR/MMloBtV8wcgyMBtO
         vU/NQDBz9ohO8eYi54dytTO49d7KBVs4mh2LGzhWdBTcAi52TX1jwpYw3GWs9yuJaUSw
         H1ShLnJ0hlx4brfni+CyocYLwmSzElQ2VW35G/Jg8YgDh9YpV0ddg5ASOzF1321ayEhJ
         LJv56W1RUtqZXRnqtn4V3YzuDikCpNouGSO54nejI8D+Z66MEu4CchxDr3aEpgfQwXyz
         SqVwd9G5/791kt6Zt+z+dXAmMi2uzqZPPPZJpOGnaRznYurgwYJhOczusJF/h8eDD+pa
         JbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=cWLW7kkQHdyi1T48Jv3E8UNXc5EkXaR7ZlUDrWCLWA8=;
        b=EVVmEwbdoOabEe/fIPY584pjnGLqd3k63qhp4+K1jA10vYrZDJWJVjbWLpqDO5c01o
         KgdpYw+rYYBJ7LjR1mJ3KDr77cL1QZn9mV8KZJBImU/q5FFBlUFrb6GLJqhp4ZfJDq6Q
         5S1CdbLzhY9C/2XCofwbLViwo1VuZKqIizaBbzawQiqAJg3ZYzxtqLJRvt9Y2YzIea91
         eZYUSe4HH86nLnV9YepWAAoxRnBLws613mtdL4dWrs8iRI6CnD0MPdH7vwmY+5twXc+L
         6uDp2l1z3b0msDT+U9kEUbenSp9NmV5X8+a7KdhPIWOEIXrq4tH7AFn1RuFM+2jCm3wx
         hsgg==
X-Gm-Message-State: AGRZ1gJsPU0IF95NJvPn8oEtePJVZUOGyqgDLoSJQspyAP+Q2138Iqub
        csDHM8rjwa9ymqJBC3+bo5S77Xy9vnM=
X-Google-Smtp-Source: AJdET5dZKrFoV8WRqlX0+Z9PgnefXcy2ABJJs5069pqaRtUJftx6ndiQ93pRXIs/DTWl2sAHXg4qHg==
X-Received: by 2002:adf:f181:: with SMTP id h1-v6mr5587234wro.79.1541050149869;
        Wed, 31 Oct 2018 22:29:09 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 65-v6sm1756219wmj.1.2018.10.31.22.29.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 22:29:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org,
        stolee@gmail.com, avarab@gmail.com, pclouds@gmail.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v4 10/12] Add a base implementation of SHA-256 support
References: <20181025024005.154208-1-sandals@crustytoothpaste.net>
        <20181025024005.154208-11-sandals@crustytoothpaste.net>
        <CAPUEspjCjFiwCO8TCM23f2jqFSpy2z05+Ea_zGATy0jh1L83iQ@mail.gmail.com>
        <20181028155206.GI6119@genre.crustytoothpaste.net>
        <xmqqftwpa8my.fsf@gitster-ct.c.googlers.com>
        <20181031225521.GA573515@genre.crustytoothpaste.net>
Date:   Thu, 01 Nov 2018 14:29:06 +0900
In-Reply-To: <20181031225521.GA573515@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Wed, 31 Oct 2018 22:55:21 +0000")
Message-ID: <xmqqlg6dtlgd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I need to do a reroll to address some other issues people brought up, so
> I can remove this line.

OK.  I actually do not feel too strongly about this one, by the way.
