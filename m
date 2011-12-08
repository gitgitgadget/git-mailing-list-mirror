From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] bundle: rewrite builtin to use parse-options
Date: Thu, 8 Dec 2011 10:39:46 -0600
Message-ID: <20111208163946.GB2394@elie.hsd1.il.comcast.net>
References: <1323349817-15737-1-git-send-email-artagnon@gmail.com>
 <1323349817-15737-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 08 17:39:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYh0l-0001IB-E1
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 17:39:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791Ab1LHQju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 11:39:50 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:35660 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842Ab1LHQju (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 11:39:50 -0500
Received: by ggnr5 with SMTP id r5so2203535ggn.19
        for <git@vger.kernel.org>; Thu, 08 Dec 2011 08:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=o5K9uSQQNRm/xX+ncNdfe54AO1CYw2Qlid5YwBAghVk=;
        b=Fy/EHk41+0a3erE2/R5+y5/Wiutk6R344fU4NeWtOcV1YLKtI1DvR+G82Z+iyCw0Z8
         uo5KQ0NHXcStiz310QNifMWVeecXxQS6WOSEGYZcuWrAj4W06GEqPnoE89j6h4Zd8Ffp
         4GisffkD9S1EOrhU0KBN9C0yQw6lZjfUjAjRU=
Received: by 10.100.35.6 with SMTP id i6mr958494ani.6.1323362389540;
        Thu, 08 Dec 2011 08:39:49 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id q52sm9898480yhh.3.2011.12.08.08.39.48
        (version=SSLv3 cipher=OTHER);
        Thu, 08 Dec 2011 08:39:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1323349817-15737-4-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186569>

Ramkumar Ramachandra wrote:

> -	if (argc < 3)
> -		usage(builtin_bundle_usage);
> -
> -	cmd = argv[1];
> -	bundle_file = argv[2];
> -	argc -= 2;
> -	argv += 2;
> +	argc = parse_options(argc, argv, NULL,
> +			options, builtin_bundle_usage,
> +			PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN);

Doesn't this make the usage completely confusing?  Before, if I wanted
to create bundle named "verify", I could write

	git bundle create verify

Afterwards, not only does that not work, but if I make a typo and
write

	git bundle ceate verify

then it will act like "git bundle verify ceate".

I am starting to suspect the first half of patch 1/2 was not such a
great idea, either. :)  Do you have other examples of how it would be
used?

Thanks for thining about these things, and hope that helps.
Jonathan
