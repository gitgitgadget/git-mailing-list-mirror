From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] Makefile: avoid a fork in Cygwin version check
Date: Mon, 05 Apr 2010 17:36:48 +0200
Message-ID: <m2eiitc3n3.fsf@igel.home>
References: <1270161834-9597-1-git-send-email-eblake@redhat.com>
	<7vaatmmju9.fsf@alter.siamese.dyndns.org>
	<4BB5F94F.3090403@redhat.com> <20100403074700.GA24176@progeny.tock>
	<4BB9E24E.4090206@redhat.com> <20100405143053.GA13093@progeny.tock>
	<4BB9F756.7030701@redhat.com> <20100405151059.GB13761@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Blake <eblake@redhat.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, jon.seymour@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 17:36:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyoMD-0005xs-Mm
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 17:36:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755388Ab0DEPgx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 11:36:53 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:50819 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755370Ab0DEPgv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 11:36:51 -0400
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 91AF21C0024A;
	Mon,  5 Apr 2010 17:36:49 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 82D3490393;
	Mon,  5 Apr 2010 17:36:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan1.mnet-online.de [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id PsVYSpKK2GFH; Mon,  5 Apr 2010 17:36:48 +0200 (CEST)
Received: from igel.home (ppp-88-217-101-104.dynamic.mnet-online.de [88.217.101.104])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Mon,  5 Apr 2010 17:36:48 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 45DDBCA297; Mon,  5 Apr 2010 17:36:48 +0200 (CEST)
X-Yow: ...Get me a GIN and TONIC!!...make it HAIR TONIC!!
In-Reply-To: <20100405151059.GB13761@progeny.tock> (Jonathan Nieder's message
	of "Mon, 5 Apr 2010 10:11:00 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.95 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143992>

Jonathan Nieder <jrnieder@gmail.com> writes:

> diff --git a/Makefile b/Makefile
> index e210a42..767fb66 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -831,7 +831,7 @@ ifeq ($(uname_S),SunOS)
>  	BASIC_CFLAGS += -D__EXTENSIONS__ -D__sun__ -DHAVE_ALLOCA_H
>  endif
>  ifeq ($(uname_O),Cygwin)
> -	ifeq ($(shell expr "$(uname_R)" : '1\.[1-6]\.'),4)
> +	ifeq ($(shell case '$(uname_R)' in (1.[1-6].*) echo old;; esac),old)

Even less forks:

        ifneq ($(filter 1.1.% 1.2.% 1.3.% 1.4.% 1.5.% 1.6.%,$(uname_R)),)

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
