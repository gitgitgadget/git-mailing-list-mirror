From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-am: indicate where a failed patch is to be found.
Date: Thu, 12 Jul 2012 14:07:43 -0700
Message-ID: <7vobnkadsw.fsf@alter.siamese.dyndns.org>
References: <1342108243-8599-1-git-send-email-paul.gortmaker@windriver.com>
 <7vhatcc1ql.fsf@alter.siamese.dyndns.org> <4FFF1821.7030705@windriver.com>
 <7va9z4byl3.fsf@alter.siamese.dyndns.org> <4FFF2720.6090705@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 23:07:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpQc3-0004Qa-W3
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 23:07:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934250Ab2GLVHr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jul 2012 17:07:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45733 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932936Ab2GLVHq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2012 17:07:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B3B4845E;
	Thu, 12 Jul 2012 17:07:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rEJWxeUkVASyg35/vvfd+lUXztQ=; b=OivrqY
	76ABZ8f2hkMUNf5f0LbyRwbiSyp4LGgNifiSTaN62RGMuaZ+XDhlxZWuTAtkIgXX
	xD5zqVByIRb1A3yKs+rSaGETolWvbFGApdAVG/a3UG0QsIgN4RFoiwLSmF0fbmwC
	d7lOZGSyKokkoL2M8i+gmKMI+jXG64/s4mqEk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=awvyjCCA/TEolGjdZ0NevXB2Ns+0vy7O
	KaYiQoFCmFOVT0FIJV3sR3XuxS28u6rp3V+VuovPU/p5oQuik/2KgmM0N7YZTXpp
	eV0s+3n2bFV6/DdU8eAnpimiDVeWO9/S4Axvq3UCVsOzcOxZKA8kBF+ZIBdsRMWy
	6mhEVB9uo48=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 494A58454;
	Thu, 12 Jul 2012 17:07:45 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BC6078453; Thu, 12 Jul 2012
 17:07:44 -0400 (EDT)
In-Reply-To: <4FFF2720.6090705@windriver.com> (Paul Gortmaker's message of
 "Thu, 12 Jul 2012 15:36:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A01C32B0-CC65-11E1-8391-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201382>

Paul Gortmaker <paul.gortmaker@windriver.com> writes:

> I think this is where our two thinking paths diverge.  You are
> suggesting I edit and fix the patch.  Yes, occasionally I do
> that, if it is a trivial context change.  But hand editing a
> patch is not for Joe Average, and gets very complicated in all
> but the trivial cases.

In your patch, you do not special case and refrain from giving the
location of the patchfile when there is only one patch in the input,
so the above does not matter anyway.

The patch does two unrelated things: reveal the location of the
actual patchfile that failed to apply which was so far kept sekrit,
and tell the user what to do with it.

Because a user who _wants to_ use a patch, once she knows where it
is, would know her favorite way of working with it (be it by editing
it and reapplying, running "git apply" with --reject or reduced
context lines, or running "patch"), an advice on _what_ to do is of
secondary importance between the two.  Perhaps we can postpone the
discussion on that and first update the code to tell _where_ the
patch is to the user?  That would be an improvement from the current
codebase no matter what your faviourite workflow is.
