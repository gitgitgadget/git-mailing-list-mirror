From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Tag peeling peculiarities
Date: Wed, 13 Mar 2013 10:29:54 -0700
Message-ID: <7vwqtb2ood.fsf@alter.siamese.dyndns.org>
References: <51409439.5090001@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Mar 13 18:30:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFpVR-0002rC-KD
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 18:30:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933169Ab3CMR36 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 13:29:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55742 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932984Ab3CMR35 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 13:29:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF401A6A9;
	Wed, 13 Mar 2013 13:29:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ois+CliZ/70xK049PlzCVCdpfgc=; b=wD+yh/
	FG2r155rWS53p2ZowUSZ1WhNuIcyzykbUdq6Qqh4Bff49/yor5O66YoDt3XYFdso
	kn0qt3vAL5miSWF1B7UTc56ipgcFqG4ym3e/M4YDB5yHh9lwem8iwsl6EL+Cgwh+
	upsgljDlt8B6953zuWSjkz1xlr8rbBR2yc+y4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YjF1WcpHWfcTxXmkxYPEehnE+CJaMQGV
	iBhWUIQnzUmox1nqyHypN1TCy3NGznJnb4v5beb7nUaO3FjVMaUmQF81oQqSGmpE
	Krxblkr1MKZcn8VMpUWNj5YskjsFJWZdP7F7yH0av+Cbc/+cA0+lZQpA2wHEH/S4
	ch/YlciBLds=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F0C9A6A7;
	Wed, 13 Mar 2013 13:29:56 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 116D5A6A4; Wed, 13 Mar 2013
 13:29:55 -0400 (EDT)
In-Reply-To: <51409439.5090001@alum.mit.edu> (Michael Haggerty's message of
 "Wed, 13 Mar 2013 15:59:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9F59DA4A-8C03-11E2-87A8-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218072>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> It is not
> clear to me whether the prohibition of tags outside of refs/tags should
> be made more airtight or whether the peeling of tags outside of
> refs/tags should be fixed.

Retroactively forbidding presense/creation of tags outside the
designated refs/tags hierarchy will not fly.  I think we should peel
them when we are reading from "# pack-refs with: peeled" version.

Theoretically, we could introduce "# pack-refs with: fully-peeled"
that records peeled versions for _all_ annotated tags even in
unusual places, but that would be introducing problems to existing
versions of the software to cater to use cases that is not blessed
officially, so I doubt it has much value.
