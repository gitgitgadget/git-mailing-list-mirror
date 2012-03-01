From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH-w 101/105] t6300 (for-each-ref): modernize style
Date: Wed, 29 Feb 2012 18:13:53 -0800
Message-ID: <7v62epqd9a.fsf@alter.siamese.dyndns.org>
References: <1330566326-26075-1-git-send-email-tmgrennan@gmail.com>
 <1330566326-26075-7-git-send-email-tmgrennan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Carlos Rica <jasampler@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Amos Waterland <apw@rossby.metr.ou.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Tom Grennan <tmgrennan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 03:14:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2vWt-0003ai-C0
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 03:14:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756864Ab2CACN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 21:13:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63329 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756530Ab2CACN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 21:13:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C5C27D08;
	Wed, 29 Feb 2012 21:13:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dgVExBB7JoZnAWYH6osiWWk/jSY=; b=c3qwXH
	BCNCG51rEs9A2rRAcNB0ZT92/lMNENm2hJXPORNWxDzI9TJVkoLWg/JSEe5rIdoI
	+cpOR9pCo/t+Pn87TaQikzIC7lutmDkYnbHXk/Lhu3+Aa3hOaC+lQ56Ftu0K0cOo
	C/Uwhql5GTs95itiLuskYokOV4oJnfDM7SFls=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Gxei+wbi8XmZ/5NeoG77pr/hhqtO4Mwb
	JatQugZhubVRqFUH8eagaV6KVyV/fBjXfBE6gMPCA6NNtsszY9mUJ0EIkZyAaoPx
	8CoFZysoVZt/ivrY7cDVpHnRO6S8gse7hj2Hw6lyKdbpp3KVxxviWbDLWIH6jNAA
	UMNzl6S6gs0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4085F7D07;
	Wed, 29 Feb 2012 21:13:56 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 42F5C7D04; Wed, 29 Feb 2012
 21:13:55 -0500 (EST)
In-Reply-To: <1330566326-26075-7-git-send-email-tmgrennan@gmail.com> (Tom
 Grennan's message of "Wed, 29 Feb 2012 17:45:22 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 32724B12-6344-11E1-AE6F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191884>

Tom Grennan <tmgrennan@gmail.com> writes:

> +if ! test -r test-lib.sh ; then
> +	(cd ${0%/*} && ./${0##*/} $@)
> +	exit $?
> +fi

Not very nice; why is this an improvement?

>  . ./test-lib.sh
>  . "$TEST_DIRECTORY"/lib-gpg.sh
>  
> +quiet () { "$@" >/dev/null; }
> +silent () { "$@" >/dev/null 2>&1; }

Not nice, either.

>  # Mon Jul 3 15:18:43 2006 +0000
>  datestamp=1151939923
>  setdate_and_increment () {
> @@ -22,9 +30,9 @@ test_expect_success 'Create sample commit with known timestamp' '
>  	setdate_and_increment &&
>  	echo "Using $datestamp" > one &&
>  	git add one &&
> -	git commit -m "Initial" &&
> +	git commit -q -m "Initial" &&
>  	setdate_and_increment &&
> -	git tag -a -m "Tagging at $datestamp" testtag
> +	quiet git tag -a -m "Tagging at $datestamp" testtag

Why? Why? Why?

	cd t && sh ./t1234-frotz.sh

would be silent enough and suppressing the output from the commands like
this patch does makes it _harder_ for people to debug their changes to the
script with

	sh ./t1234-frotz.sh -v

Most of the change in this patch does nothing to do with "modernize style".
