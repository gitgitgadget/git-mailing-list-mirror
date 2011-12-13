From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 1/2] wrapper: supply xsetenv
Date: Tue, 13 Dec 2011 10:34:23 -0800
Message-ID: <7vwra0uxqo.fsf@alter.siamese.dyndns.org>
References: <1323778227-1664-1-git-send-email-kusmabite@gmail.com>
 <20111213181602.GB1663@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 13 19:34:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaXBO-0003rx-97
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 19:34:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753285Ab1LMSe0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 13:34:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55605 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751548Ab1LMSeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 13:34:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 401097A9D;
	Tue, 13 Dec 2011 13:34:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RR60dj7tRK620VDK6h+18+pOJpk=; b=aw2xjg
	hrIzcU6pzd4Bgtcm97Qp3GupfXqJjW7iXsqiWlKL+NxD4YQqhBOXpJXF1f43+aiq
	patAI5dejoC/uUKuU5AcCZWaP4haxe1/rrp+KKHV/sNM8YToF+wxtsfMqZqr8F47
	jHXPaTIzOFuMpmkr9wNdfvD535LrAErXC0hcc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OosIK97frp8brKLomAPJYs/5qmVDvaxv
	3gnqgsYblf8hHdTqMb25EIpOO49WaWsGz8laHgp7+qNnGfGC9nJvbiYAWR+2rArX
	61vdCD0cl0MEcMg4S6pDwPqJRQSqdPt/CxB1KY/lkbmSTyqNjYRusmT2ufiDkbcO
	SEC1jhFOSy8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 37E337A9C;
	Tue, 13 Dec 2011 13:34:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BDDD47A9B; Tue, 13 Dec 2011
 13:34:24 -0500 (EST)
In-Reply-To: <20111213181602.GB1663@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 13 Dec 2011 13:16:02 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 14EA0C60-25B9-11E1-8013-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187042>

Jeff King <peff@peff.net> writes:

> On Tue, Dec 13, 2011 at 01:10:26PM +0100, Erik Faye-Lund wrote:
>
>> +int xsetenv(const char *name, const char *val, int overwrite)
>> +{
>> +	if (setenv(name, val, overwrite))
>> +		die_errno("setenv failed");
>> +}
>
> It probably doesn't matter, because the error condition is almost
> certainly just "oops, we ran out of memory". But you could also print
> the name of the variable being set, which may give the user a clue to
> some misconfiguration (e.g., trying to put some extremely long value
> into the environment).

Do we have enough memory to format that message in that situation ;-)?
