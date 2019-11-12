Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59C191F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 18:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfKLSp4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 13:45:56 -0500
Received: from mail-pf1-f178.google.com ([209.85.210.178]:43057 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfKLSp4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 13:45:56 -0500
Received: by mail-pf1-f178.google.com with SMTP id 3so13959223pfb.10
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 10:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bCTUOXEo8bv0z5hxOFeRy4wLtL5IbbpLLFaQxPnp2jY=;
        b=uqVjnEWHeqHeOpIOTAswjUP1TTN9R2LSJ1FBpkFia0YFxZKO1ka8sTWMX5cy1eLn8S
         VwsfYxjpjkn8BcZFlTPWs+6GNfnSg9yZ9G0simInpPeJngAygEuN3sx2YBITlAKJtd9v
         Dc6vg0srqg12xIpolT6UNQCQcDCT5UzRoANrzwoqKrgeYXqFdDF1YLlbvsPG73ph0ksU
         yUHxLSo3S6RKwP7+tWZb3fYB8yw8oStCvyUHoWePSLSiPjsYu5u+PgwYsFp3C2F98qUg
         bGScySxjNOE55OWCcFPPVenrjWHC/Y1fAe4/JicujtBMyUR9mkzeP/VgZDDf7SHRC87i
         5MmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bCTUOXEo8bv0z5hxOFeRy4wLtL5IbbpLLFaQxPnp2jY=;
        b=dErQMdvM+h2gr+sPJndbAEwTDCzeHIMQ3OFUrBA5BM6dGcGfI5liN9xa0bz5m5G7ir
         ZrXDi5zAYvZQjvOI4FcY8wKbj2iuZwU7FD8XaqyM04jtsm52WiFHSRAZAUg7yNCXcyi6
         L7s5B4k25d8OBcHgmuzQHyuTR7Jl5ckY/eafEov1Bmeco7JjFktxdvMRhf6NuUwpiv8o
         jPh8ET1vz7c88Nxe78Nsz8WWGTpfPXE7ipljVNDJPco5MoB5NJLHPGGbm1HHoHo6Iu7s
         REr8vaRdhtqIpwrCmJ3sW5EBXtNqgkSxIr10IziHtBd21SpqC+Z7x04Y90xy0HTlPH5e
         JWag==
X-Gm-Message-State: APjAAAXp4fKLQHbyMUYhlN3tr5Xx0qeSHqi0cXKOvE76OgYJ6k4jHaWz
        ZiR2XfAVHt5eYm0drwSPI2Mlyg==
X-Google-Smtp-Source: APXvYqw/NT2GefAuFATLejiYWCAZMgf737jLkM6jlQi2kW0xX99rYh5FfvnR/9k8SFfqcVGwiKBF8Q==
X-Received: by 2002:a17:90a:bcf:: with SMTP id x15mr8835798pjd.0.1573584352603;
        Tue, 12 Nov 2019 10:45:52 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id t15sm21350495pgb.0.2019.11.12.10.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 10:45:51 -0800 (PST)
Date:   Tue, 12 Nov 2019 10:45:47 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "gitster@pobox.com" <gitster@pobox.com>, garimasigit@gmail.com
Subject: Re: [DISCUSSION] Growing the Git community
Message-ID: <20191112184547.GA38770@google.com>
References: <71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com>
 <CABPp-BFXs4qes20S+9AZd++p3epW4eJ7Vu7zU_PdDysZ_D-yrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BFXs4qes20S+9AZd++p3epW4eJ7Vu7zU_PdDysZ_D-yrg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 19, 2019 at 03:21:08PM -0700, Elijah Newren wrote:
> On Thu, Sep 19, 2019 at 11:37 AM Derrick Stolee <stolee@gmail.com> wrote:
> > 3. Introduce a new "mentors" mailing list
> >
> > From personal experience, all new contributors at Microsoft (after Jeff
> > Hostetler at least) have first had their patches reviewed privately by
> > the team before sending them upstream. Each time, the new contributor
> > gained confidence about the code and had help interpreting feedback from
> > the list.
> >
> > We want to make this kind of experience part of the open Git community.
> >
> > The idea discussed in the virtual summit was to create a new mailing
> > list (probably a Google group) of Git community members. The point of
> > the list is for a new contributor to safely say "I'm looking for a
> > mentor!" and the list can help pair them with a mentor. This must
> > include (a) who is available now? and (b) what area of the code are they
> > hoping to change?
> >
> > As evidence that this is a good idea, please see the recent research
> > paper ""We Don't Do That Here": How Collaborative Editing With Mentors
> > Improves Engagement in Social Q&A Communities" [1].
> >
> > [1] http://www.chrisparnin.me/pdf/chi18.pdf
> >
> > When asking your first question on Stack Overflow, this group added
> > a pop-up saying "Would you like someone to help you with this?". Then,
> > a mentor would assist crafting the best possible question to ensure
> > the asker got the best response possible.
> >
> > I believe this would work in our community, too. The action items
> > are:
> >
> > a. Create the mailing list and add people to the list.
> >
> > b. Add a pointer to the list in our documentation.
> >
> > Note: the people on the mentoring list do not need to be
> > "senior" community members. In fact, someone who more recently
> > joined the community has a more fresh perspective on the process.
> 
> Sounds useful for new contributors, _if_ there are enough volunteers
> with enough time.  I'm a little worried it might be initially staffed
> well and make a nice splash, but wane with time and possibly even to
> the point that it makes new contributors more jaded than if we didn't
> have such a list.  Hopefully my fears are unfounded, as it did sound
> at the conference like there might be a good number of volunteers, but
> I just wanted to voice the concern.  (And I feel bad, but I really
> don't know that I have the bandwidth to volunteer.)

I wanted to bump this thread. With the end of the Outreachy application
period we're left with at least a couple folks who are still interested
in learning how to contribute, even outside of the scope of the
Outreachy program. I'm still really interested in participating on a
mentors list like this; can we set one up?

To try and summarize what I remember from the summit:

 - It's lower pressure for the mentees if git@vger.kernel.org isn't CC'd
   on all git-mentoring@ emails
 - (But, if we did want to CC the main list, it'd be easy enough for
   people to filter out the mentoring emails if they don't care?)
 - We should advertise that list in the new contributor places:
    - CodingGuidelines or SubmittingPatches
    - mailing list welcome email
    - MyFirstContribution tutorial
    + (My own guess is that regularly CCing the main git list when
      appropriate - that is, when a question would be better posed to
      the whole community - would help advertise, too.)
 - The idea is less to match a single newbie with a single mentor (as
   folks are busy), and more to ask the same kind of questions one would
   usually ask a mentor and be responded to by whoever is available

> Another point that might help here:  New contributors might be
> surprised by the rigor of the code review process, and might assume
> they just aren't good enough to contribute.  It might be useful to
> countermand that subtle unspoken assumption by pointing out how much
> existing long-term contributors spend revising patches.  Personally,
> despite doing my best to think of issues and make sure to send in
> really high quality patches, I still generally expect to spend at
> least as much time after submitting patches revising them as I did in
> coming up with them originally, and I'm not surprised if the time is
> doubled.  And that's after contributing for years.  I don't generally
> experience reviews anywhere near as thorough in other communities.

I agree with this point. There's a lot to be said about the review
process in open source as compared to the review process "at home"
(internally at your job by people who sit next to you), and I'm not sure
where to say it in the context of the Git project. Maybe the
MyFirstContribution doc could use a blurb? Hmm.

 - Emily
