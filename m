From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] merging renames of empty files
Date: Thu, 22 Mar 2012 16:37:05 -0700
Message-ID: <7vpqc4us0u.fsf@alter.siamese.dyndns.org>
References: <4F69B375.5050205@in.waw.pl> <86iphwomnq.fsf@red.stonehenge.com>
 <4F6B1F48.3040007@in.waw.pl> <20120322140140.GA8803@sigill.intra.peff.net>
 <7vty1gy3eh.fsf@alter.siamese.dyndns.org>
 <20120322175952.GA13069@sigill.intra.peff.net>
 <20120322182533.GA20360@sigill.intra.peff.net>
 <7v62dwxybd.fsf@alter.siamese.dyndns.org>
 <20120322190303.GA32756@sigill.intra.peff.net>
 <7vwr6cwiux.fsf@alter.siamese.dyndns.org>
 <20120322224651.GA14874@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzej?= =?utf-8?Q?ewski-Szmek?= 
	<zbyszek@in.waw.pl>, "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Ralf Nyren <ralf.nyren@ericsson.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 23 00:37:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SArZD-0005C8-6Q
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 00:37:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756587Ab2CVXhK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 19:37:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45409 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752664Ab2CVXhI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 19:37:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BCAFF66F7;
	Thu, 22 Mar 2012 19:37:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vyyitfzfe3tD5hoWtJTcj6M1tAQ=; b=ULRKjh
	IMO/XBKxqZZxU4mAjdxhmkzQ406JmJm9BFgDq1OUqk5lDaIb/cMEbSxwtxiSlAlZ
	gHRoQxfh7n6rjCdFDEkSavp1QS6QeXHAC1RkeFFBGWIeKNzUdgEg114lCZc1WDq8
	1w89nUmJza2nuGl8Hbk+irApN3xIwQM03NHb8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XFrLvOJlS3myIeCNqR7S1NeeMFQ3yt01
	FeUSGQoJSJ+4V2Z5qOZ1jZGi/JBlWnAtGSvWED8Z5VBcFs/Wvtaj+cFN7ry4QAJ0
	uEah1HtQQolsA9w0d1q4vJJ2lzAmZFOLe4Ap1xGSj34C+EZPYekv1xwFO4u3oy5K
	idzos5kx1vo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B210C66F6;
	Thu, 22 Mar 2012 19:37:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2E61766F5; Thu, 22 Mar 2012
 19:37:07 -0400 (EDT)
In-Reply-To: <20120322224651.GA14874@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 22 Mar 2012 18:46:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EFDD9460-7477-11E1-A70F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193733>

Jeff King <peff@peff.net> writes:

> Here's a 2-patch series to replace the old 3/3 (they go on top of the
> first two cleanups from the previous iteration).

Hrm. As this is probably useful for older maintenance track, I would have
preferred not to see the first one that touches sequencer.c that did not
exist in the 1.7.7.x maintenance track, as the change is purely "cosmetic"
and does not have anything to do with fixing the over-agressive merge.

>   [1/2]: teach diffcore-rename to optionally ignore empty content
>   [2/2]: merge-recursive: don't detect renames of empty files
>
> Thinking on this more, it is actually a more generic problem than just
> empty files. It is really a problem of having generic placeholder files
> with the same content. So a fully general solution would be something
> like a gitattribute for "don't do renames on this". However, in
> practice, these placeholder files are empty (since any non-empty file is
> likely to actually have different content). So I think just dropping the
> empty files as rename candidates is a pretty good heuristic, and it's
> nice and simple.

I thought that our recommendation for keeping an otherwise empty
directories around was to have .gitignore file with two entries in it,
namely:

	.*
        *

So these files will be everywhere and without being empty, no?

But I tend to prefer the simplicity of limiting this to empty files
anyway.

> After responding to Jonathan, I'm on the fence about whether diff should
> follow the same heuristic. I left the diff behavior unchanged, but a 3/2
> that turns it off by default would be a trivial one-liner.

I am also torn, but somewhat in favor of avoiding random permutations of
empty files.

I can think of only one situation somebody _could_ argue that detecting
empty-to-empty rename is halfway sensible: when there is only one empty
file that was removed, and one new empty file that was added.  Even in
such a case, the user could have done "rm this; >that", and depending on
the nature of these two files, "mv this that" may not have made _any_
sense even if they are both empty, and that is why I said "halfway"
sensible.
