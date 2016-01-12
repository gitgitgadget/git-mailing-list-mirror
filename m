From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2016, #02; Mon, 11)
Date: Mon, 11 Jan 2016 19:04:07 -0800
Message-ID: <xmqqh9ijv6qg.fsf@gitster.mtv.corp.google.com>
References: <xmqqlh7vvfxc.fsf@gitster.mtv.corp.google.com>
	<20160112000612.GA32363@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Jan 12 04:04:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIpGK-0000CN-NF
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 04:04:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758955AbcALDEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 22:04:12 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55057 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758017AbcALDEK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 22:04:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 382A63B36A;
	Mon, 11 Jan 2016 22:04:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2/6GsqNe5827sMbMw0Kr0PqNXiw=; b=N0xC1V
	MhRAJoWbh3vn+Z2OB5+hfuDbLCzFdqRTJRj4I8f2qtRNIU0jfkjkkJkhEx5B2LsE
	NWBo+U+WyvK+zmU+2JkrzwMYvVTFMtnu3IcJ/v1tJq8Xo0qpCWJPmyRVhzwv0cPa
	9W7/h0mDCYpJjalSJp8q5OruIPiAySDftcmRY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T071GyCa1sW3tvjj6VXH+iQgkoP3x+6t
	yigWAhKqXNhmYs9tlbB4pR76bm3izO/23zpPpc7p/zUDBDvKPeabUh9saXkm1ci4
	52ySrgeqBPS6zrWrFLVjnnopTgYmrt4KoFTl3cagEwYMw+wTrf5Y+o50CK3T5NyI
	d7BvMIJCO0c=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2060B3B369;
	Mon, 11 Jan 2016 22:04:09 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8BC9B3B368;
	Mon, 11 Jan 2016 22:04:08 -0500 (EST)
In-Reply-To: <20160112000612.GA32363@glandium.org> (Mike Hommey's message of
	"Tue, 12 Jan 2016 09:06:12 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 25C6E1A4-B8D9-11E5-894E-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283761>

Mike Hommey <mh@glandium.org> writes:

> On Mon, Jan 11, 2016 at 03:45:35PM -0800, Junio C Hamano wrote:
>> * mh/notes-allow-reading-treeish (2015-10-08) 3 commits
>>   (merged to 'next' on 2015-10-23 at 8a697f0)
>>  + notes: allow treeish expressions as notes ref
>>  + Merge branch 'jk/notes-dwim-doc' into next
>>  + Merge branch 'jc/merge-drop-old-syntax' into next
>>  (this branch uses jc/merge-drop-old-syntax.)
>> 
>>  Some "git notes" operations, e.g. "git log --notes=<note>", should
>>  be able to read notes from any tree-ish that is shaped like a notes
>>  tree, but the notes infrastructure required that the argument must
>>  be a ref under refs/notes/.  Loosen it to require a valid ref only
>>  when the operation would update the notes (in which case we must
>>  have a place to store the updated notes tree, iow, a ref).
>> 
>>  As the patch was done on top of the 'drop old-syntax from merge',
>>  this has to wait until that other topic can graduate, unfortunately.
>>  It can be redone in a way that does not depend on that topic after
>>  this cycle, though.
>
> I'm not sure what you mean here. The patch applies just fine on top of
> current master.

I exactly mean what I wrote ;-).

IIRC, back when the patch was queued, it wasn't directly applicable
to the tip of the master branch (I suspect that you made a patch
against 'next'), and the two topics you can see merged above turned
out to be the ones your change was textually depending on.  Because
at least one of them was slated to be kept in 'next' during the 2.7
cycle, and because we do not rewind 'next' in the middle of a cycle,
this made the patch at the tip of this topic to be ineligible for
merging to 'master' without dragging the other topics that were not
meant for 'master'.

Post release is a rare occasion that we can rewind and rebuild
'next', so you can simply send an updated patch that would apply
cleanly to the tip of 'master' (which is a lot newer than the tip of
'master' back then, and possibly have merged quite a lot of changes
from either of the two other topics your patch depends on) and tell
me "Drop that old copy queued in 'next' and replace it with this new
one when you rebuild 'next'".  If the old patch is identical to such
a patch, then just telling me "When you rebuild 'next', rebuild the
topic by just cherry-picking the tip of the topic directly to the
tip of 'master', as all the prerequisite changes have been merged
already" would be sufficient.

Which I guess you just did ;-).  I haven't checked if the
changes you depended on are all in 'master' already, but if that is
the case, then I'll do just that--if you see me forgetting to do so
when I rewind 'next', please holler.

Thanks.
