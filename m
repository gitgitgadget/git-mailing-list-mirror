From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] get_sha1_with_context: report features used in
 resolution
Date: Wed, 11 Jan 2012 18:36:12 -0800
Message-ID: <7vmx9t4pgj.fsf@alter.siamese.dyndns.org>
References: <20120111193916.GA12333@sigill.intra.peff.net>
 <20120111194210.GA12441@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org, Albert Astals Cid <aacid@kde.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 12 03:36:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlAWb-0007nn-Qg
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 03:36:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231Ab2ALCgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 21:36:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58873 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751233Ab2ALCgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 21:36:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 53C296671;
	Wed, 11 Jan 2012 21:36:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kPELuSvFQO7TOE3NPDZs5x5/YCg=; b=BryctB
	aTRsdm80TvSw+8k9ge8FPxgxxp6o9C+LIdepvoYfMX6f/OiEZeC36AQ0cyZ8orD8
	mCGszpyfJ0vFm6iqARncpZMajkag5xFK736iBbXMOpJMdnw7VeXl7kQTyDrjQcJ1
	toHwlvaO3BvzH2VbhXjtHtr/rVNdMaQK2q2XQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=COPKigs1AM9ijpglGzjekXMUPUU2r82G
	riiTEhqJJcjc9aor9gWwyjbhRQzXjgzOCJiCBHFMhpkEpvO+bILDYUIlgo08ZQHY
	GaxGCGL3zSq3YmeG1zYEnXvStDqo96MauTOvD54sRxPuEjaK7cWQPL4osYNwXNGo
	PMtl5w94ILY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AF006670;
	Wed, 11 Jan 2012 21:36:15 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CBAEB666F; Wed, 11 Jan 2012
 21:36:13 -0500 (EST)
In-Reply-To: <20120111194210.GA12441@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 11 Jan 2012 14:42:10 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3208D5FA-3CC6-11E1-81B4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188415>

Jeff King <peff@peff.net> writes:

> Most callers generally treat get_sha1 as a black box, giving
> it a string from the user and expecting to get a sha1 in
> return. The get_sha1_with_context function gives callers
> more information about what happened while resolving the
> object name so they can make better decisions about how to
> use the result. We currently use this only to provide
> information about the path entry used to find a blob.
>
> We don't currently provide any information about the
> resolution rules that were used to reach the final object.
> Some callers may want these in order to enforce a policy
> that a particular subset of the lookup rules are used (e.g.,
> when serving remote requests).
>
> This patch adds a set of bit-fields that document the use of
> particular features during an object lookup.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> The diffstat looks a little scary, but it is mostly just the internal
> get_sha1 functions learning to pass the object_context around.

Hmm, shouldn't this also cover peel_to_type()?  That would have made it
also apply to the maintenance track.
