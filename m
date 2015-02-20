From: Jeff King <peff@peff.net>
Subject: Re: [RFH] GSoC 2015 application
Date: Thu, 19 Feb 2015 21:00:22 -0500
Message-ID: <20150220020022.GC16124@peff.net>
References: <20150218191417.GA7767@peff.net>
 <vpqzj8ary29.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Feb 20 04:00:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOdpP-00030l-FI
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 04:00:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752711AbbBTDA0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2015 22:00:26 -0500
Received: from cloud.peff.net ([50.56.180.127]:51330 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752018AbbBTDAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2015 22:00:25 -0500
Received: (qmail 26926 invoked by uid 102); 20 Feb 2015 03:00:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Feb 2015 21:00:25 -0600
Received: (qmail 5624 invoked by uid 107); 20 Feb 2015 02:00:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Feb 2015 21:00:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Feb 2015 21:00:22 -0500
Content-Disposition: inline
In-Reply-To: <vpqzj8ary29.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264129>

On Thu, Feb 19, 2015 at 11:32:46AM +0100, Matthieu Moy wrote:

> > I do need somebody to volunteer as backup admin. This doesn't need
> > to involve any specific commitment, but is mostly about what to do if I
> > get hit by a bus.
> 
> If you promise me to try hard not to be hit by a bus and no one else
> steps in, I can be the backup admin.

Thanks. I need you to register and create a profile at:

  https://www.google-melange.com/gsoc/homepage/google/gsoc2015

and tell me your username (the information from last year does not carry
forward automatically). Then I mark you as backup admin and (I think)
you have to then accept.

> Throwing out a few ideas for discussion, I can write something if people
> agree.
> 
> * "git bisect fixed/unfixed", to allow bisecting a fix instead of a
>   regression less painfully. There were already some proposed patches
>   ( https://git.wiki.kernel.org/index.php/SmallProjectsIdeas#git_bisect_fix.2Funfixed ),
>   so it shouldn't be too hard. Perhaps this item can be included in the
>   "git bisect --first-parent" idea (turning it into "git bisect
>   improvements").

That seems like a reasonable topic. I was about to say "but it's much
more complicated than fix/unfixed..." but it looks like that wiki entry
covers the past discussion (and reading and understanding that would be
a first step for the student). I agree it's probably smaller than a
full-summer project and can get lumped into the other bisect idea.

> * Be nicer to the user on tracked/untracked merge conflicts
> [...]

Sounds OK to me, though I agree the merging of untracked files is a
little controversial. There are also a lot of corner cases in
merge-recursive, and I think still some documented cases where we can
overwrite untracked files. Maybe a more encompassing project would be to
organize and dig into some of those corner cases.

>  SoC-2015-Microprojects.md | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)

Thanks, applied, although...

> +### Move ~/.git-credentials and ~/.git-credential-cache to ~/.config/git
> +
> +Most of git dotfiles can be located, at the user's option, in
> +~/.<file> or in ~/.config/git/<file>, following the [XDG
> +standard](http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html).
> +~/.git-credentials and ~/.git-credential-cache are still hardcoded as
> +~/.<file>, and should allow using the XDG directory layout too
> +(~/.git-credentials could be allowed as ~/.config/git/credential and
> +~/.git-credential-cache could be allowed as ~/.cache/git/credential,
> +possibly modified by $XDG_CONFIG_HOME and $XDG_CACHE_HOME).
> +
> +Each of these files can be a microproject of its own. The suggested
> +approach is:
> +
> +* See how XDG was implemented for other files (run "git log --grep
> +  XDG" in Git's source code) and read the XDG specification.
> +
> +* Implement and test the new behavior, without breaking compatibility
> +  with the old behavior.
> +
> +* Update the documentation

I think these might be getting a little larger than "micro". That's OK
if the student can handle it, but we may want to mark them as such. I'll
leave it for now, though, as we have a bit more breathing room on the
microprojects.

> +### Add configuration options for some commonly used command-line options
> +
> +This includes:
> +
> +* git am -3
> +
> +* git am -c
> +
> +Some people always run the command with these options, and would
> +prefer to be able to activate them by default in ~/.gitconfig.

The direction here seems reasonable, though I think we have
mailinfo.scissors already, so "-c" may not be a good example.

> +### Add more builtin patterns for userdiff
> +
> +"git diff" shows the function name corresponding to each hunk after
> +the @@ ... @@ line. For common languages (C, HTML, Ada, Matlab, ...),
> +the way to find the function name is built-in Git's source code as
> +regular expressions (see userdiff.c). A few languages are common
> +enough to deserve a built-in driver, but are not yet recognized. For
> +example, CSS, shell.

I am not sure that understanding the horrible regexes involved in some
userdiff counts as "micro", but OK. :)

-Peff
