From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: git fetch documentation
Date: Sat, 1 Jun 2013 16:55:42 +0530
Message-ID: <CALkWK0mqkOZ__Gk-5VUpzLCaUHx1kA1JTrFunF3tUSeX6tDkgA@mail.gmail.com>
References: <87sj12rt13.fsf@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Nicolas Richard <theonewiththeevillook@yahoo.fr>
X-From: git-owner@vger.kernel.org Sat Jun 01 13:26:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uijx8-0004Pi-Nv
	for gcvg-git-2@plane.gmane.org; Sat, 01 Jun 2013 13:26:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755507Ab3FAL0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Jun 2013 07:26:25 -0400
Received: from mail-bk0-f53.google.com ([209.85.214.53]:34083 "EHLO
	mail-bk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755160Ab3FAL0Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jun 2013 07:26:24 -0400
Received: by mail-bk0-f53.google.com with SMTP id mx10so1153818bkb.12
        for <git@vger.kernel.org>; Sat, 01 Jun 2013 04:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+wOSc+eeNWbctr26W9T/tieyjxtE6V68lhDqomYs5GY=;
        b=ZovVWjta+jbrBgskmWFXATcKJNheCmwvER3Dc2WxdlMQ3UxB9dEIIwNLtflHnHYUPz
         CUtzLWb+B8fzEccZYngq7VWKZWzXsoHVCLBedL6jnN9N4+ntviuH0xrlYP5FMvLyWwA3
         Xa1vGGzdVRar1diqj2RT5nyE6rZ8TL0QFOgSv1zMVJyKqd1v9L8tVWNl14m2tFc/Ddrs
         tQ4/sSw7pmo0nja20cLlOkjyuEL6lPT54RoDqdGr6XNA2ESPzA9BvonwYEfYIPuVJD7V
         vzzJqy+ous0pTutbovWAg4zeFIqQBSnMrZdC9/E470Lq9KKCIEuCpcOQUFaCpe0lkPaa
         2Asg==
X-Received: by 10.204.225.132 with SMTP id is4mr4431380bkb.77.1370085982459;
 Sat, 01 Jun 2013 04:26:22 -0700 (PDT)
Received: by 10.204.172.209 with HTTP; Sat, 1 Jun 2013 04:25:42 -0700 (PDT)
In-Reply-To: <87sj12rt13.fsf@yahoo.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226124>

Nicolas Richard wrote:
> - A '*' can be used both in src and dest, and it matches any name,
>   including subdirectories, but not partial names (i.e. refs/heads/foo*
>   is invalid).
> - multiple fetch lines can be given in .git/config, each of them will be
>   obeyed
>
> These are probably obvious for most users, but I think documenting them
> would be good for newcomers. (I tried to come up with a patch but I
> can't find a precise yet concise way to explain the role of '*' in
> english.)

Good.  Yes, we don't even have examples showing that a rewrite like
refs/heads/nr/*:refs/heads/* can be done.  The documentation is
definitely lacking.  However, I'd urge you to get started by
submitting an initial draft: we will review it and help you learn and
contribute.  Some pointers:

- What you are attempting to document is called a refspec.  Look at
'struct refspec' in remote.h, and attempt to understand what its
fields mean by looking at how it is used in remote.c.

- Notice that there is a push refspec corresponding to the fetch
refspec.  This feature is even more obscure and undocumented.

- See remote.c:get_ref_match(); specifically,
match_name_with_pattern() is doing the pattern matching.  As you can
see, match_name_with_pattern() hard-codes a '*' and tries to match
just that: there is no support for anything else.  Try to skim through
the code once.

- Read Documentation/SubmittingPatches and submit a first version
quickly.  It doesn't have to be perfect at all.
