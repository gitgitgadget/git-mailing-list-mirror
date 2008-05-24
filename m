From: "Govind Salinas" <blix@sophiasuchtig.com>
Subject: Re: [PYRITE] Status update and call for information.
Date: Sat, 24 May 2008 00:16:17 -0500
Message-ID: <5d46db230805232216p7936e5dex3aa3ff0e1e0dce06@mail.gmail.com>
References: <5d46db230805222318j25657c10t2955fbdf1aa5c003@mail.gmail.com>
	 <m34p8o4ijg.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 24 07:17:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jzm8P-00031S-F8
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 07:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323AbYEXFQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2008 01:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752309AbYEXFQZ
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 01:16:25 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:8130 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbYEXFQY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2008 01:16:24 -0400
Received: by yw-out-2324.google.com with SMTP id 9so573686ywe.1
        for <git@vger.kernel.org>; Fri, 23 May 2008 22:16:17 -0700 (PDT)
Received: by 10.150.202.3 with SMTP id z3mr738109ybf.224.1211606177149;
        Fri, 23 May 2008 22:16:17 -0700 (PDT)
Received: by 10.150.181.17 with HTTP; Fri, 23 May 2008 22:16:17 -0700 (PDT)
In-Reply-To: <m34p8o4ijg.fsf@localhost.localdomain>
Content-Disposition: inline
X-Google-Sender-Auth: 275e6dfdf85ea8b4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82795>

On Fri, May 23, 2008 at 8:07 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> "Govind Salinas" <blix@sophiasuchtig.com> writes:
>
>> One of the things that has been commented on by almost any review of
>> git are the large numbers of commands that are present and the
>> endless stream of flags, options, configuration variables and
>> syntaxes that are present in git.  They certainly serve a purpose
>> and I probably would not be able to do this without all those things
>> but it can get in a normal users way some times.  Here are some of
>> the steps I have and will be taking.
>
> Which is bogus, because most of those commands are plumbing, [almost]
> never to be used by user directly.
>
> If I understand correctly in next major git release those commands are
> to be hidden and not present in PATH anymore.
>

That may be true but it is only part of the story.  I see plumbing commands
being given to users all the time on the mailing list.  Usually in some
combination.  To make it worse they usually get several sets of commands
that do something similar but any one may or may not be exactly what
they want because not everyone who responds fully understands what the
commands are doing.

I think I can reduce the number of commands to around 25 total with 10 or
so that a user might use regularly.  But it is an experiment, we will see
where it goes.

>> 1) Reduce the number of commands.
>>
>> I am currently at 30 total commands, and while I have some more to go, I
>> think there are some ways that I can get rid of some of them by
>> combining them.  Do we really need a clone, branch and checkout?  Don't
>> these all mean the same thing in the end?  They mean get me a working
>> directory of the repository starting at X.  For clone, you start
>> with 'master'. For checkout, you tell it what to get you.  Branch
>> will help you manage things you can locally get.  So perhaps we can
>> do something like the following...
>
> Note that you sometimes want to make a branch without checking it out.
> Also note that git-branch is overloaded to get a list of branches
> available.
>

Sure, removing commands is not about removing features, its about
reducing the learning curve and reducing confusion.  Its about the
commands doing what I want without me having to research it.

>> Fetch
>> pyt co <url> # or remote:origin
>>
>> It's a URL, but I am inside the repo, I should tell the user that
>> they are about to fetch something.
>
> Not necessary, you might have wanted to have repository inside
> repository, either managed using submodules, or ignored, etc.
>

Good point.  But that could be done with a submodule command or
by following the create with the ignore, say..

pyt config ignore <dir>
pyt co <url> <dir>

<dir> is not in this repo, therefore we are cloning to it.  Worst case
there would be a flag for it in the command, since this is the
unusual case, it would be ok to force the user to do a little more
typing.

>> Pull
>> pyt co -m remote:origin:branch
>>
>> Pull is just fetch/merge anyway -m tells it to merge, perhaps a flag -u
>> to do it all in one step.
>>
>> Merge
>> pyt co -m localbranchhead
>>
>> Checkout a branch
>> pyt co localbranchead # or remote:origin:branch, tag:tagname etc
>>
>> Create/switch to new local branch (this should look familiar)
>> pyt co -c <newbranch> -b <base>
>>
>> The list goes on.
>
> Note also that if you make all those unrelated (at least a bit) things
> into one command you would lose some of error detection.  For example
> you want to clone, but due to typo and DWIM-mery of "pyt co" command
> it would silently fetch/merge/branch/whatever.  Not good...
>
> Note also that another complaint is that git commands do many fairly
> independent things... and you would want to escalate it even
> further...
>

