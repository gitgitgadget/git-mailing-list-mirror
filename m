From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Keep "git --git-dir" from causing a bus error.
Date: Fri, 22 Dec 2006 17:08:53 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612221708070.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061222135625.GA26084@179.242.249.10.in-addr.arpa>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 17:09:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxmxB-0004Hz-Vp
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 17:09:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422893AbWLVQI4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 11:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965204AbWLVQI4
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 11:08:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:33805 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965200AbWLVQI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 11:08:56 -0500
Received: (qmail invoked by alias); 22 Dec 2006 16:08:54 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp020) with SMTP; 22 Dec 2006 17:08:54 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Brian Gernhardt <benji@silverinsanity.com>
In-Reply-To: <20061222135625.GA26084@179.242.249.10.in-addr.arpa>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35183>

Hi,

On Fri, 22 Dec 2006, Brian Gernhardt wrote:

> diff --git a/git.c b/git.c
> index 73cf4d4..2b3c9f9 100644
> --- a/git.c
> +++ b/git.c
> @@ -59,11 +59,14 @@ static int handle_options(const char*** argv, int* argc)
>  		} else if (!strcmp(cmd, "-p") || !strcmp(cmd, "--paginate")) {
>  			setup_pager();
>  		} else if (!strcmp(cmd, "--git-dir")) {
> -			if (*argc < 1)
> -				return -1;
> -			setenv("GIT_DIR", (*argv)[1], 1);
> -			(*argv)++;
> -			(*argc)--;
> +			if (*argc < 2) {
> +				fprintf(stderr, "No directory given for --git-dir.\n" );
> +				usage(git_usage_string);

Usage already exits, so you do not need this:

> +			} else {

Ciao,
Dscho
