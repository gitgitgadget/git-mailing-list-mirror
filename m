Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07AF6C2B9F2
	for <git@archiver.kernel.org>; Sat, 22 May 2021 21:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE14560240
	for <git@archiver.kernel.org>; Sat, 22 May 2021 21:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhEVVtb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 17:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbhEVVtb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 17:49:31 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA07EC061574
        for <git@vger.kernel.org>; Sat, 22 May 2021 14:48:04 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso10809260otu.10
        for <git@vger.kernel.org>; Sat, 22 May 2021 14:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=B34fUoWpuf/oRawgQ44PXfQ/yVbhNsMoZnHpfZgnftw=;
        b=ba+JH8R6G7JyicDU/mAF0TOYzJ8epXlHcV1iZLf9QElQrn7l9PTzrU1SFXZgbk2csN
         Mrq0CbQNLxOmgI4/IyG83Kx3nMQvvdUt4/YcN2q3SnzlAnx2ZvgjbEN7FTwux3qQfDy3
         UASZOeqFM/whTuGSoF2/rNwaC69SYUQ4C5BR50c1LkU3xksoXs+jGIGaC27cimtjsB6S
         C4p5xNdGGcTSut/NborJeJ+/9OO143XZsMBtvlpNer7jxrQfD66rnB9lVGyF/0kznr3k
         AtQadHkRM/cVFU0BARLq2gYV2aBXFakP/gvsQ6GrJo6fiwLu7wlcOTTODDgWnLelUSrp
         Ixww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=B34fUoWpuf/oRawgQ44PXfQ/yVbhNsMoZnHpfZgnftw=;
        b=WBH05qFr7azxsJvPjI7DHpsWPwjy5SuLBRNkv02tClpRktjJHC5dQgNfiD7pRC2T+h
         wv/wwXoBXODipGpStlEplDzRXTtuRuhnnsXvvVFbvH3u63HS8iVU13gynktaPPhgtpUe
         NlTTxEMWLrH5akuK2x+Uf17ZKHj3qiO99brm+p6OY7sX8M+UiUJmyqFopsJaXp8nmmwH
         3esS0zOKhelrkexG0bWuuS59hjgWmDmfaGwFYEbDvIjPVM2DROsPfhYnbMdA9sP+35RR
         0qrwVcg21o6N1y+NAF4v0IOW6u6xd7XpPTcv+pZ3bxtuK8swbayKJmDz6mzUcQtpi0Ok
         Mu+w==
X-Gm-Message-State: AOAM531gqBsu0aaDi39G2xLRJLZqU5Tnm/0d72TNIf8Qgf9PsYHETg4I
        5fPWFQ3hnvrMInoJHyePwxQ=
X-Google-Smtp-Source: ABdhPJxfdMDtmdLS5zHnh0nhZ6vZK1e1LE4x/5L9Bw7NkE/jlbHDzAifUZW/DNjNw1j4I6J1oECEhQ==
X-Received: by 2002:a9d:6548:: with SMTP id q8mr13380460otl.311.1621720083799;
        Sat, 22 May 2021 14:48:03 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id r189sm1881349oif.8.2021.05.22.14.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 14:48:03 -0700 (PDT)
Date:   Sat, 22 May 2021 16:48:02 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Leah Neukirchen <leah@vuxu.org>
Message-ID: <60a97c12d96a_85723208d4@natae.notmuch>
In-Reply-To: <e669d76b-0bed-4eac-a942-c89b7523ca34@gmail.com>
References: <20210518010121.1350327-1-felipe.contreras@gmail.com>
 <YKMWL0iZLVl1KTrB@camp.crustytoothpaste.net>
 <60a332fd22dad_14c8d4208ed@natae.notmuch>
 <YKRSlFcFAcHcR3uY@camp.crustytoothpaste.net>
 <xmqqfsyj1qe1.fsf@gitster.g>
 <YKRy6oPkgS6FMSZ0@camp.crustytoothpaste.net>
 <xmqq1ra3z23n.fsf@gitster.g>
 <87lf8bqdv0.fsf@evledraar.gmail.com>
 <YKcFrbuuJrWAxXgm@camp.crustytoothpaste.net>
 <60a7f7427eab6_55039208ba@natae.notmuch>
 <8811383b-d5f1-2b06-8ac7-47bbc5fc9d20@gmail.com>
 <60a8243323625_77e4f208f8@natae.notmuch>
 <636007b7-c079-f8a6-1b26-eb2a55505354@gmail.com>
 <60a83c794ed4d_81cd4208f3@natae.notmuch>
 <e669d76b-0bed-4eac-a942-c89b7523ca34@gmail.com>
Subject: Re: [PATCH] help: colorize man pages
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Igor Djordjevic wrote:
> 
> On 22/05/2021 01:04, Felipe Contreras wrote:
> > Igor Djordjevic wrote:
> > >
> > > ... to make the point (hopefully) even more obvious, let me 
> > > quote the whole part:
> > >
> > >   It is reasonable to configure certain software such as a text editor 
> > >   to use color or other ANSI attributes sparingly (such as the reverse 
> > >   attribute for a status bar) while still desiring that other software 
> > >   not add color unless configured to. It should be up to the user 
> > >   whether color is used, not the software author.
> > >
> > > I understand it exactly as (I think) it says - it is reasonable to 
> > > allow (the user, not developer!) to configure certain software to 
> > > (still) use color
> > 
> > This does not follow.
> 
> Sure, if that is the only part you read ("followed"), taking it out 
> of context while chopping the rest...

Language is understood bit by bit. To properly understand the sentences
that follow you first need to understand the sentences that preceed.

> > The contraposition of that statement is that if a text editor doesn't
> > use color sparingly, then the user should not be allowed to configure
> > such software.
> > 
> > Do you really think that's what they are saying? The user should not
> > have a choice? (with certain software) That's color fascism.
> 
> What I really think is that my message which you replied to - but 
> decided to quote only _sparingly_ ;) - already addressed both use of 
> "sparingly" and who should have the choice (not to say all the power) 
> in a very clear and explicit manner (hint: user exactly), so I'm afraid 
> I'd have nothing more to add, sorry.

I know what you said in the rest of the message, which is precisely why
it does not follow, and since you ignored my argument, let me state it
with logic symbols for the record.

  It is reasonable to configure certain software such as a text editor
  to use color or other ANSI attributes sparingly (such as the reverse
  attribute for a status bar)

We extract part of the message:

  It is reasonable to configure a text editor to use color sparingly

The first sentence implies the second, no information is changed.

---

You interpret that as:

  It is reasonable to allow the user to configure a text editor to use
  color sparingly

This is obviously a different sentence. You introduced a part that was
not there.

Now we use logic symbols to transform your sentence:

  p = the user configures a text editor to use color sparingly
  q = it is reasonable to allow the user

This is what you said: if p -> q. The contraposition is: ~q -> ~p.

Therefore you said:

  It is not reasonable to allow the user to configure a text editor to
  not use color sparingly.

This is a fact.

What you said doesn't make sense.

---

This what no-color.org said:

  It is reasonable to configure a text editor to use color sparingly

By doing the same contraposition as above we get that it's the same as:

  It is not reasonale to configure a text editor to not use color
  sparingly.

Or in other words.

  It is not reasonable to configure a text editor to use colors heavily.

If it's the developers doing that, then that statement is correct.

This is my interpretation. My interpretation holds to scrutiny; yours
does not.

They meant the developers. They are not trying to tell users what to do.

Cheers.

-- 
Felipe Contreras
