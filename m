From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] status: list unmerged files last
Date: Tue, 01 Sep 2009 21:26:26 -0700
Message-ID: <7vmy5egefh.fsf@alter.siamese.dyndns.org>
References: <20090901145213.GB4194@debian.b2j>
 <200909012213.54611.j6t@kdbg.org> <7vy6oy9z9r.fsf@alter.siamese.dyndns.org>
 <200909012325.45739.j6t@kdbg.org> <7vtyzmxkpr.fsf@alter.siamese.dyndns.org>
 <20090902011513.GA3874@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, bill lam <cbill.lam@gmail.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 02 06:26:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MihQk-0008Dk-SS
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 06:26:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbZIBE0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 00:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754017AbZIBE0k
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 00:26:40 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61421 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754029AbZIBE0j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2009 00:26:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E6792217A8;
	Wed,  2 Sep 2009 00:26:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=bOH4cC0kdzN6RtUEWWRycohj7eE=; b=CO9ZfsPX53U9MFkReM/N201
	Pang7ECAEA045WbDwMhScRZptKJY6jSLRG5JStW7HqtVCp/z5WnySFxyq6jxHCGP
	WNUdC0y9Y9FMsFZvUD/tKwEvBY69e2vqQC3nkavce3vtQmGFWJd08W5rRPIAj3km
	iN2ORc46jPPXCSju6EBA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=YsgaDjj09zrEWguNxfsOzt6WE6S+DoMXqf0tcatMsgfhxfrfJ
	RU9O9WiUpzL3QCvzM0tGws6c2vcAWIBLO/bWliLeMQxFXrHc6uvu67KG8Aimc3fw
	ENRbRycXuvvf+Z6F0goh34G60tmxZ5WAi8j+IST/dQ205UiR2JHKALDUcU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A6AB3217A7;
	Wed,  2 Sep 2009 00:26:35 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8CF10217A4; Wed,  2 Sep
 2009 00:26:29 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CCDC4EAE-9778-11DE-AA00-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127575>

Jeff King <peff@peff.net> writes:

> I think "related things together" trumps "close to the bottom". Because
> the former is something that _always_ applies to your output, while the
> latter is catering to a particular use case and a particular screen
> setup.
>
> In other words, why is the _bottom_ reserved for more important things
> instead of the _top_? If I have a tall terminal that is long enough to
> see the output, are you potentially making the important thing less
> obvious (because I tend to read the the output from top to bottom)? If I
> use a pager (either manually, because I have seen that the output is too
> long, or automatically via the pager.status config variable)? What about
> reading status output into an interface wrapper like "tig status"?

Yes and no.

Sure, I always work in a 92x70 screen session with 10k lines of scrollback
buffer, and when I cut and paste I do not use a mouse but use screen's cut
buffer, so I would have no problem with the list at the top.

Not that I would use "git status" while resolving merges---I would use
"ls-files -u" myself, and I may perhaps start using "status -suno", so my
personal preference does not really count on this topic.

But not everybody is used to such a set-up.  If you rely on terminal's
scrollback buffer with mouse and a short terminal, I can see cutting and
pasting would be an issue.  I do not have a good answer to "tig status",
but the design principle of supporting the lowest denominator is
important.

J6t made a good point that this new section won't appear when committing,
which I didn't take account when I was first explained how the ordering
was chosen.  After thinking about this a bit more, I think "untracked" and
"modified but not updated" sections, unlike when recording your own
commit, is mostly uninteresting while resolving a merge.  You never add
files that you forgot to add to a merge; nor you would add your local
modifications to a merge.  So the only sections that are interesting are
this new "unmerged" section and "updated" section to see the extent of
damage the merge causes to your history by introducing the crap other
people dumped on you ;-) [*1*].

The above suggests me that (1) we would want to have the new "unmerged"
section next to "updated" section, (2) we would want to have it later in
the output rather than earlier, and (3) in the traditional output, people
are used to see unmerged paths in "changed" section, so it would be easier
for them to transition if "unmerged" section were near "changed" section.

That makes the ideal place between updated and changed, no?

Incidentally that is where J6t's first patch was.  So I would agree with
the patch (but not necessarily with its justification).

[1] It might even make sense to omit other sections and show only
"updated" and "unmerged" in this order when the index is unmerged, but
that is a lot more drastic change for 1.7.0.
