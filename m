From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] builtin-prune.c: fix object parsing and use
 parse_options()
Date: Sun, 23 Mar 2008 23:21:49 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803232319130.4353@racer.site>
References: <200803232150.29971.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Sun Mar 23 23:22:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdYaH-00086j-6G
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 23:22:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755096AbYCWWVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 18:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755098AbYCWWVu
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 18:21:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:45415 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754934AbYCWWVt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 18:21:49 -0400
Received: (qmail invoked by alias); 23 Mar 2008 22:21:47 -0000
Received: from host86-148-26-43.range86-148.btcentralplus.com (EHLO racer.home) [86.148.26.43]
  by mail.gmx.net (mp018) with SMTP; 23 Mar 2008 23:21:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19mNakjVjBm+Y+lG1QlvJUtGj3qvrjbQk86HSUd6T
	l3nkyeQdd/5AiJ
X-X-Sender: gene099@racer.site
In-Reply-To: <200803232150.29971.barra_cuda@katamail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77966>

Hi,

On Sun, 23 Mar 2008, Michele Ballabio wrote:

> -static const char prune_usage[] = "git-prune [-n]";
> +static const char * const prune_usage[] = {
> +	"git-prune [-n] [--expire <time>] [--] [<head>...]",
> +	NULL
> +};

As you already use parse-options, should this not be rather

static const char * const prune_usage[] = {
	"git-prune [options] [--] [<commit>...]",

Hmm?

> +static int parse_opt_expire(const struct option *opt, const char *arg,
> +		int unset)
> +{
> +	expire = approxidate(arg);
> +	return 0;
> +}

This would probably be a good candidate to live in parse-options.[ch], no?

But yes, the patch is good!

Ciao,
Dscho
