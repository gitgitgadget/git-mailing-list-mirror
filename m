From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Add "%w" to pretty formats, which rewraps the commit
 message
Date: Wed, 23 Sep 2009 16:19:26 -0700
Message-ID: <7v63b9gsg1.fsf@alter.siamese.dyndns.org>
References: <7vfxaercma.fsf@alter.siamese.dyndns.org>
 <1253655038-20335-1-git-send-email-heipei@hackvalue.de>
 <alpine.DEB.1.00.0909232232050.4985@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0909232232560.4985@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0909232233330.4985@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0909232233590.4985@pacific.mpi-cbg.de>
 <20090923210055.GA25197@dualtron.vpn.rwth-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Gilger <heipei@hackvalue.de>
X-From: git-owner@vger.kernel.org Thu Sep 24 01:19:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mqb7f-0003Kw-FQ
	for gcvg-git-2@lo.gmane.org; Thu, 24 Sep 2009 01:19:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881AbZIWXTe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2009 19:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751837AbZIWXTe
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Sep 2009 19:19:34 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38763 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618AbZIWXTd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2009 19:19:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DD4F55CFD4;
	Wed, 23 Sep 2009 19:19:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HT59UIaPsSajIy200iZmjq8KZ20=; b=M+q58Y
	F+pLQxOfNDJ8ySgP/V9Ufb9ePXwRpuYEeDvFkF3JFlH6GtVJ0SIFeKlNQHj9CWvP
	mCyJ2J+P+6xEgwEtClu9oPPzBMoXW9oICJVhXEiE4oMbjDflmPwGVaVyKaQBt5uH
	dDlvmQMosyt5Aq+2GTkJzywJ1Jh3IFa5Ifa4s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UFcd7JJESttqoJUNQt81Zmy2UhEC1fM3
	8XL3ExTT9PHhS9KkdJD8+HhgY8yRZnTH5Bkr6b01ebLzlysFqAGRsct5/OiQQHAh
	Fw3+pcdBbHKf3iP50Ck3WPhyxJguBOlzIbAp9kPS+p3yKaSJn11eGrajCx4Y0u+i
	w8MKFso8RXE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AF2AE5CFD3;
	Wed, 23 Sep 2009 19:19:32 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3864B5CFD1; Wed, 23 Sep 2009
 19:19:27 -0400 (EDT)
In-Reply-To: <20090923210055.GA25197@dualtron.vpn.rwth-aachen.de> (Johannes
 Gilger's message of "Wed\, 23 Sep 2009 23\:00\:56 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8CFE3AA6-A897-11DE-9E6C-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129011>

Johannes Gilger <heipei@hackvalue.de> writes:

> ... One thing that bothers 
> me about the %w flag is that is includes subject and body, when we 
> already have atoms for both of these flags. So having a subject(x,y) and 
> body(x,y) tag (where x is indent and y is textwidth to be rewrapped) 
> would be nicer and more in the spirit of the existing format options 
> imho.

I do not particularly like this %w() either, and would prefer to see an
equivalent solution using combination of %S(i,j,w) and %B(i,j,w).  Your
%B(n) can be extended to do the same as Johannes's wrapping variant when
given three parameters and you can trivially do the same for %s to produce
%S(n) and %S(i,j,w).

One issue %w() sidesteps is handing of single liner commit log messages
(this is not a new issue your %B(n) introduces).  "%s%n%b" will give us
the original message only when the log has some contents in addition to
the single-line summary.  Otherwise we will get an extra blank line.

Perhaps we could extend the pretty-printer so that it understands %+x
notation, which expands to %n%x when %x expands to a non-empty result, and
otherwise it expands to empty, as a generic extension applicable to any
format specifier 'x'.  If we have such a notation, "%s%+b", would be a
reasonable way to say "give us the original commit log message here", and
we won't need %w(i,j,w) -- we can instead say %S(i,j,w)%+B(i,j,w), or
%s%+B(i,j,w) depending on what you want.
