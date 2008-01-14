From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Adding Git to Better SCM Initiative : Comparison
Date: Mon, 14 Jan 2008 09:58:10 +0300
Message-ID: <20080114065810.GY2963@dpotapov.dyndns.org>
References: <200712101357.49325.jnareb@gmail.com> <200801130144.14574.jnareb@gmail.com> <20080114001408.GV2963@dpotapov.dyndns.org> <200801140131.23027.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shlomi Fish <shlomif@iglu.org.il>, git@vger.kernel.org,
	Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>,
	David Kastrup <dak@gnu.org>, Florian Weimer <fw@deneb.enyo.de>,
	Chris Shoemaker <c.shoemaker@cox.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 07:58:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEJHV-0005Ko-Le
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 07:58:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbYANG6O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2008 01:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbYANG6O
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 01:58:14 -0500
Received: from smtp03.mtu.ru ([62.5.255.50]:49473 "EHLO smtp03.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751245AbYANG6N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2008 01:58:13 -0500
Received: from smtp03.mtu.ru (localhost.mtu.ru [127.0.0.1])
	by smtp03.mtu.ru (Postfix) with ESMTP id 7359C18701D6;
	Mon, 14 Jan 2008 09:58:11 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-140-170-195.pppoe.mtu-net.ru [85.140.170.195])
	by smtp03.mtu.ru (Postfix) with ESMTP id 90C22187038B;
	Mon, 14 Jan 2008 09:58:10 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JEJGs-0006IZ-G4; Mon, 14 Jan 2008 09:58:10 +0300
Content-Disposition: inline
In-Reply-To: <200801140131.23027.jnareb@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp03.mtu.ru 10002; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70445>

On Mon, Jan 14, 2008 at 01:31:19AM +0100, Jakub Narebski wrote:
> On Mon, 14 January 2008, Dmitry Potapov wrote:
> 
> > Yes. Git can automatically detects renames and show history together,
> > however being content oriented rather than file oriented, the notion of
> > "retaining the history of the file" can not exactly applied to it.
> 
> "History of a file" can be defined as "<scm> log 'file'", and this is
> well defined also for git. 

You missed the key word here -- *retaining*. In fact, if you define the
history of a file just as something what "<scm> log" produce then what
is the problem with CVS here? Why do most people say that CVS does not
retain file history over rename? Certainly, you can type "cvs old-name"
and see history of one file, and if you type "cvs new-name" then history
of another... But somehow most people think about these two pieces as
being the history of *one* file... So, your definition is incorrect or,
at least, very different from what most people mean by that.

BTW, when you type "git log 'file'", it shows you not history of a file,
but history of changes that affect the specified paths...

> And 'rename support' for file means just
> that this history of a file (of a current file contents) follows file
> renames.

To equate a file with its contents is like to equate a variable with
its value. They are not exactly the same. If you renamed a file and
completely changed its contents, is it still the same file or not?
If you think about file as being inode then the answer is yes, but if
look at its content then the answer is no.

Git tracks contents, while many other SCMs tracks files regardless of
their contents. So, Git can show the history of file contents, but
not the history of a file...

> 
> IIRC this des not work for directories... 

Git works for directories, it is just that the --follow option cannot
applied to it, because this option means to follow the file contents,
which does not make much sense for directories.

> but on the other hand git,
> tracking contents only as a goal, does not track directories.

Exactly.

> > 
> > Git is different in that it tracks the content as the whole rather than
> > tracking a set of files. When you look at some source code, what you
> > really want to know who and why wrote *this*, and usually it does not
> > matter to you whether it was written in this file or another one. CVS
> > is really bad at that, because if you renamed a file, it would be very
> > difficult to go back to history and find that. Many file-ids based SCMs
> > have solved this problem, however, they do not do any better than CVS
> > in another very common case -- when your code is moved around as result
> > of refactoring, but Git addresses both problems, not just one!
> 
> AFAIK Mercurial (hg) is not file-id based, but does explicitely track
> renames. There was even an idea presented on git mailing list to mark
> renames in commit object in some "note" header.

I suspect the main reason why Mercurial support that is that a lot of
programmers whose mind was mangled by many years of CVS experience asked
for that feature. In practice, what you really want to track is contents.
And it is not difficult to add some "note" to the commit and teach Git to
follow it, but I don't see any practical value in that...

> > So, it is not as much about explicit renaming vs automatic, but about
> > different design goals. After finishing reading this questionnaire,
> > it seems to me that a more proper title for it would be "Better CVS
> > Initiative", so it is not surprisingly that Git does not fit into it
> > well. It is like trying to put characteristics of your LCD into a
> > questionnaire for CRT monitors -- some does not make sense, other
> > misleading, and most important ones are not mentioned anyway...
> 
> Please remember that AFAIK this table is _older_ than Git itself.
> But it is a fact that some characteristics are much patterned after
> CVS features and misfeatures.

Well, if it is so old, that explains why it gave me such impression...

> 
> It would be much better if for each feature there was some test
> described which would allow to check if the feature is supported.

Wanna test your LCD monitor with some old CRT tests? -:)

> 
> By the way, even before "git log --follow" you could have "this file
> was renamed to that file" in the commit/revision patchset. 

You could write that in CVS message too, but I don't think it can
be considered as retaining the history of the file...


Dmitry
