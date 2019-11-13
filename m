Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DC4B1F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 11:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbfKMLPo (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 06:15:44 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:43051 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbfKMLPn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 06:15:43 -0500
Received: by mail-wr1-f46.google.com with SMTP id n1so1861145wra.10
        for <git@vger.kernel.org>; Wed, 13 Nov 2019 03:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zsve41RrVDfzIzCwLtwJRMnBKUkivKGxOKJobdPp6nU=;
        b=DgAghE0FT27DDwrrTsYgh8UPtkugNyRDelovZE+f036klSsHnugZ/zhFvPOiuhfpGu
         UmFXksi4b/9Vx32vKAmbfGcfg/WX+oU+iPp3QuMWlpO1h4zJ3/PNOXd1rlo2tj8IdqJv
         QICwahWzxiTbMKAcnjz+yuoJBUhfeyiNao9DuiksqaCSm4Hs3/iYEXMArlGcWKKqddlT
         qRx0f0t4nvlmyKIkS8rPETAZXmBMZ7VaIbEp2CvKEUCJkuCrij5RYIpnI9z5mz3uC0l7
         1M3eEJK6bXE7SjMBg7/M28h0WGqfoNZ/l5fawnDQKcTHGPhbhYyYZhR4DCVYkXJyysRZ
         cQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zsve41RrVDfzIzCwLtwJRMnBKUkivKGxOKJobdPp6nU=;
        b=OIo7PvyM9Tjv04eIZNE0rJQRjWpuIUvxtoZZy3LMbFqy+Z8fbSHneswzYV29jgbWxV
         rhg6l8C1nlhOl956o4StfE3cS7So6ePvvRYs0knpNqWN6fSwbTqGiD77EEsvDglU+CRl
         5IQGiW98GsIL8aqfClh2VwS2PsVypF3sMGX6M4fCDJ6GEapPKqciX+yETEm200CiggwS
         /oeWPAMhnLxH6EdC4j0KlfFmeMUld+nqrG2NgFWoXrUCCAgOD1n45nZZ+m63PnNmFYId
         Dfv7/nFXFGxXIJrjUSsFeve3EnVWIwsAWm+bHjHm4qcMN2NouafABbUNqU0liBHlIAK9
         i7Vg==
X-Gm-Message-State: APjAAAVNSe6ZRT76pR6p0LMKoO/RsJdItku73BHZWXEa6OBmYJB81eMB
        dsXVrz0uN0wbdl3Mt/47OQU=
X-Google-Smtp-Source: APXvYqwfj6Ip6KcUaMwW62dAH2+Q1H6BIPcC9vrpLCeCkonPakaDAdjKwGedDcE9L12+Ivc4T5LOMA==
X-Received: by 2002:adf:b199:: with SMTP id q25mr2421643wra.320.1573643741468;
        Wed, 13 Nov 2019 03:15:41 -0800 (PST)
Received: from localhost ([62.253.227.125])
        by smtp.gmail.com with ESMTPSA id f24sm1826306wmb.37.2019.11.13.03.15.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Nov 2019 03:15:40 -0800 (PST)
Date:   Wed, 13 Nov 2019 11:15:39 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Grzegorz Rajchman <rayman17@gmail.com>, git@vger.kernel.org
Subject: Re: [BUG] git stash pop --quiet deletes files in git 2.24.0
Message-ID: <20191113111539.GA3047@cat>
References: <CAMcnqp22tEFva4vYHYLzY83JqDHGzDbDGoUod21Dhtnvv=h_Pg@mail.gmail.com>
 <20191107184912.GA3115@cat>
 <xmqq7e4bp06l.fsf@gitster-ct.c.googlers.com>
 <20191108165929.GB3115@cat>
 <xmqqk188l0pn.fsf@gitster-ct.c.googlers.com>
 <20191111195641.GC3115@cat>
 <xmqqftitfz5u.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqftitfz5u.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/12, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> >> > From what you are saying above, and from my testing I think this
> >> > refresh is actually unnecessary, and we could just remove it outright.
> >> 
> >> Perhaps.  But later it will bite us when somebody wants to rewrite
> >> the "status at the end" part in C.
> >
> > Hmm, wouldn't the not re-reading the index part bite us there, rather
> > than the not refreshing the index?
> 
> Yes.  Just removing the refresh-and-write that caused us to write
> out incorrect data would "fix" the bug, while leaving the bug of not
> re-reading to bite us later.
> 
> > Below is the patch that I believe has the least chances of biting us
> > in the future, with the appropriate updated tests.  I had considered
> > leaving the 'refresh_and_write_cache()' call there, but as I was
> > writing the commit message I had a harder and harder time justifying
> > that, so it's gone now, which I think is the right thing to do.
> > Leaving it there would be okay as well, however I don't think it would
> > have any benefit.
> >
> > --- >8 ---
> > Subject: [PATCH] stash: make sure we have a valid index before writing it
> >
> > In 'do_apply_stash()' we refresh the index in the end.  Since
> > 34933d0eff ("stash: make sure to write refreshed cache", 2019-09-11),
> > we also write that refreshed index when --quiet is given to 'git stash
> > apply'.
> >
> > However if '--index' is not given to 'git stash apply', we also
> > discard the index in the else clause just before.  This leads to
> > writing the discarded index, which means we essentially write an empty
> > index file.  This is obviously not correct, or the behaviour the user
> > wanted.  We should not modify the users index without being asked to
> > do so.
> >
> > Make sure to re-read the index after discarding the current in-core
> > index, to avoid dealing with outdated information.
> 
> Yup.  The "!has_index" codepath calls update_index() that turns the
> on-disk index into the desired shape (would it help explaining that
> in the previous paragraph, by the way?) so all we need to do is to
> read it back into core.  Makes sense.

Will add some more explanation about that.

> > We could also drop the 'discard_cache()' + 'read_cache()', however
> > that would make it easy to fall into the same trap as 34933d0eff did,
> > so it's better to avoid that.
> 
> This is the discarded alternative of the main fix we saw earlier.
> Perhaps it may make the flow of thought easier to follow if we moved
> it up before talking about "refresh-and-write can be thrown away"?

Thanks, will move.

> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> >  builtin/stash.c  | 6 ++----
> >  t/t3903-stash.sh | 5 ++++-
> >  2 files changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/builtin/stash.c b/builtin/stash.c
> > index ab30d1e920..d00567285f 100644
> > --- a/builtin/stash.c
> > +++ b/builtin/stash.c
> > @@ -482,12 +482,10 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
> >  			return -1;
> >  
> >  		discard_cache();
> > +		read_cache();
> 
> A comment
> 
>     /* read back the result of update_index() back from the disk */
> 
> before discard_cache() may be warranted?

Yeah that makes sense, will add.

> >  	}
> >  
> > -	if (quiet) {
> > -		if (refresh_and_write_cache(REFRESH_QUIET, 0, 0))
> > -			warning("could not refresh index");
> > -	} else {
> 
> OK.
> 
> > +	if (!quiet) {
> >  		struct child_process cp = CHILD_PROCESS_INIT;
> >  
> >  		/*
> > diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> > index 392954d6dd..b1c973e3d9 100755
> > --- a/t/t3903-stash.sh
> > +++ b/t/t3903-stash.sh
> > @@ -232,8 +232,9 @@ test_expect_success 'save -q is quiet' '
> >  	test_must_be_empty output.out
> >  '
> >  
> > -test_expect_success 'pop -q is quiet' '
> > +test_expect_success 'pop -q works and is quiet' '
> >  	git stash pop -q >output.out 2>&1 &&
> > +	test bar = "$(git show :file)" &&
> 
> Ah, this is to ensure that we didn't lose the "file" from the index?
> 
> Denton is on the quest of removing "$(git command substitution)"
> used in a way that might hide the error from git invocation in a
> separate thread [*1*].  This may want to become
> 
> 	git rev-parse --verify :file &&
> 
> or
> 
> 	git show :file >actual && echo bar >expect &&
> 	test_cmp expect actual &&
> 
> perhaps?

Hmm I just copy-pasted this from somewhere else in this test file.
I'll add a preparatory patch getting rid of "$(git command substitution)"
as I don't believe Denton got to t3903 yet.

There's some more opportunities for modernization of this test file,
but I refrained from doing that to not blow up this bug fix series too
much.

> >  	test_must_be_empty output.out
> >  '
> >  
> > @@ -242,6 +243,8 @@ test_expect_success 'pop -q --index works and is quiet' '
> >  	git add file &&
> >  	git stash save --quiet &&
> >  	git stash pop -q --index >output.out 2>&1 &&
> > +	git diff-files file2 >file2.diff &&
> > +	test_must_be_empty file2.diff &&
> >  	test foo = "$(git show :file)" &&
> >  	test_must_be_empty output.out
> >  '
> 
> Dittto.
> 
> Thanks.
> 
> 
> [Reference]
> 
> *1* <2f9052fd94ebb6fe93ea6fe2e7cd3c717635c822.1573517561.git.liu.denton@gmail.com>
> 
> Note that "var=$(git subcmd)" is special and will signal us a failure
> of the git invocation.
