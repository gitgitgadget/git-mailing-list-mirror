From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Avoid segfault in diff --stat rename output.
Date: Mon, 22 May 2006 18:02:39 -0700
Message-ID: <7vzmh98seo.fsf@assigned-by-dhcp.cox.net>
References: <e7bda7770605221609h7c18c2ccpe92db34050d46f9f@mail.gmail.com>
	<BAYC1-PASMTP115C9137E5BDABD705881BAE9B0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 23 03:02:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiLIW-0006fe-AN
	for gcvg-git@gmane.org; Tue, 23 May 2006 03:02:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbWEWBCo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 21:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWEWBCo
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 21:02:44 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:9464 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751218AbWEWBCn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 May 2006 21:02:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060523010242.QLIQ5347.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 22 May 2006 21:02:42 -0400
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP115C9137E5BDABD705881BAE9B0@CEZ.ICE>
	(seanlkml@sympatico.ca's message of "Mon, 22 May 2006 20:36:34 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20558>

Sean <seanlkml@sympatico.ca> writes:

> Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>
> ---
>  diff.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 7f35e59..a7bb9b9 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -237,7 +237,7 @@ static char *pprint_rename(const char *a
>  		if (a_midlen < 0) a_midlen = 0;
>  		if (b_midlen < 0) b_midlen = 0;
>  
> -		name = xmalloc(len_a + len_b - pfx_length - sfx_length + 7);
> +		name = xmalloc(pfx_length + a_midlen + b_midlen + sfx_length + 7);
>  		sprintf(name, "%.*s{%.*s => %.*s}%s",

Obviously correct given what the sprintf() that immediately
follows does.  Sheesh, what was I smoking back then.  *BLUSH*

Thanks.
