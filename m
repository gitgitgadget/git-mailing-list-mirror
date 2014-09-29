From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/3] doc: modernise everyday.txt wording and format in man page style
Date: Mon, 29 Sep 2014 16:24:33 -0700
Message-ID: <xmqqfvfat3gu.fsf@gitster.dls.corp.google.com>
References: <1412008907-3988-1-git-send-email-philipoakley@iee.org>
	<1412008907-3988-2-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: GitList <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Sep 30 01:24:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XYkJ8-00010v-Ll
	for gcvg-git-2@plane.gmane.org; Tue, 30 Sep 2014 01:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754749AbaI2XYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2014 19:24:38 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53155 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751547AbaI2XYh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2014 19:24:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 010CA3E385;
	Mon, 29 Sep 2014 19:24:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=pMM69GK5icvK2k31v8KLIkTSYS8=; b=vEX/vLZUJuoVBZ3rxeQ7
	lp6nHg9y8Ny+d++87EyMlRqyZDPTk0Xej/pDA8P6klGNNYfk3MSvqNePoVT4RYKn
	//0+9vDkTCsw4qZL3886R0gTd6UNe4NNZ3ZVeRBAAybBFSUFniNBaeyr8ZGR06uN
	c7ZfloNS4TmJnoLDwCx8DLc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=kE7tKfDZ+4kGPC/ZC9DnZX6CxcRKqwEtMLOz7lRfTWfOMA
	Bw4MIpMQ6ysWB16CrMGOWQYcMoVdeUmkuysJ8Im1SgsW9s/Gym0SAfEAQg4ycH6F
	/q86mRHXmsy2fJLTOqT5gIPSSqMmCL+Yu5tu0fNd7TC+TDlUued0s3hptj/b0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EA81A3E384;
	Mon, 29 Sep 2014 19:24:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6DC5C3E383;
	Mon, 29 Sep 2014 19:24:34 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C5A5A69A-482F-11E4-82CB-9E3FC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257643>

Philip Oakley <philipoakley@iee.org> writes:

> @@ -45,7 +58,7 @@ following commands.
>  
>    * linkgit:git-rebase[1] to maintain topic branches.
>  
> -  * linkgit:git-tag[1] to mark known point.
> +  * linkgit:git-tag[1] to mark a known point.

I really appreciate your attention to details here.

> +<10> review commit logs; other forms to limit output can be
>  combined and include `--max-count=10` (show 10 commits),
>  `--until=2005-12-10`, etc.

s/--max-count=//; perhaps?

> @@ -131,27 +145,34 @@ Clone the upstream and work on it.  Feed changes to upstream.::
>  ------------
>  $ git clone git://git.kernel.org/pub/scm/.../torvalds/linux-2.6 my2.6
>  $ cd my2.6
> +$ git checkout -b mine master <1>
> +$ edit/compile/test; git commit -a -s <2>
> +$ git format-patch master <3>
> +$ git send-email --to="person <email@example.com>" 00*.patch <4>
> +$ git pull <5>

This may be found somewhat questionable by some people, as "mine"
does not build on the master at origin.  Insert "git checkout master"
before this step to cause <5> update the pristine copy of their
master, perhaps?  That way, the next step

> +$ git log -p ORIG_HEAD.. arch/i386 include/asm-i386 <6>

starts making more sense.

> +$ git fetch --tags <11>
> ...
> +<11> from time to time, obtain official tags from the `origin`
>  and store them under `.git/refs/tags/`.

I am not sure if "fetch --tags" still needs to be taught, especially
in a "quick guide" document, because "fetch" has auto-followed
relevant tags for a long time since the original version of this
document was written.

> +<3> arrange `git push` to push all local branches to
> +their corresponding branch of the mothership machine.
> +<4> push will stash all our work away on `remotes/satellite/*`
> +remote-tracking branches on the mothership machine.  You could use this
>  as a back-up method.

The original mentions "a back-up method", but a larger benefit of
this kind of settings is that it lets you pretend that mothership
"fetched" from you.

We may want to say "You can use this to pretend as if the origin,
aka mothership, ran 'git fetch' from you, aka satellite".  This is
especially true because the next step <5> is about how to integrate
your work done on 'satellite' into 'mothership' that cannot fetch
from 'satellite' (imagine satellite is behind a NAT and it can only
ssh out to mothership but not the other way around).

> -Integrator[[Integrator]]
> +Integrator[[INTEGRATOR]]
>  ------------------------
>  
>  A fairly central person acting as the integrator in a group
> @@ -213,6 +235,9 @@ project receives changes made by others, reviews and integrates
>  them and publishes the result for others to use, using these
>  commands in addition to the ones needed by participants.
>  
> +This section can also be applied to a git-request-pull workflow,
> +or the GitHub (www.github.com) pull-request flow.

Clarify which end of that workflow this can be applied, perhaps?
E.g. "... also be used by the person who responds to 'git
request-pull' or pull-request on GitHub to integrate others' work
into your history".


> @@ -225,23 +250,26 @@ commands in addition to the ones needed by participants.
>  
>    * linkgit:git-push[1] to publish the bleeding edge.
>  
> +  * linkgit:git-request-pull[1] to create a summary of changes
> +    for your upstream to pull.
> +

This new item looks somewhat out of place, doesn't it?  It is
because this is a participant item, not an integrator item.

Yes, I know a sub-area lieutenant would request a pull by the
top-level maintainer, but when you interact with your 'upstream',
you are not acting as an integrator.

If you really want to add request-pull to common 20-or-so commands,
it would make more sense to do so in the participant's section and
to explain that an sub-area lieutenant acts both as a participant
and as an integrator.

Thanks.
