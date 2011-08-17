From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] update-index: add --swap to swap index and worktree
 content
Date: Wed, 17 Aug 2011 11:26:26 -0700
Message-ID: <7vr54jevxp.fsf@alter.siamese.dyndns.org>
References: <1313158058-7684-1-git-send-email-pclouds@gmail.com>
 <7vippxgm6y.fsf@alter.siamese.dyndns.org>
 <20110816210108.GA13710@sigill.intra.peff.net>
 <7vbovpggva.fsf@alter.siamese.dyndns.org>
 <20110816222212.GA19471@sigill.intra.peff.net>
 <7vzkj9eza2.fsf@alter.siamese.dyndns.org>
 <20110816230654.GA21793@sigill.intra.peff.net>
 <CACsJy8Ad4xPz79jT3O64c3XsCeM8XETJ9bnjK0aisagrYN0CMA@mail.gmail.com>
 <20110817021727.GA29585@sigill.intra.peff.net>
 <CAOeW2eFx-ETS+1a5b2bUXeT8JJ0WGudKGyF6mxuqyK2OM35qQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 17 20:26:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qtkp0-0003rM-6q
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 20:26:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120Ab1HQS03 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Aug 2011 14:26:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47224 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751798Ab1HQS03 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2011 14:26:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 083A73813;
	Wed, 17 Aug 2011 14:26:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YTD0gPDOugcBTlno2KuGkER3G+E=; b=wRaURQ
	dOfN6I15szdaUAdH5C2lpbutZB8YQRjV23aEP5yeDwyIXb3UEcY7K+8CXnPlQvUs
	TcExI1YAbN8IVEvlnQaahQKm6kLwZrngYXIehYY4vA2fyPSgwxGkQNUZQhgyrwzO
	TpYV9cnsn7MNZFKeq6u8EQ1ihCIdJhWXbJsRE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FW/QPTrBE62L11rQ1opkTIYzU/WWVbr1
	bgM/98UCux6IwwGSk73BOa9mzcdBFHqUZUbwKmDXGc+PVR7yUt/JoKh82dN8Vido
	czMd81QAZtMomO9fKSLgPBFeH3cer4U5ES0zJpflIynCJkuykyDQze8LqVs/q1O5
	vvZ3qDwjb40=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2BBF380A;
	Wed, 17 Aug 2011 14:26:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 78F053807; Wed, 17 Aug 2011
 14:26:27 -0400 (EDT)
In-Reply-To: <CAOeW2eFx-ETS+1a5b2bUXeT8JJ0WGudKGyF6mxuqyK2OM35qQA@mail.gmail.com> (Martin
 von Zweigbergk's message of "Wed, 17 Aug 2011 10:13:08 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6BB01B1A-C8FE-11E0-8231-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179522>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> Maybe the above shows that I'm missing something. Still, would it be
> possible to achieve the use case with something like the following?
>
> git stash --keep-index

While I sense a vague aversion to committing in general in this
discussion, which I am not particularly fond of, the whole point of
"stash" is to avoid the mental burden of going over the "hump" of
committing something not ready and to replace it with a "save it as a
temporary state" that technically has the same overhead of committing but
has a lot less mental overhead. Perhaps "swapping the state of all and/or
selected paths" fits better in "stash", not "update-index"?

I dunno, but in general, a new feature to cater to _common_ end user needs
should fit in the Porcelain layer. We would be doing something wrong if we
need to teach an obscure option of lower plumbing to end users.

I personally used to feel that "ls-files -u" during a conflicted merge to
be the single sore-thumb that stuck out from this point of view, but these
days "status -s" gives the same information in a more useful way to the
end users, and I am reasonably happy with that. It may be that the end
user operation (perhaps "stash --swap", but I am not married to that) that
fits well in common workflows ends up using "update-index --swap" as an
underlying implementation detail, but I'd prefer to see how the final end
user experience using Porcelain would look like first.
