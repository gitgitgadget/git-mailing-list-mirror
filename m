From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] MinGW: fix diff --no-index /dev/null ...
Date: Sat, 7 Mar 2009 20:56:58 +0100
Message-ID: <200903072056.58465.j6t@kdbg.org>
References: <cover.1236441065u.git.johannes.schindelin@gmx.de> <dba002b9e521c639847650fbaeb8b87b66b9562e.1236441065u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 07 20:58:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg2fI-0003ZD-Fy
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 20:58:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754984AbZCGT5F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Mar 2009 14:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753826AbZCGT5D
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 14:57:03 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:15149 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753516AbZCGT5B (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 14:57:01 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id C7F5E10011;
	Sat,  7 Mar 2009 20:56:58 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 91D072814F;
	Sat,  7 Mar 2009 20:56:58 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <dba002b9e521c639847650fbaeb8b87b66b9562e.1236441065u.git.johannes.schindelin@gmx.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112569>

On Samstag, 7. M=E4rz 2009, Johannes Schindelin wrote:
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -38,6 +38,10 @@ static int get_mode(const char *path, int *mode)
>
>  	if (!path || !strcmp(path, "/dev/null"))
>  		*mode =3D 0;
> +#ifdef _WIN32
> +	else if (!strcasecmp(path, "nul"))
> +		*mode =3D 0;
> +#endif
>  	else if (!strcmp(path, "-"))
>  		*mode =3D create_ce_mode(0666);
>  	else if (lstat(path, &st))

IMO this #ifdef is a reasonable compromise. Trying to move this into=20
git-compat-util.h or mingw.h somehow would only obfuscate the code.

Tested-by: Johannes Sixt <j6t@kdbg.org>

-- Hannes
