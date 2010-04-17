From: Jeff King <peff@peff.net>
Subject: Re: ghost refs
Date: Sat, 17 Apr 2010 07:51:11 -0400
Message-ID: <20100417115111.GB28623@coredump.intra.peff.net>
References: <20100407210010.GB27012@coredump.intra.peff.net>
 <89030B4A18ECCD45978A3A6B639D1F24032A0750BE@FL01EXMB01.trad.tradestation.com>
 <k2p32541b131004071503g4ce66e5bjac8270b10790a2af@mail.gmail.com>
 <89030B4A18ECCD45978A3A6B639D1F24032A0750CC@FL01EXMB01.trad.tradestation.com>
 <k2x32541b131004071511i9bbe883az504547d6133aef@mail.gmail.com>
 <20100408043059.GA28768@coredump.intra.peff.net>
 <89030B4A18ECCD45978A3A6B639D1F24032A075390@FL01EXMB01.trad.tradestation.com>
 <7vwrwh6fz8.fsf@alter.siamese.dyndns.org>
 <20100408194908.GB4222@sigill.intra.peff.net>
 <7vbpdt65ie.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Dlugosz <JDlugosz@TradeStation.com>, git@vger.kernel.org,
	Avery Pennarun <apenwarr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 17 13:51:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O36Yw-0004tN-IK
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 13:51:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757291Ab0DQLvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 07:51:45 -0400
Received: from peff.net ([208.65.91.99]:40028 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755137Ab0DQLvn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 07:51:43 -0400
Received: (qmail 17396 invoked by uid 107); 17 Apr 2010 11:51:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 17 Apr 2010 07:51:47 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Apr 2010 07:51:11 -0400
Content-Disposition: inline
In-Reply-To: <7vbpdt65ie.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145139>

On Thu, Apr 08, 2010 at 01:42:01PM -0700, Junio C Hamano wrote:

> We might want to have a general concensus on what we want to have in the
> documentation.  As you noted, some have too sparse SYNOPSIS, while others
> have full list of options.  Some mention configuration variables, while
> others don't.  Some have extensive examples, while others lack any.
> Once we know the general direction in which we are going, we can hand off
> the actual documentation updates to the crowd ;-)

I would also like to have consensus on this, too. But it seems like it
gets bikeshedded to death every time it comes up.  But hey, why not try
it one more time? :)

> I'll list my preference off the top of my head as a firestarter.
> 
> NAME::
> 
> The name followed by what it is used for

Yep, makes sense.

> SYNOPSIS::
> 
> I prefer to have (almost) complete set of options in SYNOPSIS, rather than
> "command [<options>] <args>..." which is next to useless.  This is
> especially true for commands whose one set of options is incompatible with
> other set of options and arguments (e.g. there is no place for "-b" to
> "checkout" that checks out paths out of the index or a tree-ish).

I much prefer to have the "major modes of operation". So yes, "command
[<options>] <args>" is useless. But

  git log [<option>] [<since>..<until>] [[--] <path>...]

is sparse but useful. You immediately get a sense of how to invoke the
command, and it is very readable. If you were to put in the dozens of
possible options, it would become hard to see what it is saying. If you
want a complete list of options (IMHO), they should be in list form.

As another example, for git-branch, I would suggest:

  git branch [<options>]
  git branch [<options>] <branchname> <start-point>
  git branch -m [<oldbranch>] <newbranch>
  git branch -d [<options>] <branchname>

>From that I can quickly see that there are four major modes: listing,
creating a new branch, moving a branch, and deleting a branch. I would
also be happy if each mode was explicitly described. Some of my favorite
synopses are those of perl modules, which tend to give you a very short
and readable code snippet of how you might use the module, along with
comments showing anything non-obvious.

In the case of branch, enumerating the options in the synopsis doesn't
bother me much, because there are few enough that it remains fairly
readable. But something something like "git format-patch" or "git apply"
are getting pretty long.

I know that others disagree, though. When this came up last time, some
people said they really like having that giant clump of options. Our
manpages currently seem to be split between the two types.

> I also prefer not to list "purely for backward compatibility" options in
> SYNOPSIS section.

Definitely.

> DESCRIPTION::
> 
> The description section should first state what the command is used for,
> iow, in which situation the user might want to use that command.

Yes. Also, it should probably discuss the different modes of operation
if there is more than one.

