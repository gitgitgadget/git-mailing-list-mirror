Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0A401F404
	for <e@80x24.org>; Wed, 21 Mar 2018 21:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753650AbeCUVdK (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 17:33:10 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:34318 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753570AbeCUVdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 17:33:09 -0400
Received: by mail-wr0-f178.google.com with SMTP id o8so6662825wra.1
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 14:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3dt9Zl56AEPRBDfIISfTr5Vo5VzQ6te+j4dnoA2ngxE=;
        b=ZurCIVxA/G4r2C5isLo7q5yl7QgmFbhRpOehSpr3GpwINqUmm9xft0Pmu/nYyrlbl+
         NssPB9ncQeamj47dtYFfqyECBgp+DtFCv2wyoj7+W/SHYUKqWgNTNGZJ3rYBhVvm/wt0
         iDtgcNdPf7XfPa37m5eKbvX6X0qkIEn9NHjxdxGY6GeCFIh4zRhA3mcXpL53b7+2nRMe
         tNQXa63A5N3Wj1EK3tGav4Ob60Te66qMhbEtEtWph5n2u8bTawbWdjwIzZTJNrQG/VJm
         3RgqBUt0Sr46EXRlBMvOYrbryntjpfhjEyG80hm50yR83BMoA21yDLyT/F5UBfp79XTg
         +7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3dt9Zl56AEPRBDfIISfTr5Vo5VzQ6te+j4dnoA2ngxE=;
        b=axxBZ4uO99mBnKL5NzqiiLYU5dtT0/3IBQdoiIt7FysUYjrEUcXkL3FKHr7zmZsAWV
         irKEOm5XSvgILC5K+Ni+Uf3h3VJoHMsgQ5/5YsFsulp79ZDPUK8g9j6YO9wX1d2v0Yfr
         MEJzTGpMH+/fVBHre5iWsg92QMLPXlwQnY9xfbvdDwSlrpg2CMcuDXIO0+MRWqvFGx0X
         liQVR+dVVeTd63ZZs+cBn3JEawTG76+O7LjR3b8L1xkbIvfYbYu6yEHhvjEyDhUZmhrl
         oWUaEDquovd+DjQLYG9zeeBDqrya7glx+1XXqUi7npeVlJ2KeG5GfMrpKZ3tMrw/zGvl
         kVvw==
X-Gm-Message-State: AElRT7GeXcIO3WTg5i+JCuIMtRqz75j3+3zdh2lXCTwFPWeZV4MzNSxz
        qSmLfhKVRpCh0Lf5HXCLkK4=
X-Google-Smtp-Source: AG47ELsD6xtOmTxPGlddaGTu/AVyLszB3p6PiO3Qv/IaVkFmxaSMhXfVVQ0BjK1zrhKFACb4BZ4qzw==
X-Received: by 10.223.139.199 with SMTP id w7mr16459011wra.219.1521667987762;
        Wed, 21 Mar 2018 14:33:07 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id m62sm7468933wmc.25.2018.03.21.14.33.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Mar 2018 14:33:06 -0700 (PDT)
Date:   Wed, 21 Mar 2018 21:36:26 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Marc Strapetz <marc.strapetz@syntevo.com>
Subject: Re: [PATCH v5 2/3] stash push: avoid printing errors
Message-ID: <20180321213626.GG2224@hank>
References: <20180316223715.108044-1-gitster@pobox.com>
 <20180319232156.30916-1-t.gummerer@gmail.com>
 <20180319232156.30916-3-t.gummerer@gmail.com>
 <xmqqzi32sn5u.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzi32sn5u.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/20, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > ...
> > Fix this by avoiding the 'git clean' if a pathspec is given, and use the
> > pipeline that's used for pathspec mode to get rid of the untracked files
> > as well.
> 
> That made me wonder if we can get rid of 'git clean' altogether by
> pretending that we saw a pathspec '.' that match everything when no
> pathspec is given---that way we only have to worry about a single
> codepath.
> 
> But I guess doing it this way can minimize potential damage.  Those
> who do not use pathspec when running "git stash" won't be affected
> even if this change had some bugs ;-)

Heh yeah, we found enough bugs in this code so far, so it's probably
best to leave the part that's working alone at least for now.

