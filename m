From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Q] Mark files for later commit?
Date: Tue, 29 Mar 2011 00:51:35 -0700
Message-ID: <7v8vvytldk.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=rPAQas3gvHJ+EFYTXP_YXuULQMk8o8pgkj=9T@mail.gmail.com>
 <7voc4uto9o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Daniel =?utf-8?Q?Nystr=C3=B6m?= <daniel.nystrom@timeterminal.se>
X-From: git-owner@vger.kernel.org Tue Mar 29 09:51:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4TiV-0007OZ-Fr
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 09:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752223Ab1C2Hvq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2011 03:51:46 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34129 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752177Ab1C2Hvp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2011 03:51:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5A5BC29E4;
	Tue, 29 Mar 2011 03:53:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=hL2LmaWPzFn5
	NbkUyBcGzvzmntw=; b=T/apyM7OuyXZh6wjLyKfBLi5tjyiZKvBaNF1qZHrLYdz
	ckhR4jaPg01KAc/2v6zP2Tz4SUk7L+iFzfHwbtikI/Iu5GbhL6hMJ7uUk4aPTA9S
	ufmpXCe3CmIsG1O+bCbnZHEndYwT38RZJJ+NIo0j7ml2+uaEa74nqJhy7LhxOIM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=pVtXiu
	QZvfZTIOsMXMzm1blZboQCK81xzr9lOoeiRmVKn3EgdUwMNkKsSCXNMt31h5RY0s
	Cs9pVtOhFQhdDbg3x1xtSxhBWOH1qwSJ2nI+oG0Kg4d6tjZFP2lOJjhXddIk2Qil
	/jzwaQOAO+ygMqWZVkubsbe2scVfF4aWNiwa4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2B89229E0;
	Tue, 29 Mar 2011 03:53:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0D42529DD; Tue, 29 Mar 2011
 03:53:24 -0400 (EDT)
In-Reply-To: <7voc4uto9o.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 28 Mar 2011 23:49:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A1F3B0EA-59D9-11E0-B624-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170244>

Junio C Hamano <gitster@pobox.com> writes:

> Daniel Nystr=C3=B6m <daniel.nystrom@timeterminal.se> writes:
>
>> So this makes me wonder, is there a way to mark certain files for
>> being committed later on? Which does not automatically get added to
>> the staging area (on "git commit -a" or "git add ." and so on) unles=
s
>> it's specifically mentioned by "git add"?
>>
>> We've discussed making it generated automatically, but that's not as
>> easy as it may sound.
>>
>> How would you like a git feature like described above, marking files
>> for later inclusion?
>
> That does not sound like a feature but merely a source of confusion.

Let's step back a bit, as I think "mark them not to be added" is a clas=
sic
XY problem.

=46irst let's concentrate on this part: "a certain file contains a huma=
n
written changelog, which is modified (not prepended) for each single
commit in the project, is being committed along with the actual patch."

Doesn't that sound quite similar to our release notes?

So far, I've been updating the file after topics graduate to the 'maste=
r'
branch, but there is no fundamental reason not to make it a responsibil=
ity
of the patch contributors to add an entry to the release notes when the=
y
make their changes to the system.  Then when the topics graduate, the
entry that describes the topic will be automatically merged into the
release notes of the 'master' branch.

What will happen if we made that the convention of our project?  For on=
e
thing, I don't have to spend time on coming up with a concise and clear
description of the topics (the contributor that worked on the topic sho=
uld
be better equipped to describe it than I am).  People may make their ow=
n
entries in the single release notes file in various places (by conventi=
on,
the entries are sorted by the name of the command the change affects,
except for the ones that have system-wide effects that are described at
the top), and merging them might produce many conflicts, though.

But what choice would I have?  Obviously I shouldn't be punting on the
merges, taking one side of the release notes file as the merge result
using "-s ours" or other silly magic and discarding the valuable input
from contributors.  I _do_ want all the release notes entries from all
topics.  Merging such a conflict-heavy file and keeping it maintained
properly is an important part of the job (iow, "suck it up").

I suspect that using the "union" merge attribute may be a possibility i=
n
this case; even though the release notes is not an "append only" file, =
it
is an "insert only" file, and it is a very good candidate for the union
merge driver.

Now let's look at this part: "The changelog is only supposed to be
committed at new releases, but is kept maintained continuously so stuff
won't be forgotten."

You are willing to leave your changes uncommitted in the working tree, =
and
not committing it until the release (perhaps using your Y solution that
lets you mark it not to be committed without --force option), is perfec=
tly
Ok by you.  You are not getting any accident protection benefit from yo=
ur
SCM until the next release point and the intermediate changes between
releases you make to this file are not version controlled.

If that is the case, then probably you shouldn't be even updating the
"changelog" file constantly to begin with.  Instead, how about creating=
 a
separate "changelog+" file that is not tracked, and keep its contents
maintained continuously so stuff won't be forgotten?  When the time to
release comes, you can "mv changelog changelog", and commit it.

That would still require you to find a relevant entry in changelog+ and
modify the true changelog file if you cherry pick a particular change t=
o
an older maintenance track and make a release out of it.  Keeping the
entries in the changelog, and cherry picking the changes together with =
the
associated entries will probably reduce that "remembering" mental burde=
n,
while it may require trivial conflict resolutions in the file that can =
be
helped with the union merge driver.

Just a few cents.
