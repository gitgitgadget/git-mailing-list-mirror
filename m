From: "Miles Georgi" <azimux@gmail.com>
Subject: Re: externals program, way to do svn:externals-like subproject management without git-submodule
Date: Sat, 13 Sep 2008 20:57:47 -0700
Message-ID: <853238710809132057o22520f92qd1970847ae6a25f8@mail.gmail.com>
References: <853238710809131417v3818955sed4c0d3dd411a540@mail.gmail.com>
	 <32541b130809131517k6d1e5e4dsc5f72d54c7e71e55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 14 06:00:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Keimn-0006dD-St
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 06:00:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752409AbYIND5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Sep 2008 23:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752476AbYIND5u
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Sep 2008 23:57:50 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:8879 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752326AbYIND5s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Sep 2008 23:57:48 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1563350rvb.1
        for <git@vger.kernel.org>; Sat, 13 Sep 2008 20:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=lxohHHV7c2uxrkMOVASXLfVVHpZ9FnzvQPFh7STSjsU=;
        b=jJJ5+cvz0K8PL2iVmSo2iKZ4fsCkRwX6F3X934qrAVZw7mHCBRWZewnV8cR4bbcBt1
         hShGggvL8izR3dQnbjmBMe6w51t03FY5SuJdjweO9tXOfFamwkrlkwBKH9bLrgnefUjb
         jfHjC1wHT77Yyh9cAkAxKoGtFYo2UAYWUZvxU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=S+lcf3yonHvY4/EGcG7JqsEE5B0eR1/AQs3EKpA2QlRSTOmNCf9FFQxQBiGYGLZBep
         UeyU7b8N24tUF3tLedBJoSKm7K90deV3mE2K+nmL7j1TAbdpTGUzw3ilT69zdVpVjQ8w
         mf4VGSzjYHe195UIUlqFlWHruBrWiVmbBti/Q=
Received: by 10.141.74.18 with SMTP id b18mr3788397rvl.80.1221364667560;
        Sat, 13 Sep 2008 20:57:47 -0700 (PDT)
Received: by 10.141.98.11 with HTTP; Sat, 13 Sep 2008 20:57:47 -0700 (PDT)
In-Reply-To: <32541b130809131517k6d1e5e4dsc5f72d54c7e71e55@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95819>

Wow!  Thanks for the extremely thorough reply.

I'll just answer by numbers, I hope it's not too inconvenient to have
to scroll between emails to see which point I'm talking about :/


1.  Oh, I'm not really aware of what "cvs export" does.  I assumed it
meant something very similar to "svn export"  Running "ext export URL"
on a project manage by subversion with all the subprojects managed by
subversion simply runs "svn export URL" followed by an "svn export"
for each subproject, hence the name.  Calling it "shallow" makes sense
for git since I'm using --depth 1, but since "svn export" doesn't
create the .svn directories necessary to make it a working directory,
I don't really know if I would call that shallow.  For git's
implementation of export, I was thinking of just doing a clone and
then deleting .git/ which also wouldn't be shallow.

2.  Agreed.  I wasn't really sure what proper ini format is.  I mostly
just superficially mimicked the .git/config format.  I had considered
XML but thought it was way too verbose, and considered YAML but it
seemed awkward.  I would definitely be happy to change the format to
comply with whatever defines a valid ini file.

3.  I am also bothered by the inconsistency of the meaning of [main]
and [git/svn] along with everything you pointed out.

