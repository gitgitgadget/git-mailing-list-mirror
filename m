From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Subtree in Git
Date: Fri, 11 May 2012 13:24:02 -0700
Message-ID: <7vaa1elb4t.fsf@alter.siamese.dyndns.org>
References: <CAE1pOi2uT=wipyrOYCwy9QuXnXFV27F1gN3Ej-RaSr-fegQCfA@mail.gmail.com>
 <nngk410vrja.fsf@transit.us.cray.com> <4F9FA029.7040201@initfour.nl>
 <87fwbgbs0h.fsf@smith.obbligato.org>
 <7v8vh78dag.fsf@alter.siamese.dyndns.org> <4FA82799.1020400@initfour.nl>
 <nngzk9jvemb.fsf@transit.us.cray.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Herman van Rink <rink@initfour.nl>, <greened@obbligato.org>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>
To: "David A. Greene" <dag@cray.com>
X-From: git-owner@vger.kernel.org Fri May 11 22:24:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSwNp-0007yK-3D
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 22:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760982Ab2EKUYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 May 2012 16:24:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39460 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760973Ab2EKUYG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2012 16:24:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DE6C7231;
	Fri, 11 May 2012 16:24:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tMoK41ukGVfAdBysor3AkirE9hc=; b=WiDEXs
	Uubg/3hF9t9uoALxPyiziFLzmbCJoPn9T1J2yFTqk+01HrBE/wEDo6NgzpyQsKgV
	mbmiMDpKYkVTxcW5SWsZG4Rg3VtYG62hNAxFO4c1QC6sk6VK8oJ+Znj/qbZCzrA7
	Nw7Hcb7aPaGw/Ctp51GqTONSUDk+Zk8nnZ4x8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pcTBT1i2fFsXKDEqh+QnHRTIYd1Tpj61
	hjcZT9DI5JyQtYiXqBSdbtoJJU17AFySq3/nDfZdVLAi8NM80q009poKf2E/MJE7
	bLjolEgu52bkONNbdgws2QCl9PBOolxcsgDGiOzPJ1l8bREpeE8GOtdTmENM0i8r
	HePpEsIOhaM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55583722F;
	Fri, 11 May 2012 16:24:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C78E4722E; Fri, 11 May 2012
 16:24:03 -0400 (EDT)
In-Reply-To: <nngzk9jvemb.fsf@transit.us.cray.com> (dag@cray.com's message of
 "Mon, 7 May 2012 16:57:16 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 404A75C0-9BA7-11E1-8778-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197694>

<dag@cray.com> writes:

> Herman van Rink <rink@initfour.nl> writes:
>
>> As an alternative I've now applied a patch with all changes on a clean
>> master branch.
>> In the commit message I've named all committers from the original history.
>> Would that be acceptable?
>
> Seems ok to me but Junio has the final say.

What we do *not* want to see are merges from commits after the "subtree"
stuff is moved down to "contrib/subtree" into commits before the merge
happened, as that would mean "constant renaming merge" mess in the history
(see http://article.gmane.org/gmane.comp.version-control.git/197689 as
well).

If it is too much trouble to clean up the history, it is OK to leave
"oops, an earlier one was a total mistake but it is too late to rewind the
tree, so here is a fixup" commits.  At the very least, however, it should
be possible to clean up the history to pretend that everything has
happened _after_ the "git-subtree" project transitioned to have its files
under "contrib/subtree" hierarchy in preparation for eventually becoming a
part of the core git, no?  Then the back-merges from your tree to Herman's
will be merging updates to contrib/subtree part into contrib/subtree part,
and "git log contrib/subtree" will give us a readable output.

I thought "subtree" was a tool to make it very easy to let you pretend
that everything happened in the context of containing larger tree when you
wanted to, so I am hoping that is not asking too much (even a subtree
unaware "filter-branch" should be able to do that kind of thing, I would
think).

Thanks.
