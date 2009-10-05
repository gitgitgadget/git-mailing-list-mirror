From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach 'rebase -i' the command "amend"
Date: Mon, 05 Oct 2009 14:07:10 -0700
Message-ID: <7vbpkl8s8x.fsf@alter.siamese.dyndns.org>
References: <4AC8F22F.5070101@gmail.com>
 <alpine.DEB.1.00.0910042308200.4985@pacific.mpi-cbg.de>
 <6672d0160910042308v7280dcadyff97b977bcfe12c3@mail.gmail.com>
 <alpine.DEB.1.00.0910051116480.4985@pacific.mpi-cbg.de>
 <fabb9a1e0910050239h614118cfw8a5055e4ed966dd1@mail.gmail.com>
 <6672d0160910050910x3a9aa6a3w742c09e7f2f42187@mail.gmail.com>
 <87ab05r5hg.fsf@dylle.kalibalik.dk>
 <alpine.DEB.1.00.0910052248500.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anders Melchiorsen <mail@spoon.kalibalik.dk>,
	=?utf-8?Q?Bj=C3=B6rn?= Gustavsson <bgustavsson@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 05 23:13:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Muurg-0006cn-Fb
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 23:13:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754800AbZJEVIL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 17:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754799AbZJEVIJ
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 17:08:09 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60749 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754718AbZJEVII (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 17:08:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D00784D708;
	Mon,  5 Oct 2009 17:07:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=av6l0GDmqCIdNZdFUeNP7CepxpQ=; b=Mvw23F
	n8UCMd9Hc48tLhdDJFWCX//0+mfPx7boo8NxMls2q1u/qFLBAKccdz0Ee/v43A6y
	6oHh1Ijky3ICgVLPYEi4uJVGsA440QLcRSf1AQDwPhQVUNk8LaROx5doWaKb6xKu
	7qdT7YfR0hTFTZa6fSprS0/essOaT4J8LiroM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XGCM/yW7i5MHr7pcr12LFHYIH2uzorY1
	3wCqegqrZqieLU28B+sHLcOdzYFCwW6Jgcu9SWe5C0DPOZqg30iK+lqii7SCXpRQ
	A5rsgmHygAnKG6CYlhcGuwDDqRK+X9y/rwnbptNJjhfmkFwTmeCgCVsVqQ/ux7X6
	X7jojG4YB5Y=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C1694D702;
	Mon,  5 Oct 2009 17:07:19 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 433DC4D6FD; Mon,  5 Oct
 2009 17:07:12 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0910052248500.4985@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Mon\, 5 Oct 2009 22\:50\:05 +0200
 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 115BD3D0-B1F3-11DE-B2F4-92E639D9C332-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129589>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Being in an editor but still not able to fix typos is a nuisance.
>
> NAK.
>
> Supporting that would be totally out of line with the way rebase -i is 
> supposed to work.

If the rebase insn sheet were richer, and had a way to show the full
message, like this:

pick 4973aa2 git-pull: dead code removal
    Back when a74b170 (git-pull: disallow implicit merging to detached HEAD,
    2007-01-15) added this check, $? referred to the error status of reading
    HEAD as a symbolic-ref; but cd67e4d (Teach 'git pull' about --rebase,
    2007-11-28) moved the command away from where the check is, and nobody
    noticed the breakage.  Ever since, $? has always been 0 (tr at the end of
    the pipe to find merge_head never fails) and other case arms were never
    reached.
    
    These days, error_on_no_merge_candidates function is prepared to handle a
    detached HEAD case, which was what the code this patch removes used to
    handle.
    
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

I do not see why we shouldn't allow people to edit any part of the above
to reword.

I would even understand (but not necessarily agree) if somebody wants to
give the patch text and let users edit to reapply.

So I do not agree with your "totally out of line" at all.

> Besides, if you already have typos in the commit subject, you _better_ 
> check the whole commit message, so: double NAK.

That sounds a bit too dogmatic.

But I tend to agree with you that we would be better off not accepting
such a "retitle" patch, as it strongly encourages single-liner commit log
messages.

Oh, there was no patch?  Then nevermind...
