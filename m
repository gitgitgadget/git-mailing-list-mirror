Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6472EC00523
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 10:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B98220705
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 10:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbgAHKWY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 05:22:24 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42581 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgAHKWY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 05:22:24 -0500
Received: by mail-wr1-f65.google.com with SMTP id q6so2721534wro.9
        for <git@vger.kernel.org>; Wed, 08 Jan 2020 02:22:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j3sZJakRjvkxyqg1Z7i6+DTahgmuyIYihj70eqTwMdo=;
        b=sKeqNcj72iDlyyZWoJYuNJbfOWVYmKBIeqzSComhudmlBPD3CyjzJ/CIl9B7Ebl2Xp
         RZOSdrFCA3AMTrfTv3gieYap+TgGZcIfW9leuWLq/+zRHEql49gEmipZV0n2TSWMp/ao
         mZYu1L+NTnY4n8mq3dVCiNKxwzvT6Yh7gAp6iFOlc+S80oGQvOWG99j5jTakJUvxyKms
         HPPzaU0Ijz0eoGVGZWfjvG7JnOq/rf6N/DPgZBcwzi2+aCOSQHfwXXjUhYEj3fGh6FEH
         W51k+15jM7SnFKDNk9xqxJrkfmecPtJsKXrTYesFpYx7sC9bkzkgeIw+cWc8dkUREPku
         1qbg==
X-Gm-Message-State: APjAAAWdQOHYfciEAVQcgPBcgg6Crvp2PK9vVrFBAXOLa52D/bLEKQsS
        evOmQV/jE2PGhaGjqdWTiNJkOyGLfmOaO6ez20I=
X-Google-Smtp-Source: APXvYqyxn+0Mxysko3SjDWVSOyykV+4h6x+tiWHFPk0wKgtLgoeGDxtkKptQXS1Vx75W77nVMAYBhV0QGhVWclVLwXc=
X-Received: by 2002:adf:f382:: with SMTP id m2mr3633901wro.163.1578478942397;
 Wed, 08 Jan 2020 02:22:22 -0800 (PST)
MIME-Version: 1.0
References: <pull.507.git.1577933387.gitgitgadget@gmail.com>
 <pull.507.v2.git.1578370226.gitgitgadget@gmail.com> <19a7cc1889d6094e4f8a94c19c43ad554662e8d8.1578370226.git.gitgitgadget@gmail.com>
 <CAPig+cQ0qY8KDZrQ8khuz34DqPimorN7JHHn0Ms=KpvJYtxJoA@mail.gmail.com>
 <xmqqh8176xab.fsf@gitster-ct.c.googlers.com> <20200108014442.GC181522@google.com>
In-Reply-To: <20200108014442.GC181522@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 8 Jan 2020 05:22:10 -0500
Message-ID: <CAPig+cRt1fzNzbustfq2seQMjZmd79cGW+-oxsdzFXw8D-q26A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] branch: advise the user to checkout a different
 branch before deleting
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Heba Waly <heba.waly@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 7, 2020 at 8:44 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> On Tue, Jan 07, 2020 at 08:34:04AM -0800, Junio C Hamano wrote:
> > Eric Sunshine <sunshine@sunshineco.com> writes:
> > > (It is rather verbose and ugly, though.)
> >
> > I tend to agree. It also feels to me that it is giving too much
> > hand-holding, but after all advise() may turning out to be about
> > giving that.
>
> Well, if advise() isn't going to hold their hand, who is? ;)
> What I mean is, I think that's indeed what advise() is about, and the
> reason it can be disabled in config.

Git is already drowning in configuration options. Every new option
increases the complexity level for the user and of Git overall,
requires additional code, additional tests, and additional
documentation, and must be maintained for the life of the project. So,
every configuration option carries a cost in terms of end-user
experience and developer resources.

If anything, we should be trying to keep the number of configuration
options constant (or, even better, reduce it), rather than forever
adding more. Thus, we should think very hard before adding any new
configuration option, trying instead to discover ways in which an
issue can be addressed without adding a configuration option (with its
attendant costs and complexity), and only add an option as a last
resort.

> To me, the harm of giving too much hand-holding seems less than the
> harm of giving not enough; to deal with the one requires skimming
> past things you already know [...]

Perhaps I'm too old-school and too steeped in The Unix Way, but there
is value in silence and conciseness, and that value outweighs
chattiness, especially when chattiness is effectively unnecessary
(which is the case in the vast majority of error/warning messages
emitted by Git).

Too much hand-holding quickly becomes noise which gets ignored, thus
eventually drowns out the really important information. People need to
understand a problem before taking action to solve it. Blindly
following some piece of advice without understanding a problem can
lead to further problems (especially in those cases when it's not
possible to devise advice which suitably covers all situations in
which a particular problem may arise).

A well-written, clear, _concise_, error message can often provide
enough information to allow the user to understand and resolve the
problem without additional hand-holding. It's true that there are some
complex situations (for instance, detached HEAD) for which additional
hints can be handy for newcomers or casual users, but that should be
the exception, not the norm. Rather than adding advice messages for
every possible problem, perhaps a better use of our time would be to
weed out poorly-worded and unhelpful error messages and improve them.
