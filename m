From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: Avery Pennarun's git-subtree?
Date: Mon, 26 Jul 2010 11:15:15 -0400
Message-ID: <4C4DA683.9020102@xiplink.com>
References: <4C472B48.8050101@gmail.com> <AANLkTilivtS4TccZXHz2N_n_2RpY6q_5sw7zwdWKdnYE@mail.gmail.com> 	<AANLkTinl1SB1x1bEObLIo-LWjvxM-Yf1PfdUp4DNJda3@mail.gmail.com> 	<AANLkTikl2zKcie3YGhBHrGbYbX3yB9QCtuJTKjsAfK07@mail.gmail.com> 	<AANLkTimiROxqf7KcRKTZvMvsFdd4w3jK_GLeZR8n7tdA@mail.gmail.com> 	<4C4778DE.9090905@web.de> <AANLkTim9nfRGjhpn2Mj-1GntLsDX7xeyL2pegB84aZX8@mail.gmail.com> 	<m31vavn8la.fsf@localhost.localdomain> <AANLkTimOb2VjYI21wQsC64lm4HsVPwpRWd1twIUBnbJ3@mail.gmail.com> 	<4C49B31F.8000102@xiplink.com> <AANLkTi=LHYDhY=424YZpO3yGqGGsxpY2Sj8=ULNKvAQX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Bryan Larsen <bryan.larsen@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 17:15:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdPP0-0002vN-5O
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 17:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754324Ab0GZPPc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 11:15:32 -0400
Received: from smtp162.iad.emailsrvr.com ([207.97.245.162]:59972 "EHLO
	smtp162.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753134Ab0GZPPc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 11:15:32 -0400
Received: from relay16.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay16.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id A333E1B4248;
	Mon, 26 Jul 2010 11:15:30 -0400 (EDT)
Received: by relay16.relay.iad.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id A6A1C1B4071;
	Mon, 26 Jul 2010 11:15:20 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10) Gecko/20100528 Thunderbird/3.0.5
In-Reply-To: <AANLkTi=LHYDhY=424YZpO3yGqGGsxpY2Sj8=ULNKvAQX@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151844>

On 10-07-23 06:50 PM, Avery Pennarun wrote:
> On Fri, Jul 23, 2010 at 11:19 AM, Marc Branchaud <marcnarc@xiplink.com> wrote:
>> On 10-07-22 03:41 PM, Avery Pennarun wrote:
>>> 1) Sometimes I want to clone only some subdirs of a project
>>> 2) Sometimes I don't want the entire history because it's too big.
>>> 3) Super huge git repositories start to degrade in performance.
>>
>> The reason we turned to submodules is precisely to deal with repository size.
> 
> I believe that's very common.
> 
> However, I wonder whether that's actually a good reason for git to
> develop better submodules, or actually just a good reason for git to
> get better support for handling huge repositories.

I think that's a fundamental question, but part of the problem in coming up
with an answer is that there's no agreed-upon definition of how to handle
huge repos.  People have provided tools that answer the question in ways they
like, but I think the fact that these issues keep coming up is proof that git
isn't there yet.

>>  Our code base encompasses the entire FreeBSD tree plus different versions of
>> the Linux kernel, along with various third-party libraries & apps.  You don't
>> need everything to build a given product (a FreeBSD product doesn't use any
>> Linux kernels, for example) but because all the products share common code we
>> need to be able to branch and tag the common code along with the uncommon code.
> 
> Honest question: do you care about the wasted disk space and download
> time for these extra files?  Or just the fact that git gets slow when
> you have them?

It's not the disk space or the extra download time.  It's how long takes to
checkout all those files, and how long it takes to "git status" in a unified
repo.

>> So a straight "git clone" that would need to fetch all of FreeBSD plus 4
>> different Linux kernels and check all that out is a major problem, especially
>> for our automated build system (which could definitely be implemented better,
>> but still).
> 
> To be absolutely pedantic, the four linux kernels likely share most of
> their objects and so you're only paying the cost (at least during
> fetch) of including it once :)

That is true, but like I said the problem is the checkout.  Our different
products use different kernels (or FreeBSD):

	Product 1 -- Linux vX
	Product 2 -- Linux vY
	Product 3 -- FreeBSD

(Luckily we're currently only using one version of FreeBSD...)

All the products use common code.  When we release, we need to tag the common
code and the particular Linux kernel (or FreeBSD) we built the product with.
 We can't stuff all the Linux kernels into a single submodule, because then
the repo will be "dirty" if we checkout a different Linux kernel to build a
different product.  Even in a unified repo we'd need the kernels to live in
their own trees.

So we've ended up with individual submodules for each Linux kernel, and we've
taught our automated build to only clone/checkout the kernel it needs to
build the target product.  Otherwise the checkout I/O overshadows the actual
build time, especially when we try to run several builds in parallel on one
slave machine.

> (If you're actually using git-submodule and each copy of the kernel is
> its own module, then it might be cloning the kernel four times
> separately, in which case the objects *don't* get shared, so this ends
> up being much more expensive than it should be.  That could be fixed
> by slightly improving git-submodule to share some objects rather than
> rearchitecting it though.)

Even with the --reference parameter, it's still a problem.

>>  In truth it's the checkout that takes the most time by far,
>> though commands like git-status also take inconveniently long.
> 
> Yeah, git could stand to be optimized a bit here.  And since Windows
> stats files about 10x slower than Linux, this problem occurs about 10x
> sooner on Windows, which makes using git on Windows (which sadly I
> have to do sometimes) extremely painful compared to Linux.
> 
> IMHO, the correct answer here is to have an inotify-based daemon prod
> at the .git/index automatically when files get updated, so that git
> itself doesn't have to stat/readdir through the entire tree in order
> to do any of its operations.  (Windows also has something like inotify
> that would work.)  If you had this, then git
> status/diff/checkout/commit would be just as fast with zillions of
> files as with 10 files.  Sooner or later, if nobody implements this, I
> promise I'll get around to it since inotify is actually easy to code
> for :)
> 
> Also note that the only reason submodules are faster here is that
> they're ignoring possibly important changes.  Notably, when you do
> 'git status' from the top level, it won't warn you if you have any
> not-yet-committed files in any of your submodules.  Personally, I
> consider that to be really important information, but to obtain it
> would make 'git status' take just as long as without submodules, so
> you wouldn't get any benefit.  (I think nowadays there's a way to get
> this recursive status information if you want it, but it'll be slow of
> course.)

I'm happy with a "git status" that can ignore uninitialized submodules and
still probe into initialized/cloned ones.  I agree that it's important for
"git status" to be correct.

>> We chose git-submodule over git-subtree mainly because git-submodule lets us
>> selectively checkout different parts of our code.  (AFAIK sparse checkouts
>> aren't yet an option.)
> 
> Fair enough.  If you could confirm or deny my theory that this is
> *entirely* a performance related concern (as opposed to disk space /
> download time), that would be helpful.

Consider it confirmed.  Honestly, disk space is a complete non-issue.  It's
always nice to have faster download times, but it hasn't been an issue for us
and there are already several ways to work around it anyway.

>>  We didn't really consider git-subtree because it's
>> not an official part of git, and we didn't want to have to teach (and nag)
>> all our developers to install and maintain it in addition to keeping up with
>> git itself.
> 
> Arguably, this is a vote for including git-subtree into the core
> (which was Bryan's point when he started this thread); it obviously is
> being rejected sometimes by git users simply because it's not in the
> core, even though it could help them.

Yes, I have no objection to seeing git-subtree becoming an official part of
git.  My only complaint would be that it doesn't really help git deal with
huge repos.

		M.
