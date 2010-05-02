From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/5] pretty: make %H/%h/etc respect --abbrev[-commit]
Date: Sat, 01 May 2010 22:33:01 -0700
Message-ID: <7v39yazx4i.fsf@alter.siamese.dyndns.org>
References: <1272656128-2002-1-git-send-email-wmpalmer@gmail.com>
 <1272656128-2002-3-git-send-email-wmpalmer@gmail.com>
 <7vocgzyp1f.fsf@alter.siamese.dyndns.org>
 <20100502044506.GA14776@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Will Palmer <wmpalmer@gmail.com>, git@vger.kernel.org,
	raa.lkml@gmail.com, jrnieder@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 02 07:33:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8Rnu-0005E2-5K
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 07:33:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754653Ab0EBFdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 01:33:16 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47410 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754392Ab0EBFdP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 01:33:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 489B5AF9F4;
	Sun,  2 May 2010 01:33:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9blLMrumfzA+kCgL1rXZ3OWy25c=; b=Q/X7yv
	Ps7ZGTSLRljP2eCcUFdlQqMIUaQZs7CZ+vwrOrP4SB4gaeuYXcHUBTI1r9Z1YByU
	EjTrwJQjEitOBlShYy8LtylSo16vmBtVNbOe/qm6i9QCBgbinbIlzy2c0Nm3twXc
	UJQHC2H8ePQNshwb/WCQRzrg/i9Nh9Pf56tMc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M8JExw56XLJzsO1fNcE4Odp11b99JC1o
	8L5ER8doNLl00RhPXcZkJQ1HvT/Y4Ep0ZaH+hN6je9ctPcvOxj9+tSDseyFo6np5
	BILOc2Rrr/QNC5nCpibGRdbEefsZ81eWeKeM86Gwp1mqyY0hjaaQLdibAV31C4gl
	eiSBZMQNc1w=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E64ABAF9F3;
	Sun,  2 May 2010 01:33:08 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0EC72AF9F2; Sun,  2 May
 2010 01:33:02 -0400 (EDT)
In-Reply-To: <20100502044506.GA14776@coredump.intra.peff.net> (Jeff King's
 message of "Sun\, 2 May 2010 00\:45\:06 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 30FEB20E-55AC-11DF-8378-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146137>

Jeff King <peff@peff.net> writes:

> On Sat, May 01, 2010 at 08:13:00PM -0700, Junio C Hamano wrote:
>
>> Will Palmer <wmpalmer@gmail.com> writes:
>> ... 
>> > Here we make "git log --pretty=%H --abbrev-commit" synonymous with
>> > "git log --pretty=%h", and make %h/abbreviated-%H respect the length
>> > specified for --abbrev.
>> 
>> I think it is a good change to make %h follow --abbrev, but %H should stay
>> the full length no matter what (otherwise why would anybody use %H not %h?).
>
> But I thought the point of %h was to be abbreviated? If it follows
> --abbrev, then "git log --format=%h" would show the full sha1, no?

Sorry, but I meant that the point of %h was to be abbreviated and the
point of %H was not to be abbreviated.  So no matter whaqt --abbrev-commit
says on the command line, --format=%H should show the full commit object
name.

By the way, we should update Documentation/pretty-format.txt to use the
proper terminology.  Colloquial use "commit hash", "tree hash", etc. are
Ok but in a formal documentation we should consistently say "object name".
