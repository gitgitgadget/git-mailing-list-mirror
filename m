From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] format-patch: fix dashdash usage
Date: Thu, 26 Nov 2009 15:29:18 -0800
Message-ID: <7vws1c27ch.fsf@alter.siamese.dyndns.org>
References: <1259262720-24077-1-git-send-email-felipe.contreras@gmail.com>
 <1259262720-24077-2-git-send-email-felipe.contreras@gmail.com>
 <7vd4355aaw.fsf@alter.siamese.dyndns.org>
 <94a0d4530911261414o533aa108l202d4c6926da361e@mail.gmail.com>
 <7v7htc3mqo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 27 00:29:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDnmG-0003Bx-NY
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 00:29:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753255AbZKZX3V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Nov 2009 18:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753192AbZKZX3V
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 18:29:21 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61508 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932AbZKZX3U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Nov 2009 18:29:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2396F837FF;
	Thu, 26 Nov 2009 18:29:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=zGs6b6yuKvzl
	ubg0rwhFZ08DyAg=; b=VSDS+ptCdgDjyRXK8UnGGPYkmtUWgj4dlomJY2HT8q5R
	qFoL47AglqzvXAVq4wVVsLUY8fRuApJA+EmStHF4AF3LRMOL5EmqDQdi2CcbsLrp
	r69Qf/nlA6OVO6rN0Q7OEwDDhS52ZbGdf5z9VLIEHKQ6l+qq38JIspofDrzRJKU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=HncDNl
	+5RR1M2ViSJddkSq2kxsKXbSNokpK+g3yf6rkCvvlpfoixsInN9Z91xW8LOkTqBb
	Hke9LkxzHeKOL2MCj54T9G63wQUu4AP6ECxvumjh+wwbeiVDs7tor0+QBq9Q1bUK
	F84q+VSB+rIYUcs8wlCAPb+Bep1rZLzKq3g3g=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 045C9837FE;
	Thu, 26 Nov 2009 18:29:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 26A13837FD; Thu, 26 Nov
 2009 18:29:20 -0500 (EST)
In-Reply-To: <7v7htc3mqo.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu\, 26 Nov 2009 15\:11\:27 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 87E27B08-DAE3-11DE-B5AA-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133847>

Junio C Hamano <gitster@pobox.com> writes:

> Felipe Contreras <felipe.contreras@gmail.com> writes:
> ...
>>> I actually have a bigger question, though. =C2=A0Does it even make =
sense to
>>> allow pathspecs to format-patch? =C2=A0We sure are currently loose =
and take
>>> them, but I doubt it is by design.
>>
>> Not everyone has clean branches only with pertinent patches.
>>
>> I stumbled upon this trying to re-create (cleanly) a "branch" that w=
as
>> constantly merged into another "master" branch that had a lot more
>> stuff. Maybe there was a smarter way to do that with 'git rebase', b=
ut
>> that doesn't mean format-patch -- <path> shouldn't work.
>>
>>> The patch itself looks good and is a candidate 'maint' material, if=
 the
>>> answer to the above question is a convincing "yes, because ...".
>>
>> Yeah, I also think this should go into 'maint'.
>
> Hmm, I have not seen a clear "yes, because..." yet.

Sorry, I guess I did it again of assuming the reader would read my mind=
=2E
Let's try to be a bit more explicit.

Your description defends why you think showing only part of a single
change in a patch form is jusitified.  What I found unconvincing is tha=
t
it does not even try to justify why it is a good idea to give the full
description that explains the _whole change_, even the part to the set =
of
files that were omitted by the pathspecs, as an applicable format-patch
output.  And that is why I suspect that it may be a long rope that harm=
s
users.

> For one thing, Documentation/git-format-patch.txt does not even hint =
that
> you can give pathspecs.  builtin_format_patch_usage[] doesn't, either=
=2E  As
> I wrote the initial version of format-patch I can say with some autho=
rity
> that use with pathspecs were never meant to be supported---if it work=
s, it
> works by accident, giving long enough rope to users to potentially ca=
use
> themselves harm.
>
> I am inclined to think that we shouldn't encourage use of pathspecs (=
just
> like we never encouraged use of options like --name-only that never m=
akes
> sense in the context of the command) but I am undecided if we also sh=
ould
> forbid the use of pathspecs (just like we did for --name-only recentl=
y).

Compared to --name-only and friends that makes the output unapplicable =
by
"git am", a patch generated with pathspecs is worse.  The output will
apply cleanly and the user can choose not to bother or forget cleaning =
up
the log message from the resulting commits.

On the other hand, if the pathspec affected only the choice of commits =
but
the command is changed in such a way that patches were always generated
with --full-diff option, I can understand its usefulness in the use cas=
e
you described.  Instead of having to do "format-patch master..branch" a=
nd
then pick only the ones that are necessary by visual inspection, you wo=
uld
run it to generate the ones that _might_ need to be applied by giving
pathspec to cover the files all relevant changes _must_ touch, only to =
cut
down the search space of your visual inspection of picking and choosing=
=2E

Then at least the ones that you choose to apply are expressed in full a=
nd
the patch text and the description should match, and I wouldn't find it
problematic nor a long rope that harms users.

But without such an explanation, I can only _guess_ what the intention
is.  That is why I asked for justifications from you, as this was your
itch.
