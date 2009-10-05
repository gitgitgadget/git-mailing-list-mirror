From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "Not currently on any branch"
Date: Sun, 04 Oct 2009 21:19:09 -0700
Message-ID: <7vd452iibm.fsf@alter.siamese.dyndns.org>
References: <106990.92203.qm@web111508.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Timothy Washington <timothyjwashington@yahoo.ca>
X-From: git-owner@vger.kernel.org Mon Oct 05 06:24:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Muf7Y-0008WH-T1
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 06:24:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbZJEET7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 00:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbZJEET7
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 00:19:59 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43391 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842AbZJEET6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 00:19:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 522D36B4C8;
	Mon,  5 Oct 2009 00:19:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9KCdYR820QLpVXQnVIOwPt/LnUc=; b=ebio1p
	a2w4ydrfzGy6610gpoJwDj25aRpWIn8m+ApiZS5VfzrCjWNNU+e0km+Oh3VjYGzK
	enFikFG9fadUwkpYKch83Ko+NGctr0nZswBz6JTG8qlzrvH22XFrIlZ1G/EQJb9A
	tf0lTJpa/j4kf4nSVmOWpfZsg0E7Rhhj7KQ3I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yZ9il8VAw5aJbwrg0D/TaYIdj+8ayfuQ
	5WILTua777a1kmWPX01rsxzL5glYgYkAnDS91h6fG+O8rNm3gE2yvSipSt+JSPhM
	LF4sUsdyveWHCiMUIUF3LQD+U67JlAQxFIQED7sTUMbChgw1sun6bo3eIg5DDsxI
	ByfwfWtZ+7U=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 332C06B4C7;
	Mon,  5 Oct 2009 00:19:14 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F3F356B4C6; Mon,  5 Oct 2009
 00:19:10 -0400 (EDT)
In-Reply-To: <106990.92203.qm@web111508.mail.gq1.yahoo.com> (Timothy
 Washington's message of "Sun\, 4 Oct 2009 21\:01\:20 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3D578E62-B166-11DE-AFB3-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129528>

Timothy Washington <timothyjwashington@yahoo.ca> writes:

> Thanks for all the responses so far. But if you take a look at my repo
> (http://repo.or.cz/w/Bookkeeping.git), at the bottom of the page,
> there's clearly a 'ui-integration' branch. But if I try to go to my
> ui-integration branch, I get the message below. So I'm just clueless as
> to where it went. If use the -b option, then I'll create a new
> branch. But I don't want that. I want to keep all the data that was in
> my original 'ui-integration' branch.
>
> [timothyw] ~/Projects/Bookkeeping.4 $ git checkout ui-integration
> error: pathspec 'ui-integration' did not match any file(s) known to git.

I do not think it has anything to do with "Not currently on any branch",
but judging from this

> [remote "origin"]
>     url = http://repo.or.cz/r/Bookkeeping.git
>     fetch = +refs/heads/*:refs/remotes/origin/*

one possibility to see the above error message is to do this:

    $ git clone http://repo.or.cz/r/Bookkeeping.git
    $ cd Bookkeeping
    $ git checkout ui-integration
    error: pathspec 'ui-integration' did not match any file(s) known to git.

In a clone, your local branch namespace is not cluttered with all the
different branches your upstream repository has.  To wit:

    $ git branch
    * master
    $ git branch -a
    * master
      remotes/origin/HEAD -> origin/master
      remotes/origin/master
      remotes/origin/ui-integration

If you want to further work on the ui-integration topic, you would do
something like:

    $ git checkout -b ui-integration origin/ui-integration
    Branch ui-integration set up to track remote branch ui-integration from origin.
    Switched to a new branch 'ui-integration'
    $ git branch
      master
    * ui-integration

On the other hand, if you are not interested in working on that topic but
just want to look at it, e.g. merge it to your master:

    $ git branch
    * master
    $ git merge origin/ui-integration

without creating a local ui-integration branch at all (iow, skip that
"checkout -b" step above altogether).
