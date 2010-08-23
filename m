From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] rev-parse: suppress duplicate log limit exceeded
 message.
Date: Mon, 23 Aug 2010 09:33:57 -0700
Message-ID: <7vr5hp1e6i.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=m7+h0nVg+EAmiir-rnrjoBwbpLtztcNNBVxiz@mail.gmail.com>
 <1282355022-17795-3-git-send-email-jon.seymour@gmail.com>
 <7vy6by2vlf.fsf@alter.siamese.dyndns.org>
 <AANLkTi=3=sumzcSFoCN6FUPQPzfQvfSim8KPRoXoT3tL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 23 18:34:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnZyV-0001BT-0w
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 18:34:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753235Ab0HWQeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 12:34:06 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56884 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753129Ab0HWQeF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 12:34:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7FD74D00A4;
	Mon, 23 Aug 2010 12:34:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=PWFbDWy7rnTqayRTOIL+/Vtilyg=; b=Q4tkr9kS4FfCMGG1laBF0+R
	6arYsx68XfCwbSv/L3s2oZ5IhjxtjzzVTOugs8K/MBfiQWnZus8FkD/T4ZkXRBK8
	FJOP9lWhxs1wBfCr7qxyxq7r+8Yb7vKCs8mleqhSd8kzDzWS5NHgG/jbk7kXNEn7
	rgnIZNIAiaXN0hsvZomE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=WX2eZab6N7k8w6vAZH8KXEkSR9ncliYPkIzCm05bAaCrTewAG
	u+mme1T1XMwrFiFRaqWaqVOfYhgt3RlCNGI5Qpfuk9L4rn0ngti/woaQGRi42f8i
	hbjhqn4IYK3GKs6Wh/lguPDZO6t23G0pJcjd9yhGTqfMv+7fyCuNOvzxKM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2913DD00A3;
	Mon, 23 Aug 2010 12:34:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3C602D009F; Mon, 23 Aug
 2010 12:33:59 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3CC28C6A-AED4-11DF-A3FC-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154236>

Jon Seymour <jon.seymour@gmail.com> writes:

> Ideally,  I think we should simply be reporting the log limit exceeded
> condition as a fatal condition on its own, and not reporting the
> ambiguous ref catch all at all in this case. We have already decided
> that the argument is a reference at this point and as such it is not
> really ambiguous, it just happens to be out of bounds.

A very good point.  Would simply replacing that error-then-return-nonzero
with a die work?  If so we do not even need to worry about new mechanisms
to cause different soft error conditions reported back to the caller to be
printed.
