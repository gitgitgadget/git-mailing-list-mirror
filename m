From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Avoiding broken Gitweb links and deleted objects
Date: Fri, 10 May 2013 00:16:22 -0700
Message-ID: <7vvc6r4855.fsf@alter.siamese.dyndns.org>
References: <CAJELnLFrfY=-gOFEe0cJHuyT4UNjbTm8hXMxAmzmQHVbz4iEbg@mail.gmail.com>
	<518C8EAC.6000106@viscovery.net>
	<7vzjw349y0.fsf@alter.siamese.dyndns.org>
	<CACsJy8CopioiTrEDfuZK=n1DfJ8_chxV9dEObqpVfHHmJvzyqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Matt McClure <matthewlmcclure@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 10 09:16:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UahZ8-0008Hr-Vq
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 09:16:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590Ab3EJHQ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 03:16:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62278 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751198Ab3EJHQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 03:16:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4237184C5;
	Fri, 10 May 2013 07:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z5IcgJHDfKSP+Eazz7+3pYhHD2c=; b=up0ifx
	/DGqk7bJQJNYKDdcWN2vTNeZrSD5ic2sBecLwRkL01k7Rfwdu5RxYx8F7u65LHpF
	z9q88hyt/1MsEa4zHwxwm9Tn5l1lDl4dKkY7NlHwAPSDK+IDCU1K5MBhEDdjtbID
	P4fBHb6npJ3Hl79hd6gRwuz755aM+GhzadfYc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kQg60iW6ztiJQluwid/emnUJS57xqy52
	G0Ow4qWhOcM7lAvBs7MyIwKmkVTzE5W1Cj76THfzcN+PTkQYfguNeKAMYbasnIoS
	LNDRTvkXjqgFgqgTlGHO+tKU6wN/nmX6wmK5Pcz/FDVzuG+24XvwikrdTj6EsXgi
	pbef6eQ6fFM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA446184C4;
	Fri, 10 May 2013 07:16:24 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 17442184C3;
	Fri, 10 May 2013 07:16:24 +0000 (UTC)
In-Reply-To: <CACsJy8CopioiTrEDfuZK=n1DfJ8_chxV9dEObqpVfHHmJvzyqQ@mail.gmail.com>
	(Duy Nguyen's message of "Fri, 10 May 2013 14:04:58 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 85AA0D20-B941-11E2-88AC-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223822>

Duy Nguyen <pclouds@gmail.com> writes:

> On Fri, May 10, 2013 at 1:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Johannes Sixt <j.sixt@viscovery.net> writes:
>> Imagine that a user runs "git rebase" on a history leading to commit
>> X to create an alternate, improved history that leads to commit Y.
>> What if we teach "git rebase" to record, perhaps by default, an
>> "ours" merge on top of Y that takes the tree state of Y but has X as
>> its second parent, and "git log" and its family to ignore such an
>> artificial "ours" merge that records a tree that is identical to one
>> of its parents, again perhaps by default?  "git log" works more or
>> less in such a way already, but we might want to teach other modes
>> like --full-history and --simplify-merges to ignore "ours" to hide
>> such an artificial merge by default, with an audit option to
>> unignore them.
>
> What about git-merge? Will it be fooled by these merges while looking
> for merge bases?

I thought it was obvious that we should ignore the side branches
that were superseded this way, as by definition they did not
contribute to the end result at all.

But there must be something huge that I missed; otherwise you
wouldn't be asking such a question. It is already late and my brain
is no longer quite working, so I cannot figure out what it is X-<.

Other things that I thought were obvious include format-patch (side
branch and the capping merge did not exist), another rebase (just
rebase the primary history ignoring the side branch and the capping
merge, and then cap the result with another artificial merge), and
shortlog (it should pretend that the side branch and the capping
merge never happened).

Of course, there should be a way for any of these to take the side
branch into account as if they are normal side branches as an
option.
