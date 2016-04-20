From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git rebase -i without altering the committer date
Date: Wed, 20 Apr 2016 13:36:59 -0700
Message-ID: <xmqqd1pkuidw.fsf@gitster.mtv.corp.google.com>
References: <etPan.5717e605.4004d424.12d1@sjackman03-imac.phage.bcgsc.ca>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Shaun Jackman <sjackman@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 22:37:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asys2-0005EA-39
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 22:37:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbcDTUhE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 16:37:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62503 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751307AbcDTUhD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 16:37:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9885112E64;
	Wed, 20 Apr 2016 16:37:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+g0yap55zp2muF9yBFjNpsZ8eOg=; b=JE0H8L
	Pxw38JomlC3oip0O7TIoklj0eOt1GVPc61cV9K7SFaFLsxwwfGjikuXaUc5T3W5j
	3mW3YRwqi5bz29PFu8ZcCX5JcTuRpTvVtgIUv2NeZJBJgfjfAuY8ulyzFRH8MJ4M
	ss+2B9bvUjYg7fu2I0Tifq8A9k/4D35uXwb/U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eqLtXtDvyVWvSu5sR7ycJzV8vANhoHRC
	KjGT3NWx5p/z0Fg/Krs9cAxLbi8iO8e49YcnRBSxuWOjFu5mJEBAAEUQn6FpC9yH
	Pw1XhZvrhifKbHmAeKhFiYrFo7Yojq+eb6N+5Bd+wR6F8dU0dXbk2+gCHG9zzliv
	+GFJ6DPWff8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 91C1D12E60;
	Wed, 20 Apr 2016 16:37:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A58F712E5D;
	Wed, 20 Apr 2016 16:37:00 -0400 (EDT)
In-Reply-To: <etPan.5717e605.4004d424.12d1@sjackman03-imac.phage.bcgsc.ca>
	(Shaun Jackman's message of "Wed, 20 Apr 2016 13:24:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A22E6D78-0737-11E6-800F-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292073>

Shaun Jackman <sjackman@gmail.com> writes:

> I'd like to insert a commit between two commits without changing
> the committer date or author date of that commit or the subsequent
> commits. I'd planned on using `git rebase -i` to insert the
> commit. I believe it retains the author date, but changes the
> committer date to the current time. I've seen the options
> `--committer-date-is-author-date` and `--ignore-date`, but I don't
> believe either of those options does what I want. If no such
> option currently exists to leave the committer and author date
> unchanged, is there any chance that this functionality could
> please be implemented?

You can mark the commit as "edit", use "git commit --amend" when
"rebase -i" stops and gives control back to you, and say "rebase
--continue".  That way, you can use your favourite trick to lie
about committer date (or identity or other aspects) when running
"git commit --amend" and its effect will be left in the resulting
history, I would think.