> > diff --git a/git-stash.sh b/git-stash.sh
> > index 4c92ec931f..5e06f96da5 100755
> > --- a/git-stash.sh
> > +++ b/git-stash.sh
> > @@ -308,14 +308,16 @@ push_stash () {
> >  	if test -z "$patch_mode"
> >  	then
> >  		test "$untracked" = "all" && CLEAN_X_OPTION=-x || CLEAN_X_OPTION=
> > -		if test -n "$untracked"
> > +		if test -n "$untracked" && test $# = 0
> >  		then
> >  			git clean --force --quiet -d $CLEAN_X_OPTION -- "$@"

Argh I just noticed we could drop the "$@" here, as this is no longer
the pathspec case.  It doesn't hurt anything, except it may be a bit
confusing when reading the code.

Although if we end up implementing 'git checkout --index <pathspec>',
we'd have to add it back, but we do have a test covering this case, so
there's no worries about forgetting to add it back.

> >  		fi
> >  
> >  		if test $# != 0
> >  		then
> > -			git add -u -- "$@"
> > +			test -z "$untracked" && UPDATE_OPTION="-u" || UPDATE_OPTION=
> > +			test "$untracked" = "all" && FORCE_OPTION="--force" || FORCE_OPTION=
> > +			git add $UPDATE_OPTION $FORCE_OPTION -- "$@"
> >  			git diff-index -p --cached --binary HEAD -- "$@" |
> >  			git apply --index -R
> >  		else
> 
> Thanks, I'll take the change as-is.
> 
> I however wonder if we restructure the code to
> 
> 	if test $# = 0
> 	then
> 		# no pathspec
> 		if test -n "$untracked"
> 		then
> 			git clean --force --quiet -d $CLEAN_OPTION -- "$@"
> 		fi
> 		git reset --hard -q
> 	else
> 		test -z "$untracked" && UPDATE=-u || UPDATE=
> 		test "$untracked" = all && FORCE=--force || FORCE=
> 		git add $UPDATE $FORCE-- "$@"
> 		git diff-index -p --cached --binary HEAD -- "$@" |
> 		git apply --index -R
> 	fi
> 
> it becomes easier to understand what is going on.

I like that code structure more than what I have now.  I see you
already merged what I had to next, and I like keeping the change small
now that we're in the rc period (assuming you want to get this into
2.17?)  Maybe we can restructure the code as a separate cleanup once
2.17 is out, so this has more time to cook in master and hopefully
we'd notice regressions before the next release?

> That way, once we have a plumbing command to help the else clause of
> the above, i.e. "git checkout --index <tree-ish> -- <pathspec>"
> [*1*], then we can lose the if/then/else and rewrite the whole "we
> have created stash, so it's time to get rid of local modifications
> to the paths that match the pathspec" code to:
> 
> 	if test "$untracked"
> 	then
> 		git clean --force --quiet -d $CLEAN_OPTION -- "$@"
> 	fi
> 	git checkout --index HEAD -- "$@"

Yeah, this would be nice to have.  I wanted to have a look at what it
would take to implement 'git checkout --{cached,index}', but I'm not
familiar with the checkout code at all, so it will probably be a while
until I can get around to do it. 

> [Footnote]
> cf. https://public-inbox.org/git/xmqq4loqplou.fsf@gitster.mtv.corp.google.com/
> 
> What we want in the case in the code in question when there is
> pathspec is "match the index entries and the working tree files to
> those that appear in a given tree for paths that match the given
> pathspec".  This is close to "git checkout <tree-ish> -- <pathspec>"
> but not quite.  Current "git checkout <tree-ish> -- <pathspec>" is
> an overlay operation in that paths that match <pathspec> but do not
> exist in <tree-ish> are *NOT* removed from the working tree.  We
> obviously cannot change the behaviour of the command.
> 
> But we can add an option to ask for the new behaviour.  In general,
> for an operation that affects the index and the working tree, we can
> have "--cached" mode that affects only the index without touching
> the working tree, and "--index" mode that affects both.
> 
> "git reset <tree-ish> -- <pathspec>", which is a UI mistake, is
> better spelled "git checkout --cached <tree-ish> -- <pathspec>".  We
> take paths that match <pathspec> from <tree-ish> and stuff into the
> index, and remove entries from the index for paths that do not exist
> in <tree-ish>.  And if we extend that to "--index" mode, that is
> exactly what we want to happen.
