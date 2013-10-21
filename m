From: Shawn Pearce <spearce@spearce.org>
Subject: Re: RFE: support change-id generation natively
Date: Mon, 21 Oct 2013 16:07:30 -0700
Message-ID: <CAJo=hJudnWqCTG=j_hQjZMzYarDTH5THZOEbftLjpwKUNusrEQ@mail.gmail.com>
References: <2127507934.9293293.1382367063640.JavaMail.root@openwide.fr>
 <1382370119.28365.36627953.50C0496E@webmail.messagingengine.com>
 <CAJo=hJtbciJ3Qg8jo4U5fZ9onf2R2XOospYKGS-jCYz4p-nwRw@mail.gmail.com> <20131021163812.GA27125@domone.podge>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: james.moger@gitblit.com, Jeremy Rosen <jeremy.rosen@openwide.fr>,
	git <git@vger.kernel.org>
To: =?ISO-8859-2?B?T25k+GVqIELtbGth?= <neleai@seznam.cz>
X-From: git-owner@vger.kernel.org Tue Oct 22 01:08:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYOZt-0005SN-0o
	for gcvg-git-2@plane.gmane.org; Tue, 22 Oct 2013 01:08:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559Ab3JUXHx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Oct 2013 19:07:53 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:50027 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751463Ab3JUXHw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Oct 2013 19:07:52 -0400
Received: by mail-wg0-f46.google.com with SMTP id m15so7153489wgh.13
        for <git@vger.kernel.org>; Mon, 21 Oct 2013 16:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=abd2dWPC0Y9nOZSlCpsknddjlUdpDyveYhfodhBKdQs=;
        b=KTNzCvwmAyNTVfrupYQpYVVaaEhRAswebL6LpYK7L3uX7W9Ow2xx/vXjRPEeHOhF2d
         g1xq0RtB+lUSIAmEpoiGKKjslvhFG57iDItzt/OI1BvuW4ADxkNXMdLX1kQ4AjJw+m3r
         GxpM1PoYC1vrdcbXt9YGRxk+mBYQvyThe47gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=abd2dWPC0Y9nOZSlCpsknddjlUdpDyveYhfodhBKdQs=;
        b=TnNTf86Ueiccfg4hX0VNXWiOL31pNoHZq18xon+98w9yGzHF+cdpwSNusFApRgXeN+
         JatGwwihdEclcY/KgqJ1L6KBHvn0FLT43JoJEN+XikgFALG5zcL3+Msv6IqcR+hLeQiL
         0D509/G5btAVjRc5zmYlzuMBaZ9EoJPg6SDQ8iNY0/aJ4KvPxLm1f3TTTnuGAYO3Z6Mc
         vH5qWEP4r1aalZ6vs8Q6pPbMJrnGzkl/RcyIneQtsFzwYTV0VqzQyCE6QkCKawB+5uX1
         bJHM4xOtoSHYn84YiDjsa7MqYQK1pwMoCBrnc+ttIbbGx96RdJVmnD8QX1cuvciLAfC/
         ySBg==
X-Gm-Message-State: ALoCoQk7HJ39OvxLHhQ4Dsmc45XH232bWapFUduaWyiA4A2q7QaWEck2sKtdr4pkpYyGLNlSg7fG
X-Received: by 10.180.36.242 with SMTP id t18mr11678785wij.28.1382396870704;
 Mon, 21 Oct 2013 16:07:50 -0700 (PDT)
Received: by 10.227.62.140 with HTTP; Mon, 21 Oct 2013 16:07:30 -0700 (PDT)
In-Reply-To: <20131021163812.GA27125@domone.podge>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236450>

On Mon, Oct 21, 2013 at 9:38 AM, Ond=C5=99ej B=C3=ADlka <neleai@seznam.=
cz> wrote:
> On Mon, Oct 21, 2013 at 09:35:07AM -0700, Shawn Pearce wrote:
>> On Mon, Oct 21, 2013 at 8:41 AM,  <james.moger@gitblit.com> wrote:
>> > The change-id is exactly like a commit-id, it is an SHA-1 value, b=
ut it
>> > is a constant embedded in the commit message.
>>
>> https://gerrit-review.googlesource.com/Documentation/user-changeid.h=
tml
>> goes into more detail about these.
>>
>> > Commit-ids change all the time because of amend; change-ids are co=
nstant
>> > and they are the key that links commit revisions to a discussion.
>>
>> In a mailing list based workflow, when an author revises a patch
>> series and resends the new patches aren't linked to the old patches =
in
>> a MUA, because the Message-Ids of the original versions were not
>> preserved. Imagine if Git saved that original Message-Id somewhere a=
nd
>> could properly write In-Reply-To headers so that attempt #2 for each
>> patch replies to the end of the thread discussing attempt #1 of the
>> same patch. In a 30 patch series. Gerrit does this with Change-Id.
>>
>>
>> We briefly considered putting the Change-Id into the commit headers
>> (e.g. below the optional encoding) but could not because `git commit=
`
>> doesn't support this. So it went into the footer along with
>> Signed-off-by provenance data, which is also not expressible in
>> headers.
>
> What about adding that as Note?

If it was a note, the note would need to be updated every time the
user updated their commit locally. So `git commit --amend` and `git
rebase` (all forms) would be required to update the note with the new
commit SHA-1 so the value isn't lost.

If it was a note, the author would also have to push their notes
branch to the Gerrit server when they push their commits. This is
likely to be forgotten, since its a different branch than the branch
the user is working on. The server only needs notes for the new
incoming commits, but the notes branch will probably bring all
activity the author has been doing. So maybe the author should have
one notes branch per topic branch. And clean up the notes branches
after they delete their local topic branches. Etc.

notes are great, but they get messy. And back when Gerrit introduced
support for Change-Id (more than 4 years ago) I don't think note
support even existed. Or if it did, it was no where near as complete
as it is today.
