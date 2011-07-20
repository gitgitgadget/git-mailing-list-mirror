From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/14] http: use hostname in credential description
Date: Wed, 20 Jul 2011 15:17:08 -0700
Message-ID: <7vr55k4mxn.fsf@alter.siamese.dyndns.org>
References: <20110718074642.GA11678@sigill.intra.peff.net>
 <20110718075232.GJ12341@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 21 00:17:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qjf4w-0005ZY-Ph
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 00:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187Ab1GTWRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 18:17:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40478 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751691Ab1GTWRK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2011 18:17:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BC82585E;
	Wed, 20 Jul 2011 18:17:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=+oxKHwp0uIqaH6mY07G39CdrJEE=; b=wxnPULWxuDqJmf3yiNiV
	TEkE8YqcmLRzHOvzEtVRa8PuFNsrUvtPlezAy6CeflPL0NYpzDmlEoFa4rgyPGe5
	v7pmRyjrF+Tl4fqXb91a8WQ0VvMOblQ1VyRqkRrtSucn+h+5xWmx/hTWCWvGqIyp
	uViyJ8MVsS5Y4hR+RtALb7s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=x+zwm4vIo7NaJt9BjcQrj3PsRX4rzjxdWF8JUCRYqAmps3
	X4MwP0EvE3XPGKFsNIRB3rDGtfcXdV/lRl89lpnX4x5/3Xq43E17JxZp1MjH+HCm
	HxWkLZRR1gSKGTIT2AbTBWWJBMLFL+RZuzvIq1DV2NKFBUmctpp6TZZjtXvxU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63EEE585D;
	Wed, 20 Jul 2011 18:17:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ED001585C; Wed, 20 Jul 2011
 18:17:09 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 02E10360-B31E-11E0-ABFB-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177554>

Jeff King <peff@peff.net> writes:

> @@ -342,11 +341,11 @@ static void http_auth_init(const char *url)
>  		host = at + 1;
>  	}
>  
> +	http_auth.description = url_decode_mem(host, slash - host);

Could a hosting site like github host multiple repositories, each of which
the user may interact with under different identity?  Just wondering if it
is sufficient to say "http://example.com/" or it needs to be more
specific, e.g. "http://example.com/p/project.git/".
