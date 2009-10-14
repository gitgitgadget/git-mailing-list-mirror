From: Junio C Hamano <gitster@pobox.com>
Subject: submodule-summary
Date: Wed, 14 Oct 2009 13:34:36 -0700
Message-ID: <7vfx9lbtpf.fsf_-_@alter.siamese.dyndns.org>
References: <7vfx9pmhae.fsf@alter.siamese.dyndns.org>
 <4AD61880.4040600@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Oct 14 22:47:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyAeM-0000Qt-Gb
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 22:40:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758910AbZJNUf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 16:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758817AbZJNUfZ
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 16:35:25 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35673 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757159AbZJNUfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 16:35:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 863B8779E7;
	Wed, 14 Oct 2009 16:34:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lYO9K5pYyeD+UbKoHUIBw3naPxo=; b=ThZXmf
	mO49bwna2ZXBif6J7AosSiTUYPmkK6QZFenilZxbf4amZSvkX6nMEBZYdtghW7/c
	ktKb2yTxJSRamDShNOnYubxFZBvkL6gBhWtAF0gNRmbNMZJhEPbzUKEj058KWLhy
	vq6yc5mXd/Z+jRBTYOa4BunJBgv6FD4ZDZj34=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lQ9kCvyYI3duMvZ+S/FRCA1FJfTFDTNN
	sj8hu4AyrhJ570mzWuGaqKsjEy8jpfMRb9dHf9++J6RreN0MpWwzF6EXXvGA1IcR
	VvVJE90f1xzLgJxnRJbU62j7s3mN3m5iADX0OBoizELNZMYeUgVRTtGBj3G6E+qJ
	iMlQNToSJUk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6A2B2779E6;
	Wed, 14 Oct 2009 16:34:41 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1D16A779DE; Wed, 14 Oct 2009
 16:34:37 -0400 (EDT)
In-Reply-To: <4AD61880.4040600@web.de> (Jens Lehmann's message of "Wed\, 14
 Oct 2009 20\:29\:20 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0002211A-B901-11DE-AA16-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130336>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Dscho condensed his initial patch with the interdiff you mentioned,
> additionally silenced a compiler warning and activated --first-parent.
> This follows as patch 1/4. Patches 2/4 to 4/4 contain my two bugfixes
> and the testcase i copied from submodule summary while adapting it to
> the changes of the output format.

I think 2 and 3 should be squashed into the first one.  I do not see any
good reason for keeping initial "oops that was wrong" etched in stone,
once the review process has revealed obvious bugs and reasonable fixes
have been given to them.  If the original author re-spun a v2 patch, that
is the normal thing that happens.

I am not happy with the option name --submodule-summary, by the way.
Naming this option --submodule-summary shows the confusion between this
series being the _latest_ great invention and this series being the _last_
great invention.  I'd freely grant the former but would like to avoid the
latter.

I have this nagging suspicion that we should leave the door open for later
addition of --submodule=full that actually gives the patch text for the
entire aggregated tree, perhaps recursively.  People may want to add even
more other useful modes that we do not think of right now. It would be
better to name this --submodule=shortlog or something.

If users like the shortlog mode (or the full mode) very much, perhaps the
current default output, which shows the differences between two commit
object names, can become a --submodule=summary (or --submodule=twoline)
mode later, and the shortlog mode could become the default.

> The remaining differences from the output shown by submodule summary are:
>
> 1) git diff shows only two dots for a fast forward (submodule summary
>    always shows three)
> 2) git diff shows "Submodule" instead of a single '*' in the first line
> 3) git diff doesn't add a newline after each shortlog
> 4) submodule summary prints out the number of shortlog entries, this
>    version does not
> 5) submodule summary can limit the number of shortlog lines, git diff
>    can't do that right now
> 6) When files are replaced by a submodules or vice versa, git diff
>    generates an extra hunk for the deleted/added file and one saying
>    "(new submodule)"/"(submodule deleted)"
>
>> The output format needs to be described better here and also in
>> Documentation/diff-format.txt.
>
> Will do when it is clear which of the 6 differences should be fixed and
> which can stay.

Thanks.
