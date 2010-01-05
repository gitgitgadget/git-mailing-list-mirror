From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2010, #01; Mon, 04)
Date: Mon, 04 Jan 2010 21:18:34 -0800
Message-ID: <7v4on186z9.fsf@alter.siamese.dyndns.org>
References: <7vljgei7rs.fsf@alter.siamese.dyndns.org>
 <4B421766.4040506@kdbg.org> <7vhbr1bagk.fsf@alter.siamese.dyndns.org>
 <20100105042046.GC12574@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 05 06:18:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NS1om-0002CB-U4
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 06:18:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752361Ab0AEFSs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 00:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255Ab0AEFSs
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 00:18:48 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56008 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963Ab0AEFSr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 00:18:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 680458EF68;
	Tue,  5 Jan 2010 00:18:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bold830KIF0waSspRIt19bTPwtw=; b=iRxzVi
	qTprq4RYkCbbZ4ElKsk5Mb71Zi9A9CJd1zedeDiV8YT2GBBbZeHCbCWAF07p91eM
	C9rqhvAcQgSgupzBiO5f2GS1GKW2JcjRkvcNUyRmZTsK7ycQ0fMcxSNktmSp4lac
	BoTJM3gtDKjCFgedBDsz+QjnsmG+l+RNJG8x8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EmHmxWmVvCZVVmvgIHIY05HiQjMNaRdQ
	NLV0RfW65qF7GClMg5xi4oN5KUIH+mmnUK+FcX6YRvgDdH7Mlocx7Aw2BU+v+1mf
	YBA7sCSqEOR2l4iRTF068W2yp+Rn7wKEBsi/+bT4fkPSrQBilRhY09wbB4XkpCcr
	0crA7pMrrAM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 370278EF66;
	Tue,  5 Jan 2010 00:18:41 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 516648EF65; Tue,  5 Jan
 2010 00:18:36 -0500 (EST)
In-Reply-To: <20100105042046.GC12574@coredump.intra.peff.net> (Jeff King's
 message of "Mon\, 4 Jan 2010 23\:20\:47 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C976D0A6-F9B9-11DE-AF1A-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136161>

Jeff King <peff@peff.net> writes:

> On Mon, Jan 04, 2010 at 05:35:07PM -0800, Junio C Hamano wrote:
>
>> > 1. My patch "t0021:..." contains an unrelated change to t4030 (it
>> > changes a /bin/sh to $SHELL_PATH) that is not necessary. I included it
>> > in my first version of the patch, but later noticed that we already
>> > have many similar uses of /bin/sh instead of $SHELL_PATH in test
>> > scriptlets and decided to remove the change, but I only changed the
>> > commit message and forgot to unstage t4030.
>> 
>> While you are technically correct that the change you made in t4030 is not
>> justified by the commit log message in the sense that the "hexdump" script
>> will go through run_command() interface and is not subject to the special
>> rules filter writers need to keep in mind, the patch text itself is a good
>> change, isn't it?  Do you want me to split the commit into two (one with
>> the current message with a patch only to t0021, and another to t4030 with
>> a justification like "SHELL_PATH is what the user told us to use")?
>
> If we are going to do the t4030 change, there are a ton of other spots
> that use /bin/sh directly (I counted 38 with
>
>   grep -n /bin/sh * | grep -v :1:
>
> ). Should we be changing all of them?
>
> It is slightly just code churn, because the scripts are so simple that
> even broken shells like Solaris /bin/sh run them just fine. The only
> real advantage is that it slightly future-proofs them against somebody
> making them more complex.

Ok, it is a single liner that invokes Perl, so hardcoded /bin/sh is a much
lessor offence.
