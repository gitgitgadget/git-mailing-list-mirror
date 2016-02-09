From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv9 0/6] Expose submodule parallelism to the user
Date: Tue, 09 Feb 2016 14:03:13 -0800
Message-ID: <xmqqziv91qzi.fsf@gitster.mtv.corp.google.com>
References: <1455051274-15256-1-git-send-email-sbeller@google.com>
	<xmqq4mdh36o8.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYt9bw9MreiBhA_ZQNjS+1Xi71aNGwkjcfC1hwxkOoyYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 23:03:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTGNV-00024B-1m
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 23:03:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933207AbcBIWDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2016 17:03:17 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54914 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932560AbcBIWDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2016 17:03:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A63DD43E4A;
	Tue,  9 Feb 2016 17:03:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LASbC6IMNguaWSmSduwrYzn15nk=; b=rbit20
	/og31brc7TDK5DUktFDg3fc30KGkaB7sEJqoe44uf+iDCgt8YXUo0DX2iWCnpt5B
	DS6Zyu2+UVHPQtVXns5xC/sqbD6RVUG0/R3vYTJLoFZo3HkCtCllhuF04Z4KlT2r
	A9RQ+0BWUz+FZNvKlanQd/KNUETLwtv6s3opk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IfQnw3hpgh4T4sor7Z1mSEmD+xTThVIq
	/MrzxDtntCxnXm1aKe/bcyg2U7YYASmWiOxYmR1Bav6cvOKaYazOvo99Sc2IIjfL
	d6msdyPUIOUZgLENbBPrVidwG8P8MYcA2clZrGuHoS2P3iSxdzeV3njCBbwv1EP+
	jyzMsiaBDv8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9D74543E48;
	Tue,  9 Feb 2016 17:03:15 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2102E43E46;
	Tue,  9 Feb 2016 17:03:15 -0500 (EST)
In-Reply-To: <CAGZ79kYt9bw9MreiBhA_ZQNjS+1Xi71aNGwkjcfC1hwxkOoyYA@mail.gmail.com>
	(Stefan Beller's message of "Tue, 9 Feb 2016 13:46:59 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EB117716-CF78-11E5-843A-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285874>

Stefan Beller <sbeller@google.com> writes:

>>> * This seems to clash with 00/20] refs backend.
>>>> Applied this on top of a merge between the current 'master' and
>>>> 'sb/submodule-parallel-update' topic to untangle the dependency;
>>>> otherwise there is no way for this topic to make progress X-<.
>>>
>>> Anything I can do to help with easing the clash?
>>
>> Perhaps try to rebase the series on top of such a merge (with this
>> updated series) yourself and propose it as a basis for the next
>> reroll for David?  In short, working together with topic(s) that
>> touch the same area?
>
> Ok, I'll see if I can find a better commit to base this series on.

That is not what I meant.  I meant rebasing the refs-backend series
on top of a merge between this one and 'master', just like the way I
queued the refs-backend series on top of a merge between the
previous round of this series and 'master'.

These two topics want to update the same piece of code, so another
possibility is to rebase this series on top of a merge between
refs-backend and 'master', but the current iteration of refs-backend
already depends on the previous round of this topic.  Rebasing this
on top of refs-backend would involve first adjusting parts of
refs-backend that touched the same code as the previous round of
submodule-parallel-update touched so that refs-backend would work
directly on top of 'master', and then including the necessary change
to the refs-backend code while rebuilding submodule-parallel-update
on top of the result.  So I do not think you would go in that
direction.
