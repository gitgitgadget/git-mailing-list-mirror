Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F261BC47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 22:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0CD561185
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 22:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhFGWVC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 18:21:02 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:37541 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhFGWVC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 18:21:02 -0400
Received: by mail-ot1-f46.google.com with SMTP id v19-20020a0568301413b0290304f00e3d88so18343078otp.4
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 15:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=3RsFC/fzxAoap5Z6i1wxe6fBFfR7v5xjG/++E/GiQHk=;
        b=q5OHR5QsvaYNZWmYSBbfzAXtULbrq3ZY73gRPcOUhYHTj36CvgG3agf4/tBpNhmRu2
         YyybEx6v3H8A8bkkMQGQY4Q7UN2iDiDOZ1kCqPSiGf4Dx2GrIb0gt19EjjJhEDIddr1m
         ORrAR0GtxpqcHVDUDB2972W6l7SrqiOAPCK6gj+N3pKMslklu1h86ubFYgqCJems0a0R
         9vfYzpaS0R88e+Rpi7a1Nv+3ayEvBYaGj0UZVsb9I4IF6eg0wEFQqHSAmS3NNTrJW8Mw
         1X3KGTwJWfrmJU1SKN0LAzKnvy+AynUGK8WlkH9QBX+DxqejjzOu0BW83jPtyZwOEcXr
         Obdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=3RsFC/fzxAoap5Z6i1wxe6fBFfR7v5xjG/++E/GiQHk=;
        b=LHo+VhOFf35c9ItNtRQeSMgL2B1rhsjIIDhvyPgeke1hA848vs1BWQ4LN9VpymBqdX
         7j5g1l2EurH2qsCUuGz56q4httcTecCeCTjSxf+8ZW7WsfDUYVnQTG7QFKEtgfQy2b1G
         1ymH/vHFwt3Xf0AcMuc2H7PsNIERh59hJjG21CkSulKWulDBuY1vQubhFQhrro0yAjX9
         fVw3NYtxlDwzmiwGCFn34sEZ+pGTPQ1Sw/fqyYzrExi7xDO4jpncNbQSFWIUQ1pzigmK
         IrcsFRRQTSP8GflfQ3ZkDbs2xXBmRLlGbneNmqU2K7o3CRegyQCErHvTVL3aE0wT1fZh
         eiBg==
X-Gm-Message-State: AOAM5301s+25tva61R066i82v0EQLYuF+Fuj+oztSa2AolQDt1kU3l0/
        Mbvte5qO5dxgWQsuzgjN2+M=
X-Google-Smtp-Source: ABdhPJw8t/mSHiKe3FZGEVWsmAAn86gKpeSsMpRxP5WpS/GOnFGj04NO8olI4SkN12PjM0zmsTlIug==
X-Received: by 2002:a05:6830:717:: with SMTP id y23mr15393369ots.174.1623104282765;
        Mon, 07 Jun 2021 15:18:02 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id x7sm2489841ooc.23.2021.06.07.15.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 15:18:02 -0700 (PDT)
Date:   Mon, 07 Jun 2021 17:18:01 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Robert Karszniewicz <avoidr@posteo.de>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, stolee@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Robert Karszniewicz <avoidr@posteo.de>
Message-ID: <60be9b1913a2e_dc7a9208fc@natae.notmuch>
In-Reply-To: <YL5/diPpLTOdRjoB@BDZ>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <d2c079264955b3bd6c3a5ef77a9c3684206f8475.1623085069.git.gitgitgadget@gmail.com>
 <YL5/diPpLTOdRjoB@BDZ>
Subject: Re: [PATCH 4/4] CodingGuidelines: recommend singular they
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert Karszniewicz wrote:
> On Mon, Jun 07, 2021 at 04:57:48PM +0000, Derrick Stolee via GitGitGadget wrote:
> > From: Derrick Stolee <dstolee@microsoft.com>
> > 
> > Technical writing seeks to convey information with minimal friction. One
> > way that a reader can experience friction is if they encounter a
> > description of "a user" that is later simplified using a gendered
> > pronoun. If the reader does not consider that pronoun to apply to them,
> > then they can experience cognitive dissonance that removes focus from
> > the information.
> > 
> > If we use singular "they/them" pronouns instead of "he/him" or "she/her"
> > pronouns, then we can avoid this congitive load on the reader.
> 
> That is funny, because I experience cognitive dissonance exactly when
> people use singular plural-pronouns. ("What? Did I read right? Is it a
> group? Or a company?" [seek back to verify, or explicitly ignore the
> hiccup])

Same here.

> On the other hand I strongly doubt that such a cognitive dissonance
> happens when people come across a wrong gender.  When documentation
> speaks of "the user" -- *any* user -- then it does not in any way
> conflict that that "any user" might be female.

Same here. If it is stated that a female reviewer shall do X, I don't see
for the life of me why it wouldn't apply to me too.

> > Using singular "they" is also incredibly efficient. Choosing a gendered
> > pronoun is usually arbitrary between "he" or "she". Using constructs
> > such as "he or she", "s/he", or "(s)he" are more complicated than
> > singular "they".
> > 
> > When choosing a gendered pronoun, that pronoun no longer applies to
> > nearly half of possible readers. Even if we alternated between "he/him"
> > and "she/her" perfectly evenly, we would still expect male and female
> > readers to experience an incorrect pronoun half the time. However, some
> > readers will not prescribe to either of these binary genders. Those
> > readers hence suffer an incorrect pronoun the entire time. Singular
> > "they" applies to every reader.
> 
> The 'singular "they"' does not apply to every reader and might not even
> apply to most readers. It might be natural for native speakers to know
> that "they" is "1 or more people", but that is not what foreigners are
> taught what "they" means.

That's not even true for native speakers either.

There's a difference between singular "they" with semantically plural
antecedents, and semantically singular antecedents.

For example:

  Everyone returned to their seats

I don't see any problem with that sentence, and it's singular "they"
(with semantically plural antecedents).

When linguists say singular "they" has been used four centuries, they
refer to the usage above.

But with semantically singular antecedents it's different:

  We thank the reviewer for their comments

Many native speaker linguist experts see a problem with that sentence
(and so do I).

Cheers.

-- 
Felipe Contreras
