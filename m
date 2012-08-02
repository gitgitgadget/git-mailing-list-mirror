From: Chris Webb <chris@arachsys.com>
Subject: Re: Cherry-picking commits with empty messages
Date: Thu, 2 Aug 2012 09:55:59 +0100
Message-ID: <20120802085554.GI19416@arachsys.com>
References: <20120801111658.GA21272@arachsys.com>
 <7vd33afqjh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Neil Horman <nhorman@tuxdriver.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 10:56:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwrCb-0002ma-OA
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 10:56:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753535Ab2HBI4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 04:56:10 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:48795 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049Ab2HBI4G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 04:56:06 -0400
Received: from [81.2.114.212] (helo=arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.72)
	(envelope-from <chris@arachsys.com>)
	id 1SwrCP-0000W1-2T; Thu, 02 Aug 2012 09:56:05 +0100
Content-Disposition: inline
In-Reply-To: <7vd33afqjh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202746>

Junio C Hamano <gitster@pobox.com> writes:

> My recommendation, backed by the above line of thought, is to add
> support for the "--allow-empty-message" option to both "rebase [-i]"
> and "cherry-pick", defaulting to false.

Thanks for the very detailed analysis and advice Junio. I like your
suggested --allow-empty-message option for cherry-pick because it's
consistent with the same option in standard commit, and doesn't change the
behaviour for existing users who might rely on cherry-pick catching blank
messages.

With rebase -i, the fix might be slightly more involved than just passing
through --allow-empty-message (if given) to cherry-pick, especially given
that sometimes we git cherry-pick -n && git commit --allow-empty-message,
and at other times we do standard git cherry-pick which refuses to pick a
commit without a message.

Given a history with empty commits, as a general principle it feels like it
should be possible to edit or reword those commits to make them non-empty
without giving --allow-empty-message, but that to generate new history
containing empty messages, --allow-empty-message should be required, whether
to commit [--amend] during rebase, or to the rebase -i command itself.

Cheers,

Chris.
