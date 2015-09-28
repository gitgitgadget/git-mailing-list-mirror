From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why not git reset --hard <path>?
Date: Mon, 28 Sep 2015 13:42:02 -0700
Message-ID: <xmqq612ucm3p.fsf@gitster.mtv.corp.google.com>
References: <20150928203449.29024.qmail@ns.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: "George Spelvin" <linux@horizon.com>
X-From: git-owner@vger.kernel.org Mon Sep 28 22:42:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgfFW-0002Vk-O7
	for gcvg-git-2@plane.gmane.org; Mon, 28 Sep 2015 22:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753383AbbI1UmF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 16:42:05 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34165 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753070AbbI1UmE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 16:42:04 -0400
Received: by padhy16 with SMTP id hy16so183730791pad.1
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 13:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Jh52wvy1YS8oWyhRh+Km53qqV2IO/mnU5YV5DmaEYmI=;
        b=JUXlYfAo1gvgvIWS73x0qS7TOgEC8/n6km+igu+Qm1s8zLuzbbk/RsxMEgIjdH5SLW
         ByqIOA2wNAIRihZzlXBHIIJJYsFkbVJyrO261+TvW5Ca6GgLTDx29FJsZUugXHCJtuBA
         Jz8KP/x92Bx9a/XZfnVWTk1QWNlEHmYSOOifXqaTb8OZAXodVQ2Atjt903SqmazKEa4W
         cBfdeflK3CbG163vI99qBPqNqnuPAfkqboCLU1YIpEJLt+Pb9IDlpqJDYmPfe3GjqgVg
         k+66J40pAIMaZDfYXiJHMlIKH6ew/HR7eauIDvemSNhVZikdYachEsG3m8SS5Gm+lfMq
         L6sg==
X-Received: by 10.66.228.97 with SMTP id sh1mr28500233pac.91.1443472924172;
        Mon, 28 Sep 2015 13:42:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:66:24f2:2685:8011])
        by smtp.gmail.com with ESMTPSA id kv9sm21269189pab.39.2015.09.28.13.42.03
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 28 Sep 2015 13:42:03 -0700 (PDT)
In-Reply-To: <20150928203449.29024.qmail@ns.horizon.com> (George Spelvin's
	message of "28 Sep 2015 16:34:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278751>

"George Spelvin" <linux@horizon.com> writes:

> I was applying an old forgotten stash to see if there were any edits in
> it I wanted to preserve, and my old changes to one file made no sense
> any more.  I wanted to drop then all and keep the version in HEAD.
>
> I'd been using git reset <path> after resolving conflicts, to leave
> the changes in the same un-staged state they were before the stash,
> so I tried using "git reset --hard crypto/842.c" to throw away
> my local changes.
>
> And I got
> fatal: Cannot do hard reset with paths.
>
> So I did "git reset <path>" followed by "git checkout <path>", which
> achieved what I wanted.
>
> But what I don't understand is why git reset couldn't do it for me in one
> step.
>
> I understand that "git reset --soft" makes no sense with a path, but
> why not --hard?

I do not think there is anything fundamentally wrong for wishing for
"reset --hard <pathspec>".  It probably is just that nobody needed
it, because "git checkout HEAD <pathspec>" is a 99% acceptable
substitute for it (the only case where it makes a difference is when
you added a path to the index that did not exist in HEAD).
