From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 00/31] Support multiple checkouts
Date: Mon, 14 Jul 2014 10:05:53 -0700
Message-ID: <xmqqmwcbzx8u.fsf@gitster.dls.corp.google.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
	<1405227068-25506-1-git-send-email-pclouds@gmail.com>
	<xmqqvbr0zgy1.fsf@gitster.dls.corp.google.com>
	<CACsJy8AAfZJtg1MBNmKJcYZ=VKaLV4NWJ0nETk=0uD9XK3+exg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 19:06:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6jhs-0007pn-1P
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 19:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756651AbaGNRGW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jul 2014 13:06:22 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53339 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756421AbaGNRGQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jul 2014 13:06:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CE40A27DC8;
	Mon, 14 Jul 2014 13:05:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=6XxR3wLSryLZ
	SMBEH9qADmqmpHE=; b=emzJvLdEXmaFk3VNpkBaOLWfrs5tnXSd6rvPLRNElmbc
	Gq1BKb1+cyJ3UHyERIubBaFuLnvPvortk9a94FUifTVakpAtUIYdR8Bqi0BrL8it
	fkg8rbwBi/pC4bx8/WdeCWulI+/IbuAv9LpwfQnMtgObmgw9R2WPAhUvyoj9jaY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Knal1r
	hfk37J4YWmCvzCwFISDjJNeB4wBpTxjIWNHmpMPTykXmIr9mQGqLHnrD9kvqfaWM
	orREtHGmqWzXQnj3vVrKZ4t5Hab2+Mj18n8za1vELynVfn7jVYrbLhALbFRiD5zC
	uUuWwY7Jtgu78NI4pNEH3glMby57LLwTWFTSM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C34C027DC7;
	Mon, 14 Jul 2014 13:05:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B2FE127D87;
	Mon, 14 Jul 2014 13:05:37 -0400 (EDT)
In-Reply-To: <CACsJy8AAfZJtg1MBNmKJcYZ=VKaLV4NWJ0nETk=0uD9XK3+exg@mail.gmail.com>
	(Duy Nguyen's message of "Mon, 14 Jul 2014 18:06:22 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 13B3FD62-0B79-11E4-8795-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253497>

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Jul 14, 2014 at 11:45 AM, Junio C Hamano <gitster@pobox.com> =
wrote:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> write=
s:
>>
>>>       fd =3D open(git_path("repos/%s/gitdir", id), O_RDONLY);
>>> ...
>>> -     while (path[len - 1] =3D=3D '\n' || path[len - 1] =3D=3D '\r'=
)
>>> +     while (len && (path[len - 1] =3D=3D '\n' || path[len - 1] =3D=
=3D '\r'))
>>>               len--;
>>
>> Do we anticipate (or even allow/endorse) that end users will edit
>> this file with a random editor?  And, to a lessor degree, the same
>> question on the reading side.  Do we encourage users to directly
>> read from this file to learn something about their repository?
>>
>> If we are the only tool that writes into this file, and if we are
>> the only tool to be used to read (and use) the contents of this
>> file, I do not see the need to cater to LF vs CRLF line endings.
>
> No I don't expect users to go and change these files by themselves.
> But once directory structure is documented, other tools might appear
> and scripts on Windows may just append CRLF by default.

Essentially you are encouraging them to edit this file with a random
editor, bypassing Git, then.
