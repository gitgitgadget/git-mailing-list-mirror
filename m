From: Stefan Saasen <ssaasen@atlassian.com>
Subject: Re: [PATCH] mergetools/diffmerge: support DiffMerge as a git mergetool
Date: Tue, 8 Oct 2013 22:43:12 -0700
Message-ID: <CADoxLGMxi7CvKHD2-UFEh4=kkF_8Oker4o7YivsB2tSosXJ+Jw@mail.gmail.com>
References: <1380961741-85909-1-git-send-email-ssaasen@atlassian.com> <CAJDDKr6vyt-UgO-p2HxxAdpQnGy+=zwpc9TUpK5LL54LrjNEGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 09 07:44:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTmYw-0006Aw-MW
	for gcvg-git-2@plane.gmane.org; Wed, 09 Oct 2013 07:43:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754800Ab3JIFnz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Oct 2013 01:43:55 -0400
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:44357 "HELO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751848Ab3JIFnx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Oct 2013 01:43:53 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]) (using TLSv1) by na3sys009aob108.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUlTtGXpoWA5Yrjbmcow1m3ONCRxS1vp4@postini.com; Tue, 08 Oct 2013 22:43:53 PDT
Received: by mail-oa0-f51.google.com with SMTP id h16so52297oag.38
        for <git@vger.kernel.org>; Tue, 08 Oct 2013 22:43:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=/ux8bxG9FN5X/VZH9IB6n1r1UEeZyw6Tb3IJa2MgQfc=;
        b=DL+b54dxS6G4g7nn264dpRnx4sO8S8IYffZfeEu0sQZx3bEd7SkCyAPTYE76sUXg6W
         u+A1/8ETwIVO04dTciDGIHGiAke3r1mEETypwRTLwWcuhwtKjCVu9hh5JitNw6cRT66E
         bxDDgBZ7zR19huRt9X3eyTPy9ncAhJQ21VOEhwxdBcFIUU6b90VwA6WyWOkkOTb02TxT
         6C/q59Wl2R9VOyNQ5fmbLbBKxA+axtO7A2NlaYwErKHRSbfW1oh+asfgZhiA1kmJI76P
         wJ84LS0TVz5/+iX6qIKvhziy6fsdduXRvZgmcRwwJoJkPCUbBtdZiY+rjaQ4ZpYNoJBG
         QS6g==
X-Gm-Message-State: ALoCoQnmGt1VPOb7ZszZt7h2WRWhwYvyVU+xtghBf04AwBBDnfyDjaC3BMeTGOSq7buf0zr0UVXGc6YjZ5V0W4385KZgYZIQOV7psb+gd6LLlWdi4Olhbp1jRslz+MstxnOlfk7axQVSlp1Zxxh7Yf3U2e7bEQQeqA==
X-Received: by 10.182.45.195 with SMTP id p3mr4286074obm.29.1381297432906;
        Tue, 08 Oct 2013 22:43:52 -0700 (PDT)
X-Received: by 10.182.45.195 with SMTP id p3mr4286065obm.29.1381297432769;
 Tue, 08 Oct 2013 22:43:52 -0700 (PDT)
Received: by 10.76.116.72 with HTTP; Tue, 8 Oct 2013 22:43:12 -0700 (PDT)
In-Reply-To: <CAJDDKr6vyt-UgO-p2HxxAdpQnGy+=zwpc9TUpK5LL54LrjNEGg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235801>

Thanks for the review David, much appreciated.

> I think this line was already too long in its current form.  Would you mind
> splitting up this long line?

I've updated the patch and had a look at how to avoid repeating the list of
available merge/difftools.

> ... follow it up with a change that generalizes the "list
> of tools" thing so that it can be reused here, possibly.  The
> show_tool_help() function, as used by "git difftool --tool-help" and
> "git mergetool --tool-help", might be a good place to look for
> inspiration.

> We were able to eliminate duplication in the docs (see the handling
> for $(mergetools_txt) in Documentation/Makefile) so it'd be nice if we
> could do the same for git-completion.bash, somehow.

I can think of a number of approaches and I would like to get some feedback.

