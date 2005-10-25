From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Towards CVS code-exchange and gateways
Date: Wed, 26 Oct 2005 09:57:14 +1300
Message-ID: <46a038f90510251357l23886747s8024a4326ad4e392@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Oct 25 23:00:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUVrG-0002X0-LG
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 22:57:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbVJYU5Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 16:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbVJYU5Q
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 16:57:16 -0400
Received: from xproxy.gmail.com ([66.249.82.202]:35274 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932377AbVJYU5P convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2005 16:57:15 -0400
Received: by xproxy.gmail.com with SMTP id i30so14478wxd
        for <git@vger.kernel.org>; Tue, 25 Oct 2005 13:57:14 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=k/TbjKgbBUcFogiFMQX0rh1Xxs5rHEDZVZ/GInnqxM6Bf/XtVWmmDgEE5fG1Z2x6DvWc+fB/b0K3YrXLIUa9lK3S/8HWR05vgrvwGI13ejYEH7zClpuS43ceXmzUGwOMWtg48tUgL0tNXpS4TdpG/EA5SXlNp4ES95JelLEu5a8=
Received: by 10.64.204.7 with SMTP id b7mr96812qbg;
        Tue, 25 Oct 2005 13:57:14 -0700 (PDT)
Received: by 10.64.232.18 with HTTP; Tue, 25 Oct 2005 13:57:14 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10615>

Now that I have a few cvs2git gateways (git-cvsimport running on cron)
for the projects we work on, I am starting to need tools to "replay"
chunks of git history against external CVS repositories. So I am
thinking of writing two new scripts which expect to be executed inside
a CVS working copy:

 + "git-cvsapplypatch < patchfile" takes a patch as formatted by
git-format-patch, apply using patch (with options to be strict of
fuzzy), prepares the commit message and (optionally) autocommit if
patch returned clean.

 + "GIT_DIR=~/foo/bar/.git git-cvsreplaycommit parent:child" takes a
pair of git revisions that must be parent/child, applies the diff on
text files and changes on binary objects. Prepares the commit message
and (optionally) autocommits if the merge was clean.

Which should lead later to a git-cvsapplymbox script to automate the
process further. This part of the automation is actually a bit scary:
with git, all your scripted merges take place in your private repo,
and you review the result of the whole patchrun before pushing it out
to a public repo. With cvs, if the merge turns out to apply cleanly
but be a really bad idea... it'll be way too late. I hope to be able
to find a smart way to run it in "test" mode.

Is there anyone working on a git -> cvs gateway or similar scripts?

cheers,


martin
