From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: --full-tree
Date: Wed, 25 Nov 2009 16:00:26 -0800
Message-ID: <7vd436p339.fsf@alter.siamese.dyndns.org>
References: <7vk4xggv27.fsf@alter.siamese.dyndns.org>
 <20091125203922.GA18487@coredump.intra.peff.net>
 <7viqcytjic.fsf@alter.siamese.dyndns.org>
 <20091125210034.GC18487@coredump.intra.peff.net>
 <7vmy2as319.fsf@alter.siamese.dyndns.org>
 <20091125214949.GA31473@coredump.intra.peff.net>
 <885649360911251412n3e566c8fu536b361b993f2ac6@mail.gmail.com>
 <60F92BD7-6FFF-4D9A-B2F0-0858F4E90B59@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: James Pickens <jepicken@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 01:00:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDRmt-0002Oh-UL
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 01:00:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965023AbZKZAAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 19:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759601AbZKZAAc
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 19:00:32 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65111 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759585AbZKZAAb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 19:00:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 778B18249B;
	Wed, 25 Nov 2009 19:00:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qij5hriY65SsqBO0FSUSz2QtljM=; b=dvlkiA
	O6wKLs/wvfyDt/UiWA7JoYeXbEx8sf5ccWS3RAV4M4DHHDGhz/6k2XHGMp8qxThQ
	V0RzTVnB9SF7r9PLRC2d41ngVfDfC1XRxNQV2M+UZSqALNL38BaGrqljpXvd531h
	FnqElF86BB/HJt0VNCmVmrNf2SRhnL+KHdQ/w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V8L9d9NinJD8345k3HCxkUSmjxo0TBiM
	DdB2N+LfgCuXQ3gGgbQqtT8OeFfCtuqvOY6E5ahusjGTOSqx4EUxth89C4Askq47
	S0m3nYSuek/r9MZ81MBWj7S2KhmcUMYFUG0/rww9xEprWDi3Ie/TbmvGwaTKoekP
	l3ZF5+aDSGo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A2DA82495;
	Wed, 25 Nov 2009 19:00:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D90C182494; Wed, 25 Nov
 2009 19:00:27 -0500 (EST)
In-Reply-To: <60F92BD7-6FFF-4D9A-B2F0-0858F4E90B59@wincent.com> (Wincent
 Colaiuta's message of "Wed\, 25 Nov 2009 23\:26\:27 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B792C7D8-DA1E-11DE-ADFB-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133710>

Wincent Colaiuta <win@wincent.com> writes:

> Oh, I wouldn't like that at all. I think it would be a very ugly UI
> wart, because it would basically make Git behave differently than
> every other command line tool that accepts paths. If it is to deviate
> from the extremely widespread convention that paths starting with /
> refer to absolute paths rooted at the root of the filesystem, then the
> justification for it would need to be very strong indeed.

There are at least two flaws in that argument.

 - git does not accept paths (it lets you specify patterns that match,
   e.g. t/ to name ptahs under t/ directory).

 - "/pathspec" does follow the widespread convention that a string that
   begin with a "/" refer to a path rooted at the root _in the context_;
   the definition of root may or may not match the filesystem root.

   Think of things like <a href="/$path">Top</a>.  Does "/$path" mean at
   the root of filesystem?  No.

I am not married to the "git grep -e frotz /Documentation" notation, by
the way.  I just didn't think of a different notation that is equally
short, sweet and logical.  We could do //Documentation if it makes it more
distinct, but I do think it is worse than a single slash.
