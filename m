From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/14] introduce credentials API
Date: Thu, 21 Jul 2011 14:59:31 -0700
Message-ID: <7vvcuvz458.fsf@alter.siamese.dyndns.org>
References: <20110718074642.GA11678@sigill.intra.peff.net>
 <20110718075034.GF12341@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 21 23:59:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qk1HP-00033K-Aq
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 23:59:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752718Ab1GUV7f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jul 2011 17:59:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62222 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750868Ab1GUV7e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2011 17:59:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5EF0C363E;
	Thu, 21 Jul 2011 17:59:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lXMxEx9zUvQZeUhofNZ73VidQO0=; b=Eq7T3X
	6a1MbdMnyp8a6Np+vfbbY/M7XE3ToYpkecnLkhL3V3B3NGBn8x3f/Yt17oNR6sya
	pUcM9kVxa0sYGmvY0x4t5Ht4TmkCBPKMQl9ZZ8JH5Zu2NQXH78A0up4Pibqc9tef
	WearYtYcyNJ9WqiVme9ATwwXxrDIgV89Tian0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OJeSwmsm5hOzLT189x47+KBiP4wSbTr/
	nrbgT+J23WQJTgKJosfyOTdb7B+j/brihb+/uBLWHVSQXz9odw6vR/mkpHyGiQki
	FPEBAUMiBoEY+YPBWb785OD2PFpvfUFny1idojeFDGRpEXzWGsXCmjsXOtp0AODQ
	eT9ReeBAaWs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56572363D;
	Thu, 21 Jul 2011 17:59:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E29F8363C; Thu, 21 Jul 2011
 17:59:32 -0400 (EDT)
In-Reply-To: <20110718075034.GF12341@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 18 Jul 2011 03:50:34 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B73EEB58-B3E4-11E0-9A6B-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177627>

Jeff King <peff@peff.net> writes:

> diff --git a/credential.c b/credential.c
> new file mode 100644
> index 0000000..c403289
> --- /dev/null
> +++ b/credential.c
> @@ -0,0 +1,190 @@
> ...
> +void credential_fill(struct credential *c, const struct string_list *methods)
> +{
> +	...
> +	}
> +	die(err.buf);

credential.c:195: error: format not a string literal and no format arguments

This needs to be

	die("%s", err.buf);
