From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Rebasing with submodule change causes red herring with --continue
Date: Fri, 10 Apr 2015 11:30:20 -0500
Message-ID: <CAHd499AqCJ5N1GP6mBJZB7-9vWPNjtia1G7PHoSY3d=Zovv7UA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 10 18:30:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ygbp4-0000I7-1i
	for gcvg-git-2@plane.gmane.org; Fri, 10 Apr 2015 18:30:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754941AbbDJQaW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2015 12:30:22 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:35857 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754889AbbDJQaV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2015 12:30:21 -0400
Received: by igblo3 with SMTP id lo3so2196342igb.1
        for <git@vger.kernel.org>; Fri, 10 Apr 2015 09:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=mTjalbYCBOcankar1XMVO6Ejt/ukpSJ4lTe4kkJfINY=;
        b=LVJLe8bfmlFbkkAB3RtJoUqOxC3T+6tJeMvamIf3jdEjiqaC7ICumK7aweKU5m20GU
         dZ7YNKV8xTpA9eSm/cdkfgK174VSHDmiWqMPSRh1nps39iL24qWlOBi5MCfQ+ldqUH+B
         3/FHmDFXrz5Fk7WaqYYCigr2wyaM6h+kwbimHmm/iP3jDqB+nd7IAD9feO/1kRv4jMxs
         JF88RtwIiRxheaLJ3g3iIDzesEYBbJLXwpyaF7KPklsVbXKpbB8E9wunnR4tSdzjhHzX
         jiBNdaDLIsDydv/8hCkJefWcjm+Ga/UagwmOUNNHzcNWs2FRDqS4Z2JcmMQ4Gvt0dHWP
         0Ysw==
X-Received: by 10.107.32.212 with SMTP id g203mr4012997iog.55.1428683420876;
 Fri, 10 Apr 2015 09:30:20 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.36.49.138 with HTTP; Fri, 10 Apr 2015 09:30:20 -0700 (PDT)
X-Google-Sender-Auth: YsjQ0YDV1y7UY1_d_C8pf01VlXM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267013>

I have a branch that contains a commit with a single change: A
submodule pointing to a new SHA1.

When I rebase this branch onto the tip of its parent branch AND that
parent branch had modified that same submodule, the rebase stops at
the commit on my branch that modified the submodule and asks me if I
want to keep REMOTE or LOCAL. I say LOCAL and notice immediately that
the submodule is not staged (normally it would be).

I do:

$ git add my-submodule

Then I do:

$ git rebase --continue

At this point, it fails asking me if I forgot to stage changes and
recommends doing --skip. This is normally what you would see if the
staging area was completely empty, however it isn't, since I see the
submodule is in there.

Is this a bug or am I missing a fundamental here? I'm using Git 2.1.0
on Windows through MSYS. I'll provide more concrete examples if my
summary of the issue doesn't "ring any bells".
