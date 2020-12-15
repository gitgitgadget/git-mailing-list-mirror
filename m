Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942F6C4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 02:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48E5A207A0
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 02:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgLOChe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 21:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbgLOChU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 21:37:20 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8D2C061793
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 18:36:40 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id s2so21708825oij.2
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 18:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=IMLWVGaa895ThzBai/zT/o3sffqByGJOQ6rH77sS+2Y=;
        b=OXdZx9YlcvdjIWoXlU63nZMavQ1l30JpAqSSxyBucAEVH3KZAtDf0CNiU8Ubi3hTBe
         QeJTAlaC6IlhNdfOi11NJuC8o+teuP24C3BO9Trr1zVsiwTs4qkV/7klr965ngApuB/x
         Nokoh8/sOU/yX557qaLXNJjFQ06N/reTl299ikm5jsrLsKH+RZCzY5lJY0Gdsm+16+h3
         I6Qra2xKicBbUggFUr10BlEdJG1XQ4SG2fGh9iMcAOwwLxn+cc/vbHHQfMZeH8A37Gw6
         jxnZTlBR/dGVbvuwaR4jwA1ae1wfRd0k534bq1F1HE86kr0TUxYaHp0AcJVvu8lq+X58
         a7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=IMLWVGaa895ThzBai/zT/o3sffqByGJOQ6rH77sS+2Y=;
        b=NfN88ChA+dfXinXjoTplR6aG4ZtMjOR17PicjBvWyu+TUyQpy3zeKS33WXv8hO0Mrz
         7UjXDFYdJKSaCyAO/R0CNokWP+KCcoQbmqhYkQsB/Hg4v6dd7umkRIkGPc6tWaiGotjS
         zsOhJ7pwcx0prLKoxFiRWxahkwLEh6MsgzcL4okD9ng+6KmQF+S2hLrgZMOPFnptk+K9
         2vHHb8fnwArDGorKLEyD63FA0zGotUxQ5ybfNV55epWscssC2uBLC5puixmOcWykysqu
         eCZZb44FA/0i0v8mydjbFaAcaBdSy/+5D2HnEdPlkCtIVU0bOGAVStonounPABYnv4e+
         ZVMg==
X-Gm-Message-State: AOAM530mdZ14JlW20Y3phQ/wMp/av20xn4ZhUYT1Upv3rIhKFzcrej1Y
        XiXJ8ZoUfdQgL3dpQlRqSaE=
X-Google-Smtp-Source: ABdhPJwMpmnw/nEZVqsB+dcWByU73VpnDrpnRerkEjK5Mj5ti0Pj/Y1lgmXLTGL5yeLfuiXOWFxSrA==
X-Received: by 2002:a05:6808:8f0:: with SMTP id d16mr19996453oic.47.1607999800259;
        Mon, 14 Dec 2020 18:36:40 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id i1sm84332otr.81.2020.12.14.18.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 18:36:39 -0800 (PST)
Date:   Mon, 14 Dec 2020 20:36:37 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Message-ID: <5fd8213598c33_d7c4820837@natae.notmuch>
In-Reply-To: <xmqqzh2g9e0r.fsf@gitster.c.googlers.com>
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
 <CABPp-BF4rXBOKsn8bG6y3QUEtNVV9K2Pk5NmwrU5818CqhRt_Q@mail.gmail.com>
 <CAMP44s2L24jhCG9ps72--ZiJkXUovR726jCf8JTLHAs0jV7Whg@mail.gmail.com>
 <CABPp-BGdNt8TBMTE9zvaicF5AtvyTBhpiJXqkuZc7mBLGbw0Qw@mail.gmail.com>
 <xmqqeek2cc14.fsf@gitster.c.googlers.com>
 <CAMP44s2XFQoda_PMULWha-rj9HhNfEddO5fikmswk9=AWN4RCw@mail.gmail.com>
 <xmqqpn3lbhxn.fsf@gitster.c.googlers.com>
 <CAMP44s2nmVnXiBA8S=vHBZznuRNKKe=xGOEBJ80MYhA_XCqNkg@mail.gmail.com>
 <xmqqlfe99yvy.fsf@gitster.c.googlers.com>
 <CA+P7+xp=UGd0iK8uLxnqH0iycrxo--8on3d0Z+jsuyhpV-fVew@mail.gmail.com>
 <xmqq360h8286.fsf@gitster.c.googlers.com>
 <CAMP44s3KCoDfRXzarJw5AE7UsY-=eP6GbHzdDcdrs2rsw5tL+w@mail.gmail.com>
 <xmqqy2i86ok1.fsf@gitster.c.googlers.com>
 <CAMP44s13YFZeOMz6V5sPdOnLXD-v3aQZiP7vvXXNfQLZP4Puwg@mail.gmail.com>
 <CABPp-BGZcmHhge7JnM12baL_86yV-+7z4kkvFwUUrP+db8QD8Q@mail.gmail.com>
 <xmqqy2i6w45c.fsf@gitster.c.googlers.com>
 <CAMP44s3NNDL+zJjaukV9D2dJyU=ugSrnWz9o-whO9hKnBTxAow@mail.gmail.com>
 <xmqqtussirsl.fsf@gitster.c.googlers.com>
 <CAMP44s3CcNAT4dFogyo61zV+D1pZ-0K+1rDBk_BUk-RYVUW0RQ@mail.gmail.com>
 <xmqqh7ooje03.fsf@gitster.c.googlers.com>
 <5fd7e77c78e06_d59852083e@natae.notmuch>
 <xmqqzh2g9e0r.fsf@gitster.c.googlers.com>