I will just have to do it right then :)  Seriously, I am not afraid to
experiment
with this to get the commands right.  Perhaps some of these can't be
combined, but that is no reason not to see if it works.  Besides, DWIM is
not enough, in needs to be "DWIM Safely".

>> 2) Reduce complexity.
>>
>> This one is easy, not because there are commands in git that don't
>> have a use, but because we can usually spell stuff in a simpler way.
>> Take for example master@{100}.  If I see someone on the list use that
>> on I might expect that that is master 100 commits ago, rather than what
>> HEAD was pointing at 100 operations ago.
>
> Errr... master 100 commits ago (in first-parent line) is master~100.
> And that it is not where HEAD was (indirectly or directly) pointing,
> but where 'master' ref was pointing.
>
> The ref@{n} notation is very, very useful when you want to correct
> mistakes such as errorneous rewind ("git reset --hard HEAD^" for
> example), or botched rebase, or to view pre-rebase version to compare,
> etc.
>

I know that, and you know that, but the command and the syntax don't
tell you that.  I only know that because I spent a night[1] going over the
docs and making sure I had it right, before that I had seen the notation
on the mailing list several times but never really understood it.

>>
>> How about not using the ".." and "..." since it can be surprising to
>> users what they actually do without understanding how git works.
>> Perhaps something like --revision-start (-r) and --revision-end(-R)
>> would help them out.  Add a --symmetric or something for "...".
>
> You don't need two options; first -r is start, second -r is end...
>

Maybe, I prefer to be explicit and its a little less work for me.  Let me
ask you this.  Is there a down side to having 2 different names?  If I
say "pyt log -r foo" do I mean "..foo" or "foo.."?

>> 3) Addons.
>>
>> Some functionality isn't for everyone.  I have just put into my
>> next branch an addon that gives git revision numbers.  Why, because
>> other SCMs that are supposed to be more user friendly have them.
>> Because people have been asking for them.  Because they are easier
>> to remember.
>
> Because people does not understand the concept and constraints of
> distributed version control system (with implied multiple branches and
> nonlinear history).
>
> Revision numbers cannot be all of: decentralized, global, unchanging,
> encompassing.
>
> (Decentralized means no single authority assigning numbers, and no
> repositories which are special in any case for example using
> merge/pull with different options than other repositories.  Global
> means that all repositories have the same numbers for the same
> revisions; the opposite is local, that numbers are relevant only in
> your local repository (and you cannot say: in revision 'n' to someone
> else).  Unchanging means that revsision numbers don't change on pull
> for example.  Encompassing means that all revisions are given number.)
>

I responded to this in another mail.  The other DVCSs don't claim that
revision numbers are all of those things.  It is only necessary that when
two people say the same thing, it mean the same thing.

To quote the Hg wiki at
http://www.selenic.com/mercurial/wiki/index.cgi/RevisionNumber?highlight=(rev)

"Revision numbers referring to changesets are very likely to be
different in another copy of a repository. Do not use them to talk about
changesets with other people. Use the changeset ID instead."

This doesn't stop them from using these numbers more than the sha1
IDs because given a branch, the numbers are solid.  Doing things the
way I propose has the same properties.

>> 4) GUI.
>>
>> I have a GUI in mind, I haven't had time to work on it, but I have
>> started it and the idea is that it should be able to completely
>> replace the command line.  Why?  because some people hate command lines
>> and more importantly, because I want a GUI that will look like it
>> fits into my Gnome desktop and looks decent on my Windows machine
>> (which I use because I have to).
>
> Have you checked existing git GUIs, both history viewers and commit
> tools?  Gitk, git-gui, QGit, Giggle, ugit, tig,...
>

Yes I have looked at most of them, and all of them have something (or
even many things) I want but none of them have everything.  Giggle
has the UI I want, gitk and git-gui have most of the functionality.  ugit
has some nice features that the others don't.

>> 5) One stop shop.
>>
>> I tried setting up Apache, lighttpd etc on Windows to do some ad-hoc
>> serving of a git repo.  I was painful.  I want my webserver, gui,
>> command line, diff tool, merge tool to all come in one package.  And
>> I DON'T want it to need a cygwin or msys installation to work.
>>
>> That just makes life easier.  And I am all about the not expending
>> effort.
>
> Perhaps we could just get more examples in gitweb/README and perhaps
> in user's manual.
>

Examples won't help too much on windows, partially because its just a pain
in the ass to do, but also because thats not the preferred platform for any
of the tools.  I was using cygwin git at the time and it simply did not work.
Perhaps it has gotten better in the last few months particularly with
msysgit.

> BTW. there always is git-instaweb.
>

Yeah, but I still need the webserver, thats what I want to get rid of.  If you
want to do some ad-hoc sharing it is a huge problem and you may not
have permissions/time to install software.

> But having git-serve would be nice...
>

Indeed.

-Govind

[1] Ok, a couple of hours anyway.
