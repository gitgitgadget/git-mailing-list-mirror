Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59A431F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 23:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbeJKHC1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 03:02:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43706 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeJKHC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 03:02:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id n1-v6so7545111wrt.10
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 16:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3ac+BrctFoZDomk3Krh2RnciYd0VoIpAjcAGZCUBu9g=;
        b=FDsafi29CBq6bRdWQOCt2S4vrqS8lyZX+b71v0qgcOSaeXI4OfusiMI9ux2xZ0vWRi
         q9gXHw5pkrO/ymTs7NM2STRrplICPZCn+ea4pDvlpBQvjkqodjJC6pql8A1JGs3LrW4a
         x4QeR4uNB7LkNRuNm2vNLkqsi/5O9ujMwCSl6woaZI+gixR1+KojaeqRvm9Izm8ITy+C
         j6c29A2MY+jQCvSQHkbtAsFvlFLYw3bLbSWyjzHOgxsMnTWjBcrtPF5rrYT3V+bK88pP
         vTp4kEpHiTfAXn21zMGpq3kPQd2Y4qNx+F8OnTi3PH0ZqZwHbDVTqH4r+PtO65wmIp0W
         pSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3ac+BrctFoZDomk3Krh2RnciYd0VoIpAjcAGZCUBu9g=;
        b=Pwx5pIlSc/bhQLTK8ZDLIlVUJMZMAHZxNtJsqLJJSjXnQSU04jS6nu5UM/vA93PIgl
         /37tMMT55pMcgjVHs2lAnVlmbxAui1IrhfRqeK6rIlgPNKK4VsHl/0m4Ax9WBRPjCbh5
         xsvwcc/u3Y1rwURraUOdGiE9K/231ALSiL4arfi73WupPbNzqO/Nn8CJr5V9A2wQQNIQ
         t7cWKgfkf5/+72V/ryo06JRjPus66dMbEzBMxc5fygmCMlR8t2dySfoaM5e0ETe3Yxm3
         +Byh8pjOt2nrQxmHU0Vzvyd7Ol4jPwv7m0FESIuR/LSNgTOCbU75Mk2x1F2WAVVxb89u
         3iYQ==
X-Gm-Message-State: ABuFfohIJVfiBNmDWzCxD3ibxlDE1UfIVI75ffNvCXxZh3IMGU4opW4E
        0y43PeLGqEnfYAr1Qu5X9ms/LZn4shE=
X-Google-Smtp-Source: ACcGV60qIaK7B9PK1gd/XoMzcn5t/p91pcSci97qR7vdp5augiz3h+NP5WuOPHekPkmas5rsj2Iobg==
X-Received: by 2002:adf:c793:: with SMTP id l19-v6mr24937121wrg.230.1539214679167;
        Wed, 10 Oct 2018 16:37:59 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g8-v6sm13452203wmf.45.2018.10.10.16.37.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 16:37:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Casey <drafnel@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH] gc: remove redundant check for gc_auto_threshold
References: <20181010193235.17359-1-avarab@gmail.com>
        <CA+sFfMeOpj4V+KszboVVQSoaW2yDgpfDNGwK9ZrNfGmOOAhPtQ@mail.gmail.com>
Date:   Thu, 11 Oct 2018 08:37:57 +0900
In-Reply-To: <CA+sFfMeOpj4V+KszboVVQSoaW2yDgpfDNGwK9ZrNfGmOOAhPtQ@mail.gmail.com>
        (Brandon Casey's message of "Wed, 10 Oct 2018 15:29:35 -0700")
Message-ID: <xmqqk1mpjru2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Casey <drafnel@gmail.com> writes:

> ...  Again, I don't feel strongly about it, but I'm not
> sure this change actually improves the code.

Yeah, in the context of the current caller, this is a safe change
that does not break anybody and reduces the number of instructions
executed in this codepath.  A mistaken caller may be added in the
future that fails to check auto-threashold beforehand, but that
won't lead to anything bad like looping for a large number of times,
so as long as the API contract into this helper function is clear
that callers are responsible to check beforehand, it is still not
too bad.

So, I'd throw this into "Meh - I won't regret applying it, but it is
not the end of the world if I forget to apply it, either" pile.

I _think_ a change that actually improves the code would be to
restructure so that there is a helper that is responsible for
guestimating the number of loose objects, and another that uses the
helper to see if there are too many loose objects.  The latter is
the only one tha needs to know about auto-threashold.  But we are
not in immdiate need for such a clean-up, I guess, unless somebody
is actively looking into revamping how auto-gc works and doing a
preparatory clean-up.

