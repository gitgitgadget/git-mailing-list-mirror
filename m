From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/2] filter-branch: nearest-ancestor rewriting outside
 subdir filter
Date: Wed, 11 Nov 2009 10:22:09 -0800
Message-ID: <7vocn8q5v2.fsf@alter.siamese.dyndns.org>
References: <4AE945D0.5030403@viscovery.net>
 <0280836a32983c848bbb0e3b441be256d3c8f4fa.1257885121.git.trast@student.ethz.ch> <4AFA7624.5040400@viscovery.net> <4AFA7B9A.4090005@viscovery.net> <4AFA7C1E.1050606@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Nov 11 19:22:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8Hpr-0007F5-GY
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 19:22:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758382AbZKKSWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 13:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758375AbZKKSWP
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 13:22:15 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59130 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758339AbZKKSWO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 13:22:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C0BA7D2EC;
	Wed, 11 Nov 2009 13:22:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9qROtJ+NAoMkrAJvuu4C8LhioC8=; b=kVygnl
	HtCKdeoypkC/r2WJ+PiidbJ4b0cZpZvtanyrr7vE2VBTtGNr0u6mh/wIoFKxqK8b
	pThvdP9H8QkrDvfcRN3acs400QdhY2SNGCkkmtx87r1hBBl5s+MGf6JI/9i0Jj36
	uvLOYUTNxQDtScRs+Bl2UKm2nuvQxzkKfP3+M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Gf6jsiHPr1MiWn8Edlxnk6AeDiBmlNc9
	RJWyzbhYIhe1pKbIlBRWDuhJAZGDhnkOVBBAsYbWysqD98/ypJzSPjUX3sBApRnx
	Xeiq1FrAd3nz/9uDz8fTCXq2sLDNjXGTWPQoyXnr29MhKo6HoMjFIzWuHyhs1d96
	pf4Hh/21y+s=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F2DC7D2EB;
	Wed, 11 Nov 2009 13:22:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4491C7D2EA; Wed, 11 Nov
 2009 13:22:11 -0500 (EST)
In-Reply-To: <4AFA7C1E.1050606@viscovery.net> (Johannes Sixt's message of
 "Wed\, 11 Nov 2009 09\:55\:58 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 23CEC126-CEEF-11DE-B223-7B3EEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132683>

Johannes Sixt <j.sixt@viscovery.net> writes:

> However, that rewriting strategy is also a useful building block in
> other tasks.  For example, if you want to split out a subset of files
> from your history, you would typically call
>
>   git filter-branch -- <refs> -- <files>
>
> But this fails for all refs that do not point directly to a commit
> that affects <files>, because their referenced commit will not be
> rewritten and the ref remains untouched.
>
> The code was already there for the --subdirectory-filter case, so just
> introduce an option that enables it independently.
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>

Up to this point, nothing mentions the name of the new option.  Please
write your log for a person who needs to write the release notes by
looking at "git shortlog" output ;-)

I am wondering if this even needs an option to trigger.  Shouldn't you
want this behaviour always when you give any pathspec?

What are the sane reasons to leave the rewritten ref to point at the old
commit, essentially making the rewritten history unreachable?
