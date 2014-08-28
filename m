From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] merge, pull: stop advising 'commit -a' in case of
 conflict
Date: Thu, 28 Aug 2014 11:16:38 -0700
Message-ID: <20140828181638.GB20185@google.com>
References: <xmqq4mwxeqr7.fsf@gitster.dls.corp.google.com>
 <1409219218-9475-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Aug 28 20:16:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XN4Fe-0000O4-Ei
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 20:16:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbaH1SQq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 14:16:46 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33113 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773AbaH1SQp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2014 14:16:45 -0400
Received: by mail-pa0-f51.google.com with SMTP id rd3so3506328pab.24
        for <git@vger.kernel.org>; Thu, 28 Aug 2014 11:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=IDRk50JflxS+KKGFsYZ6jSJxmDiJ6j228irFE5ID/Hw=;
        b=RZOBoG1xdq4eISRQrlBzfZ2OaE3NyJ6CbCNG3vvjjOvtf8L2TQh5RipaEfXdWI0o/e
         9H6jgyy7eeScxISg3L1eNRt5EBHTXRGTH0bNghwiF89iT51bDAUAr8WEppkVsBEQ+0Jb
         Fl2aHjZUIDCdKyGTs3GPd6s+swZUWa7PoCgZBIJyZJ96KNRGCBlpVAFdTdbTJVvi72bD
         Iap3N/YJOrhMoMzGk3RqfMRYbqzEGlsigH4r0kXKUkiS7DDruwnRR0BTsUhrWIzxmBxY
         RmudcpCtuFDWZ0Q0F6dMNijkSIQxZi1IfrRg3DuEKcBSaXiNjEoHgwrmpV3BbuFlF0Hr
         VhRA==
X-Received: by 10.66.158.130 with SMTP id wu2mr8369617pab.59.1409249801762;
        Thu, 28 Aug 2014 11:16:41 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id tx8sm15022358pac.42.2014.08.28.11.16.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 28 Aug 2014 11:16:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1409219218-9475-1-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256111>

Matthieu Moy wrote:

> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
[...]
> ---
>  advice.c    | 3 +--
>  git-pull.sh | 2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)

Thanks for taking it on.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

[...]
> It was already on my todo-list, as a friend of mine semi-beginner with
> Git complained about the mis-advice the other day, and I had to agree.

That's a useful sort of thing to put in a commit message. :)

> Eventually, git could detect that conflicts have been resolved, but
> then that would be a different message, as not only "use git commit
> -a" could be resurected, but "Fix them up in the work tree" should be
> dropped when it is the case.

As is this --- when I wonder why code isn't a certain way, ideas for
future work found in the description for the blamed commit are often
helpful in explaining the current state and saving me from blind
alleys in changing it.

Anyway, this is already a very good change as-is.

Actually, I'd be nervous about suggesting "use git commit -a" without
at least also saying "inspect the result or run tests" in the
no-conflict-markers-found case.  Rerere sometimes makes mistakes, and
the result of picking one side when merging binary files can be even
worse.

Thanks,
Jonathan
