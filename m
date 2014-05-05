From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2014, #09; Tue, 29)
Date: Mon, 05 May 2014 16:50:58 -0700
Message-ID: <xmqqoazb944d.fsf@gitster.dls.corp.google.com>
References: <xmqq7g67iwxc.fsf@gitster.dls.corp.google.com>
	<20140505184546.GB23935@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue May 06 18:52:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhiDP-0007Xo-Du
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:27:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932931AbaEEXvF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 19:51:05 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63375 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756886AbaEEXvD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 19:51:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7F14215E36;
	Mon,  5 May 2014 19:51:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JZj1c3Nf3dqyWHg6pxmhLl5C6mI=; b=eUy/DC
	9h/5liKfHhof6vMyEr4/2+zz7pDzSXaYVat0Z62oRtRCefSKt17rB3WqEQ8dxLm8
	AqNZkZ70b+f34aG8lFkpD4nI0WheO/ERPyqQDGDquWrKufRmT+iiZwWtoau8Oc/r
	t4W1EGxdREcxYBkJI8gh3zn5ekKhKfY5tmKn0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UuOW8lD/zcybRCrFsJvS4d088EelJgoh
	gXbB8PG6r7mUByhEZUHzV/ExiwLlUlZyRu62OtTjcMQdPHNsfg7G2Q8hufvAOB1t
	G8r+huNbTdUxSBOah8ZDQwg8WFtagA9k275v2G9WJcLfjEksE3xoAuZxZmkXHdtV
	l+0KdYRHszQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7694215E35;
	Mon,  5 May 2014 19:51:02 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3030A15E32;
	Mon,  5 May 2014 19:51:00 -0400 (EDT)
In-Reply-To: <20140505184546.GB23935@serenity.lan> (John Keeping's message of
	"Mon, 5 May 2014 19:45:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1C1AE092-D4B0-11E3-843A-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248156>

John Keeping <john@keeping.me.uk> writes:

> On Tue, Apr 29, 2014 at 03:38:07PM -0700, Junio C Hamano wrote:
>> * fc/remote-helpers-hg-bzr-graduation (2014-04-29) 11 commits
>>  ...
>>  Move remote-hg and remote-bzr out of contrib/.  There were some
>>  suggestions on the follow-up fix patches still not in 'next', which
>>  may result in a reroll.
>> 
>>  Will merge to 'next' and keep it there for the remainder of the
>>  cycle.
>
> I'd like to register my opposition to moving git-remote-{bzr,hg} out of
> contrib/.
> ...
> In the case of git-remote-hg specifically, the remote helper has to use
> an interface that the Mercurial developers consider unstable [1];...
> I do not want to end up in a situation where an update to Git is blocked
> by a distribution because git-remote-hg is not updated to support newer
> versions of Mercurial sufficiently quickly; this previously happened in
> Gentoo due to git-svn and meant that was stuck on 1.7.8 until 1.7.13 was
> released [2].

The same argument would apply to git-svn, git-p4, and git-cvsimport,
I would think.

Among these, I am not sure if we can find willing maintainers who
can give enough love to them.  But unlike these other importers,
remote-hg and remote-bzr do have an active maintainer (and IIRC I
think I heard that Hg one even has an active competitor or two?) so
I am reasonably confident that these can live on their own merit
outside of my tree.  In the ideal world, I would think it may be
even beneficial to the end users of these helpers to unbundle them.

You raised a good point on the issue of external dependencies may
impact Git as a whole, even for those who are not interested in the
particular remote helpers at all.  I'll have to think about it.

The silly thing is that I totally forgot that we almost got
ourselves into a very similar situation on cvsimport when a series
wanted to make it cvsps3-only.  It is very possible nobody would
have picked up the entire new release, if we merged that change.

Having said all that, there is one caveat.

> Since the remote helper interface is stable and the remote helpers do
> not use any of the Git internals, I consider the risks of including them
> in core Git to outweigh the benefits of wider distribution.

You are correct to say that a remote helper has to talk with a
foreign system and it would not help to dictate the update schedule
of helpers to match the release cycle of Git itself.  At the same
time, however, the interface the remote helpers use to talk to Git
has not been as stable as you seem to think, I am afraid.  For
example, a recent remote-hg/bzr series needed some enhancements to
fast-import to achieve the feature parity with native transports by
adding a missing feature or two on the Git side.

So in reality, a helper has to talk with two sides, needs to adjust
to changes in the both sides, and both sides are changing.

Unbundling a helper from Git would place more burden on the helper's
maintainer, because the helper has to know enough about versions and
features of both sides (the foreign system and Git) to adjust its
behaviour, to stay compatible with wider versions of both foreign
systems and Git.  Unbundling, when done properly, may give more
ideal user experience to the end users, because such a helper would
allow them to pick up the latest (or stay on an older but known to
be stable) version of the helper and expect it to work with the
foreign system and Git they happen to have.

It however would be easier to maintain if the helper maintainer
knows a change to Git itself will be released at the same time as
the new version of the helper that takes advantage of the modified
Git.  The helper maintainer only has to worry about compatibility
with the foreign side if it is bundled with Git.

So it boils down to "how much resource are there to make sure a
helper will stay compatible with wider versions of both sides?" and
"how far backwards are helper maintainers willing to bend to support
users better?".
