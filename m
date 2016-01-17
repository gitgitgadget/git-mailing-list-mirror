From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 4/4] ls-remote: add support for showing symrefs
Date: Sun, 17 Jan 2016 18:38:22 +0100
Message-ID: <20160117173822.GE7100@hank>
References: <1453028643-13978-1-git-send-email-t.gummerer@gmail.com>
 <1453028643-13978-6-git-send-email-t.gummerer@gmail.com>
 <20160117151510.GC15519@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bturner@atlassian.com, gitster@pobox.com, pedrorijo91@gmail.com,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 17 18:38:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKrH7-0007uk-Jo
	for gcvg-git-2@plane.gmane.org; Sun, 17 Jan 2016 18:38:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbcAQRh5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2016 12:37:57 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36318 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320AbcAQRh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2016 12:37:56 -0500
Received: by mail-wm0-f67.google.com with SMTP id l65so12331352wmf.3
        for <git@vger.kernel.org>; Sun, 17 Jan 2016 09:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=fzEVMkrKN66oqySF1CT6vxJ/8vUOVySpSinX/1BiyJw=;
        b=X4lYy87U3LKi8Sf58iOW8e+NC38RvYYtPEn9T9zrVaq87Ku8LTCJnsNDlU9vz2Kzte
         44Dm31bLo9CL07evNrKY8Bi6VuCgru0uMwjntuQ9ZfsLOLPBxA3Y1TXPayA29Sjlx5VS
         WEQxt8EcODALHX36UO1NJfHiLIY46MtvI0j286eFdMszPSJcr8CerexpXKoz9Qih+sFM
         kLbz9TEokvG8p+BWRs+qgLhJ30SvP8jsVBhCTd12v2xmWrivSWdn0vv8EFOfipuZsoBz
         fPEmyazFQvGNA/QYvoLg8Lelnc0fWJczLXx7IvUqJamiHAIndI0lrDym2aSol0wsfxVy
         DfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=fzEVMkrKN66oqySF1CT6vxJ/8vUOVySpSinX/1BiyJw=;
        b=hOX82vBY9Oq9Nq/+Xu+Nz0f+s0n+ZsqJvgE51J/cgdfVCtvCAD7niNQq48GvH+RYJb
         5TaPkJT0BrU3WFcd7IrL4ABS7fRtj0OeNjWpoGJNtt8Zu7YyB7LgwudXuU9WiECQBOFz
         7exQLPq0Fs2J7389n+kD5b4qRQ02ZPALykpg56g27KO4FHsTr4vKaZcVCnr7Sy4gpdWc
         vVP0RLNfvZ+d37kenL5LlPt1UjxlJ5qtx54zJQF6is33T0rfJX2Qv7UqhxOrAhI6AfHr
         0de6u/2FsbHy6HBRJIuAYVpQxYnAWyOh0dKdjNSsMCq/AJhmSmmzj3yffa35pZnggrC+
         U05A==
X-Gm-Message-State: AG10YOTRS3wrLGQueX0ZwA5gO9OkAwbSiVW6fncqaRJ/Ys5DpBLbONmi+9dnkSIYWldI7Q==
X-Received: by 10.28.228.87 with SMTP id b84mr9508405wmh.36.1453052275232;
        Sun, 17 Jan 2016 09:37:55 -0800 (PST)
Received: from localhost ([95.233.44.41])
        by smtp.gmail.com with ESMTPSA id c185sm12024207wma.5.2016.01.17.09.37.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jan 2016 09:37:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160117151510.GC15519@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284263>

On 01/17, Jeff King wrote:
> On Sun, Jan 17, 2016 at 12:04:03PM +0100, Thomas Gummerer wrote:
>
> > Sometimes it's useful to know the main branch of a git repository
> > without actually downloading the repository.  This can be done by
> > looking at the symrefs stored in the remote repository.  Currently git
> > doesn't provide a simple way to show the symrefs stored on the remote
> > repository, even though the information is available.  Add a --symrefs
> > command line argument to the ls-remote command, which shows the symrefs
> > on the remote repository.
> >
> > The new argument works similar to the --heads and --tags arguments.
> > When only --symrefs is given, only the symrefs are shown.  It can
> > however be combined with the --refs, --heads or --tags arguments, to
> > show all refs, heads, or tags as well.
>
> I would have expected --symrefs to be "also show symref destinations for
> refs we are showing" and not otherwise affect the set of refs we pick.
> That would make:
>
>   git ls-remote --symrefs
>
> show everything, including symrefs and peeled tags (which I think is not
> possible with your patch). It would also make:
>
>   git ls-remote --symrefs --heads
>
> show symrefs and refs in refs/heads, but _not_ show symrefs outside
> of refs/heads.
>
> On the flip side, though, it does not provide a way to just get the
> symrefs without any other output.

