From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 3/6] branch: teach --edit-description option
Date: Fri, 23 Sep 2011 11:00:47 +0200
Message-ID: <4E7C4ABF.1020804@drmicha.warpmail.net>
References: <7vy5xi4y3m.fsf@alter.siamese.dyndns.org> <1316729362-7714-1-git-send-email-gitster@pobox.com> <1316729362-7714-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 11:55:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R72U0-0007qR-09
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 11:55:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752861Ab1IWJzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 05:55:43 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:43026 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752734Ab1IWJzm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Sep 2011 05:55:42 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway2.nyi.mail.srv.osa (Postfix) with ESMTP id 63C1E2BA1D;
	Fri, 23 Sep 2011 05:54:37 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 23 Sep 2011 05:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=YioR3kzsvuDbPRZQsVaYtv
	XkSL8=; b=CF5435zDJNBH0dAlKUljKG2DtuhMo8IT4KqF/o3YCB/j5mYqyrJLCG
	/utSnIquzewMAkssWtGB1UkUesIlzNZLYXp6wu2iB/LUd8AZIsFax6YgvVzQWcV3
	LPS8ZT6pXc4eGKaD+P9BO3IZvL7M2UUU1woK6TLm/ZEFyOsPGfJbU=
X-Sasl-enc: peW07R3VkfsIlDpTfnv8tfd+PgxqPOC80r5p2dDadQmj 1316768449
Received: from localhost.localdomain (p5485951A.dip0.t-ipconnect.de [84.133.149.26])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 280C1820A1C;
	Fri, 23 Sep 2011 05:00:49 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0.2) Gecko/20110906 Thunderbird/6.0.2
In-Reply-To: <1316729362-7714-4-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181954>

Junio C Hamano venit, vidit, dixit 23.09.2011 00:09:
> Using branch.$name.description as the configuration key, give users a
> place to write about what the purpose of the branch is and things like
> that, so that various subsystems, e.g. "push -s", "request-pull", and
> "format-patch --cover-letter", can later be taught to use this
> information.
> 
> The "-m" option similar to "commit/tag" is deliberately omitted, as the
> whole point of branch description is about giving descriptive information
> (the name of the branch itself is a better place for information that fits
> on a single-line).

I don't think that is the only reason why we should not make "git branch
-m foo bar" set the description "foo" for branch "bar"...

Granted, your argument applies to "--set-description" ("-m"-like) also.

Michael

> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git-branch.txt |    5 +++
>  builtin/branch.c             |   56 ++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 59 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> index 507b8d0..8871a4e 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -14,6 +14,7 @@ SYNOPSIS
>  'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branchname> [<start-point>]
>  'git branch' (-m | -M) [<oldbranch>] <newbranch>

;)

>  'git branch' (-d | -D) [-r] <branchname>...
> +'git branch' --edit-description [<branchname>]
