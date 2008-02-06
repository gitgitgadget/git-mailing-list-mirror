From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] allow setting GIT_WORK_TREE to "no work tree"
Date: Wed, 06 Feb 2008 11:42:15 +0100
Message-ID: <47A98F07.4000402@viscovery.net>
References: <20080206102608.GA1007@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 06 11:42:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMhjw-0000n0-AD
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 11:42:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753778AbYBFKmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 05:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754057AbYBFKmT
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 05:42:19 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:31221 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753061AbYBFKmS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 05:42:18 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JMhj1-0000ex-Nt; Wed, 06 Feb 2008 11:41:56 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 1FAB76B7; Wed,  6 Feb 2008 11:42:15 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080206102608.GA1007@coredump.intra.peff.net>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72796>

Jeff King schrieb:
> In setup_git_directory_gently, we have a special rule
> that says "if GIT_DIR is set but GIT_WORK_TREE is not, then
> use the current working directory as the work tree." This is
> the intended behavior for the user perspective.
> 
> However, setup_git_directory_gently sets GIT_DIR itself,
> meaning that further setups (either because we are executing
> a command via alias, or in a subprocess) will see the
> non-existent GIT_WORK_TREE and assume we fall into the
> "current working directory is the working tree" codepath.
> 
> Instead, we now use a special value of GIT_WORK_TREE to
> indicate that we have already checked for a worktree and
> that there isn't one, setting it when we set GIT_DIR and
> checking for it in the special case path.
> 
> The special value is a blank GIT_WORK_TREE; it could be any
> value, but this should not conflict with any user values
> (and as a bonus, you can now tell git "I don't have a work
> tree" with "GIT_WORK_TREE= git", though I suspect the use
> case for that is limited).

Hrm. Unfortunately, on Windows there is no such thing as an empty
environment string. setenv(x, "") *removes* the environment variable.

-- Hannes