Subject: Re: [PATCH v2 02/14] pull: improve default warning
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> >> We do not have to or implement both, but either should give us the
> >> "when pull sees a non-ff history, it should stop without merging or
> >> rebasing, and the user won't be given the advice on how to choose
> >> between merge and rebase" behaviour, I would think.
> >
> > Right, so both should error out.
> 
> One of them, not both; the one we choose to implement would make it
> fail, I would think.

If only one of them fail, then it's impossible to tell the user:

  If you want to try the new behavior, type this command:

    git config $something

We have to go straight for the error, with no deprecation period.

> > And what should these do?
> >
> >   git -c pull.rebase=no -c pull.ff=only pull --merge
> 
> There is no --merge, so let's reread with s/--merge/--no-rebase/;

Back in 2013 everyone found it easier to speak in terms of --merge, even
you, BTW, who was the first one to send a patch with --merge [1], after
Linus suggested it [2].

> the command line would be saying "I only want to fast-forward, or I
> want the command to fail".  The advice code should not trigger
> (i.e. we gave an explicit preference to merge and not to rebase, so
> rebase_unspecified would be false), but the configured preference
> that says "we take only fast-forward merges" will still be in effect.
> If the history is fast-forward, the merge backend will happily
> advance our history.  If not, the merge backend will happily fail
> the pull.
> 
> If you want to countermand the configured preference from the
> command line and allow a merge to be done when non-ff history is
> given, what you'd need to override is not --merge/--no-rebase.  The
> configuration pull.rebase=no already says you do not want rebase and
> you want merge).  You want to override --ff-only, so I'd expect
> "pull --ff" (or "pull --no-ff") to be how you override your
> configured preference and merge in a non-ff history, either by fast
> forwarding or creating an extra merge commit.

Precisely, so you can't tell the user:

  If you want to try the new behavior, type this command:

    git config pull.ff only

Because, after the user gets the error:

  Not a fast-forward, either merge or rebase.

She cannot do:

  git pull --merge

Which is the best idiom to specify she wants a merge.

The command will still fail, even after the user has specified she wants
the new mode, and that she wants to merge in this perticular case.

> >   git -c advice.pullnonff=false pull --merge
> 
> Again with s/--merge/--no-rebase/; but that is showing the
> preference not to rebase and to merge from the command line, so
> shouldn't it just go ahead and merge without any advice?

Yes, but *before* we make this the default, what configuration get us
there today?

> > I'm going to answer because I think it's obvious what you would expect:
> > if you pass --merge, both should succeed.
> >
> > Except they won't, because "git pull --ff-only --merge" fails.
> >
> > Correct?
> 
> See above.

That's a "correct". There's no configuration today that gives us both:

 1. fail: git -c $config pull
 2. pass: git -c $config pull --merge

Like this does:

 1. fail: git -c pull.mode=fast-forward pull
 2. pass: git -c pull.mode=fast-forward pull --merge

Cheers.

[1] https://lore.kernel.org/git/7v4ncjs5az.fsf_-_@alter.siamese.dyndns.org/
[2] https://lore.kernel.org/git/CA+55aFz2Uvq4vmyjJPao5tS-uuVvKm6mbP7Uz8sdq1VMxMGJCw@mail.gmail.com/

-- 
Felipe Contreras
