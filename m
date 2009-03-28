From: Elijah Newren <newren@gmail.com>
Subject: Re: How do I force git to forget about merging a binary file that is 
	to stay deleted on the target branch?
Date: Sat, 28 Mar 2009 06:47:38 -0600
Message-ID: <51419b2c0903280547y1bb5664dj70e4e6aa939bd015@mail.gmail.com>
References: <e38bce640903272226l3facf47br9b1849bf708c3881@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Brent Goodrick <bgoodr@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 28 13:49:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnXyO-0006OJ-VZ
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 13:49:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658AbZC1Mrn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Mar 2009 08:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753476AbZC1Mrm
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 08:47:42 -0400
Received: from mail-gx0-f160.google.com ([209.85.217.160]:38298 "EHLO
	mail-gx0-f160.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753463AbZC1Mrm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Mar 2009 08:47:42 -0400
Received: by gxk4 with SMTP id 4so3001191gxk.13
        for <git@vger.kernel.org>; Sat, 28 Mar 2009 05:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6hLcpGPjvnPGXVbyeJxDB6/C9T6p03koqa4bnOZl4rs=;
        b=x5VKVqMRMW9U32u8QG3fa2jDyJGiTC1vyD8VpCdCp3VAwMB4pNcW4jaWpmflN0ru2j
         u6rHYhA/zHc3yPlC7UMW7ZyH54IrLFNc4e8gYmyLizhwhBTajAdDngF/xJlUaFxhHCuW
         ha6dl44Ek4jNY3cAOOKL4WkNg/4RbZaYq629s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pr2lpimvhUjUG8gY5jxAx3Cetu2095bM3cCSLzHQ5PhqNIM4dt65UftR1mQ5DJrFIK
         AI6WFIgDU7/PXcCqvXt0IbJxozEDkW19fruTs0g5Snm5tiIfO1z8Ystp5fpPZCA8c4WU
         mfU7aD880qPP5XG2i1Ciwq4/MHaALZPwpoBcw=
Received: by 10.231.16.74 with SMTP id n10mr686781iba.28.1238244458814; Sat, 
	28 Mar 2009 05:47:38 -0700 (PDT)
In-Reply-To: <e38bce640903272226l3facf47br9b1849bf708c3881@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114952>

Hi,

On Fri, Mar 27, 2009 at 11:26 PM, Brent Goodrick <bgoodr@gmail.com> wro=
te:
> How do I commit a merge but force git to forget about merging one fil=
e
> that I don't want on the target branch, when it is binary, and when i=
t
> was changed on the source branch, but was deleted on the target branc=
h
> (and should stay deleted on the target branch)?
>
> The details: I am merging a "work" branch into a "home" branch. =C2=A0=
There
> is one file called "TimeSheets/Timesheet Exempt.XLS" that is binary.
> I don't want that file on the "home" branch, but do want it on the
> "work" branch. =C2=A0I had made an editing change to that file on the
> "work" branch, along with a bunch of other changes I do want to merge
> into the "home" branch. But no matter what I do, I can't force git to
> forget about that "TimeSheets/Timesheet Exempt.XLS" file.
>
> I've tried various flavors of git-checkout and git-reset to no
> avail. This is what I see at the very last before I gave up:

You can resolve this merge conflict by running
$ git rm TimeSheets/Timesheet\ Exempt.XLS

which will make git delete the file from your working copy and the
index, at which point you can then make a commit that does not include
this file.


> Here is what I'm left with:
>
> ,----
> | $ : gitw status
> | TimeSheets/Timesheet Exempt.XLS: needs merge
> | # On branch home
> | # Changes to be committed:
> | # =C2=A0 (use "git reset HEAD <file>..." to unstage)
> | #
> | <snipped out other files I do want to commit>
> | #
> | # Changed but not updated:
> | # =C2=A0 (use "git add <file>..." to update what will be committed)
> | # =C2=A0 (use "git checkout -- <file>..." to discard changes in wor=
king directory)
> | #
> | # =C2=A0 =C2=A0 unmerged: =C2=A0 TimeSheets/Timesheet Exempt.XLS
> | #
> | $ : gitw commit -m "merge from work"
> | TimeSheets/Timesheet Exempt.XLS: needs merge
> | TimeSheets/Timesheet Exempt.XLS: unmerged
> (49a49bd9de154daa8ca6cff3cfb550d0dd1b4519)
> | TimeSheets/Timesheet Exempt.XLS: unmerged
> (8de60b8b6827ef1f80921f6d35b574a56683bfdd)
> | error: Error building trees
> `----
>
> Any help anyone can provide is greatly appreciated.
