From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] execv_git_cmd(): also try PATH if everything else fails.
Date: Mon, 22 Oct 2007 00:21:10 -0400
Message-ID: <20071022042110.GJ14735@spearce.org>
References: <1192867937.v2.fusewebmail-240137@f> <20071020205721.GA16291@srparish.net> <Pine.LNX.4.64.0710202258440.25221@racer.site> <20071021023614.GB14735@spearce.org> <Pine.LNX.4.64.0710212256270.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Scott Parish <sRp@srparish.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 22 06:21:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjonB-0001Uj-7n
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 06:21:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbXJVEVP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 00:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750975AbXJVEVP
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 00:21:15 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:44400 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbXJVEVO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 00:21:14 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ijomv-0002IR-3P; Mon, 22 Oct 2007 00:21:13 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B34F020FBAE; Mon, 22 Oct 2007 00:21:10 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710212256270.25221@racer.site>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61929>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Earlier, we tried to find the git commands in several possible exec
> dirs.  Now, if all of these failed, try to find the git command in
> PATH.
...
> diff --git a/exec_cmd.c b/exec_cmd.c
> index 9b74ed2..70b84b0 100644
> --- a/exec_cmd.c
> +++ b/exec_cmd.c
> @@ -36,7 +36,8 @@ int execv_git_cmd(const char **argv)
>  	int i;
>  	const char *paths[] = { current_exec_path,
>  				getenv(EXEC_PATH_ENVIRONMENT),
> -				builtin_exec_path };
> +				builtin_exec_path,
> +				"" };

So if the user sets GIT_EXEC_PATH="" and exports it we'll search
$PATH before the builtin exec path that Git was compiled with?
Are we sure we want to do that?

I'm going to throw this into pu tonight just so I don't lose it,
but I have a feeling we want to amend it before merging.

-- 
Shawn.