Question?  Is it okay to have "/" characters in the ini section name?
I'm assuming it is otherwise you wouldn't have recommended the format
that you did. I wonder if it would be okay to just put the repository
as the section name.  That way scm and path could be excluded for
situations where the defaults are sufficient.  Although I guess this
would have the implication of changing a projects repository
(something that happens way more frequently than changing the path
it's installed to) some what messy since it's being identified by its
repository.

That's an interesting idea having the subprojects default to the same
SCM as the main project.

4.  Using the default paths is optional.  In rails applications, 99%
of the time if a subproject is called rails, it is intended by the
developer to belong in vendor/rails, otherwise, 99% of the time it's a
plugin.  Rails developers actually got kind of used to using
svn:externals to install plugins because the plugin install script has
a -x option that uses svn:externals.  But let's say you have something
you want in the lib directory, you could do:

ext install some://repository/urlsomelib lib/somelib

and it will not put it in vendor/plugins.  Rails developers tend to
automatically re-factor code that they intend to use in another
project into a plugin.  This is always what I do since plugins are as
easy to make as putting a subproject in lib/ (or elsewhere.)

But yeah, if this feature makes somebody nervous, they can just always
explicitly give the path (which they'll have to do if it's not a rails
app.)  It also detects that it's a rails app so it will complain if
you leave the path off in a non-rails app.  It won't try to put
something in vendor/plugins of a non-rails app just because a path is
missing.

5.  Yeah that's a good idea.  I could create a command that adds an
existing subproject to the .externals and updates the ignore properly.
 To get this effect at the moment, one would manually add the
subproject to .externals and run "ext update_ignore"  I personally
don't usually find myself doing this though.  I almost always want the
subproject to be added to the project.  I need to make an "ext
uninstall" for backing out if you don't like it.  I personally would
rather manually remove the item from .externals than have to issue two
commands to install it.  But your idea of a save command is very
powerful, especially with the branch switching ideas you have in #8
below.

6.  Hey that's a pretty interesting idea!  I hadn't even thought about
that as I have not yet personally encountered that use case.  I've
been hoping that rails plugins could have their own vendor/plugins
directory because if they did I would also use something like that all
the time.  This is definitely something that should be implemented at
some point.

7.  Agreed (for the most part.)  I almost never want to do this for my
own projects as I almost always want the branch tip no matter what.
I'd rather run tests and discover that something has broke before
deploying than have to go to all my projects and advance the commit
manually.

However, for large projects that are not written by me, this would be
useful.  For example, rails and engines are 2 projects that frequently
break my code.  If I blindly deploy an application with the rails
master branch as a subproject after about a month, there's probably a
15% chance it won't function properly (or at all.)  the way I
currently have been handling this is by having my own rails repository
at git://github.com/azimux/rails.git that I occaisionally will merge
rails/rails.git with and run tests for my larger applications.  If I
like how it behaves I push the merged tip back out to azimux/rails.git
which is what all my projects reference in their .externals file.

I like your idea of a revision= and branch= syntax for the externals
file instead of the syntax I've been using.  I also like your idea of
using unambiguous comands like "latest"  And I would definitely not
have it disconnected from a branch if it can be avoided.  I guess it
would checkout a specific commit but be on a branch, and then if the
developer needed to edit the subproject, they would realize it was
non-fastforward when they pushed and then do a rebase against the
current tip?  I'm not 100% sure how this workflow would normally occur
as I've not yet had to rebase anything, and when I was using
git-submodule, I would always checkout a branch tip if I had to edit
the subproject and then would do a git add submodule/path to point at
the new commit when I was done.

8.  Oh yes, I feel your pain on this one.  I guess there would need to
be a combination of something like "ext switch" if you really want it
switched at the main project level for everybody, or maybe have "ext
save" be smart enough to detect a branch has been switched for
situations where the developer is trying to switch it for good from
the main project level.  The implementation of this probably requires
some more thinking but it's definitely very useful if implemented.

9.  I wasn't planning on having any sort of commit/push-type features
since the workflows of the SCMs are different when it comes to
commiting/pushing.  For example, if it's a subversion project it needs
to do an "svn commit" requiring a log message.  And sometimes I really
only want to push a subset of the subprojects that I've modified.

Maybe what I could do is have "ext status" also see if a subproject
could be pushed and issue a warning like "<subproject> has commits
that are missing from <remote name>.  Did you forget to push?"  This
would be unnecessary for subversion managed subprojects as if it's up
to date, then it's pushed and vice versa, but for git it would be very
helpful for when the status is empty due to commits being performed,
but is not yet pushed out to it's origin.  I don't know if I would
like it automatically doing the pushing though, but it could be
doable, maybe with a command with the name "git" in it to specify it's
scm specific, like "ext gitpush" or I could just have an "ext push"
that does nothing for svn/cvs projects.

10.  That's an interesting idea but I'm not sure it would be worth the
effort to implement.  I would still need to require ruby to be
installed (unless I rewrote it), and then the user would need to
manage the local ext for each project.  The chicken/egg thing actually
kinda works out though.  You could do "git clone blah/blah.git"
followed by "cd blah; ./ext co"  When I deploy I do something similar
with an after_update hook since the deployment software I'm using
doesn't know anything about ext... yet :)

I truely appreciate all the ideas and criticisms.  I definitely intend
to implement some your ideas, probably starting with restructuring the
ini file.  I should probably start by using a 3rd party ini file
parser instead of the parser I wrote.  That would get me on track to
changing the format and changing the format is something that should
probably be done first before people start using it and expecting
backwards compatibility.

Thanks again Avery

Miles

On Sat, Sep 13, 2008 at 3:17 PM, Avery Pennarun <apenwarr@gmail.com> wrote:
> On Sat, Sep 13, 2008 at 5:17 PM, Miles Georgi <azimux@gmail.com> wrote:
>> I posted this on the rails list a week ago (though it can certainly be
>> used in non-rails applications (it does require ruby to be installed,
>> and is best installed via rubygems))   I didn't get any feedback at
>> all which was kind of dissapointing.  I decided to mention it here to
>> see if I can get any feedback.
>>
>> I have a tutorial demonstrating how to use ext here:
>> http://nopugs.com/ext-tutorial
>
> Hi Miles,
>
> Well, you asked for feedback :)
>
> I myself have found that git-submodule doesn't really do it for me
> either.  Someday, like you, I was planning to break down and write a
> replacement that works more like how I want.  I haven't done that, and
> now here you are, with a replacement that's *more* like what I want,
> but not quite.  With that in mind, here is an assortment of
> suggestions that I myself have been too lazy to implement.
>
> (The suggestions are based on the tutorial you posted.  I haven't
> tried ext itself yet.)
>
> 1. 'ext export' is not a good name for what it does.  It doesn't
> actually export anything.  It's putting files *into* your working set!
>  Worse, 'cvs export' for example does something totally different.
> 'ext qcheckout' (for "quick") or 'ext shallow' (because it makes
> shallow clones) might be better names.
>
> 2. Your ini file is not quite in ini format.  To feel "normal", all
> lines should be either [section] lines or key=value lines.  It's worth
> having your ini-looking files really be ini-like partly because there
> are existing tools for parsing/creating those files in any language,
> and partly because humans get confused if they don't see what they
> expect.  Section lines should also have a preceding blank line rather
> than one following, though maybe that's just a side effect of your
> blog software.
>
> 3. The ini file breaks things into sections based on scm, rather than
> based on folder.  This is restrictive in multiple ways: you can't
> define *options* per-scm because the per-scm section is already used
> for lists of folders.  And you can't define options per-folder because
> there is no section to put them into.  I'd recommend an ini structure
> more like this:
>
>      $ cat .externals
>
>      [main]
>      scm = git
>      layout = rails
>
>      [vendor/rails]
>      url = git://github.com/rails/rails.git
>      scm = git
>
>      [vendor/plugins/acts_as_list]
>      url = git://github.com/rails/acts_as_list.git
>      scm = git
>
>      [vendor/plugins/foreign_key_migrations]
>      url = svn://rubyforge.org/var/svn/redhillonrails/trunk/vendor/plugins/foreign_key_migrations
>      scm = svn
>
>      [vendor/plugins/redhillonrails_core]
>      url = svn://rubyforge.org/var/svn/redhillonrails/trunk/vendor/plugins/redhillonrails_core
>      scm = svn
>
> Note that it's longer this way, but much more extensible and it's
> pretty obvious what it means just by looking at it.  Also, most of the
> "scm=" lines are actually redundant: externals should be able to
> auto-detect them anyhow.  In the [main] section, the scm in question
> is obvious, because if you can read the .externals file, you know
> which scm it is.  In the other sections, the URL method: string will
> (most of the time) reveal the scm type.  For ones where it doesn't,
> like http:, then you could supply scm= or default to the same scm as
> [main].
>
> 4. The built-in rails directory layout support makes me nervous and is
> decidedly non-obvious.  As a Rails developer, presumably I know that
> when I check out (magic url string) that it should to into (magic path
> string), and I can supply both.  I'd rather not supply just one and
> *hope* that the ext program knows wtf I want.  In my own case, I'm not
> even a Rails developer, so I'm even more nervous.
>
> 5. There is no reason to use the ext command to create new subtrees
> anyway.  Why not let me check out the subtrees for the first time
> however I might normally do it (git clone, svn co, etc) and *then*
> tell ext to "take a look and write down what I just did"? It saves you
> teaching people new command line syntax.  Plus I can do a trial run
> without touching the ext command, and if it works, I can just say
> "great, save these settings" by typing something like "ext save".
>
> 6. What about .externals files inside nested projects?  I (really do)
> have a project that uses a git-submodule called myproj, and *that*
> project contains a directory called mylib (ie. myproj/mylib).  I would
> expect to have a main .externals file and a myproj/.externals file.
> If I call ext from the toplevel, I'd expect it to be smart enough to
> see both files and do something sane.
>
> 7. I really appreciate git-submodule's ability to lock to a specific
> commit, although apparently you don't like this.  The reason it's
> valuable is for consistency: whenever I check out my project, the unit
> tests should *always* pass.  But if I automatically get the very
> latest version of some subproject, they might break my tests, which is
> highly annoying.  Sometimes we want to get the latest version of
> everything (which svn:externals and current ext makes easy and
> git-submodule makes hard).  But other times, we just want to get a
> precisely accurate historical version, which git-submodule makes easy
> but ext makes hard.  This would actually be pretty easy for you to
> implement if we use the new ini file layout above: just add an
> *optional* entry in each section called "revision =".  In svn, it's a
> revision number; in git, it's a commit id.  Also, as you correctly
> observed, git-submodule's tendency to check things out on a
> disconnected HEAD is horrible and error prone.  A "branch =" ini
> variable would solve that right away (defaulting to 'master' if not
> provided), and also let you tell 'git clone' which branch to checkout
> in the first place, which is not actually obvious.  You could
> auto-record these variables as part of "ext save", and auto-grab the
> latest in a new "ext latest" command.  ("ext update" is not a good
> name, as updating does different things on different scms, while
> "latest" is unambiguous).
>
> 8. Branch switching.  If I switch my main project from one branch to
> another using git (and yes, I do this very frequently!) I need my
> submodules to keep working properly.  git-submodule fails
> spectacularly at this: 'git submodule init' writes stuff into my
> .git/config file, which isn't per-branch, even though .gitmodules is,
> but .gitmodules is ignored (except for *new* submodules) after the
> first init.  It also never auto-unregisters submodules when they
> disappear from .gitmodules, and totally can't handle a submodule that
> moves from one place to another in the local repo.  svn:externals is
> differently, but about equally, awful; it goes on wild deletion sprees
> when it's in a bad mood.  Pretty much anything remotely sane you do
> here will beat any existing implementation I know of.  Key feature:
> don't *delete* submodule dirs when I switch to a branch that doesn't
> need them, but stash them away somewhere and bring them back when I
> switch back - remembering that when you go to bring them back, we may
> want a different revision, branch, and directory name, but it still
> makes sense to start with the version we had before.
>
> 9. Ordering of 'git push' operations.  Currently with git-submodule
> it's easy to check something into a subproject, commit the new gitlink
> into the parent project, and then push the parent project, while
> forgetting to push the subproject back where it came from.  If ext
> could enforce this somehow (eg. have a 'recursive push' sort of
> operation that does innermost first) it would be awesome.
>
> 10. Self hosting.  Because ext isn't included with any scm, if I use
> it in my project I have an extra dependency that people need in order
> to build it, and not everybody has 'gem'.  It would be great if ext
> could drop itself into a subdir of my project and manage updating
> itself to the latest version automatically when I ask.  Sadly, I guess
> it can't itself be a submodule because of the chicken-and-egg problem
> :)
>
> I look forward to hearing from you tomorrow when all my suggestions
> are implemented :)
>
> But seriously, I don't mind helping out with a few of these if you
> like the sound of these ideas.  I don't have a tonne of time, but the
> correct working of submodules is very important to me, and I'm
> suffering a lot at work from the lack of it, so alleviating suffering
> == worth my time.
>
> Have fun,
>
> Avery
>
