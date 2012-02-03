From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Alternates corruption issue
Date: Fri, 03 Feb 2012 09:38:13 -0800
Message-ID: <7v8vkjstq2.fsf@alter.siamese.dyndns.org>
References: <20120131193922.GA31551@sigill.intra.peff.net>
 <7v1uqf8vqu.fsf@alter.siamese.dyndns.org>
 <20120131204417.GA30969@sigill.intra.peff.net>
 <20120131214047.GA13547@burratino>
 <20120131214740.GA2465@sigill.intra.peff.net>
 <20120131215501.GF13252@burratino>
 <20120131220510.GA3253@sigill.intra.peff.net>
 <20120131222258.GG13252@burratino>
 <20120202215913.GA26727@sigill.intra.peff.net>
 <7vzkd0u4ik.fsf@alter.siamese.dyndns.org>
 <20120203120215.GA31441@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	GIT Mailing-list <git@vger.kernel.org>,
	"Hart\, Darren" <darren.hart@intel.com>,
	"Ashfield\, Bruce" <Bruce.Ashfield@windriver.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 03 18:38:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtN5a-0008Jm-2U
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 18:38:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757328Ab2BCRiR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 12:38:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60803 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753592Ab2BCRiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 12:38:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECD2D3435;
	Fri,  3 Feb 2012 12:38:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W7Rz1PMgF3CSmfiCEtXq8Du8xZo=; b=i6m5Ff
	Evb6OmGv1D+OqWnQEI8Xg9WrjW6fMoWj1yJUksFvhpuCyB+q4HhEsV8TP+Xzru8T
	fBX6qu1ZFJT07Vpi0z6Zs6d+VgfMXRDk5HcFA0dAX/nrE0ccja+MtKj1iS2jE59N
	6mq9t96uUn+4/ajG3rqBtqcFw1KKdM/nzFHLw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=av2nHISqKfQyuyNKOSDZwzDOMziwwQSE
	5oNeJIEwWNlEcwNd4M4H4s8X7dwDznTPfnFLBnlm5ZprkJy7EisOwbKIa4LgO/UL
	H43u1SLj3CFMZTRNht469n4jofryv9OacY/9rNAp0ebb4KFX7azdzPhGs6LDbQvQ
	MuMkvY4JF5I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E41AA3434;
	Fri,  3 Feb 2012 12:38:15 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 797BE3433; Fri,  3 Feb 2012
 12:38:15 -0500 (EST)
In-Reply-To: <20120203120215.GA31441@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 3 Feb 2012 07:02:15 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DA25FBCC-4E8D-11E1-8B28-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189786>

Jeff King <peff@peff.net> writes:

> However, with the ordering change, there is a technically a regression
> in one case: a random file "foo" next to a repo "foo.git". Saying "git
> ls-remote foo" used to prefer "foo.git", and will now select the file
> "foo" only to fail.

Yeah, very true X-<.

> Thanks for noticing. I saw this issue when I was writing the original
> version of the patch, and meant to revisit it and at least document it
> in the commit message, but I ended up forgetting.

No, thanks for working on this.
