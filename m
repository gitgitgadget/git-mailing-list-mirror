From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Warn when calling deref_tag() on broken tags
Date: Wed, 2 Nov 2005 21:47:46 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511022145010.13989@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20051102200751.26904.5780.stgit@machine.or.cz>
 <Pine.LNX.4.63.0511022115250.13746@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051102204101.GE1431@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 21:48:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXPWQ-0002vX-IQ
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 21:47:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965164AbVKBUrs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 15:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965234AbVKBUrs
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 15:47:48 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:44503 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965164AbVKBUrr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2005 15:47:47 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7390213F238; Wed,  2 Nov 2005 21:47:46 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 566239F0BA; Wed,  2 Nov 2005 21:47:46 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3F9F79EFBE; Wed,  2 Nov 2005 21:47:46 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id F0AAD13F238; Wed,  2 Nov 2005 21:47:45 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051102204101.GE1431@pasky.or.cz>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11040>

Hi,

On Wed, 2 Nov 2005, Petr Baudis wrote:

> diff --git a/tag.c b/tag.c
> index b1ab75f..9cd09cf 100644
> --- a/tag.c
> +++ b/tag.c
> @@ -3,10 +3,18 @@
>  
>  const char *tag_type = "tag";
>  
> -struct object *deref_tag(struct object *o)
> +/* The refname argument is optional and suitable to use only if
> + * we use this to resolve an actual tag ref. */
> +struct object *deref_tag(struct object *o, const char *refname)

How about leaving dereg_tag's signature alone, and warn something like 

	"You have a broken tag (sha1=%s).\n"
	"To find out which name(s) it corresponds to, execute\n"
	"\tgit-name-rev --tags %s\n"

What do you think?

Ciao,
Dscho
