From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] Documentation/Makefile: clean up MAN*_TXT lists
Date: Fri, 1 Feb 2013 11:20:10 -0800
Message-ID: <20130201192010.GA12368@google.com>
References: <20130201082538.GA25674@sigill.intra.peff.net>
 <20130201082650.GA25783@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Max Horn <max@quendi.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 01 20:20:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1MAE-0004Xx-RT
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 20:20:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754648Ab3BATUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 14:20:21 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:54776 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752921Ab3BATUT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 14:20:19 -0500
Received: by mail-pa0-f50.google.com with SMTP id hz10so2394693pad.37
        for <git@vger.kernel.org>; Fri, 01 Feb 2013 11:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=c4Zhx2LR8/U2Bcm3f4+pWq4MBWRjXkHPQ16Relg5zN4=;
        b=Rhiel4YebpykAPtLvHIdx3tj2BKm7mMGnEUbkjqCc9HGLH3Ggzd1wEVeVZAio0ltVc
         AsbHIZND5u1pv5TffCa9415LlwNNv+zEJqXpTSOA36g1LAYCJVybv4wS8S2wSzHvo2zh
         YvHznTKwuOs1poq8DCKTGXRDSsJf9E7+XgaFx0eF+f92Z5C/HwtLFLhrLscidP5o1vf7
         dTpHz9uUZw/Z3PZG3Kwm2MW5e02+4KzrEaaLmiWAiZ98lTo2bXqeYe95bPxZMRJUzpGF
         V/FfxS9S3cjjVeOGkRcWnUJ1sjTaa79dGzZMJC2l1TCe+WFLvXZcIkL4HDkT1QrvU10O
         cM5Q==
X-Received: by 10.66.83.136 with SMTP id q8mr32395399pay.83.1359746419271;
        Fri, 01 Feb 2013 11:20:19 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id l5sm9985442pax.10.2013.02.01.11.20.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 01 Feb 2013 11:20:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130201082650.GA25783@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215254>

Jeff King wrote:

> We keep a list of the various files that end up as man1,
> man5, etc. Let's break these single-line lists into sorted
> multi-line lists, which makes diffs that touch them much
> easier to read.

Independentally of the rest of the series, I think this is a good
cleanup.

> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -1,13 +1,28 @@ MAN7_TXT += gitcredentials.txt
> -MAN1_TXT= \
> -	$(filter-out $(addsuffix .txt, $(ARTICLES) $(SP_ARTICLES)), \
> -		$(wildcard git-*.txt)) \
> -	gitk.txt gitweb.txt git.txt
> +MAN1_TXT += git.txt
> +MAN1_TXT += gitk.txt
> +MAN1_TXT += gitweb.txt
> +

If the user happens to have MAN[157]_TXT set in the environment, this
would be affected by that.  How about:

	# Guard against environment variables
	MAN1_TXT =
	MAN5_TXT =
	MAN7_TXT =
	
	MAN1_TXT += ...
	...

?

With that change,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
