Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D1891F7D2
	for <e@80x24.org>; Mon,  5 Jun 2017 18:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751292AbdFESbS (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 14:31:18 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:33308 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751281AbdFESbR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 14:31:17 -0400
Received: by mail-pg0-f51.google.com with SMTP id f185so23874574pgc.0
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 11:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MoVZ8/eEv+KzIOloV8vCALjpaOr735UTjqNLhxj1BIc=;
        b=bLqy+UXOEAtVxOp1ZHywP8LKI0fB1u+HsL4qw4uWOPfjbvzoFAYfwb679xD+ZVVi6V
         Q/joXHhjm89+J0BrXc8+9bW8x1r+iOFCDuGSeXiJYq+MQKaXHRANySXzw3V/fFzXFK6l
         Xy15XfqHl3fDHW2eB4mo9+DvgIqy2SZiLnLQ9DwC1uaGyHY0PouCT0mZySLSil9q+jfP
         48gh9smaBU3dOFepXARZtHgLdnWeGa5YQXQgQaCGW2IYL+RIcWfXXIkqZbckY2rFN8E3
         Ifs/uuGSChE906tm9BP1pbBG/mhxsZs/cFkIuizYP/CTCTdNalsoYw3XwzxR2wMZhkSZ
         0pPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MoVZ8/eEv+KzIOloV8vCALjpaOr735UTjqNLhxj1BIc=;
        b=kffsFTnRdvI3gs2TxOhW3FURHNGo6A76XRHpKQZsBlMNxWaEcXTVwLIAYapBS7tqDR
         3p+3ymYwH+BSKVVP+Onk+x1ZhwjVyuZb9rR/DHuZcD/iVVHi7wIwM7+umXR9Eb5NL0Km
         Ho2o6e+Vj54XyjuL0rhhm0i/63GQysXYw80Nnm4UGNTtkMMgIDZb4sKrtUZS+RYyfwXR
         kJHj/RZI9nZKjrNsQ476Z1d79VTENYjO5gKmROJr/EKohkKKb4KJx2/Tov4ajuRw/PgC
         WDBKOACRxnB5bClJ/VGs/xLPG2ArWS2QOIHK1G33bl88zbcuhbjOhBGgMueqbAH/Aads
         bH7w==
X-Gm-Message-State: AODbwcBxHMLWsxKu+92ZofITp4R98nH7fCFME9pwRGnbqs68fPXndELL
        dsRAOlSqETac8rjm7b8vr9wNhdjpr+Bm
X-Received: by 10.84.232.198 with SMTP id x6mr17083871plm.245.1496687477101;
 Mon, 05 Jun 2017 11:31:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Mon, 5 Jun 2017 11:31:16 -0700 (PDT)
In-Reply-To: <20170605175344.GC40426@google.com>
References: <20170531214417.38857-1-bmwill@google.com> <20170531214417.38857-7-bmwill@google.com>
 <CAGZ79kbqsvuBG21teO2kT=H6G-xP0wJbd0f0BTjd9obRMSaxGQ@mail.gmail.com> <20170605175344.GC40426@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 5 Jun 2017 11:31:16 -0700
Message-ID: <CAGZ79kb2sC=Bnx5KVeZCbx2yMexVeEtGynte-Tw75w940qww3w@mail.gmail.com>
Subject: Re: [PATCH 06/31] repo: introduce the repository object
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ben Peart <peartben@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> > +
>> > +       repo_set_gitdir(repo, resolved_gitdir);
>> > +
>> > +       /* NEEDSWORK: Verify repository format version */
>>
>> Care to elaborate on this? I do not understand why we would want
>> to check the format version here?
>
> When opening up a repository git needs to check if it understands the
> repository format and all extensions.  If it doesn't git needs to bail
> out and not operate on the repository.  So a part of initializing a repo
> object would be to verify that it understands the repository format
> version.

Ah yes. Conceptually I understand why and what the repo format
version check is. At the time of asking the question I was confused
whether this is the right place, but after some thought this is the
best place to put it.

And this NEEDSWORK is really just telling the reader that it needs to
be moved here, not copied. (That was another brain fart I had upon
reading this comment).

Thanks,
Stefan
