Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C062120248
	for <e@80x24.org>; Sun, 24 Mar 2019 12:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbfCXM0S (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 08:26:18 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50232 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbfCXM0S (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 08:26:18 -0400
Received: by mail-wm1-f68.google.com with SMTP id z11so6248142wmi.0
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 05:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Mc/nI1QVc38MnzMwzu8eEZJi4xqeQ2HYniD96NASpmw=;
        b=hXDTIFmBNf4zM0msUwf2gyN6i91LWNxwAXIeXUWjzL9RD+HM662kJK6KPjCsZok1LM
         XWuA/kApHYolcQSXIoW4iSk5d3/eR406y+kAZan/46W/osSICHb3tuJwZDkUIvGmnM3u
         mxu//+MtKdJvoNR72ummXJNTFsRdS+f4zr02t2Zx9ROufCVojYWbcTBu+/35zFpYzv6v
         0l/lapEhoRSQI9c4m4TEuiQ2ffy9PKBJW0G7dXjU7eX7Bn41wwuJYii4jVEHsMatpe7B
         7JXpf4rcwZPR8A4sbVaXty6x587Hdz0TeM6E+bepeX1i+MSXT7yOtt9gHMcAHgeuT0D3
         IYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Mc/nI1QVc38MnzMwzu8eEZJi4xqeQ2HYniD96NASpmw=;
        b=bMTsaHAWh5tzD17F+lnre/ufVeYS92IGFuLP5N92SCJCQPa/4P6x+39x7DEaNT4Z/Y
         1rtcY4GU/1PG/PL4tGTPNb3JktSNV9z1rPgmw0JXsY6pRLh8qN7wrRZl2oaZjyt7CMG9
         nrCLUOIGyQnEWEmPPOBRixKF5OhGkmOy2S0utbmlt4FF8xkaThclaLCiu0Zpv/M12BuV
         Rt9B7Bc+jxdmkz9By0e/ulQ3QIIiu5nbg8li6qZrJO6+LLf9zyDmLrrB7NhJRO6Gt9Eu
         pT8Bk8XVh4Y8vHUlWMg7Hx+zfMU4tq33OFuHUnUCg0bCQKIETi50WmndSbyqdopNK/eK
         dL3w==
X-Gm-Message-State: APjAAAUFaxl5lkj0MnYsUcyScIsSgGgZhS+KhogHfluifyOfuZ8J4sZn
        DXSEfzSzoz43ll+R+y4pIbE=
X-Google-Smtp-Source: APXvYqyr1v01O3U+0U1mSlAc3OiNA5gkW+wS1Gn3PJ/e9/NRGOjKfzoQhWF/qE93lnrTtN6nQbSJhw==
X-Received: by 2002:a1c:ef1a:: with SMTP id n26mr2488287wmh.104.1553430376323;
        Sun, 24 Mar 2019 05:26:16 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id c193sm15945902wma.46.2019.03.24.05.26.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Mar 2019 05:26:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniel Kahn Gillmor <dkg@fifthhorseman.net>
Cc:     git@vger.kernel.org
Subject: Re: git tag -v should verify that the tag signer intended the same tag name as the user is verifying
References: <875zsdu41d.fsf@fifthhorseman.net>
        <xmqq5zsduinf.fsf@gitster-ct.c.googlers.com>
        <xmqq1s31ui5s.fsf@gitster-ct.c.googlers.com>
        <87imwbmqpg.fsf@fifthhorseman.net>
Date:   Sun, 24 Mar 2019 21:26:13 +0900
In-Reply-To: <87imwbmqpg.fsf@fifthhorseman.net> (Daniel Kahn Gillmor's message
        of "Fri, 22 Mar 2019 01:19:07 -0400")
Message-ID: <xmqqpnqgpifu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel Kahn Gillmor <dkg@fifthhorseman.net> writes:

> I don't personally have any use case for doing such a tag rename -- you
> mention two:
>
>  a) wanting to call tag "foo" that you found on remote "origin" by the
>     name of "origin/foo"
>
>  b) wanting to call "v2.20.0" by the name "g2.20.0"

For the record, in the latter there is no "wanting to call".  It was
merely a set-up used to illustrate what support there already exists
in the current system that helps making users aware of tags that are
not stored in there "natural" place.

The former however is a natural consequence of noises people make
around here from time to time, wanting to have tags you grab from
elsewhere and tags you create locally in separate places.
