From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Suggestion on git-push --porcelain
Date: Tue, 09 Feb 2010 18:57:46 -0800
Message-ID: <7vmxzhn6fp.fsf@alter.siamese.dyndns.org>
References: <be6fef0d1002091834i1c4b202cp5afacc326bd1a4d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	"Larry D'Anna" <larry@elder-gods.org>, Jeff King <peff@peff.net>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 03:58:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nf2mT-0005cC-RP
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 03:58:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755473Ab0BJC57 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 21:57:59 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39401 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755402Ab0BJC56 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 21:57:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E8B6986AF;
	Tue,  9 Feb 2010 21:57:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cCZyBG9Y8BiSpcOPfPAhZeCe3F8=; b=LoVXGr
	FxTTumwcN0gghsnagoRE2IORC2e893l9zuD6gANNocr7SuI0fl7vCJWW/RNrGB7C
	VZIPhHWl3WR/FpYNXTUpl8G4GMQLs7ixbAZLPT9HAhCxs4k11iH2bfqHxqh7kqkN
	IL6KQ3mAUuVkktRJ3LBJDD4Si62o0LFTKa0gM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R11AdGfD/xeCoWPbJRUopI+jNQhKoKde
	QEUS4N6zd+niWm+lKRKham9rsh5vNpcr0ZTEHNI3xKCkU97fTJbH5iv/OgDJemtD
	oKsULiQvBLeWAeV632GKq6manEmSfC5nIwgB68aYX0vHZZGF0QiOSWcH6l3lL8XB
	uIvBhdyocBQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E33BB986A9;
	Tue,  9 Feb 2010 21:57:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 028D0986A8; Tue,  9 Feb
 2010 21:57:47 -0500 (EST)
In-Reply-To: <be6fef0d1002091834i1c4b202cp5afacc326bd1a4d6@mail.gmail.com>
 (Tay Ray Chuan's message of "Wed\, 10 Feb 2010 10\:34\:00 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 14C1B4B6-15F0-11DF-B6F7-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139475>

Tay Ray Chuan <rctay89@gmail.com> writes:

>   $ git push --porcelain
>   PORCELAIN To git://foo.com/git/myrepo.git
>   PORCELAIN uptodate refs/heads/baz:refs/heads/baz 1234ab ba4321
>   PORCELAIN nonff refs/heads/bar:refs/heads/bar 2345cd 3456de
>
> This is an "positive" approach, in the sense that we don't remove
> anything from the current output; we just add more printf("PORCELAIN")
> lines to wherever is appropriate.

Sorry, but I don't see what that would solve.  For example, we used not to
give the destination to the standard output stream, but that line carries
a necessary information and Larry's series corrects that.

In your "prefix with PORCELAIN" scheme, such a change will start adding a
new line "PORCELAIN To ..." that older implementations may not be prepared
to see.

Other than making the output more noisy, I do not see an improvement here.
