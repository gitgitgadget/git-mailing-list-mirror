From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log --oneline: put decoration at the end of the line
Date: Wed, 19 Sep 2012 12:57:28 -0700
Message-ID: <7vr4pxg507.fsf@alter.siamese.dyndns.org>
References: <1348055540-13774-1-git-send-email-pclouds@gmail.com>
 <20120919182039.GE11699@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 19 21:57:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEQOy-0000nh-57
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 21:57:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338Ab2IST5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 15:57:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64495 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751074Ab2IST5b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 15:57:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB75181F3;
	Wed, 19 Sep 2012 15:57:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iFExowIgKPArewubQrVYku9vqSg=; b=furFdX
	flTt9a4Z7yNGo+fiat1ZJe6j4ly1sqJ7czRCRSucIXlajP3zzmmEf0zm+Lqw2cjj
	2i9uXfRtZYdSVl1tCA68dZPVXD0YRRLpuCpGGt1/sBda0UJg/6JVHN2Gr2yBSw4T
	iPXXRrqLgaCQunbziUVTttMWK9ggVclmvx98I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aiZ3fHeAH8XmbpmBPKpFXZOEvqWXfshh
	+PcG2nBvFj96CqMPpcFzaoQjzNyl/RTDldqPr5VXCoY86PK9B5mkG2dsN5BpeZo1
	4ldsGnQreM9u5/39NsXlNWGzx90c4kHjU9+aMJH8lNDQdgVFXMEH6aW1zJcssdgv
	SLP9DEpPG4o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9AA8A81F2;
	Wed, 19 Sep 2012 15:57:30 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1BB3C81F1; Wed, 19 Sep 2012
 15:57:30 -0400 (EDT)
In-Reply-To: <20120919182039.GE11699@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 19 Sep 2012 14:20:40 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3E7B544A-0294-11E2-9AB1-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205988>

Jeff King <peff@peff.net> writes:

> We should also consider briefly whether anybody is relying on --oneline
> for machine parsing. I think "log --oneline" is fair game, but I wonder
> if people calling "rev-list --decorate --oneline" should be considered.
> It seems kind of unlikely to me, considering that the decorate output is
> ambiguous to parse anyway (if you see parentheses, you cannot tell if it
> is decorate output or part of the commit subject).

Yeah, I do not think it is likely.  Among the in-tree scripts,
git-stash does use rev-list --oneline but the purpose of the call
exactly is to grab a human readable one line summary, and it will be
happy with any change to make --oneline more human readble.

t4202 has many invocations of "log --oneline --decorate", though;
these things do get tested.
