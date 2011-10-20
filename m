From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] revert: fix buffer overflow in insn sheet parser
Date: Thu, 20 Oct 2011 11:55:17 -0700
Message-ID: <7vaa8va3xm.fsf@alter.siamese.dyndns.org>
References: <1319058208-17923-1-git-send-email-artagnon@gmail.com>
 <1319058208-17923-4-git-send-email-artagnon@gmail.com>
 <7v8vogbgai.fsf@alter.siamese.dyndns.org>
 <20111020080328.GA12337@elie.hsd1.il.comcast.net>
 <4E9FE061.3080601@gmail.com>
 <20111020090912.GA21471@elie.hsd1.il.comcast.net>
 <7vmxcva8k1.fsf@alter.siamese.dyndns.org>
 <20111020180533.GA5563@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 20 20:55:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGxm1-00057N-DM
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 20:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422Ab1JTSzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Oct 2011 14:55:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50709 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751127Ab1JTSzU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2011 14:55:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF45F53CD;
	Thu, 20 Oct 2011 14:55:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FoBpTIkfW9dx99r35x+6ZGQLDy8=; b=YjQ/wT
	YchpXsNRIeDXLk6VMN611B/bzz66VEtEvcC6ScoSEapfCEe1zfOokj1cI7Kh+yZT
	laBAw0lCgUHQJPiUzOuoj/gOwQrFkZQ8GzQmKmToZ4zH8TTqlbbXMzzT1Up0jytF
	GeextdDK+slXe8LZVyyOMtikXChwjJoBurdwc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yCXKrpoBbDGraBZesDcFUEWVCUdpa9eB
	FwK1Q6d0lZAC1tMDTq4oGSkJYp4yWGmmIAoKECt+DLFl6vDMlMCSpYnU6ERvIqrC
	7kB+wwQpTmUeJt6b/MgD5H5NYYr2yDQ1pajggqKdmuwNcjbJG38I1kU+9Dgt6FGN
	qqsghNmjtH8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6A9553CC;
	Thu, 20 Oct 2011 14:55:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 10C7553CB; Thu, 20 Oct 2011
 14:55:18 -0400 (EDT)
In-Reply-To: <20111020180533.GA5563@elie.hsd1.il.comcast.net> (Jonathan
 Nieder's message of "Thu, 20 Oct 2011 13:05:33 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0E396D84-FB4D-11E0-A020-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184035>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Incidentally, Ram might wonder why I fuss so much about commit
> messages.  It's actually very simple --- I think of them as part of
> the code.

And another reason is because I do fuss about them too ;-)

It is easy to tell a good patch from a bad one by just reading the message
without actually reading the patch text itself.

When the log message justifies the cause and the approach in the right
way, the actual patch becomes self evident. Also I often find myself
coming up with a _better_ solution than the patch I originally prepared
while writing the commit log message to explain it, and redoing the patch
text to match the description.
