From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] redundant error message
Date: Thu, 05 Dec 2013 12:00:16 -0800
Message-ID: <xmqqsiu73w6n.fsf@gitster.dls.corp.google.com>
References: <CACsJy8BtCi_QSMZXfnscQmRyjvgSV1fG6smAOoCSab_e2YATxQ@mail.gmail.com>
	<20131205191518.GB19039@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 05 21:00:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vof61-00039n-3x
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 21:00:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752192Ab3LEUAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Dec 2013 15:00:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48817 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751957Ab3LEUAU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 15:00:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68B1B5867C;
	Thu,  5 Dec 2013 15:00:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3ZfpSxdBddFnfs6gPJ5bmSX7vPA=; b=ZCk+1m
	Y/D4MhadyLZL7UsEWj/4LHYqnep4BSHrJC5jDNUAVMAi6xA1e0NFFNySZFT6nq1U
	DnUTNDN4+x+tIZDjP7D/IlurEKHKkkmSMvQIP1NUaz82czS1luNseFsA8m4y9HCt
	eyvZrLKyWoyhwFH/SZz2dtjjtBo7vsTcLkpk8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FM6veX1hOLMTw2xbQGXfsu0GBsv6m7TZ
	NmS/KjknO/BpTBtPMvLRToUjj+2Wdyu74rR2uGsARI5UWJkSOAlw6a3pkDazvrIH
	gQbWM9I4E+4ddkVyir1zkxa0r8mhLob6G0p6RsMaeJDhSSuDb6uJRytW5tVmE7Ib
	Lj8WZ9e5xk8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 553455867B;
	Thu,  5 Dec 2013 15:00:20 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3180E58677;
	Thu,  5 Dec 2013 15:00:19 -0500 (EST)
In-Reply-To: <20131205191518.GB19039@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 5 Dec 2013 14:15:18 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DDD9CB48-5DE7-11E3-AD45-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238904>

Jeff King <peff@peff.net> writes:

>   $ >foobar
>   $ git rev-parse foobar --
>   foobar
>   --
>   fatal: bad flag '--' used after filename
>
> That's not right.

Hmph, it looks like it is following the usual "zero-or-more dashed
options, zero-or-more revs and then zero-or-one double-dash and then
zero-or-more paths" rule to parse the thing.  "foobar" is a file and
not a rev, so "--" should not be there, no?

Confused why you think it is not right...
