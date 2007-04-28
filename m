From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/5] Introduces for_each_revision() helper
Date: Sat, 28 Apr 2007 04:46:41 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704280446180.12006@racer.site>
References: <11776932123749-git-send-email-lcapitulino@mandriva.com.br>
 <1177693212202-git-send-email-lcapitulino@mandriva.com.br>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net, git@vger.kernel.org
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
X-From: git-owner@vger.kernel.org Sat Apr 28 04:47:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hhcxn-0005pe-N8
	for gcvg-git@gmane.org; Sat, 28 Apr 2007 04:47:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754623AbXD1Cqs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 22:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754681AbXD1Cqs
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 22:46:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:34756 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754623AbXD1Cqr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 22:46:47 -0400
Received: (qmail invoked by alias); 28 Apr 2007 02:46:45 -0000
Received: from unknown (EHLO localhost) [62.225.123.37]
  by mail.gmx.net (mp050) with SMTP; 28 Apr 2007 04:46:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/4u4hSOPb4r+rpntNBBkPgRmylZy3T8je/ZmKkDt
	tHppbW2qDPgODK
X-X-Sender: gene099@racer.site
In-Reply-To: <1177693212202-git-send-email-lcapitulino@mandriva.com.br>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45766>

Hi,

On Fri, 27 Apr 2007, Luiz Fernando N. Capitulino wrote:

> diff --git a/revision.h b/revision.h
> index cdf94ad..7be3fc7 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -133,4 +133,15 @@ extern void add_object(struct object *obj,
>  extern void add_pending_object(struct rev_info *revs, struct object *obj, const char *name);
>  extern void add_pending_object_with_mode(struct rev_info *revs, struct object *obj, const char *name, unsigned mode);
>  
> +/* helpers */
> +
> +/**
> + * for_each_revision	- iterate over revisions
> + * @commit:	pointer to a commit object returned for each iteration
> + * @rev:	revision pointer
> + */
> +#define for_each_revision(commit, rev) \
> +	for (prepare_revision_walk(rev); \
> +		  (commit = get_revision(rev)) != NULL; )
> +
>  #endif

I object to this, additionally to the magic argument that I agree to, on 
the grounds that it is actually wrong. The first iteration will work on an 
_uninitialized_ "commit" variable.

Furthermore, it is not like it was a huge piece of code that is being 
replaced by a shortcut. There are better places to do some libification 
than this.

Ciao,
Dscho
