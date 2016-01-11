From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] lock_ref_sha1_basic: handle REF_NODEREF with invalid refs
Date: Mon, 11 Jan 2016 10:28:32 -0800
Message-ID: <xmqqziwcvulr.fsf@gitster.mtv.corp.google.com>
References: <20160111154651.GA25338@sigill.intra.peff.net>
	<20160111155239.GB22778@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 11 19:28:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIhCp-00079x-OR
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 19:28:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933243AbcAKS2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 13:28:36 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62205 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932846AbcAKS2f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 13:28:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EDD3739E36;
	Mon, 11 Jan 2016 13:28:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EezNODgKduSSTDgRND39jnz1gu4=; b=N+E5Ow
	ZcEbg1eF7EldsZL985hUUsFKYGw/ojG9kmvAj9lBevDsNBtHIC7HETpQDIlsX4/B
	eCYhrhaltyFB2aj5eQhH1yEJPUDP+0vXpuI9Op/l/a3DHEI7wO5zfVbN4AovKFxI
	EOIAWZsR3qUJhoxr2POiemv0reFMZYgciuChM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M/YnFo2gqvikqkNnAcpuj34/icIOYaDS
	ibcxNztTIFLph6PBRgnVWyRENTpAEjXtfWloKNNtczRbL1tzAd5yXKWaoNI+hcpZ
	qsjSXIroI2YaRlOhOSdE3h2RBxzANC85yWeGIHwfmRVFvhgzkZdVblRPYgIFWkoY
	inJDdTLOo7U=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E473639E35;
	Mon, 11 Jan 2016 13:28:34 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 529C939E33;
	Mon, 11 Jan 2016 13:28:34 -0500 (EST)
In-Reply-To: <20160111155239.GB22778@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 11 Jan 2016 10:52:39 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1F88CCDC-B891-11E5-8AC1-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283689>

Jeff King <peff@peff.net> writes:

> So instead, we attempt to resolve HEAD fully to get the old
> sha1, and only if that fails do we fallback to a
> non-recursive resolution. We lose nothing to the fallback,
> since we know the ref cannot be resolved, and thus we have
> no old sha1 in the first place. And we still get the benefit
> of the d/f-checking for the symref itself.
>
> This does mean an extra round of filesystem lookups in some
> cases, but they should be rare. It only kicks in with
> REF_NODEREF, and then only when the existing ref cannot be
> resolved.

Makes perfect sense to me.  Thanks.
