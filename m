Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2F6C433EF
	for <git@archiver.kernel.org>; Tue, 10 May 2022 02:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234935AbiEJCqn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 22:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234895AbiEJCqm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 22:46:42 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608492817B5
        for <git@vger.kernel.org>; Mon,  9 May 2022 19:42:46 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id cx11-20020a17090afd8b00b001d9fe5965b3so884031pjb.3
        for <git@vger.kernel.org>; Mon, 09 May 2022 19:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1KTW9OKcW/6S9EoN72me93fOo5VrSUz3iSGIARIECC4=;
        b=qmBRzGqO+BgqnwuH1HC1inpc02xWa1LOIW1kz2SHF8ukKQGv5VcMfTvtCHHMnDNEOA
         3hwKJE4UFF1EfAz22uGdEHEOefN1y+OONrDL0MqXgfQM7Z7A03HiYtIXe24Ijmw+bUef
         8p9o7XxtMefemqkPij5ZmMbUXm639qLltJe4CCe+WHMarm1CQLna3iUbD0f3ratAYXY1
         AkeExp9qjyIrhOQms4uwtRMFpzxQm4dTvntMnDKK3h/e+QgrevKBz4D9cRWDu5Hj50Jp
         BO/cceRZaLw9AuVzNlSbDvcWCX1HHUOulUyCXQ1QzyitYFsQ0ESU95fb4y1g5NoNzerD
         P+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1KTW9OKcW/6S9EoN72me93fOo5VrSUz3iSGIARIECC4=;
        b=gOIxUocUUe499sX98e39reHHAejX0RWu0SOjNRo1g2aS76jQWatL6Wr4EJq4GrME+d
         QYZPVzt43GWlZjqOBOnPnqVJj44vbnwCoDgdTOQ325Zx1WK5HLVV2zKTYddJljhUGNDc
         NNRYGleGoPW8y0rOa7/9svjzwMi59o14NTEE0itao1FE/SLp+U3iEapBiLdQUm1rrfWc
         j/KHRrDxEANfNUgV4p5f3guDPBPcX0FXvYJHMkoTzIK63SfNRPsM1hLHyE4w9H1r+h8G
         urRaNwUoba8+d/Ru6DKp683EKyU0WneJ65KUxbngTip00UssxYs6RI2d6GEhPfjMLJWx
         2qDA==
X-Gm-Message-State: AOAM532dDpAZizOU62S/1MJorTfULTbrFG5Z6c0IJ5gYe71rcuV495uc
        OejkYBmb8huKLAIzmXbVUomNXEBs8Gk=
X-Google-Smtp-Source: ABdhPJwGDmTb2W3z4nf2odGp+iAf5T/yBBPMpnIPAS0Sjprn86TSCIwnDr0rvwVHoQFYIMU6f02L4Q==
X-Received: by 2002:a17:902:b90b:b0:15f:bd0:18b5 with SMTP id bf11-20020a170902b90b00b0015f0bd018b5mr9129901plb.97.1652150565370;
        Mon, 09 May 2022 19:42:45 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:1348:7167:3ccb:351d])
        by smtp.gmail.com with ESMTPSA id i13-20020a170902eb4d00b0015e8d4eb1f7sm638530pli.65.2022.05.09.19.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 19:42:44 -0700 (PDT)
Date:   Mon, 9 May 2022 19:42:42 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Timo Funke <timoses@msn.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Weird behaviour of git diff-index in container
Message-ID: <YnnRIq3kudurSq4c@google.com>
References: <VI1PR0402MB28779C7A41783472B2EF6823BFC69@VI1PR0402MB2877.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR0402MB28779C7A41783472B2EF6823BFC69@VI1PR0402MB2877.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

Timo Funke wrote:

> podman run --rm -it -v `pwd`:/git:z --entrypoint sh docker.io/alpine
> > container# apk add git
> > container# cd /git
> > container# git diff-index --quiet HEAD -- ; echo $?
> 1
> > container# git diff-index --quiet HEAD -- ; echo $?
> 1
> > container# git status
> On branch master
> nothing to commit, working tree clean
> > container# git diff-index --quiet HEAD -- ; echo $?
> 0
>
>
> What did you expect to happen? (Expected behavior)
> `git diff-index --quiet HEAD -- ; echo $?` should return `0`
> even without executing `git status`.
>
> What happened instead? (Actual behavior)
> Without executing `git status` `git diff-index --quiet HEAD -- ; echo $?`
> will repeatedly print `1`.
>
> What's different between what you expected and what actually happened?
> It is odd that `git diff-index --quiet HEAD -- ; echo $?` prints
> different results depending on whether `git status` was executed.

I love this example.  Thanks for writing.

I checked "git help diff-index" to see whether it describes this
pitfall, and I didn't see an explanation.  So at the very least you
have uncovered a documentation bug.

The difference between diff-index and status here is a difference
between "porcelain" (user-facing) commands and "plumbing"
(script-facing) commands.  In Git's index file there is stat(2)
information for each file; if that stat(2) information matches the
corresponding file in the working directory then we know it hasn't
been modified relative to what is in the index.  If the stat(2)
information differs from the working copy, on the other hand, the
behavior depends on whether the command being run is porcelain or
plumbing:

 - plumbing commands assume that the script author has run "git
   update-index --refresh -q" first to update the stat(2) information
   if the file hasn't changed.  This allows efficient scripts to
   refresh the index once and then run multiple commands that rely on
   the result of that:

	git update-index --refresh -q || :
	for rev in "${revs[@]}"
	do
		if git diff-index --quiet "$rev" --
		then
			... do something ...
		fi
	done

 - porcelain commands such as "git status" implicitly refresh the
   index before doing anything else.  This allows them to produce the
   expected result even if the repository is a copy made using "cp -a"
   or has been transferred across machines on a USB stick.

Some places I expected to find an explanation of this:

- documentation for the "git diff-index" command ("git help
  diff-index").  It does not mention this behavior.

- documentation for the "git diff" command ("git help diff").  It also
  doesn't mention this.  That's particularly surprising because it
  would be a great place to document the diff.autoRefreshIndex setting
  that affects this behavior of the "git diff" command (described in
  Documentation/config/diff.txt).

- the Git user manual (Documentation/user-manual.txt).  It describes
  "git update-index --refresh" but very briefly.  It doesn't describe
  the above scripting pattern.

- Git's command-line conventions ("git help cli").  No mention.

- overview of plumbing and porcelain commands ("man git").  No
  mention.

- the Git scripting manual ("git help core-tutorial").  It describes
  "git update-index --refresh" after a "cp -a" but not its use in
  scripts.

- the history of Git's contrib/examples/.  This contains many examples
  of the above scripting pattern but is not very discoverable.

So there are many opportunities for someone to document this better.
If you'd be interested in pursuing that, I'd be happy to provide some
pointers.

Thanks,
Jonathan
