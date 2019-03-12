Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PLING_QUERY,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CA5920248
	for <e@80x24.org>; Tue, 12 Mar 2019 18:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfCLST0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 14:19:26 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:46282 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfCLSTZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 14:19:25 -0400
Received: by mail-io1-f54.google.com with SMTP id k21so2903712ior.13
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 11:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UJ934CHSKpwO2UWCEPOeLPVOZJZh1QmKAGH03zermE0=;
        b=I+irmR83brntbF+KfADtq6ilRDa2M1u0blE6KGXpUOWBfUizunzIOZlVS++eAchgq3
         TYC058lx7p8bTSQP+kV7u13jWdRm/rCI4KNbLpZYkcGUXhKYCzp7sMEL3ZptKJfa9Z3U
         BEzEqklZ4hJXOR5X4ew3aJlL9ZRalA4jmozfoTcpLl9Fk0eZ7wHVdX0IIb0qOf4A1Gpc
         slaDwEF2JuLoB8kIstn7BE6jS7JBmB5Rz4lLtjTrWRFRW/kT0YpaU0hoet+kHvpZ7Cwi
         B+eFso1JnygECPdxeZuPpVjZEft+CaLVttGIh8InH+U0+jrXLeNrZdzQKOWeLmSNEuKt
         2KwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UJ934CHSKpwO2UWCEPOeLPVOZJZh1QmKAGH03zermE0=;
        b=CfzRUTJtojG54//Wd+n2UZRkgCxp6N9QRwfGODKCSJb0I2yT5e9vUQblOEXcEwdoYV
         x3S6hofYfiN49S16Qnt73MOfVLXsmEnNqz7ALBfsh9gpyyrGWeQSHTbDsMC9YppvN3+h
         2RbqFcDr4t2OHkrDwKQOOTc85orUmi6zWWACjkc8bFV2+PIql/2YjVB2cBEkTeudOgha
         92wlhku1amnmeCLxA58uihbZO96Koxs63Gjz8pEzPMFqZMwao1/ktiWC+t2EJ770Pe2O
         0v5/caVbcGzP0qJf1cRR6VyQ67GcwPO5iAPlnS43EvUdnWwM0Lgc3XQoaSae4Um0+3B8
         LR9w==
X-Gm-Message-State: APjAAAV4cKs9T8nVQ5eoEkj7qrtUuiQq7cHF4PHXfEa82OdBBj3XZk0C
        Ickk+PVF50teviN6tz2X5KBEZ0ZRae+G6S7vw9WvSLaC
X-Google-Smtp-Source: APXvYqySo236Pmp0o5IvyfR7Uks8DSugIgo2zywktjk8PPDV9/6e5571jnZiJQLcbU1U3Onl3Tnjmmtr2X0Jn613OUg=
X-Received: by 2002:a6b:7103:: with SMTP id q3mr7923534iog.253.1552414764352;
 Tue, 12 Mar 2019 11:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LFD.2.21.1903121317020.16391@localhost.localdomain>
 <CAGyf7-F2wCB7D_JGzd7USaTV0YfmOuFG2Z6GkWVM-JqWKaagQA@mail.gmail.com> <alpine.LFD.2.21.1903121359480.17390@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.21.1903121359480.17390@localhost.localdomain>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Tue, 12 Mar 2019 11:19:13 -0700
Message-ID: <CAGyf7-FDLA7zZ9y3GyyVsF38hmm8E+-4+n8gAtmYnp4g7E7=Ug@mail.gmail.com>
Subject: Re: why does "git revert" commit even if i try to bail with ":q!"?
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 12, 2019 at 11:01 AM Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>
> On Tue, 12 Mar 2019, Bryan Turner wrote:
>
> > On Tue, Mar 12, 2019 at 10:23 AM Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> > >
> > >   never noticed this before ... when i do a regular "git commit" and
> > > enter my "vi" edit session and change my mind, i can bail with ":q!",
> > > regardless of what i've set up as a commit message, and i'll see:
> > >
> > >   Aborting commit due to empty commit message.
> > >
> > > however, i was just playing with "git revert" and, after i ran:
> > >
> > >   $ git revert <commit SHA>
> > >
> > >   again, simulating that i changed my mind, i just typed ":q!", but
> > > the revert went ahead, anyway. i tried again, this time completely
> > > deleting all the lines from the commit msg (as the template
> > > suggested), but the revert *still* completed after typing ":q!".
> > >
> > >   it was only after deleting all the lines and using ":wq" that the
> > > revert was cancelled:
> > >
> > >   Aborting commit due to empty commit message.
> > >
> > > that seems ... inconsistent. am i misunderstanding something?
> >
> > When you're doing a fresh commit, the .git/COMMIT_MSG is "empty". It
> > has whitespace and comments, but no _usable_ lines. So when you :q!,
> > the commit is aborted because nothing Git can use as a commit
> > message was saved to the file and so it's still "empty".
>
>   no, if i enter the commit edit session, type some _usable_ lines,
> then type ":q!", it *still* aborts the commit because of an empty
> commit message. try it and tell me if it behaves differently for you.

Sorry, perhaps I was unclear. Even if you _type_ something, unless you
:w it's not _written_. So using :q! at that point is the same as if
you typed nothing.

But if you type something, then :w, then _as a separate command_, do
:q!, the commit _will_ be done.

Is that more clear, I hope?
Bryan
