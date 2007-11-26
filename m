From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Use is_absolute_path() in diff-lib.c, lockfile.c, setup.c,
 trace.c
Date: Mon, 26 Nov 2007 08:45:21 +0100
Message-ID: <474A7991.5010202@viscovery.net>
References: <11960297431954-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Nov 26 08:45:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwYf6-0001BV-LA
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 08:45:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181AbXKZHpb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 02:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753028AbXKZHpa
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 02:45:30 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:50150 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753997AbXKZHp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 02:45:29 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IwYe1-0001EV-Ab; Mon, 26 Nov 2007 08:44:46 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 1D7486B7; Mon, 26 Nov 2007 08:45:22 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <11960297431954-git-send-email-prohaska@zib.de>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66050>

Steffen Prohaska schrieb:
> Using the helper function to test for absolute paths makes porting easier.

The patch looks good.

> --- a/setup.c
> +++ b/setup.c
> @@ -59,7 +59,7 @@ const char *prefix_path(const char *prefix, int len, const char *path)
>  const char *prefix_filename(const char *pfx, int pfx_len, const char *arg)
>  {
>  	static char path[PATH_MAX];
> -	if (!pfx || !*pfx || arg[0] == '/')
> +	if (!pfx || !*pfx || is_absolute_path(arg))
>  		return arg;
>  	memcpy(path, pfx, pfx_len);
>  	strcpy(path + pfx_len, arg);

This instance, however, will be reworked for Windows anyway because we must 
do '\\' to '/' conversion even if the path is absolute (and, hence, we 
cannot just return the input).

But disregarding this note, the change makes the code more readable, IMO, so 
I'm all for it.

-- Hannes
