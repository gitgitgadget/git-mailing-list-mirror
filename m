From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] gc: reject if another gc is running, unless --force is given
Date: Mon, 05 Aug 2013 23:43:29 -0700
Message-ID: <7vwqnzgvzi.fsf@alter.siamese.dyndns.org>
References: <1375510890-4728-1-git-send-email-pclouds@gmail.com>
	<1375712354-13171-1-git-send-email-pclouds@gmail.com>
	<7vsiyoj932.fsf@alter.siamese.dyndns.org>
	<CALkWK0kZ=5TguAh9krAzFNuF0_sTRxcQKuZMnuQG7FQU0dJe=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 06 08:43:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6azt-00031I-8h
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 08:43:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755431Ab3HFGnu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 02:43:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62346 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755127Ab3HFGnd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 02:43:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5248A3244B;
	Tue,  6 Aug 2013 06:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PJxb6cBu1glHGZvboZHdNIZKk2s=; b=Ql5qJx
	Zlprn9xIK5lUqlbyc2YKMPee2m9APxnjIxmp7GtTrUzB9KBZxOoKDC00ANDEc6rG
	ZnUYR+uQwRvqVHEQiCfd1sWb2HmBaJLxLWrIyNlpup+jy6/OD7IATLa7Ua9IJI7B
	aR/yYJg9v5S/9k4ufhyHGGJ4yXocNmxwehAQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JmRgLRg63cJBt72nhhLXhyHLq3qRJ0QN
	S1nYUWceZ4eroSxLosbCs5CtMW+GxOJGAapGxAeU8M3cnxu3+Xl0wGn1BSrExCf7
	P0lG7koWUN20lq7wlrknS/BeYb/340MOcizsq9el9+GfEx1uokTP0buwdreSg2hG
	IuGeLut8iSs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 48A733244A;
	Tue,  6 Aug 2013 06:43:32 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3CA5D32441;
	Tue,  6 Aug 2013 06:43:31 +0000 (UTC)
In-Reply-To: <CALkWK0kZ=5TguAh9krAzFNuF0_sTRxcQKuZMnuQG7FQU0dJe=g@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Tue, 6 Aug 2013 00:07:43 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 821B5D64-FE63-11E2-91C0-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231726>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> [...]
>
> The other comments mostly make sense.
>
>> After reading what the whole function does, I think the purpose of
>> this function is to take gc-lock (with optionally force).  Perhaps a
>> name along the lines of "lock_gc", "gc_lock", "lock_repo_for_gc",
>> would be more appropriate.
>
> The whole point of this exercise is to _not_ lock up the repo during
> gc,...

I do not think it is a misnomer to call the entity that locks other
instances of gc's "a lock on the repository for gc".  Nothing in
Duy's code suggests any other commands paying attention to this
mechanism and stalling, and I think my comments were clear enough
that I was not suggesting such a change.

So I am not sure what you are complaining.
