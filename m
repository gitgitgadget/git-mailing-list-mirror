From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Extend "checkout --track" DWIM to support more cases
Date: Wed, 20 Aug 2008 21:52:23 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808202151320.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <20080820185028.GA16626@blimp.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 21:48:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVtfX-0006Kv-Nb
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 21:48:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753544AbYHTTrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 15:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753380AbYHTTrc
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 15:47:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:56602 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753343AbYHTTrb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 15:47:31 -0400
Received: (qmail invoked by alias); 20 Aug 2008 19:47:29 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp041) with SMTP; 20 Aug 2008 21:47:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/JfLx6pDvJOHYqiqqG6fC2K86V/zQABG914tZYmp
	BU7ZSiJAQhSjBU
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20080820185028.GA16626@blimp.local>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93020>

Hi,

On Wed, 20 Aug 2008, Alex Riesen wrote:

> The code handles additionally "refs/remotes/<something>/name",
> "remotes/<something>/name", and "refs/<namespace>/name".
> Test cases included.
> 
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---
> 
> Johannes has likable ideas :)
> 
>  builtin-checkout.c |   20 +++++++++++++++-----
>  t/t7201-co.sh      |   23 ++++++++++++++++++++++-
>  2 files changed, 37 insertions(+), 6 deletions(-)
> 
> diff --git a/builtin-checkout.c b/builtin-checkout.c
> index e95eab9..20466e2 100644
> --- a/builtin-checkout.c
> +++ b/builtin-checkout.c
> @@ -447,11 +447,21 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>  		char *slash;
>  		if (!argc || !strcmp(argv[0], "--"))
>  			die ("--track needs a branch name");
> -		slash = strchr(argv[0], '/');
> -		if (slash && !prefixcmp(argv[0], "refs/"))
> -			slash = strchr(slash + 1, '/');
> -		if (slash && !prefixcmp(argv[0], "remotes/"))
> -			slash = strchr(slash + 1, '/');

Why is this not enough?  It strips refs/ if there is one, and remotes/ if 
there is one (possibly after stripping refs/).  No?

Puzzled,
Dscho
