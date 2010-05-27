From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git fast-export/fast-import *facepalm*
Date: Thu, 27 May 2010 17:19:58 -0400
Message-ID: <AANLkTimgh-1u9_p9SzB6DlP_gPDBiPJZkg-Hjvpq0eCM@mail.gmail.com>
References: <AANLkTinV5mEACphA-nW9URce0Mh9xyu3UjWmfBqL6cLN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 27 23:26:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHkbF-0007A1-PV
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 23:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932551Ab0E0V0l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 17:26:41 -0400
Received: from mail-yw0-f198.google.com ([209.85.211.198]:43815 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932556Ab0E0V0k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 17:26:40 -0400
Received: by ywh36 with SMTP id 36so134234ywh.4
        for <git@vger.kernel.org>; Thu, 27 May 2010 14:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=bxJ/0VovLu8qLHrwUeO0XJ5M6wQqo33yC9U5AIq/lKY=;
        b=c9PznaaTq11s4YuirJROTFXg/sB/CjWFtwdVXeuTYXN9IvUqdnCztU6YYJhplLCkXT
         kf1srsmZ1/Y6suya+dLYn8/ONF/+naomIu0u6rRE6h89sPW6U1aSyVNg8SUo1cORRonT
         rqnsNREn75CE6KCjrQJK4fxywap126E9oWU74=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=WOSAKPPIFrvegTF4pq10nAPqGxqokj4LRnYArM0P1MMWTYgMrR+Ms9M4uzksZq/9UQ
         d0xRPnxYgoysYMGx+ixecKcFekIY35zPKvGQ6qaaf+l4avkvoEHZ8CINM0UX+Q8BIar+
         R59R/Z8xy8i21F0khl9pb6UXQn64kwTRNHTkE=
Received: by 10.150.250.17 with SMTP id x17mr566771ybh.264.1274995219309; Thu, 
	27 May 2010 14:20:19 -0700 (PDT)
Received: by 10.231.59.207 with HTTP; Thu, 27 May 2010 14:19:58 -0700 (PDT)
In-Reply-To: <AANLkTinV5mEACphA-nW9URce0Mh9xyu3UjWmfBqL6cLN@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147900>

On Thu, May 27, 2010 at 4:46 PM, Chris Packham <judge.packham@gmail.com> wrote:
> My brain melt came when I wanted to get the set of changes between 2
> versions from a public branch and import them into our repository.
> Having just learned about git fast-export I decided that it was the
> right tool for the job so I did the following
>
> (cd linux-2.6.32.y; git fast-export v2.6.32.12..v2.6.32.14) | git fast-import

Personally what I would do is use git rebase instead:

# WARNING: untested.  back up your repo first!
cd my-repo
git fetch ../linux-2.6.32.y v2.6.32.14
git branch b FETCH_HEAD
git fetch ../linux-2.6.32.y v2.6.32.12
git branch a FETCH_HEAD
git checkout b
git rebase --onto master a
# now your branch b should be master + the patches from a..b

> Which I'll give a try in a minute. In the meantime is there anyway for
> me to safely remove the upstream linux commits without loosing our
> commits in the process?

Looks like Shawn answered this question.  In any case, the answer is git-reset.

Have fun,

Avery
