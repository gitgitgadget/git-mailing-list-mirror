From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 10/21] pack-bitmap: add support for bitmap indexes
Date: Mon, 02 Dec 2013 13:43:43 -0800
Message-ID: <xmqq7gbnq67k.fsf@gitster.dls.corp.google.com>
References: <20131114124157.GA23784@sigill.intra.peff.net>
	<20131114124432.GJ10757@sigill.intra.peff.net>
	<87siuedhvj.fsf@thomasrast.ch>
	<20131202161208.GB24202@sigill.intra.peff.net>
	<xmqqk3fnq9bh.fsf@gitster.dls.corp.google.com>
	<20131202204715.GA18842@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <tr@thomasrast.ch>, git@vger.kernel.org,
	Vicent =?utf-8?Q?Mart=C3=AD?= <vicent@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 02 22:43:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnbHW-00059s-RI
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 22:43:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752747Ab3LBVnv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Dec 2013 16:43:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40676 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752007Ab3LBVnu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Dec 2013 16:43:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 43F2258A6A;
	Mon,  2 Dec 2013 16:43:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zH2jltDVpmDC1oI6Sbf6OIytEwM=; b=OqlsLF
	6sZFveXXnM9Ne/gRugB1qHyuJXVX99on+l45Of2UY8QUtkBmxuiF6vO5yhnPkiH/
	8A6x1cP8bw40WOvsD9+AN0h1LUbh1q35H2sbA9Xa2lV5R1Cz5HhWC1ETahxxJVGd
	IswFUod9d1xRtmJLo93v1uEos0BF+KUNXJpuI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HKGGu/SmQd/nBorzdrNiv6mmHnPBw+e6
	jHOnvBIWv5Hc3qBeEtvyaoHm3twWFO2+3G/Takm1H3VjKOAj4eLwqRB4wCWbtdXi
	KSMgOSkV3UY7TJL3eOFEuTx+8cUeXuWNKt0SkwaKUMjFQY61yZJK3XoVacK/wRj5
	dznAl+hjKPM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3378558A69;
	Mon,  2 Dec 2013 16:43:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6DD1658A68;
	Mon,  2 Dec 2013 16:43:48 -0500 (EST)
In-Reply-To: <20131202204715.GA18842@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 2 Dec 2013 15:47:15 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D39C8D54-5B9A-11E3-B022-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238656>

Jeff King <peff@peff.net> writes:

> Sorry, I was not very clear about what I said. I do not think "go get a
> newer gcc" is a good thing to be telling people. But I wonder:
>
>   a. if there are actually people on systems that have pre-c99 compilers
>      in 2013
>
>   b. if there are, do they actually _use_ the ancient system compiler,
>      and not just install gcc as the first step anyway?
>
> In other words, I am questioning whether we would have to tell anybody
> "go install gcc" these days. I'm not sure of the best way to answer that
> question, though.

Thanks. We are at the same wavelength.  I do not know what the best
way to answer that question, either.  Unleashing such a change to
the wild is one obvious way to do so, and it will give us the most
accurate answer, so it may be the "best way" if we primarily care
about the quality of the answer, but we value the experience of our
direct consumers even more when judging what is best, so...
