From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 4/4] grep: obey --textconv for the case rev:path
Date: Thu, 07 Feb 2013 10:03:43 -0800
Message-ID: <7v4nho9f28.fsf@alter.siamese.dyndns.org>
References: <cover.1360162813.git.git@drmicha.warpmail.net>
 <a2808975f00bac5de0902e6830f254e4b064e8a5.1360162813.git.git@drmicha.warpmail.net> <20130206223656.GF27507@sigill.intra.peff.net> <51136E75.5060002@drmicha.warpmail.net> <20130207092640.GC15727@sigill.intra.peff.net> <5113784B.10103@drmicha.warpmail.net> <20130207095533.GA17110@sigio.peff.net> <5113827A.40801@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Feb 07 19:04:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3VpT-0004Ax-5S
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 19:04:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030218Ab3BGSDr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 13:03:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54903 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030213Ab3BGSDq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 13:03:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BCA9ADE1D;
	Thu,  7 Feb 2013 13:03:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tr7xe47pk6Ap3iFSgSlMd94mGfs=; b=etWpJ/
	dvdlP4gzhGOYkSjeo00VRoy1g82Qg79Hb3avtGbCv7DkQqQz6sZpX2eABW+ucN27
	XyU0sXAeO4lSBFq9htvgTFyEugL28DxLwJWw8bjW6KCgWkXJpMTwrF7ZNoUiBNx1
	DtcTsIApguXkP2XWzPO2m3LIFBjc5fQR5c9do=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=po6A/eaQLDspLC5ekNe88pGLx5Ex9/60
	Bd0RjagawoslfiOAsU0h/jKbPrWlOD3y/TzuKunMY5ohQcii7npq0eHpSgkagyUZ
	vy1EHgu6NPBakonK2FuV0LB+RJdsekqMpnIeh7ACeQBnt7pbJ4bVRXwkf0QqHcYz
	tO5xzuopZp4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2924DE1B;
	Thu,  7 Feb 2013 13:03:45 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 38D6BDE18; Thu,  7 Feb 2013
 13:03:45 -0500 (EST)
In-Reply-To: <5113827A.40801@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Thu, 07 Feb 2013 11:31:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B6C7EA3C-7150-11E2-B5C0-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215704>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>>> (cd t && git grep GET_SHA1_QUIETLY HEAD:../cache.h)
>>> ../HEAD:../cache.h:#define GET_SHA1_QUIETLY        01
>> 
>> Yuck.
>
> And even more yuck:
>
> (cd t && git grep --full-name GET_SHA1_QUIETLY HEAD:../cache.h)
> HEAD:../cache.h:#define GET_SHA1_QUIETLY        01
>
> Someone does not expect a "rev:" to be in there, it seems ;)

I think stepping outside of $(cwd) is an afterthought the code does
not anticipate.
