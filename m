From: Dov Grobgeld <dov.grobgeld@gmail.com>
Subject: Re: Seeing git history of file including merge changes
Date: Wed, 9 Sep 2015 11:26:47 +0300
Message-ID: <CA++fsGHPEMhfENx-35=_9_k7mH98TU8NkHO0pYLC2aSxUKWvyg@mail.gmail.com>
References: <CA++fsGE-R1XpHxAVRZvOEAAwNr1XdTudGbwE4GYvg-E5L9kqEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 09 10:27:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZaig-0002LO-IG
	for gcvg-git-2@plane.gmane.org; Wed, 09 Sep 2015 10:27:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925AbbIII0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2015 04:26:52 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:38051 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597AbbIII0s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2015 04:26:48 -0400
Received: by wiclk2 with SMTP id lk2so12379069wic.1
        for <git@vger.kernel.org>; Wed, 09 Sep 2015 01:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=XHBbUHAqJWHvvnGm5ZzF064yeTYPzyhMkpbFBb0HARA=;
        b=gDWHDqZ5yFn9MJs1xIPHRBwLQ+JGv9I9Nzk+aD9JVUs1a4ANrflEfR03P1OEAs/APC
         pDIJTDnjJE5WaDfY10veKuTpe3HpUEWM8/V9OVlAdXTYetuMhUpw9ifUIJ31ZH4wW+FF
         hojECF7oXRWiCQLmiE1TdVYUq4QY06to6t9+qizKs8HJwCSdl/LlOqBFLwfQFES/YuMh
         AaGtn9D4f93FAyF9NxR9N54kt7wOuINHIt3pFpPR/WqB2ZMO5rZOLiMAiFYl3880zqwf
         /4L/8ja16W5riNbaknIOEES8M2v/mZYR632sMo0CLrIlKdoBCyagdQ7W0fmwxoB8nKX5
         LLyA==
X-Received: by 10.180.73.244 with SMTP id o20mr53582950wiv.31.1441787207098;
 Wed, 09 Sep 2015 01:26:47 -0700 (PDT)
Received: by 10.28.0.6 with HTTP; Wed, 9 Sep 2015 01:26:47 -0700 (PDT)
In-Reply-To: <CA++fsGE-R1XpHxAVRZvOEAAwNr1XdTudGbwE4GYvg-E5L9kqEQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277536>

I asked the following question on StackOverflow a while ago, but did
not receive any answers so I'll try here.

We have git repository where a file was changed on a topic branch and
this branch was then merged back into the main branch. Due to various
reasons the merge was made wrongly and as a result the changes were
not accepted during the merge. The following image shows what
happened:

               -----
              (  H  )
               -----
                 ^
                 |
                 |
               -----
              (  M  )
               -----^
                 ^   \
                 |    \  -Delta
                 |     \
                 |     -----
                 |    (  B  )
                 |     -----
                 |    ^
                 |   /  +Delta
               -----/
              (  A  )
               -----


The file was changed in commit B and the changes were undone in commit M.

My problem is how to view the changes to the file between a specific
commit, e.g. B and another commit in its "downstream", e.g. H.

If you do

    git log -u B..H

you won't see any changes, as the changes due to M are suppressed. You
can see potential changes by doing:

    git log -u --full-history B..H

which will show you that there was a merge commit, but it still won't
show you the diff between B and M.

So is there a way of seeing all changes made to a file including those
made by a merge commit?

Thanks!

Dov
