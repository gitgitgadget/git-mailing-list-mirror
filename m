From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Re: add documentation for mailinfo.scissors and
 '--no-scissors'
Date: Fri, 11 Sep 2009 14:00:46 -0700
Message-ID: <7v8wglw60x.fsf@alter.siamese.dyndns.org>
References: <33445216edc4c4e1976cdd81521922042955e6eb.1252626034.git.nicolas.s.dev@gmx.fr> <f63e8402656c02fc2ecdcce8a37cc1d60a61aa1d.1252628643.git.nicolas.s.dev@gmx.fr> <7veiqe0x05.fsf@alter.siamese.dyndns.org> <20090911134112.GA18684@vidovic> <7vws45wbxq.fsf@alter.siamese.dyndns.org> <20090911200849.GB18684@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Fri Sep 11 23:01:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmDEy-0002d2-2g
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 23:01:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756412AbZIKVA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 17:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756407AbZIKVA5
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 17:00:57 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33618 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756405AbZIKVA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 17:00:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A42052F52A;
	Fri, 11 Sep 2009 17:00:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc
	:mime-version:content-type:subject:references:from:date
	:in-reply-to:message-id; s=sasl; bh=ds+CY/FGacUszaqJNrYbnNlAi8g=; b=
	tiKt4hq/Xz3EE4d+y42xJN8DT2Wt0tHQhBCSNimE8oCXC99gnvvGnR6SuqxgSaXE
	GWL4MiMkAS3yYeCAUwb68OuEMy3TsX7dxJS4GzW458JkrrlQlWAx7RSYyTERKXqu
	kTT9BFdP8eGUps5OtdSgksPtFjDhX0eTlgCVI6IVBV0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc
	:mime-version:content-type:subject:references:from:date
	:in-reply-to:message-id; q=dns; s=sasl; b=ZYvTJFGUwEZMuznNH0B+Kg
	hHkfNy13f1ko7bq5oLCv8oCX5Qp7oh0BnyJTEP+26ZBdxwvKjcJNP5bKvWZmkAVC
	OBBewltdYKa8T20dhikKNCSHuMQbN+YpOD8NSau3LufhKgU9inuoq/vHkCrYorQe
	c9D2DcEyCuEX5A1cmTKaQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 10DB32F529;
	Fri, 11 Sep 2009 17:00:53 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 417D82F528; Fri, 11 Sep
 2009 17:00:48 -0400 (EDT)
In-Reply-To: <20090911200849.GB18684@vidovic> (Nicolas Sebrecht's message of
 "Fri\, 11 Sep 2009 22\:08\:49 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3126A5C2-9F16-11DE-A34F-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128218>

Nicolas Sebrecht <nicolas.s.dev@gmx.fr> writes:

> Ok. So, the fact that the usage of git-am doesn't tell about
> --no-scissors is the expected behaviour?

You _could_ argue that we _could_ describe a long option "frotz" that
lacks the '!' flag in OPTIONS_SPEC as "--[no-]frotz" in the output by
changing the rev-parse --parseopt, if you really want to.

However, I think that is not done deliberately to avoid cluttering the
output.  I Cc'ed the primary guilty party ;-) of the parse-options
infrastructure.

Currently, non-bool options are not marked with '!'.  Nobody sane would
say "git am --no-directory foo", but "rev-parse --parseopt" acccepts such
a nonsense input, and it is up to the calling script to catch it and barf.
But "rev-parse --parseopt" will start saying "--[no-]directory=" with such
a change, which is not good.

And --no-scissors is not that special.  We could add --no-signoff to say
"I do not want to sign-off this one time" explicitly, and it is crazy if
we had to add another line in OPTIONS_SPEC when we want to do so, when it
is clear "signoff" option is a boolean.

As a long term direction, I'd rather not to see "no-" in OPTIONS_SPEC, but
have that taken care of by "rev-parse --parseopt" to keep our sanity.  The
only existing offender is "no-verify" in "rebase -i".  Let's solve it (if
there is anything to solve, which I doubt) without adding new ones.
