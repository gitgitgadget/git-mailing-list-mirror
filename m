Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF9091F404
	for <e@80x24.org>; Thu, 22 Feb 2018 20:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751180AbeBVUJw (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 15:09:52 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35407 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750776AbeBVUJv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 15:09:51 -0500
Received: by mail-wm0-f66.google.com with SMTP id x21so691527wmh.0
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 12:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=8lG9hon3X9J7+US7ebpjLTxN3uEMVmmnfkdR1fdH1/w=;
        b=C8kM/Q2/8l498j3YK6gjZo3ApH3fOfn9IhkE7O/tDryjMiScMB+PL946Ho8K9nXLmJ
         3IvhQoNZGrzWUiagJtUuBYz5GNenalwk17WvTWD8L9CKloVo15TAdolPNcHmqk3b2gWK
         bETh/XMwjbuUGFeA19F3eKUZRI2ckHZFKE1pc1CGyTnBpGqDqEXdfhBosdDJqbVxiqVD
         nVl8MkHXMiuzb660dJRrVi4ohny3ss5S2asUiTc57Ljui4KTHknYQNB9GGexT3MjvdAw
         CW7cpuzsrQJdrcKbZeKygwJRNB/dQBGM2HPujNWBKwGyYxXKFvffDzxKbREipxC4S4SU
         CtIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=8lG9hon3X9J7+US7ebpjLTxN3uEMVmmnfkdR1fdH1/w=;
        b=QbMaZNCmyImJKVU9kQDzqB7Pu7CyGWBVM7VaB1+lOnXiL/V2fC4XMpF+KUehFeTUCP
         YxLgPbDXyBDEq7xadTrh5JdPpjEf0R44BYUKiWO6tEyJOFeFT5ctB+dYyxqmx1UPdXIi
         UG0onE4aQNPipOrujSZ5Koskbepwqujl+0WGjHm8kg/HrXv3yhuLnG8jT2NXDEWYZ5sX
         eQHKmM759kl+ChCpiEKeCXoXpkuK+TLQL/Df5c24ap4GLweZxiXywmqjQxHs5c1Hgxiz
         A/GGXFwXFOPvlC8iuLOWTULo+/SSSlmY0K8twnOCDkfDJJWzp03aUMeoqhK//gh6YOGq
         QUAQ==
X-Gm-Message-State: APf1xPBz7cLL8azekCIKTbfrJkBsD2n+MvWVuMYl6mjko7Isl8jEDyYP
        Lg62yV+tvCIpFZ/qmGpIjqE=
X-Google-Smtp-Source: AG47ELug6J1jvBviKKCc5vksY0W3OMcN8/ErbZw9VL7Mo25BHQelNg7VQbYGlVaImbHkIQNTPXsSnQ==
X-Received: by 10.28.108.7 with SMTP id h7mr271997wmc.35.1519330189426;
        Thu, 22 Feb 2018 12:09:49 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h194sm292711wma.8.2018.02.22.12.09.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Feb 2018 12:09:48 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v5 00/17] document & test fetch pruning & add fetch.pruneTags
References: <20180121000304.32323-1-avarab@gmail.com>
        <20180209203216.11560-1-avarab@gmail.com>
        <xmqq606pyiqo.fsf@gitster-ct.c.googlers.com>
        <874lm9f6pe.fsf@evledraar.gmail.com>
Date:   Thu, 22 Feb 2018 12:09:48 -0800
In-Reply-To: <874lm9f6pe.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 22 Feb 2018 15:18:53 +0100")
Message-ID: <xmqq7er4wzub.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Thu, Feb 22 2018, Junio C. Hamano jotted:
>
>> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>>
>>> Here's a v5 (correct subject line this time!). Many thanks to Eric for
>>> a thorough review.
>>
>> We haven't seen any comments on this round.  Is everybody happy?
>>
>> I do not have a strong opinion on the new feature, either for or
>> against.  I didn't find anything majorly questionable in the
>> execution, though, so...
>
> I've been running that here on thousands of boxes (that are actively
> using it) for 2 weeks now without issue. Would be great to have it
> merged down & in 2.17.

If those thousands of boxes are all employing one specific workflow
that is helped by these changes, and the workflow is that other
people do not care about (or even worse, actively do not want to let
their junior project members to use without thinking), then a
data-point from the original author does not amount to much ;-)

Let's see how others find it useful and/or if the changed code gets
in the way of others (I am not absolutely sure if the changes are
free of regression to existing users who do not use the new
feature).

Thanks.
