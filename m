From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] t0000 cleanups
Date: Mon, 30 Dec 2013 10:30:28 -0800
Message-ID: <xmqqwqimry2j.fsf@gitster.dls.corp.google.com>
References: <20131228092731.GA26337@sigill.intra.peff.net>
	<20131228222129.GE5544@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	John Keeping <john@keeping.me.uk>,
	Thomas Rast <tr@thomasrast.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 30 19:31:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vxhc8-0003q2-Nh
	for gcvg-git-2@plane.gmane.org; Mon, 30 Dec 2013 19:30:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756126Ab3L3Sad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Dec 2013 13:30:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44145 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755867Ab3L3Sac (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Dec 2013 13:30:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E1D9D5F6D6;
	Mon, 30 Dec 2013 13:30:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fh92ePlawyKRFaBwuaHrBhYvJhg=; b=Eqk45Q
	PpM8OBrZQfS2VTNOOjZyMBxppdLXiHzQK7BgyHxkHDc4282PNLbsbi+srkXjYI+T
	foK0gIAWUcuQW/EIj8WEM3upA/ejtDpKELHvJH1c3Um61JVmQBoIvwJVPj6D5yUe
	g2ckQuUXbGAcwpllQNvJJ4dDITTshjPTIOLQc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A63LRHtSkpAHv5+Ot1aC5Veuxj7SjWNy
	nOweRvH0ommVIRxTbuaoXmBcT7v9IH+Q0UszPje1uYJrw6eQRx4tGeFylMaA733B
	aJMgCiLIsbH0dRynPl72DQuhYVnFs/LGZ6/CsoqNl/VO6Lc3I91z9pU7Frlmqkq5
	IQUfK/nP3LE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC0C15F6D5;
	Mon, 30 Dec 2013 13:30:31 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 015705F6D3;
	Mon, 30 Dec 2013 13:30:31 -0500 (EST)
In-Reply-To: <20131228222129.GE5544@google.com> (Jonathan Nieder's message of
	"Sat, 28 Dec 2013 14:21:29 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 769B0D8C-7180-11E3-B15F-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239811>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jeff King wrote:
>
>> When I want to debug a failing test, I often end up doing:
>>
>>   cd t
>>   ./t4107-<tab> -v -i
>>   cd tra<tab>
>>
>> The test names are long, so tab-completing on the trash directory is
>> very helpful. Lately I've noticed that there are a bunch of crufty trash
>> directories in my t/ directory, which makes my tab-completion more
>> annoying.
>
> Ah, and if I'd read this then I wouldn't have had to be confused at
> all.  Would it work to replace the commit message with something like
> this?

The third paragraph of 1/3 sufficiently covers it, no?  We could add
"It makes it less convenient to use tab completion 'cd t/tra<TAB>'
to go to the trash directory of the failed test to inspect the
situation" after "... left in the t/ directory.", though.

    Once upon a time, the test-lib library would create trash
    directories in the current working directory, unless we were
    explicitly told to put it elsewhere via --root. As a result,
    t0000 created the sub-test trash directories inside its own
    trash directory.

    However, we noticed that this did not cover all cases, since
    we would need to respect $TEST_OUTPUT_DIRECTORY even if
    --root is not given (or is relative). Commit 38b074d fixed
    this to consistently use the full path.

    As a result, trash directories used by t0000's sub-tests are now
    created in git's original test output directory rather than in our
    trash directory. Furthermore, since some of the sub-tests simulate
    failures, the trash directories do not get cleaned up, and the cruft
    is left in the t/ directory.

    We could fix this by passing a new "--root=$TRASH_DIRECTORY"
    option to the sub-test. However, we do not want the sub-tests
    to write anything at all to git's directory (e.g., they
    should not be writing to t/test-results, either, although
    this is already handled by separate code).  So the best
    solution is to simply reset $TEST_OUTPUT_DIRECTORY entirely
    in the sub-test, which covers this case, as well as any
    future ones.
