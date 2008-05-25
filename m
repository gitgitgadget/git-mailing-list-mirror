From: "Govind Salinas" <blix@sophiasuchtig.com>
Subject: Re: [PYRITE] Status update and call for information.
Date: Sun, 25 May 2008 14:03:37 -0500
Message-ID: <5d46db230805251203y6208198dldcaf2c4e7d973a3c@mail.gmail.com>
References: <5d46db230805222318j25657c10t2955fbdf1aa5c003@mail.gmail.com>
	 <200805242247.07565.jnareb@gmail.com>
	 <5d46db230805241450w71b0c587o4767becc0058ee0a@mail.gmail.com>
	 <200805251335.36530.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Dmitry Potapov" <dpotapov@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 25 21:05:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0LXa-0006bo-Lg
	for gcvg-git-2@gmane.org; Sun, 25 May 2008 21:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758244AbYEYTEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 May 2008 15:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758076AbYEYTEH
	(ORCPT <rfc822;git-outgoing>); Sun, 25 May 2008 15:04:07 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:4499 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757581AbYEYTEE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 May 2008 15:04:04 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1099933ywe.1
        for <git@vger.kernel.org>; Sun, 25 May 2008 12:03:38 -0700 (PDT)
Received: by 10.150.91.17 with SMTP id o17mr2006783ybb.222.1211742217784;
        Sun, 25 May 2008 12:03:37 -0700 (PDT)
Received: by 10.150.181.17 with HTTP; Sun, 25 May 2008 12:03:37 -0700 (PDT)
In-Reply-To: <200805251335.36530.jnareb@gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: e5a4f913d0f51303
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82874>

Trimming attributions, as they are getting hairy.

2008/5/25 Jakub Narebski <jnareb@gmail.com>:
> "Govind Salinas" <blix@sophiasuchtig.com> writes:
>>
>> 1) Reduce the number of commands.
[snip]
>> To answer your question a little better, I am looking at it like this:
>> The predominant action is, as you say, going to be "I want to create a
>> branch so that I can start working on something."  While I respect that
>> you might want to create a branch and not start doing something
>> *right away*, I think this is less likely.  So...
>>
>> pyt co
>>   this lists stuff you can checkout by which we mean local branches.
>
> Note that "git checkout" defaults to HEAD.

I do not see that as an issue.  I do not intend to have command
computability in that fashion.  However, if there is a good reason
for the default to be HEAD, then I would like to know.

>> pyt co -r
>>   this lists remote stuff you can check out, such as remote tracking
>>   branches and the remotes themselves.
>>
>> pyt co -a
>>   lists both of the above, maybe tags too.
>
> These three are all about listing metadata, refs to be more exact.
> 'checkout' is IMHO all about getting given state recorded in repository
> (or, in git case, also from index) into working area, i.e. in a way
> opposite to 'commit' or 'checkin', at least as far as it is possible.
> So I think this is in the same league as using 'less' to view contents
> (listing) of a directory.  This IMHO does not reduce confusion, but
> adds to it.

I have a theme in my commands, it is one that is in git too to some
extent.  The theme is that a command should provide both the
action and the information needed to carry out that action, making
it self contained.  Your argument could be used to argue that
"git branch" needs to be split up into "git list-branch" and
"git branch."  Now if you are saying that I should make it
"pyt co -l" to list what can be checked out, then I would think about
that, but I kind-of like the "git branch" way of doing it over the
"git-tag" way.  More a matter of taste in my opinion.

> Also note that git-branch is used to create and list branches
> (unfortunately it uses -l for --enable-reflog and not for --list as
> other commands like git-tag do), but can be also used to delete and
> rename branches.  Do you want to stuff this functionality in "pyt co"?

Yes and no, in that order.  Delete should be handled, rename is rare
enough that I would ask people to spell it

pyt co -n newname oldname
pyt co -d oldname

>> pyr co <uri> <remote-name> <branch>
>>    the user wants to checkout something that isn't local.  So we do
>>    a git remote add -t <branch> -f <remote-name> <uri> followed by
>>    checkout <remote-name>/<branch>
>>    There would probably be variations/flags to get different functionality.
>
> Please note that result of this is very, very different from ordinary
> checkout.  Either it doesn't touch working area if it is equivalent
> of git-fetch, or can result in conflicts and not a clean state if
> it is equivalent of git-pull.

My meme for checkout/checkin is..

pyt checkout/in [what to checkout/in] [where to checkout/in to]

This would be a "set up remote & fetch", which means to me
"check out the <uri> to this remote tracking branch".  It is hopefully
a bit clearer since I have decided on making pull/fetch/merge into
a separate command following some of the earlier comments
in this thread.

>> pyt co [something=HEAD] [--] <files>...
>>   should be obvious
>
> But it isn't obvious.
>
> Let me explain.  Because in git commits are always whole-tree
> snapshots, and usually (read: almost always) it makes sense to have
> whole-tree commits in an SCM, this cannot switch branches.  So for
> example there is a question if it is a separate mode (yet another
> oveloading of 'pyt co' operator) of checkout changing working area
> without changing current branch (something like svn-revert,
> or hg-undo), or would it make HEAD detached and result in something
> like not yet implemented "git cherry-pick <rev> -- <files>".

it is "git checkout [somthing=HEAD] -- <files>..." thats why I thought it
would be obvious.  Having said that, the other option is to put this in the
recover/revert command which I have outlined in another mail.  Basically
the recover command would be "git reset --hard [somecommit=HEAD]"
with the ability to specify files rather.  Specifying files would mean to
"git checkout" the *just* files instead of the reset.  Does that sound
better?

>>>> I don't think any commonly used SCM unites 'clone', 'branch', and
>>>> 'checkout' functionality under the same name. This approach seems
>>>> to be more confusing than helpful.
> [...]
>> See above, they in fact do.  It struck me as odd too, because I had
>> started with git.  After thinking about it for a while, I saw advantages
>> to it.
>
> And it looks like you gone to far in the reducing number of commands
> direction and do not see disadvantages of heavily overloaded, DWIM-ming,
> doing multiple different things depending on options commands.  If you
> don't like large number of commands (is 30+ large number?), use GUI!

It isn't set in stone, when I started this thread, I was thinking about 24 total
commands.  Based on feedback it is 26.  Also, using a gui only reduces
typing, the gui needs to carry forward the concepts of the underlying
system or things *really* won't make sense.

> What you need is to have some _users_ to tell you if you do with
> Pyrite in good direction.  Or at least analysis of common git workflows
> and how they could be improved...

I agree 100%.  I currently am basing this on the comments that I have
heard/read from people just starting to use git and other systems as
well as reviews I have seen posted.  I would very much like it if people
would send me comments on their experiences, both negative and
positive, while starting to use git and other DSCMs and why they
decided to stick with their result.

People seem to *like* the bzr and hg interfaces, they seem to
tolerate the git one because git has better features.  That is the
impression I get from doing my reading.

-Govind
