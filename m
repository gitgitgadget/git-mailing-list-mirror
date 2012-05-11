From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Equivalent of "fixup" for git filter-branch
Date: Fri, 11 May 2012 14:51:58 +0200
Message-ID: <m2havmop75.fsf@igel.home>
References: <CAGK7Mr5D0WQn-Tc1B5=F7+3OgZd1uy54Be-ZrbyFv0CP8JY5bw@mail.gmail.com>
	<m21umsylz8.fsf@igel.home>
	<CAGK7Mr7qdTwfha8aUdXE4FeXjA0rW3JL0q=a9kHArirjv5bygg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Philippe Vaucher <philippe.vaucher@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 11 14:52:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSpKL-0007s0-Nk
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 14:52:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758447Ab2EKMwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 May 2012 08:52:05 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:58612 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623Ab2EKMwD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2012 08:52:03 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3VprmH4J6tz4Kh0m;
	Fri, 11 May 2012 14:51:59 +0200 (CEST)
Received: from igel.home (ppp-93-104-149-188.dynamic.mnet-online.de [93.104.149.188])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3VprmH3VzDz4KK79;
	Fri, 11 May 2012 14:51:59 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 0C0C6CA29F; Fri, 11 May 2012 14:51:59 +0200 (CEST)
X-Yow: We just joined the civil hair patrol!
In-Reply-To: <CAGK7Mr7qdTwfha8aUdXE4FeXjA0rW3JL0q=a9kHArirjv5bygg@mail.gmail.com>
	(Philippe Vaucher's message of "Fri, 11 May 2012 14:32:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.96 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197673>

Philippe Vaucher <philippe.vaucher@gmail.com> writes:

>>
>> > I know there is `skip_commit` for git filter branch with
>> > --commit-filter which squash the current commit with the next one,
>> > however I have trouble finding a "fixup" equivalent that'd squash the
>> > commit with the previous one (just like git rebase -i allows).
>>
>> Probably doable with an index filter that updates the index for the
>> parent commit with the contents of the fixup commit and a commit filter
>> that skips the fixup commit.
>
>
> Hum, I'm unsure about how this would look... can I use "git commit --amend"
> inside a commit-filter?

I don't think that will work if the amended commit has more than one
children, since the result won't be reflected in the map function.

> Also, how can I know in advance that the next commit will be a fixup commit?

In the index filter, when $GIT_COMMIT equals the parent of the fixup
commit, update the index with git read-tree from the fixup commit.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
