From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 4/4] remote: use remote_is_configured() for add and rename
Date: Mon, 15 Feb 2016 21:43:51 +0100
Message-ID: <20160215204351.GE13775@hank>
References: <1455558150-30267-1-git-send-email-t.gummerer@gmail.com>
 <1455558150-30267-5-git-send-email-t.gummerer@gmail.com>
 <20160215183334.GH26443@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 15 21:43:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVPzY-00012D-U1
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 21:43:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799AbcBOUn3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 15:43:29 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35890 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665AbcBOUn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 15:43:28 -0500
Received: by mail-wm0-f67.google.com with SMTP id a4so12375280wme.3
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 12:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=l8MQfbWZa+vkF2Uua8l8lC1AdDz9JBBaJxXnfdx/P7g=;
        b=N0zkrx1H4C2EVSdGld8Nq/5B6fw7LCe60bt7FcG0DCVmjSwtt7G/opQVjEEUXAFY3j
         Yt76xi4XfkBkNWkTtpD1jZrVpJTjB9ik03iNmr0EW63DAbpUK9xo4IPpTuu3w+z37Vvc
         dy9x0a+ZrmHbtdr/4XMU4RF2JyRCWJ8Cj2qe7LVmRx6rSDj394XI2Jrnunq9UrjWVuvm
         oeog6frK+FMnU9X9no3erbW2pVhDH0qXbNTulBQflAzHK304XxptvP6m3dPCQDlmWLhn
         Z/uU4YDJWpsu7fhv67s+WQToraCnUl0FZBi8tZjAjRjJsR+3kBp9PYk6wS8/GbNWBSfo
         8Gjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=l8MQfbWZa+vkF2Uua8l8lC1AdDz9JBBaJxXnfdx/P7g=;
        b=LfT27cc9wwAepWfPAR+XtnAZLgY3ZAmboKN6L+eD4oRaEoswTXN2eFngN8zGtFkV8Z
         naGXjGYu1+k40HZ0L/G0SlmHzlMsewDpfg3UDTQkhUCMFmPSHVKGfLy2rCnKZxnyTQr/
         gQJ/Foz6ru20CpLIb0JLEk63lueT/Jw8UEN7MEiZ7dZdJKXTCQGJwUOIMIDgl44LiE5J
         bvPvTsNhI105vEYGvg6kirInBQJmfbjCjMUPpmqSe7GGna4sXcIwPuQQNrqhrkvF8yMX
         fTL5paBm2ph8vdRD9868nUZgl5WKPv0tkgl7CBmf7CJUWUQIT1IseR1xfUHJr1jDa42f
         /TUg==
X-Gm-Message-State: AG10YORtoPv9iikTl0Nskb7Y5UMcnOtndh4D/OdG7BCZWlAnN+6R/FSRTG1y6KeclBVBAQ==
X-Received: by 10.28.178.209 with SMTP id b200mr3551327wmf.98.1455569007651;
        Mon, 15 Feb 2016 12:43:27 -0800 (PST)
Received: from localhost (host186-106-dynamic.41-79-r.retail.telecomitalia.it. [79.41.106.186])
        by smtp.gmail.com with ESMTPSA id v66sm17248726wmb.18.2016.02.15.12.43.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Feb 2016 12:43:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160215183334.GH26443@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286238>

On 02/15, Jeff King wrote:
> On Mon, Feb 15, 2016 at 06:42:30PM +0100, Thomas Gummerer wrote:
>
> > Both remote add and remote rename use a slightly different hand-rolled
> > check if the remote exits.  The hand-rolled check may have some subtle
> > cases in which it might fail to detect when a remote already exists.
> > One such case was fixed in fb86e32 ("git remote: allow adding remotes
> > agreeing with url.<...>.insteadOf").  Another case is when a remote is
> > configured as follows:
> >
> >   [remote "foo"]
> >     vcs = bar
> >
> > If we try to run `git remote add foo bar` with the above remote
> > configuration, git segfaults.  This change fixes it.
> >
> > In addition, git remote rename $existing foo with the configuration for
> > foo as above silently succeeds, even though foo already exists,
> > modifying its configuration.  With this patch it fails with "remote foo
> > already exists".
>
> Checking is_configured() certainly sounds like a better test, but...
>
> > diff --git a/builtin/remote.c b/builtin/remote.c
> > index 981c487..bd57f1b 100644
> > --- a/builtin/remote.c
> > +++ b/builtin/remote.c
> > @@ -186,10 +186,7 @@ static int add(int argc, const char **argv)
> >  	url = argv[1];
> >
> >  	remote = remote_get(name);
> > -	if (remote && (remote->url_nr > 1 ||
> > -			(strcmp(name, remote->url[0]) &&
> > -				strcmp(url, remote->url[0])) ||
> > -			remote->fetch_refspec_nr))
> > +	if (remote_is_configured(remote))
> >  		die(_("remote %s already exists."), name);
>
> This original is quite confusing. I thought at first that there was
> perhaps something going on with allowing repeated re-configuration of
> the same remote, as long as some parameters matched. I.e., I am
> wondering if there is a case here that does _not_ segfault, that we
> would be breaking.
>
> But reading over fb86e32dcc, I think I have convinced myself that it was
> merely an ad-hoc check for "is_configured", and using that function is a
> better replacement.

It took me a while too to convince myself there is nothing strange
going on.  But I could neither find anything in the history, nor could
I think of any case that we could break.

Thanks for your review!

> -Peff
