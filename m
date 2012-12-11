From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] Allow git log to use mailmap file
Date: Tue, 11 Dec 2012 14:33:00 -0800
Message-ID: <7vip886wyr.fsf@alter.siamese.dyndns.org>
References: <1355264493-8298-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Rich Midwinter <rich.midwinter@gmail.com>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 23:33:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiYOA-0000Ew-Qk
	for gcvg-git-2@plane.gmane.org; Tue, 11 Dec 2012 23:33:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755002Ab2LKWdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2012 17:33:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33003 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754844Ab2LKWdE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2012 17:33:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F9E0A485;
	Tue, 11 Dec 2012 17:33:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UPwaBkzGncYXahjvktvpFJpkfyg=; b=j+7pCS
	/SoibaVzQWOS3iLbFb86ACSLvxKe7DC81Asc4pJOT3+XxnbLcs/aKWKpT1LLl1UW
	vGi84amXoFXtHjhsKIFtl1iNgco8znJu6L/OQQxPY/LmKHt7IGkUq6u2ipT6B+U3
	onstjDBVEd1/+i8MsfDheL6sO28RIyZoZJV7I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uBkXgO1hsKmDQNvvcWHo6uMBGn0hYlSI
	AAEKa8N3llg22Tvwijh8sdYIriNOlmpNEYujhFFVjpC2VbSZNxNVLXHyIEGFxxAr
	UDm5SPdWVDqn1wq543Kke5zOaEx9732oVU5iFNtXBAjkScbWM2ScDsoBMXvq6+RZ
	X4LGqyNtZj0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CB8EA484;
	Tue, 11 Dec 2012 17:33:04 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 27841A483; Tue, 11 Dec 2012
 17:33:03 -0500 (EST)
In-Reply-To: <1355264493-8298-1-git-send-email-apelisse@gmail.com> (Antoine
 Pelisse's message of "Tue, 11 Dec 2012 23:21:28 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B9B28414-43E2-11E2-BB2B-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211311>

Antoine Pelisse <apelisse@gmail.com> writes:

> Implement the feature suggested here [1] by Rich Mindwinter
> and Junio C Hamano (and following his advices)
>
> This is a pre-version so there are a bunch of things still missing,
> among them:
>  - There is no tests
>  - Grep search for mailmap author/committer is not available
>  - There is no documentation of the new option
>
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/211270

That was quick ;-)

> Antoine Pelisse (5):
>   Use split_ident_line to parse author and committer
>   mailmap: Remove buffer length limit in map_user
>   mailmap: Add mailmap structure to rev_info and pp
>   pretty: Use mailmap to display username and email
>   log: Add --use-mailmap option
>
>  builtin/blame.c | 59 +++++++++++++++++-------------------------------
>  builtin/log.c   |  9 +++++++-
>  commit.h        |  1 +
>  log-tree.c      |  1 +
>  mailmap.c       | 16 ++++++-------
>  pretty.c        | 70 ++++++++++++++++++++++++++++++++++++---------------------
>  revision.h      |  1 +
>  7 files changed, 84 insertions(+), 73 deletions(-)
>
> --
> 1.8.1.rc1.5.g7e0651a
