From: linux@horizon.com
Subject: Re: How to do a reverse rebase?
Date: 20 Aug 2007 06:39:43 -0400
Message-ID: <20070820103943.6046.qmail@science.horizon.com>
References: <20070820055809.GZ27913@spearce.org>
Cc: git@vger.kernel.org
To: linux@horizon.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Aug 20 12:39:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN4fr-0005Tz-KJ
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 12:39:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752391AbXHTKjw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 06:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751779AbXHTKjw
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 06:39:52 -0400
Received: from science.horizon.com ([192.35.100.1]:19605 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751503AbXHTKjv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 06:39:51 -0400
Received: (qmail 6047 invoked by uid 1000); 20 Aug 2007 06:39:43 -0400
In-Reply-To: <20070820055809.GZ27913@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56207>

> I don't think so.  To do the merge of those files we need a working
> directory to operate in; that working directory is the one you have.
> It sounds like what you want is this:

>	old=`git symbolic-ref HEAD` &&
>	git checkout HEAD^0 &&
>	git cherry-pick debug_hack &&
>	git branch -f debug_hack HEAD &&
>	git checkout $old

Er, actually, I don't want the messing about with $old.
At the end of the day, I want to be on the tip of the rebased
work.

The problem is that git-cherry-pick only oves a single comit,
so if I have a stack, it's annoying.

It's more like:
	git checkout HEAD^0 &&
	for i in `git-rev-list --reverse ..debug_hack`; do
		git-cherry-pick $i
	done &&
	git branch -D debug_hack &&
	git checkout -b debug_hack
