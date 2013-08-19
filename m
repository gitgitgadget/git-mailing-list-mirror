From: Nazri Ramliy <ayiehere@gmail.com>
Subject: Re: Does Git now have any C struct version history tracking mechanism?
Date: Mon, 19 Aug 2013 13:54:08 +0800
Message-ID: <CAEY4ZpO3x-B7SKQa+Djtt_AfQ7y=nNBZ1sR9Gvv8d3FvQLK1PA@mail.gmail.com>
References: <CAHz2CGW_xR4Q193h2itCELdXEpoAxetj324ATstALHM03cSvFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Zhan Jianyu <nasa4836@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 19 07:54:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBIPu-0002eG-LK
	for gcvg-git-2@plane.gmane.org; Mon, 19 Aug 2013 07:54:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817Ab3HSFyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Aug 2013 01:54:10 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:40846 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810Ab3HSFyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Aug 2013 01:54:09 -0400
Received: by mail-la0-f48.google.com with SMTP id er20so2962021lab.7
        for <git@vger.kernel.org>; Sun, 18 Aug 2013 22:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=gjF2quTM22zRG0kz+K02yL6neSxOMedYPZpvv6oxVlY=;
        b=aGGpwA+wXh1YiUj7HPiOOdzSD8XWDWZBe8mfa74TIC0qTmzhBtAf1OoWre9aisP5Is
         6TL+Qw7QmWaQe9G58zobCpC7/se5BwiwMnRCDFxJThV2m0Sw5TlLp0+w6yggQZZ6NzJg
         dI4JcUPspdjGG0sdafGKiangltNJQyazGaqLaRt5cDR3KRUTzcBC825ONcKFn4OIXaIv
         tyElpy7AAVQWMg2lL9b2Q57UIVuPnce45YzL+quvrckQdsBQ+fQV8ZFBpQwlcS0aXNoR
         fRESBTE5INVxmdRtnl6/b79Ki2nyrGzDmXkzfdSz5v8ZjRd6GID6ZjpwyGftl3rKFwT9
         NRQQ==
X-Received: by 10.152.3.201 with SMTP id e9mr10900636lae.24.1376891648074;
 Sun, 18 Aug 2013 22:54:08 -0700 (PDT)
Received: by 10.112.150.162 with HTTP; Sun, 18 Aug 2013 22:54:08 -0700 (PDT)
In-Reply-To: <CAHz2CGW_xR4Q193h2itCELdXEpoAxetj324ATstALHM03cSvFg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232529>

On Sun, Aug 18, 2013 at 6:33 PM, Zhan Jianyu <nasa4836@gmail.com> wrote:
>   Such a requirement came into my mind when I am tracking a gloomy C
> struct , with lengthy list of elements which are either elaborated or
> opaque. So I use git blame to track it down and found that its
> original version is quite simple and intuitive. So I think I could
> just slice out every snapshot of this struct, reading every changelog
> , to get a better knowledge of what it is and why it should be like
> this.
>
> It seems quite helpful but the process is quite cumbersome. So I
> wonder if there is already some mechanism fulfilling my requirement in
> Git.  If it doesn't,  would it be worthy adding one ?

It's already merged to git.git's master quite recently in
ed73fe56428eecd2b635473f6a517a183c4713a3 (back in June).

You'd invoke git log like this:

    $ git log -L :struct_or_function_name:filename.c

and it will show you the commits and the specific hunks that affect
the struct or function name.

It's still a bit rough on the edges, for example, doing the following
in git.git:

    $ git log -L :rev_cmdline_info:revision.h

Shows three commits (a765499, ca92e59 and 281eee4) where the second
one does not touch the struct at all (if you do "git show ca92e59" you
might gain an insight as to how -L works).

But that is not to say that it's not good. The gain really shadows the
roughness.

nazri
