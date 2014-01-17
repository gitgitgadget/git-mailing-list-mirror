From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: 'git log' escape symbols shown as ESC[33 and ESC[m
Date: Thu, 16 Jan 2014 18:29:21 -0800
Message-ID: <20140117022921.GU18964@google.com>
References: <52D87A79.6060600@rawbw.com>
 <20140117014758.GF7249@sigill.intra.peff.net>
 <52D88F30.4000807@rawbw.com>
 <20140117021320.GA12444@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yuri <yuri@rawbw.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 17 03:29:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3zBZ-00017h-Dq
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 03:29:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751841AbaAQC30 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 21:29:26 -0500
Received: from mail-yh0-f49.google.com ([209.85.213.49]:50232 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751770AbaAQC3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jan 2014 21:29:25 -0500
Received: by mail-yh0-f49.google.com with SMTP id b6so1210353yha.22
        for <git@vger.kernel.org>; Thu, 16 Jan 2014 18:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=poAInl2LQ9G2O61UiH/T5PYg1LiNeEl6MoYNoz9iXEE=;
        b=loXOGVl0srY0+uppJyWPLGmLi1Y9HN8HPOLzD37b9+GXBvv2W8hVxN7SG6T7gXFaNe
         0uu0Yj2Xh3b9PJBE0GRGKZvEIi7AFzVRKCixWlqYjhzGCG2dmtVSlaKqrUMc3GzOn9Hw
         r3G9WETx6TcluFhjGTWtShmaflkF3yWkKNzMuILKr9SGh6Hm0FPOaH3Fc15nxzL0wJai
         dyl9gdytdBxOMz4iWHYQNF9XZXFc+5TTTG4jO7eLnxnr5X992idrcrFEX0RWi1QSELle
         UQQmuFWOyX1sQk5G/O3BQ9uxUP6Zjqqw12PlGDQKQGwL0ZwwhBzQGdcJBFW3Ji+SVCro
         fOEg==
X-Received: by 10.236.131.19 with SMTP id l19mr13598885yhi.0.1389925764799;
        Thu, 16 Jan 2014 18:29:24 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id z7sm15365934yha.14.2014.01.16.18.29.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 16 Jan 2014 18:29:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20140117021320.GA12444@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240562>

Hi,

Jeff King wrote:

> Obviously that does not help the "new unchanged user".  I think we can
> be smarter about guessing whether the pager can actually handle color,
> based on the name.
[...]
> +++ b/pager.c
> @@ -182,3 +182,38 @@ int check_pager_config(const char *cmd)
[...]
> +	/*
> +	 * We know that "more" does not pass through colors at all.
> +	 */
> +	if (!strcmp(pager, "more"))
> +		return 0;

I seem to remember that on some systems "more" is the name of the
full-featured pager that knows how to scroll forward and backward and
handle color.  (My memory could be faulty.  A search in the makefile
for DEFAULT_PAGER=more only finds AIX, which is not the platform I was
thinking of.)

On a stock Debian system "more" is especially primitive, which means
that it passes colors through, too.  It being so primitive also means
it is not a particularly good choice for the PAGER setting, though,
so probably that's not too important.

Hope that helps,
Jonathan
