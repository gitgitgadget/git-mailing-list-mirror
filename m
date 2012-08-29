From: Dan Johnson <computerdruid@gmail.com>
Subject: Re: [PATCH v2 1/3] teach log --no-walk=unsorted, which avoids sorting
Date: Wed, 29 Aug 2012 13:34:08 -0400
Message-ID: <CAPBPrnstykXxTEH56YFDqU2XW+o8WRKBN6=QOTpLJ1jRU7DXCA@mail.gmail.com>
References: <50289e50.8458320a.7d31.3c46SMTPIN_ADDED@gmr-mx.google.com>
	<1346220956-25034-1-git-send-email-martinvonz@gmail.com>
	<1346220956-25034-2-git-send-email-martinvonz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 29 19:34:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6m9h-0005Nu-EO
	for gcvg-git-2@plane.gmane.org; Wed, 29 Aug 2012 19:34:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753673Ab2H2ReL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Aug 2012 13:34:11 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:47551 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753324Ab2H2ReJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2012 13:34:09 -0400
Received: by eekc1 with SMTP id c1so354936eek.19
        for <git@vger.kernel.org>; Wed, 29 Aug 2012 10:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wtOzLnlGG8Q1Jsp4/t8tB3OdY9exhqyGIDN3PKn6sVU=;
        b=yWkjtEbhJNa49oSnb+4rGbH5IGCisfM8SSwyEK2sJ7J5eaHzLKi4Q5yFAQLZwaV2F9
         4IhIqLI6OUF8Ns6xbtLga7Zn0uqQNwfAveBvPxvAs5eO3YR3PXN1hExdUFAxHDWIiOPu
         aLnQN5tOZlhmacCi844dO7Z+cC2LDfhsZEJfS4ESXkfQYC6SjjyiQWQqPogzGrHtC2cB
         D8PQ3vzBQ9bOO6waG5jfMxu+CBcpUZrPIIgOBpE44yj6ChvhdrLrTrr1hNyDyR8tnn6N
         h/lEcWHOwVlLoPibaRgV6C3dekxTvtoXPDpD2oUGOkH5GP5SYsjUUxp1Y/9+EUvw+M3C
         jipQ==
Received: by 10.14.4.201 with SMTP id 49mr3038676eej.0.1346261648756; Wed, 29
 Aug 2012 10:34:08 -0700 (PDT)
Received: by 10.14.119.199 with HTTP; Wed, 29 Aug 2012 10:34:08 -0700 (PDT)
In-Reply-To: <1346220956-25034-2-git-send-email-martinvonz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204488>

On Wed, Aug 29, 2012 at 2:15 AM, Martin von Zweigbergk
<martinvonz@gmail.com> wrote:
> When 'git log' is passed the --no-walk option, no revision walk takes
> place, naturally. Perhaps somewhat surprisingly, however, the provided
> revisions still get sorted by commit date. So e.g 'git log --no-walk
> HEAD HEAD~1' and 'git log --no-walk HEAD~1 HEAD' give the same result
> (unless the two revisions share the commit date, in which case they
> will retain the order given on the command line). As the commit that
> introduced --no-walk (8e64006 (Teach revision machinery about
> --no-walk, 2007-07-24)) points out, the sorting is intentional, to
> allow things like
>
>  git log --abbrev-commit --pretty=oneline --decorate --all --no-walk
>
> to show all refs in order by commit date.
>
> But there are also other cases where the sorting is not wanted, such
> as
>
>  <command producing revisions in order> |
>        git log --oneline --no-walk --stdin
>
> To accomodate both cases, leave the decision of whether or not to sort
> up to the caller, by allowing --no-walk={sorted,unsorted}, defaulting
> to 'sorted' for backward-compatibility reasons.
>
> Signed-off-by: Martin von Zweigbergk <martinvonz@gmail.com>
> ---

Perhaps I am missing something from an earlier discussion, but it is
not obvious to me why this is an option to the no-walk behavior and
not something like --sorted/--unsorted as a separate option.

In other words, I don't understand why you always want to sort if you
are doing revision walking.

Thanks for any explanation,
-Dan
