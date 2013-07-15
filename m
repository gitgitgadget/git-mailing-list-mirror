From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] push: document --lockref
Date: Sun, 14 Jul 2013 20:50:39 -0700
Message-ID: <7vd2qkfpm8.fsf@alter.siamese.dyndns.org>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org>
	<1373399610-8588-1-git-send-email-gitster@pobox.com>
	<1373399610-8588-8-git-send-email-gitster@pobox.com>
	<51DC7199.2050302@kdbg.org> <7vhag3v59o.fsf@alter.siamese.dyndns.org>
	<51DC78C0.9030202@kdbg.org> <7v38rnv0zt.fsf@alter.siamese.dyndns.org>
	<7vvc4jtjqa.fsf@alter.siamese.dyndns.org> <51DF1F56.9000705@kdbg.org>
	<7vzjtspwvo.fsf@alter.siamese.dyndns.org> <51E03B18.5040502@kdbg.org>
	<7vli5bllsd.fsf@alter.siamese.dyndns.org> <51E0605E.9020902@kdbg.org>
	<7vy59biih4.fsf@alter.siamese.dyndns.org> <51E0F93A.8050201@kdbg.org>
	<7vwqougwec.fsf@alter.siamese.dyndns.org> <51E1B5DB.9080904@kdbg.org>
	<7v61wdgdd1.fsf@alter.siamese.dyndns.org> <51E3084D.2040504@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Jul 15 05:50:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyZoH-0001Dc-6Z
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 05:50:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753928Ab3GODup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jul 2013 23:50:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58339 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753916Ab3GODuo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 23:50:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 59AC3297CD;
	Mon, 15 Jul 2013 03:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=8rOa3LQYMX/bJ+dRB2E4qfgsb0I=; b=FKJOkC+ci8mrKIxdrZ+D
	jHmysc3+GjjdwZ71zFKjOXq8YWEGw7+ibTmCgFooYWb2I8vYfHxSAJP/osXHqkZ3
	Sc1LeQ4yYDXE6SoxRjQlNCPZUfaahu6wzcfhYlnev2x2OJ0eaOuGGkoicdNT2pLm
	d9KA1ekihB+8YDoDuM3kx0w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=rDJYIXi+6O8b5Vv/hPEOkMPBhZFv03AKxEkV6n6tEU+DVV
	DzLs8+rkA+WOIJJeSq9HAfDY0frFykd2RzLxh0eHfTVsF9rq+PNVgQffFweFqpqa
	b2xigYGTzOrMQs9nLQYsgVICsUGVcwNERpUOSVadJYbptfFgm0FaLJM47ARm8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FE04297CB;
	Mon, 15 Jul 2013 03:50:44 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6A17E297C9;
	Mon, 15 Jul 2013 03:50:43 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B9519C12-ED01-11E2-8EBC-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230408>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 14.07.2013 21:17, schrieb Junio C Hamano:
>> Johannes Sixt <j6t@kdbg.org> writes:
>>> I actually think that by implying allow-no-ff in --lockref, you are
>>> hurting users who have configured a push refspec without a + prefix:
>>> They suddenly do not get the push denied when it is not a fast-forward
>>> anymore.
>> 
>> Of course, that is why you should not use --lockref when you do not
>> have to.  It is a tool to loosen "must fast-forward" in a more
>> controlled way than the traditional "--force".
>
> Sorry, IMO, this goes into a totally wrong direction, in particular, I
> think that this is going to close to door to make --lockref the default
> some day in a way that helps everyone.

I would presume that you would force that "reverse tracking"
short-hand as the expected value, as "default" will not have other
sources of information.

I think the use of "reverse tracking" is way overrated.  It is
probably the only default value that we could use, if the user is
too lazy not to specify it, but I do not think it is particularly a
sensible or safe default.

The following does not discuss "should --lockref automatically
disable the 'must fast-forward' check?".  The problem highlighted is
the same, regardless of the answer to that question.

After rebasing beyond what is already published, you try the
"lockref" push, e.g. (we assume you work on master and push back to
update master at your origin):

	$ git fetch
        $ git rebase -i @{u}~4 ;# rebase beyond what is there
        $ git push ;# of course this will not fast-forward
        $ git push --lockref
	... or with your "must-fast-forward is independent"
	$ git push --lockref origin +master
        ... or also with your "--lockref is default"
	$ git push origin +master

If somebody else pushed while you are working on the rebase, the
last step (one of the above push) will fail due to stale
expectation.  What now?

The user would want to keep the updated tip, so the first thing that
happens will always be

	$ git fetch
	$ git log ..@{u} ;# what will we be losing?

The right thing to do at this point is to rebase your 'master' again
on top of @{u}

	$ git rebase -i @{u}

before attempting to push back again.  If you do that, then you can
do another "lockref" push.

But the thing is, a novice who does not know what he is doing will
likely to do this:

        $ git push --lockref
	... or with your "must-fast-forward is independent"
	$ git push --lockref origin +master
        ... or also with your "--lockref is default"
	$ git push origin +master

	... rejected due to stale expectation
        $ git fetch

You just have updated the lockref base, so if you did, without doing
anything else, 

	$ git push origin +master

then you will lose the updated contents.

The conclusion?  It does not make sense to make "lockref" the
default.

The --lockref mechanism is necessary _only_ when you want to break
the usual "must fast-forward" safety, and the user needs to be made
very aware of what he is doing.  Making it default and making it
appear easy to invoke with a single "+", is totally going in a wrong
direction.  Besides, by making it the default and turning "+" into
"only defeat 'must fast-forward", you will break existing setting of
people who have "remote.*.push = +ref" configured, without having a
remote-tracking for that ref.

So it will not happen; "lockref" will not be on by default, even if
it is made independent of "must fast-forward".
