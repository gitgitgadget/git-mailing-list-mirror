From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] credential-osxkeychain: support more protocols
Date: Sun, 02 Jun 2013 12:46:40 -0700
Message-ID: <7vbo7onvmn.fsf@alter.siamese.dyndns.org>
References: <1369973275-13353-1-git-send-email-quanxunzhen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Xidorn Quan <quanxunzhen@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 02 21:46:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjEEs-0003Uj-H0
	for gcvg-git-2@plane.gmane.org; Sun, 02 Jun 2013 21:46:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756122Ab3FBTqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jun 2013 15:46:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57002 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756075Ab3FBTqq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jun 2013 15:46:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A53512418D;
	Sun,  2 Jun 2013 19:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aDAG6kuRzNzizomEHdzuL2s8iqg=; b=ySDomE
	s2V3g/CFdWgTf4EbKzj0ljn2gerBtxuuDTqY8zCPfGlT4Yw3VPFiAQx7y9qYSZ2F
	SZuYirPb2rRHqGOjwdj7Xyt04d7AXKk7cwyazf9B1+y/hYpOyPGaNGHP1ffRE40W
	mNvgvMTRVDQ3sffGv8c7pNZZVU4EN1lNgqFQY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ci2psFxVNqg/GzQlWjiw1ZuofjkdorRt
	tXJADprCWDNuWnfJ2RM+vbb/zbo6Ehu8oEzRj47q6MEoB4lHQPPKmRLnLxchB6Aq
	0ku69kIEEOsjKAapRxMFkGqunrLVtMVjaXbLW0hchAp0QAHJggzBWBC8w2ozdqGI
	97qkMSTr9Kk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9917D2418C;
	Sun,  2 Jun 2013 19:46:45 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F1B5224189;
	Sun,  2 Jun 2013 19:46:44 +0000 (UTC)
In-Reply-To: <1369973275-13353-1-git-send-email-quanxunzhen@gmail.com> (Xidorn
	Quan's message of "Fri, 31 May 2013 12:07:55 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 27B55DA8-CBBD-11E2-A21E-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226177>

Xidorn Quan <quanxunzhen@gmail.com> writes:

> Add protocol imap, imaps, ftp and smtp for credential-osxkeychain.
>
> Signed-off-by: Xidorn Quan <quanxunzhen@gmail.com>
> Acked-by: John Szakmeister <john@szakmeister.net>
> Acked-by: Jeff King <peff@peff.net>
> ---

Hmph, I think I already have an identical copy in my tree.  Sent a
wrong patch?

>  contrib/credential/osxkeychain/git-credential-osxkeychain.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> index 3940202..bcd3f57 100644
> --- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> +++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> @@ -127,10 +127,20 @@ static void read_credential(void)
>  		*v++ = '\0';
>  
>  		if (!strcmp(buf, "protocol")) {
> -			if (!strcmp(v, "https"))
> +			if (!strcmp(v, "imap"))
> +				protocol = kSecProtocolTypeIMAP;
> +			else if (!strcmp(v, "imaps"))
> +				protocol = kSecProtocolTypeIMAPS;
> +			else if (!strcmp(v, "ftp"))
> +				protocol = kSecProtocolTypeFTP;
> +			else if (!strcmp(v, "ftps"))
> +				protocol = kSecProtocolTypeFTPS;
> +			else if (!strcmp(v, "https"))
>  				protocol = kSecProtocolTypeHTTPS;
>  			else if (!strcmp(v, "http"))
>  				protocol = kSecProtocolTypeHTTP;
> +			else if (!strcmp(v, "smtp"))
> +				protocol = kSecProtocolTypeSMTP;
>  			else /* we don't yet handle other protocols */
>  				exit(0);
>  		}
