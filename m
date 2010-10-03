From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC] New type of remote helpers
Date: Sun, 3 Oct 2010 15:56:16 +0200
Message-ID: <AANLkTikQyVLyH-O-OH2yZ0B3_UKDqzcnNgtqefSCN68t@mail.gmail.com>
References: <4CA86A12.6080905@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Sun Oct 03 15:56:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2P3T-00052Y-CE
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 15:56:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753909Ab0JCN4i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 09:56:38 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55107 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849Ab0JCN4h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Oct 2010 09:56:37 -0400
Received: by iwn5 with SMTP id 5so5782583iwn.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 06:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Uope/gmlAWefiwG0mShxeOK20V3R4byfZScw6/eeolM=;
        b=Y8XefFVm+Shb01iWEy8GU3ycXtnXfpUDAXLHLxWwxi52Myh/OlVbuau9EPrA/XmCRw
         DxXQ+X6riJ9a3rLhpytJUThdGGY+c+KbpwVk1HxuauWWEangKpt/rhKxOplalRm1CIo5
         +UoqE4KEaIqbk5pqFxLkTgjI2cS+zGm/pysRI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=HJ1WZsp877mJ2t7ZlXVsghzLwapYofzmtivSKkHtJmlPpAzkdedExogCemKWClpTcq
         PMtBaC/ifeyTm0GUySS4XrGb/FQrJFxt7KtDHSkP+YmjtIYOkkgXI8UcKOAq9KWERZ65
         Lu6HbTgl6W3WiSNRRZsApKQ2vQdhuyfQKhLpI=
Received: by 10.231.36.8 with SMTP id r8mr3905154ibd.128.1286114196220; Sun,
 03 Oct 2010 06:56:36 -0700 (PDT)
Received: by 10.231.33.138 with HTTP; Sun, 3 Oct 2010 06:56:16 -0700 (PDT)
In-Reply-To: <4CA86A12.6080905@dbservice.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157873>

Heya,

On Sun, Oct 3, 2010 at 13:33, Tomas Carnecky <tom@dbservice.com> wrote:
> My work has the goal of making interaction with foreign SCMs more
> natural. The work that was done on remote helpers is the right
> direction. But the 'import' and 'export' commands are the wrong appro=
ach
> I think.

I'm not convinced that they are, but we'll see.

> The problem I have with 'import' is that updating the refs is
> left up to the remote helper (or git-fast-import). So you lose the ni=
ce
> output from ls-remote/fetch: non-ff and other warnings etc.

This is a good point, and I like the patches addressing this.

> I slightly
> modified how the remote helpers (and fast-import) work, now they beha=
ve
> exactly like 'core' git when fetching: Git tells the remote helper to
> fetch some refs, the helper does that and creates a pack and git then
> updates the refs (or not, depending on fast-forward etc).

Again, these patches I like, and would like to see them included. I'll
probably pick them up and send them out as part of my next
git-remote-hg reroll if nothing happens with them.

> To test this
> approach I created a simple remote helper for svn.

I guess it suffices as a POC, but I'd have preferred to see
collaboration with the people working on git-remote-svn instead
(cc-ed).

> $ git ls-remote svn::/Volumes/Dump/Source/Mirror/Transmission/
> r1017 (impure) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trunk
> r919 (impure) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 branches/nat-traversal
> r480 (impure) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 branches/0.6
>
> Git learned to understand version numbers from foreign SCMs. Git
> displays those as 'impure' because it knows that version exists but d=
oes
> not know yet which git commit that version maps to.

Very interesting. This is a useful feature, I approve.

