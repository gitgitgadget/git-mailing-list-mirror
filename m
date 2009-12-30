From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: Question about 'branch -d' safety
Date: Wed, 30 Dec 2009 12:12:38 +0900
Message-ID: <20091230121238.6117@nanako3.lavabit.com>
References: <20091230065442.6117@nanako3.lavabit.com> <20091229223123.GA12965@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Wed Dec 30 04:13:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPozq-0004sc-W8
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 04:13:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800AbZL3DNK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 22:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751794AbZL3DNJ
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 22:13:09 -0500
Received: from karen.lavabit.com ([72.249.41.33]:39598 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751524AbZL3DNJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 22:13:09 -0500
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id CB18911B89A;
	Tue, 29 Dec 2009 21:13:07 -0600 (CST)
Received: from 9683.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id 7IJI8GIBULZQ; Tue, 29 Dec 2009 21:13:07 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=MXzO4DmvO5PNLpHWKiOXUrqVfGBJktKm5M0fQ5OhLo0xwhEBxYC3o2KD/qM5Z4GGT8Ugoq/hpGYjs9mbT0DhnKt0doGCdc8NWkoIro81b2+GoqjuulqfC8jn7altqisHCohU2n2SQT6/EChBWgBoZehl1CFwT0rFB62A8VkGdaU=;
  h=From:To:Cc:Subject:X-Draft-From:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Message-Id;
X-Draft-From: ("nntp+news.gmane.org:gmane.comp.version-control.git" 135841)
In-Reply-To: <20091229223123.GA12965@vidovic>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135850>

Quoting Nicolas Sebrecht <nicolas.s.dev@gmx.fr>

> The 30/12/09, Nanako Shiraishi wrote:
>
>> I think the safety feature should check if the branch to be deleted is merged to the remote tracking branch it was forked from, instead of checking the current branch.
>> 
>> What do you think?
>
> I think we shouldn't. At first, every repository don't have a remote.
> This may easily be passed by a "double check" with a logical OR between
> the two statements.

Sorry, I was unclear. What I meant was that checking with the branch the branch to be deleted was forked from, if and only if such a branch exists. Otherwise, we can keep using the old default behavior to check with the current branch.

> But even with it, we would hit some foreign workflow. Think: Bob
> directly push to Alice and Alice does the same to Bob. I don't use this
> kind of workflow myself but I consider them to be sensible enough to
> have our attention.

Here is what I think about your scenario.

Bob directly pushes to Alice and Alice does the same to Bob, both to their refs/remotes/<other person>/ tracking branches, and their own local branches fork from the remote tracking branches that keep track of other person's work. You would still want the check based on that tracking branch, not based on 'master' that has no relationship with the branches they are exchanging.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
