From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] git-shell and git-cvsserver
Date: Fri, 5 Oct 2007 17:07:17 +0200
Message-ID: <20071005150717.GN31659@planck.djpig.de>
References: <200710051453.47622.wielemak@science.uva.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jan Wielemaker <wielemak@science.uva.nl>
X-From: git-owner@vger.kernel.org Fri Oct 05 17:08:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdomE-000433-LC
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 17:07:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756983AbXJEPHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 11:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756929AbXJEPHd
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 11:07:33 -0400
Received: from planck.djpig.de ([85.10.192.180]:2258 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756537AbXJEPHd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 11:07:33 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 4ED4588231;
	Fri,  5 Oct 2007 17:07:31 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AFfTnhVt31G5; Fri,  5 Oct 2007 17:07:19 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id D97EB88232; Fri,  5 Oct 2007 17:07:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200710051453.47622.wielemak@science.uva.nl>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60090>

On Fri, Oct 05, 2007 at 02:53:47PM +0200, Jan Wielemaker wrote:
> +#define EXEC_PATH "/usr/local/bin"
> +
> +static int do_cvs_cmd(const char *me, char *arg)
> +{
> +	const char *my_argv[4];
> +	const char *oldpath;
> +
> +	if ( !arg )
> +		die("no argument");
> +	if ( strcmp(arg, "server") )
> +		die("only allows git-cvsserver server: %s", arg);
> +
> +	my_argv[0] = "cvsserver";
> +	my_argv[1] = "server";
> +	my_argv[2] = NULL;
> +
> +	if ( (oldpath=getenv("PATH")) ) {
> +		char *newpath = malloc(strlen(oldpath)+strlen(EXEC_PATH)+5+1+1);
> +		
> +		sprintf(newpath, "PATH=%s:%s", EXEC_PATH, oldpath);
> +		putenv(newpath);
> +	} else {
> +		char *newpath = malloc(strlen(EXEC_PATH)+5+1);
> +		
> +		sprintf(newpath, "PATH=%s", EXEC_PATH);
> +		putenv(newpath);
> +	}
> +
> +	return execv_git_cmd(my_argv);
> +}

This seems to be mostly a duplication of prepend_to_path from git.c

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
