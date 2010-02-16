From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix threaded grep for machines with only one cpu
Date: Mon, 15 Feb 2010 17:12:37 -0800
Message-ID: <7v3a12t24a.fsf@alter.siamese.dyndns.org>
References: <20100215225001.GA944@book.hvoigt.net>
 <7vwryet2cw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Feb 16 02:12:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhBzk-0008Ts-8x
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 02:12:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394Ab0BPBMv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 20:12:51 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45184 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756025Ab0BPBMu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 20:12:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 039529AA8F;
	Mon, 15 Feb 2010 20:12:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g+zRPkwbS5PluZ5NdueoiHPc/cE=; b=Mc6TnS
	fcZ/u9VMC4iajcL0n9lHtuHZT5WvDDlVc68pCFnqxH6pOmPKtLi6KZSAJTfmbBQM
	YKptrTaiD07EFvRe9hdDvF0JBOcx33c+iaFgzuyUthg13GuYWTggq8icBCu3atku
	2ECvF2Mknham1Ei0K5Yw/+mDYXVxrcLsquoJo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aNJCxdicDf4VH1eK2OnfsoBiQ6PBruP+
	WJvtw6FwPdBUbNuNaGkfPRVt0CCj+iHbvjAb30/8i/54fxY3cjBi6Knd8BR9l2y/
	YX6I3aTklJaJO1DywGc7qLNZsYHgJ0n3uPcTH4wV3nQniglcysab+P4d2QAVlvF/
	PgmhgchSiLQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C55439AA8A;
	Mon, 15 Feb 2010 20:12:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 700A59AA80; Mon, 15 Feb
 2010 20:12:39 -0500 (EST)
In-Reply-To: <7vwryet2cw.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 15 Feb 2010 17\:07\:27 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 647D9126-1A98-11DF-850E-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140055>

Junio C Hamano <gitster@pobox.com> writes:

> Heiko Voigt <hvoigt@hvoigt.net> writes:
>
>> In case the machine has only one cpu the initialization was
>> skipped.
>
> An obvious question that forces reviewers to go "Huh?" is why this
> matters.
>
> If use_threads is false, we do not call start_threads(), and I think at
> least the intent of the threaded grep code in 5b594f4 (Threaded grep,
> 2010-01-25) is that uninitialized mutexes matter at all in that case.

s/matter/do not &/; obviously.
