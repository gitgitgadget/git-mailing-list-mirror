From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rev-parse: fix potential bus error with --parseopt option
 spec handling
Date: Tue, 26 Feb 2008 11:26:41 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802261126130.17164@racer.site>
References: <1203998859-86344-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 12:28:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTxyR-0000Xu-Tl
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 12:27:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760116AbYBZL1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 06:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758133AbYBZL1K
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 06:27:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:44568 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752736AbYBZL1J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 06:27:09 -0500
Received: (qmail invoked by alias); 26 Feb 2008 11:27:08 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp042) with SMTP; 26 Feb 2008 12:27:08 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+4+VJi2/24LRXCf8GWWvQ2VXvfm03UPUhHQbxpq4
	qeJAbKEmaxSxNv
X-X-Sender: gene099@racer.site
In-Reply-To: <1203998859-86344-1-git-send-email-jaysoffian@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75122>

Hi,

On Mon, 25 Feb 2008, Jay Soffian wrote:

> diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
> index b9af1a5..90dbb9d 100644
> --- a/builtin-rev-parse.c
> +++ b/builtin-rev-parse.c
> @@ -315,7 +315,7 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
>  		s = strchr(sb.buf, ' ');
>  		if (!s || *sb.buf == ' ') {
>  			o->type = OPTION_GROUP;
> -			o->help = xstrdup(skipspaces(s));
> +			o->help = xstrdup(skipspaces(sb.buf));

Looks obviously correct, but I would have expected a SIGSEGV, not a 
SIGBUS.

Ciao,
Dscho
