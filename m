From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/11] alternative unify appending of sob
Date: Wed, 28 Nov 2012 21:56:45 -0800
Message-ID: <7vvccprlya.fsf@alter.siamese.dyndns.org>
References: <1353894359-6733-1-git-send-email-drafnel@gmail.com>
 <CACsJy8AfaETfikvB+zON4iiX2HBehJg-xX2GGmKYHueX8rv3qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <drafnel@gmail.com>, git@vger.kernel.org,
	Brandon Casey <bcasey@nvidia.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 06:57:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tdx7R-0006QE-4y
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 06:57:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244Ab2K2F4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 00:56:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38330 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751039Ab2K2F4s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 00:56:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF27DACB1;
	Thu, 29 Nov 2012 00:56:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TbvvbdFbVfiRtHTcWuT5cjQJDe8=; b=Im2G+Y
	aPPIS7tmKTAR/gVUDO6fQMVeHapbRCLy+PReV2KjT2TLiVIBrnSi8k7iyhVcEXy/
	OLOqisYBQOzl+PCicsfwdED4xqgrweFFDyyClzuevbmWkomWhE/1J5hGXu2Mtn8v
	fiUgMZ7XETS3lEiCWG3yVy57LVeQk1yCv+1TA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XEbyEcPySi8W8QNrjiPD0qNqaRp4mliU
	OEyGVpzbnHtENWEmcymyYUi7YtymLQ8S+8joLw6ZilI6uInxJBAEuPPY6+ElczpK
	t9MQ9AnIwgjipmMyZ9OObaqoIM+KDgRoNWc91w87c1DPLtk4/MYJCcpAT7XgAfQl
	uUUNZtba580=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DCA01ACB0;
	Thu, 29 Nov 2012 00:56:47 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 48929ACAF; Thu, 29 Nov 2012
 00:56:47 -0500 (EST)
In-Reply-To: <CACsJy8AfaETfikvB+zON4iiX2HBehJg-xX2GGmKYHueX8rv3qw@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Mon, 26 Nov 2012 14:56:49 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8F8C98A8-39E9-11E2-81C6-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210807>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Mon, Nov 26, 2012 at 8:45 AM, Brandon Casey <drafnel@gmail.com> wrote:
>
>> I've integrated Duy's series with a few minor tweaks.  I added a couple
>> of additional tests to t4014 and corrected one of the tests which had
>> incorrect behavior.  I think his sign-off's should still be valid, so I
>> kept them in.  Sorry that I've been slow, and now the two of us are stepping
>> on each other's toes, but Duy please take a look and let me know if there's
>> anything you dislike.
>
> I'm still not sure whether format-patch should follow cherry-pick's
> rule in appending sob. If it does, it probably makes more sense to fix
> the sequencer.c code then delete log-tree.c (not fixes on log-tree.c
> then delete it). I see that your changes pass all the new tests I
> added in format-patch so sequencer.c is probably good enough,
> log-tree.c changes are probably not needed. Feel free take over the
> series :-)

After reading the series over, I agree with the above.

Patch #9 that fixes the copy in log-tree.c only to discard it in
patch #11 does not seem to be the best organization of the series.
Instead, perhaps we can salvage the tests in patch #9 (but mark
failing ones as expecting failure) without updating the one in
log-tree.c, adjust prototype in patch #10 (still broken in
log-tree.c) to avoid having to make changes to the callers in patch
#11, and then conclude the series with #11?

Other than the code in patches #06 and #07 that I already commented
on, i.e. assignments in if () condition that make it harder to
follow the logic, I did not find anything majorly objectionable in
the series.

Thanks for a pleasant read.
