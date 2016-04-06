From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 5/6] builtin/verify-tag: move verification code to tag.c
Date: Wed, 06 Apr 2016 09:33:17 -0700
Message-ID: <xmqq60vuzohe.fsf@gitster.mtv.corp.google.com>
References: <1459872449-7537-1-git-send-email-santiago@nyu.edu>
	<1459872449-7537-6-git-send-email-santiago@nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: santiago@nyu.edu
X-From: git-owner@vger.kernel.org Wed Apr 06 18:33:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anqOW-00020q-HL
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 18:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbcDFQdW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 12:33:22 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:51028 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751060AbcDFQdV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 12:33:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E2E6A52464;
	Wed,  6 Apr 2016 12:33:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qY9vGeVDwlWFwIsG453rg4dyzjc=; b=ulQNc9
	5gtJuCm+z5VABtAgmrirJEGwJQDVIHV2IWyl4wzT4RV74g6xJynPif7kb6RiA5WI
	lKsRFQlP8SOlq1JJVgdkrwcW+AxUfB5h7eNtQPEI6yPMnRIvctiM5JLiMlsDPIBe
	CGr7WCGnRBLu3IwoSyOCjwzw8qaZnqRf5qdnU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UAHniCy46LEuRBUStTLONGX9Htpd39JZ
	+JQQAsXzxX7jgpPOiOQ/lLSjZVA7YDNu6VufHUQWJuuUBKbtZguBHALgtw5PY/aR
	aCUGMJlNSAtUgJyehW4WB29cB9DkL/KIdrnAdAczx5m0DttdMa8KTFtP9FnqxBq/
	RFLOn7Xd9Pk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DA0A952463;
	Wed,  6 Apr 2016 12:33:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5841752460;
	Wed,  6 Apr 2016 12:33:19 -0400 (EDT)
In-Reply-To: <1459872449-7537-6-git-send-email-santiago@nyu.edu>
	(santiago@nyu.edu's message of "Tue, 5 Apr 2016 12:07:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 45698992-FC15-11E5-81AC-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290847>

santiago@nyu.edu writes:

> From: Santiago Torres <santiago@nyu.edu>
>
> The PGP verification routine for tags could be accessed by other
> commands that require it. We do this by moving it to the common tag.c
> module. We rename the verify_tag() function to gpg_verify_tag() to avoid
> conflicts with the mktag.c function.

After outlining the observation and opinion, we describe the changes
as if we are ordering somebody to "do this, do that" to the codebase,
like so:

	... require it.

        Move the function to tag.c and make it public, and rename it
	gpg_verify_tag() to make its name more descriptive and also
	avoid conflicts with a static function in builtin/mktag.c.
