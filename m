From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] Add new git-related helper to contrib
Date: Wed, 22 May 2013 12:54:54 -0700
Message-ID: <7vk3mqiycx.fsf@alter.siamese.dyndns.org>
References: <1368978823-18247-1-git-send-email-felipe.contreras@gmail.com>
	<7vr4gyizti.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 22 21:55:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfF7m-00061q-Kr
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 21:55:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757010Ab3EVTy6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 15:54:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47582 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756843Ab3EVTy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 15:54:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA6D921DB8;
	Wed, 22 May 2013 19:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3pykVJSKn1cb/CwXxUamklwXNm4=; b=p7GVIw
	EFmG5bnvclJsA/gu+/iZc0Umpv6DG2RiALY2Sem6S7/kFkoC6gXEnXLUDnF/S3Br
	ybwIuS4UIPu2E2gVGJTzZBenh0CbK/zVIlenrzjVJkziJYEWM4P93rAGBToaAChF
	XM1UAcLpXMs4i08DHCkkZHfoehIq9mBcTvdeI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m9wlU2suUavq8NZdSxehetHysHi6ocwJ
	j5YWNEmJbhLjWlBt1hyFl42XielcSHlVSgw6xcGJBHgtU/twGfXu+2docVjrkokX
	H8qFVxRBrrR+7It3RljgMVaay0Lg36xbQjEhdfAyPZdnj3LUEuIRfo1xUJm34gzX
	XOiqmk2xWoc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DDE8A21DB7;
	Wed, 22 May 2013 19:54:56 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4362721DB6;
	Wed, 22 May 2013 19:54:56 +0000 (UTC)
In-Reply-To: <7vr4gyizti.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 22 May 2013 12:23:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 79FE7DEE-C319-11E2-9993-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225186>

Junio C Hamano <gitster@pobox.com> writes:

> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> diff --git a/contrib/related/git-related b/contrib/related/git-related
>> new file mode 100755
>> index 0000000..b96dcdd
>> --- /dev/null
>> +++ b/contrib/related/git-related
>> @@ -0,0 +1,124 @@
>> +#!/usr/bin/env ruby
>> +
>> +# This script finds people that might be interested in a patch
>> +# usage: git related <file>
>> +
>> +$since = '5-years-ago'
>> +$min_percent = 10
>> +
>> +def fmt_person(name, email)
>> +  '%s <%s>' % [name, email]
>> +end
>
> Micronit.  I suspect you do not need this helper, unless later
> patches start using it.

Not that matters terribly, but "later patches start using it in a
different way" may be needed as a clarification.

The current two callers capture both "%s <%s>" as two separate
groups but they do not need to; they can do "(%s <%s>)" and pass $1
to this function, I think.
