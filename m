From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] setup_revisions: remember whether a ref was positive
 or not
Date: Mon, 08 Aug 2011 15:56:02 -0700
Message-ID: <7vd3gfv7gd.fsf@alter.siamese.dyndns.org>
References: <1311517282-24831-1-git-send-email-srabbelier@gmail.com>
 <1311517282-24831-4-git-send-email-srabbelier@gmail.com>
 <7vy5znscst.fsf@alter.siamese.dyndns.org>
 <7vr55fs1z0.fsf@alter.siamese.dyndns.org>
 <CAGdFq_ghxFdpjxCgTNbqXWGpt0rpJaGZ1_h+ZC71PzaPzbQ-0A@mail.gmail.com>
 <7vy5zabbz7.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1108081748060.7748@s15462909.onlinehome-server.info>
 <7vfwlbztfg.fsf@alter.siamese.dyndns.org>
 <CAGdFq_hLy6_AW-Yh_9fi318Z6jdkFWw5+cYrwMtOitDkGQorFA@mail.gmail.com>
 <7vpqkfv8x1.fsf@alter.siamese.dyndns.org>
 <CAGdFq_jzraS-_afjs+MmRS4ML805h73hXAjrRkrQ=tGUdSQqkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 09 00:56:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqYk0-0000vG-AN
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 00:56:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610Ab1HHW4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 18:56:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38623 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751328Ab1HHW4F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 18:56:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B37284178;
	Mon,  8 Aug 2011 18:56:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RMbdYh1L2og4OHZA1SUVIrxhHwk=; b=mI423u
	n4JUh3IVMQgzx7bWmFIcho4Luy77nT2lzhUI8X5lWKfhzES4CiBFZ4pj9LgCvv7R
	1HmEWC3BjvwUnBtgLadyoD0HRLypN3pydQdsAkLqS4tlyF1uhPUkFQvs/r8IiHA/
	iXJY+z7V7VxZdwde2eYs8nfLa62pxaSvxm6vA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JO/QEWR4uSycwJHz7ClypVOhF07CKR1q
	0Lv6Wx9RjZVXP2hSDDSgEaYVjFdRfTzZM3oJfgs2kHmW0hRijMBMGVAHNG7FiJkm
	dqHPbHSuLyQV5Pil4RT01M8OE1q6NTI/RQYrXtQVqqYiHDu/HwXrozNKApMTBayu
	+nJms+U+gNc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6BDA4177;
	Mon,  8 Aug 2011 18:56:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 30F504176; Mon,  8 Aug 2011
 18:56:04 -0400 (EDT)
In-Reply-To: <CAGdFq_jzraS-_afjs+MmRS4ML805h73hXAjrRkrQ=tGUdSQqkQ@mail.gmail.com> (Sverre
 Rabbelier's message of "Tue, 9 Aug 2011 00:28:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 980F01E2-C211-11E0-A506-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179001>

Sverre Rabbelier <srabbelier@gmail.com> writes:

>> Please remind yourself why then it is not sufficient for your patch to
>> read from the name field please?
>
> Sure, we could do it. But it would be duplicating all the effort
> already being done in rev-parse!
>
>> After all, wasn't the issue that "master^0..master" yields an empty set
>> but you somehow wanted to know that the RHS of that dotdot was given as a
>> positive ref?
>
> The issue was that if I push "master" to origin but I already pushed a
> "next" which points at the same commit nothing happens...

Would we have the same issue with "git bundle", by the way, caused by the
same setup_revisions() limitation?  Over there we would also need to
decide the set of refs that the user wanted to record their values while
computing the set of commits we would need to transfer. 

In this message I am not interested in talking about what implementation
to use to fix it, but just wondering the scope of the same issue and
trying to figure out the (positive) impact of _a_ fix.
