From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 4/4] cache-tree: Write updated cache-tree after commit
Date: Tue, 15 Jul 2014 09:45:44 -0700
Message-ID: <xmqqbnsqwoxz.fsf@gitster.dls.corp.google.com>
References: <1405140276-32162-1-git-send-email-dturner@twitter.com>
	<1405140276-32162-4-git-send-email-dturner@twitter.com>
	<CACsJy8D0CdS5B5xNSSCk+LToXV9FnHFLkPzJ5f-7NTWiw9yn5w@mail.gmail.com>
	<xmqqr41oylyo.fsf@gitster.dls.corp.google.com>
	<53C41456.2000006@ramsay1.demon.co.uk>
	<xmqqvbqzygkm.fsf@gitster.dls.corp.google.com>
	<53C42453.1090109@ramsay1.demon.co.uk>
	<xmqq8unvy4bf.fsf@gitster.dls.corp.google.com>
	<CACsJy8BvQYyXWB7YfoonfEeqi9gStEZHqKC_JNAhxZbLJas54w@mail.gmail.com>
	<CAPc5daVH=i72Y4dA8TefPLfFB79Cvw7STPnQf_f10cBeYbg2ug@mail.gmail.com>
	<20140715102314.GA8273@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Turner <dturner@twitter.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 18:45:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X75rZ-0004mJ-QP
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 18:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754179AbaGOQpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 12:45:55 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58849 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752919AbaGOQpx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 12:45:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3BAB628C8C;
	Tue, 15 Jul 2014 12:45:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nUcHvH38jkAleoVppN8i+vj6n54=; b=plPiAv
	B1QWUWf0kgAcgZISwQS34JMUZcvDGSkAbwVvDkCxEY9WxhazVFH54SZ9ijLr1S34
	f+Zfxcxj2AD6+lo2/UkQ5VEWHYb1S2T4IOXyNx7dn9JUuIQFfXquuUfdox5ApsV+
	1GWpsZcvcFT9JojQ4KkfAIO1wAXxL2HXsw3yc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DSD4TJ76s4FPS8GZdkw5FHuo/MObRiSk
	qo+TUwY/e9jxtHdRSzyJNbrGhDdKR4BfcmZfgzE0WYyyXhkMBe6Oc3XRRCHEZoGH
	vXCKTi5GkBNqtBtQlDcvWThR8mngKobwxKMD0AaghUs5u2Bj/czHzbQMB+DtFDuG
	c07ud7k1PX0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2EA0C28C8B;
	Tue, 15 Jul 2014 12:45:35 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2376228C84;
	Tue, 15 Jul 2014 12:45:29 -0400 (EDT)
In-Reply-To: <20140715102314.GA8273@lanh> (Duy Nguyen's message of "Tue, 15
	Jul 2014 17:23:14 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6DBD7C22-0C3F-11E4-A840-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253573>

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Jul 14, 2014 at 11:38:06PM -0700, Junio C Hamano wrote:
>> On Mon, Jul 14, 2014 at 7:15 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> >
>> > It makes me wonder if a cleaner way of rebuilding cache-treei in this
>> > case is from git-add--interactive.perl, or by simply spawn "git
>> > update-index --rebuild-cache-tree" after running
>> > git-add--interactive.perl.
>> 
>> We could check if the cache-tree has fully been populated by
>> "add -i" and limit the rebuilding by "git commit -p" main process,
>> but if "add -i" did not do so, there is no reason why "git commit -p"
>> should not do so, without relying on the implementation of "add -i"
>> to do so.
>> 
>> At least to me, what you suggested sounds nothing more than
>> a cop-out; instead of lifting the limitation of the API by enhancing
>> it with reopen-lock-file, punting to shift the burden elsewhere. I
>> am not quite sure why that is cleaner, but perhaps I am missing
>> something.
>
> Reopen-lock-file to me does not sound like an enhancement, at least in
> the index update context. We have always updated the index by writing
> to a new file, then rename.

Time to step back and think, I think.

What is the real point of "writing into *.lock and renaming"?  It
serves two purposes: (1) everybody adheres to that convention---if
we managed to take the lock "index.lock", nobody else will compete
and interfere with us until we rename it to "index". (2) in the
meantime, others can still read the old contents in the original
"index".

With "take lock", "write to a temporary", "commit by rename or
rollback by delete", we can have the usual transactional semantics.
While we are working on it, nobody is allowed to muck with the same
file, because everybody pays attention to *.lock.  People will not
see what we are doing until we release the lock because we are not
writing into the primary file.  And people can see what we did in
its entirety once we are done because we close and rename to commit
our changes atomically.

Think what CLOSE_LOCK adds to that and you would appreciate its
usefulness and at the same time realize its limitation.  By allowing
us to flush what we wrote to the disk without releasing the lock, we
can give others (e.g. subprograms we spawn) controlled access to the
new contents we prepared before we commit the result to the outside
world.  The access is controlled because we are in control when we
tell these others to peek into or update the temporary file "*.lock".

The original implementaiton of CLOSE_LOCK is limited in that you can
do so only once; you take a lock, you do your thing, you close, you
let (one or more) others see it, and you commit (or rollback).  You
cannot do another of your thing once you close with the original
implementation because there was no way to reopen.

What do you gain by your proposal to lock "index.lock" file?  We
know we already have "index.lock", so nobody should be competing on
mucking with its contents with us and we gain nothing by writing
into index.lock.lock and renaming it to index.lock.  We are in total
control of the lifetime of index.lock, when we spawn subprograms on
it to let them write to it, when we ourselves write to it, when we
spawn subprograms on it to let them read from it, all under the lock
we have on the "index", i.e. "index.lock".

The only thing use of another temporary file (that does not have to
be a lock on "index.lock", by the way, because we have total control
over when and who updates the file while we hold the "index.lock")
would give you is that it allows you to make the success of the "do
another of your thing" step optional.  While holding the lock, you
close and let "add -i" work on it, and after it returns, instead of
reopening, you write into yet another "index.lock.lock", expecting
that it might fail and when it fails you can roll it back, leaving
the contents "add -i" left in "index.lock" intact.  If you do not
use the extra temporary file, you start from "index.lock" left by
"add -i", write the updated index into "index.lock" and if you fail
to write, you have to roll back the entire "index"---you lose the
option to use the index left by "add -i" without repopulated
cache-tree.  But in the index update context, I do not think such a
complexity is not necessary.  If something fails, we should fail and
roll back the entire "index".

> Now if the new write_locked_index() blows
> up after reopen_lock_file(), we have no way but die() because
> index_lock.filename can no longer be trusted.

If that is the case, lock.filename[] is getting clobbered by
somebody too early, isn't it?  I think Michael's mh/lockfile topic
(dropped from my tree due to getting stale without rerolling) used a
separate flag to indicate the validity without mucking with the
filename member, and we may want to do something like that as the
right solution to that problem.
