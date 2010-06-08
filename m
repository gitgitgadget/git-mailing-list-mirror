From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-mergetool--lib.sh: fix mergetool.<tool>.*
 configurations ignored for known tools
Date: Tue, 08 Jun 2010 14:05:24 -0700
Message-ID: <7vzkz5s0a3.fsf@alter.siamese.dyndns.org>
References: <1275705112-8088-1-git-send-email-sylvain@abstraction.fr>
 <1275705112-8088-2-git-send-email-sylvain@abstraction.fr>
 <20100608083445.GC14366@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sylvain Rabot <sylvain@abstraction.fr>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 08 23:05:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM5zQ-0001yM-E8
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 23:05:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756466Ab0FHVFf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 17:05:35 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36179 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756314Ab0FHVFe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 17:05:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 509B9BACA4;
	Tue,  8 Jun 2010 17:05:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=AN2Y23FyKMNeZbHs7u5avO5Bryw=; b=UCq+rspS3y0c8mVDHz5fjzC
	6j93krHPjPX7Sd+zLkJCn6YtpruoE3lEmnTfryoZY2q3RQoniXNgjd48C409W6LP
	H2MHA8Ul9kVf6SGylKpNIhn3rOgj7Nl1DA3rp4BmYWYO/rLPtVoOORoL8iX0CAnn
	VvdqDAmB7KzqpxSHMn14=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=gvBKsvpUfOn2kwKzV/aXw3senis/skDvcHdy2n1gMcUafUr8L
	h99aA0fjysJRriBLqotzlUiP4Q4VxYwt9Mbbjx/ZP1j5lX1QzyXlKiV0m0E+aKc0
	OBx5Qzy319anjhjIaIpqj27c+Pz7AICXt8/NEzfZed1yR86ktFmY33Nii4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A15BBAC9F;
	Tue,  8 Jun 2010 17:05:30 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 383B7BAC9A; Tue,  8 Jun
 2010 17:05:26 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 91C30312-7341-11DF-9A9C-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148718>

David Aguilar <davvid@gmail.com> writes:

> Hi, sorry for the delay in responding to this email.

Thanks for a review.

> I don't think we ever signed up to support this configuration.
> mergetool.<tool>.path has always (from my naive reading of the
> documentation) been the absolute path to <tool>.
>
> I don't think it should have a dual-role where it can be either
> the tool's parent directory or the path to the tool itself.
> I would prefer to keep it as simple as possible, if we can.

I concur; it is not just about simplicity, but setting the value to the
parent directory of the tool feels downright confusing.

>> +		# mergetool.<tool>.path is the same as mergetool.<tool>.cmd
>> ...
>> +	fi
>
> This section is getting pretty nested.
> Should we break the handling for configs-that-override-builtins
> into a separate function?

Sounds like a sane thing to do.
