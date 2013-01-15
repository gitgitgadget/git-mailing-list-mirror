From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2013, #06; Mon, 14)
Date: Mon, 14 Jan 2013 19:02:35 -0800
Message-ID: <7v1udn6tdg.fsf@alter.siamese.dyndns.org>
References: <7vehhn8kub.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>
To: "Eric S. Raymond" <esr@thyrsus.com>,
	Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 04:03:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tuwnk-0007Ou-CT
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 04:03:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752679Ab3AODCj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 22:02:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45774 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752333Ab3AODCi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 22:02:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2422AACBA;
	Mon, 14 Jan 2013 22:02:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OQo6LHr/7jDO0PB+Zx/gwNs1Xmc=; b=Zr0a5k
	/m3VPgZ9U/fvIiAfCGvUsf01vCczZGx1ij9x3isuPDUfutEd8CW5cjbPgvi6p0I2
	U9iKjWnwBjCBAZM81tRDwspEaW7UXYao5C5j81hMcyIeax3/2pC8P6zMbtrit3tp
	FWiZs/7frkWuw+SSnTlWL0ZZSeduo3prvGU0I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Uom5yQB9nlNpb0ysnXRkPgXn5o2yUBMj
	r+C3OgVScom9fRCGR9hkuDR1U20nb5Db61P+Mk2C9LUx6RFp4w73al0Yn6HxbuEk
	wLmTUK2AYfoLAMLXDzd9I7QDB9QDLUxPLYqGLaYqL5aNPFpePeTadJkRwU0j+ueE
	1vdbVJo2fXI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 193A4ACB9;
	Mon, 14 Jan 2013 22:02:38 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6CC5DACB7; Mon, 14 Jan 2013
 22:02:37 -0500 (EST)
In-Reply-To: <7vehhn8kub.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 14 Jan 2013 14:23:56 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 045E011C-5EC0-11E2-A33F-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213571>

Junio C Hamano <gitster@pobox.com> writes:

> [New Topics]
>
> * jc/cvsimport-upgrade (2013-01-14) 8 commits
>  - t9600: adjust for new cvsimport
>  - t9600: further prepare for sharing
>  - cvsimport-3: add a sample test
>  - cvsimport: make tests reusable for cvsimport-3
>  - cvsimport: start adding cvsps 3.x support
>  - cvsimport: introduce a version-switch wrapper
>  - cvsimport: allow setting a custom cvsps (2.x) program name
>  - Makefile: add description on PERL/PYTHON_PATH
>
>  The most important part of this series is the addition of the new
>  cvsimport by Eric Raymond that works with cvsps 3.x.  Given some
>  distros have inertia to be conservative, Git with cvsimport that
>  does not work with both 3.x will block adoption of cvsps 3.x by
>  them, and shipping Git with cvsimport that does not work with cvsps
>  2.x will block such a version of Git, so we'll do the proven "both
>  old and new are available, but we aim to deprecate and remove the
>  old one in due time" strategy that we used successfully in the
>  past.

My reading of the review discussion of this series, and the
discussion in the $gmane/213170 thread, is that the approach
outlined in this series is something Git-side is comfortable working
with.

I personally think it will be slightly less work on your side to
keep the cvsps 3.x + new cvsimport combo improving, because you no
longer need to worry about punting to the old cvsimport.  In
addition, I think the new layout would make it easier for the new
combo to gain trust of existing Git userbase over time by adding
more t965x series of tests that correspond to the tests in the t960x
series, working on the same (simple) CVS histories, demonstrating
that the result would be what users expect, and guarding the code
from future breakage.  By giving options to pick and choose both old
and new cvsps, I think it will make it easier for distros to include
cvsps 3.x sooner, promoting its adoption, which will in turn benefit
us.

I converted one of Chris's follow-up test tweaks to this to
illustrate how it can be done without breaking tests for the
original cvsimport, but didn't do all of them.  Chris, is this a
foundation we can work together on top?

Even though I assigned Author: to the "start adding cvsps 3" patch,
I forgot to forge Eric's sign-off to it.  If Eric is OK with the
direction this series is going, I'll do so and advance the rerolled
series to 'next'.

Thanks.
