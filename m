From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 2/1] Make request-pull able to take a refspec of form local:remote
Date: Fri, 24 Jan 2014 12:16:24 -0800
Message-ID: <xmqqvbx9qgo7.fsf@gitster.dls.corp.google.com>
References: <alpine.LFD.2.11.1401221535140.18207@i7.linux-foundation.org>
	<xmqqlhy6trfp.fsf@gitster.dls.corp.google.com>
	<CA+55aFyGaaMOL5pBhZ1BHMr07oDi2MuS-fPu4nnxhjoy+F0AQw@mail.gmail.com>
	<xmqqsises3u0.fsf@gitster.dls.corp.google.com>
	<CA+55aFyN7WWAF6pGfP+0j29nf6ETao0J5sUu+5UDaXUYC9_Geg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tejun Heo <tj@kernel.org>, Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 24 21:16:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6nB3-0001NM-VK
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 21:16:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940AbaAXUQa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jan 2014 15:16:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39266 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751157AbaAXUQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jan 2014 15:16:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DA72654B1;
	Fri, 24 Jan 2014 15:16:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U7p/xTli/7eL/YZSQtyabYMyG2M=; b=krqx/8
	G7AciygdMxYYB21fb33iwfA2nhZKEXBL5AeRisUNeqe+z+CnpU0OMMbulNub+2lN
	ux6vGD7bN+MCIUQPYWG8YLTOO+Y16RajNF3p0XAnEh0e4x66JnXDKjGLgVuNPu9j
	OXM4Y+MpRNG5vIy67vZ8xOM2wYcTm6mIPjQNw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LRYmoKY7/1eEZrdQrG2TwEbUVekiXPnX
	f9tB3IK0hKFZiMZbOyjtMgxitWZkGbJ/crO9rIp98ZRif8DFBwTv1M8O8dCtDO5E
	nohmASeMqqWFY2v5OdnwL9NWv0A+gzi6k11iF8Q7ozEQxeUaE7nnqN9/pn+yfpHn
	yGM2it+lUa4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8BC46654B0;
	Fri, 24 Jan 2014 15:16:28 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DBA0D654AF;
	Fri, 24 Jan 2014 15:16:26 -0500 (EST)
In-Reply-To: <CA+55aFyN7WWAF6pGfP+0j29nf6ETao0J5sUu+5UDaXUYC9_Geg@mail.gmail.com>
	(Linus Torvalds's message of "Thu, 23 Jan 2014 15:56:14 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 674C41E4-8534-11E3-93B7-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241033>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So I don't actually think anybody should need to be retrained, or
> "always use the local:remote" syntax. The local:remote syntax exists
> only for that special insane case where you used (the same)
> local:remote syntax to push out a branch under a different name.
>
> [ And yeah, maybe that behavior is more common than I think, but even
> if it is, such behavior would always be among people who are *very*
> aware of the whole "local branch vs remote branch name is different"
> situation. ]

As the new default for "git push" would push to the same name, I
agree that people who are now forced to use local:remote syntax
would be the ones who know what they are doing [*1*].

So there are two remaining items, I think.

 - After creating a tags/for-linus signed tag and pushing it to
   tags/for-linus, asking request-pull to request that tag to be
   pulled seems to lose the tag message from the output.

 - Docs.


[Footnote]

*1* Not that it is always acceptable to break the existing users as
    long as they are clueful ones and they are given an escape hatch.
    But this time I know I won't be in the middle of firestorm like
    the one we had immediately after 1.6.0, as long as I keep the
    URL of the message I am responding to in the list archive ;-)
