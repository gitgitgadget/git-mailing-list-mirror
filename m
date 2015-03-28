From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: how to make "full" copy of a repo
Date: Sat, 28 Mar 2015 21:33:31 +0100
Message-ID: <CACBZZX6y3OB3y+V6VetHD0ZOxG3T+xsCFXy_-Qj2erLK7-wpEg@mail.gmail.com>
References: <1427511397.19633.52.camel@scientia.net> <5516F856.9010100@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christoph Anton Mitterer <calestyo@scientia.net>,
	Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Mar 28 21:34:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbxQg-0002l2-IC
	for gcvg-git-2@plane.gmane.org; Sat, 28 Mar 2015 21:34:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092AbbC1Udx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Mar 2015 16:33:53 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:35902 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530AbbC1Udw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Mar 2015 16:33:52 -0400
Received: by obbld8 with SMTP id ld8so42450797obb.3
        for <git@vger.kernel.org>; Sat, 28 Mar 2015 13:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=2Nt8925Ny0CmVvXmUJj86q1Hwn4/lKmEAEfnIwWKYDA=;
        b=L5jNHPkUYrtnCc+JpltwLESc2GI0nr/2WSp2Kl4Am2EhFKzJoRj97LvQwSTbg8mwVw
         OcAZWtiCLxfEh1vxurq25wCauOvEMxujQ9b2wLErQn85aLF1oXWzWtr1EaqMJQuSOIbD
         SLcrxyKkqz0RDq89Hii5++KVq1hq5tS3QTGOKGkZoSFRRw7AfJq91CMr90rYoemVuyu0
         hLGGho/2Sh3cq/h4k/5hqlxdtAI74WfJrXJ6Ihz9ydKyeAddC0D23DyrbKyKRBQH7R8r
         SjtVqGhN8t0PQMYrjR5/oHOhb1EZP9tmZjmfXZs3PQdMkYCuPS2WOYtnkUBFlnULQeCt
         geWA==
X-Received: by 10.60.78.72 with SMTP id z8mr20858111oew.13.1427574831881; Sat,
 28 Mar 2015 13:33:51 -0700 (PDT)
Received: by 10.76.82.1 with HTTP; Sat, 28 Mar 2015 13:33:31 -0700 (PDT)
In-Reply-To: <5516F856.9010100@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266425>

On Sat, Mar 28, 2015 at 7:52 PM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> On 2015-03-28 03.56, Christoph Anton Mitterer wrote:
>> Hey.
>>
>> I was looking for an ideally simple way to make a "full" copy of a g=
it
>> repo. Many howtos are floating around on this on the web, with also =
lots
>> of voodoo.
>>
>>
>> First, it shouldn't be just a clone, i.o.w.
>> - I want to have all refs (local/remote branches/tags) and of course=
 all
>> objects from the source repo copied as is.
>> So it's local branches should become my local branches and not remot=
e
>> branches as well - and so on.
>> Basically I want to be able to delete the source afterwards (and all
>> backups ;) ) and not having anything lost.
>>
>> - It shouldn't set the source repo as origin or it's branches as rem=
ote
>> tracking branches, as said it should be identical the source repo, j=
ust
>> "freshly copied" via the "Git aware transport mechanisms".
>>
>> - Whether GC or repacking happens, I don't care, as long as nothing =
that
>> is still reachable in the source repo wouldn't get lost (or get lost
>> once I run a GC in the copied repo).
>>
>> - Whether anything that other tools have added to .git (e.g. git-svn
>> stuff) get's lost, I don't care.
>>
>> - It should work for both, bare and non-bare repos, but it's okay wh=
en
>> it doesn't copy anything that is not committed or stashed.
>>
>>
>>
>> I'd have said that either:
>> $ git clone --mirror URl-to-source-repo copy
>> for the direction from "outside" the source to a copy,
>> or alternatively:
>> $ cd source-repo
>> $ git push --mirror URl-to-copy
>> for the direction from "within" the source to a copy with copy being=
 an
>> empty bare or non-bare repo,
>> would do the job.
>>
>> But:
>>
>> a) but the git-clone(1) part for --mirror:
>>    >and sets up a refspec configuration such that all these refs are
>>    >overwritten by a git remote update in the target repository.
>>    kinda confuses me since I wanted to get independent of the source
>>    repo and this ssems to set up a remote to it?
>>
>> b) do I need --all --tags for the push as well?
>>
>> c) When following
>>    https://help.github.com/articles/duplicating-a-repository/
>>    it doesn't seem as if --mirror is what I want because they seem t=
o
>>    advertise it rather as having the copy tracking the source repo.
>>    Of course I read about just using git-clone --bare, but that seem=
s to
>>    not copy everything that --mirror does (remote-tracking branches,
>>    notes).
>>
>>    So I'm a bit confused...
> This instructions have 3 repos:
> the source, "old", the destination "new" and a temporary one.
> As you only push to "new", "new" should have no information about
> "old" or "temp".
>>
>>
>> 1) Is it working like I assumed above?
>> 2) Does that also copy things like git-config, hooks, etc.?
>> 3) Does it copy the configured remotes from the source?
>> 4) What else is not copied by that? I'd assume anything that is not
>>    tracked by git and the stash of the source?
>
> You didn't write if this is a bare repository,
> if it is on a local disc, if it is reachable by rsync ?
> Linux or Windows ?
>
> For a "full clone" (in the sense of having everything, bit for bit)
> I would probably use rsync. (After stopping all activities on the rep=
o)

This warrants more emphasis. If you rsync a repository that's
"active", i.e. getting pushes you *will* get corrupt copies. E.g. you
can easily copy something out of the objects directory that's in the
middle of being written, or copy the "refs" namespace after you copy
"objects" and end up with an unreachable object.

There's unfortunately no good solution to this other than doing both
git --mirror backups and rsync backups (for hooks etc.) and combining
the two, or pushing a hook for the duration that bans all updates.
