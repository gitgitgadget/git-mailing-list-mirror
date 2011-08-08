From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] setup_revisions: remember whether a ref was positive
 or not
Date: Mon, 08 Aug 2011 15:24:26 -0700
Message-ID: <7vpqkfv8x1.fsf@alter.siamese.dyndns.org>
References: <1311517282-24831-1-git-send-email-srabbelier@gmail.com>
 <1311517282-24831-4-git-send-email-srabbelier@gmail.com>
 <7vy5znscst.fsf@alter.siamese.dyndns.org>
 <7vr55fs1z0.fsf@alter.siamese.dyndns.org>
 <CAGdFq_ghxFdpjxCgTNbqXWGpt0rpJaGZ1_h+ZC71PzaPzbQ-0A@mail.gmail.com>
 <7vy5zabbz7.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1108081748060.7748@s15462909.onlinehome-server.info>
 <7vfwlbztfg.fsf@alter.siamese.dyndns.org>
 <CAGdFq_hLy6_AW-Yh_9fi318Z6jdkFWw5+cYrwMtOitDkGQorFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 09 00:24:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqYFP-0006eq-RU
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 00:24:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752782Ab1HHWYa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 18:24:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60891 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752180Ab1HHWY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 18:24:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DCDC5C35;
	Mon,  8 Aug 2011 18:24:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RnfuSvCGhlIedZei6aijz6LCAQ4=; b=ZbEUoD
	Vqnxbc7Vdw1Rg5dUOiMwNvoj6v8OmOLaqKzo9HYLm25izkEFlW//9qcG2UtdezRQ
	cygHHzqDyKJsZ+nwhHFpqZM5cF8FEZWcJfQHCLUoRLIZJYaqwHWXZb72VpuFLm3G
	w0uuXQ12td2VLmNXBvOxXK4osy9NC6ld18ItM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AMCmbTf7FJEVbM+nu80SWVFKst1v9nYL
	X+85xDMjNOdb8zuOb5eOBPkpgmoVFgwELV8+yY/ZFsmKXbXqQvzonj0k2O+b8Xsu
	USflC1b1AYQSg84hxkX90mE7flPifYrDZW+SYYk/Zif5qTSqDZGzT2WY/vvDEwvx
	HjwPOnjclyA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 08E5D5C34;
	Mon,  8 Aug 2011 18:24:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 75C7E5C2F; Mon,  8 Aug 2011
 18:24:27 -0400 (EDT)
In-Reply-To: <CAGdFq_hLy6_AW-Yh_9fi318Z6jdkFWw5+cYrwMtOitDkGQorFA@mail.gmail.com> (Sverre
 Rabbelier's message of "Mon, 8 Aug 2011 23:27:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2D873ABE-C20D-11E0-A159-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178994>

Sverre Rabbelier <srabbelier@gmail.com> writes:

>> But the point is that this codepath does not have a faintest clue whether
>> the "obj" parameter is something the end user actively asked for (which
>> might have been marked as uninteresting for other reasons, namely, because
>> it is reachable from other negative refs). So passing unconditional 0 is
>> just as bad.
>
> Doesn't passing 0 indicate that we _did not_ receive any explicit user
> input on this ref, which is exactly what we want to record? If the
> user passed us any explicit input on the ref, we record it at the
> other call-sites, here, the user told us nothing, so we record exactly
> that, nothing.

Hmm, which means you have a way to say "explicitly affirmative" vs "no
information", but no way to say "explicitly negative", for example, and
the worse part is that it is unclear if the approach the patch takes is
extensible enough to allow that in the future. That is the kind of "myopic
hack" attitude I did not particularly like in this patch.

"The next person who needs more generic framework can rip out what this
patch does and the work required is the same amount" is not a convincing
argument---it would mean you are burdening that other person with an extra
work to _redo_ what this series does properly, and it is not likely to be
of help for that person after your interest in this codepath has long
waned.

>> As I said, I am not married to the verbose struct/union representation
>> (the only reason I showed that verbosity was because it allowed me to do
>> away without having to enumerate all the syntax sugars we already
>> support); if your "flags" can express the same thing (it may needs to
>> become a bitfield with enough width, but I highly suspect that you would
>> also need at least a component that says "this is the string the user gave
>> us --- the user said 'master', not 'master^0', for example) and is a lot
>> more compact, that is definitely we want to go with.
>
> Don't we already store that in the name field?

Please remind yourself why then it is not sufficient for your patch to
read from the name field please?

After all, wasn't the issue that "master^0..master" yields an empty set
but you somehow wanted to know that the RHS of that dotdot was given as a
positive ref?
