Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6681020248
	for <e@80x24.org>; Fri, 12 Apr 2019 01:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfDLBse (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 21:48:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37386 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfDLBse (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 21:48:34 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so9792786wrm.4
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 18:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Do6crs3syZlfKyY0J5m6RQMvh9Qa70Tt0A1OtzLNFds=;
        b=aT+NJ32MSPWYBxjEyaTfXemBWPe2qddmsjQWUNV/0Ov212DB5IWTp12XEO69MPKqzI
         r02xLdz6RoK2+dZ/LZjD7BDIkizo8lFbAOw8doaH3TsLXkLZLIqB/4iIUg/nWJThh+tX
         XXRCEgCn5yGEMUcVqZcm1QdZz4Le/iYZSvMmQU41nlBB7TkgDB/WlJPTrTlY9no86wYt
         8WTF9H3xx50n2+T5fNXO2mJWzV7s+Cz7FiVd692UTohphhCKwVc0zLdzcBWKELxIkkAd
         fRNaPzKHiC4TItiJieX+IZkRXBMiq5L/YirLOW9Gc8dvwYEUmsGDPYuMK45jwPn1C8wx
         DJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Do6crs3syZlfKyY0J5m6RQMvh9Qa70Tt0A1OtzLNFds=;
        b=cWAcNTvLyWTIwgzdSmW1nhVdMbaFAVxCwbRnCzLZS28X6LBJ7F/Ie0WBRhyKvEsfVZ
         r9BaUJ+NadZl20jN3NbyLdjq6eQ3x9vYrCfW4OfykK2cX4ognYJGatfw9WmoU7dJS+iH
         Fo5REnoYtVZaAyKzg3/NAsx8+jSmwpDXKhH/4TUMBO2mjUn+Wf+0C0apw5RNLDoZNNV4
         OiQdzgXMnS0pVKlAGR6iMW/RHKhXjTodKYmB5UgZwBO9ndgusjli15+pPtrYLXPGvsMK
         mK5enYIMiFLEeU5/GNuiIRX/5qgJL+Kgx7NktFmMy64fKfgLoDzXN2zUECAt4+M2z/Cg
         E1bA==
X-Gm-Message-State: APjAAAUBOwALOVF6KIz9FBm/Tzo4Ed5j93qAAlzH/FBk6TI0KIMK6/Yg
        qMFkeFwgLXJaE82rkgDiO8i+UIF4MXM=
X-Google-Smtp-Source: APXvYqw3m+/Cffr+jCFgTJ7B3MEiFlpiYouj6xtpP+D8xQCdetcovJWfvQjI0lyqFe8rtrwdKw0xtg==
X-Received: by 2002:adf:f488:: with SMTP id l8mr32201712wro.213.1555033712015;
        Thu, 11 Apr 2019 18:48:32 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id a11sm5241531wmm.35.2019.04.11.18.48.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 18:48:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] untracked cache: fix off-by-one
References: <pull.178.git.gitgitgadget@gmail.com>
        <a7f75cefb682546862be4dd8b48f91c4034c5d5a.1554901006.git.gitgitgadget@gmail.com>
        <20190410162029.GA30818@sigill.intra.peff.net>
Date:   Fri, 12 Apr 2019 10:48:30 +0900
In-Reply-To: <20190410162029.GA30818@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 10 Apr 2019 12:20:29 -0400")
Message-ID: <xmqq7ec00z9t.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yeah, every struct on a platform where FLEX_ARRAY is 1 ends up
> over-allocated by 1 byte. We could account for that in all of our flex
> allocations, but I don't it affects enough platforms to be worth the
> bother.

It was an explicit design decision to declare that the
overallocation was a non-problem back when we invented FLEX_ARRAY
macro.  We could probably have instead decided to pass number of
bytes to be stored in the flex-array (including NUL if that is a
character array) then subtract the value of FLEX_ARRAY if FLEX_ARRAY
were limited to only 0 or 1, but that was not workable as it is the
most natural to define FLEX_ARRAY to an empty string, i.e. making an
array field decl to "type field[];", for the more recent compilers.


>> As there is no obvious way to trigger this bug reliably, on all
>> platforms supported by Git, and as the bug is obvious enough, this patch
>> comes without a regression test.
>
> Makes sense. This code path should be well-covered by the existing tests
> anyway, so even if we could get those tools to trigger, I don't think
> there would be much point in adding a new test.

Yeah, it is already super that this obscure bug was spotted in the
first place.  It is true that this may regress without a test, but I
do not think it is reasonable to expect that it is possible to write
a reliable crash-detecting test for this one.

> The right thing is probably something like:
>
>   eos = memchr(data, '\0', end - data);
>   if (!eos)
> 	return error("malformed untracked cache extension");
>   len = eos - data;
>
> I wouldn't be at all surprised if other bits of the index code have the
> same issue, though. And at any rate, thinking about that should
> definitely not hold up your fix.

True, true.  I wonder if folks intereseted in libFuzzer can chime in
with something useful here, but that is totally independent.

