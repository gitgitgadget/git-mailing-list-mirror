From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [ANNOUNCE] GIT 1.5.4-rc3
Date: Sat, 12 Jan 2008 17:57:49 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0801121756400.8333@wbgn129.biozentrum.uni-wuerzburg.de>
References: <7vsl13wmas.fsf@gitster.siamese.dyndns.org> <200801120926.14307.ismail@pardus.org.tr> <7vejcnwl85.fsf@gitster.siamese.dyndns.org> <200801120947.48602.ismail@pardus.org.tr> <20080112090432.GA6134@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?Ismail_D=F6nmez?= <ismail@pardus.org.tr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 12 17:58:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDjgf-0006UL-60
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 17:58:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754167AbYALQ5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 11:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754131AbYALQ5x
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 11:57:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:60006 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754040AbYALQ5x (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 11:57:53 -0500
Received: (qmail invoked by alias); 12 Jan 2008 16:57:51 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp030) with SMTP; 12 Jan 2008 17:57:51 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18OVyso+vUOP1DFg7djKnHN9WnyD9mcrX2SFghnVu
	+4lTlbj3gTJMvl
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <20080112090432.GA6134@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70332>

Hi,

On Sat, 12 Jan 2008, Jeff King wrote:

> diff --git a/builtin-clean.c b/builtin-clean.c
> index 6cad8ea..eb853a3 100644
> --- a/builtin-clean.c
> +++ b/builtin-clean.c
> @@ -90,7 +90,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>  	strbuf_init(&directory, 0);
>  
>  	if (pathspec)
> -		seen = xmalloc(argc);
> +		seen = xmalloc(argc > 0 ? argc : 1);
>  
>  	for (i = 0; i < dir.nr; i++) {
>  		struct dir_entry *ent = dir.entries[i];
> @@ -125,7 +125,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>  			continue;
>  
>  		if (pathspec) {
> -			memset(seen, 0, argc);
> +			memset(seen, 0, argc > 0 ? argc : 1);
>  			matches = match_pathspec(pathspec, ent->name, ent->len,
>  						 baselen, seen);
>  		} else {

Would it not be better to guard the memset by an "if (argc)", and set 
"seen" to NULL by default?

Ciao,
Dscho
