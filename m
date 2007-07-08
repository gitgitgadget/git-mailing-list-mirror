From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH v3] revision: allow selection of commits that do not match
 a pattern
Date: Sun, 08 Jul 2007 16:57:46 +0200
Message-ID: <20070708145746.GJ1528MdfPADPa@greensroom.kotnet.org>
References: <20070707153001.GA10408MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0707071724410.4093@racer.site>
 <20070707165208.GC1528MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0707071831300.4093@racer.site>
 <20070707184224.GE1528MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0707071957370.4093@racer.site>
 <20070708105719.GH1528MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0707081519230.4248@racer.site>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 08 16:58:07 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7YD2-0006gI-OQ
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 16:58:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753636AbXGHO5s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 10:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752965AbXGHO5s
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 10:57:48 -0400
Received: from smtp17.wxs.nl ([195.121.247.8]:42930 "EHLO smtp17.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752852AbXGHO5r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 10:57:47 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp17.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JKV00DVC88AAQ@smtp17.wxs.nl> for git@vger.kernel.org; Sun,
 08 Jul 2007 16:57:46 +0200 (CEST)
Received: (qmail 13173 invoked by uid 500); Sun, 08 Jul 2007 14:57:46 +0000
In-reply-to: <Pine.LNX.4.64.0707081519230.4248@racer.site>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51888>

On Sun, Jul 08, 2007 at 03:22:06PM +0100, Johannes Schindelin wrote:
> @@ -382,6 +391,8 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
>  	unsigned count = 0;
>  	enum grep_context ctx = GREP_CONTEXT_HEAD;
>  
> +	opt->not_at_all = 0;
> +
>  	if (buffer_is_binary(buf, size)) {
>  		switch (opt->binary) {
>  		case GREP_BINARY_DEFAULT:
> @@ -500,7 +511,7 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
>  		return 0;
>  
>  	if (opt->status_only)
> -		return 0;
> +		return !opt->not_at_all;
>  	if (opt->unmatch_name_only) {
>  		/* We did not see any hit, so we want to show this */
>  		printf("%s\n", name);

I don't understand this part.
Aren't you changing the return value from 0 to 1 here if there is no NOT_AT_ALL node?

> @@ -68,6 +70,7 @@ struct grep_opt {
>  	unsigned extended:1;
>  	unsigned relative:1;
>  	unsigned pathname:1;
> +	unsigned not_at_all:1; /* is set if the pattern was seen */
>  	int regflags;
>  	unsigned pre_context;
>  	unsigned post_context;

The name for this field is also a bit confusing.
Wouldn't "matched_some_line" or some such by more appropriate?

skimo
