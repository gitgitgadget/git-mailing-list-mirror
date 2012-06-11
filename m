From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t: Replace 'perl' by $PERL_PATH
Date: Mon, 11 Jun 2012 12:15:03 -0700
Message-ID: <7v1ull7j9k.fsf@alter.siamese.dyndns.org>
References: <1339441313-5296-1-git-send-email-vfr@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.om
To: vfr@lyx.org
X-From: git-owner@vger.kernel.org Mon Jun 11 21:15:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeA53-0003O7-W5
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 21:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987Ab2FKTPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 15:15:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57827 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750731Ab2FKTPH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 15:15:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CCC3937C;
	Mon, 11 Jun 2012 15:15:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q1CAGDITnhW0inBK1TwECL7vH50=; b=pQqhIi
	trWNuLOp7bW7dV8rXsKgvHqn/Fl2gPxihRC7mw1y9LK5jDc0lqF3zj6xetUTwz8j
	OK8fdpcxnt9VBBiZDMYD/oevBwmh72Qwv69C2Jku2+xN5egVJ0po73BT1urxF/CK
	ASoUSTpM/QCn9xycuYDvBSfX0lA8o8/MoqqjU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rfpgs6yxXtitdIO/mpP/ksv0cEd+RX90
	7964musIgB65FG9bw5NSfr384Tk8KnBOjDQsaQpbSoB1hntbu8QnDdLnxN9qkY/P
	hisaKs+z25t3yBDwRiSMcWi0hCpoKWgconrDmTuZa4DX8lpEveXjoEYpisrz/mOE
	34DWVbEqUdc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 749D7937B;
	Mon, 11 Jun 2012 15:15:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6BB60937A; Mon, 11 Jun 2012
 15:15:05 -0400 (EDT)
In-Reply-To: <1339441313-5296-1-git-send-email-vfr@lyx.org> (vfr@lyx.org's
 message of "Mon, 11 Jun 2012 19:01:53 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C06EA036-B3F9-11E1-81D8-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199710>

vfr@lyx.org writes:

> From: Vincent van Ravesteijn <vfr@lyx.org>
>
> GIT-BUILD-OPTIONS defines PERL_PATH to be used in the test suite. Only a
> few tests already actually use this variable when perl is needed. The
> other test just call 'perl' and it might happen that the wrong perl
> interpreter is used.
>
> This becomes problematic on Windows, when the perl interpreter that is
> compiled and installed on the Windows system is used, because this perl
> interpreter might introduce some unexpected LF->CRLF conversions.
>
> This patch makes sure that $PERL_PATH is used everywhere in the test suite
> and that the correct perl interpreter is used.
>
> Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>
> ---

There was already this discussion:

    http://thread.gmane.org/gmane.comp.version-control.git/132560/focus=132561

which basically dismissed effort along this line with "If the perl
in your PATH is so broken that it can't be used for simple helpers,
then you should fix your PATH."

I personally do not mind if we do this consistently, but I am not
sure your $PERL_PATH that is not quoted is the right way to invoke
it; look for PERL_PATH in t/ to see the existing uses.
