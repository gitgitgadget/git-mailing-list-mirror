From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What should I do to display the diff of even a simple merge
 commit?
Date: Tue, 09 Feb 2010 16:05:50 -0800
Message-ID: <7v1vguuf8h.fsf@alter.siamese.dyndns.org>
References: <46d6db661002091545j74f625ffr74ca70a0474948fc@mail.gmail.com>
 <20100209235707.GQ9553@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian MICHON <christian.michon@gmail.com>,
	git list <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Feb 10 01:07:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nf070-0005qF-Dy
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 01:07:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752720Ab0BJAGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 19:06:00 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44562 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391Ab0BJAGA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 19:06:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B4F19801D;
	Tue,  9 Feb 2010 19:05:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7nY4aaowOs95/Tq9x9BQY1AMBWc=; b=pZ8Mw9
	NQVzns49DI5DJw13Lq/kVC3Obv1KaU0Vk1Qj2eah8qleZ9n3/rFT6YVKIws862qT
	Jq4rZDASFPtBZabeZsUUGv8GJ5DpghQXgt3fjyOZodUrqJXZc+YHwG8P+BcAxU01
	8z8YQG5vGPZFLZOYVih7oUTdEk0VnqmRG4QaY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XrkM7z63QhceGHIoMH0yIvSmhJYBzi/G
	5AhOl/lMBQBLrdG6kmSrAUudT9dfSfQm08DYgYf41Nh8nwb6PzSzHmUenlIFcmj0
	wOb7jgkVn5/dfkGor+vO8EPAsjxKd2WAJ2CTGqgf1HudQkZXMRv7fcbntT/x9vjZ
	PcDK3Npx9/Q=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CD2AB9801A;
	Tue,  9 Feb 2010 19:05:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0D92098012; Tue,  9 Feb
 2010 19:05:51 -0500 (EST)
In-Reply-To: <20100209235707.GQ9553@machine.or.cz> (Petr Baudis's message of
 "Wed\, 10 Feb 2010 00\:57\:07 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0F4AAB18-15D8-11DF-BDA3-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139464>

Petr Baudis <pasky@suse.cz> writes:

>   I'm not sure if there is any clever switch for this, but I usually
> just use one of
>
> 	git diff mergecommit^1 mergecommit
> 	git diff mergecommit^2 mergecommit
>
> depending on which parent I want the diff against. If you always do your
> merges as "on mainline, merging in a topic" without fast-forwarding,
> diff against the first parent will be probably the right one and you can
> simply use:
>
> 	git diff mergecommit^ mergecommit

Frankly, we should make "git log --first-parent -p" DTRT, I think.

The attitude towards merges we maintain officially is "all parents are
equal", but in practice, there often are cases where --first-parent
traversal makes a lot more sense when browsing the history (especially
"the official" one).  The use of that option should be a clear enough sign
that diff between the first parent and the merge result is asked for.
