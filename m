From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Don't require working tree for git-rm
Date: Sat, 3 Nov 2007 11:56:17 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711031155070.4362@racer.site>
References: <1194084521-12962-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat Nov 03 12:57:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoHcv-0001VO-Bi
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 12:57:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753214AbXKCL5G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 07:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753204AbXKCL5F
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 07:57:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:56454 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753199AbXKCL5E (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 07:57:04 -0400
Received: (qmail invoked by alias); 03 Nov 2007 11:57:02 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp045) with SMTP; 03 Nov 2007 12:57:02 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX189oqMJxcM9cojoj0f7lgWEUmH9YvbtVJ2H+pUGIe
	qh6cdXrC0gg1p1
X-X-Sender: gene099@racer.site
In-Reply-To: <1194084521-12962-1-git-send-email-mh@glandium.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63242>

Hi,

On Sat, 3 Nov 2007, Mike Hommey wrote:

> This allows to do git rm --cached -r directory, instead of
> git ls-files -z directory | git update-index --remove -z --stdin.
> This can be particularly useful for git-filter-branch users.
> 
> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---
>  git.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/git.c b/git.c
> index 4e10581..01dcb6a 100644
> --- a/git.c
> +++ b/git.c
> @@ -345,7 +345,7 @@ static void handle_internal_command(int argc, const char **argv)
>  		{ "rev-list", cmd_rev_list, RUN_SETUP },
>  		{ "rev-parse", cmd_rev_parse, RUN_SETUP },
>  		{ "revert", cmd_revert, RUN_SETUP | NEED_WORK_TREE },
> -		{ "rm", cmd_rm, RUN_SETUP | NEED_WORK_TREE },
> +		{ "rm", cmd_rm, RUN_SETUP },

Just removing this is wrong!

You have to test for a working tree if "--cached" was _not_ given.  

Ciao,
Dscho
