From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] docs: add a basic description of the config API
Date: Tue, 07 Feb 2012 10:45:35 -0800
Message-ID: <7vhaz21nzk.fsf@alter.siamese.dyndns.org>
References: <20120206095306.GA2404@sigill.intra.peff.net>
 <20120206095346.GA4300@sigill.intra.peff.net>
 <7vbopb61cd.fsf@alter.siamese.dyndns.org>
 <20120207180625.GA27189@sigill.intra.peff.net>
 <20120207182302.GA31059@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 07 19:45:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ruq2v-00056E-Tn
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 19:45:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756229Ab2BGSpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 13:45:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62816 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756021Ab2BGSph (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 13:45:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF80773CA;
	Tue,  7 Feb 2012 13:45:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6I0xvVqKqPehj3p/qM6J+3Dcxxc=; b=m0AlWw
	/x/vLC0DGnjzlKQUZemA2XjWuaOdD0e55K6WiiXUgN4sy0w9Z/awJvsN6MB8uYQs
	H2lTX+0lK20bYc70GDWyNLuuzuvHZLH+9Kt4kNCZlsZ0uOu/qvUi+3L/3HbuxYpD
	zff78rCnt48033jEhnbefhnxbpEH53EA8KJBs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DMpADygteG3hXHNSMG3+ZI61uM17MuEY
	DZhXHXr+FiMWYVOnSGOdznlwCBw2KGw1kGY0a6gBEMf7SRuwbQzGezbpil7BEnBe
	23GbvycBEAIk6GVZM6rJoSDuDPTKXgzaGv0DePEiGrCNoUd4bfA7mJey1h1HnIMP
	1HmJPHuFSec=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4F5173C9;
	Tue,  7 Feb 2012 13:45:36 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7692673C8; Tue,  7 Feb 2012
 13:45:36 -0500 (EST)
In-Reply-To: <20120207182302.GA31059@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 7 Feb 2012 13:23:02 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EC6A679C-51BB-11E1-90B1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190198>

Jeff King <peff@peff.net> writes:

> -- >8 --
> Subject: drop odd return value semantics from userdiff_config
> ...
>  5 files changed, 12 insertions(+), 37 deletions(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 5a67c20..01956c8 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -2050,14 +2050,8 @@ static int git_blame_config(const char *var, const char *value, void *cb)
>  		return 0;
>  	}
>  
> -	switch (userdiff_config(var, value)) {
> -	case 0:
> -		break;
> -	case -1:
> +	if (userdiff_config(var, value) < 0)
>  		return -1;
> -	default:
> -		return 0;
> -	}
>  
>  	return git_default_config(var, value, cb);
>  }
> ...

Looks very nice ;-)
