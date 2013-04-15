From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/14] Improve git-status --ignored
Date: Mon, 15 Apr 2013 13:25:05 -0700
Message-ID: <7vli8jr17i.fsf@alter.siamese.dyndns.org>
References: <514778E4.1040607@gmail.com> <516C4F27.30203@gmail.com>
 <7v1uabsin7.fsf@alter.siamese.dyndns.org>
 <7vwqs3r3m4.fsf@alter.siamese.dyndns.org> <516C5DBF.1010102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Adam Spiers <git@adamspiers.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 22:25:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URpxl-0002Un-Fh
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 22:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753335Ab3DOUZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 16:25:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58014 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751541Ab3DOUZI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 16:25:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9569316FFD;
	Mon, 15 Apr 2013 20:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WMPJMK/vBMr/PhHCaoypwM7JCg0=; b=N9X6V3
	2ZRLZ2vN02Eu4pqnD26s22anQWm/3hbNQ+D4ZpBm/4f/m3alcJaqtBKC7Fm7ZszS
	bu3QI2wrj4+7h6+Tn+xs16TSoIIfdKs4lQvKBbwtLLgQVZYO0hxTtUmNgxXeAwiq
	NVq1gxFONRTsocm4Ig0gNty9wXd99uB3eNdPI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tkfkw2SDanWhaFHvVuWVy9c9dD5jXqb5
	f5ihibL1ic0pA6YhWbGJqBeA6KAdeLd5fWuQni8pj3SGwdxZecT8BNgrFEN08R3k
	KamAymX/sEee1lXHRIQffeRrvD+MzfLW1+WJ4+4tTRyRmc/UApd1eUxqcTQV7shD
	PTukU+bjwPw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C85C16FFA;
	Mon, 15 Apr 2013 20:25:07 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0175F16FF9; Mon, 15 Apr
 2013 20:25:07 +0000 (UTC)
In-Reply-To: <516C5DBF.1010102@gmail.com> (Karsten Blees's message of "Mon,
 15 Apr 2013 22:06:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 900A0BC0-A60A-11E2-A3BD-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221310>

Karsten Blees <karsten.blees@gmail.com> writes:

> Am 15.04.2013 21:33, schrieb Junio C Hamano:
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>>> Karsten Blees <karsten.blees@gmail.com> writes:
>>>
>>>> This patch series addresses several bugs and performance issues in
>>>> .gitignore processing.
>>>
>>> A 8-patch series ending at 5d765dc7888b (dir.c: git-status: avoid
>>> is_excluded checks for tracked files, 2013-03-18) has been cooking
>>> in 'next'; in general we won't revert and requeue a new round for a
>>> topic that has already merged to 'next'.
>>>
>
> I'm sorry to have caused such trouble. I thought you were expecting a reroll from this:

Heh, that was an ancient history.

It is not such a big deal to revert stuff from 'next'.  I've tried
to queue this reroll, but tentatively ejected the result from 'pu'
for today's integration run, as as/check-ignore topic has an
unpleasant conflict with this.

Thanks.
