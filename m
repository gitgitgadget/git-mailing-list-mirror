From: Stephen Bash <bash@genarts.com>
Subject: Re: Tags, Grafts, and Clones, oh my!
Date: Fri, 20 Aug 2010 10:40:50 -0400 (EDT)
Message-ID: <5054888.117464.1282315250235.JavaMail.root@mail.hq.genarts.com>
References: <20100820133925.GE9448@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 20 16:41:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmSmF-0006ea-D0
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 16:41:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752790Ab0HTOk6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 10:40:58 -0400
Received: from hq.genarts.com ([173.9.65.1]:60641 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752665Ab0HTOk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 10:40:57 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 70FC11E268F1;
	Fri, 20 Aug 2010 10:40:56 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6ZjLNcAbpESj; Fri, 20 Aug 2010 10:40:50 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id 50D921E2635E;
	Fri, 20 Aug 2010 10:40:50 -0400 (EDT)
In-Reply-To: <20100820133925.GE9448@kytes>
X-Mailer: Zimbra 6.0.7_GA_2473.UBUNTU8 (ZimbraWebClient - SAF3 (Mac)/6.0.7_GA_2473.UBUNTU8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154045>

> Thanks for the testcase! Offhand, it definitely looks like a bug. I'm
> investigating to figure out which part of the chain is at fault.

No problem.  I was very happily to isolate it outside the large repo I was working with...

Contrary to my first e-mail, 'git checkout -b branchFoo tagFoo' doesn't solve the problem...  My guess is I got lazy and did a "normal" local clone (no file URL) when I was testing.

Data from further testing:
  - doing a "normal" local clone doesn't emit the error
  - a remote clone over ssh does emit the error (so it's not just file:///)
  - in a brand new repo (init'ed, not cloned) 'git fetch ../foo refs/tags/tagFoo:refs/tags/tagFoo' fails:
      error: unable to find 28fffee... (sha of tag object)
  - in a brand new repo 'git fetch ../foo refs/heads/branchFoo:ref/heads/branchFoo' succeeds, and correctly fetches tagFoo  (where branchFoo is created via 'git checkout -b branchFoo tagFoo')


Thanks,
Stephen
