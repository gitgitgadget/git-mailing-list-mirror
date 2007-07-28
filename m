From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Don't rely on unspecified behavior
Date: Sat, 28 Jul 2007 20:30:07 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707282028130.14781@racer.site>
References: <20070728173948.GD23337@cip.informatik.uni-erlangen.de>
 <11856471952272-git-send-email-tschwinge@gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Thomas Schwinge <tschwinge@gnu.org>
X-From: git-owner@vger.kernel.org Sat Jul 28 21:30:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IErzf-00005L-EC
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 21:30:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752266AbXG1TaY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 15:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752463AbXG1TaY
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 15:30:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:37597 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752260AbXG1TaX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 15:30:23 -0400
Received: (qmail invoked by alias); 28 Jul 2007 19:30:21 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp046) with SMTP; 28 Jul 2007 21:30:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+FwTxlUBeF/XUCK8MOWbO7N5RPVp/vZj7cpSdcGj
	lrMWBpNRAFLf6n
X-X-Sender: gene099@racer.site
In-Reply-To: <11856471952272-git-send-email-tschwinge@gnu.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54051>

Hi,

On Sat, 28 Jul 2007, Thomas Schwinge wrote:

> Calling access(p, m) with p == NULL is not specified, so don't do that.  On
> GNU/Hurd systems doing so will result in a SIGSEGV.
> 
> Signed-off-by: Thomas Schwinge <tschwinge@gnu.org>
> ---

Isn't this the same patch as you sent before?

>  builtin-add.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/builtin-add.c b/builtin-add.c
> index 7345479..de5c108 100644
> --- a/builtin-add.c
> +++ b/builtin-add.c
> @@ -60,7 +60,7 @@ static void fill_directory(struct dir_struct *dir, const char **pathspec,
>  		path = git_path("info/exclude");
>  		if (!access(path, R_OK))
>  			add_excludes_from_file(dir, path);
> -		if (!access(excludes_file, R_OK))
> +		if (excludes_file != NULL && !access(excludes_file, R_OK))

We usually omit the "!= NULL"; see the other source code in git.git.

Ciao,
Dscho
