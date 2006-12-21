From: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
Subject: Re: GIT - error: no such remote ref refs/heads/TestBranch
Date: Thu, 21 Dec 2006 11:49:28 +0100
Message-ID: <slrneokplo.nsf.Peter.B.Baumann@xp.machine.xx>
References: <89b129c60612191233s5a7f36f2hd409c4b9a2bbbc5c@mail.gmail.com> <7v64c7pmlw.fsf@assigned-by-dhcp.cox.net> <87wt4m2o99.wl%cworth@cworth.org> <7vmz5i6vqb.fsf@assigned-by-dhcp.cox.net> <87vek62n1k.wl%cworth@cworth.org> <7v1wmu5ecs.fsf@assigned-by-dhcp.cox.net> <87tzzp3fgh.wl%cworth@cworth.org>
X-From: git-owner@vger.kernel.org Thu Dec 21 11:54:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxLYg-0002Oh-IP
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 11:53:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbWLUKxv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 05:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbWLUKxv
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 05:53:51 -0500
Received: from main.gmane.org ([80.91.229.2]:51129 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964781AbWLUKxu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 05:53:50 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GxLYb-0004qI-4D
	for git@vger.kernel.org; Thu, 21 Dec 2006 11:53:49 +0100
Received: from mason.hofmann.stw.uni-erlangen.de ([131.188.24.36])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Dec 2006 11:53:49 +0100
Received: from Peter.B.Baumann by mason.hofmann.stw.uni-erlangen.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Dec 2006 11:53:49 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: mason.hofmann.stw.uni-erlangen.de
User-Agent: slrn/0.9.8.0 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35051>

On 2006-12-21, Carl Worth <cworth@cworth.org> wrote:
> --pgp-sign-Multipart_Wed_Dec_20_22:55:50_2006-1
> Content-Type: text/plain; charset=US-ASCII
>
> On Wed, 20 Dec 2006 15:36:51 -0800, Junio C Hamano wrote:
>> Do you have comments on recent changes (both on 'master' and
>> some parts of 'next') from teachability point of view?  I think
>> you are "the guilty guy" who defined the theme for v1.5.0 to be
>> "usability and teachability" ;-).
>
> I'm flattered to be blamed for what I consider a very good theme for
> the release.
>
> I don't have a lot of detailed comments right now other than to repeat
> a "good job!" to everyone who has done a lot to improve things lately,
> (coming up with more use-oriented documentation, adding a reasonable
> shorthand "add"[*] for update-index, cleaning up a lot of bad error
> message and needless spew, making much more reasonable default clone
> behavior, etc. etc.). I think git's really come a long ways as far as
> usability and teachability, (while nothing fundamental has really
> changed and old-time users should hardly notice anything different).
>
> I think I'll have a few minor tweaks to suggest to the documentation
> if I get a chance to take a detailed pass over it, (which I hope to do
> before the new year).
>
> And I'd definitely like to enable "git checkout <revision>" with a new
> complaint on git-commit before the 1.5 release. I'll see if I can't
> find time to work on implementing that.
>
> -Carl
>
> [*] I'm still somewhat unsettled that the "new" add command conflates
> the notions of adding content into the index for paths that previously
> didn't exist in the index with the notion of updating the content in
> the index for paths that did exist already. I think those notions are
> generally distinct from the users point of view---the first changes a
> file's state in a fundamental way, (from "untracked" to "tracked"),
> while the second merely updates its content with no change to its
> state.
>
> One way to see the distinction is to imagine two different useful
> operations "add all untracked file paths to the index" and "update
> content for all tracked paths". If we had separate commands for 'add'
> and 'update' then it would be natural to express these two variants
> with "git add --all" and "git update --all".
>

I'm also not so confident about mixing "add NEW files" with "updating
the contents of already known files". I'd prefere to seperate those two
meanings. Having two similarly named files in my workdir, I could easly
misspell the filename and wouldn't even notice that I have added a NEW
file inspite of refreshing the contents of an already existing file.

> As things stand now, the first operation is available already with
> "git add .", (and oddly, with "git add", and I agree that should be
> removed). Meanwhile the second operation is not currently available in
> git, (but I recently proposed it as "git add -a|--all" in response to
> a request). As pointed out in that thread, there's a bit of a problem
> in that "git add --all" is really easy to mistake for a command that
> would add all untracked files to the index, (since it's when adding
> new paths that people will most often use "git add" so it will
> naturally be associated with adding new paths). It's less likely for
> users to establish the "update content" notion of "git add" since it
> often won't be needed at all, (tutorials and the git-commit
> documentation recommend "commit -a" to avoid the need to use "git add"
> in its updating sense).
>
> So, to summarize, I think it's good to have a much shorter command to
> type than "update-index" for the update-content-of-path-in-index
> operation. So using "add" for this is better than "update-index"
> already. And if that's how it stays, I can certainly live with it.
>
> But I think it might be even better if the updating notion were on a
> separate command name (update ? stage ?), and this in spite of the
> fact that fewer commands is generally better for learnability.
>

What about 'refresh'?

> It's not a major issue---and it's nothing that I would make a big fuss
> over, so feel free to ignore it if it appears a non-issue to you.
>
> --pgp-sign-Multipart_Wed_Dec_20_22:55:50_2006-1
> Content-Type: application/pgp-signature
> Content-Transfer-Encoding: 7bit
>
>
> --pgp-sign-Multipart_Wed_Dec_20_22:55:50_2006-1--
