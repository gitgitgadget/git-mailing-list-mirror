From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/7] replace: forbid replacing an object with one of a different type
Date: Fri, 06 Sep 2013 14:34:18 -0700
Message-ID: <xmqqioydws6d.fsf@gitster.dls.corp.google.com>
References: <20130906050702.6657.25651.chriscool@tuxfamily.org>
	<20130906051100.6657.41248.chriscool@tuxfamily.org>
	<xmqqmwnpwv6m.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
	Thomas Rast <trast@inf.ethz.ch>, Johannes Sixt <j6t@kdbg.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Sep 06 23:34:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VI3fi-00038K-11
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 23:34:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815Ab3IFVeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 17:34:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63432 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750761Ab3IFVeY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 17:34:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A4883F9EE;
	Fri,  6 Sep 2013 21:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yX5hXt0HKetXxtWyPMoohLODR0A=; b=vKjFNo
	zgZxGguZ93m1d65Bt/b+KSxU8HRSsQUDdcf09fawiRh4K27gyXTLN/aA+aqMgHJe
	x5vq5XVNmkKiPX3I+QjGEI0I8XTNdYVuLLg5H5k3H03shcxlTvVoJREZttUoygPR
	U++Rb/B9cbCD3JWFGZACjK1bIkZ64r/X+YKmI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I9Gjewctz0eIpZqGLJLd8QF88afTge9D
	ZoEgL6w9quLai82qvVq7tM7nI8gIAxcHYNjOzTHwj6i5A12QXux5pqgXQiy6XHG5
	LXr5kGCmJEieDJxUXztCehkpfqYESO2I6oM5UO0jjNnVReqSJMFnlV2q7A0tqSds
	3XOIY+jFa+I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A233D3F9ED;
	Fri,  6 Sep 2013 21:34:23 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D63C43F9E9;
	Fri,  6 Sep 2013 21:34:21 +0000 (UTC)
In-Reply-To: <xmqqmwnpwv6m.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 06 Sep 2013 13:29:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 180F5E4C-173C-11E3-A12E-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234098>

Junio C Hamano <gitster@pobox.com> writes:

> Christian Couder <chriscool@tuxfamily.org> writes:
>
>> +	obj_type = sha1_object_info(object, NULL);
>> +	repl_type = sha1_object_info(repl, NULL);
>
> That we can do this is somewhat curious....

Note that this was a comment on the sha1_object_info() API, which,
unlike read_sha1_file() API, does not seem to interact with the
"replace" mechanism.  I _think_ that needs to be rethought by
checking each call site, but for the purpose of this series, I think
this is the best we can do in this patch.

Will queue the whole series.

Thanks.
