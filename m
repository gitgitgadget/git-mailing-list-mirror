From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Re: Merge with git-pasky II.
Date: Fri, 15 Apr 2005 01:31:59 +0200
Message-ID: <20050414233159.GX22699@pasky.ji.cz>
References: <Pine.LNX.4.58.0504132020550.7211@ppc970.osdl.org> <7vfyxtsurd.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org> <7v64ypsqev.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org> <7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net> <20050414121624.GZ25711@pasky.ji.cz> <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net> <20050414193507.GA22699@pasky.ji.cz> <7vmzs1osv1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 01:29:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMDm4-0006z2-Sb
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 01:29:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbVDNXcs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 19:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbVDNXcs
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 19:32:48 -0400
Received: from w241.dkm.cz ([62.24.88.241]:5326 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261650AbVDNXcB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 19:32:01 -0400
Received: (qmail 21592 invoked by uid 2001); 14 Apr 2005 23:31:59 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vmzs1osv1.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Apr 15, 2005 at 01:12:34AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> >>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:
> 
> PB> What I would like your script to do is therefore just do the
> PB> merge in a given already prepared (including built index)
> PB> directory, with a passed base. The base should be determined
> PB> by a separate tool (I already saw some patches); most future
> PB> "science" will probably go to a clever selection of this
> PB> base, anyway.
> 
> I think you are contradicting yourself for saying the above
> after agreeing with me that the script should just work on trees
> not commits.  My understanding is that the tools is just to
> merge two related trees relative to another ancestor tree,
> nothing more.  Especially, it should not care what is in the
> working directory---that is SCM person's business.

Yes. Isn't this exactly what I'm saying?

I'm arguing for doing less in my paragraph, you are arguing for doing
less in your paragraph, and we even seem to agree on the direction in
which we should do less.

> I am just trying to follow my understanding of what Linus
> wanted.  One of the guiding principle is to do as much things as
> in dircache without ever checking things out or touching working
> files unnecessarily.

I'm just arguing that instead of directly touching the directory cache,
you should just list what would you do there - and you already do this,
I think. So I'd be happy with a switch which would just do that and not
touch the directory cache. I'll parse your output and do the right thing
for me.

> PB> This will give the tool maximal flexibility.
> 
> I suspect it would force me to have a working directory
> populated with files, just to do a merge.

Why would that be so?

> PB> I'm all for an -o, and I don't mind ,, - I just don't want it uselessly
> PB> long. I hope "git~merge~$$" was a joke... :-)
> 
> Which part do you object to?  PID part?  or tilde?  Would
> git~merge do, perhaps?  It probably would not matter to you
> because as an SCM you would always give an explicit --output
> parameter to the script anyway.

Yes. I'll just override it with ,,merge, I think. So, do whatever you
want. ;-))

> PB> By the way, what about indentation with tabs? If you have a
> PB> strong opinion about this, I don't insist - but if you
> PB> really don't mind/care either way, it'd be great to use tabs
> PB> as in the rest of the git code.
> 
> I do not have a strong opinion, but it is more trouble for me
> only because I am lazy and am used to the indentation my Emacs
> gives me.  I write code other than git, so changing Perl-mode
> indentation setting globally for all .pl files is not an option
> for me.  I'll see what I can do when I have time.

Doesn't Emacs have something equivalent to ./.vimrc? I've also seen
those funny -*- strings.

Well, if it would mean a lot of trouble for you, just forget about it.

> PB> Is there a fundamental reason why the directory cache
> PB> contains the ancestor instead of the destination branch?
> 
> Because you are thinking as an SCM person where there are
> distinction between tree-A and tree-B, two heads being merged.
> There is no "destination branch" nor "source branch" in what I
> am doing.  It is a merge of two equals derived from the same
> ancestor.

That's a valid point of view too.

Actually, when you would have a mode in which you would not write to the
directory cache, do you need to read from it? You could do just direct
cat-files like for the other trees, and it would be even faster. Then,
you could do without a directory cache altogether in this mode.

> PB> And this is another thing I dislike a lot. I'd like merge-tree.pl to
> PB> leave my directory cache alone, thank you very much. You know, I see
> PB> what goes to the directory cache as actually part of the policy part.
> 
> Remember I am not touching *your* dircache.  It is a dircache in
> the temporary merge area, specifically set up to help you review
> the merge.  

Yes, but I want to have a control over its dircache too. :-) That is
because I want the user to be able to use the regular git commands like
"git diff" there.

> Can't the SCM driver do things along this line, perhaps?
> 
>  - You have your working files and your dircache.  They may not
>    match because you have uncommitted changes to your
>    environment.  You want to merge with Linus head.  You know
>    its SHA1 (call it COMMIT-Linus).  Your SCM knows which commit
>    you started with (call it COMMIT-Current).
> 
>  - First you merge the tree associated with COMMIT-Current.  Use
>    it and COMMIT-Linus to find the common ancestor to use.
> 
>  - Now use the tree SHA of COMMIT-Current, tree SHA1 of
>    COMMIT-Linus, and tree SHA1 of the common ancestor commit to
>    drive git-merge.perl (to be renamed ;-).  You will get a
>    temporary directory.  Have your user examine what is in
>    there, and fix the merge and have them tell you they are
>    happy.
> 
>  - You go to that temporary directory, do write-tree and
>    commit-tree with -p parameter of COMMIT-Linus and
>    COMMIT-Current.  This will result in a new commit.  Call that
>    COMMIT-Merge.
> 
>  - You, as an SCM, should know what your user have done in the
>    working directory relative to COMMIT-Current.  Especially you
>    should know the set of paths involved in that change.  Go in
>    to the temporary area, checkout-cache those files if you have
>    not done so.  Apply the changes you have there.  Optionally
>    have the user examine the changes and have him confirm.  Lift
>    those files into the user's working directory.
> 
>  - Do your bookkeeping like "echo COMMIT-Merge >.git/Head", to
>    make the user's working files based on COMMIT-Merge, and run
>    read-tree using the COMMIT-Merge in the user's working
>    directory.  At this point, show-diff output should show what
>    the changes your user have had made if he had started working
>    based on COMMIT-Merge instead of starting from
>    COMMIT-Current.
> 
> I think the above would result in what SCM person would call
> "merge upstream/sidestream changes into my working directory".

And that's exactly what I'm doing now with git merge. ;-) In fact,
ideally the whole change in my scripts when your script is finished
would be replacing

	checkout-cache `diff-tree` # symbolic
	git diff $base $merged | git apply

with

	merge-tree.pl -b $base $(tree-id) $merged | parse-your-output

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
