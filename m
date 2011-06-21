From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] stash: Add --clean option to stash and remove all
 untracked files
Date: Tue, 21 Jun 2011 10:16:27 -0700
Message-ID: <7vboxr9kb8.fsf@alter.siamese.dyndns.org>
References: <1308612986-26593-1-git-send-email-david@porkrind.org>
 <20110621003852.GB2050@sigill.intra.peff.net> <4DFFF5AA.4030401@porkrind.org>
 <4E002762.3050803@sohovfx.com> <4E003A0F.5080601@viscovery.net>
 <20110621141843.GA18700@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Andrew Wong <andrew.w@sohovfx.com>,
	David Caldwell <david@porkrind.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 21 19:16:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ4Z2-0007zM-JM
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 19:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757055Ab1FURQc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 13:16:32 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56573 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752986Ab1FURQa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 13:16:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 39E2253FE;
	Tue, 21 Jun 2011 13:18:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u3HNnXWbRYQuY/xiAtYag4aLE+I=; b=NZLA39
	+FPeoSza/Oj/l/mc3gqJvoYEqZK6dlQJu/4R/I3UdWvLDyjorF19wuPPRXcSMo+5
	mdE3aujeQFDCeXAhjJQMGV9gLoB5uoYqU4Ru4376U5rC1rbSk9YxZL5YLcsADaY0
	ibzpL7Erb1wk6/Rvrb+6qLvYMoTjOBIoWD7rE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DvLjqr8LzeXqXxtOrWDqKMJBNbzj60Kn
	JkO66VI8zV/pHzKYDmidNEKyg8SswtC8shzc3BHQinANuu15aHY8xz1px7RJHudi
	lgyyP5tHIH6gtMxaqZXaG+LLiYLhiyevChsOV9O5yIuSMf+5nuift3pDN94X2QUJ
	vubC6t29L4c=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3148353FD;
	Tue, 21 Jun 2011 13:18:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7F53353FB; Tue, 21 Jun 2011
 13:18:41 -0400 (EDT)
In-Reply-To: <20110621141843.GA18700@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 21 Jun 2011 10:18:43 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 82A1AB32-9C2A-11E0-AE7E-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176175>

Jeff King <peff@peff.net> writes:

> On Tue, Jun 21, 2011 at 08:28:31AM +0200, Johannes Sixt wrote:
>
>> > I personally think "--untracked" (and -u) is more intuitive too, since it
>> > tells you what "git stash" is about to do. i.e. "git stash" is about to do
>> > the usual stash operation *and* also stash the "untracked" files.
>> 
>> Really?
>> 
>>    $ git stash --untracked
>> 
>> sound like it stashes *only* untracked files. (That by itself may be a
>> feature that some people want; so far, I'm not among them.)
>
> I would be happy with something that indicated "untracked files in
> addition to the regular stash". I just think it should be about "add
> these other files into the stash", not "end up in this directory state".
>
> Something like "--untracked-too" fits that, but is horribly ugly.

This I think depends on how you view what stash does. If you concentrate
on the "saving" aspect too much, your naming would start from "untracked"
and end up to be that ugly thing. If you start from "what happens to the
working tree", on the other hand, --clean may not be such a bad name for
what it does.

But I think the previous point you raised about untracked-but-not-ignored
vs untracked-and-ignored is much more important. I do not think anybody
would want to put build products in stash and unstash them later, so in
that sense we can say we would only save the untracked-but-not-ignored in
the stash and remove them, but then "git stash --clean" (or whatever we
end up calling it) would still leave non-source material in the working
tree, which probably does not exactly the original motivation of wanting
to get a pristine source tree without having to trust the build procedure
(i.e. "make clean" may leave cruft behind).
