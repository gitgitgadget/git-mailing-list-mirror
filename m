From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 5/6] status: do not depend on flaky reflog messages
Date: Fri, 14 Jun 2013 19:31:30 +0530
Message-ID: <CALkWK0k28u583Jci+Dvad1pbu7_dJdnmz1WBkP790a_t2QdPTg@mail.gmail.com>
References: <1371130349-30651-1-git-send-email-artagnon@gmail.com>
 <1371130349-30651-6-git-send-email-artagnon@gmail.com> <7vvc5hubox.fsf@alter.siamese.dyndns.org>
 <CALkWK0kjxKFkrLArL1mLZYCMN1=sgnDSa3vaoJm6eSUp2E4Pyw@mail.gmail.com>
 <7vd2rpu3kf.fsf@alter.siamese.dyndns.org> <CALkWK0=NAiGDVWbwHXMmEffPF9wKXd23BdwOntfdvNCpVe8fiA@mail.gmail.com>
 <7vppvosstl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 16:02:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnUa6-0000Hh-DF
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 16:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434Ab3FNOCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 10:02:18 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:58303 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930Ab3FNOCR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 10:02:17 -0400
Received: by mail-ie0-f179.google.com with SMTP id c10so1501846ieb.38
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 07:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=BJH2neAHoePMYWINGyb6PIJb8DM3ac1+QXAB63iPFyY=;
        b=mIqZCUv+Z9CzVsxJZzre9JotHgzsjdx98s1rldbRUlAdbVcVSk8IAgJlr8FU9EFD6l
         DgHSO0r47Vf/u3ed6GmGokbE3RgrtoKXoeS4YmogSPBV6TCzfQplUsfaPwLhI3Svq8ps
         +0C8bazvQYoiEBbaGmrYfXXiKTGA1x1vpzcCsPspJdcY6rAndG4CXRyZEmx3MbH7oMWP
         gthb+LRnh4zxHKz23AkC+kXM12Lhd34o7KKhfSGIsOG4sz0nV7WdKt85Oje15iP0Li15
         7uyFevAW/Xk4WjtAbLt+pySQlwCztu7aHjqXG7YgvnhEoOM6f8moPaj76+7LU2BLXZSE
         inCA==
X-Received: by 10.50.18.80 with SMTP id u16mr1114868igd.13.1371218530185; Fri,
 14 Jun 2013 07:02:10 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Fri, 14 Jun 2013 07:01:30 -0700 (PDT)
In-Reply-To: <7vppvosstl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227873>

Junio C Hamano wrote:
> The part you stripped from your quote looked like this:

Apologies for the lack of clarity.

>>> You were at 1.8.2 but no longer are, so in the following sequence:
>>>
>>>     $ git checkout v1.8.2
>>>     $ git status
>>>     $ git reset --hard HEAD^
>>>     $ git status
>>>
>>> the former would say "detached at v1.8.2" while the latter should
>>> *not*, because we are no longer at v1.8.2.  "detached from v1.8.2"
>>> is too subtle a way to express the state, and is confusing, but I
>>> would not be surprised if people find it useful to be able to learn
>>> "v1.8.2" even after you strayed away.
>
> And your justification to make the latter "git status" to say "Not
> on any branch" instead of "detached from" was "what is wrong with
> describe".

In this example, it is inconsequential whether I run:

  $ git checkout v1.8.2^

or:

  $ git checkout v1.8.2
  $ git reset --hard @^

as far as describe is concerned.  It will give me the same good
consistent answer in either case.

> The user used "checkout" to detach the HEAD, and the user stayed in
> that detached state and jumped around.  Where is this "without using
> checkout" coming from?

The point I was trying to make is:

  $ git checkout v1.8.2
  $ git checkout @^

will give a different result once again.  As the end-user, I use
checkout to inspect detached HEAD states, and reset to update
worktree/refs.

Did my response to your examples make sense?  Are you convinced that
this feature should be removed yet?
