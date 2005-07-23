From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [PATCH 1/1] Tell vim the textwidth is 75.
Date: Sat, 23 Jul 2005 11:27:31 +0100
Message-ID: <1122114452.6863.72.camel@localhost.localdomain>
References: <20050721202309.8216.19338.stgit@h164.c77.b0.tor.eicat.ca>
	 <7v3bq71rmb.fsf@assigned-by-dhcp.cox.net> <tnx1x5ryvn2.fsf@arm.com>
	 <20050722192424.GB8556@mars.ravnborg.org>
	 <7vy87yr2xh.fsf@assigned-by-dhcp.cox.net>
	 <1122068634.7042.35.camel@localhost.localdomain>
	 <7vu0imh23q.fsf@assigned-by-dhcp.cox.net>
	 <1122108098.6863.38.camel@localhost.localdomain>
	 <20050723093035.GB11814@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Bryan larsen <bryanlarsen@yahoo.com>,
	Sam Ravnborg <sam@ravnborg.org>
X-From: git-owner@vger.kernel.org Sat Jul 23 12:28:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwHEb-0004Ur-4T
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 12:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbVGWK1o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jul 2005 06:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbVGWK1o
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jul 2005 06:27:44 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:1376 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S261668AbVGWK1e (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2005 06:27:34 -0400
Received: from aamta11-winn.ispmail.ntl.com ([81.103.221.35])
          by mta08-winn.ispmail.ntl.com with ESMTP
          id <20050723102733.GEZK889.mta08-winn.ispmail.ntl.com@aamta11-winn.ispmail.ntl.com>;
          Sat, 23 Jul 2005 11:27:33 +0100
Received: from cpc1-cmbg5-3-0-cust179.cmbg.cable.ntl.com ([81.104.192.179])
          by aamta11-winn.ispmail.ntl.com with ESMTP
          id <20050723102733.JIQV24042.aamta11-winn.ispmail.ntl.com@cpc1-cmbg5-3-0-cust179.cmbg.cable.ntl.com>;
          Sat, 23 Jul 2005 11:27:33 +0100
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050723093035.GB11814@pasky.ji.cz>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 2005-07-23 at 11:30 +0200, Petr Baudis wrote:
> Dear diary, on Sat, Jul 23, 2005 at 10:41:38AM CEST, I got a letter
> where Catalin Marinas <catalin.marinas@gmail.com> told me that...
> > The problem appears when one upstream maintainer changes the
> > configuration, should this be merged again? In this case you can get
> > conflicts.
> 
> So you resolve them...? If the upstream keeps doing changes frequent
> enough and large-scale enough to this becoming annoying, something is
> wrong. :-)

OK, that's fine with me (but see below).

> > That's OK with one issue - git should be able to exclude _git when
> > generating a diff between 2 trees, unless one can enforce the _git/*
> > files to be read-only.
> 
> Why? I think those meta-information is important too, and if it differs,
> I want to see it in the diff. Oh, now I see what you mean - to
> optionally exclude it. That would be nice, having --exclude in
> common diff options.

That's useful when generating patches.

The other problem is that the upstream maintainer might not be
interested in my own settings but they would be pulled together with the
normal data.

> > Another option would be to have .git/info/<branch> and, with cogito for
> > example, .git/info/origin should always be pulled, even if the local
> > files were modified. You would override these settings
> > in .git/info/master. The problem is to define the branches order in
> > which the settings are read.
> 
> Yes, and you may be pulling from multiple branches. I would keep
> .git/info simple and single-instanced. If you want your stuff to
> propagate to others, put it to .gitinfo/.

Yes, my idea complicates things quite a lot.

> > This could be avoided by using ini-like files (well, easy to read in
> > Python) and have [git] (for the common things like author name),
> > [cogito], [stgit] etc. sections.
> 
> Now if it is going to look like this, I think separate files would be
> much more practical, more effective and likely simpler for the user as
> well. For Cogito-specific stuff, the user can well dive into
> Cogito-specific configuration files, I think. (Well, there's none now;
> there is .cgrc but that only contains default options for Cogito
> commands and will stay so; I plan ~/.cg/cogito.conf or something.
> Actually, perhaps the Git configuration file should be ~/.git/git.conf -
> it looks cool, doesn't it?)

Or we could have ~/.git/git.conf, ~/.git/cogito.conf and
~/.git/stgit.conf, under the same directory.

> > The problem is how much similar we want the Porcelains to be regarding
> > the settings and the templates. For StGIT, it is much simpler to have
> > something like '%(FILELIST)s' rather than '@FILELIST@' in a template but
> > I have not problem with switching to a common syntax. But we should see
> > what can easily be changed.
> 
> I chose @FILELIST@ only since it is a common convention to have this as
> rewrite placeholders, and I think it's more visually clear than
> %(FILELIST). Were you insisting on the second syntax, I wouldn't have
> %any problem switching, though. Cogito does no @@ rewriting yet.

It's true that @...@ is a common convention and is much clearer. I chose
my syntax since it was easier to format the strings in Python. If we go
for a common template, I would prefer the @...@ one (and do a regexp
replace in Python instead of the string formatting).

> Agreed. What Cogito uses:
> 
> 	.git/author	Default author information in format
> 				Person Name <email@addy>

What about .git/committer? This is useful if I do a commit at work and I
want the repository to have my gmail address.

> 	.git/branch-name
> 			Symbolic name of the branch of this repository.

Isn't this the same as $(readlink .git/HEAD), with some trimming?

> 	.git/commit-template
> 			Commit template to use in the commit editor
> 			instead of some short header (most of it is
> 			still hardcoded).

OK

> 	.git/exclude	--exclude-from for git-ls-files
> 			I want to rename this to .git/ignore

OK, either name is fine with me.

> 	.git/hooks/commit-post
> 	.git/hooks/merge-pre
> 	.git/hooks/merge-post

OK, though StGIT doesn't use any at the moment.

Now, the StGIT files (.git means $GIT_DIR):

      * /etc/stgitrc, ~/.stgitrc, .git/stgitrc - configuration files
        (the latter overrides the former). The syntax is similar to the
        ini files
      * .git/patches/ - directory containing the patch information. I
        won't go into details here since this is only used by StGIT
      * .git/exclude - for the files to be ignored by the 'status'
        command
      * .git/conflicts - includes the list of files conflicting after a
        merge operation. The user should run 'stg resolved --all' to
        mark the conflicts as resolved and remove this file
      * .git/branches/ - the same meaning as in cogito, only that
        'master' is considered a branch and 'stg pull' doesn't use
        'origin'
      * .git/patchdescr.tmpl - the same idea as commit-template, used
        when creating the first description for a patch
      * .git/patchexport.tmpl - template used when exporting the patches
        in a series
      * .git/patchmail.tmpl - template used for sending patches by
        e-mail

-- 
Catalin
