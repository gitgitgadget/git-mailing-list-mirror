From: "Elijah Newren" <newren@gmail.com>
Subject: Re: RFC: perhaps a "new file" should not be deleted by "git reset --hard"
Date: Wed, 10 Sep 2008 20:38:13 -0600
Message-ID: <51419b2c0809101938v30e5a1aflf944027aedc2d900@mail.gmail.com>
References: <279b37b20809101212g57e9ad99qbf6fa15888679894@mail.gmail.com>
	 <eafc0afe0809101912v72916d3hce9ae5d6812f0db8@mail.gmail.com>
	 <eafc0afe0809101914lff5b23ehaf625d702fbd9b5d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Eric Raible" <raible@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Changsheng Jiang" <jiangzuoyan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 04:39:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kdc5b-0005ci-5g
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 04:39:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752226AbYIKCiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 22:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752187AbYIKCiO
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 22:38:14 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:24785 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186AbYIKCiN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 22:38:13 -0400
Received: by rv-out-0506.google.com with SMTP id k40so139855rvb.1
        for <git@vger.kernel.org>; Wed, 10 Sep 2008 19:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=S7nWsX3U76lokBppsySfnIlcH0J+5xjJE4GWZju6FLg=;
        b=Ziuy4QzVSuqta30bTEMMUoFzcC3Q4TOw31lEymz/3qxJRHcdaumVjL8AR9cZesKrnT
         wL6+qyeukbqdsfbib/2vkDcpNApcldnF+vx7RhP5E+jIdnONpdmndILFe5K74ErHGvco
         nwOzgLIAWuCwD0Pf9JnMfGC1cQRlqlvkd3eK0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=e0/Z4oZvZ8d/dpSnkxdcDj/ZHpJDU6rWx0xSkOX8lfo88QKzDwVUmeDU3pBRLHZUjC
         tM7gyra4uUCPPQe8Ccna6hbQkcDDEDwscSSjKzC/YFaeJLsb2/zfU56R7sNSePDZhVtD
         ZXvs0127Vz0i1XZ3swe9c0W9ZquXKn3ToOM/8=
Received: by 10.141.83.15 with SMTP id k15mr1313106rvl.289.1221100693194;
        Wed, 10 Sep 2008 19:38:13 -0700 (PDT)
Received: by 10.141.163.16 with HTTP; Wed, 10 Sep 2008 19:38:13 -0700 (PDT)
In-Reply-To: <eafc0afe0809101914lff5b23ehaf625d702fbd9b5d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95574>

On Wed, Sep 10, 2008 at 8:14 PM, Changsheng Jiang <jiangzuoyan@gmail.com> wrote:
> I think the current behavior is better than you described. If you want
> to ignore some files, you can added it to the exclude file. All files
> not excluded in the repo directory is maintained by git.

No, there's a limbo state -- the "untracked" files shown by git status
(which is the default state; these are files that have not been
explicitly requested to be ignored or be tracked).  Note the quote
from Linus at the beginning of Eric's email that specifically
references this.

Anyway, Eric wasn't really talking about ignoring files, since he was
explicitly adding them for the next commit.  It's just that at some
point he changed his mind and decided he didn't want to include any of
the changes he had already made in the next commit, but was surprised
when git reset --hard deleted the files from both the index and
working copy instead of just the index.  git reset --hard really is
meant for throwing away unwanted stuff (particularly including in the
working directory), but I can see how he may have expected behavior
more along the lines of git rm --cached for those particular files.  I
don't agree with that viewpoint (I see files as tracked as soon as you
stage it, not once you commit it), but I can see where the expectation
comes from.

Just my thoughts,
Elijah
