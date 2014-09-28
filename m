From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] Do not make trace.c/getnanotime an inlined function
Date: Sun, 28 Sep 2014 21:15:29 +0200
Message-ID: <54285E51.3090209@kdbg.org>
References: <1411890626-28237-1-git-send-email-bdwalton@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: karsten.blees@gmail.com, gitster@pobox.com, git@vger.kernel.org
To: Ben Walton <bdwalton@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 28 21:15:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XYJwl-0007Mk-M9
	for gcvg-git-2@plane.gmane.org; Sun, 28 Sep 2014 21:15:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727AbaI1TPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2014 15:15:38 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:11582 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750837AbaI1TPi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Sep 2014 15:15:38 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3j5c5364SBz5tlJ;
	Sun, 28 Sep 2014 21:15:19 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 6408E19F5AF;
	Sun, 28 Sep 2014 21:15:29 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.0
In-Reply-To: <1411890626-28237-1-git-send-email-bdwalton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257612>

Am 28.09.2014 um 09:50 schrieb Ben Walton:
> Oracle Studio compilers don't allow for static variables in functions
> that are defined to be inline. GNU C does permit this. Let's reference
> the C99 standard though, which doesn't allow for inline functions to
> contain modifiable static variables.
> 
> Signed-off-by: Ben Walton <bdwalton@gmail.com>
> ---
>  trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/trace.c b/trace.c
> index b6f25a2..4778608 100644
> --- a/trace.c
> +++ b/trace.c
> @@ -385,7 +385,7 @@ static inline uint64_t gettimeofday_nanos(void)
>   * Returns nanoseconds since the epoch (01/01/1970), for performance tracing
>   * (i.e. favoring high precision over wall clock time accuracy).
>   */
> -inline uint64_t getnanotime(void)
> +uint64_t getnanotime(void)
>  {
>  	static uint64_t offset;
>  	if (offset > 1) {
> 

But then the function could stay static, no?

-- Hannes
