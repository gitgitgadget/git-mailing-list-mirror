From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3]http: authenticate on NTLM proxies and others
 suppported by CuRL
Date: Fri, 02 Mar 2012 10:50:18 -0800
Message-ID: <7v4nu6et1x.fsf@alter.siamese.dyndns.org>
References: <4F4FBDBA.8040609@seap.minhap.es>
 <7v399snnrs.fsf@alter.siamese.dyndns.org> <4F50D16D.3090800@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, sam@vilain.net
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Fri Mar 02 19:50:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3XYf-0005Ge-NA
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 19:50:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226Ab2CBSuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 13:50:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35012 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754743Ab2CBSuU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 13:50:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 263656708;
	Fri,  2 Mar 2012 13:50:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AGnAnV7pWVFxM466kIQLaKAL4zc=; b=i+dwcB
	BVlSuWedZxHhZ0BoCz09mX3JPbdMo6M2nRmIoNRiPgJmJXxcVyJlxu0cLUbfhgYW
	uJmdggBF/wYBSX7ax+Wn03cmR97iRCCFdOgjKjsElvsNObivjWjwray0I2exJahB
	ibyKGeaFun4gHYlzqqXDbx07xMTkiCdQQv2zY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZuLbp31+wYvRbYt0RYmAgnP+9I0YcTbu
	jDIMiCKuljVjb0VopUzeuBvWYs2hYBvjNU70tx83j+GHNWCJYhUBh/e4CWdi5wNc
	iyRTdDQhrflnq4sLux7fE/c3CmwpkABfsztVz7BcC0m1hDvyYr0dHXDYsF+Oxabz
	BD3r/68yQxA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C0396707;
	Fri,  2 Mar 2012 13:50:20 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6F8D86706; Fri,  2 Mar 2012
 13:50:19 -0500 (EST)
In-Reply-To: <4F50D16D.3090800@seap.minhap.es> (Nelson Benitez Leon's message
 of "Fri, 02 Mar 2012 14:55:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8EFEBC3A-6498-11E1-826D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192060>

Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es> writes:

Is there anything specific about NTLM in this patch?  Let's retitle it to
something like

	http: support proxies that needs authentication

> ...
> So as CURLAUTH_ANY provide us out-of-the-box proxy support, we don't
> want it activated manually from a config option, instead we added it
> automatically when a proxy is being used.

I can sort of parse this paragraph but cannot follow the logic.

 - Because we use CURLAUTH_ANY, a proxy that requires authentication is
   supported out-of-the-box.

 - We do not want having to manually enable it.

 - Instead of adding a manual configuration, we do so automatically.

It sounds like it is saying the same thing three times.  Do we even need
that paragraph?  Shouldn't we drop it instead?

Otherwise it all looks good, so you can either

 (1) explain why the above suggestions are wrong and why I should apply
     the message I am responding to as-is;

 (2) send another re-roll; or

 (3) say "yeah, your suggestions all sound good to me", in which case I'll
     just locally amend and apply.

Thanks.

>
> Signed-off-by: Nelson Benitez Leon <nbenitezl@gmail.com>
> ---
>  http.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/http.c b/http.c
> index 0ffd79c..8ac8eb6 100644
> --- a/http.c
> +++ b/http.c
> @@ -295,8 +295,10 @@ static CURL *get_curl_handle(void)
>  	if (curl_ftp_no_epsv)
>  		curl_easy_setopt(result, CURLOPT_FTP_USE_EPSV, 0);
>  
> -	if (curl_http_proxy)
> +	if (curl_http_proxy) {
>  		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
> +		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
> +	}
>  
>  	return result;
>  }
