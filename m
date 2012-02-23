From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] push: add 'prune' option
Date: Wed, 22 Feb 2012 17:31:01 -0800
Message-ID: <7vlinu72ui.fsf@alter.siamese.dyndns.org>
References: <1329950621-21165-1-git-send-email-felipe.contreras@gmail.com>
 <1329950621-21165-5-git-send-email-felipe.contreras@gmail.com>
 <7v1upm8jnq.fsf@alter.siamese.dyndns.org>
 <CAMP44s1s_NeXeUpxDR0cLoLGjSaf-0E_62MzAxeiHS=-6c045A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 23 02:31:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0NWZ-0001pb-IM
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 02:31:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754651Ab2BWBbG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Feb 2012 20:31:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37706 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751803Ab2BWBbE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Feb 2012 20:31:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF5866F1D;
	Wed, 22 Feb 2012 20:31:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=7eWM3obSevhh
	DAG4F7+ToZ/auNQ=; b=N8NmjQ3DAtgCrFxeOtaC2Gcnzwvhkd6FuLr0Fsit9QRb
	V8p0vhGeIrutli3DLcmgQoPMx2bzZ513+53e8l/XaxjffGagu+jEPJJz3tAyCTNi
	fRjPRAs4CtfO9ifDEZFT2pp5J22eu41h07JMe7JRF6v9fdwBBk8roj2zi6eMBhs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=fX26xY
	CP60Lq5M/N4i+tjy8W5NmaphuSPZjJ8/U/MmCt5Z0wdSJmreGijxpgHJiHZn5tmC
	f9XUj/K/PiZFZELoFFBAODj52MdXDmLRS/xxGA85hO2dUPDTkCYVenf3eGovTqfW
	S1IXT9geeCt/SfR5JGvialGZ7XOuHHMFf9F5c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A64B36F1C;
	Wed, 22 Feb 2012 20:31:03 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1DA096F1A; Wed, 22 Feb 2012
 20:31:03 -0500 (EST)
In-Reply-To: <CAMP44s1s_NeXeUpxDR0cLoLGjSaf-0E_62MzAxeiHS=-6c045A@mail.gmail.com> (Felipe
 Contreras's message of "Thu, 23 Feb 2012 03:09:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0C6B1678-5DBE-11E1-91E5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191321>

=46elipe Contreras <felipe.contreras@gmail.com> writes:

> On Thu, Feb 23, 2012 at 2:42 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Yeah, but that's 'git push --all', and that's not the common
> operation--'git push' is.

"git push" is common but that does not give you a solid base to guess w=
hat
the reader's assumption would be.  Are you assuming "matching" semantic=
s?

> So that's what I presumed the reader would
> assume,...

I do not want let us guess what the reader assumes, as many people seem=
 to
suggest setting push.default to different values and that would change
what the reader would assume.  That was the whole reason that I suggest=
ed
to spell the assumption out, so that the reader's assumption does not h=
ave
to get into the picture.

> This reuses the name `tmp`, which seems to be your objective, but it
> doesn't explain _why_ it would remove `tmp`; is it because `tmp` is
> the upstream branch, or is it because it has the same name?

The example is to clarify "local counterpart" in the main text.  I
actually would prefer to get rid of `tmp` but I left it as-is as you
wrote.  The exact name used in the example does not matter, whether it =
is
`tmp` or `xyzzy`.

> Unfortunately, I as a reader have trouble understanding this. More
> specifically I have trouble understanding where `refs/remotes/laptop/=
`
> is coming from, and what it is meaning. I have always pictured
> `refs/remotes` as something that 'git fetch' updates, and always from
> the relevant repository.

The layout is the recommended set-up to emulate a fetch with a push in =
the
reverse direction, which I thought anybody should notice.  It is a fail=
ure
in our documentation that even an expert didn't.

>>> diff --git a/remote.h b/remote.h
>>> index b395598..341142c 100644
>>> --- a/remote.h
>>> +++ b/remote.h
>>> @@ -145,7 +145,8 @@ int branch_merge_matches(struct branch *, int n=
, const char *);
>>> =C2=A0enum match_refs_flags {
>>> =C2=A0 =C2=A0 =C2=A0 MATCH_REFS_NONE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=
 0,
>>> =C2=A0 =C2=A0 =C2=A0 MATCH_REFS_ALL =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=3D (1 << 0),
>>> - =C2=A0 =C2=A0 MATCH_REFS_MIRROR =C2=A0 =C2=A0 =C2=A0 =3D (1 << 1)
>>> + =C2=A0 =C2=A0 MATCH_REFS_MIRROR =C2=A0 =C2=A0 =C2=A0 =3D (1 << 1)=
,
>>> + =C2=A0 =C2=A0 MATCH_REFS_PRUNE =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D (1 =
<< 2),
>>> =C2=A0};
>>
>> Lose the ',' at the end, for the same reason why deleted line did no=
t have
>> one.
>
> And why is that?

Because I told you so ;-).

More seriously, we have had patches to accomodate other people's compil=
ers
by dropping the last comma in enum {}.  See c9b6782 (enums: omit traili=
ng
comma for portability, 2011-03-16), 4b05548 (enums: omit trailing comma
for portability, 2010-05-14) for examples.
