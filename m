From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add the --submodule-summary option to the diff option
 family
Date: Wed, 07 Oct 2009 13:00:36 -0700
Message-ID: <7vd44zt1nf.fsf@alter.siamese.dyndns.org>
References: <cover.1254668669u.git.johannes.schindelin@gmx.de>
 <67a884457aeaead275612be10902a80726b2a7db.1254668669u.git.johannes.schindelin@gmx.de> <7vbpkmn6oi.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0910051027010.4985@pacific.mpi-cbg.de> <7vr5thacb4.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0910052251190.4985@pacific.mpi-cbg.de> <4ACB22E9.3010001@web.de> <7vocok21pw.fsf@alter.siamese.dyndns.org> <4ACCECE6.1030508@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Oct 07 22:09:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvcpG-0005vB-6j
	for gcvg-git-2@lo.gmane.org; Wed, 07 Oct 2009 22:09:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759964AbZJGUB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2009 16:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759963AbZJGUB2
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Oct 2009 16:01:28 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47160 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756960AbZJGUB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2009 16:01:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5BAE350616;
	Wed,  7 Oct 2009 16:00:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Idtkqi9ZDcw05bpJfSLSwU4kyRw=; b=dOG4q8
	0sD7+cFT8lFo1IJvQFO11FalTlwQbaa26HgXb8xGp6Vs2aqqryGSQ66jtKIxSC9d
	IGqkkWX3daKjh8VKNHgshYluoL1ZuIiVtd06DqDmb7s+qcKhfloHasR6y++XKYhP
	gsR3Ke9vCgHuMF2yxfMm6OqRY3Uyi5haSSj6U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eNAMtfLigfYFpsD9QTFHNFEWkzGfJZ0z
	UuAvqFf/AZr0tq5umtDtnoyeLjkZ7wZv52riL8Qwquj6NJgrY9hYljdPHR/r3/qM
	HPqCA77rMkgSnOhrZtsPIUNfzjfVtBd8NcaAUIZol5ntxN9OxgVE3PDEys1CP46d
	z2dHaIculeY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FD6850614;
	Wed,  7 Oct 2009 16:00:41 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 70E2050613; Wed,  7 Oct
 2009 16:00:37 -0400 (EDT)
In-Reply-To: <4ACCECE6.1030508@web.de> (Jens Lehmann's message of "Wed\, 07
 Oct 2009 21\:32\:54 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 170C1BD4-B37C-11DE-A989-E80E3AD9C332-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129655>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> So i took a live repo from my dayjob containing 8 submodules. In each
> submodule i did a "git checkout HEAD^" to simulate one change.

It appears that your "simulation" is to have changes in all submodules and
nowhere else in the tree.  I have to wonder how common would that be.  If
I have been working in the subprojects without changing the superproject
at all, I would likely to be in one of the subproject directories and my
"git diff" would not even have to trigger this codepath.  If we have on
the other hand changes in the superproject, showing them would cost us
equally in both approaches.

> then i got:
>
>   without fork : real	0m0.203s
>   with fork    : real	0m0.453s
>
> This is a degradation of more than 120% because of the fork()s. And
> just for fun i ran the scripted submodule summary too:
>
>   scripted     : real	0m3.437s
>
> So the forked version outperforms the scripted version by a factor of
> 7, while the speedup from Dscho's original proposal is almost 17fold.

Thanks.  I was worried if the forking to ensure correctness may sactifice
performance so much to be unusable, but it does not seem to be the case,
given the above comparision.

I didn't look at the code but presumably it uses the run_command()
interface and cleanly written?
