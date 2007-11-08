From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH 2/2] git status: show relative paths when run in a subdirectory
Date: Thu, 08 Nov 2007 00:26:16 -0800
Message-ID: <7v8x593zyv.fsf@gitster.siamese.dyndns.org>
References: <9e4733910711071415i1729e277u6be19b72cd682a85@mail.gmail.com>
	<Pine.LNX.4.64.0711072242230.4362@racer.site>
	<9e4733910711071445p7cfb6cffx83adb1d84d6bf9d8@mail.gmail.com>
	<Pine.LNX.4.64.0711072255420.4362@racer.site>
	<9e4733910711071503va92a653s25fd978989d5917d@mail.gmail.com>
	<243E1E6E-4723-42D3-933C-D2A0D1ACE287@silverinsanity.com>
	<ee77f5c20711071531q5acc4d06u264f5daad7c04cc4@mail.gmail.com>
	<Pine.LNX.4.64.0711080011170.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Symonds <dsymonds@gmail.com>,
	Brian Gernhardt <benji@silverinsanity.com>,
	Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 08 09:26:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq2io-000208-Op
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 09:26:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753539AbXKHI00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 03:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752540AbXKHI00
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 03:26:26 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:39878 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbXKHI0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 03:26:25 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id E0AB22EF;
	Thu,  8 Nov 2007 03:26:46 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 4553592643;
	Thu,  8 Nov 2007 03:26:40 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711080011170.4362@racer.site> (Johannes
	Schindelin's message of "Thu, 8 Nov 2007 00:12:22 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63963>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> -static const char *quote_crlf(const char *in, char *buf, size_t sz)
> +static const char *quote_crlf(const char *in, int len, char *buf, size_t sz,
> +	const char *prefix)
>  {

This is not quote_*crlf* anymore.

> @@ -118,8 +150,8 @@ static void wt_status_print_filepair(struct wt_status *s,
>  	const char *one, *two;
>  	char onebuf[PATH_MAX], twobuf[PATH_MAX];
>  
> -	one = quote_crlf(p->one->path, onebuf, sizeof(onebuf));
> -	two = quote_crlf(p->two->path, twobuf, sizeof(twobuf));
> +	one = quote_crlf(p->one->path, -1, onebuf, sizeof(onebuf), s->prefix);
> +	two = quote_crlf(p->two->path, -1, twobuf, sizeof(twobuf), s->prefix);

I wonder if it makes more sense to use strbuf here...
