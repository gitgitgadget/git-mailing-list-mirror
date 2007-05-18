From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 09/16] entry.c: optionally checkout submodules
Date: Sat, 19 May 2007 00:00:14 +0200
Message-ID: <20070518220014.GD10475@steel.home>
References: <11795163053812-git-send-email-skimo@liacs.nl> <1179516307425-git-send-email-skimo@liacs.nl>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sat May 19 00:00:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpAUp-0007bo-Od
	for gcvg-git@gmane.org; Sat, 19 May 2007 00:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754528AbXERWAS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 18:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754560AbXERWAS
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 18:00:18 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:53493 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754528AbXERWAR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 18:00:17 -0400
Received: from tigra.home (Fc8ca.f.strato-dslnet.de [195.4.200.202])
	by post.webmailer.de (mrclete mo48) (RZmta 6.5)
	with ESMTP id I0435bj4IKM5I3 ; Sat, 19 May 2007 00:00:14 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id C5062277BD;
	Sat, 19 May 2007 00:00:14 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 95874D195; Sat, 19 May 2007 00:00:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1179516307425-git-send-email-skimo@liacs.nl>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWow0t1E=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47663>

skimo@liacs.nl, Fri, May 18, 2007 21:24:58 +0200:
> +	if (!getcwd(cwd, sizeof(cwd)) || cwd[0] != '/')
> +		die("Unable to read current working directory");
> +
> +	if (chdir(path))
> +		die("Cannot move to '%s'", path);
> +

How about modifying run_command to chdir after fork?

You'd save the hassle of save/restoring cwd and don't mess up process'
context (which is always a good idea to preserve). The code'd be
simplier, too.
