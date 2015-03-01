From: William Di Luigi <williamdiluigi@gmail.com>
Subject: [Feature request] Commit flag to "ignore" conflicting/unmerged changes
Date: Sun, 1 Mar 2015 01:43:32 +0100
Message-ID: <CAJNpUg5RdXBxSGiZoSVHNZK84VbztTARqRXy+v0y0_bSQZ4c4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 01 01:44:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRrzD-0001IG-V4
	for gcvg-git-2@plane.gmane.org; Sun, 01 Mar 2015 01:44:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752854AbbCAAnz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2015 19:43:55 -0500
Received: from mail-lb0-f179.google.com ([209.85.217.179]:46251 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752425AbbCAAny (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2015 19:43:54 -0500
Received: by lbjf15 with SMTP id f15so23607516lbj.13
        for <git@vger.kernel.org>; Sat, 28 Feb 2015 16:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=wPZcjn0dPW2AoIzaGVGUnKD9k6kdgHa0xlKyD+Oz/5w=;
        b=zWhhX+RghXwHqaOPX9SrlafPB1PRiGvB3vsivh6f568Q+nUmwlmjMzCezQuSVw48+S
         M74ZciUSpBM1UWoPbwpflk0kd1gsGMO2b821IQHWUgocdfKoqv+n0aZZGIcOXFUCpSNn
         tC6qrTF8RjZPPga7DTeMslRq2BjCV+QdpQdK/l3FU1nBP/KkswTuRG7jMXpxG51Qec80
         MpayoTPItRqnRxqgcIB58FzW7fXkUGxxKo7zodspje4Pz61jT3WgXhEW4QZV1cX1yu2J
         j/RA3YvEcK4i+U1vvcguz4OPEoj2Heg8jNjQf0k3PzeL1VxhYX+8d55yL1CQ3Sp/E8l/
         ZUFQ==
X-Received: by 10.152.10.98 with SMTP id h2mr18660778lab.18.1425170633128;
 Sat, 28 Feb 2015 16:43:53 -0800 (PST)
Received: by 10.112.136.196 with HTTP; Sat, 28 Feb 2015 16:43:32 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264543>

Hi, the scenario is as follows: I'm working on a repo where only
"rebase" is used and never "merge" (which can arguably be a bad
thing). Anyway, I worked on a separate branch for some time and now I
need to integrate all the changes introduces by "master" (and prepare
some "fixup" commits that will be used when the branch will be finally
rebased).

So I call `git merge --squash --no-commit master` and some conflicts
come out. Suppose that I now have 100 files automatically merged and
staged by git, and 10 files which are conflicting ("both modified")
and I'll need to fix by hand.

The point is: I would like to commit *all* the changes that git
successfully merged (*including* partial changes inside conflicting
files). After that, I will start to work on the conflicts (which will
be resolved with several "fixup" commits).

For the moment, the only (quite tedious) way I've found to do it is this:
1. `git reset HEAD` for each of the 10 conflicting files
2. `git add -p` and select only the non-conflicted hunks
3. `git commit` let's call this commit "temp"

Then, I can finally work with *just* the conflicts. When I will rebase
on master, I will simply discard the "temp" commit and I will apply
every fixup that piled up.

The feature I'm requesting is something like a flag that allows `git
commit` to work anyway by "ignoring" unmerged hunks (which can then be
downgraded to unstaged changes).

What do you think?

Regards,
William
