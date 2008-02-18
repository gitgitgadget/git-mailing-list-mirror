From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] branch: optionally setup branch.*.merge from upstream
 local branches
Date: Mon, 18 Feb 2008 13:29:55 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802181328380.30505@racer.site>
References: alpine.LSU.1.00.0802181209210.30505@racer.site <1203341084-18543-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 14:31:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR65G-0006TM-Rp
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 14:31:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760620AbYBRNaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 08:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754006AbYBRNaM
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 08:30:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:49523 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760578AbYBRNaI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 08:30:08 -0500
Received: (qmail invoked by alias); 18 Feb 2008 13:30:06 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp006) with SMTP; 18 Feb 2008 14:30:06 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1885/kDVZo8Mztbta+2nJliCa1bi9/Bphb8XS8ATl
	yg5VGOwAfI0eoW
X-X-Sender: gene099@racer.site
In-Reply-To: <1203341084-18543-1-git-send-email-jaysoffian@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74284>

Hi,

sorry, I overlooked that earlier:

On Mon, 18 Feb 2008, Jay Soffian wrote:

> diff --git a/branch.c b/branch.c
> index 1fc8788..24e98dd 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -130,7 +130,15 @@ void create_branch(const char *head,
>  	   automatically merges from there.  So far, this is only done for
>  	   remotes registered via .git/config.  */
>  	if (real_ref && track)
> -		setup_tracking(name, real_ref);
> +		if (setup_tracking(name, real_ref) == 1 && track == BRANCH_TRACK_ALWAYS) {

This line is too long.

> +			char key[1024];
> +			sprintf(key, "branch.%s.remote", name);

To stay safe, you should use snprintf() and test the return value.

> +			git_config_set(key, ".");
> +			sprintf(key, "branch.%s.merge", name);

Same here.

Thanks,
Dscho
