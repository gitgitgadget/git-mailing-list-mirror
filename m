From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 2/2] gettext.h: add parentheses around N_ expansion
Date: Tue, 06 Jan 2015 13:24:21 +0000
Message-ID: <54ABE205.70801@ramsay1.demon.co.uk>
References: <ecb18f9d6ac56da0a61c3b98f8f2236@74d39fa044aa309eaea14b9f57fe79c> <f67db70c63f8dcbfc58d7ffda86ff10@74d39fa044aa309eaea14b9f57fe79c>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 14:38:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8UDg-0002JH-Ho
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 14:30:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754938AbbAFNao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 08:30:44 -0500
Received: from mdfmta005.mxout.tch.inty.net ([91.221.169.46]:35232 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753432AbbAFNan (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 08:30:43 -0500
X-Greylist: delayed 367 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Jan 2015 08:30:43 EST
Received: from smtp.demon.co.uk (unknown [127.0.0.1])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id A9D8718DECE
	for <git@vger.kernel.org>; Tue,  6 Jan 2015 13:24:38 +0000 (GMT)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 9D0FC12816C;
	Tue,  6 Jan 2015 13:24:31 +0000 (GMT)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 3EA44128163;
	Tue,  6 Jan 2015 13:24:26 +0000 (GMT)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta009.tch.inty.net (Postfix) with ESMTP;
	Tue,  6 Jan 2015 13:24:22 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <f67db70c63f8dcbfc58d7ffda86ff10@74d39fa044aa309eaea14b9f57fe79c>
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262063>

On 06/01/15 10:34, Kyle J. McKay wrote:
> The N_ macro is used to mark strings for translation without
> actually translating them.  At runtime the string is expected
> to be passed to the gettext API for translation.
> 
> If two N_ macro invocations appear next to each other with only
> whitespace (or nothing at all) between them, the two separate
> strings will be marked for translation, but the preprocessor
> will then combine the strings into one and at runtime the
> string passed to gettext will not match the strings that were
> translated.
> 
> Avoid this by adding parentheses around the expansion of the
> N_ macro so that instead of ending up with two adjacent strings
> that are then combined by the preprocessor, two adjacent strings
> surrounded by parentheses result instead which causes a compile
> error so the mistake can be quickly found and corrected.
> 
> Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
> ---
> This patch is optional, but prevents the problem fixed by 1/2
> from recurring.
> 
>  gettext.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/gettext.h b/gettext.h
> index 7671d09d..d11a4139 100644
> --- a/gettext.h
> +++ b/gettext.h
> @@ -63,6 +63,6 @@ const char *Q_(const char *msgid, const char *plu, unsigned long n)
>  }
>  
>  /* Mark msgid for translation but do not translate it. */
> -#define N_(msgid) msgid
> +#define N_(msgid) (msgid)
>  
>  #endif
> 

Hmm, see commit 642f85faa ("i18n: avoid parenthesized string as
array initializer", 07-04-2011), for a counter-point. :-P

ATB,
Ramsay Jones
