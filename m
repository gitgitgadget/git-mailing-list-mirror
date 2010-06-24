From: Junio C Hamano <gitster@pobox.com>
Subject: Re: potential improvement to 'git log' with a range
Date: Thu, 24 Jun 2010 13:31:47 -0700
Message-ID: <7v8w64cguk.fsf@alter.siamese.dyndns.org>
References: <w2j3abd05a91004091624mb2836ff4v118a1ae9ac5ca6e7@mail.gmail.com>
 <i2kfabb9a1e1004091633nc70f2f19hd16ea9704f0933b0@mail.gmail.com>
 <n2t3abd05a91004091713s4d081106qd74419425b25e8e@mail.gmail.com>
 <alpine.LFD.2.00.1004091807220.3558@i5.linux-foundation.org>
 <AANLkTinPrObdQh1vZLo0tlq2bZn7BXKvHWLktI2pR5LY@mail.gmail.com>
 <7vmxulebr2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Aghiles <aghilesk@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	git list <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 24 22:32:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORt5l-000424-Hx
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 22:32:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755225Ab0FXUcE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 16:32:04 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42972 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755060Ab0FXUcC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 16:32:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DAA8FBED55;
	Thu, 24 Jun 2010 16:32:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=7mtDMIyVZMuU/5AZ4pqQGmCfKzQ=; b=IWP44o
	fAc4Q4gmKFwp54HFGHxA/9M8TnQ5H7H7a+W7uOnAIVK59HLXeWgmlthyDX3HhC2O
	Ej+gm4pp3QQ38aT2/2CuHGYHM44DKAy6dIxdOZzbqXF14mDDxGlr1hDiY4OhKgdm
	TK7+svcoU91W0165H0T37ZSEyG5Y6bzYbxc9k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cf5tAjDNHSWPa/hj9ZGXpJuzhQ5DIbNK
	SLzbZTbB1PyGAr0smgTOIKHcRPJjzxWVuF+E85gtD/HeTs3bdgTML6dnL8EiT6Nm
	g/pq7xQ0uYHF86CFtacbm5jimmfUXg62YNy9mHtlYJuJLFIOFsXZ9UPf2Slz2bhT
	eanrGAN78NM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D7AFBED4F;
	Thu, 24 Jun 2010 16:31:55 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0155BBED46; Thu, 24 Jun
 2010 16:31:48 -0400 (EDT)
In-Reply-To: <7vmxulebr2.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 23 Jun 2010 13\:26\:41 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8782C4C4-7FCF-11DF-BC91-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149639>

Junio C Hamano <gitster@pobox.com> writes:

> Jay Soffian <jaysoffian@gmail.com> writes:
>
>> Speaking of which, I'd love a switch to "git show $merge_commit" which
>> does "git log $merge_commit^..$merge_commit^2" but I've been too lazy
>> to write it. 9/10 times that I use .., it's in this context. :-)
>
> Doesn't "git show -p --first-parent $merge" work for you?

Heh, this is a totally different operation to compare the tree before and
after the merge.

What "log merge^..merge^2" does is to list the commits we merged from the
point of view of the person who did the merge.  I haven't found the need
for a short-cut for that myself, but in any case, I think such a feature
belongs less to "show" (which is about "inspecting a single object") than
to "log" (which is about "give me the sequence").

You may want to look into merge.log variable if you find yourself wanting
to do that often with your history, though.
