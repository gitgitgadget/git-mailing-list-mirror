From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] On error, do not list all commands, but point to --help option
Date: Sat, 20 Oct 2007 23:33:18 -0400
Message-ID: <20071021033318.GD14735@spearce.org>
References: <bqaujirk.fsf@blue.sea.net> <ir51if2y.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Sun Oct 21 05:33:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjRZF-0001oW-4q
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 05:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbXJUDdW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 23:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbXJUDdW
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 23:33:22 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58507 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbXJUDdV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 23:33:21 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IjRYp-0007oC-P3; Sat, 20 Oct 2007 23:33:07 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9F75F20FBAE; Sat, 20 Oct 2007 23:33:18 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <ir51if2y.fsf@blue.sea.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61875>

Jari Aalto <jari.aalto@cante.net> wrote:
> - Remove out call to list_common_cmds_help()

Even if the list is against this change (which I'm in favor of)... 

> - Send error message to stderr, not stdout.

I really think this really should be done.  CVS and SVN both print
to stderr in this case, as does any other program I can think of
that takes subcommands.  Its just the right thing to do.

> @@ -185,8 +185,7 @@ static void show_man_page(const char *git_cmd)
>  
>  void help_unknown_cmd(const char *cmd)
>  {
> -	printf("git: '%s' is not a git-command\n\n", cmd);
> -	list_common_cmds_help();
> +	fprintf(stderr, "git: '%s' is not a git-command. See --help\n\n", cmd);

Why are you still printing two LFs here?  We have no additional
text to display after this error message, we probably only need
the one LF.

-- 
Shawn.
