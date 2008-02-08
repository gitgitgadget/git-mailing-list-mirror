From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: read_branches_file ()
Date: Fri, 8 Feb 2008 16:22:45 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802081618210.11591@racer.site>
References: <20080208165008.52630d36@pc09.procura.nl> <20080208170305.069d43d2@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Fri Feb 08 17:23:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNW0W-0003n3-6p
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 17:23:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754485AbYBHQWj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 11:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754473AbYBHQWj
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 11:22:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:46341 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754084AbYBHQWi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 11:22:38 -0500
Received: (qmail invoked by alias); 08 Feb 2008 16:22:36 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp008) with SMTP; 08 Feb 2008 17:22:36 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/pK3s8G73pY5HM6Wwd7CAgEbVouCC3KQUvDogwDj
	XmtIR5t7T4fuQr
X-X-Sender: gene099@racer.site
In-Reply-To: <20080208170305.069d43d2@pc09.procura.nl>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73103>

Hi,

On Fri, 8 Feb 2008, H.Merijn Brand wrote:

> --8<--- remote.c.diff
> --- remote.c.org        2008-01-27 09:04:18 +0100
> +++ remote.c    2008-02-08 17:01:09 +0100
> @@ -1,6 +1,7 @@
>  #include "cache.h"
>  #include "remote.h"
>  #include "refs.h"
> +#include <sys/stat.h>

This should not be necessary; we include all system headers in cache.h.

> @@ -173,11 +174,15 @@ static void read_branches_file(struct re
>         char *frag;
>         char *branch;
>         int n = slash ? slash - remote->name : 1000;
> -       FILE *f = fopen(git_path("branches/%.*s", n, remote->name), "r");
> +       char *gp = git_path ("branches/%.*s", n, remote->name);

Please use a more descriptive variable name, such as "branches_file" or 
"branches_path".

Also, we only leave a space after operators like "for", "while", but not 
after function names.

> +       if (stat (gp, &st_buf) || S_ISDIR (st_buf.st_mode))

Again, please remove the spaces after "stat" and "S_ISDIR".

Other than that, the patch looks obviously correct: please resubmit with a 
nice commit message and a sign-off.

Thanks,
Dscho
