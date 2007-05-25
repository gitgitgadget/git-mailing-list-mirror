From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] Add git-submodule command
Date: Sat, 26 May 2007 00:01:50 +0200
Message-ID: <8c5c35580705251501u6346c27by1d133efc3d157bf2@mail.gmail.com>
References: <8c5c35580705250752k2021f02dv804d87da5c0d5da7@mail.gmail.com>
	 <11801165433267-git-send-email-hjemli@gmail.com>
	 <Pine.LNX.4.64.0705251924280.4648@racer.site>
	 <7vodk8r97s.fsf@assigned-by-dhcp.cox.net>
	 <8c5c35580705251329u33ac1462m9db35cac0c37e3a9@mail.gmail.com>
	 <7v4pm0r5ga.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org,
	"Linus Torvalds" <torvalds@linux-foundation.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 26 00:02:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrhrF-0001cj-5c
	for gcvg-git@gmane.org; Sat, 26 May 2007 00:02:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753002AbXEYWBw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 18:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753190AbXEYWBw
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 18:01:52 -0400
Received: from nz-out-0506.google.com ([64.233.162.228]:3273 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753002AbXEYWBv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 18:01:51 -0400
Received: by nz-out-0506.google.com with SMTP id n1so444649nzf
        for <git@vger.kernel.org>; Fri, 25 May 2007 15:01:50 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eCKaqczxhEFxnMSq9LpXDxRGe3B+HouRPEBt7r4UuVDO3ImOj307uN8GSYjuJKNvcewJF7hiqYovlDuFczZgfN4jpe6TmeGir/dA4UCVhqxF1pmMcyRCk6w4jhOiRss3SyixJxxy0qVta8PqVkwOJ9gfGAK1l14VGaVFvtpEiHM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uh3bsXDdWNhB7ORCqj9w8/3S/UZweVNkdzbA0UUfOc+vNMCuHsd5Qn7Q/BYR3RDxVoccBhJduPVsXzxAhu78x73vWELtORvLU6eOfhrJyViKEwdzjDWSvppCv+7RLENL5E/+b9kfcP5XEbTOBNHAlGlWRbMZy7eT+f4acHKbDrE=
Received: by 10.114.135.1 with SMTP id i1mr1679600wad.1180130510404;
        Fri, 25 May 2007 15:01:50 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Fri, 25 May 2007 15:01:50 -0700 (PDT)
In-Reply-To: <7v4pm0r5ga.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48424>

[This thread is starting to get long, sorry for even more noise about
the submodule stuff]

On 5/25/07, Junio C Hamano <junkio@cox.net> wrote:
> "Lars Hjemli" <hjemli@gmail.com> writes:
>
> > On 5/25/07, Junio C Hamano <junkio@cox.net> wrote:
> > ...
> >> I really do not want that (mis)conception that .gitmodules
> >> specify the default and .git/config the override.  I really
> >> think we should use the .git/config as _the_ only authority to
> >> get URL, but keyed with the three-level scheme, with URL in
> >> .gitmodules used _solely_ as a hint when setting up the URL in
> >> the .git/config file.
> >>
> >>         cf. $gmane/47502, 47548, 47621
> >>
> >
> > I've read these articles, but I think much of the concerns about
> > trusting the url supplied by upstream goes away when the submodule
> > clone/checkout isn't an integrated part of the superproject
> > clone/checkout. Besides, if you trust your upstream enough to clone
> > their repository (the superproject), why wouldn't you trust the data
> > (.gitmodules) in that very repository?
>
> It's not about trusting.  You would need to support the mapping
> for network connectivity reasons, and you would also need to
> notice and reconfirm when the suggested URL in .gitmodules
> changes (perhaps because the upstream relocated from sf.net to
> repo.or.cz ;-), you would need something like what I described
> in order to keep track of user preference for each submodule in
> .git/config anyway.  If that "mapping" ends up to be ident
> mapping for most people, that is fine.  At least by always doing
> the three-level mapping we would not have any special case in
> the code, and this is not the performance critical part of the
> system.
>
> I think the response to the case when upstream repository
> relocates from the ".gitmodule for default, .git/config for
> override" camp would be "you asked to override in .git/config,
> so it is your job to notice the change in .gitmodules and adjust
> your override URL".  That is a serious mistake in usability
> point of view.  Repository relocation would (hopefully) seldom
> happen, but when it does happen, things either would break
> (which is easier to diagnose and manually fix up), or things
> clone fine but we reach a wrong repository (which is harder to
> notice, as "fetch" may succeed -- it just would not fetch the
> right commit).  Being able to notice when upstream repository
> relocates and to ask for confirmation when that happens would
> eliminate a lot of confusion from that.

Basically, I'd say that as long as the superproject names the sha1 of
the submodule commit, nothing else matters.

If you track a submodule, you would easily notice it if the submodule
has the 'wrong' commit checked out (git diff, git status, git
submodule status). And 'git submodule update' would synchronize the
submodules you have decided to track, or error out with a message like
"Unable to checkout '$sha1' in submodule '$path'".

This is when the ugly sides of submodules raises its head (the
'official' repo has moved, my local repo is out of date, whatever). I
just don't see the need for solving those problems now. The 'git
submodule' command would make the common cases easier. Hopefully(?)
that would encourage more people to test/use submodules, and the
problems that actually _needs_ solving will then show up in due time.

> > Another possibility is simply doing the submodule clone/checkout by
> > hand (i.e. do 'git clone preferred-url path', don't do 'git submodule
> > init path').
>
> But that is what this patch is trying to help the users, isn't
> it?  It reduces the attractiveness of this new tool greatly if
> you give up there.

Well, I happen to think that the average user of submodules wouldn't
care the slightest bit where the submodule was cloned from, as long as
the sha1 matches. So no, the patch was more about the lack of
submodule porcelain and less about completeness.


> >>When the name of the commit object in the
> >> superproject tree and/or index is 0{40}, it would be a good
> >> extension to use "whatever commit that happens to be at the tip
> >> of this branch" taken from the .gitmodules file.
> >
> > I really can't imagine what kind of superproject would have such a
> > setup. Why would this be needed?
>
> "We would work with any working version of Linux 2.6 kernel"
> would be a sensible thing to say, I would think.

Maybe. I wouldn't want to automatically track the tip of _any_ branch,
since I would have no way of knowing if what works today will also
work tomorrow (or even compile).

> It's purely optional, and as you seem to agree always detaching
> HEAD is easier to explain, you do not need "module.$path.branch"
> at all.  I just mentioned 0{40} as a possible use case for that
> configuration variable.

Ok.

I'll redo the patch, removing the branch-specific things, and try to shut up :)

-- 
larsh
