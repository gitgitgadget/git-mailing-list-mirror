From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] ff-refs: builtin command to fast-forward local refs
Date: Mon, 30 Nov 2015 16:24:07 -0800
Message-ID: <xmqqio4j6moo.fsf@gitster.mtv.corp.google.com>
References: <1447207885-10911-1-git-send-email-rappazzo@gmail.com>
	<56431B69.9010007@drmicha.warpmail.net>
	<CANoM8SV77Jg8qYsn7UZ=a18WvrA_ayAWCnAjN9Tf6Re=r1Ggsg@mail.gmail.com>
	<CANoM8SWxMeDjwy-GwVc+En8D7N8LyzzsBKtX_MbiS4Z49DjD7g@mail.gmail.com>
	<564B47AC.7070609@drmicha.warpmail.net>
	<CANoM8SXrRmXPZQotQgJNNonJcb3rs5LM=JwOYoh4mX4nw2XB-g@mail.gmail.com>
	<alpine.DEB.1.00.1511181052130.1686@s15462909.onlinehome-server.info>
	<20151124223903.GG29185@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Rappazzo <rappazzo@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 01 01:24:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3Yjv-0007HG-88
	for gcvg-git-2@plane.gmane.org; Tue, 01 Dec 2015 01:24:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754446AbbLAAYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2015 19:24:11 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55127 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751995AbbLAAYK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2015 19:24:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5E33D3105A;
	Mon, 30 Nov 2015 19:24:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=niNk5WAR5tQp297AEXXYG/3rJn0=; b=RjsKxK
	bveV2A7S+0+V9kAoXE/ravsN3cswDlg/mYFlz0ySnQZbE5IqfovtSTbbJAl7JONn
	IdZNAoYHW9EhypbqGlEbflgLmSSZwTXN5+58Xwk/LIFxWT0jPegQMZNJpygYPyna
	LF4G8tXGAsDOHF80aJPG3wl6BrMUvmwNkoBr4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wB73dtItjAH5zZSgSuusnBk/RqVXncjW
	3V8YTIhxtr2yvl9TPgwGMSlqJEcy+ssq7YxpkjDe2i77M/gfsB7j4e/4sLdrtzRI
	CvWeMIZBoJrVUEjoK1woDtov94lAh9aH5E5UJoB1Hrai1o2NwMUDKTAvsGISLXVQ
	wDhwbuFzzBU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5507031058;
	Mon, 30 Nov 2015 19:24:09 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C385F3104C;
	Mon, 30 Nov 2015 19:24:08 -0500 (EST)
In-Reply-To: <20151124223903.GG29185@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 24 Nov 2015 17:39:03 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D68F5EAA-97C1-11E5-A27C-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281827>

Jeff King <peff@peff.net> writes:

> On Wed, Nov 18, 2015 at 10:56:02AM +0100, Johannes Schindelin wrote:
>
>> > For me I use this command more as a post-fetch:
>> > 
>> > git fetch --all --prune && git-ff-refs
>> > 
>> > I imagine that the big difference is in the number of branches that I
>> > maintain, and perhaps in the way that I use gitk to visualize them.  I
>> > would be happy to add another option to git-fetch for --ff-refs as an
>> > alternative if that would feel better than a full-on builtin.
>> 
>> I would much prefer, say, `git fetch --all --prune
>> --fast-forward-tracking-branches` (with maybe `-T` as short option for
>> `--fast-forward-tracking-branches` and/or a shorter `--ff-tracking`) to a
>> new builtin.

Hmph, I am not sure it is a good idea to allow "git fetch" affect
refs that it was not told to "fetch", but that is why you give a new
option from the command line to update refs that are not involved in
the fetch based on what was fetched, so it might be OK.

But the above is *NOT* fast-forwarding "tracking" branch.  It is
doing something else: fast-forwarding the local branch that is based
on a remote-tracking branch.

    They have refs/heads/master, and they call it their 'master'
    branch.

    You have refs/remotes/origin/master, and that is the
    remote-tracking branch for their 'master'.

    You may have prepared your 'master' to build on their 'master'
    branch.  That is not a 'tracking branch' for anything.

So --ff-tracking and the other name above need to be rethought.

> FWIW, that makes a lot more sense to me, as it would presumably touch
> only branches which track whatever we just updated, and not other random
> refs.
>

This ff-refs series breaks build for me by introducing calls to chdir()
whose return values are not checked -Werror=unused-result, by the way.

> I have to admit that I'm a little wary of something like ff-refs meeting
> all needs, though. I have custom scripts that match my workflow and tell
> me when a branch could be updated. I could replace part of them with
> "ff-refs --dry-run", but that is really not much code. Basically:
>
>   git for-each-ref --format='%(refname) %(upstream)' refs/heads |
>   while read ref upstream; do
>     git merge-base --is-ancestor $ref $upstream &&
>       echo "$ref can fast-forward"
>   done

Yup.  I like that one.
