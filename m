From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fwd: possible Improving diff algoritm
Date: Wed, 12 Dec 2012 13:53:51 -0800
Message-ID: <7vpq2f2az4.fsf@alter.siamese.dyndns.org>
References: <CAO54GHC4AXQO1MbU2qXMdcDO5mtUFhrXfXND5evc93kQhNfCrw@mail.gmail.com>
 <CAO54GHD3C2RKUvE5jK_XOCVbbDuE_c5xfe28rOL+DaE5anL-Wg@mail.gmail.com>
 <7vvcc73yzh.fsf@alter.siamese.dyndns.org>
 <CANv4PNm45xGBn2veKi1o0wB4K9NgsbtCsiymHNO4xbCDpJ5tDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin <ikke@ikke.info>, git <git@vger.kernel.org>
To: Morten Welinder <mwelinder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 22:54:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiuFp-0001VC-Rp
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 22:54:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755402Ab2LLVx4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 16:53:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47603 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755378Ab2LLVxz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 16:53:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 29B1995A3;
	Wed, 12 Dec 2012 16:53:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HbGzDSRPzvmi/9UZitGi2HRmUcw=; b=MYNyo4
	0AKOm0Ccprh6liEKwfO7fPCeueQSuTy2hUwTdlE5MDVFZeHbowMyKWSpay4RFPoQ
	hLa4Q2zUGauZUugH/wCmolFqj0DzxhZT73GpDKbM2w/am3Qyu2oLxxEtzZXAjUlV
	2vmaA+SI0JyKzIV9Ya/YJgsPeUDUN7mQU1izk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dAaEOio9z4I3CRT/MZni65/ONrZbMrQA
	pcmVXzUtrsR74DM0L+ZRtV+BfQJc0QCOJ0RlCiu9ck+OexMRwDHKxA+IQeEf0hR4
	kuVC8+fcnax49sk03F/MjfYA+f3zZzzEWHgf6tbl4Y7qoI1J6NDsTih24WoLjXFP
	l5OznDMKmbc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 160EA95A2;
	Wed, 12 Dec 2012 16:53:54 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8364795A1; Wed, 12 Dec 2012
 16:53:53 -0500 (EST)
In-Reply-To: <CANv4PNm45xGBn2veKi1o0wB4K9NgsbtCsiymHNO4xbCDpJ5tDg@mail.gmail.com> (Morten
 Welinder's message of "Wed, 12 Dec 2012 16:40:32 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6BA042B0-44A6-11E2-939D-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211396>

Morten Welinder <mwelinder@gmail.com> writes:

> Is there a reason why picking among the choices in a sliding window
> must be contents neutral?

Sorry, you might be getting at something interesting but I do not
understand the question.  I have no idea what you mean by "contents
neutral".

Picking between these two choices

         /**                         +    /**                         
    +     * Default parent           +     * Default parent           
    +     *                          +     *                          
    +     * @var int                 +     * @var int                 
    +     * @access protected        +     * @access protected        
    +     * @index                   +     * @index                   
    +     */                         +     */                         
    +    protected $defaultParent;   +    protected $defaultParent;   
    +                                +                                
    +    /**                              /**                         

would not affect the correctness of the patch.  You may pick
whatever you deem the most desirable, but your answer must be a
correct patch (the definition of "correct" here is "applying that
patch to the preimage produces the intended postimage").

And I think if you inserted a block of text B after a context C
where the tail of B matches the tail of C like the above, you can
shift what you treat as "inserted" up and still come up with a
correct patch.

The output being "a correct patch" is not the only thing we need to
consider, though, as I mentioned in another response to Kevin
regarding the "consequences".
