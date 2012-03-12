From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git-am: error out when seeing -b/--binary
Date: Mon, 12 Mar 2012 16:56:07 -0500
Message-ID: <20120312215607.GB11362@burratino>
References: <20120312024948.GB4650@kroah.com>
 <20120312063027.GB8971@1wt.eu>
 <20120312064855.GB16820@burratino>
 <20120312085820.GA11569@1wt.eu>
 <20120312152004.GB9380@kroah.com>
 <20120312152453.GB12405@1wt.eu>
 <87aa3l4vqq.fsf@thomas.inf.ethz.ch>
 <20120312165703.GB18791@burratino>
 <7vvcm9snko.fsf@alter.siamese.dyndns.org>
 <87399dpk48.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Willy Tarreau <w@1wt.eu>,
	Greg KH <greg@kroah.com>, Ben Hutchings <ben@decadent.org.uk>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>
X-From: linux-kernel-owner@vger.kernel.org Mon Mar 12 22:56:36 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1S7DEH-0000TB-PF
	for glk-linux-kernel-3@plane.gmane.org; Mon, 12 Mar 2012 22:56:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078Ab2CLV4W (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 12 Mar 2012 17:56:22 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:47420 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757654Ab2CLV4S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Mar 2012 17:56:18 -0400
Received: by yenl12 with SMTP id l12so3110541yen.19
        for <multiple recipients>; Mon, 12 Mar 2012 14:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=SJ3cMEhKGTlEh8m7as3NpTLM7VlOd+1k9L4WkPuXHms=;
        b=EoQZe/IUOwf2O+NUaGgiv0lxRToK7AygGdUYKjNEIfYEuUTVgyjSr2e+wCCv2Gecr7
         /NI5Uq3MV2q2EeiIbaMrOZJrPrx15o5kUsirlb7qVBc41KbUDqE96sOyJLtWWgApKCNf
         ZP5Tzx6/+aUIdSWQjtaWl0+H7eucfB+scGPk3a1antB9iu2sr+8Uawc0p3UE7IauzDog
         Q1bLtGOVprcaVQnAvR/qwsURwu4B/8iZ9NrFZtAx+fj37xoUSAPw1ZumBYu3UWuPt7gz
         mK5fq59PzwwWvbD+o9nWwwXKJckLHxIl4McgR9HJ+IcVOWJDyeUUEYfsangPMzIOt+FC
         5jwg==
Received: by 10.182.227.37 with SMTP id rx5mr9346950obc.53.1331589377904;
        Mon, 12 Mar 2012 14:56:17 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id u5sm22484176obk.16.2012.03.12.14.56.16
        (version=SSLv3 cipher=OTHER);
        Mon, 12 Mar 2012 14:56:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87399dpk48.fsf@thomas.inf.ethz.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192958>

Thomas Rast wrote:

> Ok, but if I don't get to say anything about repurposing, can I at least
> make it an error message instead of just spewing out the "invalid
> option" help?

I don't mind either way.

[...]
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -380,7 +380,9 @@ do
>  	-i|--interactive)
>  		interactive=t ;;
>  	-b|--binary)
> -		: ;;
> +		echo >&2 "The -b/--binary option was deprecated in 1.6.0 and removed in 1.7.10."
> +		die "Please adjust your scripts."
> +		;;

Hm, on second thought, if people are seeing this message, I would
prefer if they write to the mailing list so we can find out about it.
So I really would rather see this say

	--binary)
		: ;;

and have "-b" completely unrecognized, without any words in our
defense except for a note in the release notes mentioning the option's
removal and that it has been an unadvertised backward-compatibility
no-op since 1.6.0.

Jonathan
