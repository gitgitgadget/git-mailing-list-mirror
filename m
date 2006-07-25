From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC/PATCH] git wrapper: add --git-path=<path> and --bare options
Date: Tue, 25 Jul 2006 10:43:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607251042120.29649@g5.osdl.org>
References: <Pine.LNX.4.63.0607251926190.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Jul 25 19:44:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5Qwx-0005gQ-Nk
	for gcvg-git@gmane.org; Tue, 25 Jul 2006 19:44:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWGYRoE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Jul 2006 13:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWGYRoD
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Jul 2006 13:44:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55171 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750805AbWGYRoC (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Jul 2006 13:44:02 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6PHhsnW007559
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 25 Jul 2006 10:43:55 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6PHhrGO003104;
	Tue, 25 Jul 2006 10:43:54 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607251926190.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-1.032 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.141 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24180>



On Tue, 25 Jul 2006, Johannes Schindelin wrote:
>  
>  SYNOPSIS
>  --------
> -'git' [--version] [--exec-path[=GIT_EXEC_PATH]] [--help] COMMAND [ARGS]
> +'git' [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate]
> +	[--bare] [--git-dir=GIT_DIR] [--help] COMMAND [ARGS]

Here you have "--git-dir"

> @@ -41,6 +42,15 @@ OPTIONS
>  	environment variable. If no path is given 'git' will print
>  	the current setting and then exit.
>  
> +-p|--paginate::
> +	Pipe all output into 'less' (or if set, $PAGER).
> +
> +--git-path=<path>::
> +	Set the path to the repository. This can also be controlled by
> +	setting the GIT_DIR environment variable.

But here you have "--git-path".

> +		} else if (!strcmp(cmd, "--git-dir") && *argc > 1) {
> +			setenv("GIT_DIR", (*argv)[1], 1);
> +			(*argv)++;
> +			(*argc)--;
> +		} else if (!strncmp(cmd, "--git-dir=", 10)) {
> +			setenv("GIT_DIR", cmd + 10, 1);

And here you have "--git-dir" again.

Since "--git-dir" makes more sense than "--git-path", I'd suggest just 
fixing the OPTIONS section ;)

		Linus
