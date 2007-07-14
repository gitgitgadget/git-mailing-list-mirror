From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/6] Define ishex(x) in git-compat-util.h
Date: Sat, 14 Jul 2007 11:18:15 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707141115270.14781@racer.site>
References: <11842671631744-git-send-email-skimo@liacs.nl>
 <11842671632000-git-send-email-skimo@liacs.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sat Jul 14 12:18:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9ehq-0003c1-0l
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 12:18:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756088AbXGNKS1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 06:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755770AbXGNKS1
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 06:18:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:44323 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755830AbXGNKS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 06:18:26 -0400
Received: (qmail invoked by alias); 14 Jul 2007 10:18:24 -0000
Received: from R063a.r.pppool.de (EHLO noname) [89.54.6.58]
  by mail.gmx.net (mp043) with SMTP; 14 Jul 2007 12:18:24 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Hbylkj5vHN3phYa/tqUPx6TAePq85DlcvVIQ5R7
	DuaK08NnkzOMgT
X-X-Sender: gene099@racer.site
In-Reply-To: <11842671632000-git-send-email-skimo@liacs.nl>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52466>

Hi,

On Thu, 12 Jul 2007, skimo@liacs.nl wrote:

> diff --git a/git-compat-util.h b/git-compat-util.h
> index 362e040..1a36f4c 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -325,12 +325,15 @@ static inline int has_extension(const char *filename, const char *ext)
>  extern unsigned char sane_ctype[256];
>  #define GIT_SPACE 0x01
>  #define GIT_DIGIT 0x02
> -#define GIT_ALPHA 0x04
> +#define GIT_HEXAL 0x04
> +#define GIT_OTHAL 0x08
> +#define GIT_ALPHA (GIT_HEXAL | GIT_OTHAL)

I'd have left GIT_ALPHA, and added GIT_HEXDIGIT.

>  #define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask)) != 0)
>  #define isspace(x) sane_istest(x,GIT_SPACE)
>  #define isdigit(x) sane_istest(x,GIT_DIGIT)
>  #define isalpha(x) sane_istest(x,GIT_ALPHA)
>  #define isalnum(x) sane_istest(x,GIT_ALPHA | GIT_DIGIT)
> +#define ishex(x) sane_istest(x,GIT_HEXAL | GIT_DIGIT)

I know, I originally proposed this.  In the mean time, however, I found 
that this gem should be even better (in terms of diff size):

#define ishex(x) (hexval(x) >= 0)

Ciao,
Dscho
