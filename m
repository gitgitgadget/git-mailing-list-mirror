From: Jay Soffian <jaysoffian@gmail.com>
Subject: Dealing with rewritten upstream
Date: Fri, 30 Sep 2011 18:09:10 -0400
Message-ID: <CAG+J_DwR4vE6iYt475EM7-VDNi4hG3jhdmXWSbJ04Y9fyHeuLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 01 00:09:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9lGg-0001uO-4n
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 00:09:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756588Ab1I3WJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Sep 2011 18:09:13 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:42310 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757353Ab1I3WJK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2011 18:09:10 -0400
Received: by ywb5 with SMTP id 5so1891262ywb.19
        for <git@vger.kernel.org>; Fri, 30 Sep 2011 15:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=BSI027ycL5dQ/DBtudfE3k2/Y4wsoiVpkGjfjqd1KK0=;
        b=xqQ1lWCPZB9ofU8BzmkZa8U7NDBAILyjmH77oP6eAU4WIqixIZkF+7bNGbLUhgAyVY
         1nv1wG9wgJwDfSHe/gEms6lwOBtRn6hFMFm1TMySsI+DJn7C5GUBFyuH/5UtCXF8JxIJ
         kO1VWgEbAJBOV2SgaLG2TYlANvGYmz2+Oox4E=
Received: by 10.147.154.12 with SMTP id g12mr11319012yao.36.1317420550317;
 Fri, 30 Sep 2011 15:09:10 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Fri, 30 Sep 2011 15:09:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182515>

I have a repo w/over two years of history whose upstream repo is a
git-svn mirror.

The upstream folks recently announced they need to retire the existing
repo and replace it with a new repo. The new repo is identical to the
old repo tree wise (commit for commit), but some of the commits in the
old repo had incorrect authorship which is corrected in the new repo,
so the new repo has different commit IDs than the old.

(i.e., it's as if they've run filter-branch --env-filter on the old repo.)

My repo has many merge points with the old history.

Pictorially:

---A---B---C---D---E... new-upstream/master

---a---b---c---d---e... old-upstream/master
    \       \       \
     1---2---3---4---5  master

The obvious way do deal with this situation is:

$ git merge -s ours -m "Splice in new-upstream/master" E

Are there any other/better options I'm missing?

(Eventually upstream plans to migrate entirely to git, so I can't just
run git-svn myself.)

j.
