From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] revisions passed to cherry-pick should be in
 "default" order
Date: Mon, 13 Aug 2012 13:05:06 -0700
Message-ID: <7vtxw6d0ct.fsf@alter.siamese.dyndns.org>
References: <7vpq6ygcy1.fsf@alter.siamese.dyndns.org>
 <50289e50.a19f320a.5d99.3fdfSMTPIN_ADDED@gmr-mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: y@google.com
X-From: git-owner@vger.kernel.org Mon Aug 13 22:05:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T10tR-0000px-P1
	for gcvg-git-2@plane.gmane.org; Mon, 13 Aug 2012 22:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752720Ab2HMUFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 16:05:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38532 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752688Ab2HMUFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 16:05:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4554198BB;
	Mon, 13 Aug 2012 16:05:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y4x70in1NVkYNFVjptU1IBHnBDk=; b=fmRlBq
	tEZtkKj9JaCDkF9IQji+kbkGJ+x2KnLaznOVRpjIfEdWQUhKc4o4qxHfjX+ytfRN
	D5wrpLovmtd49e1ES3VYtT4BB5nit6QBebBkjShLqJpp6Hj/gihgJ2IQ7z0dUdgl
	ajYnJXN9j6p9QS7F+9+5HKgZrPoYBo5tuHz98=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EF3DrGR0CFFUI0ZhN2cvLuSGsJDiqkkD
	sSx7eDrkxbp55NFX/4kpEs6KBsdzI29cuO9r5NdtSjr8YmgIHR3a6Ib2PLHxKUkz
	f70MfCN1GnHvou7FVbr5AhlOVAekYFFPFpNwD+1y61nMn8wxMqpqnzl6HuAzMe5k
	7j/ve98uL0c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 32F5698BA;
	Mon, 13 Aug 2012 16:05:09 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B27CB98B9; Mon, 13 Aug 2012
 16:05:07 -0400 (EDT)
In-Reply-To: <50289e50.a19f320a.5d99.3fdfSMTPIN_ADDED@gmr-mx.google.com>
 (y.'s message of "Sun, 12 Aug 2012 23:27:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2DF56B08-E582-11E1-92D4-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203358>

y@google.com writes:

> From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
>
> 'git cherry-pick' internally sets the --reverse option while walking
> revisions, so that 'git cherry-pick branch@{u}..branch' will apply the
> revisions starting at the oldest one. If no uninteresing revisions are
> given, --no-walk is implied. Still, the documentation for 'git
> cherry-pick --stdin' uses the following example:
>
>  git rev-list --reverse master -- README | git cherry-pick -n --stdin
>
> The above would seem to reverse the revisions in the output (which it
> does), and then pipe them to 'git cherry-pick', which would reverse
> them again and apply them in the wrong order.

I think we have cleared this confusion up in the previous
discussion.  It it sequencer's bug that reorders the commits when
the caller ("rev-list --reverse" in this case) gives list of
individual commits to replay.

So I think we are all OK with chucking this patch.  Am I mistaken?