That's why I decided to implement it this way.  However I think the
below makes sense, so I'll change the behavior in the re-roll.  In
case we really want to have only symrefs we could still introduce
something like --symrefs-only, though I'm doubtful we'll need that.

> But I think if you just want a specific
> symref (say, HEAD), you can ask for it:
>
>   git ls-remote --symrefs $remote HEAD
>
> This is all somewhat moot, perhaps, as the server side currently only
> shares symref information for HEAD. But that may change in the future
> (it's a limitation of the current protocol).
>
> I'm also somewhat doubtful that people regularly use ls-remote much at
> all these days, let alone with "--heads" or "--tags". So it's hard to
> come up with concrete use cases for any of this. The above is just what
> I would expect for general flexibility and consistency with other
> commands.
>
> > ---
> >  Documentation/git-ls-remote.txt |  8 +++++++-
> >  builtin/ls-remote.c             |  9 ++++++++-
> >  t/t5512-ls-remote.sh            | 20 ++++++++++++++++++++
>
> Documentation _and_ tests. Yay. :)
>
> > @@ -98,6 +101,10 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
> >  	if (!dest && !quiet)
> >  		fprintf(stderr, "From %s\n", *remote->url);
> >  	for ( ; ref; ref = ref->next) {
> > +		if (symrefs && ref->symref)
> > +			printf("symref: %s	%s\n", ref->symref, ref->name);
>
> I assume that's a raw tab in the string. Please use "\t", which makes it
> more obvious to readers what is going on.

Thanks, will change.

> Since this output is only triggered by a new option, we're not
> constrained by compatibility in the output. But I think it's still a
> good idea to keep the general "<content>\t<refname>" pattern set by the
> other lines, as you did.
>
> Here's my obligatory bikeshedding for the format. Feel free to ignore.
>
> I wondered if just:
>
>   refs/heads/master       HEAD
>   1bd44cb9d13204b0fe1958db0082f5028a16eb3a       refs/heads/master
>
> would look nicer. It is technically ambiguous if a symref can point to a
> 40-hex refname. They generally will start with refs/, but I'm not sure
> that is strict requirement. It also makes it harder to add other output
> later if we choose to. So some kind of keyword like "symref:" is a good
> idea.
>
> We could also do it as:
>
>   ref: refs/heads/master     HEAD
>
> which matches the symref format itself. I guess that doesn't really
> matter here, but somehow it seems more aesthetically pleasing to me.

I like this format the most so far, so unless I hear any objections
I'll do this.

> The output would look a lot nicer for humans if we right-padded the
> symref destination to match the 40-hex that is on all the other lines
> (so all of the refnames line up).  But that makes machine-parsing a lot
> harder. We could do something clever with isatty(1), but I don't think
> it's worth the effort.
>
> > +test_expect_success 'ls-remote with symrefs and refs combined' '
> > +	cat >expect <<-EOF &&
> > +	symref: refs/heads/master	HEAD
> > +	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/master
> > +	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/remotes/origin/HEAD
> > +	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/remotes/origin/master
> > +	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/tags/mark
> > +	EOF
>
> I expected there to be a:
>
>   1bd44cb9d13204b0fe1958db0082f5028a16eb3a	HEAD
>
> line. It's technically redundant, since the caller can dereference
> refs/heads/master themselves, but it potentially makes things easier for
> a caller. I realized why it isn't here, though. We print all symrefs,
> regardless of whether they match the flags, but "HEAD" doesn't match
> "--refs", so we don't show its value.  Under the semantics I proposed
> above, "ls-remote --symrefs" would show both.
>
> -Peff

--
Thomas
