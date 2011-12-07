From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 08/15] t3200 (branch): fix && chaining
Date: Wed, 7 Dec 2011 15:55:09 -0600
Message-ID: <20111207215509.GC2911@elie.hsd1.il.comcast.net>
References: <20111207100858.GB13374@elie.hsd1.il.comcast.net>
 <1323286611-4806-1-git-send-email-artagnon@gmail.com>
 <1323286611-4806-9-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 22:55:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYPSW-0005qL-9W
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 22:55:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758003Ab1LGVzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 16:55:18 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42909 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757878Ab1LGVzR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 16:55:17 -0500
Received: by yenm11 with SMTP id m11so508417yen.19
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 13:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=WvlSFJxM6qJOvVL41py5krwVo/IgvzaCHtV0sdy6EXk=;
        b=eOQdZjMw4KoEI85EpYjUeBWsEwelH1yEm9y5NEQSMK03vNXuifZLWClBBdIFy7Rj1o
         gAsSQfezyAyoRjSE1Z+Bb/BmerAGxgw9zjYRv9paWrKYd6oXWUl4OHO4YvQSH0wqfr9T
         n4O2AyWJbJTjE6HfQRSRKgYuWBVWi56qb6knI=
Received: by 10.236.129.140 with SMTP id h12mr394480yhi.47.1323294916019;
        Wed, 07 Dec 2011 13:55:16 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id w68sm5260351yhe.14.2011.12.07.13.55.14
        (version=SSLv3 cipher=OTHER);
        Wed, 07 Dec 2011 13:55:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1323286611-4806-9-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186504>

Ramkumar Ramachandra wrote:

> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -22,7 +22,7 @@ test_expect_success \
>  
>  test_expect_success \
>      'git branch --help should not have created a bogus branch' '
> -     git branch --help </dev/null >/dev/null 2>/dev/null;
> +     git branch --help </dev/null >/dev/null 2>/dev/null &&
>       test_path_is_missing .git/refs/heads/--help

Won't this break when running tests for the first time, before the git
manpages are installed?

>  '
>  
> @@ -88,7 +88,7 @@ test_expect_success \
>  test_expect_success \
>      'git branch -m n/n n should work' \
>         'git branch -l n/n &&
> -        git branch -m n/n n
> +        git branch -m n/n n &&
>  	test_path_is_file .git/logs/refs/heads/n'

Good catch.
