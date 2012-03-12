From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for
 push.default
Date: Mon, 12 Mar 2012 10:53:33 -0700
Message-ID: <7v8vj5u2n6.fsf@alter.siamese.dyndns.org>
References: <vpqobs65gfc.fsf@bauges.imag.fr>
 <1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr>
 <1331288715.21444.38.camel@beez.lab.cmartin.tk>
 <4F5A4C45.7070406@xiplink.com> <4F5AF1A8.4050604@alum.mit.edu>
 <4F5E12A5.6030701@xiplink.com> <vpqzkblixmb.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Mar 12 18:53:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S79RF-0005Xs-CY
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 18:53:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638Ab2CLRxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 13:53:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39517 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751499Ab2CLRxf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 13:53:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09860634F;
	Mon, 12 Mar 2012 13:53:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KRWh1bGesDoeXZ9rzekFVNHgxn4=; b=xq5SMX
	3jpDXBtt3RGZTReF91ECp8cfqTbzzkAeHqSKxCWV6PuBBftvOAyzlYCbpsWvTkkj
	1wJhmdpMBw2/9sV7n8whNge+xZ2JoxHm9u57Dnq2m/sv8s5ivEd7sl+rpqAiiDvU
	nY76GMCT0E4Aj1cFZicQGMEBM2Aa/Gw/VzGmQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gwCXR4RPmPc4DLk5gt2XHRTCgPJGQ3+N
	Tm6Dgj6MtaffPoODZIq38R66gmQqv8D76cmPmXXKWFHjVnCquhRvTetDmTBNQWJZ
	hOYPHJWP3KUZRUvHOQUfGxxntDfwbsLT1/0Nw59BJuPfOe0+KmsbBGhl1pz7ahZd
	DSjaztpmI+U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3DE6634B;
	Mon, 12 Mar 2012 13:53:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 763DF6346; Mon, 12 Mar 2012
 13:53:34 -0400 (EDT)
In-Reply-To: <vpqzkblixmb.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Mon, 12 Mar 2012 17:37:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 499F4BE2-6C6C-11E1-B783-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192911>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> * 'upstream' makes "git push" and "git pull" symmetrical. While there
>   are workflows where it is usefull to have "push" and "pull" point to
>   different branches, I think it is far more intuitive to have this
>   symmetry by default.

Yes, "by default" is really the key word in this discussion, and I
find the above a sound reasoning.

> ...
> That being said, I think the mode you Michael described at least
> deserves to exist, even if I disagree that it would be the best default.

While I agree with that, I think the "if and only if the destination
already exists" falls into the same "modifier" category as "force"
that changes the behaviour of updating _one_ ref from the default
"only if it fast-forwards" to "even if it does not fast-forward".  I
would prefer this new modifier not to be tied too tightly to the
Michael's magic mode, so that it can also be used when the refspecs
are explicitly given.

In other words, with "force":

	git push $there +pu

updates branch 'pu' over there even if it is not an ancestor of our
'pu'.  Similarly, may want to be able to say (I am *not* suggesting
to use '?' as the motifier):

	git push $there ?next

to update next only if it exists over there and it is an ancestor of
our 'next'.

Maybe these modifiers can be combined, so that I can say

	for there in k.org repo github sf.net
        do
		git push $there maint master ?next ?+pu
	done

Because the publishing point I have at sourceforge lack next and pu,
this will only update maint and master following the usual rules
over there, but next and pu will be updated at other places.

Hmm?
