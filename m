From: "Kaizer H. Sogiawala" <kaizers@gmail.com>
Subject: Re: git-p4 - workflow suggestions
Date: Fri, 4 Feb 2011 09:41:36 -0800
Message-ID: <AANLkTimF0AJLLAwVCY=yDqySrT8UunscUYopypei23UX@mail.gmail.com>
References: <AANLkTik3iFXZE6KSvSSgka3rJyCQbPXpUrTWRGyonfT=@mail.gmail.com> <AANLkTik7Gv6vOgYNyuz-TCD6SAPV5G8f7RujEpfEYU3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tor Arvid Lund <torarvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 04 18:42:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlPfZ-0004p7-8L
	for gcvg-git-2@lo.gmane.org; Fri, 04 Feb 2011 18:42:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743Ab1BDRl6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Feb 2011 12:41:58 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52908 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837Ab1BDRl5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Feb 2011 12:41:57 -0500
Received: by gyb11 with SMTP id 11so1020657gyb.19
        for <git@vger.kernel.org>; Fri, 04 Feb 2011 09:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=tccvzhyaqNkvgwS9x7T/RG5t8kJt3yuv+rFGIqQwF9I=;
        b=cX6VTr81OQtXaeo2hRlYQXQ54R+3tXYGoUyETGmwrDx0gEc9QyvQfa/IL6/cyZ2TOJ
         WeRWFgrqZ06g3kokoRKav69VQ+6DrXTUcsaue8vus7rHI4YaR0bc+J0o78GE1jEJTFmI
         8ry3bjQ5mdVNOdjKH7pXDhSNazBqbUM+efvlY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=W8G1MJbuAzbVsDYF0ClwG3FAGPurxxeWxijNa/mUakmYPsiLxWcvp7pLCDyVsMuNnw
         dJgiGLhtB8+h16OArySjn57ks7fYU7MNy7AVqv2qurotn9WSbn/rfswzyU4uwEGAEq3z
         /6UXv/8hefv4v+oYv4b960kHiGQcVLhyelFq0=
Received: by 10.147.170.14 with SMTP id x14mr166972yao.36.1296841316589; Fri,
 04 Feb 2011 09:41:56 -0800 (PST)
Received: by 10.147.169.8 with HTTP; Fri, 4 Feb 2011 09:41:36 -0800 (PST)
In-Reply-To: <AANLkTik7Gv6vOgYNyuz-TCD6SAPV5G8f7RujEpfEYU3Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166050>

Thanks a bunch Tor. It seems you are using a non-bare repo as the
"blessed" repository and mitigating the risk or getting the workspace
messed up by always "pulling" changes that need to go in Perforce. I
will give it a try and post back.

Thanks for the post.

On Fri, Feb 4, 2011 at 2:26 AM, Tor Arvid Lund <torarvid@gmail.com> wro=
te:
> On Fri, Feb 4, 2011 at 1:23 AM, Kaizer H. Sogiawala <kaizers@gmail.co=
m> wrote:
>> Hi,
>>
>> We are primarily a Perforce shop. I am looking for a git-p4 workflow
>> that will alllow a sub-team (2-20 developers) to use git as their
>> primary source control repository. This sub-team is tasked with
>> refactoring and will need heavy-duty branch/merge support. The
>> main/central source code repository (and branch) is in Perforce.
>>
>> I am looking at approaches that will allow me to "git-p4 clone" from
>> Perforce (a branch in perforce, say trunk) into a bare/shared git
>> repository. This repository is then cloned by each developer of the
>> git-sub-team to perform regular development/push/pull/merge/rebase
>> activities.
>
> Hey! Yes, this should be possible - at least to some extent. What I
> did personally, was to keep things as simple as possible, and decide
> early on that I wouldn't hope to be able to do *everything* with
> git-p4/perforce that I *could* do in git. [branch/merge tradeoff
> details will follow]
>
>> Periodically, a gatekeeper would pull changes from Perforce to git a=
nd
>> push changes from git to Perforce. Can this be done?
>
> I think I did kind of what you describe... I had one "blessed" git-p4
> repo. That repo would be setup by:
>
> git p4 clone --import-local //depot/path@all myproject
>
> (The "--import-local" makes sure that the p4 branch is placed in
> refs/heads/ instead of refs/remotes. Better when the actual users
> clone the git repo later...)
>
> Then I made a simple script that would loop through all my git-p4
> projects... basically just 'cd' into the dir and do 'git p4 sync'.
> This script would be run by a cron job every <whatever> minutes so it
> would always be reasonably up-to-date.
>
>> So far, I have looked at the:
>> - git-p4 documentation
>> - Version Control with Git book By: Jon Loeliger (particularly the
>> git-svn section)
>> - Mailing list (particularly following thread answered by Tor Arvid =
Lund)
>> - googl'n around this topic
>>
>> Most discussion is around how to use git-p4 as a sync mechanism for =
a
>> single user. When I attempt to git-p4 clone (import) and then create=
 a
>> shared/bare repository out of it and emulating multiple user, the
>> git-p4 sync mechanism breaks down after couple of merges. The git-p4
>> sync/rebase/submit will try to reapply duplicate changes and trip
>> pretty early in the cycle.
>>
>> If you have a working model of making available a p4 branch for a
>> sub-team using git-p4, I would really appreciate a writeup or blog.
>> Thanks in advance.
>
> Ok, so to make things practical, I made some simple 'rules' for mysel=
f:
>
> * The blessed git repo would be "pull-only" for the git users. That i=
s
> - no one pushes to that repo. It reads from p4, and the users do 'git
> fetch/pull' from that. Nothing more, nothing less...
>
> * When preparing commits for upload to perforce, *always* rebase them
> on top of the latest git-p4 tip.
>
> I never tried to do merges in git, and then try to turn that into
> 'integrates' in perforce. So I always kept the perforce-things
> 'linear' so that the communication between git and perforce should be
> easy. IOW I always did the "official" branching and integrate'ing
> using the perforce client.
>
> We did 'git p4 submit' directly from the users' git repos (which woul=
d
> be synced by the blessed git repo, and from there to the other git
> users). If you want another layer in-between [we use gerrit
> code-review... You may have something else, or an integration manager
> etc], you could push to another <some-project-manager-repo> and do al=
l
> git-p4 submits from there, I guess...
>
>
> Of course, these branch/merge limitations only apply to my git histor=
y
> at the point where I want to push to perforce. In all my daily work, =
I
> create topic branches, rebase, reorder commits... all of the git
> goodness. I simply "linearize" things when I want to push...
>
>
> In your use-case, if you are going to do work that will result in man=
y
> perforce integrates, you may have a harder time with git-p4 than I
> did, but it should be worth a try so that you can delight in daily gi=
t
> usage instead of cursing the awfulness that is perforce.
>
> And yes, git-p4 does rewrite every commit after you submit it. This i=
s
> because of the quite simple design that was used to help git-p4 "know=
"
> what had been synced from perforce to git. Commit messages get the
> appended "[git-p4: depot-paths =3D ... change =3D 12345]" line. If gi=
t-p4
> had been written today, this could have maybe been solved using
> git-notes instead of rewriting commit msgs. I'm just saying... :)
>
> Otherwise, you will have to get around the fact that it rewrites
> everything. For me, I have used git rebase a *lot* :)
>
> Good luck!
>
> =A0 =A0-- Tor Arvid
>



--=20
Kaizer H. Sogiawala
