From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Cannot push some grafted branches
Date: Mon, 17 Dec 2012 13:14:56 -0800
Message-ID: <7vwqwgjs8f.fsf@alter.siamese.dyndns.org>
References: <20121211153903.7522d6b0@chalon.bertin.fr>
 <7vd2yg8ngk.fsf@alter.siamese.dyndns.org>
 <20121212094432.6e1e48c8@chalon.bertin.fr>
 <7v38zb3ux0.fsf@alter.siamese.dyndns.org>
 <877goht6eu.fsf@pctrast.inf.ethz.ch>
 <20121217114058.449cbc3c@chalon.bertin.fr>
 <CAP8UFD2pkotNy=t5wTxDH-pMivQsTz-kw2y8Y7rWY42YKabp7g@mail.gmail.com>
 <m21ueo78f8.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <christian.couder@gmail.com>,
	Yann Dirson <dirson@bertin.fr>,
	Thomas Rast <trast@student.ethz.ch>,
	git list <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Mon Dec 17 22:15:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tki1v-000582-9C
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 22:15:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752948Ab2LQVO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 16:14:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63911 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752714Ab2LQVO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 16:14:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FC6E93FD;
	Mon, 17 Dec 2012 16:14:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RouGEIpIQUMOETed3eaL9ge5D6Y=; b=Rwo08O
	Aculc28YcbxSxpitscnNpwcT0q0bZJB6YczVFwcVaeZlVdRJEwlitl8n/H6kbF3H
	5NOXcDFp9NOtMDUF4hhU3IfFwjBS28um+cUUfo727XK2+N8z9jJ61Yaw4SFeJuDf
	ZAh+nN65zwbHtFbu27R2XVGO4KdT1KuqVr7Gw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NqaN9FYVJzZlSDVrj+5NOvxUmMrAxL0D
	mR0HeDeROeDQrGvnUtIxEud/IJrvQBDPXD9x7g6pDUUZEHbbat2lNBKyQkVHIgmA
	/+56snxtM0q8QBxtPEYKI1O7jZEFefnQoBHCv8V2y7hu/NQwbB1TEjGOqhQqJqPe
	brOiXTT7vOU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CC8E93FC;
	Mon, 17 Dec 2012 16:14:58 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EDE1793FB; Mon, 17 Dec 2012
 16:14:57 -0500 (EST)
In-Reply-To: <m21ueo78f8.fsf@igel.home> (Andreas Schwab's message of "Mon, 17
 Dec 2012 21:03:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CF96BE48-488E-11E2-8790-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211704>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Christian Couder <christian.couder@gmail.com> writes:
>
>> Yeah, at one point I wanted to have a command that created to craft a
>> new commit based on an existing one.
>
> This isn't hard to do, you only have to resort to plumbing:
>
> $ git cat-file commit fef11965da875c105c40f1a9550af1f5e34a6e62 | sed s/bfae342c973b0be3c9e99d3d86ed2e6b152b4a6b/790c83cda92f95f1b4b91e2ddc056a52a99a055d/ | git hash-object -t commit --stdin -w
> bb45cc6356eac6c7fa432965090045306dab7026

Good.  I do not think an extra special-purpose command is welcome
here.
