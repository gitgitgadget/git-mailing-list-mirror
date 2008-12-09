From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: Forcing --no-ff on pull
Date: Tue, 09 Dec 2008 19:17:04 +0900
Message-ID: <20081209191704.6117@nanako3.lavabit.com>
References: <1228815240.18611.48.camel@starfruit.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Tue Dec 09 11:19:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9zgN-0002hc-Ls
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 11:19:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752356AbYLIKRy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 05:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752591AbYLIKRy
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 05:17:54 -0500
Received: from karen.lavabit.com ([72.249.41.33]:36767 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752273AbYLIKRx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 05:17:53 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 1E6C2C869F;
	Tue,  9 Dec 2008 04:17:53 -0600 (CST)
Received: from 9253.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id RC7XF7PGTXOH; Tue, 09 Dec 2008 04:17:53 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=QqsfRxqKXhG+VBYTAVIweUzE1CPEYQ3jBu3hBpR8fFfxsT5cGJVWUu430Z91R1rsUgVjfcEIdnFhy6G3U65o1iMUjFR4Q5bxbLvF3F6oz1Cz7s9R9CezN0tyNVxd7LESxLx+zHRvkLptbSMbw3uxXyVK1M/1K7AcWCdhOVg5uhI=;
  h=From:To:Cc:Subject:Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <1228815240.18611.48.camel@starfruit.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102621>

Quoting "R. Tyler Ballance" <tyler@slide.com>:

> The most common use-case involves a user merging a project branch into a
> stabilization branch (`git checkout stable && git pull . project`) in
> such a way that no merge commit is generated. Of course, without
> thinking they'll push these changes up to the centralized repository.
> Not 15 minutes later they realize "ruh roh! I didn't want to do that"

Why does the user not want to fast-forward, if the merge she wants to do is actually a fast-forward?

If you mean that the user merged branches in a wrong direction, how does it help her avoid such a mistake to unconditionally forbid fast-forward merges?  Doesn't people often do:

 Start on a topic branch, have a potentially bright idea...
 % git checkout -b experiment
 Hack on experiment branch.
 Happy because it indeed was an excellent idea.
 % git checkout topic
 % git pull . experiment
 % git branch -d experiement

If you forbid fast-forward merges, when they merge their successful experiment back to the original topic, it will leave an unwanted merge in the history.

In other words, I do not think --no-ff is a right solution for the problem you are trying to solve.  Perhaps you would need a hook that prevents a merge from certain direction from taking place instead?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
