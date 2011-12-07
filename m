From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Undo a commit that is already pushed to central server and merged
 to several branches
Date: Wed, 7 Dec 2011 20:12:22 +0530
Message-ID: <CALkWK0k46HnWTHx3iYuWFUegTgZhAMShx9MT2E83QCmxrvZOxg@mail.gmail.com>
References: <4EDF74EC.6090504@fechner.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Matthias Fechner <idefix@fechner.net>
X-From: git-owner@vger.kernel.org Wed Dec 07 15:42:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYIi0-0005jW-SW
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 15:42:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756562Ab1LGOmp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 09:42:45 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:35965 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756557Ab1LGOmo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 09:42:44 -0500
Received: by wgbdr13 with SMTP id dr13so1439933wgb.1
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 06:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=YBQJ6dMQvXkaHBVP1U1ZCbm7Tsi73s20B9dtu9zNgsg=;
        b=x5Zu/TW62LSSjKHVq5Wg+rkDaOIFN7fEmK5kkrKdIUsW7ntW6SuXxM7HdWpPDx9les
         wUdOoncx/BxD9dsmQxfJSxzPm5Fi4pR/+NMNwkP8e+7qQNWGEpEPQLjX46i3naydnC8B
         8E29Ro4bmr1OCFY2M/HLX3yjnId/CKvSWNPV4=
Received: by 10.227.203.10 with SMTP id fg10mr15479247wbb.1.1323268963420;
 Wed, 07 Dec 2011 06:42:43 -0800 (PST)
Received: by 10.216.51.141 with HTTP; Wed, 7 Dec 2011 06:42:22 -0800 (PST)
In-Reply-To: <4EDF74EC.6090504@fechner.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186457>

Hi Matthias,

Matthias Fechner wrote:
> [...]
> I continued to work then on different branches and merged the bad master
> branch to all my other branches.
> [...]
>
> What I would like to do is move this bogus commit into a different branch
> and remove all changes from this bogus commit from every branch.

If I understand correctly, each of your branches looks like*:

o  <--- HEAD of branch; merge commit referencing bogus commit
| \
o  \   <--- This is where you want to move the HEAD to
|   \
o    o  <-- Bogus commit from master branch
|
o
|
o  <-- Branch born

Assuming that you actually want to rewrite the history, the situation
calls for a git-reset(1).  Just "git reset --hard HEAD~1" on each of
your branches (Caution: first understand what it does!) and you'll
rewind the HEAD to "undo" the bad merge.  After that you can just "git
push +foo:foo" to overwrite the foo branch on your server.  If you
don't want to rewrite anything and simply commit the inverse of the
bad commit, see git-revert(1).

* If you're having difficulty understanding the diagram, please read:
http://eagain.net/articles/git-for-computer-scientists/

Cheers.

-- Ram
