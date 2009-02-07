From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] don't append 'opaquelocktoken:' in PUT and MOVE
Date: Sat, 7 Feb 2009 18:03:19 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902071801570.10279@pacific.mpi-cbg.de>
References: <498DA4F9.20104@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 07 18:04:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVqbC-0000Ot-Df
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 18:04:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754752AbZBGRCm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 12:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754711AbZBGRCl
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 12:02:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:35616 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754581AbZBGRCk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 12:02:40 -0500
Received: (qmail invoked by alias); 07 Feb 2009 17:02:38 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp030) with SMTP; 07 Feb 2009 18:02:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX185P3cg5cA520XDYGOn2XfWAF4kIvLKMt20eKQV6+
	xYENM/diDEy8I9
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <498DA4F9.20104@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108867>

Hi,

On Sat, 7 Feb 2009, Tay Ray Chuan wrote:

> diff --git a/http-push.c b/http-push.c
> index eefd64c..10df94a 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -558,7 +558,7 @@ static void start_put(struct transfer_request *request)
> 
>  	append_remote_object_url(&buf, remote->url, hex, 0);
>  	strbuf_addstr(&buf, "_");
> -	strbuf_addstr(&buf, request->lock->token);
> +	strbuf_addstr(&buf, request->lock->token + 16);

Umm.  This "16" is a little bit too hardcoded for my liking.  I mean, it 
is not even obvious from _this_ hunk why "16" should be correct.

Besides, I have to wonder where request->lock->token is set, and if that 
would not be the better place to fix the issue?

Ciao,
Dscho
