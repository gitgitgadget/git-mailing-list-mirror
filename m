From: "Roman V. Shaposhnik" <rvs@sun.com>
Subject: Re: Intricacies of submodules
Date: Thu, 17 Apr 2008 12:50:08 -0700
Message-ID: <1208461808.26863.129.camel@goose.sun.com>
References: <47F15094.5050808@et.gatech.edu>
 <8FE3B7A7-4C2D-4202-A5FC-EBC4F4670273@sun.com>
 <32541b130804082033q55c795b5ieaa4e120956ff030@mail.gmail.com>
 <49E9DCEC-8A9E-4AD7-BA58-5A40F475F2EA@sun.com>
 <32541b130804082334s604b62b0j82b510c331f48213@mail.gmail.com>
 <7vhcebcyty.fsf@gitster.siamese.dyndns.org>
 <6CFA8EC2-FEE0-4746-A4F6-45082734FEEC@sun.com>
 <7v63uqz265.fsf@gitster.siamese.dyndns.org>
 <1207859579.13123.306.camel@work.sfbay.sun.com>
 <7vd4oxufwf.fsf@gitster.siamese.dyndns.org>
 <46dff0320804110904w531035f4w79c1889bc90c09ee@mail.gmail.com>
 <7vmyo0owep.fsf@gitster.siamese.dyndns.org> <1207970038.10408.8.camel@ginkgo>
 <7vlk3jlkrr.fsf@gitster.siamese.dyndns.org>
 <1208202740.25663.69.camel@work.sfbay.sun.com>
 <7vd4or7wdt.fsf@gitster.siamese.dyndns.org>
 <1208317795.26863.91.camel@goose.sun.com> <87lk3c4ali.fsf@jeremyms.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, Ping Yin <pkufranky@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	stuart.freeman@et.gatech.edu, git@vger.kernel.org
To: Jeremy Maitin-Shepard <jbms@cmu.edu>
X-From: git-owner@vger.kernel.org Thu Apr 17 22:04:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmZyP-0003HH-PY
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 21:40:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755767AbYDQTkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 15:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752991AbYDQTj7
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 15:39:59 -0400
Received: from sca-es-mail-1.Sun.COM ([192.18.43.132]:35998 "EHLO
	sca-es-mail-1.sun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755664AbYDQTj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 15:39:58 -0400
Received: from fe-sfbay-09.sun.com ([192.18.43.129])
	by sca-es-mail-1.sun.com (8.13.7+Sun/8.12.9) with ESMTP id m3HJdt8F014516
	for <git@vger.kernel.org>; Thu, 17 Apr 2008 12:39:56 -0700 (PDT)
Received: from conversion-daemon.fe-sfbay-09.sun.com by fe-sfbay-09.sun.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 id <0JZH00H01II4CS00@fe-sfbay-09.sun.com> (original mail from rvs@sun.com)
 for git@vger.kernel.org; Thu, 17 Apr 2008 12:39:55 -0700 (PDT)
Received: from [192.168.0.103] ([76.21.110.21])
 by fe-sfbay-09.sun.com (Sun Java System Messaging Server 6.2-8.04 (built Feb
 28 2007)) with ESMTPSA id <0JZH00311IMA49F0@fe-sfbay-09.sun.com>; Thu,
 17 Apr 2008 12:39:47 -0700 (PDT)
In-reply-to: <87lk3c4ali.fsf@jeremyms.com>
X-Mailer: Evolution 2.12.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79815>

On Thu, 2008-04-17 at 14:09 -0400, Jeremy Maitin-Shepard wrote:
> > And here's one more thing: in-tree .gitconfig and in-tree 
> > update-my-git-settings.sh are absolutely identical as far
> > as their security ramifications are concerned. If you really paranoid
> > you have to eyeball either of them.
> 
> There is a huge difference: if you allow in-tree .gitconfig by default,
> then git clone <some-repository> becomes an unsafe operation.  I can't
> even inspect some arbitrary repository to _see_ if I like the code and
> think it is safe very easily, since I'd normally do that by cloning the
> repository.

Are you saying that a *remote* in-tree .gitconfig would be capable of
affecting *local* system before the end of the clone operation? I find
it very hard to believe. And if it is so, I'd love to be educated on the
subject matter. What I (and to some extent Ping Yin) have been proposing
is a completely different semantics -- the in-tree .gitconfig would only
be able to affect your *local* operations. Doing clone of the *remote*
repository is a safe operation under such assumptions. Once you cloned
it, you might need to eyeball the content of .gitconfig if you're really
paranoid.

> As a silly analogy, it is currently perfectly safe to clone a repository
> that has a text document containing instructions about committing
> suicide, because there is the assumption that the instructions are not
> automatically executed simply because they are on the user's hard drive.

Same holds true for the semantics being proposed. The intsructions are
*not* executed until you actually try to do something with your 
repository. There's a window of opportunity in which inspecting the
content of .gitconfig is absolutely possible.

> > Why? I'm really confused here. Unless I'm given a clear example of at
> > least one setting that somehow becomes dangerous when stored inside
> > in-tree .gitconfig, I really do consider such an enforcement to be
> > as meaningful as enforcing that Git MUST manage source code and nothing
> > else. You seemed to mention the trust issue. Well, why don't you trust
> > the user to place whatever he wants in in-tree .gitconfig? And yes,
> > we are talking about trustworthy users here and repositories that
> > haven't been compromised.
> 
> Obviously any configuration option that specifies a shell command to run
> is unsafe to specify in an in-tree .gitconfig.  As Junio noted,
> smudge/clean commands are especially unsafe because they will be
> executed even if the user only uses the clone command.

I'm sorry but I guess that went over my head. Is this the example of
something that can affect local repository (and host!) during the
clone operation? I tried to find documentation on the subject but
googling for "git smudge" returns very few useful hits and the bits
of documentation in gitattributes(5) don't really explain much.

> You actually seem to be the one assuming that a Git repository must
> store source code (in particular source code that is then blindly
> executed by anyone that clones the repository), as that is the only case
> in which an in-tree .gitconfig can introduce no additional security
> risk, since your security is then already completely dependent on
> trusting the contents of the repository.

There are two things at play: first of all, I usually *do* trust the
content of the repository. Call it matter of personal preference,
but *for me* if you start with distrust -- there's very little you
can do with that repository to begin with. To me it is a bit of 
red herring. On the other hand I understand where you're coming from
and I definitely appreciate the need for a clone operation to be
safe. So far, the only example of an unsafe setting that I have been
given is smudge/clean filters. May be this is enough to shoot the
very idea of an in-tree .gitconfig down, but I still don't really
understand the *complete* semantics of these things. Can somebody
explain, please?

I hope this is not too much to ask.

Thanks,
Roman.
