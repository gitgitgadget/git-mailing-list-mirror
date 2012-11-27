From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Operations on unborn branch
Date: Tue, 27 Nov 2012 09:25:52 -0800
Message-ID: <CANiSa6isDKAgxHWqh5XiQ-adT3-ASFtvAshp028DTcotjQxzmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 27 18:26:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdOvC-0004U2-S5
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 18:26:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756226Ab2K0RZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 12:25:56 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:62276 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755994Ab2K0RZz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 12:25:55 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so8597472iea.19
        for <git@vger.kernel.org>; Tue, 27 Nov 2012 09:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=2m6AmOUwBt7kapW9N0Gnob8zgj/UE2V9DOgQNNOE2Qs=;
        b=xTpMbd8/r4JbW9Zm7GitE/SRhLCFvR46mtjBgv55zO/C2G+qVr7s9OwLYc7rR0R3su
         KqqCMoWNXjP7430UudfARZqjtCePsxV6xG8W5MWrc5ZpsTuRdLupiXVL2mtsPdkgv4NX
         3T+azmydXfzYTFYNPVCMe9UOf8bZOVFU7CyCYqBEUveAyFz5vcedtR0us/l2GJNiekso
         hv1uK5P5RaIt4Ko7+Wh9efpeOdFxZQ3EOPR5CwiXdUiRnU2juWR7y8yvAyxQUSVl1hzC
         vhEeTxaqu6ZDh/Oc7M0+H17Z39hC24WRxWJNciufqEvyn2k8GXu9S0rDwd5o45UxHYfa
         nAJQ==
Received: by 10.50.203.74 with SMTP id ko10mr5561787igc.26.1354037152815; Tue,
 27 Nov 2012 09:25:52 -0800 (PST)
Received: by 10.64.91.99 with HTTP; Tue, 27 Nov 2012 09:25:52 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210568>

While looking at how to handle "git rebase --root", I noticed that
"git cherry-pick" fails with the following when run on an unborn
branch:

error: You do not have a valid HEAD
fatal: cherry-pick failed

I can not see any reason that it shouldn't work. "git cherry-pick -n"
does work. (For rebase, "git cherry-pick --ff" would be used, and I
think that should also work on an unborn branch.)

Also, "git reset" doesn't work on an unborn branch and I can not see
any reason that it shouldn't work. This was also asked on stack
overflow [1], and of course the solution is to use "git rm --cached",
but doesn't mean that "git reset" shouldn't work.

I have very limited time to work on git these days, so if anyone else
would like to work on any of this, I would be very happy. I _might_
take some time to fix the cherry-pick issue.

Btw, every time I run into problems like these with the treatment of
root commits, I can't help but wonder how things would look if git had
always had a single root commit (naturally with some dummy user,
timestamp etc to ensure sameness across repos). With my limited
knowledge, it seems like that would complicate a few things, but
simplify a lot of things (maybe I'm biased because of the things I
have happened to work on?). Has anyone spent some time seriously
thinking about this? I suppose it would be hard to introduce
backward-compatibly, and maybe this is very unrealistic even for git
2.0, but I would be curious to hear what others think.

Martin

[1] http://stackoverflow.com/questions/3894808/new-git-repository-and-already-git-reset-does-not-work
