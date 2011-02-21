From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] merge: improve inexact rename limit warning
Date: Mon, 21 Feb 2011 15:33:14 -0800
Message-ID: <7vzkppgdz9.fsf@alter.siamese.dyndns.org>
References: <20110219101936.GB20577@sigill.intra.peff.net>
 <20110219102051.GA22508@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 22 00:33:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrfFz-0002cG-2C
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 00:33:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567Ab1BUXd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 18:33:26 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50033 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015Ab1BUXd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 18:33:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AAC6D3FC7;
	Mon, 21 Feb 2011 18:34:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=/2wT1yhn7Qk00I6kC5fE5yXF358=; b=Q+8ubL+zppnsbpzqmNoHB8G
	tJjymm4LgbkllhRv9yiXC5xrHfhDj7nDuMeL4kgm8T3UUvjv9QmvtVkzddZ/fueg
	BHPJha5IrdW8CKNLAnZvjbWVaenxdeII0C9HkchGjioHRVNogtlwGuYye3/GiKJv
	ofpTJ+BnUP1hxd0TGSKk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=NhUE8dWEKikHw29A9wnWNB2UkcWAUjAK1aILd/lbc2P32hliw
	yDOTFvolo8RqTUmddC1D0QJCER7UNn1117hDtfgbcYGXJ9YtjCLhpG+COjAvJwPl
	Bp1KaKgF/+2NmTo3oaQ6DbTMEdQNt7Aioa7uFxPLZ5RIX4KgQ4+s+Xl3P4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6B1C73FC4;
	Mon, 21 Feb 2011 18:34:32 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 020E13FC1; Mon, 21 Feb 2011
 18:34:26 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 226D3CA6-3E13-11E0-8213-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167512>

Jeff King <peff@peff.net> writes:

> The warning is generated deep in the diffcore code, which
> means that it will come first, followed possibly by a spew
> of conflicts, making it hard to see.
>
> Instead, let's have diffcore pass back the information about
> how big the rename limit would needed to have been, and then
> the caller can provide a more appropriate message (and at a
> more appropriate time).
>
> No refactoring of other non-merge callers is necessary,
> because nobody else was even using the warn_on_rename_limit
> feature.
>
> Signed-off-by: Jeff King <peff@peff.net>

Thanks.

This conflicts with 2840824 (diffcore-rename: fall back to -C when -C -C
busts the rename limit, 2011-01-06) on 'pu', unfortunately.
