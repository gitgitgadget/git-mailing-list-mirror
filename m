From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: What's cooking in git.git (Apr 2011, #01; Sun, 3)
Date: Mon, 04 Apr 2011 12:40:35 +0200
Message-ID: <4D99A023.1090102@drmicha.warpmail.net>
References: <7v62quc464.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 12:44:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6hGb-0007mg-41
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 12:44:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754547Ab1DDKoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 06:44:11 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:35301 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754487Ab1DDKoK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Apr 2011 06:44:10 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id E51CC20309;
	Mon,  4 Apr 2011 06:44:09 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 04 Apr 2011 06:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=IKfq5q0NibHz9jXY82fQzFqm1Vg=; b=hPw3JHD7S/fxneIWYx+ySJyD/S1fDy3IOn0dSaO13nmeB3l3ygsvp2EOIp6uwuOyKzZpuoExOFYVEWK9DDAWFiXToVgPiIzqD9D8eN9rgRGOcmNz3nVK3ZAVW5yJC70DOWEqsY+wS2ttBOgfF6rhbHu+RXoU1VnsYBRhvirSuY8=
X-Sasl-enc: YiXO5IFsWkop3xDm44Cfm6pdruKmXcI96uLbPwc78tqK 1301913849
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 61966442AD5;
	Mon,  4 Apr 2011 06:44:09 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <7v62quc464.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170802>

Junio C Hamano venit, vidit, dixit 04.04.2011 01:21:
> Here are the topics that have been cooking.  Commits prefixed with '-' are
> only in 'pu' while commits prefixed with '+' are in 'next'.
> 
> Hopefully we will have 1.7.5-rc1 coming Wednesday.
> 
> --------------------------------------------------
> [New Topics]
> * jc/rev-list-options-fix (2011-04-01) 1 commit
>   (merged to 'next' on 2011-04-03 at 91f19de)
>  + "log --cherry-pick" documentation regression fix
> 
> We should merge this before -rc1, but there might be other similar
> breakages in the text flow due to the same f98fd43 (git-log.txt,
> rev-list-options.txt: put option blocks in proper order, 2011-03-08).

I rechecked and didn't find any other mis-references. Some commit
limiting options mention commit formatters like "--pretty", but I deem
that to be okay without an explicit "see below".


> * mg/doc-revisions-txt (2011-04-01) 3 commits
>  - revisions.txt: language improvements
>  - revisions.txt: structure with a labelled list
>  - revisions.txt: consistent use of quotes
> 
> Most parts looked reasonable except for some nits.

Should I resubmit or have you squashed that in already?

> 
> * mg/reflog-with-options (2011-04-01) 3 commits
>   (merged to 'next' on 2011-04-03 at e69a95c)
>  + reflog: fix overriding of command line options
>  + t/t1411: test reflog with formats
>  + builtin/log.c: separate default and setup of cmd_log_init()
>  (this branch is used by mg/show-without-prune.)
> 
> Reasonable, but can wait.

Well, can be considered bugfix, but not a regression fix.

> 
> * mg/show-without-prune (2011-04-01) 1 commit
>  - builtin/show: do not prune by pathspec
>  (this branch uses mg/reflog-with-options.)
> 
> I wanted to like this, but it still feels like too much magic.

...with a little less magic suggested now (act on single no-walk rev only).

> * mg/sha1-path-advise (2011-03-31) 2 commits
>  - sha1_name: Suggest commit:./file for path in subdir
>  - t1506: factor out test for "Did you mean..."
> 

Should I resubmit with "commit:./file" only, or is that too late anyways?

> --------------------------------------------------
> [Cooking]
> 
> * jc/diff-irreversible-delete (2011-02-28) 1 commit
>   (merged to 'next' on 2011-04-03 at 5a23b23)
>  + git diff -D: omit the preimage of deletes
> 
> Unstuck, thanks to Michael J Gruber.

and to Junio for taking up the sticks ;)

> * mg/grep-full-tree (2011-03-01) 2 commits
>  . grep: make --full-tree work with pathspecs
>  . grep: --full-tree
> 
> It would be preferable to use ":/" or whatever magic pathspec that is
> relative to the root of the working tree.

I think we can drop it, it's clear we're going for ":/" or the like, and
it's clear that won't be before 1.7.5.

Michael
