From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] optionally disable overwriting of ignored files
Date: Thu, 19 Aug 2010 03:41:08 -0700 (PDT)
Message-ID: <m3aaoiq41v.fsf@localhost.localdomain>
References: <4C6A1C5B.4030304@workspacewhiz.com>
	<7viq39avay.fsf@alter.siamese.dyndns.org>
	<20100818233900.GA27531@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Thu Aug 19 12:41:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Om2Yg-0004JI-2m
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 12:41:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532Ab0HSKlN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Aug 2010 06:41:13 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47472 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752453Ab0HSKlL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Aug 2010 06:41:11 -0400
Received: by wwi17 with SMTP id 17so2273151wwi.1
        for <git@vger.kernel.org>; Thu, 19 Aug 2010 03:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=F2f8014Y1pxydQPA8iaxSYe8+/5AVImTUyoImI+IAyQ=;
        b=bfY22MriMqZgSUz7Lgn3oSbtIFVwS6WN43GAM2/lHbtvwbf7S+AeJPbHZ0nHs78WtR
         YHduTiPQiaDIFUlXtyNmzjwJyWAuA6F3jimTJUYD+5VAjnOguFULRCT2t90lOi4tDA/r
         8jyOVgrGQvYrLYfY2M7aDIiBO+LB+lu/KwN/I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=RlVrQB3Yjzz2DssVJNgHI9ErA9FYFuf2WJmvQnsZP1dGEDUnzVaUv7cycazBCANdoy
         LPhWaQl4SWi0PW1wHaD6H+Pjlpl4oDSvw8AD9Aia6NLiuV6yqP566QhAoUBLlR8Yt30r
         M9Z4hdjbCcvoTKnUmKM84ukWnJWUdCNoMFamc=
Received: by 10.216.187.143 with SMTP id y15mr8107217wem.74.1282214469893;
        Thu, 19 Aug 2010 03:41:09 -0700 (PDT)
Received: from localhost.localdomain (abvy166.neoplus.adsl.tpnet.pl [83.8.222.166])
        by mx.google.com with ESMTPS id h37sm896384wej.23.2010.08.19.03.41.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Aug 2010 03:41:08 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o7JAeNiq031350;
	Thu, 19 Aug 2010 12:40:34 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o7JAduo6031333;
	Thu, 19 Aug 2010 12:39:56 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20100818233900.GA27531@localhost>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153914>

Clemens Buchacher <drizzd@aon.at> writes:

>  Documentation/config.txt |    6 ++++++
>  builtin/checkout.c       |    7 +++++++
>  builtin/merge.c          |    9 +++++++++
>  cache.h                  |    1 +
>  config.c                 |    3 +++
>  environment.c            |    1 +
>  6 files changed, 27 insertions(+), 0 deletions(-)

You forgot to update Documentation/git-checkout.txt and
Documentation/git-merge.txt with the new '-i' option.

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 5affb6f..121a6a3 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c

> @@ -664,6 +669,8 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>  		OPT_SET_INT('3', "theirs", &opts.writeout_stage, "stage",
>  			    3),
>  		OPT_BOOLEAN('f', "force", &opts.force, "force"),
> +		OPT_BOOLEAN('i', "overwrite-ignored", &overwrite_ignored,
> +		  "allow explicitly ignored files to be overwritten"),
>  		OPT_BOOLEAN('m', "merge", &opts.merge, "merge"),
>  		OPT_STRING(0, "conflict", &conflict_style, "style",
>  			   "conflict style (merge or diff3)"),
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 4d31e09..47b12ba 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -185,6 +185,8 @@ static struct option builtin_merge_options[] = {
>  		"allow fast-forward (default)"),
>  	OPT_BOOLEAN(0, "ff-only", &fast_forward_only,
>  		"abort if fast-forward is not possible"),
> +	OPT_BOOLEAN('i', "overwrite-ignored", &overwrite_ignored,
> +	  "allow explicitly ignored files to be overwritten"),
>  	OPT_RERERE_AUTOUPDATE(&allow_rerere_auto),
>  	OPT_CALLBACK('s', "strategy", &use_strategies, "strategy",
>  		"merge strategy to use", option_parse_strategy),

-- 
Jakub Narebski
Poland
ShadeHawk on #git
