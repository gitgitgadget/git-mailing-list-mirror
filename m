From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] transport-helper: report errors properly
Date: Sat, 13 Apr 2013 22:23:22 -0700
Message-ID: <7v38ut7ilq.fsf@alter.siamese.dyndns.org>
References: <20130410211311.GA24277@sigill.intra.peff.net>
 <20130410211552.GA3256@sigill.intra.peff.net>
 <CAMP44s02K5ydKLNi0umMkuAicoVTWyCdVfjs0yssCa2oyFShGQ@mail.gmail.com>
 <7vfvywj4au.fsf@alter.siamese.dyndns.org>
 <CAMP44s2QJJnSRVVJscLsTnXk5zdGbA2utefF5SO7=90+ttENew@mail.gmail.com>
 <7vd2u0hdmj.fsf@alter.siamese.dyndns.org>
 <CAMP44s1pZW6OJ2nkegKFQq6=npPSiD4dX_z37t63B9baaFW16w@mail.gmail.com>
 <20130413060031.GA22374@sigill.intra.peff.net>
 <CAMP44s3gOXvHknN1yXQcDYP=OBfjm7=eJnSkh5cj5QJNOarEWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 14 08:05:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URG40-0001Io-Cw
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 08:05:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192Ab3DNGFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 02:05:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63085 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750766Ab3DNGFI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 02:05:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C4721E3F1;
	Sun, 14 Apr 2013 06:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=zvPUZaqosVMp+rQPL6qVVVpSSzg=; b=AE9nJb+RTq2622PQFz8T
	A3n3siiAK4DpUs0ICY2R/iiWt/ZALzHKZtnjV+rkQK8j94Up5WBNcCHhf8mIXoQE
	Irwq6h7tNeY8lRXHsc92RUSgBzFJyoiPiMa0+8agqChKAbqrCYZ9CWcR91GU3SHd
	GasDIC9dB8UZeds/eXZM+7M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=qk1/nr1R5m6ZCYoohAbTtM+NOoKuhptoDFWaEWGBeINPy1
	uqOpUiIOzDsimx9hwZmf7gX+Bo0nRKPAuX1DOVjLNUf7lBSzz9GyvmBSnAqaYRH/
	+nteAh8sC2dF4U2CFxVzWnsAagQNhgAR26sPs0vb7bh1EnSB7ma1FNdh4kuic=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B7DA3E3F0;
	Sun, 14 Apr 2013 06:05:07 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1DE0AE3EF; Sun, 14 Apr 2013
 06:05:07 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 41A5BE9E-A4C9-11E2-96A6-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221083>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Sat, Apr 13, 2013 at 1:00 AM, Jeff King <peff@peff.net> wrote:
>> On Sat, Apr 13, 2013 at 12:42:29AM -0500, Felipe Contreras wrote:
>>
>>> To me, the reality is obvious: my patch didn't require such a big
>>> commit message, the short version was fine, the only reason Jeff King
>>> insisted on a longer version is because the patch came from me.
>>
>> Get over yourself. The reason I suggested a longer commit message for
>> your commit is because after spending several hours figuring out what
>> the current code did, and what it should be doing instead, I wanted to
>> document that effort so that I and other readers did not have to do it
>> again later.
> ...
> The double standard might not come from you, perhaps you subject all
> the patches you review to the same standard, it comes from the fact
> that the patches you review have an unfair disadvantage.

There are reviewers who share the basic values [*1*] with I and the
tradition of this project and whose judgement I can trust.

When somebody (like Peff) whose judgement I trust spends time to
review a series, and writes his thought process to the degree that
he thinks is appropriate, that's his judgement and I trust it.

You cannot expect perfect evenness from multiple people.  For that
matter, you cannot expect perfect evenness even from a single
person, either.

When reviewing a proposed change to an area that I am intimately
familiar with, I may immediately know some subtleties involved in a
proposed solution without even reading the patch, and I may not even
realize that such subtleties are hard to know without being somebody
who are already familiar with that part of the codebase, and either
in-code comment or in the log message may better spelled them out.
On the other hand, when the change is in another area that I am not
familiar with, I may request more explanation, if only for me to
understand the issue.

I try to avoid the "I may know too well" pitfalls, but I am not
perfect. I will not speak for Peff or any other reviewers whose
jugement I trust, but I would be very surprised if any of them
claimed he is perfectly even.

"Double" may only be showing that we do not have enough trusted
maintainers; ideally I would like it to have "Triple" or more.


[Footnote]

*1* A few examples of core values.

 - we should make sure that future developers who wonder why a part
   of the code is how it is can find out what thought process
   brought the code into the current shape.

 - when we add something, we try not to overengineer or to shoot for
   unattainable perfection, but we still try to make sure we will
   not paint ourselves into an unescapable corner when we later want
   to extend it.
