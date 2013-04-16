From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] pull: introduce --[no-]autostash and pull.autostash
Date: Tue, 16 Apr 2013 10:42:56 -0700
Message-ID: <7vsj2qmkwv.fsf@alter.siamese.dyndns.org>
References: <1365887729-9630-1-git-send-email-artagnon@gmail.com>
 <1365887729-9630-4-git-send-email-artagnon@gmail.com>
 <vpq38us2oov.fsf@grenoble-inp.fr>
 <CALkWK0mdC_tK2CGqAa67fr189PQCjSjzAOPujipOHFfoiYW0qA@mail.gmail.com>
 <vpqppxvoqsc.fsf@grenoble-inp.fr> <7vobdfztz9.fsf@alter.siamese.dyndns.org>
 <CALkWK0=cNEkE0bUoWJg119o+FaQywJhgkUxiFfLGPSsLrFVZ=A@mail.gmail.com>
 <7vr4ibu14j.fsf@alter.siamese.dyndns.org>
 <CALkWK0=6E=s6kJysMo2yC22c3pvCWn90S5neRyP0jpzpYrZboA@mail.gmail.com>
 <vpqli8je8w0.fsf@grenoble-inp.fr>
 <CALkWK0ndk7hPYk4pN8gmLxLOJR0XsLo1gwHB=n0QkK6DHgLzKQ@mail.gmail.com>
 <vpqvc7mdd3x.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Apr 16 19:43:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US9uJ-0002AA-IO
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 19:43:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936038Ab3DPRm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 13:42:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57800 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935536Ab3DPRm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 13:42:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C9E7165D5;
	Tue, 16 Apr 2013 17:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nLGtRY5rlYwuMpTeXGCdzl/I94o=; b=MYuS/y
	khuIhV6dvmQp3NF9tCyc4H7YL73n73kuCDllNm8rNyGWlDWyd+3ALht+/J0kDQF2
	fCw4RJ4jA/IBWo231ymtCIwbxc9ziK0sEv+MEICvSpA3+QoV23FezQX8MSz8Iusx
	vWPurs++duvTlFCFHQM2WR/zVpd+4b4tqxJ/w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cNwZr/wVkY0uoPypNMcFTGegYtfytuOS
	LDYJ6cihl7ShNmYYT55yOFHQJHaoYNlvqPex41hX3a/yliT0TVhO8oS9Hz/7fA80
	/ic/46WdljtlxqcIHAv1z3nVFaxHd8XD1A+qaha9J+9p1TOUjsULzcGI2by5A+rX
	nn38BS1Ubko=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 43A83165D4;
	Tue, 16 Apr 2013 17:42:58 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 89DF9165D0; Tue, 16 Apr
 2013 17:42:57 +0000 (UTC)
In-Reply-To: <vpqvc7mdd3x.fsf@grenoble-inp.fr> (Matthieu Moy's message of
 "Tue, 16 Apr 2013 11:44:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 13344DAA-A6BD-11E2-977C-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221434>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> If it is 0 (which means that the rebase completely successfully), pop
>> the stash before exiting as usual.
>
> And you're going to pop the stash even if no stash were triggered when
> starting the rebase.
>
> Really, think about it again: you're not going to guess whether you have
> to unstash without storing this information somewhere. You may argue
> about storing it outside the todolist, you can't unstash
> unconditionally.

Yes, it can be part of todo, but it does not have to be.

Regardless of where the information is stored, implementing the last
step as "stash pop" will add a small inconsistency the end user
needs to be aware of.

Imagine "git rebase" stops, asks you to help with conflicts, and you
look at it, play with the working tree, and made a mess.  If this
was the last "stash pop" invocation, the way to go back and start
again is "reset --hard && stash pop".  For all the other steps, that
is not how the user goes back to the originally conflicted state in
order to retry from scratch.

Makes me wonder if the world were a better place if the rebase-todo
list were implemented as a dedicated stash and "rebase --continue"
were a mere "stash pop" followed by a commit if pop goes smoothly.

I am not suggesting to actually do so, but it is an intriguing
thought from the perspective of end user experience, isn't it?

In any case, I am not saying that it is a _bad_ thing to implement
the last "restore the WIP" stage as "stash pop". I am just pointing
out that the messaging needs to be done carefully to make sure the
user understands which one is which, as the way to deal with the
situation where it stops and asks the user for help would be
different from normal step in the rebase sequence that replays a
commit.
