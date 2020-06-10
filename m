Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EA2C433DF
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 11:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED41D2072E
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 11:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeDeMRPC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbgFJLQZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 07:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbgFJLQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 07:16:25 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0F5C03E96B
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 04:16:24 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id q19so1979755lji.2
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 04:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eOUFghuZtwOj6jLELNNTRr9COUW5+pX0O9aTFagv48s=;
        b=UeDeMRPC5Lz/C1y+DU+2hndzC/Z3UvUWd6nFeGGFfQZsIbxjr3JaphM+ynLMnhW9+P
         MLRtbi8j3Ktf0SdVunHbtYxt+/hvxrz+HbwU8APsyuL7afr3GxwpkuxUlb9aD3NsTgUq
         d9fYvAp6PUgQCtCI9Lu3pEXKLpJ4PXbuSM7/BaxpSJ53S20KiNfpoS/AEM+6++XqxYcA
         kik9BcgnH6/y/T8FBghhsXhi4NHnAMUDGWXujREqP6NW/n+OR40lU9mNdScQ4L1WwNRG
         GgR7JCMOLoSSzzQSX4LFjpkn7psoNQ0NI/QJOo0SGUASC9ZTEPTfUDyzcEBNVQjFs6WS
         dHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eOUFghuZtwOj6jLELNNTRr9COUW5+pX0O9aTFagv48s=;
        b=MjMiAoA5pYGd9+rMqA+8krePXYi12Oz1vG6JnrIszD+8wh5mHyVaGMBnCXQfZfikAt
         ODV2A18xbIVZEUV2Hy7HTVlMvXIu22Vh20mWbpKTWSr6uy/GwO+Jm0RV2aF42MM3IY5u
         +ZMPuVWk8wF0hN78pF6wEQcTnnwFxbj6Lew94xc3WsSQPbE/IQOFZ7J+w9euFROK0nlH
         F6zsqOyl9NtM1lQajeuwxg+snno2juttYVQxXCgUtGvUVrfJWcWj6vyzPw3W0N+rC5ZI
         jgbCnotHfMktAIO22cO7ZjlnOA3ZvM8n9md9JFUobNtQJ8GXcLpcgtW450QAgOjS2GRu
         TraA==
X-Gm-Message-State: AOAM530/GLZ3qPH5ABIhM/dEQLl1eU2leo4KiZkXMPDQBWAc91jeYZJL
        CzgQFTp07bZY7j4GbLwHsHnoQXlaVa94lw3wpiQ=
X-Google-Smtp-Source: ABdhPJyAxF5rn3MThnG7pN4pTv2Wa57bflBtqVJgaEwwoLjAdfiBiSA05mqNK+/176gW+lej5xHoXcw78qU3vUgIoHs=
X-Received: by 2002:a2e:89da:: with SMTP id c26mr1585109ljk.447.1591787783079;
 Wed, 10 Jun 2020 04:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
 <20200505231641.GH6530@camp.crustytoothpaste.net> <CAOAHyQx=+fM1FpAv+g3M+j7j4MgLJA03=MGFmXLvZcfJKAEpGg@mail.gmail.com>
 <xmqqeeqoi5wc.fsf@gitster.c.googlers.com> <CAOAHyQzxG7Lc6+PLBtM6oe9vSoEEAmuXAaKF2VzO_phtkfGRVA@mail.gmail.com>
 <alpine.LFD.2.21.2006100549070.3771@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.21.2006100549070.3771@localhost.localdomain>
From:   Kevin Swinton <kevin.swinton@gmail.com>
Date:   Wed, 10 Jun 2020 12:16:13 +0100
Message-ID: <CAEwB0hhOUWiS80OPLWp1rZ4HKKn9GaXts+r30xQh=kPx2KQ_Pw@mail.gmail.com>
Subject: Re: Rename offensive terminology (master)
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Simon Pieters <simon@bocoup.com>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, don@goodman-wilson.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

May I just add to this part of the conversation by pointing out that
if people are concerned that the use of the word "master" for the main
branch name is offensive, there will also need to be subsequent
consideration for the name of the project itself: "git" is, for some,
nothing more than derogatory slang with no particularly positive
connotations.

It becomes arguable that if people wish to avoid (for example) the
upcoming generation from acclimatising/normalising usage of the word
"master", that same principle could also encroach upon the name of the
tool itself.

Share and enjoy.

K


On Wed, 10 Jun 2020 at 11:51, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>
> On Tue, 9 Jun 2020, Simon Pieters wrote:
>
> > Hi Junio,
> >
> > On Tue, Jun 9, 2020 at 6:02 PM Junio C Hamano <gitster@pobox.com> wrote:
> > >
> > > Simon Pieters <simon@bocoup.com> writes:
> > >
> > > > If someone is interested in helping with this, please follow up with
> > > > Don. But I would like to ask again for git mainline to seriously
> > > > consider adopting this change, given the information presented above
> > > > and the ongoing movement against systemic racism.
> > >
> > > I am OK in principle if a future version of Git, when used by a new
> > > user of Git who does not have any custom configuration, wrote a
> > > string other than 'master' in .git/HEAD when "git init" is run.
> > >
> > > Picking a good replacement word to mean the primary branch is
> > > tricky, though.  Just having a notion that one is special among
> > > many (i.e. the primary-ness of the thing being named with a word
> > > that will replace 'master') may already be offending to some folks.
> >
> > I find this response not satisfactory:
>
>   ... snip ...
>
> "I can't breathe ... I can't breathe ..."
>
> "Well, tell you what, what if we rename the initial default branch in
> a distributed version control system for you?"
>
>   *Now* do you understand how asinine all this sounds?
>
> rday
