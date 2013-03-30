From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug in "git rev-parse --verify"
Date: Fri, 29 Mar 2013 21:15:23 -0700
Message-ID: <7vfvzdr09w.fsf@alter.siamese.dyndns.org>
References: <51543FDB.9010109@alum.mit.edu>
 <CAPc5daUqzz=9TBmj2Q0MHqEc6gMHxXoGr9+JV3hq76zDKJAyCw@mail.gmail.com>
 <515462FB.9040605@alum.mit.edu> <20130328153808.GB3337@sigill.intra.peff.net>
 <7vli97v558.fsf@alter.siamese.dyndns.org> <51565F96.1020203@alum.mit.edu>
 <7vk3opr0ke.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <junio@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Mar 30 05:16:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULnD1-0003mR-ER
	for gcvg-git-2@plane.gmane.org; Sat, 30 Mar 2013 05:16:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557Ab3C3EP1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Mar 2013 00:15:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45260 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750997Ab3C3EP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Mar 2013 00:15:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1AC93FFBD;
	Sat, 30 Mar 2013 04:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M32rxskpM5JsuEYHE4kgXfieeQ8=; b=X0WzPq
	vmpNlAFX7nII+WzpOp04KM59234NDibv1eIfA2sEDLQKNbALrgdInxZhzPKD8iJ6
	67fD+TdkrUMNKfc79OAcSAShiv8tbpQWbxXSqulHDlsclo3fqK9Nug39IdYHltsm
	+mdxElUM57tVHZJ+oZWFWSbcmKyFU8OGNjByA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s+avtoZzkbONYtHwmhRqz2N/xvCcAd8J
	P3dbIG7m+ekNq9EESM8CBsDJUWl2zOwjERFNeZnvAVS5Nqo2qHosi1L+3dhmK2S1
	hHOt8QmMmoBKi84Prf+LZ+MD0viKbxbLAZIGlmX0exADZ3hxxiCWWJz02WJOLnSU
	7/NAu61NcTI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F9EEFFBC;
	Sat, 30 Mar 2013 04:15:26 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7AB7AFFBB; Sat, 30 Mar 2013
 04:15:25 +0000 (UTC)
In-Reply-To: <7vk3opr0ke.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 29 Mar 2013 21:09:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7280D5F6-98F0-11E2-B6F7-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219554>

Junio C Hamano <gitster@pobox.com> writes:

>> 3. Verifying arguments at one spot centralizes error-checking at the
>> start of a script and eliminates one reason for random git commands to
>> fail later (when error recovery is perhaps more difficult).
>
> Not necessarily, unless your script is a very narrow corner case
> that is satisfied with "any kind of object goes".

Clarification.  I meant "A single central point to check is a useful
concept, but centrally checking 'does this exist? I do not care what
it is' is not necessarily useful and I suspect it is not useful more
often than it is".  When you care if something exists, you often
want to know what it is and other aspects of that thing at the same
time.
