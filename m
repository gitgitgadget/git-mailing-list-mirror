From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 4/8] Add a function to set a non-default work tree
Date: Sat, 19 Apr 2008 19:33:51 +0200
Message-ID: <200804191933.51303.johan@herland.net>
References: <alpine.LNX.1.00.0804171931550.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Apr 19 20:14:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnGy7-0007gK-4L
	for gcvg-git-2@gmane.org; Sat, 19 Apr 2008 19:35:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754788AbYDSRed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2008 13:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753820AbYDSRed
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 13:34:33 -0400
Received: from smtp.getmail.no ([84.208.20.33]:48637 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752129AbYDSRed (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2008 13:34:33 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JZL0040T25KB400@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 19 Apr 2008 19:34:32 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JZL0020V24F2A10@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 19 Apr 2008 19:33:51 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JZL003N224FL120@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 19 Apr 2008 19:33:51 +0200 (CEST)
In-reply-to: <alpine.LNX.1.00.0804171931550.19665@iabervon.org>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79908>

On Friday 18 April 2008, Daniel Barkalow wrote:
> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> ---
>  cache.h       |    1 +
>  environment.c |    6 ++++++
>  2 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/cache.h b/cache.h
> index 96dcb49..d88a4e2 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -311,6 +311,7 @@ extern char *get_index_file(void);
>  extern char *get_graft_file(void);
>  extern int set_git_dir(const char *path);
>  extern const char *get_git_work_tree(void);
> +extern void set_git_work_tree(const char *tree);
>  
>  #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
>  
> diff --git a/environment.c b/environment.c
> index 6739a3f..d6c6a6b 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -81,6 +81,12 @@ const char *get_git_dir(void)
>  	return git_dir;
>  }
>  
> +void set_git_work_tree(const char *new_work_tree)
> +{
> +	get_git_work_tree(); /* make sure it's initialized */
> +	work_tree = xstrdup(make_absolute_path(new_work_tree));

Shouldn't we free(work_tree) before resetting it?

> +}
> +
>  const char *get_git_work_tree(void)
>  {
>  	static int initialized = 0;


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
