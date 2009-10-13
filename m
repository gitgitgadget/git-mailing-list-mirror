From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch when
 appropriate to do so
Date: Tue, 13 Oct 2009 01:44:53 -0700
Message-ID: <7v7huzznqy.fsf@alter.siamese.dyndns.org>
References: <0016e68fd0123a175304754694b4@google.com>
 <200910122340.13366.trast@student.ethz.ch>
 <7vr5t89qiw.fsf@alter.siamese.dyndns.org>
 <200910130836.57011.trast@student.ethz.ch>
 <7vljjf226t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	<Euguess@gmail.com>, Mikael Magnusson <mikachu@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	<git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 10:52:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxd6o-0006mR-SH
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 10:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759194AbZJMIqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 04:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759130AbZJMIqY
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 04:46:24 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41290 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759108AbZJMIqW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 04:46:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 912BC6F17C;
	Tue, 13 Oct 2009 04:45:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X17I5fwd7BnsErLwBuL3uRC/fOI=; b=Dny+wY
	+dbvDLjFQrC1CHo54ThzdU+Zd1+MRBx1AhzvsAyTpGwKj/3P9GGnCuzgF5/8IJRV
	vxLvtU1Y+c7Sji4sqUhnl0Tod/2iDQYwyb/e/ILjYxDZjoYTjLdJ6hGYciqRxuRN
	wl4vZcspJgEEd+XGWhydpojlurtJLXhIxZgwA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GqHDMOh+tmzlwupfs28/VI4iCuIBuckR
	9IZB51xowo80QF8OGhSsl1Wask0/E7shRuYxhfaU8239pHKWBAB7HZATvLUl7f9g
	Dh/PZraXae0mDBXCXrCl4YMW4Uf4u/CzoQwAb6H5jvyT0ocZxlGlVkHXHw1QQ1pV
	MiJG2nc307s=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2CD156F17B;
	Tue, 13 Oct 2009 04:45:07 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 402156F175; Tue, 13 Oct 2009
 04:44:54 -0400 (EDT)
In-Reply-To: <7vljjf226t.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue\, 13 Oct 2009 00\:16\:58 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B55D2B6E-B7D4-11DE-9D19-A730BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130147>

Junio C Hamano <gitster@pobox.com> writes:

> So we need the set of new rules, say, for 1.7.0 release.  A strawman?
>
> Assume that these are the only refs that exist:
>
>     refs/remotes/origin/{master,next,nitfol}
>     refs/remotes/xyzzy/{frotz,nitfol}
>     refs/heads/master

Sorry, I had this as refs/heads/{master,mine} in my initial draft but
removed the 'mine' branch by mistake; the first item in #0 does not make
sense without it.

>     refs/tags/v1.0.0
>
> #0. These will stay as is:
>
>  $ git checkout mine               ;# switches to the branch
>  $ git checkout $any_committish^0  ;# detaches
>
> #1. These used to detach, but will create a local branch
>
>  $ git checkout origin/next        ;# as if with -t
>  $ git checkout xyzzy/frotz        ;# as if with -t (origin is not special)
>
> #2. These are allowed only when unambiguous and there is no local branch yet.
>
>  $ git checkout next               ;# ok
>  $ git checkout frotz              ;# ok (origin is not special)
>  $ git checkout nitfol             ;# not ok (ambiguous and origin is not special)
>
> #3. These used to detach, but what should we do?
>
>  $ git checkout v1.0.0             ;# detach, or refuse???
>  $ git checkout origin/master      ;# detach, or refuse???
>
> I can buy 0, 1, and 2, and I think it is a minor inconvenience if we
> started refusing to detach in case #3, as people who want to detach can
> always suffix ^0 or ~0 to make it a general committish.
>
> Did I cover all cases?