> $ git fetch svn::/Volumes/Dump/Source/Mirror/Transmission/
> *:refs/remotes/svn/*
> From svn::/Volumes/Dump/Source/Mirror/Transmission
> =C2=A0* [new branch] =C2=A0 =C2=A0 =C2=A0trunk =C2=A0 =C2=A0 =C2=A0->=
 svn/trunk
> =C2=A0* [new branch] =C2=A0 =C2=A0 =C2=A0branches/nat-traversal -> sv=
n/branches/nat-traversal
> =C2=A0* [new branch] =C2=A0 =C2=A0 =C2=A0branches/0.6 -> svn/branches=
/0.6

Interesting, if you do 'git remote add svn
svn::/Volumes/Dump/Source/Mirror/Transmission/' and then do 'git fetch
svn', do you get (more or less) the same output?

> Git tells the remote helper to 'fetch r1017 trunk'. =C2=A0The remote =
helper
> does that, creates the pack and then tells git that it imported r1017=
 as
> commit c5fed7ec. This is done with a new reply to the 'fetch' command=
:
> 'map r1017 c5fed7ec'. The remote helper can use that to inform core g=
it
> as which git commit the impure ref was imported. Git can then update =
the
> refs. At no point does the remote helper manipulate refs directly.

I love this. Very elegant.

> The pack is created by a heavily modified git-fast-import. The existi=
ng
> fast-import not only creates the pack but also updates the refs. This=
 is
> no longer desired as git is in charge of updating the refs.

NAK. I object against forking git fast-import just for this purpose.
I'd much rather just modify git fast-import to learn to learn not
update refs, which should be easy enough.

> My modified
> fast-import works like this: After creating a commit, it writes it's =
git
> object name to stdout. That way the remote helper can figure out as
> which git commits the svn revisions were imported and relay that back=
 to
> core git using the above described 'map' reply.

Work has been underway to teach git fast-import to do just this
(courtesy of Jonathan), no need to fork git fast-import to achieve
that.

> $ git show --show-notes=3Dsvn svn/trunk
> commit c5fed7ecc318363523d3ea2045e1c16a378bb10c
> Author: livings124 <livings124@localhost>
> Date: =C2=A0 Wed Oct 18 13:57:19 2006 +0000
>
> =C2=A0 =C2=A0more traditional toolbar icons for those afraid of chang=
e
>
> Notes (svn):
> =C2=A0 =C2=A0b4697c4a-7d4c-4a30-bd92-6745580d73b3/trunk@1017

Very nice! I'm definitely stealing the note-generating code for git-rem=
ote-hg.

> The svn helper needs to be able to map svn revisions to git commits.
> git-svn does this by adding the 'git-svn-id' line to each commit
> message. I'm using git notes for that and it seems to work just fine.
> The note contains the repo UUID, path within the repo and revision.

Very elegant.

> There was a challenge how to update the notes ref (refs/notes/svn). A=
s
> with fast-import, I did not want the remote helper to do it. Neither =
the
> remote helper nor fast-import should be writing any refs. But core gi=
t
> can only update refs which were discovered during transport->fetch().=
 I
> modified the remote helper 'fetch' command and the transport->fetch()
> function to return an optional list of refs. These are the refs that =
the
> remote helper wants to update but which should not be presented to th=
e
> user (because these are internally used refs, such as my svn notes).

Nice.

> So the whole session between git and my svn remote helper looks like =
this:
>> list
> < :r1017 trunk
>> fetch :r1017 trunk
> [helper creates the pack including history up to r1017 and associated
> svn notes]
> < map r1017 <commit corresponding to r1017>
> < silent refs/notes/svn <new commit which stores the updated svn note=
s>

Looks good.

> $ git fetch svn::/Volumes/Dump/Source/Mirror/Transmission/
> *:refs/remotes/svn/*
> From svn::/Volumes/Dump/Source/Mirror/Transmission
> =C2=A0 c5fed7e..228eaf3 =C2=A0trunk =C2=A0 =C2=A0 =C2=A0-> svn/trunk
>
> $ git fetch svn::/Volumes/Dump/Source/Mirror/Transmission/
> *:refs/remotes/svn/*
> From svn::/Volumes/Dump/Source/Mirror/Transmission
> =C2=A0 228eaf3..207e5e5 =C2=A0trunk =C2=A0 =C2=A0 =C2=A0-> svn/trunk
> =C2=A0* [new branch] =C2=A0 =C2=A0 =C2=A0branches/scrape -> svn/branc=
hes/scrape
> =C2=A0* [new branch] =C2=A0 =C2=A0 =C2=A0branches/multitracker -> svn=
/branches/multitracker
> =C2=A0* [new branch] =C2=A0 =C2=A0 =C2=A0branches/io -> svn/branches/=
io

Note to other reviewers: the repository was updated in between
successive calls to 'git fetch', see below.

> Updating the svn branches works like expected. The remote helper
> automatically detects which branches it already imported (by going
> through all refs and the attached svn notes) and creates a new pack w=
ith
> the new commits. New branches are also detected. The svn notes are
> updated accordingly.

I assume this only works for regular svn repositories? I guess it
doesn't really matter to the rest of the series, since the
'git-remote-svn' helper is more of a POC I think?

Most of your extensions to the helper protocol make sense. However,
after re-reading your series I think we _should_ keep the 'import' and
'export' command, so that helpers don't have to invoke 'git
fast-import' or 'git fast-import' themselves. I suspect it will be
more efficient than your approach as well. Speed _is_ a very important
concern, to have decent support for foreign
remotes, imports/exports should be as fast as possible. Also, this
series doesn't address pushing back to the foreign scm, which is very
convenient through the 'export' command.

Either way, thank you very much for working on this!

--=20
Cheers,

Sverre Rabbelier
