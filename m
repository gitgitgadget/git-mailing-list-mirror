From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 13/15] t3030 (merge-recursive): use test_expect_code
Date: Wed, 7 Dec 2011 15:57:42 -0600
Message-ID: <20111207215741.GD2911@elie.hsd1.il.comcast.net>
References: <20111207100858.GB13374@elie.hsd1.il.comcast.net>
 <1323286611-4806-1-git-send-email-artagnon@gmail.com>
 <1323286611-4806-14-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 22:57:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYPUv-0006tQ-4U
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 22:57:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758509Ab1LGV5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 16:57:49 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:45257 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758497Ab1LGV5s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 16:57:48 -0500
Received: by yenm11 with SMTP id m11so510344yen.19
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 13:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=OuckIfJTBLGtc7KQq2dznS7sEXJDyeOyYRHNCrSI6YE=;
        b=Cldh4LGDaltU8QKBaqFHtky3UiktwPBHCub8RLsAG5JF36IRJyIOL3toQEEb/3vhGV
         UtAIk16edqSfAolJHVvqUNqM/FgmXEYaRFhedEQrhLOqiGOOmtLaXFvoi6leAUV43wTD
         B+xkEdK1FLqVcEvKyme9yhaSF/C3GPvaVWsUQ=
Received: by 10.236.77.72 with SMTP id c48mr383578yhe.55.1323295068039;
        Wed, 07 Dec 2011 13:57:48 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id n5sm5316112yhk.1.2011.12.07.13.57.46
        (version=SSLv3 cipher=OTHER);
        Wed, 07 Dec 2011 13:57:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1323286611-4806-14-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186506>

Patches 9-12 look good.

Ramkumar Ramachandra wrote:

> Use test_expect_code in preference to repeatedly checking exit codes
> by hand.
[...]
> +++ b/t/t3030-merge-recursive.sh
> @@ -285,17 +285,7 @@ test_expect_success 'merge-recursive simple' '
>  	rm -fr [abcd] &&
>  	git checkout -f "$c2" &&
>  
> -	git merge-recursive "$c0" -- "$c2" "$c1"
> -	status=$?
> -	case "$status" in
> -	1)
> -		: happy
> -		;;
> -	*)
> -		echo >&2 "why status $status!!!"
> -		false
> -		;;
> -	esac
> +	test_expect_code 1 git merge-recursive "$c0" -- "$c2" "$c1"

Yeah, this style is kind of repetitive.  Worse, if "git checkout"
fails with status 1, it would yield a false success.  Thanks for
fixing it.
