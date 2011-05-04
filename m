From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] specifying ranges: we did not mean to make ".." an
 empty set
Date: Wed, 04 May 2011 08:36:53 -0700
Message-ID: <7vpqnyfpey.fsf@alter.siamese.dyndns.org>
References: <7vr58glxro.fsf@alter.siamese.dyndns.org>
 <20110502193321.GB10487@sigill.intra.peff.net>
 <7vhb9clu0n.fsf@alter.siamese.dyndns.org>
 <7v62pslt2k.fsf_-_@alter.siamese.dyndns.org>
 <20110502210141.GA15753@sigill.intra.peff.net>
 <4DBFA31E.40207@drmicha.warpmail.net>
 <7vvcxrit07.fsf@alter.siamese.dyndns.org>
 <4DC0F845.2080903@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed May 04 17:37:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHe8X-0004vg-W1
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 17:37:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754451Ab1EDPhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 11:37:07 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51481 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551Ab1EDPhF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 11:37:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 29F7B59C8;
	Wed,  4 May 2011 11:39:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t83LDYmRYH4gNsPRksZ33oiY9hs=; b=r9NARk
	WzDVLG71mFiRSoSbOMHCnU2ugUZrNRXtk9bBCWK4XKfgCrHAqITdjIcWh980ymyk
	+UvylhJKvFBI3x3/SuEaWFFd+QAlOeLrodDLG7bC7HNnkV1Qt176eEeBDoSDV+dU
	X8c5VkhgGo8V9aSyvyGK7fQ/mce/YEu1zOaCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZLeeoCX22ymR9m1ux6bX83D7IEXCVCi8
	23ucjD2EjZckM9qgLPR7EAddVfkREkyhEEjaCu2c9Wg9dsHGw2mgrrowxe+66TrQ
	c8GQOZOwv0mNO5BeeKfX7/wMD3eIl1g/PfRB+1kNRTG1XpB6aBhPL2qj0DhMhNvV
	cau2xRyZaRs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E559159C4;
	Wed,  4 May 2011 11:39:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B828459C1; Wed,  4 May 2011
 11:38:57 -0400 (EDT)
In-Reply-To: <4DC0F845.2080903@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Wed, 04 May 2011 08:55:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A2A3CDE8-7664-11E0-A4B3-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172747>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>> Contrast that with ".." and realize that is very different.  It is
>> infinitely more likely that the user meant the immediate parent directory
>> than an empty revision range.
>
> and that is a straw man argument. I suggested "@{u}..HEAD" for "..",
> because I consider that much more useful.

But the thing is, 

Either of @{u}.. or ..@{u} may be an often used range depending on who you
are and what you want to find.  But reusing ".." for that purpose would be
a very steep uphill battle for obvious reasons that I can count at least
three:

 * How can a user remember ".." stands for whichever of @{u}.. or ..@{u}
   you happen to pick?

 * Can you guarantee that there will never be anything _more_ common and
   useful than "@{u}.." that deserves to use ".." as a shorthand?  I
   can't.

 * Doing anything other than an empty range for ".." is a bit _too_
   magical for my taste.  After all, if $A.. means $A..HEAD and ..$B means
   HEAD..$B, giving an empty string to $A or $B should yield nothing other
   than HEAD..HEAD, unless you want to confuse the user.

I think your argument is that I wouldn't have felt the annoyance if ".."
meant a vastly more useful range that is totally different from the
current semantics, because I would have understood that ".." could be both
a useful range and a useful pathspec, and there won't be "Stipid git!  I
know .. could be an empty range but it should be obvious to you that I
didn't mean that interpretation with no practical value. Just take it as a
parent directory pathspec!".

You could achieve that by time-travelling to a past where no git user were
present and inplement "$A..$B" to default in that way from day one, and if
I were living in such a world, I would certainly agree with you.

But that is not the world we live in.

In other words, both of us agree with the statement: "What .. means today
has no practical value".  But I do not think that the conclusion that
follows that statement should be "so let's change its semantics and make
it do something useful".  Changing it to anything magical breaks
consistency in a big way, than keeping this degerated case as such.

As I said in the beginning of the thread, this was a mere annoyance, and I
wouldn't be unhappy to drop this change.  I will have to type "../" myself
when I mean "parent directory", but that is a minor annoyance.  But it
also may turn out to be a disaster that everybody else needs to teach new
people to do so.

As to changing the semantics of "..", I am moderately against it, but I
consider that is a separate topic.  I am not opposed to giving a range
that is common and useful (be it @{u}.., ..@{u}, or anything else) a
short-hand, but that short-hand should not be "..".
