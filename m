From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2009, #04; Sun, 23)
Date: Mon, 24 Aug 2009 15:03:21 -0700
Message-ID: <7vy6p86f9y.fsf@alter.siamese.dyndns.org>
References: <7v1vn2qb29.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0908232117460.6044@xanadu.home>
 <YE4QMh4rA1r2X3ZG5TvGJZspm0UdCWyP-r6KFthp8PuFewAhHPJ3GQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Aug 25 00:03:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mfhdb-0000KY-7O
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 00:03:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753518AbZHXWD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 18:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753517AbZHXWD2
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 18:03:28 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38537 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753082AbZHXWD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 18:03:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 122461780B;
	Mon, 24 Aug 2009 18:03:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=D6++j0ncp4fYWagf8QH+MDSZR34=; b=depVOm
	ALTm9F+4yQbWKZQwbKqrVz3QFPSFMfz5Onhpy9BYWZpFnF+PCfkENjtq3N2uY/14
	dJhLdHulJqJcLbalYi+IbWy5jVVfPtb+WEjKTttO79EGQK9fqHFWEjn3Oxvj68jP
	vRVVYw5E0TDq2IXvuFXz6p6PRmG60j7k8pcU4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aj3ZTmLJfb5nri47UG43OuW+vV9l10y+
	pA8mm2qkigpxZS3s/AszoBDABpex97lTbjHs2v3m5+J+TeW2NdWEZ+ERIFdYmfmd
	jz09CY7WvbbFh49+XDnKNXtxLQTGeGrbZyGlzi2zBH1nnIFzCgQ6USjlY28txlS4
	70b+kaeZTwk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D480717807;
	Mon, 24 Aug 2009 18:03:26 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 24A5A17806; Mon, 24 Aug
 2009 18:03:23 -0400 (EDT)
In-Reply-To: <YE4QMh4rA1r2X3ZG5TvGJZspm0UdCWyP-r6KFthp8PuFewAhHPJ3GQ@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Mon\, 24 Aug 2009 16\:29\:00 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F3281DE8-90F9-11DE-B971-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126974>

Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil> writes:

> Nicolas is right, the code compiles and executes correctly on Solaris as-is.
>
> Here is the state of the two unsubmitted optimization patches:
>
>   1) Change things like __i386__ to __i386 since GCC defines both, but
>      SUNWspro only defines __i386.
>
>      This works correctly in my testing.  I'm assuming that a test for
>      __amd64 is not necessary and expect that __x86_64 is set whenever
>      __amd64 is set.
>
>   2) Set __GNUC__ on SUNWspro v5.10 and up.
>
>      This compiles correctly and passes the test suite, but produces
>      warnings for __attribute__'s that sun's compiler has not implemented.
>      This produces a very noisy compile.
>
> I've wanted to do some performance testing to see whether this actually
> produces an _improvement_.  I'll try today.

Thanks.

I agree (1) would be a reasonable thing to do.

(2) feels very iffy/hacky.  As far as I can see, by defining __GNUC__,
Solaris would also use builtin-alloca in compat/regex/regex.c, which may
or may not be what you want.

It might be cleaner to do:

	#if __GNUC__ || SUNWspro > 5.10
        #define GCC_LIKE_INLINE_ASM
        #define GCC_LIKE_STMT_EXPR
        #endif

and use them, instead of __GNUC__, to enable the inline assembly used in
the block sha1 codepath.
