Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE32120248
	for <e@80x24.org>; Tue, 12 Mar 2019 07:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfCLHRc (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 03:17:32 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50337 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfCLHRc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 03:17:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id x7so1444555wmj.0
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 00:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Ja94JDH0cqF1pP3PJUHn9v5umLZT6VZPaCaz7C1A++8=;
        b=ccgyVZgdlzzPvjyyVoypKyaqTv/RDmGULOuHUHXs8So/VheURAiAl5rDQfKnse7Wjc
         +MozC9pJpScq2CpPU1JbLKW8QkecRB8/dj/s6hJUci1JSXRvGpg+96yDPVtXCCpbWOI+
         ZFyjvkpmMtziXR2nMgBx9YGyoj+W97Qoh6uJE48wEnpCUG4Ta5Y+oqPNmH9QeLb37C7E
         DnmVzd2Kg14+qLQgUlt8HVEk/WEX2lnzPjAw7UzBnytPdgkRe4JsRAkkY5/S3f+l9b/p
         FhHLX1jJDnFakv5P1/40wFFVHeFzEZ2isXZPRcciBVfv4MgdzpHhuOhR+HTLgZgkiAvy
         qhmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Ja94JDH0cqF1pP3PJUHn9v5umLZT6VZPaCaz7C1A++8=;
        b=pPHwtynORQNHx0JX/HSZ46F0bWKJhgtyQk4ETgDNPgOPCqHmWbfDCx5wES6iQPoZKo
         wgv/BINk3HcNwC5sOcsUoOL2wcI383Og7VGtHr5xNvhNWXnWPam3xH9XQt+fdY9eFNiI
         r3vxuaVJbD9PenoM19vsisxRXRY/181eqLtt2O5v34tA2q3qKR47JzQzz8oYf6nkiJX/
         Pa5WVySDOkajWDHbUW6BdPtZyJZ6DzanhZ2P9i9kEFMOLQ+WopF/5JRkIhsVY62CViNj
         pQgdnMw24kxlnLaqd6o9/JuugxdhqrAafhsIsTupF5ddeUZY1yC/kd0mx3p7LbifwGzw
         pp+A==
X-Gm-Message-State: APjAAAUA7hdhys1drsKV+qSstRrldnEnaNskYZ3O+wyzz765jqbTzrE8
        bidWA+Y4uMGrZBwHfFHu4i4=
X-Google-Smtp-Source: APXvYqz3rIfYUQvUKiCeddf2L35S6xqp2iXEyMzQqRmgCzBfmGZXTUnc5HnReZRozEGgGbAh4Paezg==
X-Received: by 2002:a7b:c344:: with SMTP id l4mr1206122wmj.121.1552375050022;
        Tue, 12 Mar 2019 00:17:30 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id l5sm1794732wmi.24.2019.03.12.00.17.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 00:17:29 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.org>,
        Elijah Newren <newren@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        vincent.guittot@linaro.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Deprecating git diff ..; dealing with other ranges
References: <20190311093751.GA31092@archbookpro.localdomain>
Date:   Tue, 12 Mar 2019 16:17:28 +0900
In-Reply-To: <20190311093751.GA31092@archbookpro.localdomain> (Denton Liu's
        message of "Mon, 11 Mar 2019 02:37:51 -0700")
Message-ID: <xmqqmum0h88n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> I was in the process of deprecating `git diff <commit>..<commit>` as
> discussed here[1].
>
> [1]: https://public-inbox.org/git/xmqqmumy6mxe.fsf@gitster-ct.c.googlers.com/

I didn't (and don't) advocate such a deprecation, FWIW, in that
message.  I simply do not think it is worth the cost.

I however think it may be worth making sure that our docs do not
encourage "diff A..B" and teach "diff A B" when comparing two
endpoints.  That can be done without changing anything in the code.

