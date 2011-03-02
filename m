From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: [1.8.0] fix branch.autosetupmerge and branch.autosetuprebase
Date: Wed, 2 Mar 2011 08:30:00 +0100
Message-ID: <1jxhtdj.c6tsy3wnbmbjM%lists@haller-berlin.de>
References: <AANLkTi=Ei-Gr3=O0_dfaCekQ0+nB8v1kZYT7sTw-Ydm+@mail.gmail.com>
Cc: dustin@spy.net (Dustin Sallings)
To: jaysoffian@gmail.com (Jay Soffian), git@vger.kernel.org (git)
X-From: git-owner@vger.kernel.org Wed Mar 02 08:30:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PugVf-0008Ep-GN
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 08:30:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754000Ab1CBHaF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 02:30:05 -0500
Received: from mail.ableton.net ([62.96.12.117]:57202 "EHLO mail.ableton.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750881Ab1CBHaE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 02:30:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=haller-berlin.de; s=mail_2009081900;
	h=Message-ID:Date:From:Subject:In-Reply-To:Cc:To; bh=EYVYZ44gTxxl+4dAGgr+axcECtGuL0i51P+jKYAlgIg=;
	b=iTL6QxAtnBumy/z+r9PxDXXSUu3XSSOQEbAJSBUP6/m8o+IAuli6Jz/yhRY2zM7EM7aJ8u4wGKlvIAl1R3++j9IoOCWuGHCZeS+0N/67K1tBfR8aZnEKUz6PMt/KGY3YLvg3y8BN/cRhdRFRbIz7FoQyXvNR1YHwCq4o01JFz2U=;
Received: from dslb-088-074-017-003.pools.arcor-ip.net ([88.74.17.3] helo=[192.168.42.92])
	by mail.ableton.net with esmtpsa (SSLv3:AES128-SHA:128)
	(Exim 4.72)
	(envelope-from <lists@haller-berlin.de>)
	id 1PugVU-0007Mr-C8; Wed, 02 Mar 2011 08:30:00 +0100
In-Reply-To: <AANLkTi=Ei-Gr3=O0_dfaCekQ0+nB8v1kZYT7sTw-Ydm+@mail.gmail.com>
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.6.6 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168298>

Jay Soffian <jaysoffian@gmail.com> wrote:

> 99% of the time, I think you are doing one of the following:
> 
>   $ git branch topic origin/master    # 1
>   $ git branch topic master           # 2
>   $ git branch topic some_other_topic # 3
> 
> In the case of (1), you want origin/master to be configured as the
> upstream for topic. In the case of (2), even though you are starting
> at master, I'll bet you want the upstream to be origin/master. In the
> case of (3), even though you are starting at some_other_topic, I'll
> bet you want topic to have the same configured upstream as
> some_other_topic.

Where I work, none of these is true.  I guess these may be true for an
open-source kind of setup, where one developer is working on a branch
and then posts a patch series; however, in a corporate environment with
a central repository and multiple developers collaborating on a topic
branch, it's not.  Our workflow is to branch a topic from master (with
--no-track), push the topic to the central repository, others pull the
topic branch (with autosetuprebase=always) and contribute to it, and
eventually it is merged back to master.  We never want automatic
rebasing onto master for topics.

Which means that we only ever have upstream branches with the same name
as the local branch.  I haven't seen a single exception yet, and I wish
there was a way to set autosetupmerge to "only_if_name_matches" or some
such.

> 2. Deprecate branch.autosetuprebase. Pull's default action shouldn't
> be specified when the branch is created. Rather, add a "pull.rebase"
> boolean defaulting to false, and which is overridden per-branch by
> branch.<name>.rebase.

I like this part of the proposal though.


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
