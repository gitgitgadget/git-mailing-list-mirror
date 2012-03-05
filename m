From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: pull --rebase with =?utf-8?Q?=C3=A9?= in name
Date: Mon, 05 Mar 2012 09:23:19 -0800
Message-ID: <7v8vjf2c8o.fsf@alter.siamese.dyndns.org>
References: <FECFDD4D-6EC3-4DE1-8A08-B4477345C4AA@habr.de>
 <20120305102657.GB29061@sigill.intra.peff.net>
 <87399nqqog.fsf@thomas.inf.ethz.ch>
 <F5A485EA-7EAD-4D8B-87C4-7185F713318C@habr.de>
 <20120305115815.GA4550@sigill.intra.peff.net>
 <0E2B8DE3-1ABD-453F-BCAA-0D693ECA5987@habr.de>
 <87ipijkxlm.fsf@thomas.inf.ethz.ch>
 <20120305132913.GA15004@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>,
	=?utf-8?Q?Ren=C3=A9?= Haber <rene@habr.de>,
	git@vger.kernel.org, Will Palmer <wmpalmer@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 05 18:23:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4bd9-0001FA-EK
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 18:23:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757195Ab2CERXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 12:23:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52516 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757185Ab2CERXV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 12:23:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 555E8736E;
	Mon,  5 Mar 2012 12:23:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LR3hZPAWPAy1NaCk2NvZp2IBkDg=; b=IRwpCe
	9Aad3WgZLpBuCYoehmQBI+ByOLHyoAOPw6W6OonvT6EZ+ZDLni/lJlHuvcc1qvAE
	rvQYyc4/PNfALgpxCl/8nKjW1rKRtarqcTwnmrr36IW1X/qV91Nyp5gxvi3r5NvB
	+/V77OkoieKGQH7V9z2o7XrEMjYq9wcE4O3ng=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bHdDqP3L5i+YwjzScZf3WhqfgUQyQCI2
	JWkIHbLDUIy4+mOMDZv33vgKUFWjQ5/m3W6U08I7bAclwV+1gUlI+kdJcUPd4A0S
	oh5vsq88nDPB1XzUdiK/zEQwtq1X2aN9AqpzX68tpWLkQWBKPYem2dNQ4lSLoGzI
	FQ8f7E3pcbc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C667736C;
	Mon,  5 Mar 2012 12:23:21 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 95342736B; Mon,  5 Mar 2012
 12:23:20 -0500 (EST)
In-Reply-To: <20120305132913.GA15004@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 5 Mar 2012 08:29:13 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E78F3CA2-66E7-11E1-A8B3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192254>

Jeff King <peff@peff.net> writes:

> It would be nice if the --pretty format placeholders had a "shell-quote"
> modifier, and we could just do:
>
>   git show --format='GIT_AUTHOR_NAME=%(an:shell)'
>
> or something similar. for-each-ref knows about shell-quoting, but we
> can't use it here, because we are looking at arbitrary commits, not just
> ones pointed to by refs.

You guys seem to have been having a lot of fun overnight. Perhaps I
should live on European time?

I think there were talks about cross pollinating and eventually
unifying the placeholder languages of pretty and for-each-ref, and
if we were to do so, I agree that --pretty definitely should learn
to do --sq. But I do not think we want to teach everything :shell;
following the style of %w(), something more generic that would apply
to any payload would be preferred, perhaps giving an end result like
this:

	git show -s --format='
		GIT_AUTHOR_NAME=%(sq-begin)%an%(sq-end)
                GIT_AUTHOR_EMAIL=%(sq-begin)%ae%(sq-end)
        '

which would be immediately `eval`-able.

Also I wonder if it is time for "git-am" to make more use of direct
knowledge of the $rebasing and the original commit. Perhaps by
teaching commit-tree to take the -c option from commit, we may not
even have to worry about this.

In any case, my reading of the conclusion you guys have already
reached in this thread is that the issue is not even a bug in Git,
but is a broken build/installation of sed by a third-party.  I am
inclined to suggest any change to get_author_ident_from_commit
helper backburnered before we teach --sq to --pretty machinery.

If the broken sed was the apple one that came with the platform, my
conclusion might be different, but it seems to me that this is not
something we would urgently have to worry about and patch our code
up with an ugly band-aid workaround.
