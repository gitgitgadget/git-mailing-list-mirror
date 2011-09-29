From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] refs: Use binary search to lookup refs faster
Date: Thu, 29 Sep 2011 16:48:00 -0700
Message-ID: <7v62karjv3.fsf@alter.siamese.dyndns.org>
References: <4DF6A8B6.9030301@op5.se>
 <CAP8UFD3TWQHU0wLPuxMDnc3bRSz90Yd+yDMBe03kofeo-nr7yA@mail.gmail.com>
 <201109281338.04378.mfick@codeaurora.org>
 <201109281610.49322.mfick@codeaurora.org>
 <c76d7f65203c0fc2c6e4e14fe2f33274@quantumfyre.co.uk>
 <960aacbf-8d4d-4b2a-8902-f6380ff9febd@email.android.com>
 <7c0105c6cca7dd0aa336522f90617fe4@quantumfyre.co.uk>
 <4E84B89F.4060304@lsrfire.ath.cx> <7vy5x7rwq9.fsf@alter.siamese.dyndns.org>
 <20110929041811.5363.33396.julian@quantumfyre.co.uk>
 <7vvcsbqa0k.fsf@alter.siamese.dyndns.org>
 <20110929221143.23806.25666.julian@quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Martin Fick <mfick@codeaurora.org>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Fri Sep 30 01:48:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9QKp-00011L-Vv
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 01:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753501Ab1I2XsG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Sep 2011 19:48:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52680 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751516Ab1I2XsD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2011 19:48:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D54604CE1;
	Thu, 29 Sep 2011 19:48:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/mTOWK0mrOITWNRDQ3eJh/IvB4U=; b=gS6XMk
	y+WS8ZyZ9M1U57CzDJDmxRQjr99E7k+/DcxzrVFq6RhkIIAlCnKhp/Gjz31VLbtp
	YX6xFNPa1znTqJBS+d980BltsTxyrMB4W6BqwnFCwmJI/f2WT64P71wUo4SMMvCU
	x1immiCkZc0mqjmwYOi/St9ZvwiYX1aKwZ+OA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d6WNmp497q3GhCpRHtOeonVuSQNGKVqs
	weBL7lIxtDEA0KtoqTBRDPP1I4vqIrQCoj3VuPkACdrVK8K8bMa0sgYYQRX5Uwc1
	crKVpOAuOqR183ue9EM6uv0JxIWMi06NKo4b3F4Oge/iH2DHze0CF4O++wgkXRCI
	l54paZCSuSA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA7F64CE0;
	Thu, 29 Sep 2011 19:48:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4393F4CDF; Thu, 29 Sep 2011
 19:48:02 -0400 (EDT)
In-Reply-To: <20110929221143.23806.25666.julian@quantumfyre.co.uk> (Julian
 Phillips's message of "Thu, 29 Sep 2011 23:11:42 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 780C50A4-EAF5-11E0-9E56-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182456>

This version looks sane, although I have a suspicion that it may have
some interaction with what Michael may be working on.

Thanks.
