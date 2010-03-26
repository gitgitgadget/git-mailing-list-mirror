From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Rebasing with merges and conflict resolutions
Date: Fri, 26 Mar 2010 08:02:44 +0100
Message-ID: <4BAC5C14.4060903@viscovery.net>
References: <20100326031111.GB27737@kiwi.sharlinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "R. Tyler Ballance" <tyler@monkeypox.org>
X-From: git-owner@vger.kernel.org Fri Mar 26 08:02:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nv3ZE-0001fM-Vf
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 08:02:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842Ab0CZHCr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 03:02:47 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:62743 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750795Ab0CZHCq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 03:02:46 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Nv3Z6-0002eA-My; Fri, 26 Mar 2010 08:02:45 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 73E9F1660F;
	Fri, 26 Mar 2010 08:02:44 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <20100326031111.GB27737@kiwi.sharlinx.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143215>

Please don't set Mail-Followup-To on this list.

Am 3/26/2010 4:11, schrieb R. Tyler Ballance:
> Two contributors worked in tandem on a particular project, constantly merging
> back and forth between each other creating a history of 118 commits total with
> 37 of them being merge commits, 7 of those merge commits having conflict
> resolutions involved.
> 
> I would /like/ to rebase those into a more linear revision history, but I
> can't seem to find any set of commands that doesn't have me:
>    a) Manually re-doing every conflict resolution and merge (git rebase -p master)
>    b) Drastically diverging from the original topic branch and entering some
>       sort of mergeless hell (git rebase master)

I'm afraid you can't avoid the merge conflict resolutions. But you can let
you help by git-rerere. Look into the script rerere-train.sh that lets you
prime your rerere database.

http://repo.or.cz/w/alt-git.git/blob_plain/master:/contrib/rerere-train.sh

> Is it even possible to straighten this out without a massive rework of these
> commits?

I would sort the commits into topics and then repeatedly rebase -i the
history involved onto the same commit, each time removing those commits
that do not belong to the topic. That is, you get a forest of topics
sprouting from the same commit. Finally, merge the topics back together.

IOW, I wouldn't aim at a completely linear history, at least not at the
first try.

> In the future, is there a better way for two developers to work in the same
> back-and-forth fashion (code ping pong!) without leading to *heavily* merged
> histories that are unpossible to untangle?

Discipline. Keep developers focused on their topic. Merge only after a
topic is completed. Do not give in to "oh, *your* feature is cool, *I*
want to have it now, so I merge it".

-- Hannes
