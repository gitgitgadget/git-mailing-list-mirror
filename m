From: YONETANI Tomokazu <qhwt+git@les.ath.cx>
Subject: Re: [PATCH] Fix _XOPEN_SOURCE problem on DragonFly
Date: Thu, 1 Apr 2010 16:37:42 +0900
Message-ID: <20100401073742.GA52362@les.ath.cx>
References: <20100304020522.GA76036@les.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Apr 01 09:37:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxEyO-0001sl-S5
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 09:37:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753938Ab0DAHhs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Apr 2010 03:37:48 -0400
Received: from x219233.ppp.asahi-net.or.jp ([122.249.219.233]:4243 "EHLO
	les.ath.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753657Ab0DAHhq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Apr 2010 03:37:46 -0400
Received: by les.ath.cx (Postfix, from userid 1000)
	id D5EFD86654; Thu,  1 Apr 2010 16:37:42 +0900 (JST)
Content-Disposition: inline
In-Reply-To: <20100304020522.GA76036@les.ath.cx>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143721>

Hello.
Is there anything else I need to do to get this in?

On Thu, Mar 04, 2010 at 11:05:22AM +0900, YONETANI Tomokazu wrote:
> Hi.
> DragonFly has the same problem that FreeBSD used to have.  Since the
> return value of implicitly declared functions defaults to int, it can
> cause disasters on architectures where sizeof(int) < sizeof(void *).
> The patch below should address this issue.
> 
> Best regards,
> YONETANI Tomokazu.
> 
> diff --git a/git-compat-util.h b/git-compat-util.h
> index a3c4537..e292926 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -55,7 +55,8 @@
>  # else
>  # define _XOPEN_SOURCE 500
>  # endif
> -#elif !defined(__APPLE__) && !defined(__FreeBSD__)  && !defined(__USLC__) && !defined(_M_UNIX) && !defined(sgi)
> +#elif !defined(__APPLE__) && !defined(__FreeBSD__) && !defined(__USLC__) && \
> +      !defined(_M_UNIX) && !defined(sgi) && !defined(__DragonFly__)
>  #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
>  #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
>  #endif