> OPTIONS::
> 
> List of full options.  Some existing pages list them alphabetically, while
> others list them in functional groups.  I prefer the latter which tends to
> make the page more concise, and is more suited for people who got used to
> the system (and remember, nobody stays to be a newbie forever, and people
> who stay to be newbies forever are not our primary audience).

I also prefer sorting by functionality. The only reason to prefer
alphabetical is for people finding a specific option. Presumably their
pager has a search function (whereas for grouping by functionality, I
agree with your conciseness argument, and it means you are more likely
to find related options that might help you).

> Detailed discussion of concepts::
> 
> Some manual pages need to have discussion of basic concepts that would not
> be a good fit for the DESCRIPTION section (e.g. "Detached HEAD" section in
> "checkout" manual).  I am not sure if this kind of material is better
> given in OPTIONS section close to the functional group (e.g. "History
> Siimplification" heading in "log" manual).

I would really prefer most of this material to be pushed out into its
own manual pages, and referred to by name (e.g., say "see
githistory(7) for a discussion of history simplification" or "history
is simplified as described in githistory(7)").

Here's my reasoning.  There is a lot of overlap in git commands. The
same concepts come up in many places (e.g., revision traversal,
formatting, and diff options in log, show, whatchanged, diff, diff-*,
etc). History simplification will come up in at least rev-list and log.
So our options are:

  1. choose one place as the canonical location, and say "see history
     simplification in git-log(1)" everywhere else.

     This is annoying because the user has to find the right section in
     git-log. For manpages, it would be nicer to just do "man
     githistory", and for formats with hyperlinks, it should be a
     hyperlink.

  2. factor it out into history.txt, and include it in each relevant
     page. This is what we do with pretty-formats.txt, diff-options, and
     some others.

     My problem with this approach is two-fold:

       a. There is some value to naming the concept to the user. If I
          read the "git show" page and then the "git log" page, I may
          see that they both have pretty options. But it takes some
          mental effort to see that they are identical and then reduce
          it to "both commands take the same pretty options" in my mind.
          But if we explicitly link, then we are saying "there is a
          concept called pretty options. You can use it here, and when
          you see other places mention that concept, it is the same
          thing." Which IMHO makes git easier to learn for new users;
          they learn easily digestable concepts and build on them
          instead of being overwhelmed with commands and options.

        b. As an experienced user who already knows that "pretty
           formats" is a concept, I find it annoying to have to find
           them inside of git-log(1) when I want to see them. I would
           much prefer to do "man gitpretty".

        c. These subsegments can get long. pretty-formats.txt is 186
           lines. That is a big chunk to be in my way if I am reading
           git-log(1). I get to the "pretty formats" section and say
           "that is not interesting to me. What is the next section?"
           and then have to scroll down through 186 lines.

  3. factor it into githistory(7), and reference it by name

     Obviously this is my favorite. :) It does have one downside,
     though. If we convert pretty-formats.txt into gitpretty(7), then
     searching for "oneline" in git-log may not turn up what you want.
     I wonder if we can summarize with something like:

       --format=:
       --pretty=<oneline|full|raw>:
       --oneline:
         Format the output. See gitpretty(7).

    in git-log(1).

> EXAMPLES::
> 
> I prefer to make it mandatory for Porcelain command manual pages to have a
> list of often used patterns that a reasonably intelligent person can guess
> how to tweak to match the particular situation s/he is in.

Yes, examples are good.

> AUTHOR/DOCUMENTAITON::
> 
> These sections in most pages are not kept up to date, and I prefer to
> remove them altogether.  They do not help end users who never clone
> git.git, and those who clone git.git will have shortlog to give them more
> accurate information.

Agreed. I find them useless at best, clutter at worst.


You didn't mention configuration variables. I do think it would be
better to have the variables for a specific command in that command's
manpage (in an ENVIRONMENT section that also mentions environment
variables). For variables that affect many commands, I would suggest
factoring them out as described above.

git-config (or perhaps even gitconfig(7)) should have a list of all
variables and where they are described, like:

  apply.ignorewhitespace        git-apply(1)
  apply.whitespace              git-apply(1)
  branch.autosetupmerge         git-branch(1)
  [etc]

There is not much point in having full descriptions in one giant list.
Instead, you can peruse the whole list, and then go to the configuration
section of the relevant manpage to see a bunch of related options. Such
a list should be pretty easy to generate automatically from the other
documentation.

-Peff
