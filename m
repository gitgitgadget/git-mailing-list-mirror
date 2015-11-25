From: Raymundo <gypark@gmail.com>
Subject: Re: 'git log --source' seems to fail to show ref name after the first
 tag comes out.
Date: Wed, 25 Nov 2015 23:00:24 +0900
Message-ID: <CAAe7MbDu-Z7585A6tDcFg78pRrnDjvmdZV7oqGkqO8XchZUzaA@mail.gmail.com>
References: <CAAe7MbAwWHXxVOu-CU7QpN0K3XTKJ1=xp4-dzSwBQatdAZ1vaQ@mail.gmail.com>
 <20151125125956.GC4504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 25 15:00:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1acr-0001tI-DD
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 15:00:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754344AbbKYOAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 09:00:47 -0500
Received: from mail-io0-f179.google.com ([209.85.223.179]:35210 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753745AbbKYOAp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 09:00:45 -0500
Received: by ioc74 with SMTP id 74so54218869ioc.2
        for <git@vger.kernel.org>; Wed, 25 Nov 2015 06:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=jOz+yTjV3iG9aj3Qt3CsRb0poSAJwFe/SbFYkuTE1yo=;
        b=kkMpy8m+P3UDl1H8PPi4lQB2K3CfDn1KE5GsHUU+5mAg+pvFCNEWREtJ88+VpHotMZ
         LppA5U3/U6ZP4GhqVUkwpokhKumcS4no1evZIBfSFOQSUJ63wGEuK4xcvwAPDnFdScS5
         xw1gmTx62Bk+wKxmWcTlj3XXhScU588zRQCVo7XzJmhQKSSu8cr21Vd3M0E1kjkNPIhu
         dZgc6aiBbqU7PS4gMf1mV79jGKX9Pa+of2UpwSc0rjpjTQOwfZ2ok6JzJf7mmPXzYIN8
         9VJ/vc3p1PLjp4SAhINrrmtz57QQFAv7FzMNpD48yPISR6TIBojDePDIftAwslSQiN7S
         5Yrg==
X-Received: by 10.107.32.76 with SMTP id g73mr32238642iog.78.1448460044100;
 Wed, 25 Nov 2015 06:00:44 -0800 (PST)
Received: by 10.36.26.200 with HTTP; Wed, 25 Nov 2015 06:00:24 -0800 (PST)
In-Reply-To: <20151125125956.GC4504@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281712>

2015-11-25 21:59 GMT+09:00 Jeff King <peff@peff.net>:
>
> Sounds like a good opportunity to use git-bisect. I came up with 2073949
> (traverse_commit_list: support pending blobs/trees with paths,
> 2014-10-15) from git v2.2.0, which unfortunately was written by me. :)
>
> This one-liner seems to fix it:
>
> diff --git a/revision.c b/revision.c
> index af2a18e..d434b8b 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -297,7 +297,6 @@ static struct commit *handle_commit(struct rev_info *revs,
>                  * through to the non-tag handlers below. Do not
>                  * propagate data from the tag's pending entry.
>                  */
> -               name = "";
>                 path = NULL;
>                 mode = 0;
>         }
>
> But I'm not sure if it causes other problems. In particular, I see why
> we would not propagate a path field, but I do not know why the original
> was avoiding propagating the name field.
>
> -Peff

It's a good news that you found the reason so soon.

I'd like to wait for next version :-)

Thank you!