Firstly I think a similar solution to how the duplication is avoided in the
documentation can't be easily applied to the completion script. Looking at the
script itself (and/or usage docs like
http://git-scm.com/book/en/Git-Basics-Tips-and-Tricks) the recommended way of
using it is by copying the script as-is. That means there won't be a build step
we could rely on unless I've overlooked something?

That leaves a different approach (run- vs. build time) where I can think of two
possible solutions.
The first would be similar to what is being done at the moment by looking at
the MERGE_TOOLS_DIR and in addition considering any custom merge tools
configured. I'm working with the premise that it is a reasonable assumption
that users of the git completion script have a git installation available even
though they may have gotten the script by other means.
For users to still be able to install the script by simply copying it
to any location
on the filesystem the list generation function(s) would either have to
be sourced
from the git installation or duplicated. I suppose the former would need to
take into account that the completion script doesn't necessarily matches the
installed version of git with some potential brittleness around
relying on external
files and directories. The latter doesn't buy us anything as it duplicates even
more code than the current list of available mergetools.

The second approach would be to do something similar to resolving the merge
strategies (in __git_list_merge_strategies) by parsing the output of the `git
merge tool --tools-help` option with a very similar disadvantage that it relies
on the textual output of the help command and doesn't work outside of a git
repository.


I'm currently leaning towards the last approach as it seems less reliant on
implementation details but it doesn't look ideal either and I may be missing
another approach that would be better suited.

> It might be worth leaving the git-completion.bash bits alone in this
> first patch and follow it up with a change that generalizes the "list
> of tools" thing so that it can be reused here, possibly.

To decouple this and adding the diffmerge merge tool option, I'd rather keep the
git-completion change part of the patch. That way the patch is self contained
and covers the change including the completion using the current approach and
doesn't rely on the duplication change. Any concerns around that, otherwise I'll
resend the patch with only the long line fixed?

Cheers,
Stefan


On 6 October 2013 14:21, David Aguilar <davvid@gmail.com> wrote:
>
> On Sat, Oct 5, 2013 at 1:29 AM, Stefan Saasen <ssaasen@atlassian.com> wrote:
> > DiffMerge is a non-free (but gratis) tool that supports OS X, Windows and Linux.
> >
> >     See http://www.sourcegear.com/diffmerge/
> >
> > DiffMerge includes a script `/usr/bin/diffmerge` that can be used to launch the
> > graphical compare tool.
> >
> > This change adds mergetool support for DiffMerge and adds 'diffmerge' as an
> > option to the mergetool help.
> >
> > Signed-off-by: Stefan Saasen <ssaasen@atlassian.com>
> > ---
> >  contrib/completion/git-completion.bash |  2 +-
> >  git-mergetool--lib.sh                  |  2 +-
> >  mergetools/diffmerge                   | 15 +++++++++++++++
> >  3 files changed, 17 insertions(+), 2 deletions(-)
> >  create mode 100644 mergetools/diffmerge
> >
> > diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> > index e1b7313..07b0ba5 100644
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -1188,7 +1188,7 @@ _git_diff ()
> >         __git_complete_revlist_file
> >  }
> >
> > -__git_mergetools_common="diffuse ecmerge emerge kdiff3 meld opendiff
> > +__git_mergetools_common="diffuse diffmerge ecmerge emerge kdiff3 meld opendiff
> >                         tkdiff vimdiff gvimdiff xxdiff araxis p4merge bc3 codecompare
> >  "
>
> It's a little unfortunate that we have to keep repeating ourselves
> here.  mergetool--lib has a list_merge_tool_candidate() that populates
> $tools and help us avoid having to maintain these lists in separate
> files.
>
> It might be worth leaving the git-completion.bash bits alone in this
> first patch and follow it up with a change that generalizes the "list
> of tools" thing so that it can be reused here, possibly.  The
> show_tool_help() function, as used by "git difftool --tool-help" and
> "git mergetool --tool-help", might be a good place to look for
> inspiration.
>
> We were able to eliminate duplication in the docs (see the handling
> for $(mergetools_txt) in Documentation/Makefile) so it'd be nice if we
> could do the same for git-completion.bash, somehow.
>
> > diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> > index feee6a4..6d0fa3b 100644
> > --- a/git-mergetool--lib.sh
> > +++ b/git-mergetool--lib.sh
> > @@ -250,7 +250,7 @@ list_merge_tool_candidates () {
> >                 else
> >                         tools="opendiff kdiff3 tkdiff xxdiff meld $tools"
> >                 fi
> > -               tools="$tools gvimdiff diffuse ecmerge p4merge araxis bc3 codecompare"
> > +               tools="$tools gvimdiff diffuse diffmerge ecmerge p4merge araxis bc3 codecompare"
>
> I think this line was already too long in its current form.  Would you
> mind splitting up this long line?
>
> >         fi
> >         case "${VISUAL:-$EDITOR}" in
> >         *vim*)
> > diff --git a/mergetools/diffmerge b/mergetools/diffmerge
> > new file mode 100644
> > index 0000000..85ac720
> > --- /dev/null
> > +++ b/mergetools/diffmerge
> > @@ -0,0 +1,15 @@
> > +diff_cmd () {
> > +       "$merge_tool_path" "$LOCAL" "$REMOTE" >/dev/null 2>&1
> > +}
> > +
> > +merge_cmd () {
> > +       if $base_present
> > +       then
> > +               "$merge_tool_path" --merge --result="$MERGED" \
> > +                       "$LOCAL" "$BASE" "$REMOTE"
> > +       else
> > +               "$merge_tool_path" --merge \
> > +                       --result="$MERGED" "$LOCAL" "$REMOTE"
> > +       fi
> > +       status=$?
> > +}
>
> Other than those two minor notes, this looks good to me.
>
> Thanks,
> --
> David
