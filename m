From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 04/15] t1007 (hash-object): fix && chaining
Date: Wed, 7 Dec 2011 15:47:16 -0600
Message-ID: <20111207214716.GA2911@elie.hsd1.il.comcast.net>
References: <20111207100858.GB13374@elie.hsd1.il.comcast.net>
 <1323286611-4806-1-git-send-email-artagnon@gmail.com>
 <1323286611-4806-5-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 22:47:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYPKu-0002pP-6r
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 22:47:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758032Ab1LGVr1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 16:47:27 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:64162 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757954Ab1LGVr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 16:47:26 -0500
Received: by yenm11 with SMTP id m11so502575yen.19
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 13:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=jJUs+BRAohlfCTuLDoIPXhaUuVm/m3jKO60CCeWqIFc=;
        b=wmlD8gVYL6s28bxImuym/Lbi3jIVgD5aMyUP/I8ZXxxhNPvOzAwKf2+YmMuCglj8UN
         TXRdDBCQTEoFDM7M3sv0CJ0XLubPurWi3dC/cJQWiLl7IesaiAUwiWRb49HGXhPPSXGY
         Fy5gxmgDodyAmEQSeoSWR42tS6zIGGEJ5dgdo=
Received: by 10.236.155.74 with SMTP id i50mr437004yhk.23.1323294446248;
        Wed, 07 Dec 2011 13:47:26 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id l19sm8364664anc.14.2011.12.07.13.47.24
        (version=SSLv3 cipher=OTHER);
        Wed, 07 Dec 2011 13:47:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1323286611-4806-5-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186501>

Ramkumar Ramachandra wrote:

> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>

I think there's room for at least one line of description about why
one would want to do this.

IMHO if the patches are only being sent to me, Junio, and the
mailing list (and not cc-ed to different people), then there's no
reason to split them up when they have the same topic.

Aside from that, patches 1-3 look good.  Now for this one:

[...]
> --- a/t/t1007-hash-object.sh
> +++ b/t/t1007-hash-object.sh
> @@ -154,13 +154,13 @@ test_expect_success 'check that --no-filters option works with --stdin-paths' '
>  pop_repo
>  
>  for args in "-w --stdin" "--stdin -w"; do
> -	push_repo
> +	push_repo &&
>  
>  	test_expect_success "hash from stdin and write to database ($args)" '
>  		test $example_sha1 = $(git hash-object $args < example)
> -	'
> +	' &&

I don't see how this would have any effect.  Is it intended?
