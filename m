From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] diff_filespec cleanups and optimizations
Date: Fri, 17 Jan 2014 10:49:42 -0800
Message-ID: <xmqqd2jqxx2x.fsf@gitster.dls.corp.google.com>
References: <20140117011844.GA6870@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 17 19:49:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4EUI-000879-ON
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 19:49:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753330AbaAQStq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jan 2014 13:49:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34968 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753291AbaAQStp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 13:49:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F319620F0;
	Fri, 17 Jan 2014 13:49:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=52cj9YwfIJgczEEkwg8SIIl07Wg=; b=L0QIJT
	gPuMAunAhGCygFptsde770iKICpcLM90KY2f6Q+536CbVuaDL0Heb7nBtdCnWRhH
	iBo4bWQZqnR/jvuP+lKFhrpGPxfePYrAvAdj1K2HM+pu1s8OQAdQN737M8kNC/aU
	K7/bWKtlDOZyMH/tPflAYUbXABnTGjf0BlUoI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c54lJaD9c5X3JV8jv4PxHY2kD9Nk2IFm
	4P7bFdsndlw7ioTcuAl9gUxaGMfUoSIQE+7sg2wRcuVKk1VYTZpXBvrKfvAvYUNY
	GA4oA8Y+nbNt3Pf95ag2BbnyFu6NYEDALWLkT6gUu7eTiWvo3wjEpqaxrJXd6ML1
	+3900HGk6A4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F402620EE;
	Fri, 17 Jan 2014 13:49:45 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 560B8620ED;
	Fri, 17 Jan 2014 13:49:44 -0500 (EST)
In-Reply-To: <20140117011844.GA6870@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 16 Jan 2014 20:18:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 21720974-7FA8-11E3-9D7A-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240607>

Jeff King <peff@peff.net> writes:

> But while looking at it, I noticed a bunch of cleanups for
> diff_filespec.  With the patches below, sizeof(struct diff_filespec) on
> my 64-bit machine goes from 96 bytes down to 80. Compiling with "-m32"
> goes from 64 bytes down to 52.
>
> The first few patches have cleanup value aside from the struct size
> improvement. The last two are pure optimization. I doubt the
> optimization is noticeable for any real-life cases, so I don't mind if
> they get dropped. But they're quite trivial and obvious.

Thanks for a pleasant read.
