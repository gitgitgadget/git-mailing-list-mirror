From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 17/21] bisect: rename count_distance() to compute_weight()
Date: Fri, 15 Apr 2016 15:12:36 -0700
Message-ID: <xmqq37qm8qsr.fsf@gitster.mtv.corp.google.com>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
	<1460294354-7031-18-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sat Apr 16 00:12:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arByn-0004kS-3X
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 00:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752284AbcDOWMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 18:12:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62104 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751587AbcDOWMk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 18:12:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3F40A1200A;
	Fri, 15 Apr 2016 18:12:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HnFE3KROLndZBozG6IEQYrS/sAo=; b=twaMyA
	ffX9NhmwUO8sTR81tKwewNhRo8xji+JW+6apqkJ6dVWCi31hm/FopGmwfMt6UKVs
	Qzknpu3kqWCV+aP2onWFRjOnFaqulrd/vqHxIY702mRIdRfu2PCP8YrTyXFoV1fj
	kpDM3G+JSUJGeHerAlnX9Rac8u3lJJTb/crrc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HetVQNZSNQM+KiIDIKiVB/2OJGiJAaRk
	DtdhFlgxpz75gq/po0ts5PieIoTNxLYQh/Hv31ZTLoWCripMpYj7Nnxg3YmyfDa9
	fWrUHXsbInFljHvFQyRNGZ1iuragNZb3jGy54NHpflz6BZBlRFnvnA86e7BKXwwT
	NH3dkRTeDt4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3616912008;
	Fri, 15 Apr 2016 18:12:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 97CC712006;
	Fri, 15 Apr 2016 18:12:37 -0400 (EDT)
In-Reply-To: <1460294354-7031-18-git-send-email-s-beyer@gmx.net> (Stephan
	Beyer's message of "Sun, 10 Apr 2016 15:19:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 29997A94-0357-11E6-A079-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291682>

Stephan Beyer <s-beyer@gmx.net> writes:

> Let us use the term "weight" for the number of ancestors
> of each commit, and "distance" for the number
> min{weight, #commits - weight}. (Bisect finds the commit
> with maximum distance.)
>
> In these terms, "count_distance()" is the wrong name of
> the function. So it is renamed to "compute_weight()",
> and it also directly sets the computed weight.
>
> Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
> ---
>  bisect.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Makes sense.  We can think of the "distance" the distance from the
periphery of the graph we are looking at, and "bisection" is to find
a point close to the center of the graph.
