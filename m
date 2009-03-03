From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc: clarify how -S works
Date: Tue, 03 Mar 2009 08:42:12 -0800
Message-ID: <7v1vted0d7.fsf@gitster.siamese.dyndns.org>
References: <49AD3E78.1050706@sneakemail.com>
 <20090303152333.GB24593@coredump.intra.peff.net>
 <20090303154041.GA31265@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Valdemar =?utf-8?Q?M=C3=B8rch_=28Lists=29?= 
	<4ux6as402@sneakemail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 03 17:44:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeXig-0003HS-T7
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 17:43:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754813AbZCCQmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 11:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbZCCQmU
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 11:42:20 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49744 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896AbZCCQmU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 11:42:20 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id BFC533512;
	Tue,  3 Mar 2009 11:42:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0CE363511; Tue, 
 3 Mar 2009 11:42:13 -0500 (EST)
In-Reply-To: <20090303154041.GA31265@coredump.intra.peff.net> (Jeff King's
 message of "Tue, 3 Mar 2009 10:40:41 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 42052A80-0812-11DE-A55F-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112114>

Jeff King <peff@peff.net> writes:

> I wonder if "gitdiffcore" is a little scary for new people who just want
> to use "-S", but hopefully point (1) above will get rid of most of the
> confusion, and those who follow the link want to learn all about diff.

As I mentioned in the other message, what --pickaxe achieves is very
different from what people would naturally want from --search, an
option that does not exist.

I do not mind a patch that adds a diffcore transformation that internally
generates a diff and searches the string given by the user in it, and
triggers that with --search option.  The transformation should come just
after (or before) the pickaxe in the call sequence inside diffcore_std();
name it diffcore_search() or something.

In retrospect, because --pickaxe was designed primarily for Porcelain use,
it was a mistake for it to have taken a short-and-sweet -S synonym.

> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 813a7b1..9276fae 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -176,7 +176,10 @@ override configuration settings.
>  	number.
>  
>  -S<string>::
> -	Look for differences that contain the change in <string>.
> +	Look for differences that introduce or remove an instance of
> +	<string>. Note that this is different than the string simply
> +	appearing in diff output; see the 'pickaxe' entry in
> +	linkgit:gitdiffcore[7] for more details.

Look for differences that change the number of occurrences of <string>?
