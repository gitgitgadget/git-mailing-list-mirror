From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] rebase: refuse to rebase with -s ours
Date: Mon, 16 Nov 2009 11:57:05 -0800
Message-ID: <7vpr7ip7ji.fsf@alter.siamese.dyndns.org>
References: <cover.1258309432.git.trast@student.ethz.ch>
 <efd7770d166a97481e8e31e407b9c2da02a341e5.1258309432.git.trast@student.ethz.ch> <alpine.DEB.1.00.0911161333470.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Baz <brian.ewins@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 16 20:57:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NA7hb-0004bF-NR
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 20:57:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437AbZKPT5U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 14:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753402AbZKPT5U
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 14:57:20 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63897 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545AbZKPT5T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 14:57:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 28FD080AF6;
	Mon, 16 Nov 2009 14:57:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3r9YJAyowcrycBlBBrtKtr33fF0=; b=T/7tmI
	NVqFfs/sQDyVbz+5zPJtkVYjyTA9mVHSTZ2k3mIOoMFWI03idLbP3KlUn/wnqQqE
	Yg9/ZpYeHP2VF49tj9kuyam63/xz64rlmbpASgUtcj3BjJI6iLNCkVBN0QCu1E+f
	M0YTNWtJqNerogI3y0H1td4ekO7oCnzSmZLdI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I6XTAAcyZoFbxvJAdRwQMdSAvCP10Lw2
	gEyFFVm914Sgni8lUWgsPZkMUtSmvrDjd8DSKgqza6orKLjeIcOR1MRXis9eQ9jw
	Lx+K/Btspu2SQjyAarirXPcFaqxXF+xaLNyDZHGPofrp0ufpoCiLXXl+gQM7CmN3
	461kNpECI7U=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AE6B180AF5;
	Mon, 16 Nov 2009 14:57:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 78CE480AF4; Mon, 16 Nov
 2009 14:57:07 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0911161333470.4985@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Mon\, 16 Nov 2009 13\:35\:13 +0100
 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3D17BEAE-D2EA-11DE-861E-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133022>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sun, 15 Nov 2009, Thomas Rast wrote:
>
>> Using the "ours" strategy with rebase just discards all changes, turning 
>> <branch> into <upstream> (or <newbase> if given).  This is unlikely to 
>> be what the user wants, so simply refuse to do it.
>
> "Unlikely" or "impossible"?

It is more like "very likely to be a mistake".

Our tradition has been to give them long enough rope, but the recent trend
is to consider ourselves experienced enough with various git workflows to
be capable of identifying not just "cannot possibly a meaningful request"
but also "almost always a mistake" cases, and tighten the rope to help
people from stumbling, I think.

But it needs more careful thought to avoid forbidding useful use cases,
and your input is hugely appreciated if you have doubts (even better, an
example of useful use case that will become impossible).

> Besides, I find it rather arbitrary that the "ours" strategy is refused, 
> but none of the user-provided merge strategies.  IOW disallowing "ours" 
> may very well foster unreasonable expectations.

I cannot read this quite clearly.  Unreasonable expectations being...?

 * "ours" is disallowed but anything else including user-provided ones are
   Ok, so we are allowed to circumvent this restriction by adding a
   synonym for "ours" as a user-defined one, and are encouraged to do
   so. ---that is a wrong message to send.  Is that what you mean?

 * strategy X, unlike "ours", is allowed, so users will have rights to
   expect use of X as a rebase strategy would yield useful result, but
   that is wrong---Dscho knows that merge strategy X (I cannot read which
   one you had in mind if this is what you are talking about) does not
   work well in this and that cases.  Is this what you mean, and if so
   what is X?

Perhaps you had something other than the above two in mind?
