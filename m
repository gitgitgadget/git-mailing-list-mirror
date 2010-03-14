From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'git add' regression in git-1.7?
Date: Sat, 13 Mar 2010 22:34:34 -0800
Message-ID: <7veijns96t.fsf@alter.siamese.dyndns.org>
References: <32541b131002182042p610fce4ex96efbffea9afe2ed@mail.gmail.com>
 <hll65c$87a$1@ger.gmane.org>
 <32541b131002182115t5501d0d1u19367a4d8e7627e4@mail.gmail.com>
 <20100219053431.GB22645@coredump.intra.peff.net>
 <20100219060249.GD22645@coredump.intra.peff.net>
 <20100219082445.GB13691@coredump.intra.peff.net>
 <7vhbp0ls26.fsf@alter.siamese.dyndns.org>
 <20100309223729.GA25265@sigill.intra.peff.net>
 <20100309230931.GC25265@sigill.intra.peff.net>
 <7veijsmza0.fsf@alter.siamese.dyndns.org>
 <20100311071543.GA8750@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>,
	SungHyun Nam <goweol@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 14 07:34:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqhPc-0005ZM-3x
	for gcvg-git-2@lo.gmane.org; Sun, 14 Mar 2010 07:34:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753050Ab0CNGeq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Mar 2010 01:34:46 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57169 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736Ab0CNGep (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Mar 2010 01:34:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 60D24A1468;
	Sun, 14 Mar 2010 01:34:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lX3K0oQh2CzwOX5rOAb2VRSWCjU=; b=mBGBrw
	24+Er3dMjIj8AA7cnSAIZz1aQH/Dv8/fko+1myyB6z6D6YEHakKtd7oFSi2ZsBOu
	UKGQehmCg2bVnJdDtj73bPZx5hkyqU/yaMaDPnsxEIEHXStSiodkCtZPLHIyJ7Q7
	tYXP/RJjmRMl2HBnRC8A/dna55D/L6CXJNOGw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u0Pcuj1jnnmikgGKF63UuAy1us4J/Ob1
	4jxzawhZG1753UACBc17VWzDU+XCt9r0CtVm6gg+iWn3DvJKH/I9J5L1TILNw+6b
	qGhxN1cyLyAXpDRUwsXvYApfU2JL/XebTnn6sEveuZihsrH7YAbWh5B3lBW22IzM
	Rupdq2GEUTg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D8D6A1467;
	Sun, 14 Mar 2010 01:34:41 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EDFB0A1466; Sun, 14 Mar
 2010 01:34:35 -0500 (EST)
In-Reply-To: <20100311071543.GA8750@sigill.intra.peff.net> (Jeff King's
 message of "Thu\, 11 Mar 2010 02\:15\:43 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AB721746-2F33-11DF-8C70-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142127>

Jeff King <peff@peff.net> writes:

> Another option is to declare the current behavior wrong. Letting the
> shell glob produces different results for obvious reasons:
>
>   $ git add b* ;# will fail, because we see individual pathspecs
>
> but perhaps that is the "feature" of letting add glob itself. Personally
> I have never asked "git add" to glob on my behalf, so I don't know why
> people would do it.

I know of one reason:

    $ git add '*.[ch]'

will add a/b.c and c/d/f.h for you.
