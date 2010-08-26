From: Joshua Juran <jjuran@gmail.com>
Subject: Re: How to handle a git repository with multiple branches
Date: Thu, 26 Aug 2010 06:09:13 -0700
Message-ID: <D36A67AE-3477-4D8D-A424-6413D8C4E70C@gmail.com>
References: <AANLkTimW-SQi1eprxTPXxF85SBO4d5MU13=dsboNNrzd@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Erez Zilber <erezzi.list@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 15:09:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OocCu-0006Rw-Fy
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 15:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753512Ab0HZNJZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 09:09:25 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:52994 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752502Ab0HZNJS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 09:09:18 -0400
Received: by pwi7 with SMTP id 7so686189pwi.19
        for <git@vger.kernel.org>; Thu, 26 Aug 2010 06:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=W4PoxqtGz91koAKsTfbgj1atjlb1wqQVaUxlNTyDy/I=;
        b=Fi/HG1fYYXyiP8YCU85FnyQ4iq37b/7j7pOqE5zHJ+4q6AGkNYrSoglbQO2AUWUkBH
         9gpWuiwJSRA06gd8zfZTuBhp2v9E0nnMUJZOcbxoPCilKrOCVFs1Ki2yQRqLETnBQzFc
         bPs9brXhI0UJ1p+vQ08Q75FPp6EslfG7EH5Cs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=CKaPIKOj84eTM1OqErjBekymxeGXR6iOk3WzOqJ1FX0B8AQDwClfzdKx+YDW2RlQ9+
         6NDLWXiMVqr/UDpghuxjc43mfsErh5UxZB9H6JX+Cr2wxuD1kVlYI6LNlc2d1DUzNWT4
         5YVxpaAw7qiHh3zhIhpIdNTLK6DHyqLmWQK68=
Received: by 10.114.103.6 with SMTP id a6mr11096942wac.213.1282828157024;
        Thu, 26 Aug 2010 06:09:17 -0700 (PDT)
Received: from zaphod.jjuran.dyndns.org (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id s5sm4443489wak.0.2010.08.26.06.09.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Aug 2010 06:09:15 -0700 (PDT)
In-Reply-To: <AANLkTimW-SQi1eprxTPXxF85SBO4d5MU13=dsboNNrzd@mail.gmail.com>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154538>

On Aug 26, 2010, at 4:53 AM, Erez Zilber wrote:

> My repository has several branches. Each branch is for a separate code
> release. Let's assume that I have a branch for V1.0 (branch_1) and a
> branch for V2.0 (branch_2).
>
> Some commits are relevant only for branch_1, some are relevant only
> for branch_2 and some are relevant for both. For the commits that are
> relevant for both branches, I thought about the following solutions:
> 1. Put these common commits in branch_1 and merge branch_1 into
> branch_2. This is bad because it will also merge commits that are
> relevant only for branch_1.
> 2. Cherry-pick the common commits from branch_1 to branch_2. This is
> also bad because the commit ID changes, and in case of conflicts, git
> is unable to tell that these 2 commits are actually the same commit.
> This makes it very difficult to track the changes between branches.
>
> Since there are several other developers and sub-maintainers in this
> project which are rebased on both these branches, I don't want to
> change the git history of my branches because when I do that,
> sub-maintainers and developers lose the reference to their base.
>
> I'm looking for a better solution. Is there any best-practice  
> solution?

Off the top of my head, store each patch in its own branch, based off  
of a commit common to both branch_1 and branch_2.  Then merge patch  
branches into release branches as appropriate.  You might consider  
also doing this for patches unique to a release, not just the common  
ones.

Josh
