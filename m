From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] git-push: clean up some of the output from git
 push --porcelain
Date: Mon, 08 Feb 2010 23:31:44 -0800
Message-ID: <7v4olqlva7.fsf@alter.siamese.dyndns.org>
References: <214a0317f2e4707a866b2f5d10509296bc1479c1.1265661033.git.larry@elder-gods.org> <a1b71c9f6566549e6117f5c98c2f1e60754a7334.1265661033.git.larry@elder-gods.org> <7vtytrih7b.fsf@alter.siamese.dyndns.org> <7vvde7h1mn.fsf@alter.siamese.dyndns.org> <20100208213256.GA470@coredump.intra.peff.net> <7viqa7cqs9.fsf@alter.siamese.dyndns.org> <20100208223107.GB21718@cthulhu> <7vpr4f9wey.fsf@alter.siamese.dyndns.org> <20100209045417.GA15210@cthulhu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Larry D'Anna <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Tue Feb 09 08:32:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NekZm-0002VM-Mx
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 08:32:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752977Ab0BIHb4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 02:31:56 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44547 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519Ab0BIHby (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 02:31:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 28ACF97BF3;
	Tue,  9 Feb 2010 02:31:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=C+02BJic7TFjGfP8tFYfshk11FQ=; b=clo9eLvxiMcj3wJmDFdcgMr
	58P4TliOlCKxXtBsOboCUqxLusWxQj00DuQPu7cjjDc9zcvO1l+uscAC/HK/rSXx
	0bJ0NFoNNzcnRcGK9CKapVyd1hnBUnYxrCOIyCLch673+mx8DWkk7W57khwTRvox
	qqMml2RaKNqS87ddR8JE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=FAIxTurnE2Cu4Dzni8BGLXp53a/c2psfJrnBXK18htLxKJcQO
	HipdsQmvg9jSsYfgIHt0GbuRdV+LaA46+zwJ6RSNT1Zz9tYHDb0+4cSMYfuRaBhC
	+80fsjgLBptdvxr8gcxIwGmqEiveqNy5VfrQ/B5GcPyBB+XKb5hWHCKGkk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E9BE497BF2;
	Tue,  9 Feb 2010 02:31:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 048D297BEF; Tue,  9 Feb
 2010 02:31:45 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2F93D722-154D-11DF-BFEF-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139378>

Larry D'Anna <larry@elder-gods.org> writes:

> * Junio C Hamano (gitster@pobox.com) [100208 17:48]:
>> *1* As I hinted repeatedly, I think many of them are mere churn, except
>> for "don't advice porcelain scripts" (good) and perhaps "exit with failure
>> status upon only this kind of failure" (I am undecided).  
>
> What about the "To" lines?  It seems that they really should go to stdout (if
> --porcelain is selected).  Otherwise, how does the reader of stdout know which
> refs got pushed to which remote?

I think that probably is an improvement.

We would probably need documentation updates to cover the parsing of "To",
at least; it might be cleaner to have a separate section for porcelain
writers.  And tests.  But this series won't hit next until 1.7.0 ships so
we have enough time to polish the details.

I queued the series and once merged it to 'pu' but seeing some tests fail,
I reverted the merge.  The error is somewhat curious...

$ while sh t5401-*.sh -i; do :; done
... wait for a while ...
* FAIL 12: send-pack stderr contains hook messages

                grep ^remote: send.err | sed "s/ *\$//" >actual &&
                test_cmp - actual <expect

$ t/(364643e...); cat trash\ directory.t5401-update-hooks/actual 
remote: STDOUT pre-receive
remote: STDERR pre-receive
remote: STDOUT update refs/heads/master
remote: STDERR update refs/heads/master
remote: STDOUT update refs/heads/tofail
remote: STDOUT post-receive
remote: STDERR post-receive
remote: STDOUT post-update
remote: STDERR post-update
$ t/(364643e...); cat trash\ directory.t5401-update-hooks/expect 
remote: STDOUT pre-receive
remote: STDERR pre-receive
remote: STDOUT update refs/heads/master
remote: STDERR update refs/heads/master
remote: STDOUT update refs/heads/tofail
remote: STDERR update refs/heads/tofail
remote: STDOUT post-receive
remote: STDERR post-receive
remote: STDOUT post-update
remote: STDERR post-update
