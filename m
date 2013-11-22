From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Git issues with submodules
Date: Fri, 22 Nov 2013 16:46:27 +0530
Message-ID: <CALkWK0n7jdLKOAFoFjuRz0aTCssorAgk2y=Vce76Y5aHWbj53Q@mail.gmail.com>
References: <CAErtv26Q_YN+U+trjNac1aKLi9BvNHNNuaUkrr2RE0nB+yxWsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>
To: Sergey Sharybin <sergey.vfx@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 22 12:17:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vjojb-0003fz-51
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 12:17:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755165Ab3KVLRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Nov 2013 06:17:10 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:63038 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754143Ab3KVLRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 06:17:09 -0500
Received: by mail-ie0-f170.google.com with SMTP id qd12so1855801ieb.29
        for <git@vger.kernel.org>; Fri, 22 Nov 2013 03:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ogkjUPshSUfKmVUPDSGD6b7hRW6WbOHKU0Srge/7GtM=;
        b=nkC9R9lkMwC/XfEb76VfGFgoBLtsryr4DJY24sXjnK6/i3h+9MPfNWOvKRqNVleacB
         w45NisqDQOPQ8Ps+7OwMKPGsRgeC1hoA4gRfg0S9XFpKaEGqnMlyX0SETyUXjZFWPnDY
         QahSOb5DCHsdQp3eA2Zm2PPj7F4QPMWu21wW1yLhVhfQvsPYWZVX7AxRvefLi6QM6Qsl
         mdiYsVUhyf1oCSqCCoXNPIqypm7+5gb2j1djZc5LDVllg8STyQ91MPp9p+Imt5DHr9zC
         iRt3IZH/7tgYTPxHq55FMUSXI/kcTc8d1oTfx3lJBjYUJHHi8zTL7WqOi05GFJ5qMl52
         IyzA==
X-Received: by 10.50.16.45 with SMTP id c13mr1856621igd.55.1385119027167; Fri,
 22 Nov 2013 03:17:07 -0800 (PST)
Received: by 10.64.73.36 with HTTP; Fri, 22 Nov 2013 03:16:27 -0800 (PST)
In-Reply-To: <CAErtv26Q_YN+U+trjNac1aKLi9BvNHNNuaUkrr2RE0nB+yxWsw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238178>

[+CC: Jens, the goto-guy for submodules]

Sergey Sharybin wrote:
> Namely, `git ls-files -m` will show addons as modified, regardless
> ignore=all configuration. In the same time `git diff-index --name-only
> HEAD --` will show no changes at all.

This happens because diff-index handles submodules explicitly (see
diff-lib.c), while ls-files doesn't (see builtin/ls-files.c). My
opinion is that this is a bug, and git ls-files needs to be taught to
handle submodules properly.

> This leads to issues with Arcanist (which is a Phabricator's tool) who
> considers addons as uncommited changes and either complains on this or
> just adds this to commits.

Does Arcanist use `git ls-files -m` to check?

> There're also some more issues which happens to our
> developers and which i can not quite reproduce.

Do try to track down the other issues and let us know.

> Sometimes it happens so git checkout to another branch yields about
> uncommited changes to addons and doesn't checkout to another branch.

I've seldom used submodules with branches, so I'll let others chime in.

Cheers.
