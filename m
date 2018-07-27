Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AE791F597
	for <e@80x24.org>; Fri, 27 Jul 2018 20:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389377AbeG0Vlh (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 17:41:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42986 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389341AbeG0Vlh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 17:41:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id e7-v6so6194989wrs.9
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 13:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=znrvRseIc4a8MmfOjUdEAdFuVLfcM1AtbpMR7bYf8qk=;
        b=OGI87FvqnG0MGTDRpTg0sQ/awklfjmrWZ9HCccvDRj7TUVZoFyFdQbKeZ4v+5Vboaw
         AeJaa28tCOicj9U+DdKT5MANfJ2yC4pFAayh5g8McGswqdfRpObQ4NtjHY4VsWnmzogJ
         WdAIUFZsCyDi1F1iTeP7DmIMYXWMxjDQ3/R/lUUS5kOxNtflr6/kNPiY86pSECyJPlSa
         HEMl1giN87ftgx4HSDlR4fcN9M8vIlyr572+4arLw0Dfcahsogo7oyQjhpEM6AowO8F/
         x2KRx1qCmwlQqcrDy+UNwFABy40AWVz33LYD1eTrwZtNzF6mrfznaYRfY04D68h9Z6JR
         mkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=znrvRseIc4a8MmfOjUdEAdFuVLfcM1AtbpMR7bYf8qk=;
        b=G4o+3lgzuQ6m5ANTWoyl411z+7jJKenoU672SLH2N4R5ZgzgHBT3Hex4YQGVO3ZUJ7
         CDYFOWE2bgASRe0/TjmEMVdDGtgnPk5CvM5kaTnvVxwNEvw556KBTTCzSe1tpaDsvI/t
         PuO+BHWe06+lEALhBYU+jbx3FIxkTrF3U1TvcyYTVb22dqMUtS7Zrp+tY7wHwDG8iAIW
         /hg4FSS+28Cn+f2ubOlc6zVwTFgh39rCbg68XdnTAKQ5xcFmxFzQcT1PKKXXbhoDHfnE
         2OTa15W6mqck+X0R0V4oMzJ/UivBigu9GHLBIpBfQMvO28dbkWVteJMZnpnNQPe7Z3Au
         Sbmg==
X-Gm-Message-State: AOUpUlH2h2YaXZJlOVoVNMPrfnbB6rQKLPl/5sCeCyzbknkq2XdRih5q
        zbj3wUwYTS2zx6F7B3v8o7g=
X-Google-Smtp-Source: AAOMgpep0CmwENp1YdUFr6FhByuZqRTdYNz76xEs2suAMYcIFCu5khvnb1I84p4yZSHcGT7T6P64dw==
X-Received: by 2002:adf:8325:: with SMTP id 34-v6mr6118587wrd.67.1532722686762;
        Fri, 27 Jul 2018 13:18:06 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h7-v6sm5139517wrs.8.2018.07.27.13.18.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 13:18:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 07/10] fetch: implement fetch.fsck.*
References: <20180525192811.25680-1-avarab@gmail.com>
        <20180727143720.14948-8-avarab@gmail.com>
Date:   Fri, 27 Jul 2018 13:18:04 -0700
In-Reply-To: <20180727143720.14948-8-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 27 Jul 2018 14:37:17 +0000")
Message-ID: <xmqq6010mo03.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

>  +
>  Setting `fsck.<msg-id>` will be picked up by linkgit:git-fsck[1], but
> -to accept pushes of such data set `receive.fsck.<msg-id>` instead.
> +to accept pushes of such data set `receive.fsck.<msg-id>` instead, or

Inherited from the original, but I find it a lot more readable to
write "to accept pushes of such data, set X" with a comma, given
especially that "data set" is a noun that has little to do with what
this sentence wants to talk about.

I'd suggest doing s/instead/& to loosen the error checking/ or
something, as you are only talking about "to accept" (iow, the
target audience is not those who want to reject more by promoting
"warn" to "error"---you are talking to those who are only interested
in demoting "error" to "warn" or "ignore").

> +to clone or fetch it set `fetch.fsck.<msg-id>`.

It is unclear to me what "it" in the last sentence refers to.  

The best rewrite I came up with is "... to clone or fetch from a
repository with such data" but that is not an exact counterpart to
"to accept pushes of such data", so I am hesitant to suggest it.

"... to accept such data when fetching or cloning" might be a better
counterpart, but repeated "to accept" in this single sentence bothers
me somewhat.  I dunno.

I'll comment on the implementation part of this patch after lunch.
Thanks for working on this.
