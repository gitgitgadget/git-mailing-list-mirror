From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] branch: introduce --set-upstream-to
Date: Fri, 31 Aug 2012 10:09:46 -0700
Message-ID: <7vy5kvng2t.fsf@alter.siamese.dyndns.org>
References: <1346347393-8425-1-git-send-email-cmn@elego.de>
 <1346347393-8425-2-git-send-email-cmn@elego.de>
 <CAN0XMOKar3jdDMfY=rRkcmNy0i0zKMuhBQ=Z4bi=eus_xAFWyA@mail.gmail.com>
 <87mx1b3x3m.fsf@centaur.cmartin.tk>
 <CAN0XMOK1_JqMuAkW-XzGfkn8pkTUqt879-+E0cGBn79GzEXWkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Fri Aug 31 19:09:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7UjD-00005a-Ts
	for gcvg-git-2@plane.gmane.org; Fri, 31 Aug 2012 19:09:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754546Ab2HaRJt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Aug 2012 13:09:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48073 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754365Ab2HaRJs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Aug 2012 13:09:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6944E8996;
	Fri, 31 Aug 2012 13:09:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=c+bzzSuXJUc/
	xnbF/5QHq2hhpKU=; b=XUIsZVVibV7+Ru3cUgqFJtCzlZJ/Q+SXAA1eV0jpkTkg
	DPbqCggVOb1Hj1v5oq+GYIGd14c8vaTYEhUlX/UsTM2NFcpLv90PUFhGEpnPcHws
	W1J8IAeUOGOmIHMGGQoVG8+kAyV4WrizaAbAJi3Pewr7HyV3Gw2JvPF0zE2V80U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Ap9oJu
	fHo0QgX9ol0ff6qEwDp2Vc3sF/JEAFyoW4/z7ohK+ExyvfldoQeuIkjPHIxfAKjF
	5Si6RUoSBaxZso4vuAgFKuNdPAA1ue8GYwN5PRzP5LadoXjZN0L2JlDI998ebrQS
	EYJ4Zukql73G0G/shkKOyem+DemFf5+QcMSAQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55C5E8995;
	Fri, 31 Aug 2012 13:09:48 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AD59D8994; Fri, 31 Aug 2012
 13:09:47 -0400 (EDT)
In-Reply-To: <CAN0XMOK1_JqMuAkW-XzGfkn8pkTUqt879-+E0cGBn79GzEXWkQ@mail.gmail.com> (Ralf
 Thielow's message of "Fri, 31 Aug 2012 17:30:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AAF8F092-F38E-11E1-8D9E-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204594>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> On Fri, Aug 31, 2012 at 5:22 PM, Carlos Mart=C3=ADn Nieto <cmn@elego.=
de> wrote:
>> Ralf Thielow <ralf.thielow@gmail.com> writes:
>>
>>> On Thu, Aug 30, 2012 at 7:23 PM, Carlos Mart=C3=ADn Nieto <cmn@eleg=
o.de> wrote:
>>>> behaviour. To work around this, introduce --set-upstream-to which
>>>> accepts a compulsory argument indicating what the new upstream bra=
nch
>>>> should be and one optinal argument indicating which branch to chan=
ge,
>>>> defaulting to HEAD.
>>>>
>>>
>>> Could you please also add this new option to the
>>> "contrib/completion/git-completion.bash"
>>> script?
>>
>> If I knew how those things work... Is this enough?
>>
>
> Yes, Thanks.

While you are at it, perhaps you may want to unadvertise --set-upstream=
?

>
>>    cmn
>>
>> --8<--
>> Subject: [PATCH] completion: add --set-upstream-to and --unset-upstr=
eam
>>
>> ---
>>  contrib/completion/git-completion.bash | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/contrib/completion/git-completion.bash b/contrib/comple=
tion/git-completion.bash
>> index ffedce7..4f46357 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -880,6 +880,7 @@ _git_branch ()
>>                         --color --no-color --verbose --abbrev=3D --n=
o-abbrev
>>                         --track --no-track --contains --merged --no-=
merged
>>                         --set-upstream --edit-description --list
>> +                       --unset-upstream --set-upstream-to=3D
>>                         "
>>                 ;;
>>         *)
>> --
>> 1.7.12.3.g0dd8ef6
