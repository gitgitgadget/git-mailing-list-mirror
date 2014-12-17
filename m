From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Improving git branch
Date: Wed, 17 Dec 2014 12:51:36 -0800
Message-ID: <xmqqzjam80fb.fsf@gitster.dls.corp.google.com>
References: <CAHQ6N+qBUcBcG8RC6Co+k_GmJDXCynmyfZmvTjz4bQyH1wG3DA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 17 21:51:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1LZR-0000Hk-7P
	for gcvg-git-2@plane.gmane.org; Wed, 17 Dec 2014 21:51:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbaLQUvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2014 15:51:41 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50826 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751030AbaLQUvk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2014 15:51:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ECF9628E7B;
	Wed, 17 Dec 2014 15:51:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=spLCm8fX0BeG0q5oM95erxxx3vA=; b=N/QFrN
	wgHMUPpRn58P97gMUsHmmtZlyyWzApno9QDV30BDoYR4zoNvhGnyVJW+ULLk3sYj
	Zd5RrF7U9iVwc9EQ9Q2kzuuWNElPIsi4QUWp5Q4LMrBhK3grqq39huwbZktkUCUx
	8rBoke3Q6wmKXX1a2GY1lA11wT5QHI38MkpHI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JqOpf0Wkr/w3NkPgeyfGiYgGJH02Luvw
	TERWMhn8eE0y4AFSmPyzsPq7vo8yvj5anY44+KPBlXH5ghE8OJmSm+pCEfUmwAXg
	2uYG5u9A8OXybYHQfHYngwpa7GUGkr7QW53B58kxHXA78M+PiKNq8BlOi5bY86kt
	bfOZSlf5m5w=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E450928E7A;
	Wed, 17 Dec 2014 15:51:40 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6926628E79;
	Wed, 17 Dec 2014 15:51:40 -0500 (EST)
In-Reply-To: <CAHQ6N+qBUcBcG8RC6Co+k_GmJDXCynmyfZmvTjz4bQyH1wG3DA@mail.gmail.com>
	(John Tapsell's message of "Wed, 17 Dec 2014 11:10:10 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 80239FC2-862E-11E4-A071-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261495>

John Tapsell <johnflux@gmail.com> writes:

>   I'm interested in putting in some time and effort into improving the
> output of "git branch".
>
>   What I'm thinking is an output like this:
>
> $ git branch
>
> 2014-12-17 * (detached from origin/master)     deaba04 Do stuff
> 2014-12-15   john.ta/add_timing_info                6edbcfa  Add timing stuff
> 2014-12-14   master                                          8537316
> [origin/master: ahead 1, behind 16] Some stuff
> 2014-12-12   john.ta/new_reduce_memory       99d84db Reintroduce: memory stuff
> 2014-12-05   john.ta/bugfixes                            e15c95e Add stuff
> 2014-12-03   john.ta/container                           e9fd4e5 This
> branch is a test bed for containers
>
>
> (These columns are supposed to be all aligned nicely..)
>
> So, features:
>
> 1. Show the date of the last commit
> 2. Sort by date.  Most recently used branches at the top
> 3. Show the branch name, including your current "branch", with a * to
> indicate that it's checked out.
> 4. Show the sha
> 5. Show the branch DESCRIPTION - and if that's not available, show the
> short-line of the most recent commit.
>
> There is also a small amount of color here that I can't paste here, to
> follow the coloring in the current git branch.
>
> Before I start making patches etc, what do people think?  Would I have
> a chance of getting this in?  Should I change some aspects etc?

Three random points:

 * A single output format can never be favourite of everybody, so
   this needs to be more like

	$ git branch --format='%(committerdate) %(refname) %(subject)'

   optionally with branch.format configuration variable to let the
   user specify the default.

 * I am not sure if the "current" marker should be anywhere but the
   frontmost column in the recommended default.  The output from the
   command obviously is not meant for machine processing
   (e.g. sorting or grepping), so this point is minor, though.

 * I do not think the object name should take valuable screen real
   estate, again in the built-in default (I wouldn't mind people
   hurting themselves with their configuration at all ;-).  After
   looking at "git branch --pretty-long" output, people can give any
   command john.ta/bugfixes instead of e15c95e, no?
