From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 27/40] Windows: Implement a custom spawnve().
Date: Thu, 28 Feb 2008 15:36:15 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802281535210.22527@racer.site>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-28-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Thu Feb 28 16:37:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUkp4-0003oE-Me
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 16:37:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757770AbYB1Pgs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 10:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757706AbYB1Pgs
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 10:36:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:57308 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757004AbYB1Pgr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 10:36:47 -0500
Received: (qmail invoked by alias); 28 Feb 2008 15:36:45 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp013) with SMTP; 28 Feb 2008 16:36:45 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19nNgMaEFZn8nvL/zOGiEwxqpmGOIQ9FEwm2pquqg
	0kGfZ4E+Fw2cRu
X-X-Sender: gene099@racer.site
In-Reply-To: <1204138503-6126-28-git-send-email-johannes.sixt@telecom.at>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75411>

Hi,

On Wed, 27 Feb 2008, Johannes Sixt wrote:

> diff --git a/git-compat-util.h b/git-compat-util.h
> index 0324789..570eb10 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -611,6 +611,7 @@ int mingw_rename(const char*, const char*);
>  int mingw_vsnprintf(char *buf, size_t size, const char *fmt, va_list args);
>  #define vsnprintf mingw_vsnprintf
>  
> +pid_t mingw_spawnvpe(const char *cmd, const char **argv, char **env);
>  void mingw_execvp(const char *cmd, char *const *argv);
>  #define execvp mingw_execvp
>  
> diff --git a/run-command.c b/run-command.c
> index 3834f86..5ed338c 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -156,7 +156,7 @@ int start_command(struct child_process *cmd)
>  		cmd->argv[0] = git_cmd.buf;
>  	}
>  
> -	cmd->pid = spawnvpe(_P_NOWAIT, cmd->argv[0], cmd->argv, (const char **)env);
> +	cmd->pid = mingw_spawnvpe(cmd->argv[0], cmd->argv, env);

Should this not be "#define spawnvpe mingw_spanvpe" in git-compat-util.h 
instead?

Ciao,
Dscho

