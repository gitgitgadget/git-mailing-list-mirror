From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v7 2/7] wrap-for-bin: Make bin-wrappers chainable
Date: Wed, 03 Jul 2013 12:30:49 +0200
Message-ID: <51D3FD59.7090701@alum.mit.edu>
References: <1372804789-12732-1-git-send-email-benoit.person@ensimag.fr> <1372804789-12732-3-git-send-email-benoit.person@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Celestin Matte <celestin.matte@ensimag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: benoit.person@ensimag.fr
X-From: git-owner@vger.kernel.org Wed Jul 03 12:30:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuKKv-0005rB-UD
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 12:30:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753131Ab3GCKax (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 06:30:53 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:63373 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752239Ab3GCKax (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jul 2013 06:30:53 -0400
X-AuditID: 1207440f-b7f786d000001f20-78-51d3fd5c397f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 30.6A.07968.C5DF3D15; Wed,  3 Jul 2013 06:30:52 -0400 (EDT)
Received: from [192.168.101.152] (mx.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r63AUniS023232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 3 Jul 2013 06:30:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <1372804789-12732-3-git-send-email-benoit.person@ensimag.fr>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsUixO6iqBvz93KgwfsH4hYTF81itLiwqo/V
	outKN5NFQ+8VZotLn9ezOrB6/F75idFj4pfjrB4XLyl7fN4kF8ASxW2TlFhSFpyZnqdvl8Cd
	0XzHqeA2X8W/N39YGhjn8XQxcnJICJhInFo3iQ3CFpO4cG89kM3FISRwmVFiyZFVzBDOVSaJ
	ta3X2EGqeAW0Jf7dewtUxcHBIqAqMW2XAEiYTUBXYlFPMxNIWFQgTOLKb1WIakGJkzOfsIDY
	IgIyElubLoONZBZYxiix88BfVpCEsICrRMOxM2C2kEAro8S2S2AzOQU8JWbdfw92HLOAjsS7
	vgfMELa8xPa3c5gnMArMQrJjFpKyWUjKFjAyr2KUS8wpzdXNTczMKU5N1i1OTszLSy3SNdHL
	zSzRS00p3cQICWv+HYxd62UOMQpwMCrx8Do8uxQoxJpYVlyZe4hRkoNJSZT36o/LgUJ8Sfkp
	lRmJxRnxRaU5qcWHGCU4mJVEeCf+AcrxpiRWVqUW5cOkpDlYlMR51Zeo+wkJpCeWpGanphak
	FsFkZTg4lCR454M0ChalpqdWpGXmlCCkmTg4QYZzSYkUp+alpBYllpZkxIPiNL4YGKkgKR6g
	vf1ge4sLEnOBohCtpxiNOSaf3fKekePADyApxJKXn5cqJc67B6RUAKQ0ozQPbhEsob1iFAf6
	W5h3BUgVDzAZws17BbSKCWiV9PJLIKtKEhFSUg2MbVeuCJrvtPtX5Pxp/15H867XX+KkvHgP
	5D6R+m02q+R9YrTopPbQWKmaAJk/hspaHw+v4unp/fNOvEDoxh4WRmuWJdy3rdq+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229487>

On 07/03/2013 12:39 AM, benoit.person@ensimag.fr wrote:
> From: Benoit Person <benoit.person@ensimag.fr>
> 
> For now, bin-wrappers (based on wrap-for-bin.sh) redefine some
> environnement variables (like $GITPERLLIB). If we want to chain to
> those scripts and define one of those variables before, our changes
> will be overwritten.
> 
> This patch simply makes the bin-wrappers prepend their modifications
> rather than redefine the vars.

Your commit message makes it sound like GITPERLLIB is only one example
of a general class of environment variables fixed by the patch, but in
fact the patch address *only* GITPERLLIB.  Please make the commit
message better match the patch.

And maybe you could mention for posterity whether you have seen other
variables that will need fixing vs. you did an audit and think that
GITPERLLIB is the only problematic one vs. you haven't looked for other
similar problems at all.  This could save some time for the next person
with a similar itch and/or maybe inspire somebody to do an audit.

Thanks,
Michael

> Signed-off-by: Benoit Person <benoit.person@ensimag.fr>
> Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> ---
>  wrap-for-bin.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/wrap-for-bin.sh b/wrap-for-bin.sh
> index 53a8dd0..dbebe49 100644
> --- a/wrap-for-bin.sh
> +++ b/wrap-for-bin.sh
> @@ -14,7 +14,7 @@ else
>  	GIT_TEMPLATE_DIR='@@BUILD_DIR@@/templates/blt'
>  	export GIT_TEMPLATE_DIR
>  fi
> -GITPERLLIB='@@BUILD_DIR@@/perl/blib/lib'
> +GITPERLLIB='@@BUILD_DIR@@/perl/blib/lib:'"$GITPERLLIB"
>  GIT_TEXTDOMAINDIR='@@BUILD_DIR@@/po/build/locale'
>  PATH='@@BUILD_DIR@@/bin-wrappers:'"$PATH"
>  export GIT_EXEC_PATH GITPERLLIB PATH GIT_TEXTDOMAINDIR
> 


-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
