From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] am: learn passing -b to mailinfo
Date: Wed, 11 Jan 2012 17:35:34 -0800
Message-ID: <7vzkdt4s9l.fsf@alter.siamese.dyndns.org>
References: <e915a551c9bbf12f4d8fd929e9ed24f3223790ee.1326312730.git.trast@student.ethz.ch> <19539098c07a207f3bd24f5a145ba3b6c5e46766.1326312730.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jan 12 02:35:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rl9a0-0003yH-Cx
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 02:35:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924Ab2ALBfi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 20:35:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35598 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751890Ab2ALBfh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 20:35:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B38257971;
	Wed, 11 Jan 2012 20:35:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LSSvAK2Z9sLUHEpydaWeVuPMVCY=; b=MrIWRY
	Ti98PEPgr3cmqHr5qX9dKRG+YtsF9SsX6bAr3xUqv8owg55bqbiZo+Ua95pTlZ3S
	bJGJY3rhpO2HsgYN0ldQLfqJveaukFe5IQ0Bw3x0M3tQhQp0N6M33YVhqa+P3VT0
	yTBfG4KD4mnpyHID2N7GmH1p96Lu8voCUcSS8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=njAQ2lNafkkNZ1vP1uyC1ceyKbIqy53r
	1K63cJp8khGSWUFuWbnfAT8R+6G1pYms8MFk6e2i/pegK5HoLVxhMbwQ2HakOOay
	nKJw2qK1vkbqWiqwy2w2xjleafistnf8YVhwLoSeg7Xc+44jK5LeOR0QHpS+tKxE
	koUk6VGAQAE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A97CF7970;
	Wed, 11 Jan 2012 20:35:36 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3A864796D; Wed, 11 Jan 2012
 20:35:36 -0500 (EST)
In-Reply-To: <19539098c07a207f3bd24f5a145ba3b6c5e46766.1326312730.git.trast@student.ethz.ch> (Thomas Rast's message of "Wed, 11 Jan 2012 21:13:43 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B9DBD79C-3CBD-11E1-9835-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188412>

Thomas Rast <trast@student.ethz.ch> writes:

> @@ -571,8 +574,8 @@ then
>  else
>  	utf8=-n
>  fi
> -if test "$(cat "$dotest/keep")" = t
> -then
> +keep=$(cat "$dotest/keep")
> +if test "$keep" = t
>  	keep=-k
>  fi

Curious.

Who writes 't' to $dotest/keep after this patch is applied?

I also do not want to worry about "echo" portability issues that may come
from an existing

	echo "$keep" >"$dotest/keep"

that this patch does not touch.

I suspect that this patch was not tested in a way to exercise this
codepath; shell would have barfed when seeing the lack of "then" here, no?
