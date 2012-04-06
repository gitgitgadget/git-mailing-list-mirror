From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] tests: add initial bash completion tests
Date: Fri, 06 Apr 2012 16:33:58 -0700
Message-ID: <7vbon4zb89.fsf@alter.siamese.dyndns.org>
References: <1333740519-3792-1-git-send-email-felipe.contreras@gmail.com>
 <20120406201926.GA1677@sigill.intra.peff.net>
 <CAMP44s3-Ji33oG=Os_O9KpxawWzZzmiZ04QMTokQ+K6_x-31MA@mail.gmail.com>
 <7vfwcgzbrd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 07 01:34:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGIfO-0002PS-Um
	for gcvg-git-2@plane.gmane.org; Sat, 07 Apr 2012 01:34:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758305Ab2DFXeB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 19:34:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40004 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753230Ab2DFXeA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 19:34:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 41494792C;
	Fri,  6 Apr 2012 19:34:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wW714nFpKSj2OWvikDoBqV6f2ys=; b=BUx2A4
	2IRErvDsPVGcZW47dyxzBeAutVfuxgbLG2UaggfraWpcSIrsrkDj98XJQ1hQjvY8
	gCgZ+BCFfjoNjY5r2GnkvPTIpfyWKOQmb3564VMf/bfFs0KXB0FIXfNivsz1Yiwc
	WdSQ5JbnfoQtSx1mFekhJbVPm9ArGvwFKuQkQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rUOQthdSRdEj1+3v9IjmXfVdjTWyZoWX
	qlNZ6Sh8YTvvXK8XxcbvF4QYD/uqkSd/qtuyUoqMcU1LehEEkk9bY0moWItuVIqP
	KGqcG2VnFHg7atMFcBud5meP1Uc16BYkC3+kwIE4GHn1ljpuZLBbjH5dcPRtj+kD
	lbkSgqGh1wE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 366F4792B;
	Fri,  6 Apr 2012 19:34:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 944FE792A; Fri,  6 Apr 2012
 19:33:59 -0400 (EDT)
In-Reply-To: <7vfwcgzbrd.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 06 Apr 2012 16:22:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FC40D526-8040-11E1-8387-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194924>

Junio C Hamano <gitster@pobox.com> writes:

> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> What about this instead?
>>
>> #!/bin/sh
>>
>> if type bash >/dev/null 2>&1
>> then
>> 	# execute inside bash
>> 	[ -z "$BASH" ] && exec bash $0
>> else
>> 	echo '1..0 #SKIP skipping bash completion tests; bash not available'
>> 	exit 0
>> fi
> ...
> Other than that, it is very much simple and straight-forward.  I like it.

It probably is even simpler to do it like this.

if test -z "$BASH" && ! exec bash "$0" "$@"
then
	echo '1..0 #SKIP...'
        exit 0
fi

... rest of the test starting with ". ./test-lib.sh" ...
