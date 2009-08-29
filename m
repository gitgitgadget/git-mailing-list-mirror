From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow testing of _relative family of time formatting and
 parsing functions
Date: Sat, 29 Aug 2009 14:46:53 -0700
Message-ID: <7vk50mz41e.fsf@alter.siamese.dyndns.org>
References: <4A97193A.8090502@facebook.com>
 <20090828060538.GA22416@coredump.intra.peff.net>
 <81b0412b0908280058i364bfb83nb04354d982abc053@mail.gmail.com>
 <20090828150212.GA6013@coredump.intra.peff.net>
 <alpine.LFD.2.00.0908281307510.6044@xanadu.home>
 <20090828190319.GA9233@blimp.localdomain>
 <20090828191521.GA12292@coredump.intra.peff.net>
 <81b0412b0908281220o1c378d5dn6ed52c8d55a9cdec@mail.gmail.com>
 <20090828193302.GB9233@blimp.localdomain>
 <20090828205232.GD9233@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Nicolas Pitre <nico@cam.org>,
	David Reiss <dreiss@facebook.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 29 23:47:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhVlV-0002Y7-H2
	for gcvg-git-2@lo.gmane.org; Sat, 29 Aug 2009 23:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752574AbZH2VrH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Aug 2009 17:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752561AbZH2VrH
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Aug 2009 17:47:07 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64387 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752480AbZH2VrG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Aug 2009 17:47:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A9DA1DF9F;
	Sat, 29 Aug 2009 17:47:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=UmlwhS2lM0kjd/B5Zf2y0hJ8pDA=; b=EXtWLT
	D+BeGHL2CeGporlEri5yxHUb2kDeeD8PuooGqIMF50M6c7tsryCYUiuziRgLxnSe
	AJV7s9e26g8ryCtc9jOJA0wIPeCFpOsklbCV+hhCRdIMrp3onBxJFQeYfk22saoh
	O+lEXGGT9p99qcoWwCiU7Ut9+CSJ2cnWM+q5M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tkY4JeDfJSIUpIqoR7WOEl1lHoIGm9XW
	LCNEsASBPq/tHOENWw8KiXpZfAZ+AZiTa493HevygschlIQiBiPrLTXkEvrlZVZl
	eQTxMPajfe/XLlfpqHlZwVndR77jq7v3BVlbtt2ZhMu2VVnoGe6viFLJW8t5f1uW
	TMCIuy8ftj4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1346B1DF9E;
	Sat, 29 Aug 2009 17:47:01 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 27EA51DF9C; Sat, 29 Aug
 2009 17:46:55 -0400 (EDT)
In-Reply-To: <20090828205232.GD9233@blimp.localdomain> (Alex Riesen's message
 of "Fri\, 28 Aug 2009 22\:52\:32 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7BA48910-94E5-11DE-A565-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127385>

Alex Riesen <raa.lkml@gmail.com> writes:

> To complement the testability of approxidate.
> ---
> Alex Riesen, Fri, Aug 28, 2009 21:33:02 +0200:
>> 
>> It should allow safe testing of this part of the code.
>
> And this should really allow testing of it:
>
>     $ ./test-date '10.days.ago'
>     10.days.ago -> bad -> Thu Jan  1 01:00:00 1970
>     10.days.ago -> Tue Aug 18 22:50:20 2009
>
>     relative: 10.days.ago -> Fri Dec 22 12:00:00 1989
>
>     relative: 10 days ago, out of Fri Dec 22 12:00:00 1989
>
>     $

What are these blank lines for?  Is this intended as a serious submission
for inclusion?  I am having a hrad time to guess, especially you did not
sign this off, nor Cc'ed me.
