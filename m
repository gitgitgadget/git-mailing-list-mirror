From: P Baker <me@retrodict.com>
Subject: Re: [RFC GSoC 2009: git-submodule for multiple, active developers on 
	active trees]
Date: Tue, 31 Mar 2009 18:32:00 -0400
Message-ID: <526944450903311532u24eb74fby1f558c1bef5c653a@mail.gmail.com>
References: <526944450903251314o622711b5u3665bac90398d6be@mail.gmail.com>
	 <20090330153245.GD23521@spearce.org>
	 <526944450903310830q5f56fe82xb64ae8dc3c954ffb@mail.gmail.com>
	 <alpine.DEB.1.00.0903311749160.7052@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 01 00:33:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LomWa-0000yY-0a
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 00:33:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757281AbZCaWcJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Mar 2009 18:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756278AbZCaWcH
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 18:32:07 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:46787 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755032AbZCaWcE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Mar 2009 18:32:04 -0400
Received: by qyk16 with SMTP id 16so5011849qyk.33
        for <git@vger.kernel.org>; Tue, 31 Mar 2009 15:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=52wcTTA2+G7SxuaDhj+ykDsMSoF3/GhzBNhokrpRuTY=;
        b=uFWCmq0+JqKOLZ54rbzoKtb2fIr8eJqVcX5B1WZRFeRn/UbN/H2nhR5t1uGhECXf35
         rFaKLvWU6fzKEC5nOGiPkDZzTYZnvtF0kKVLdU1CzcpOzw4vLbuUu+vR/IHGMs3vFpLF
         Y1ov5v5JVefDaPETyjMFf0TeR0wEeojmAK3go=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=Mh4uZ5pbiPTCyb4QrDDxMlGDpf79VclCGHoXlTo5BZbxTJnbpouC0di1BKy8ubkFbH
         wIlxa6p1dXK2xS5T02KZGprs6G+CefBUd/rK86xN0+jp7evR7xxsOE8ajHxaf+5ovJPV
         0yYSZriNdlSImoedOCDPWkLulpuBpCIlosIw8=
Received: by 10.220.76.144 with SMTP id c16mr2889444vck.17.1238538720900; Tue, 
	31 Mar 2009 15:32:00 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0903311749160.7052@intel-tinevez-2-302>
X-Google-Sender-Auth: de24e1cbcab6b89f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115326>

Thanks for the comments, my replies are included. It's good to see
some core folks are big users!

On Tue, Mar 31, 2009 at 11:57 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> I am a rather intense user of submodules, so I am quite interested.
>

I'm curious, where/under what circumstances do you tend to use it?

> Please take my comments as encouragement rather than discouragement.
>

Always.

>> *move objects of submodules into base .git/ directory
>> **This would, as I understand it: protect submodules from being
>> overwritten and changes lost when switching between branches of the
>> superproject that might or might not contain the submodules and
>> centralize their management into one location.  The added benefits o=
f
>> fully using git's ability to branch and merge submodules makes it
>> worth adding some complexity within the .git directory.
>
> The main problem with renaming/deleting is not the repository of the
> submodule, but the working directoy.
>

My understanding is that since the submodule objects (history) is
stored in a .git directory in the subdirectory where the submodule is
located, removing that subdirectory during checkout of a branch that
does not include that submodule eliminates the .git directory as well.
Moving the objects from the submodule's .git directory to the base
=2Egit directory would seem to alleviate this problem.

>> *use .git instead of .gitmodules
>> **I actually don't know why this was included with the project
>> description, I searched for an explanation of the desired name chang=
e
>> on the mailing list and in commit messages, but came up with nothing=
=2E
>
> AFAICT somebody thought that the information about the locations of t=
he
> submodules should be in .git/ rather than in the working directory.  =
But
> of course, that is wrong: you want it to be tracked.
>

So, in looking back through the archives of the mailing list there
seems to be some disagreement between using .gitmodules and
=2Egit/config to track submodules.

>> *git submodule update --init should initialize nested levels of subm=
odules
>> **As an ease of use command, either an additional flag to recurse ca=
n
>> be added, or it can act by default. As a requested feature on the
>> mailing list, this is worth implementing.
>
> I thought there was a patch to support "git submodule recurse"?  That
> would be rather less limited than yet another option to submodule upd=
ate.
>

There is a git submodule foreach command, but it doesn't look like the
patch for git submodule recurse
(http://marc.info/?l=3Dgit&m=3D120997867213008&w=3D2) has been incorpor=
ated
into a public release.

That is one route, on the other hand, the default action is also open
to question. When I update a submodule, I would probably expect that
anything it depends on is also updated. The default action probably
should be recursive.

>> *ability to update submodule pulled from svn repo
>> **One workaround is to clone it as local copy using git-svn and then
>> import that local clone as a submodule; clearly a clunky solution.
>> There are many requests for this feature (see
>> http://panthersoftware.com/articles/view/4/git-svn-dcommit-workaroun=
d-for-git-submodules
>> for a typical example), and it makes sense integrating git-submodule
>> with git-svn would expand submodule's usefulness.
>
> I do not think that this would be good.  Both "git svn" and "git
> submodule" are rather complex by now, and mixing them would only
> complicate code.
>

Hm, point well taken, but it would seem to have enormous benefit for a
lot of people. I can move it down the priority list, but I'd like to
include it in the proposal - complexity alone isn't a good reason to
avoid something.

I also believe that the workaround described, if incorporated into
git-submodules.sh in an appropriate way might open up possibilities
for further improvement. The UI would change much, seems like it'd
just be detection of pointing to a SVN repo instead of a git repo and
then hooking into git svn calls instead of regular git calls. This
brings up the possibility that git submodules should abstract its
repository handling in much the same way that git does. I'm not
familiar with the code, but this seems more like calling other
plumbing hooks than anything else.

>> *make submodules deal with updated references
>> **Instead of issuing merge conflicts on updated submodule references=
,
>> this will allow submodules on default detached HEAD so that changes
>> from the local repo can be committed without first pulling changes
>> from the shared repo.
>
> I'd rather call this "make git-submodule help with merging".
>

Better name. Duly noted. Will change.

>> *protect changes in local submodules when doing =E2=80=9Cgit submodu=
le update=E2=80=9D
>> **This is similar to the previous point, in that changes need to be
>> protected or merged or warnings issued when updating the submodule.
>> The potential to lose work with no warning is a big no-no.
>
> One word: Reflogs.
>

I  haven't used reflogs, but it doesn't seem to fix the problem (maybe
you can explain?): simply knowing where/what the reference is, doesn't
mean that git-submodule looks at it, obeys the reference or issues
warnings when it should. The problem as stated
(http://flavoriffic.blogspot.com/2008/05/managing-git-submodules-with-g=
itrake.html?showComment=3D1211380200000#c3897235118548537475)
was that git submodule update would silently overwrite any local
changes with the remote version (i.e. git did not check to see if the
local reference was different than the remote reference when
updating).

>> *make git submodules easy to remove
>> ** See http://pitupepito.homelinux.org/?p=3D24, for an example of wh=
y
>> this is a pain. Adding a submodule has ui, removing one should as
>> well.
>
> AFAIR there was already a patch to implement this, but the OP apparen=
tly
> did not address all issues.
>

Yep, found it on the mailing list. Obviously, part of the project
would be to resolve those final issues.

Phillip Baker
