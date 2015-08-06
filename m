From: Chris Packham <judge.packham@gmail.com>
Subject: Error when cloning with weird local directory
Date: Thu, 6 Aug 2015 16:21:06 +1200
Message-ID: <CAFOYHZByteuPZwRvw9tzFWOD6vguw4wPK1J6rLZZvHzyZRBtSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 06 06:21:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNCg6-0007Pi-F0
	for gcvg-git-2@plane.gmane.org; Thu, 06 Aug 2015 06:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754480AbbHFEVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2015 00:21:08 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:38009 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130AbbHFEVH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2015 00:21:07 -0400
Received: by iggf3 with SMTP id f3so3902991igg.1
        for <git@vger.kernel.org>; Wed, 05 Aug 2015 21:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=b4CJiYBP7TO8ehm96dkliG6aaUdinVj4pi7tAJY9Mdw=;
        b=ymeSJ1qS2ueolhzXoX6/5am9zwFLjd4II55pQPS5tDd8AiNgzDBwksLXUKyBptDKEP
         OBOhuLy6ZjkhvarSk05GZcH4rBGU2Mcti1VEzOoH+AVj2NedYb9z5KBJlSovzxDGvAG0
         kF0T4Z4HKhWarVCWBuS1vb4UymY4EuiZdMhcsru5o84MDsOXKYpf6bHOhQGzU9SRCKNa
         3TgobMPjCOZYuHrEEpgtPRwY0lSKAeOhbW6puOiMJOaIlGZWuq3qVD58KBFGePXK/c4S
         F/uRzWL0/PKn0T4r3U0CxqCdBnnaHdH/JxDRbtEEal+conf5o0y0MIGn6TD9htT2XdbH
         n6nA==
X-Received: by 10.50.122.40 with SMTP id lp8mr1269782igb.49.1438834866353;
 Wed, 05 Aug 2015 21:21:06 -0700 (PDT)
Received: by 10.79.116.130 with HTTP; Wed, 5 Aug 2015 21:21:06 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275410>

Hi All,

A developer at $dayjob called me over to have a look at a git error he
was getting (names changed to protect the innocent).

  $ git --version
  git version 2.5.0
  $ git clone ssh://example.com/repo.git
  Cloning into 'repo'...
  fatal: I don't handle protocol '/home/user/src/ssh'

After a bit of head scratching we found that he had a local directory
structure called 'ssh://example.com/repo.git' it wasn't a complete
repo but it had some of the things one expects to find in a .git
directory (info, objects, refs, etc). It had been there for a while
and we suspect was created by a scp gone wrong from the last time he
was dealing with repo.git.

I'm wondering if it's worth catching this kind of weirdness and
erroring out with a slightly more useful message. I'm also wondering
what would have happened if this repo was actually a full and complete
thing.

I'm not sure that there is a problem worth solving here. I can provide
an anonymized tarball of the directory structure in question if anyone
is interested. But maybe this is useful for future mailing list
searchers[1].

Thanks,
Chris
--
[1] - https://xkcd.com/979/
