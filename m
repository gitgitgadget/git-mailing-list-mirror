From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] receive-pack: close sideband fd on early pack errors
Date: Fri, 19 Apr 2013 15:30:07 -0700
Message-ID: <7vr4i6xifk.fsf@alter.siamese.dyndns.org>
References: <20130419212429.GA20873@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 20 00:30:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTJov-0005tt-Lx
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 00:30:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934470Ab3DSWaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 18:30:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61572 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933870Ab3DSWaK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 18:30:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 95607182E2;
	Fri, 19 Apr 2013 22:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ODExWUU2baPIgwJ8CScXU0meYA4=; b=bjrA7k
	5WQQjvIFGkIVhhXG4QDzDFX23rfLi6weme1zw4PtqWBYPgqFqOSDEq0cWLLBmtI6
	NEKyui52l0N89xOR6pOFeiDGCewexHC/IujUPf2cdR/O/AsmWbtOARoa3fe/R8y1
	o8vOfxVlU/zLtFIBtXvtrI2+xQ6M5qEDE0tSw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tc21LSIM1sKCGQdWLSjf6EGKcsssp2q0
	reekh1rWbYo6NI42tlIplJNO3C5oySwEAQRs5+7cyVX3mY9cARvya+Oshd61xLVP
	E+CRXkTZ420duhfo9KQL/nvVE2wOQwPl6ISrulsBdf7Vw0jxbzTtqAgn6IM9pBQN
	A2uW8R/sGsM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C485182E0;
	Fri, 19 Apr 2013 22:30:09 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AB334182DF;
	Fri, 19 Apr 2013 22:30:08 +0000 (UTC)
In-Reply-To: <20130419212429.GA20873@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 19 Apr 2013 17:24:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B1002902-A940-11E2-87D5-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221827>

Jeff King <peff@peff.net> writes:

> This was triggered in the real world by attempting to push a ref from
> a corrupted repository. pack-objects dies on the local end, we get an
> eof on the receive-pack end without any data, notice that it's a bogus
> packfile, and hit the deadlock.
>
> The bug was introduced by a22e6f8, which is in v1.7.12.3, so it should
> be maint-worthy.

Hmm, well spotted.  Will queue.  Thanks.
