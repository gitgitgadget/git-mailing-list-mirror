From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] t0303: immediately bail out w/o
 GIT_TEST_CREDENTIAL_HELPER
Date: Wed, 14 Mar 2012 23:55:24 -0700
Message-ID: <7vk42ml5er.fsf@alter.siamese.dyndns.org>
References: <20120314141401.GC28595@in.waw.pl>
 <1331734704-14281-1-git-send-email-zbyszek@in.waw.pl>
 <7v8vj2omiv.fsf@alter.siamese.dyndns.org>
 <20120315035405.GA4149@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 15 07:55:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S84ay-0004d1-W2
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 07:55:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755627Ab2COGz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Mar 2012 02:55:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41709 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753763Ab2COGz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 02:55:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CEE646D5;
	Thu, 15 Mar 2012 02:55:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CwYe1B0GG/RItKA6NQXOJySoDOI=; b=GXfiBZ
	6NslBAcbsxdsYFIhoiX5v5I1zlk/OQWXvFS1211PV13B6XHt1w2EwueW48nvvgtj
	VST+/TeTn15KaOi4+/jYPqjEyLEuLcbLQApMxnx5CCAza1xrBSOm4VErrzXpXA7u
	HjND7It36kyNFxz/V8DUbR+/6D+f41sVmrTfw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nrKA3KBtoMgQ4xjLnUV2hO9/7ftGwZAc
	kqeT2fAZ86j8fph1gous1ySpbBn7F4sj4igTOI0fuKXYyeLbGPFkweKSzkbnm3WN
	AZg1QopJ2XP4WuqKq9IKL6DQbsp8byuC9UmfXafQReOcTtJsDNU+QItHjYki3MP7
	4ctMiD+1BDY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 53FDB46D4;
	Thu, 15 Mar 2012 02:55:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C03A946D3; Thu, 15 Mar 2012
 02:55:25 -0400 (EDT)
In-Reply-To: <20120315035405.GA4149@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 14 Mar 2012 23:54:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D7BEDFB8-6E6B-11E1-AB6B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193188>

Jeff King <peff@peff.net> writes:

> On Wed, Mar 14, 2012 at 03:17:28PM -0700, Junio C Hamano wrote:
>> This is probably not related to your patch, but
>> 
>> 	GIT_TEST_CREDENTIAL_HELPER=cache sh t0303-*.sh
>> 
>> passes OK for me while
>> 
>> 	make GIT_TEST_CREDENTIAL_HELPER=cache T=t0303-*.sh prove
>> 
>> seems to get stuck forever.
>
> It's because t0303 is the generic "test any helper" script, and does not
> know how to clean up the credential-cache daemon. So the daemon sticks
> around, holding onto a file descriptor that causes prove to hang.

And the reason why "sh t0303-*.sh" version does not have this problem is...?
