From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Should "git apply --check" imply verbose?
Date: Tue, 20 Aug 2013 14:43:56 -0700
Message-ID: <xmqqtxikujfn.fsf@gitster.dls.corp.google.com>
References: <5213873A.6010003@windriver.com>
	<xmqqioz06y9m.fsf@gitster.dls.corp.google.com>
	<5213B95D.3040409@windriver.com>
	<xmqqzjsc5ggp.fsf@gitster.dls.corp.google.com>
	<20130820151554.6afbcb7f@gandalf.local.home>
	<7v7gfgkuyo.fsf@alter.siamese.dyndns.org>
	<20130820155433.217abb3e@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	<git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
X-From: git-owner@vger.kernel.org Tue Aug 20 23:44:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBtii-0007Am-Q0
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 23:44:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779Ab3HTVoD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 17:44:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45322 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751753Ab3HTVn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 17:43:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3D383A47A;
	Tue, 20 Aug 2013 21:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dMA/vTRNsXFJoauvX/LN4UhfmQI=; b=Zl/1qn
	TH04dP4QToMdl9mbJHXiHcySvBFxrLtpxAadv2HnvzzlDhSlzGXN1uJDWUsPwzOx
	Ng09jsZrpMcYPBpdNORRgo+EwHY6g3VzdN8xc8xiM1sNEQ4E3L/i2wh6XTCQ2CwZ
	FeWbJQfUeNmq84CPVXExpmtpoyiLc/CO3z2Rg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y63Dle1y2s+nQlcqbF4ac67gFo9QbMY8
	Q8vyxH5PUv0ccboeKRhHWZAuAbwmhss2MEny/ZJ0kf2OtBRxP1KlAX3hJlDpDT8x
	GREkDRG7TQ//ucNxSZGK5YXdDQ3geX01502xuAP9hSIr4RO4S2skvwrTpoCLTtbW
	hrx7PE3rjlg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E75DA3A478;
	Tue, 20 Aug 2013 21:43:58 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3EC233A476;
	Tue, 20 Aug 2013 21:43:58 +0000 (UTC)
In-Reply-To: <20130820155433.217abb3e@gandalf.local.home> (Steven Rostedt's
	message of "Tue, 20 Aug 2013 15:54:33 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9E7F2E3E-09E1-11E3-A698-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232651>

Steven Rostedt <rostedt@goodmis.org> writes:

>> > Linus told me that "git apply" was basically a replacement for patch.
>> > Why would you think it would not be a good idea to assume that people
>> > would not be familiar with how GNU patch works?
>> 
>> The audience of Git these days are far more widely spread than the
>> kernel circle.  I am not opposed to _helping_ those who happen to
>> know "patch", but I was against a description that assumes readers
>> know it, i.e. making it a requirement to know "patch" to understand
>> "apply".
>
> Patch is used by much more than just the kernel folks ;-)  I've been
> using patch much longer than I've been doing kernel development.

Yeah, I was familiar with "patch" when I started Git, too ;-).

But only folks in the kernel circle will be told by Linus the
similarity between apply and patch, no?

In any case...

>> In other words, your enhancement to the documentation could go like:
>> 
>> 	... By default, ... With this option, you will additionally
>> 	see such and such and such in the output (this is similar to
>> 	what "patch --dry-run" would give you).  See the EXAMPLES
>> 	section to get a feel of how it looks like.
>> 
>> and I would not be opposed, as long as "such and such and such" are
>> written in such a way that the reader does not have to have a prior
>> experience with GNU patch in order to understand it.

... I forgot to also add: And by mentioning "similar to", people who
are familiar with "patch" are also helped by their pre-existing
knowledge, so both kinds of people win.

Thanks.
