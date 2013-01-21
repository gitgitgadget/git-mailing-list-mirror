From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-cvsimport-3 and incremental imports
Date: Sun, 20 Jan 2013 16:01:29 -0800
Message-ID: <7vehhfjteu.fsf@alter.siamese.dyndns.org>
References: <20130120200922.GC7498@serenity.lan>
 <20130120232008.GA25001@thyrsus.com> <20130120233422.GB3474@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Eric S. Raymond" <esr@thyrsus.com>,
	John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 01:02:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tx4pu-0004gh-4C
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 01:02:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752673Ab3AUABe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 19:01:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52153 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752509Ab3AUABd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 19:01:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0044DB2D1;
	Sun, 20 Jan 2013 19:01:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ftxnzfq7nXm2xvWRPBS6f+aAkbA=; b=ZsindV
	McviVicmetPUKuLxkXEGIVGjW6MAZmOeBkJKQy2SvZTE24iAZ1o3ga0rcwSDMTAV
	GCltX8A4fZXQT+JG8881qC39NVZz44631iE15wwA42kRlviaIpe4K9GEiN1r/bNO
	p9B6oFn8dQUXNr9Rt0iYy3F4uzLoeWnJXkiYI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cEFF1O6eU3+I48hVOoCOTTeOM/2fmzma
	oD766U5CazYLs6FmRd9qKIzkuSfoMQnU0s8lJgMUCtMwGU9YTSEiuYAPl40+3mna
	DdeLoC3kemvA9OqEn7R36J9sA17lNNwFVgNDlfpXfxL1y93YOikwXLHJ7hg/Bkqp
	51RSOAnvfXE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6A66B2CF;
	Sun, 20 Jan 2013 19:01:31 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7470AB2C9; Sun, 20 Jan 2013
 19:01:31 -0500 (EST)
In-Reply-To: <20130120233422.GB3474@elie.Belkin> (Jonathan Nieder's message
 of "Sun, 20 Jan 2013 15:34:22 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B63959B2-635D-11E2-AC59-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214060>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Eric S. Raymond wrote:
>
>> You get to integrate this.  I think the transition strategy Junio
>> has chosen is seriously mistaken, leading to unnecessary grief for users
>> who will be fooled into thinking it's OK to still use cvsps-2.x.
>
> So our choices are:
>
>  a. support current users, offend ESR, don't benefit from ESR
>     improvements
>
>  b. give up on current users, please ESR, benefit from ESR
>     improvements
>
>  c. some option yet undiscovered
>
> In that case, (c) sounds like our best bet.  Do I understand
> correctly?
>
> Sigh,
> Jonathan

Isn't (c) is to just build on cvsimport-2 and cvsimport-3 combo?

If Eric does not want to get involved in cvsimport-2 (and cvsps2),
that is perfectly fine.  We have the beginning of cvsimport-3 code
that was released with Sign-off, and as long as cvsps3 produces a
"more corrrect" output stream (either traditional cvsps2 style or as
a fast-import stream) than cvsps2 conversion describes, cvsimport-3
can get the full benefit of his work, no?

I do not think that Eric will be the only person who understands
cvsps3 output who can fix bugs that may potentially still exist in
cvsimport-3 code [*1*].

We live in real world, and distro inertia makes it likely that a new
version of git that does not work for people who have been happy
with cvsps2 will get resistance from them, when they do not trust
the 0.x releases of a new piece of software "cvsps3" that happens to
have a name similar to what they have been shipping, i.e. "cvsps2".
Shipping such a crippled Git will not be an effective way to promote
adoption of "cvsps3".

[Footnote]

*1* This of course assumes Eric's two major claims are true, that
is, (1) cvsimport-3 is already mature and better than cvsimport-2,
and (2) the code is so simple that it does not even need its own
tests as long as the front-end conversion that happens at the cvsps3
end is tested well.  Choosing b. will have to assume them to be true
anyway, so I do not think it is a big loss to rely on the same
assumptions and choose b. from our point of view.
