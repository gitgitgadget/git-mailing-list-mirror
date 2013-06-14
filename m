From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] status: do not depend on flaky reflog messages
Date: Fri, 14 Jun 2013 07:52:39 -0700
Message-ID: <7v38sksq14.fsf@alter.siamese.dyndns.org>
References: <1371130349-30651-1-git-send-email-artagnon@gmail.com>
	<1371130349-30651-6-git-send-email-artagnon@gmail.com>
	<7vvc5hubox.fsf@alter.siamese.dyndns.org>
	<CALkWK0kjxKFkrLArL1mLZYCMN1=sgnDSa3vaoJm6eSUp2E4Pyw@mail.gmail.com>
	<7vd2rpu3kf.fsf@alter.siamese.dyndns.org>
	<CALkWK0=NAiGDVWbwHXMmEffPF9wKXd23BdwOntfdvNCpVe8fiA@mail.gmail.com>
	<7vppvosstl.fsf@alter.siamese.dyndns.org>
	<CALkWK0k28u583Jci+Dvad1pbu7_dJdnmz1WBkP790a_t2QdPTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 16:52:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnVMt-0002fO-1A
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 16:52:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753186Ab3FNOwn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 10:52:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60254 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753127Ab3FNOwm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 10:52:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4B1C27DF0;
	Fri, 14 Jun 2013 14:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KLhiJBuYQyXmi/9gEcSXPzdBT2A=; b=o8u99c
	QFJEVcw9gizK1x+91K9YYMTAHs+jaUWDkiZ8ksdHQEABJHGuJVsgBDy/Rab9gCG3
	7A2W+GTosZonzrDY8Ss8fAO/11sQp+8dfnw4okDjzT1LRHQEWcTlgbEQe9q6unCF
	JSqMlPg+4SUcbL4WeULG7q4kf079B+owLrqFg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W0SWez+knPMFiyfg7NyCfQ8Hgj+0WEyl
	oVSCANppck1d2lFchqwJPP4GKMjyhI/+fbeRnU/RFtC6j5Pe8+nLbWTHgoqIqyAz
	G+vRO0oBMEzSxhgoji23B2v2l5ioMglXXeT4caWNeCE7aLe8KMtlHVLdt3Udc4eD
	jlh+HxeA5Qo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB06227DED;
	Fri, 14 Jun 2013 14:52:41 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3961927DEA;
	Fri, 14 Jun 2013 14:52:41 +0000 (UTC)
In-Reply-To: <CALkWK0k28u583Jci+Dvad1pbu7_dJdnmz1WBkP790a_t2QdPTg@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Fri, 14 Jun 2013 19:31:30 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 102AC972-D502-11E2-8B8C-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227875>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> In this example, it is inconsequential whether I run:
>
>   $ git checkout v1.8.2^
>
> or:
>
>   $ git checkout v1.8.2
>   $ git reset --hard @^
>
> as far as describe is concerned.  It will give me the same good
> consistent answer in either case.

Yes, "describe HEAD" is about the location in the history of the
commit at the current HEAD.

But the commit shown on "detached at/detached from" is for people
who care about the differences between the initial "checkout" you
did in these two examples: "checkout v1.8.2^" and "checkout v1.8.2".

That is different from the question you ask to "describe", which is
the location your HEAD happens to be in the commit ancestry graph
after you detached the HEAD with "checkout" and possibly jumping
around.  If you say "Not on any branch" instead of saying "detached
from v1.8.2" (or v1.8.2^), you are losing information, aren't you?

As I said (twice), you can argue that that particular piece of
information is not useful (at least to you), but why it is not
useful has to be justified, against the justification given by
b397ea4863a1 (status: show more info than "currently not on any
branch", 2013-03-13) and people who have been using that information
in the status output, no?

>> The user used "checkout" to detach the HEAD, and the user stayed in
>> that detached state and jumped around.  Where is this "without using
>> checkout" coming from?
>
> The point I was trying to make is:
>
>   $ git checkout v1.8.2
>   $ git checkout @^
>
> will give a different result once again.

The last checkout is for HEAD^ while at v1.8.2 in this case, isn't
it?  Don't you want to show it?
