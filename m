From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] remote: repack packed-refs once when deleting multiple refs
Date: Fri, 23 May 2014 12:25:13 -0700
Message-ID: <xmqqwqdci9gm.fsf@gitster.dls.corp.google.com>
References: <537B2FA4.7020001@opera.com> <537F2252.3010101@opera.com>
	<537F2319.7040105@opera.com>
	<xmqq61kwjon6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Ronnie Sahlberg <sahlberg@google.com>
To: Jens =?utf-8?Q?Lindstr=C3=B6m?= <jl@opera.com>
X-From: git-owner@vger.kernel.org Fri May 23 21:25:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wnv5o-0005aK-PF
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 21:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbaEWTZV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 15:25:21 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57974 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751217AbaEWTZU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 15:25:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C97B719CF5;
	Fri, 23 May 2014 15:25:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5sNsKJRWzqqVSTPVVe2mKSxyzk4=; b=doBJWW
	piiQ8MgSCcPXBSlw8pA9PWf4jGaPmSYbiLOlCsmCv5HHZ3Fa7DYLYdIdptWtYfrP
	06lfuLy7MKOOGrO3oQLH+I07/FV2d4apVwwWFKqDHmzJnvTK70R4wSLwieto5xH4
	oPnpNd8k5G3h6wytH4gJq4gEYhppy5Nx4UZkI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gSTpD9mlbrMI5FLAbfNRm+2ky82B4Oel
	wzObdFWsY1ioROZm5vtma+M5s10FZ7HvSU8sedyDEeoYYU/9kY2VKYvbXA8JMLiA
	+a+5u91ffJC5n27wqJmqUPi6fWINjnPCa1ZdVhZCvxNp7BiyuyRr0dqjMtNsAmS9
	n06JzOoaJIw=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B3C8719CF4;
	Fri, 23 May 2014 15:25:19 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0274B19CEE;
	Fri, 23 May 2014 15:25:14 -0400 (EDT)
In-Reply-To: <xmqq61kwjon6.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 23 May 2014 12:11:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F777F118-E2AF-11E3-A85E-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250017>

Junio C Hamano <gitster@pobox.com> writes:

>> -		if (delete_ref(refname, sha1, 0))
>> +		if (delete_ref(refname, NULL, 0))
>>  			result |= error(_("Could not remove branch %s"), refname);

By the way, how does this series interact with what Ronnie and Michael
are working on with their ref-transaction series?
