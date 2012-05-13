From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] builtin/blame.c: Fix a "Using plain integer as NULL pointer"
 warning
Date: Mon, 14 May 2012 01:39:41 +0200
Message-ID: <4FB0463D.4010909@lsrfire.ath.cx>
References: <4FB02A7C.1000605@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Mon May 14 01:39:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STiOF-0003Bl-C3
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 01:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753705Ab2EMXjq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 May 2012 19:39:46 -0400
Received: from india601.server4you.de ([85.25.151.105]:60394 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753635Ab2EMXjp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2012 19:39:45 -0400
Received: from [192.168.2.105] (p579BE964.dip.t-dialin.net [87.155.233.100])
	by india601.server4you.de (Postfix) with ESMTPSA id 5099C2F80FC;
	Mon, 14 May 2012 01:39:43 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <4FB02A7C.1000605@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197759>

Am 13.05.2012 23:41, schrieb Ramsay Jones:
>
>
> Signed-off-by: Ramsay Jones<ramsay@ramsay1.demon.co.uk>
> ---
>
> Hi Junio,
>
> I try to catch these warnings, while the topics are still in the
> pu branch, so that we can squash the fix into them before they
> hit next. I don't know how I missed this one (commit 4b4132f,
> "blame: factor out helper for calling xdi_diff()", 09-05-2012)
> which was part of the 'rs/xdiff-lose-emit-func' branch.
>
> Sorry about that.
>
> ATB,
> Ramsay Jones
>
>
>   builtin/blame.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 778d661..24d3dd5 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -93,7 +93,7 @@ static int diff_hunks(mmfile_t *file_a, mmfile_t *f=
ile_b, long ctxlen,
>   {
>   	xpparam_t xpp =3D {0};
>   	xdemitconf_t xecfg =3D {0};
> -	xdemitcb_t ecb =3D {0};
> +	xdemitcb_t ecb =3D {NULL};
>
>   	xpp.flags =3D xdl_opts;
>   	xecfg.ctxlen =3D ctxlen;

The warning is given by sparse, not a C compiler, correct?  It's=20
probably worth shutting it up by making that change; my excuse for usin=
g=20
{0} is that it is such a nice and portable idiom [1] for initializing=20
any structure, however.

Ren=E9


[1] http://www.ex-parrot.com/~chris/random/initialise.html
