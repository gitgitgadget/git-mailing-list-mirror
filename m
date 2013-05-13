From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/7] rebase.autostash completed
Date: Mon, 13 May 2013 07:00:54 -0700
Message-ID: <7vr4hbou7d.fsf@alter.siamese.dyndns.org>
References: <1368359801-28121-1-git-send-email-artagnon@gmail.com>
	<7vy5bjqxxa.fsf@alter.siamese.dyndns.org>
	<CALkWK0mWRC9_QVYAu9Q4iAoVTpfkf9xkc9apjrdv6SyEiCq+hA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 13 16:01:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbtJJ-0002B3-6H
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 16:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754024Ab3EMOA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 10:00:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48655 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754005Ab3EMOA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 10:00:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 566381C2BA;
	Mon, 13 May 2013 14:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZGm2pVPs7P5y2I+nF4mPmkKxZhw=; b=OE8TmZ
	onOQRvoki3yHNWUiFEnQyGCpQ+AzvRy2qvBs21f2ZGdWb0md4Z59EpYYnRZyusz5
	HSJLfTQsYEtPPvUsQBF1z628noKXRlZf1KPN0jM8kRf8cRuFmuOYC9l5eoKP9EY/
	hwAShPCP6xOKygvogJ4ZcTJ+NCr2nU1LuPpI4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YPx6el9HkkBYgwQwX/ARKYsd7//2QO0V
	YiHJRoq57su/7Z8xmADUjUZYREAZSe6/fB43ghUrx1Y1vsV1YO4mBlVc3JMhnnRN
	BTkXhoqzNb1B44lGloaYJgXo/Z69IjCDjSYLFe8nFsYW7qeazQslC1PR/q6/d3s1
	bz7RTZEE2O0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A6A71C2B8;
	Mon, 13 May 2013 14:00:56 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9E5F11C2B7;
	Mon, 13 May 2013 14:00:55 +0000 (UTC)
In-Reply-To: <CALkWK0mWRC9_QVYAu9Q4iAoVTpfkf9xkc9apjrdv6SyEiCq+hA@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 13 May 2013 13:29:29 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 87DFF5F0-BBD5-11E2-A167-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224146>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> Especially I did not check if there are
>> still undesirable data loss behaviour in corner cases that people
>> were worried about in the discussion.
>
> Check the tests.  What am I missing?
>
>>    In the longer term, it is unmaintainable to make such users (like
>>    this new code) of the stash mechanism manually do so, and we may
>>    want to add a "git stash __store" subcommand, not meant for the
>>    interactive use of end users.  The implementation of the stash
>>    can later be changed without affecting such users by doing so.
>
> Yes, a "store" that stores a commit created with "create" would be
> nice.  Why the horrible double-underscore though?  "git stash create"
> is not meant for interactive use of end users either.

"create" is not advertised very widely, but "store" is too close to
what is already familiar to the people "save" and we really do not
want to confuse them.  "store -m message commit" sounds as if you
are creating a stash to apply to the given $commit.
