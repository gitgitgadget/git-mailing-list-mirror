From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Add new @ shortcut for HEAD
Date: Wed, 01 May 2013 15:08:03 -0700
Message-ID: <7vsj264am4.fsf@alter.siamese.dyndns.org>
References: <1367401888-21055-1-git-send-email-felipe.contreras@gmail.com>
	<7vr4hq7fjy.fsf@alter.siamese.dyndns.org>
	<CAMP44s16X8c_5GgW=ZcA9wrd=oHAiVDZFWxqiGmysaUJckZ5wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 00:08:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXfC8-0006NO-JD
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 00:08:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758068Ab3EAWII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 18:08:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63250 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757580Ab3EAWIG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 18:08:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0FB671B29D;
	Wed,  1 May 2013 22:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7LLb/PBaGV4pnRRs7atX81aFDMk=; b=DCUPmb
	BHkXHgKGSvNSuCOtHv34LkktHYBK8osilhCiynw9/wIfVNNsF2VDe1hC+SO0I7cL
	aVq6TymWAV1/9el8EmesTK04niRy90qEFqzln7SUq5PciDEXhXqoPrLnkf2uDksT
	I4rBByvnUdJzhH+qSGpWZ3eWsruGbUwt3cuLk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WQHZjcKn3gmW48GkVIeRTCH/IFFKhK6O
	L/f1saOTCxVbjULGV75aVROS3IFhyBGDDcEEeFEakWHuCfat2m8Y3Wi9UtJBV8n7
	Awttc7HTkMX1SzoiXohS6iTIf5+hrPfIg71HkSsDZO8igKGa2VYPY+NE7oyeHupg
	EqZgMeyGsdU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 058ED1B29C;
	Wed,  1 May 2013 22:08:06 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 78C6D1B29B;
	Wed,  1 May 2013 22:08:05 +0000 (UTC)
In-Reply-To: <CAMP44s16X8c_5GgW=ZcA9wrd=oHAiVDZFWxqiGmysaUJckZ5wQ@mail.gmail.com>
	(Felipe Contreras's message of "Wed, 1 May 2013 13:33:43 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 994445CC-B2AB-11E2-A9E5-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223153>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Wed, May 1, 2013 at 12:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> So HEAD@{0}~0^0 is too much to type, but we can remove '^0', and we can
>>> remove '~0', and we can remove 'HEAD', which leaves us with @{0}, but we
>>> can't remove '{0}'?
>>>
>>> This patch allows '@' to be the same as 'HEAD'.
>>
>> While the above reasoning is cute, it is misleading.
>>
>> If you start from HEAD@{1}~0^0, we can remove '^0', we can remove
>> '~0', but you cannot remove HEAD from the remaining "HEAD@{1}"
>> without changing what it means.  @{1} is where the current branch
>> was, while HEAD@{1} is where you were---they are different when you
>> have just did "git checkout anotherbranch".  HEAD@{1} is the tip of
>> your previous branch, @{1} is where anotherbranch was before its tip
>> became the commit you have checked out.
>
> Replace @{1} with @{u} and it holds.

Yes and no.  Starting from HEAD@{u}~0^0, we can remove ^0 and ~0,
and you remove HEAD from the remaining "HEAD@{u}" to get @{u} and
all of them still mean the same thing.  It is the other branch your
current branch is integrating with.

But that decomposition does not get you to HEAD which is the final
destination you want to reach.  As soon as you drop the remaining
{u}, it suddenly changes the meaning and start referring to the
current branch.

>> So I'd suggest toning it down, perhaps something like this:
>>
>>         Even though we often can do without having to type "HEAD",
>>         e.g. "git log origin.." substitutes missing RHS with "HEAD",
>>         sometimes we still do need to type "HEAD" (thats six f*cking
>>         keystrokes "Caps Lock", "H", "E", "A", "D" and finally "Caps
>>         Lock").
>
> I don't know what RHS means, and I don't use caps lock :)

"right hand side"?  You can say "Hold down Shift", H, E, A, D and
"Release Shift" ;-).

>>         That is four keystrokes too many to name an often needed
>>         reference.  Make "@" usable as its synonym.
>
> Yeah, that's nice, but doesn't explain why "@", and why not something else.

The thing is, HEAD@{0}~0^0 nor HEAD@{u}~0^0 is not a valid
explanation why it is "@", either.

But that does _not_ mean "@" is a good choice.  Nor the explanation
has to be based on the "starting from this and strip" progression.

"@" is already special and is familiar to users when specifying a
ref, and that is a good enough reason (you can of course say that in
the log message).
