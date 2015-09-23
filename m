From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 5/8] branch: drop non-commit error reporting
Date: Wed, 23 Sep 2015 13:29:23 -0700
Message-ID: <xmqqr3lox4kc.fsf@gitster.mtv.corp.google.com>
References: <1443031873-25280-1-git-send-email-Karthik.188@gmail.com>
	<1443031873-25280-6-git-send-email-Karthik.188@gmail.com>
	<xmqqfv25x80c.fsf@gitster.mtv.corp.google.com>
	<vpq6130ucbh.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Sep 23 22:29:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeqfS-0005wq-B5
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 22:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754425AbbIWU30 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2015 16:29:26 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36192 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637AbbIWU3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2015 16:29:25 -0400
Received: by pacgz1 with SMTP id gz1so222616pac.3
        for <git@vger.kernel.org>; Wed, 23 Sep 2015 13:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=SnVgXbjCccUDZWW8/G3FWCSw7dqRz9NjO/VYQd/3AYI=;
        b=e64YAjVobs+vY4HY5KhbpNxqrdeMGr6ygBBPZSPWH0tMX5kWKip65X1sv73erKfVla
         zYAqQoaKJQ+QO+7Lw68CdZbIWPK3tPwJeN4c3L2TcF9In6HcQNn/YvkTskddkywK1f+K
         7FlCl9VkNw3gk1UXEwNSG5YKgFjt5fy+CPesHA+AGNE9uIA75cTzZRZDAcx+OvZgAclp
         aG01R1oqL8LlbRZTscYsyuvySWAsn0UBmhE2VTd1D4yr/PvHx9nAMDd7UJgDuhpTXhG6
         cpk73vW1X62wmTZGI1xVvW7+KZJWLNGnoJv3GKcLBcBGSa9kiISg8v3eJWatQCwYhgKu
         +vhg==
X-Received: by 10.68.65.70 with SMTP id v6mr39974534pbs.23.1443040164817;
        Wed, 23 Sep 2015 13:29:24 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:a07c:76d3:22e9:4d3d])
        by smtp.gmail.com with ESMTPSA id hn1sm9545109pbb.44.2015.09.23.13.29.23
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Wed, 23 Sep 2015 13:29:23 -0700 (PDT)
In-Reply-To: <vpq6130ucbh.fsf@grenoble-inp.fr> (Matthieu Moy's message of
	"Wed, 23 Sep 2015 22:10:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278512>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> More precisely: if we find such a branch ref and we're used with an
> option that requires us to lookup the commit, then we report it as an
> error.
> ...
> So I agree with Junio that the commit message is not sufficient: there
> is a behavioral change. I'm OK with it, but the commit message shouldn't
> claim that there isn't.
>
> Porting to ref-filter drops the commit before we get an opportunity to
> complain, so we stop complaining because it's not worth the trouble.

I share the same conclusion.  It may be an unfortunate fallout but
giving the diagnosis was not really the job for this codepath in the
first place.

If it were, then I would have said we should fix it to keep the
behaviour, even if the fix is involved, and that is why I would not
necessarily agree with "not worth the trouble".

> BTW, this looks like an fsck bug:
>
> $ git fsck --strict
> Checking object directories: 100% (256/256), done.
> error: refs/heads/broken: not a commit
> $ echo $?
> 0

Interesting.  Perhaps leave it as a MicroProject for GSoC next year?
;-)
