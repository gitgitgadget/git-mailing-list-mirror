From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] travis-ci: run previously failed tests first, then slowest to fastest
Date: Wed, 27 Jan 2016 11:05:07 -0800
Message-ID: <xmqqd1sm9730.fsf@gitster.mtv.corp.google.com>
References: <DBA834D2-BFC9-4A2F-94D9-A1D0D60377BD@gmail.com>
	<20160122023359.GA686558@vauxhall.crustytoothpaste.net>
	<20160122055255.GA14657@sigill.intra.peff.net>
	<20160122060720.GA15681@sigill.intra.peff.net>
	<20160124143403.GL7100@hank>
	<xmqqd1sqd9sq.fsf@gitster.mtv.corp.google.com>
	<xmqq8u3ed45r.fsf@gitster.mtv.corp.google.com>
	<20160125144250.GM7100@hank>
	<xmqqk2mxa7ug.fsf@gitster.mtv.corp.google.com>
	<xmqqegd5fht9.fsf@gitster.mtv.corp.google.com>
	<20160127151602.GA1690@ecki.hitronhub.home>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Gummerer <t.gummerer@gmail.com>, Jeff King <peff@peff.net>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Wed Jan 27 20:05:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOVP4-0001qb-OK
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 20:05:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965258AbcA0TFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 14:05:14 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56204 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964854AbcA0TFK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 14:05:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 83DDC3C2E1;
	Wed, 27 Jan 2016 14:05:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1iEnzzF/3Y7bpXXNZ3rbpl4X3Pw=; b=K7vEnx
	8bPvVl8XhBY62GQkEy/WfuEprKuwFOE4CVKY5Gi9B1hPcNX5p2PjieQsnUOHBW+V
	JSedqpncoi7sCnzTqaKL41rgoWKFW5rtQRQq6mbIV70H58X74mqXmR7QefJyMDrd
	9AvuHS5OiIlpJ68QkaQa1TNak40k7WtyUO5rk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VIMOq3baJMfwAfvMLmlq39qgPUzBbT9r
	M1qmVztPDzxNDWR+X5fIyOrVhP4IKY2YD7y+fb2hM8CR1Jb45fq/VXRg/UfAsNCQ
	9RZFXEI5yxP1zlrLLW2ewgzoqrO0hGtprMFsS90tDQnJL/1Ksrhjx1X/bkAMMf4P
	QFeCzFir1eY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 795383C2E0;
	Wed, 27 Jan 2016 14:05:09 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E2C353C2DC;
	Wed, 27 Jan 2016 14:05:08 -0500 (EST)
In-Reply-To: <20160127151602.GA1690@ecki.hitronhub.home> (Clemens Buchacher's
	message of "Wed, 27 Jan 2016 16:16:02 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E2440AA4-C528-11E5-AD00-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284947>

Clemens Buchacher <drizzd@aon.at> writes:

> Coming back to "[PATCH] optionally disable gitattributes": The topics
> are related, because they both deal with the situation where the work
> tree has files which are not normalized according to gitattributes. But
> my patch is more about saying: ok, I know I may have files which need to
> be normalized, but I want to ignore this issue for now. Please disable
> gitattributes for now, because I want to work with the files as they are
> committed. Conversely, the discussion here is about how to reliably
> detect and fix files which are not normalized.

I primarily wanted to make sure that you understood the underlying
issue, so that I do not have to go back to the basics in the other
thread.  And it is clear that you obviously do, which is good.

Here, you seem to think that what t0025 wants to see happen is
sensible, judging by the fact that you call "rm .git/index && git
reset" a "fix".

My take on this is quite different.  After a "reset --hard HEAD", we
should be able to trust the cached stat information and have "diff
HEAD" say "no changes".  That is what you essentially want in the
other thread, if I understand you correctly, and in an ideal world
where the filesystem timestamp has infinite precision, that is what
would happen in t0025, always "breaking" its expectation.  The real
world has much coarser timestamp granularity than ideal, and that is
why the test appear to be "flaky", failing to give "correct" outcome
some of the time--but I'd say that it is expecting a wrong thing.

An index entry that has data that does not round-trip when it goes
through convert_to_working_tree() and then convert_to_git() "breaks"
this arrangement, and I'd view it as the user having an inconsistent
data.  It is like you are in a repository that still has an unmerged
paths--you cannot proceed before you resolve them.

Anyway.

As to your patch in the other thread, here is what I think:

 (1) When you know (or perhaps your CI knows) that the working tree
     has never been modified since you did "reset --hard HEAD" (or
     its equivalent, like "git checkout $branch" from a clean
     state), these paths with inconsistent data would break the
     usual check to ask "is the working tree clean?"  That is a
     problem and we need a way to ensure that the working tree is
     always judged to be clean immediately after "reset --hard
     HEAD".  IOW, I agree with you that the issue you are trying to
     solve is worth solving.

 (2) Regardless of the "inconsistent data breaking the cleanliness
     check" issue, it may be handy to have a way to temporarily
     disable the attributes, i.e. allow us to ask "what happens if
     there is no attributes defined?"  IOW, I am saying that the
     change in the patch is not without merit.

In addition to (1), I further think that this sequence should not
report that the path F is modified:

     # Write F from HEAD to the working tree, after passing it
     # through convert_to_working_tree()
     $ git reset --hard HEAD

     # Force the re-reading, without changing the contents at all
     $ cp F F.new
     $ mv F.new F

     $ git diff HEAD

which is broken by paths with inconsistent data.  Your CI would want
a way to make that happen.

However, I do not think disabling attributes (i.e. (2)) is a
solution to the issue (i.e. (1)), which we just agreed to be an
issue that is worth solving, for at least two reasons.

 * Even without any attributes, core.autocrlf setting can get the
   data in your index (whose lines can be terminated with CRLF) into
   the same "inconsistent data" situation.  Disabling attribute
   handling would not have any effect on that codepath, I think.

 * The indexed data and the contents in the working tree file may
   match only because the clean/smudge transformation is done.  If
   you disable attributes, re-checking by passing the working tree
   contents through convert_to_git() and comparing the result with
   what is in the index would tell you that they are different, even
   if the clean/smudge filter pair implements round-trip operations
   correctly.

One way to solve (1) I can think of is to change the definition of
ce_compare_data(), which is called by the code that does not trust
the cached stat data (including but not limited to the Racy Git
codepath).  The current semantics of that function asks this
question:

    We do not know if the working tree file and the indexed data
    match.  Let's see if "git add" of that path would record the
    data that is identical to what is in the index.

This definition was cast in stone by 29e4d363 (Racy GIT, 2005-12-20)
and has been with us since Git v1.0.0.  But that does not have to be
the only sensible definition of this check.  I wonder what would
break if we ask this question instead:

    We do not know if the working tree file and the indexed data
    match.  Let's see if "git checkout" of that path would leave the
    same data as what currently is in the working tree file.

If we did this, "reset --hard HEAD" followed by "diff HEAD" will by
definition always report "is clean" as long as nobody changes files
in the working tree, even with the inconsistent data in the index.

This still requires that convert_to_working_tree(), i.e. your smudge
filter, is deterministic, though, but I think that is a sensible
assumption for sane people, even for those with inconsistent data in
the index.
