From: Jason Sewall <jasonsewall@gmail.com>
Subject: Re: Hey - A Conceptual Simplication....
Date: Wed, 18 Nov 2009 14:52:06 -0500
Message-ID: <31e9dd080911181152h665d5d9dr5c0736c0ca3234c1@mail.gmail.com>
References: <005a01ca684e$71a1d710$54e58530$@com>
	 <20091118142512.1313744e@perceptron>
	 <008401ca6880$33d7e550$9b87aff0$@com>
	 <m37htnd3kb.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: George Dennie <gdennie@pospeople.com>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 20:52:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAqZf-000422-EG
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 20:52:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758449AbZKRTwD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 14:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758373AbZKRTwD
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 14:52:03 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:58274 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758284AbZKRTwB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2009 14:52:01 -0500
Received: by bwz27 with SMTP id 27so1524823bwz.21
        for <git@vger.kernel.org>; Wed, 18 Nov 2009 11:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=w4ldAGyUlrDLovXMdq/4VQ3N7Gu2NRLHN7iqqFkyEPA=;
        b=mFgJNZ4kzXHegDt8kW+DMkIJMtzGDiG5g//GtPGhRUmLT06AsI8rmdrRwdMj5jiUA+
         6J4iqrOPO6WWFHtTyu34Ot59N3mTuS1MtiK1XzYYX7fdBbxpxbCH72VpMK3NFVarxj7Z
         puEMr//dNRkLi5kY+g5/Jz/zl223c/3KDdCIk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=njXa3Sa1iOSSCz5WUZGUaxyE8eQ4+ymZ3JsoWdaHIXzw6p/Bu2f3pPoLHu4SWLGM7B
         i3eY2kjipaYtbcIEKUpV/XqggJtG80ro+5GMaQpXyhaoZUarBMI1jLxedTKPUolghU+g
         MkIRxYKuXbPZl8FiogYu8Z+XrM1flT5k8+gaU=
Received: by 10.216.90.203 with SMTP id e53mr1556989wef.28.1258573926495; Wed, 
	18 Nov 2009 11:52:06 -0800 (PST)
In-Reply-To: <m37htnd3kb.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133197>

Sorry for the 2x post, George; forgot to include the list in my reply....

On Wed, Nov 18, 2009 at 1:51 PM, George Dennie <gdennie@pospeople.com> wrote:
[some cleanup of quote line wrapping]
> Jason Sewall wrote...
>> If you have a bunch of debugging code sitting around in your
>> working tree after you've tracked down a problem, you don't want to
>> commit all of those printfs, etc. - you want to commit the
>> fix. This has ramifications from making diffs of history cleaner to
>> making git bisect actually useful.

> One of the concerns I have with the manual pick-n-commit is that you
> can forget a file or two. Consequently, unless you do a clean
> checkout and test of the commit, you don't know that your
> publishable version even compiles.  It seems safer to commit the
> entirety of your work in its working state and then do a clean
> checkout from a dedicated publishable branch and manually merge the
> changes in that, test, and commit.

I find git status very useful in preparing a commit; untracked (and
'un-ignored') files are listed right there and I can if there are new
source files that are not present but not tracked.  You could even add
a 'pre-commit hook' to make sure that you don't have any untracked *.c
(or whatever) files before you actually make the commit.

As to 'publishable' version, it's probably a good idea to run 'make
distcheck' or the equivalent before making a release anyway.

> It seems the intuitive model is to treat version control as applying
> to the whole document, not parts of it. In this respect the document
> is defined by the IDE, namely the entire solution, warts and
> all. When you start selectively saving parts of the document then
> you are doing two things, versioning and publishing; and at the same
> time. This was a critical flaw in older version control approaches
> because the software solution document is a file system sub-tree.

I find this leads to big, shapeless commits and, as I mentioned
before, it seriously limits the utility of 'git bisect'.  I also fail
to see how 'selectively saving parts of the document' is versioning
and publishing - what is the publishing part?  The act of committing
is one thing (and 'saving parts of the document' is one conceivable
name for it) and publishing another.  Your workflow may vary, but
before actually 'publishing' (perhaps pushing out to a public repo, or
merging into a public branch), it's probably a good idea to test the
code with whatever system you use anyway.

> What you termed the debugging/printf's I would treat as a
> distinctions between a debug vs. a release version that may be
> suitably delineated by #define's or preferably separate unit tests
> assemblies. If I must prune prior to committing; however, then it
> seems reverting spurious printf's may offer a more reliable and
> automatable technique than ensuring that I have added all the new
> class files, resource files, text files, sub projects, etc; that may
> constitute the "fix." Once so selectively reverted I can test and
> commit such a publishable version.

What if you are hacking away and make changes to several parts of the
code at once?  Making the commits as fine-grained as possible makes it
easier to cherry-pick, bisect, and understand the history.

As to debugging code, I admit I sometimes will use git gui or git add
-p to stage just what I want and then put whatever is 'left over' in a
branch that I might use again later if another bug comes up.  Then I
can reset --hard my 'working' branch and the debugging code is gone.

> Jason Sewell wrote...
>>  Isn't fastidiously maintaining a .gitignore file to contain
>> everything you *don't* want in the project more confusing than
>> explicitly specifying things you *do* want in the project?
>
> This is git ignore for "cleaning prior to a check" and git ignore
> for "adding to index" and is not an either or. You would specify
> what you don't want to version tracked as normal but you can also
> stipulate what you don't want to be deleted during a clean restore
> (which should otherwise completely wipe the folder prior to
> restoring a specific commit). This would permit embedding
> non-version elements within the version tree for whatever reason you
> find necessary.

Perhaps I don't understand your scheme, but it sounds like you're
advocating 2 .gitignores:

* .gitignore_track; with everything you don't automatically staged but
 which can be trashed by your cleaning checkout
* .gitignore_keep; with things you don't want staged but which
  shouldn't be deleted by git during cleaning

That seems even more confusing.  I'm actually having trouble seeing
why you want this untracked-file nuking checkout at all.  Care to give
an example?

> Thomas Rast wrote...
>> That would require supernaturally good maintenance of your
>> .gitignore to
> avoid adding or (worse) nuking files by accident.
>
> On the contrary, the approach would all but eliminate the
> possibility of loss of data since you would not manually (and
> therefore error prone-ingly) pruning until after a commit. In fact,
> one might default automatic commits (if required) prior to checkouts
> or at least an alert system when uncommitted changes exists.

Who is pruning after a commit?  Once nice thing about checkout is that
it will refuse to move to a different commit if there are files that
will get trashed.  Then you can say 'oops, I should stash/commit/nuke
that stuff before I change HEAD.

Jason
