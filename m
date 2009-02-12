From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] stash: --keep option just saves
Date: Thu, 12 Feb 2009 13:04:48 -0800
Message-ID: <7vskmjjrin.fsf@gitster.siamese.dyndns.org>
References: <20090212062514.6117@nanako3.lavabit.com>
 <7vljscbp60.fsf@gitster.siamese.dyndns.org>
 <20090212171732.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 22:06:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXilL-0000Wo-Og
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 22:06:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758683AbZBLVE4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 16:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756637AbZBLVE4
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 16:04:56 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43729 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776AbZBLVEz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 16:04:55 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 447BC99EDA;
	Thu, 12 Feb 2009 16:04:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id AF43099ED9; Thu,
 12 Feb 2009 16:04:50 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CBC35DCE-F948-11DD-BF73-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109654>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> I'm sorry. I didn't think about such a negative aspect of adding the
> feature.

No need to be sorry about anything, please.  Nobody has to apologise after
trying a constructive contribution to solve a perceived problem.

> I can imagine that, after using many 'stash save --keep', I'll naturally
> want to manipulate changes between kept stashes, like running 'git log'
> to view the difference between each step and cherry-picking a change
> between ones next to each other etc. Because a list of stashes doesn't
> support such operations, additional support for them is needed to make
> it useful, but I agree with you that such additions are not real
> features that are necessary, because git already supports these
> operations if I used commits on a normal branch instead. Use of 'stash
> save --keep' is making it necessary to implement duplicated features for
> no good reason.

That was exactly my point.  "save --keep" (or --no-reset) might look as if
it is a new convenience feature, but you will realize that it really is
not, once you think things through.  It is not new because there already
is a way meant to be used to snapshot before going forward (i.e. regular
commits on a private branch for experiment), and it is not convenient
because its results cannot be used as flexibly with existing tools as the
results by the other, existing approach.

It can be argued that it adds one huge convenience.  It is quicker to say
'git stash save --keep' than 'git commit -a -m "WIP as of $(date)"', and
in addition, you first have to do a "checkout -b wip" once, if you use the
approach with regular commits on a exprimental branch forked from the
target branch, instead of the approach with regular commits directly on
the target branch.

But if that convenience is the real motivation behind it, adding an option
"git commit --snap" that runs 'git commit -a -m "WIP as of $(date)"' would
be a far more superiour solution that does not have the problem of feature
duplication (and no, please do not suggest "git alias snap ..."; the point
is to make it easy to do this for *everybody* out of the box).

> It may also confuse users by unnecessarily adding another way to do the
> same thing.

I actually did not think of that issue, but you may be right.

>> This topic won't go beyond 'next' during this round because it started way
>> after -rc0 was tagged.  It is not urgent to decide what will happen to the
>> recent "snapshot" related topics, and we have plenty of time to toss ideas
>> around, but currently I have to say that I am not very enthused about any
>> of the causes mentioned in various discussion threads.
>
> You already applied my patch on pu branch. It's OK by me if you dropped it.

Rather, lets let a hundred flowers blossom and see what happens.  I will
promise it will not be followed by a purge ;-).
