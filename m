From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Use "git_config_string" to simplify "builtin-gc.c"
	code where "prune_expire" is set
Date: Tue, 30 Sep 2008 12:37:25 -0700
Message-ID: <20080930193725.GJ21310@spearce.org>
References: <20080930190549.GA9869@eratosthenes.cryptobackpack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: David Bryson <david@statichacks.org>
X-From: git-owner@vger.kernel.org Tue Sep 30 21:38:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkl3M-0003SP-JE
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 21:38:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753239AbYI3Th0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 15:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753211AbYI3Th0
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 15:37:26 -0400
Received: from george.spearce.org ([209.20.77.23]:51156 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752601AbYI3ThZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 15:37:25 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 31D0E3835F; Tue, 30 Sep 2008 19:37:25 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080930190549.GA9869@eratosthenes.cryptobackpack.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97149>

David Bryson <david@statichacks.org> wrote:
> Hi all,
> This is a quick janitor patch and my first patch sent to the git mailing
> list.  Please let me know if I have done any process of the patch
> submission wrong, and if I got the Janitorial task done in the proper
> fashion.

This part of the message probably should go after the "---" line.
Everything above "---" goes into the commit message, everything
after it is automatically cut by git-am.

This sort of "Hi, I'm new" isn't very useful in the long term in
the project logs, but its still useful to introduce yourself.  ;-)
 
> Signed-off-by: David Bryson <david@statichacks.org>
> ---
>  builtin-gc.c |    7 ++-----
>  1 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/builtin-gc.c b/builtin-gc.c
> index fac200e..6260652 100644
> --- a/builtin-gc.c
> +++ b/builtin-gc.c
> @@ -57,15 +57,12 @@ static int gc_config(const char *var, const char *value, void *cb)
>  		return 0;
>  	}
>  	if (!strcmp(var, "gc.pruneexpire")) {
> -		if (!value)
> -			return config_error_nonbool(var);
> -		if (strcmp(value, "now")) {
> +		if (value && strcmp(value, "now")) {
>  			unsigned long now = approxidate("now");
>  			if (approxidate(value) >= now)
>  				return error("Invalid %s: '%s'", var, value);
>  		}
> -		prune_expire = xstrdup(value);
> -		return 0;
> +		return git_config_string(&prune_expire, var, value);
>  	}
>  	return git_default_config(var, value, cb);
>  }

-- 
Shawn.
