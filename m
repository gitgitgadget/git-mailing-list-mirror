From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git annotate runs out of memory
Date: Tue, 11 Dec 2007 11:59:29 -0800
Message-ID: <7vve75c89q.fsf@gitster.siamese.dyndns.org>
References: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com>
	<alpine.LFD.0.9999.0712111018540.25032@woody.linux-foundation.org>
	<4aca3dc20712111109y5d74a292rf29be6308932393c@mail.gmail.com>
	<20071211193407.GC20644@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Berlin <dberlin@dberlin.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 21:00:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2BGx-0002DU-2H
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 21:00:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbXLKT7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 14:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbXLKT7p
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 14:59:45 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55231 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbXLKT7p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 14:59:45 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C0985442;
	Tue, 11 Dec 2007 14:59:38 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CACE15441;
	Tue, 11 Dec 2007 14:59:32 -0500 (EST)
In-Reply-To: <20071211193407.GC20644@artemis.madism.org> (Pierre Habouzit's
	message of "Tue, 11 Dec 2007 20:34:07 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67926>

Pierre Habouzit <madcoder@debian.org> writes:

>> Looking through thousands of diffs to find the one that happened to
>> your line is also pretty annoying.
>
>   If the question you want to answer is "what happened to that line"
> then using git annotate is using a big hammer for no good reason.
>
> git log -S'<put the content of the line here>' -- path/to/file.c
>
> will give you the very same answer, pointing you to the changes that
> added or removed that line directly. It's not a fast command either, but
> it should be less resource hungry than annotate that has to do roughly
> the same for all lines whereas you're interested in one only.
>
> The direct plus here, is that git log output is incremental, so you have
> answers about the first diffs quite quick, which let you examine the
> first answers while the rest is still being computed.

Yes.

> Unlike git annotate, this also allow you to restrict the revisions
> where it searches to a range where you know this happened, which makes
> it almost instantaneous in most cases.

Yes, but blame also takes revision bottoms (obviously you have to start
digging from a single revision so "blame master..next pu" would not
work, but "blame ^foo ^bar baz" would).

> Of course, if the line is '    free(p);\n' then you will probably have
> quite a few false positives,...

You can feed more than a line from -S, and the assumed and recommended
typical use case is to do so.

> Note that it does not justifies the current memory consumption that just
> looks bad and wrong to me,...

Right.
