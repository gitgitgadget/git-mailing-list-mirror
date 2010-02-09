From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9302: Protect against OS X normalization
Date: Mon, 08 Feb 2010 23:05:19 -0800
Message-ID: <7vr5ouopn4.fsf@alter.siamese.dyndns.org>
References: <7vfx5bt6nn.fsf@alter.siamese.dyndns.org>
 <1265688445-46137-1-git-send-email-brian@gernhardtsoftware.com>
 <20100209060845.GD14736@coredump.intra.peff.net>
 <7vocjyq4qq.fsf@alter.siamese.dyndns.org>
 <20100209065845.GA6503@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 09 08:05:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NekAC-0005Va-Sb
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 08:05:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753261Ab0BIHFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 02:05:32 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62969 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961Ab0BIHFb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 02:05:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1ABA4979A7;
	Tue,  9 Feb 2010 02:05:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Pug4wBhZRyxmpSwC4o/TZlIHl8g=; b=a/8LA9
	p9Y9vOn9rn+TApwyzbrNDMFh9dM+7WW8RG+RknzSZRXUfHeEsQIMFAoauyCjePsK
	LL+RVMqMVjcL1RS5GJWv0Rso009vxzTHj9xJWBV6XaxaIADfgwCX/1hgMDfxDTMc
	ppweKk/0aWRRXLQZqUI9H0tftnnNtdnFX3Vro=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vf1iIiFGDl5NKr1DkpiWhoSm6SFrMa+W
	Sr0skWSYwKMFjczfxwmGsz1qlvG1T6dXbgis5AnZ0+Dcraoja70PYgCRC3a38yEI
	y/gHFtetVsDk2ATF72ipRghMWEok7XHF995XHoCyZW+ggTLRjxhJCK0zNI88oG+M
	GAK4YPujs0Y=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DA496979A6;
	Tue,  9 Feb 2010 02:05:24 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2A2A2979A5; Tue,  9 Feb
 2010 02:05:21 -0500 (EST)
In-Reply-To: <20100209065845.GA6503@sigill.intra.peff.net> (Jeff King's
 message of "Tue\, 9 Feb 2010 01\:58\:45 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7ECE4ECA-1549-11DF-8F4D-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139376>

Jeff King <peff@peff.net> writes:

> On Mon, Feb 08, 2010 at 10:53:49PM -0800, Junio C Hamano wrote:
>
>> I think there is no reliable reproduction recipe for this, as we don't
>> control what garbage is in the tail of malloc'ed memory; valgrind would
>> have found it, though.
>>
>> Let's revert the test part of the patch.
>
> IMHO, valgrind finding it is reason enough to keep it. We do run the
> test suite against valgrind from time to time, and clearly this code
> path was not being exercised prior to this (or my previous valgrind runs
> would have caught it).
>
> I think Brian's patch is the best thing to do.

Having Brian's patch would not hurt, and it definitely is an improvement
than using a name OSX cannot cope with, so I'll apply it nevertheless.

FWIW, neither the updated test nor your French test does not trigger for
me after reverting the "quote.c" part from 8424981 without valgrind.

Thanks for helping me think this through.
