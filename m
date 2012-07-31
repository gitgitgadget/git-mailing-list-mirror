From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fix git-svn for SVN 1.7
Date: Tue, 31 Jul 2012 16:05:01 -0700
Message-ID: <7vtxwnh6qq.fsf@alter.siamese.dyndns.org>
References: <1343468872-72133-1-git-send-email-schwern@pobox.com>
 <20120730203844.GA23892@dcvr.yhbt.net>
 <7v1ujsl8ut.fsf@alter.siamese.dyndns.org> <5017AB63.6080909@pobox.com>
 <20120731200108.GA14462@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael G Schwern <schwern@pobox.com>, git@vger.kernel.org,
	robbat2@gentoo.org, bwalton@artsci.utoronto.ca, jrnieder@gmail.com
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Aug 01 01:05:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwLV4-0002Ys-S7
	for gcvg-git-2@plane.gmane.org; Wed, 01 Aug 2012 01:05:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754896Ab2GaXFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 19:05:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59749 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754719Ab2GaXFG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 19:05:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF7A98FCC;
	Tue, 31 Jul 2012 19:05:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=myLt8rwpQ54puCje6AVAFDyArgA=; b=bHsJ1z
	eQF14uquJrEJj7GKMIHf5jmn4nt+GT3X0Vppwa3NV94LHKNIzEvggUxUpOnNjuH9
	Ql8vn9o769fp8hpV46pb60z6XTd4mhzeKEAFLuRp24496S8MZQTal0OeBFnlYH28
	SHkzuBvrYho7aTu+SLKHdos9snDtZl28LhFtk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WClm8jf0iCc7/iXgK/FAdbVcy6grUHP3
	wR+NK59o4M1z3iqVzrHOhWKXEjoQh8MDHaBPpPocV93hKSODXMAngo6vfxLmBwzU
	V2yZUSEBsS9Y9fdRtER9f3/9fJuwOvYhd884aDCJsv/cLi0YwhB3Bpt7JqZ5TYey
	NyyPSqQoj78=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CD118FCB;
	Tue, 31 Jul 2012 19:05:04 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0A81D8FCA; Tue, 31 Jul 2012
 19:05:02 -0400 (EDT)
In-Reply-To: <20120731200108.GA14462@dcvr.yhbt.net> (Eric Wong's message of
 "Tue, 31 Jul 2012 20:01:08 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2918C33C-DB64-11E1-B87A-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202693>

Eric Wong <normalperson@yhbt.net> writes:

> Michael G Schwern <schwern@pobox.com> wrote:
>> It just doesn't matter.
>> 
>> Why are we arguing over which solution will be 4% better two years from now,
>> or if my commits are formatted perfectly, when tremendous amounts of basic
>> work to be done improving git-svn?  The code is undocumented, lacking unit
>> tests, difficult to understand and riddled with bugs.
>
> Yes it does matter.
>
> git-svn has the problems it has because it traditionally had lower
> review standards than the rest of git.  So yes, we're being more careful
> nowadays about the long-term ramifications of changes.

Thanks.  I know it takes guts to publicly admit that over time your
own creation has become less ideal than you wish it to be, but it
needed to be said.

Michael, please realize that the only reason people comment on the
patch series is because they care about what the series brings to
us.  In other words, your effort is appreciated.  For a change that
we want to have in our codebase, the functionality of the code
immediately after the change is applied of course is important, but
the maintainability of the result also matters.

We want to make sure that anybody who wants to understand and
improve the system can read the code without distraction from
inconsistent coding styles used in different sections of code.  We
want "git log" (or "git log git-svn.perl perl/") output to tell a
coherent story about how the code evolved and why these changes are
made in a consistent voice to the readers.  We want people to be
able to "git log | grep Signed-off-by:" to count the contributors.

A contributor has enough room to be creative in how his or her code
is designed.  Updating the code to follow the "convert as early as
possible", and (during subsequent discussion with Eric) suggesting
use of class instances instead of bare strings to make it harder to
mistakenly use bare unconverted strings are two examples you already
showed creativity in areas that matter.

There is no need to be creative in ChangeLog and coding styles; it
only hurts maintainability.

Regarding the operator overloading of "eq" for comparing the
converted strings, I still think it will hurt maintainablity (we
want to make sure that it is harder, not easier, to make wrong
changes to the code in the future), but I may be mistaken and you
may have better ideas.  If you can use overloading in such a way
that it won't harm maintainability and yet makes the resulting code
easier to read, I don't have any objection.

What I won't accept is "maintainability does not matter".  It does.

Thanks.
