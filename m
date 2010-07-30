From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] tests: WIP Infrastructure for Git smoke testing
Date: Fri, 30 Jul 2010 09:13:58 -0700
Message-ID: <7v39v1rlq1.fsf@alter.siamese.dyndns.org>
References: <1280438455-16255-1-git-send-email-avarab@gmail.com>
 <20100730123443.GA11936@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Mike Ralphson <mike.ralphson@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 30 18:14:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OesE7-0004Yq-0u
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 18:14:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801Ab0G3QOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 12:14:12 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63130 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192Ab0G3QOK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 12:14:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B9707C7C60;
	Fri, 30 Jul 2010 12:14:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UQKYrbzl21eB+1DoBdhFaOGhAWA=; b=KELvOW
	7+JCv/eqRJmNtU+UQ9SU2ck2Zb7tsGT2FDQd+p0mEZJNWjTUYELrp4+9wWw1jy2i
	hT/gsuwhOrnT/X63lXpETa7bv2+e4Rm1t/KKuzl1U/3BU5WkRaLbRv5Rs+j5N2BK
	fuiD9DgOstxv4kSgBrdDDt7L6h/yJLmBOukcA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uW1k9rDFWjrTCWYgdkYxwbGFHgD/DC6q
	3LqDi5k/bw3a139fxdFU2lAXqQ667YkDrv2JDCLFrp+X2vOn3hhMguRuK4HNUHv1
	CzyBXxpFGMut8hRQWujAp8MHixsElCI+FCXmXRdpZOq8yIaUdplnjCUKKZQzVk6S
	kY0Kzn30rZI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 74654C7C5D;
	Fri, 30 Jul 2010 12:14:05 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A092DC7C5A; Fri, 30 Jul
 2010 12:14:00 -0400 (EDT)
In-Reply-To: <20100730123443.GA11936@coredump.intra.peff.net> (Jeff King's
 message of "Fri\, 30 Jul 2010 08\:34\:43 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 79A4257C-9BF5-11DF-9CF4-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152250>

Jeff King <peff@peff.net> writes:

> I think these days Junio runs the test suite through a couple of VMs,
> but I don't know exactly which platforms, or how often he does so.

The normal "before push-out" procedure for me is:

 - On Debian5 (x86_64 -- this is my primary box): build, build docs, run
   tests, install for all four integration branches (Dothem script from
   'todo' branch, whose checkout I have in Meta/, is used for this).

 - Push the four branches and run Dothem on k.org's FC11 (x86_64).

 - VMs running FC11 (i386) and FBSD80 (i386) run the same "Dothem" script,
   modulo that t9xxx series of tests which take too much time are skipped,
   when all four branches passes tests on my primary box successfully.

I push the result out after the four branches are Ok on my primary box and
k.org's FC11 (iow, I do not wait for VM tests to finish).
