From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: minor problems in git.c
Date: Thu, 01 Dec 2005 14:51:13 +0100
Message-ID: <20051201135113.GW8383MdfPADPa@greensroom.kotnet.org>
References: <72499e3b0512010400i1de76ed2la22cd745f811007f@mail.gmail.com>
 <81b0412b0512010448u7fcdddacnd7de5df217ab3ca@mail.gmail.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Robert Watson <robert.oo.watson@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Dec 01 14:54:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhoqL-0002d9-Nt
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 14:51:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbVLANvS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 08:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbVLANvS
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 08:51:18 -0500
Received: from smtp18.wxs.nl ([195.121.247.9]:60838 "EHLO smtp18.wxs.nl")
	by vger.kernel.org with ESMTP id S932236AbVLANvR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Dec 2005 08:51:17 -0500
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp18.wxs.nl (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with SMTP id <0IQT000S5NTE9P@smtp18.wxs.nl> for git@vger.kernel.org; Thu,
 01 Dec 2005 14:51:14 +0100 (CET)
Received: (qmail 3106 invoked by uid 500); Thu, 01 Dec 2005 13:51:14 +0000
In-reply-to: <81b0412b0512010448u7fcdddacnd7de5df217ab3ca@mail.gmail.com>
To: Alex Riesen <raa.lkml@gmail.com>
Mail-followup-to: Alex Riesen <raa.lkml@gmail.com>,
 Robert Watson <robert.oo.watson@gmail.com>, git@vger.kernel.org,
 Junio C Hamano <junkio@cox.net>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13058>

On Thu, Dec 01, 2005 at 01:48:35PM +0100, Alex Riesen wrote:
> @@ -283,16 +283,15 @@ int main(int argc, char **argv, char **e
>  	len = strlen(git_command);
>  	prepend_to_path(git_command, len);
>  
> -	strncat(&git_command[len], "/git-", sizeof(git_command) - len);
> -	len += 5;
> -	strncat(&git_command[len], argv[i], sizeof(git_command) - len);
> +	snprintf(git_command + len, sizeof(git_command) - len, "/git-%s",
> +		 argv[i]);

Shouldn't you check the return value of snprintf

>  	if (access(git_command, X_OK))
>  		usage(exec_path, "'%s' is not a git-command", argv[i]);

or use the (possibly) truncated version of the command in the error message ?

skimo
