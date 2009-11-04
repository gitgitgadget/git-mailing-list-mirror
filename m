From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Set Makefile variables from configure
Date: Wed, 04 Nov 2009 11:56:57 -0800
Message-ID: <7vy6mmf4hi.fsf@alter.siamese.dyndns.org>
References: <20091103222123.GA17097@progeny.tock>
 <1257357960-12763-1-git-send-email-bwalton@artsci.utoronto.ca>
 <7v7hu6gjzz.fsf@alter.siamese.dyndns.org>
 <1257363937-sup-5123@ntdws12.chass.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, jrnieder <jrnieder@gmail.com>,
	git <git@vger.kernel.org>
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Wed Nov 04 20:57:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5lyz-00046c-8o
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 20:57:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758065AbZKDT5G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 14:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758045AbZKDT5F
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 14:57:05 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55774 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757901AbZKDT5D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 14:57:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 504D373F8B;
	Wed,  4 Nov 2009 14:57:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1SmfJxvsQPOTyKJhTV21IYdIxW0=; b=ZvLAmF
	1zCrkMLm/TMrcXaKKPdrLp6YTiGe9QjxWaQgHc7gd9MCqDt1QZUzgAZw1CbCPy8A
	aBKev01VLkBdm8RAcbVXrGyRqqJnX4U8gInginApLpkkcKVQUTX6Euxmt1dc+UsO
	uRSVESePS6A1k8zRxBQafTaYMFGlWjaBU+qh0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TUeUkDIcpPt8p29IuIafpMnYUthW03bR
	VH9eDRPeIDuSMuFTzP7vXOAMaAM8xU5cZ7VvA69gTcVsaSNfLKd2k1DjmOc0b+et
	zT4j+QQViWygkOl/pCcjZvrGzaQrfcRJ0LZKmGjKa0fmyHe7weICKhgPKUQGQ3TZ
	enKhCiT+zM8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 213B473F8A;
	Wed,  4 Nov 2009 14:57:05 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4D14973F89; Wed,  4 Nov
 2009 14:56:58 -0500 (EST)
In-Reply-To: <1257363937-sup-5123@ntdws12.chass.utoronto.ca> (Ben Walton's
 message of "Wed\, 04 Nov 2009 14\:47\:45 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 39D49CDE-C97C-11DE-82D0-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132136>

Ben Walton <bwalton@artsci.utoronto.ca> writes:

> Excerpts from Junio C Hamano's message of Wed Nov 04 14:36:32 -0500 2009:
>
>> I am a bit puzzled about the "warning" logic.  Is this because you expect
>> variables we typically give YesPlease/NoThanks as their values will not be
>> handled with this new PARSE_WITH_SET_MAKE_VAR() macro?
>
> No, this is because it's perfectly acceptable, in my opinion for a
> user to say:
>
> --with-pager=no
> or
> --with-editor=yes
>
> Neither of those are smart things to do, but they're not necessarily
> wrong, either.  I'm open to bailing on error for these, but I thought
> leaving these as unvalidated, but with a warning, was more
> flexible...if say a user wanted to have a pager called 'no' or
> something.

What puzzled me was not "why is it not an error but just a warning?", which
is what you just explained, but "why should we even care what value is
being given to begin with?".

I am _not_ saying "I think it is more correct not to check the value at
all".  I just wanted to understand in what situation it may be benefitial
to give this warning in the first place.

> For the variables that are accepting YesPlease/NoThanks, I think it's
> more suitable to use the standard autoconf header/function/library
> detection as it stands now.  This macro is more for 'oddball'
> variables like DEFAULT_PAGER, DEFAULT_EDITOR, etc that aren't
> necessarily easily detectable.  In some cases, even if it were
> detectable, the detection might not be right.

I am guessing from this description of 'oddball variables' that your
answer to my question is yes.  That is, configure.ac writers are strongly
discouraged from using this new macro for variables that would usually get
YesPlease/NoThanks kind of values.

And then it makes sense to warn 'yes/no', as it is unlikely that the user
wants to set name (or path) of programs we allow to be tweaked to 'yes' or
'no'.
