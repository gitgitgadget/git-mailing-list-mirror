From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-p4.py: Don't try to rebase on submit from bare repository
Date: Fri, 19 Feb 2016 09:21:06 -0800
Message-ID: <xmqqy4agd3b1.fsf@gitster.mtv.corp.google.com>
References: <1455749160-2017-1-git-send-email-aidecoe@aidecoe.name>
	<CAE5ih78G1JczQvUEwzz3TmVPZuKUJVcxwZAsDdNzUbqAyHcqqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Amadeusz =?utf-8?B?xbtvxYJub3dza2k=?= <aidecoe@aidecoe.name>,
	Git Users <git@vger.kernel.org>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Fri Feb 19 18:21:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWokE-0002Qw-B5
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 18:21:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947508AbcBSRVM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Feb 2016 12:21:12 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64031 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030325AbcBSRVK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Feb 2016 12:21:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3DD4A4316B;
	Fri, 19 Feb 2016 12:21:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=CgLWdz42Tlqq
	uFJxo8J1H+/yl3g=; b=L/O1IozAA6eWk8/YYF83SbsyxFQ3H0ZGEZTDGuvQvLvv
	X1i83l24o6tYW0UOT2bZzi8cFDqcyR1B2cBv2VuG6jmsLfbLqFuZW9yZI0EjXZSR
	wnwJ7YXNb9AuuII3SF5q22aAkc8NECse2GhwLoi5gYT9WzTw/e55NOrr3GwwxJw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=rZU+7i
	sd2knGaakCw3mAHUDRtDEJ/YD8v6rsh5d6nMm5ikrEVKzrk+nGYTs7B3pu9Wvn/X
	wUIsofT7MAuGjGmvdFk8H+KUVvd7q/LCdXcxMg0zIDul1BFY0YswH/XTWW5QgWmJ
	5QiD1mPY90vm7US8zl2CC3koUFD1vqv+YKBcg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E253543169;
	Fri, 19 Feb 2016 12:21:08 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B7D9A43166;
	Fri, 19 Feb 2016 12:21:07 -0500 (EST)
In-Reply-To: <CAE5ih78G1JczQvUEwzz3TmVPZuKUJVcxwZAsDdNzUbqAyHcqqA@mail.gmail.com>
	(Luke Diamand's message of "Fri, 19 Feb 2016 09:47:13 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 29B19B48-D72D-11E5-80A8-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286720>

Luke Diamand <luke@diamand.org> writes:

> On 17 February 2016 at 22:46, Amadeusz =C5=BBo=C5=82nowski <aidecoe@a=
idecoe.name> wrote:
>> git-p4 can be successfully used from bare repository (which acts as =
a
>> bridge between Perforce repository and pure Git repositories). On su=
bmit
>> git-p4 performs unconditional rebase. Do rebase only on non-bare
>> repositories.
>
> This looks obviously sensible and good to me, ack.
>
> Thanks!
> Luke

Luke, thanks for a prompt feedback.

Amadeusz, can you sign off your patch (cf. Documentation/SubmittingPatc=
hes)?



>
>
>
>> ---
>>  git-p4.py | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/git-p4.py b/git-p4.py
>> index c33dece..e00cd02 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -2059,8 +2059,9 @@ class P4Submit(Command, P4UserMap):
>>                  sync.branch =3D self.branch
>>              sync.run([])
>>
>> -            rebase =3D P4Rebase()
>> -            rebase.rebase()
>> +            if not gitConfigBool("core.bare"):
>> +                rebase =3D P4Rebase()
>> +                rebase.rebase()
>>
>>          else:
>>              if len(applied) =3D=3D 0:
>> --
>> 2.7.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
