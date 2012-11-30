From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cache-tree: invalidate i-t-a paths after writing trees
Date: Thu, 29 Nov 2012 16:06:51 -0800
Message-ID: <7vhao8neck.fsf@alter.siamese.dyndns.org>
References: <3E62F933-76CD-4578-8684-21444EAA454F@JonathonMah.com>
 <1352459040-14452-1-git-send-email-pclouds@gmail.com>
 <7vy5ibouo4.fsf@alter.siamese.dyndns.org>
 <CACsJy8DEwpg0gY1o6gSB747W5fAYYxz97e-qnkQthSut3B7Eag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathon Mah <me@jonathonmah.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 30 01:07:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeE8M-0004Qn-T2
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 01:07:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755248Ab2K3AGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 19:06:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64397 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754947Ab2K3AGy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 19:06:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DFAC97B7;
	Thu, 29 Nov 2012 19:06:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uJbVi++NzF4LSjbV5Dv1IS93xmQ=; b=kdZOvY
	Zd4lBbrf/Zu5jBRAGBcdPWA6fQT+SxJUZvxkhV9/2ltYU0CpQNDLWfkZI7gt2cdJ
	PXsruuqUx5MvTz5TO1CUeaSkfDcWi+3rFafDe3vT3rQBKATAcPpMKnGn0OJHaKcf
	BwOccRHCts+wMasM1IPcQzQYXWP/ZMvD3RHQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w6IR1CdUDhmPtHrH+OkI9hKdRe3QqFf/
	W4i6qCPPOtq5n0ApXTEpkr5XhlKj1xYHgKgIrZCsXloA1A9pM3iWGH4xZIxLIaSD
	g3j9gKVdoxNtVPNOO9szl5BkJXi6LL+HT7XEtssrnSWj3CgJ8wJAFMg7SiPSpCCy
	g0UKL95UqtQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BF1597B6;
	Thu, 29 Nov 2012 19:06:53 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AFEB697B5; Thu, 29 Nov 2012
 19:06:52 -0500 (EST)
In-Reply-To: <CACsJy8DEwpg0gY1o6gSB747W5fAYYxz97e-qnkQthSut3B7Eag@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Sat, 10 Nov 2012 18:04:32 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D83827AA-3A81-11E2-9DF7-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210884>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

>> An alternative might be to add a "phoney" bit next to "used" in the
>> cache_tree structure, mark the cache tree as phoney when we skip an
>> entry marked as CE_REMOVE or CE_ITA, and make the postprocessing
>> loop this patch adds aware of that bit, instead of iterating over
>> the index entries; instead, it would recurse the resulting cache
>> tree and invalidate parts of the tree that have subtrees with the
>> "phoney" bit set, or something.
>
> Yeah, that sounds better.

Did anything happen to this topic after this?
