From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] gitweb: add the ability to show side-by-side diff on
 commitdiff.
Date: Sun, 16 Oct 2011 20:57:52 -0700
Message-ID: <7v7h44p8vz.fsf@alter.siamese.dyndns.org>
References: <CAFo4x0Kb651CyxoP8wxR36aDe5=Md2UV3qjh+HPo4ad6NB=Emg@mail.gmail.com>
 <7vobxgpixo.fsf@alter.siamese.dyndns.org>
 <CAFo4x0+_Uy=yjbO61qj8krS0-iovzC5WnBE8-1n5OzxgGeg6JA@mail.gmail.com>
 <7vbotgper8.fsf@alter.siamese.dyndns.org>
 <CAFo4x0KPP1yZec+98_rn9tG_fhtB-DYAcdi90TwiwUPq+DP90g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kato Kazuyoshi <kato.kazuyoshi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 05:59:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFeMP-0006lZ-Bb
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 05:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754666Ab1JQD54 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Oct 2011 23:57:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33610 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754487Ab1JQD5z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Oct 2011 23:57:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E64E61AA;
	Sun, 16 Oct 2011 23:57:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=QBok0P2XjuD4
	K5TG8Wi5YvUvTQg=; b=LlNvmXYJD2xQErv309ho1Kw06yIWJH97hj/eYPB/JJld
	ZkNo8S1n9P2OodD/Nr6LsxFrW4WvLzFh9S8/ubUB6G4ReLz8wWOQ3tL/tpxxXo2C
	LotLJbc6RIM1arq1srs5SBIou7vnJHbSRn8tn/TIuZV0QyF6TXbobvxyETEEsgo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=sumEWE
	liSkKUYfiouZ+OJzcmZHopYiROtX3LTtv8mAowLglB3Mu0+jVRkHS+YtmB3UDa+b
	/YRMSX4feU1hNnqrEOOxClaHp1cW75eKWe6pOE51hFyy4f8Pnok7LuZzN0Y2HnQx
	DcN7JPmLNo0KjsGqSGCzDhgn2VAABWrn/RPqQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85D0961A9;
	Sun, 16 Oct 2011 23:57:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EC94161A8; Sun, 16 Oct 2011
 23:57:53 -0400 (EDT)
In-Reply-To: <CAFo4x0KPP1yZec+98_rn9tG_fhtB-DYAcdi90TwiwUPq+DP90g@mail.gmail.com> (Kato
 Kazuyoshi's message of "Mon, 17 Oct 2011 11:33:49 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 30CDB084-F874-11E0-B09B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183764>

Kato Kazuyoshi <kato.kazuyoshi@gmail.com> writes:

> On Mon, Oct 17, 2011 at 10:51 AM, Junio C Hamano <gitster@pobox.com> =
wrote:
>>
>> I think a better organization would be
>>
>> =C2=A0[1/2] change code so that $diff_class does not have leading SP
>> =C2=A0 =C2=A0 =C2=A0 optionally catch a case where $diff_class stays=
 empty as an error?
>>
>
> I think we don't have to treat empty $diff_class as an error because
> $diff_class will be an empty when $line is around modification
> (ex. foo or quux).
>
>   foo
> - bar
> + baz
>   quuz

Ok. then even though class=3D"diff " is not any different from class=3D=
"diff",
I have to say generated html output becomes aesthetically less nice wit=
h
this change; we may want to do something about it _iff_ it does not tak=
e
too much change, but as I said I do not care too much about it.
