From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git fast-export/fast-import *facepalm*
Date: Thu, 27 May 2010 14:03:28 -0700
Message-ID: <20100527210328.GN16470@spearce.org>
References: <AANLkTinV5mEACphA-nW9URce0Mh9xyu3UjWmfBqL6cLN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 27 23:03:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHkEs-0005cz-Al
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 23:03:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759130Ab0E0VDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 17:03:33 -0400
Received: from mail-pz0-f176.google.com ([209.85.222.176]:42058 "EHLO
	mail-pz0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757165Ab0E0VDc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 17:03:32 -0400
Received: by pzk6 with SMTP id 6so309992pzk.1
        for <git@vger.kernel.org>; Thu, 27 May 2010 14:03:31 -0700 (PDT)
Received: by 10.114.9.15 with SMTP id 15mr9569597wai.137.1274994210325;
        Thu, 27 May 2010 14:03:30 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id f11sm13147300wai.11.2010.05.27.14.03.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 May 2010 14:03:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinV5mEACphA-nW9URce0Mh9xyu3UjWmfBqL6cLN@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147898>

Chris Packham <judge.packham@gmail.com> wrote:
> What I've ended up with is a repository with a detached set of changes i.e
> 
> o -o   l - l - l - l - l - l     o - master
>      \                          /
>       o - o - o - o - o - o
> 
> o = our commits
> l = linux commits
> 
> Because the code is common textually I think what I really should have done is
> 
> (cd linux-2.6.32.y; git format-patch v2.6.32.12..v2.6.32.14) | git am
> 
> Which I'll give a try in a minute. In the meantime is there anyway for
> me to safely remove the upstream linux commits without loosing our
> commits in the process?

If I read your diagram right, the l-l-l chain isn't connected at
all to your graph, so it should just get removed with `git gc`.

But if it is connected due to a merge with your master, lookup the
merge and find its parent which is your local stuff and `git reset
--hard` to that commit.

-- 
Shawn.
