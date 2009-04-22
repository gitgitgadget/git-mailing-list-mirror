From: skillzero@gmail.com
Subject: Re: How to merge from newer branch to older branches?
Date: Wed, 22 Apr 2009 14:01:01 -0700
Message-ID: <2729632a0904221401u43af69a5ncec0f3f274ad648f@mail.gmail.com>
References: <2729632a0904211224x6e2621caxf6c169d90b760530@mail.gmail.com>
	 <20090421193615.GB7832@coredump.intra.peff.net>
	 <7vmya946fg.fsf@gitster.siamese.dyndns.org>
	 <2729632a0904221044q20e6cabau7dd06b3020a8ce49@mail.gmail.com>
	 <20090422201541.GC14146@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 22 23:03:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lwjau-0001zh-8s
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 23:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754011AbZDVVBG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Apr 2009 17:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752652AbZDVVBE
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 17:01:04 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:45467 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753856AbZDVVBD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2009 17:01:03 -0400
Received: by qw-out-2122.google.com with SMTP id 5so167808qwd.37
        for <git@vger.kernel.org>; Wed, 22 Apr 2009 14:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7wIXlHCvVxxrE5mk7Ss6aIq8wwoKfIeb2Cas0XQvJ5M=;
        b=i5a6Dxwzoq2mMFsY1e8TfHzS9qC6L9KEIVu9vdc4zxl24OsyHGN6s+pN7Y8Y5tLR/1
         7yi34elDwD17RowPjCn3vewsn9cYwXSyMaR50dq+iWCArAm3AGWZrO29T+SlvNTst3/M
         SWbC4yOgadqs4BvkU/wtJG8d9lguXbuqUh3+U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Q5GrE3DGJQ4ttulklhqmlpqC7I7YlOsZp3GpncHzDpXuBkw1iZyHBpTvHA1J0uA/fL
         yjbP2s/ESXW9R/mjHAtvqLwXv85G4E0S5xx1ToYgn3uVJTdCy3WiEuNoCcB0YH4HrtAo
         XtKxzIjRO0dEdIFgMo9v/N3KV/Jy5d2vp4bcg=
Received: by 10.224.89.77 with SMTP id d13mr334222qam.376.1240434061665; Wed, 
	22 Apr 2009 14:01:01 -0700 (PDT)
In-Reply-To: <20090422201541.GC14146@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117260>

On Wed, Apr 22, 2009 at 1:15 PM, Jeff King <peff@peff.net> wrote:
>
> On Wed, Apr 22, 2009 at 10:44:06AM -0700, skillzero@gmail.com wrote:
>
>> It seems like this merge conflict is going to cause problems if I tr=
y
>> to re-merge to pick up a bug fix to 'feature' in the future. Looking
>> at the documentation, it sounds like 'git rerere' can help by
>> re-applying the manual conflict resolution I did?
>
> It shouldn't. Remember that your merges into 1.1, 1.2, etc, created a
> new merge base. So when you have bug fixes to make to this topic, you
> don't put them on the "feature" branch, but onto this topic branch. T=
hen
> you re-merge the topic branch into 1.1., 1.2, feature, etc, and it wi=
ll
> look only at the new bugfix.

I'm not sure I understand. When I did the original rebase of "feature"
onto the merge-base of all the branches I wanted to merge to (v1.1 and
v1.2 in this case), the end result was that "feature" is now based on
the merge-base. When I merged "feature" into 1.1, I had to fix some
conflicts so in the log I see my conflict fix commit then a merge
commit, but "feature" wasn't changed (only v1.1 was).

I was thinking that if I find a bug in my original "feature" branch, I
would commit the fix to the "feature" branch then merge that into
v1.1, v1.2, master, etc. But I was thinking that when I tried to merge
"feature" into v1.1 (which previously needed a commit to fix
conflicts), I'd need to re-fix those same conflicts.

When I look at the log for v1.1 though, maybe I just misunderstood the
way the conflicts are resolved in git? I was thinking the conflicting
merge would end up as one big commit that's a combination of the
"feature"'s commits and my conflict fixes.

But in the log for v1.1, it looks like my conflict fixing commit may
have just "fixed" the v1.1 branch such that it could accept a
"feature" merge without conflict. If that's true then a future merge
of "feature" containing new commits should just merge without
conflict. That would be awesome if that's the way conflicting
resolving in git works.

> However, the first entry in the reflog for that branch ref should
> indicate branch creation (unless it is so old that it has expired).
> Something like:
>
> =C2=A0$ git branch foo origin/master
> =C2=A0$ git reflog show foo
> =C2=A00be9bc0 foo@{0}: branch: Created from origin/master
>
> So 0be9bc0 would be the creation point in this case. But you might ha=
ve
> totally rewritten the branch after that point, so 0be9bc0 might not b=
e a
> useful value anymore.

Thanks, that shows what I need. For my case, it happened to be @{58}.
Is there a way to reverse the order or a special syntax to say "0 from
the end"? Trying --reverse said "cannot combine --reverse with
--walk-reflogs" and trying @{-1} show me something else.
