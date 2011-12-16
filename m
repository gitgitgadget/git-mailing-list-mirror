From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] attribute "eol" with "crlf"
Date: Fri, 16 Dec 2011 14:17:04 -0800
Message-ID: <7vehw4go0v.fsf@alter.siamese.dyndns.org>
References: <CAN0XMO+OOdTJ+aNMSc2G3RVc7Wfypr4+7dU3US9GVAmMiSJ7cg@mail.gmail.com>
 <vpqr504wf70.fsf@bauges.imag.fr> <7vmxasgqlm.fsf@alter.siamese.dyndns.org>
 <CAN0XMOL674Hw_LctTC+8NNqA84Of6dMjdKT0SU+DWMG7EYShYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Dec 16 23:17:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rbg5Z-0002ZN-UN
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 23:17:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760878Ab1LPWRK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Dec 2011 17:17:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36339 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756644Ab1LPWRH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Dec 2011 17:17:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF41C768E;
	Fri, 16 Dec 2011 17:17:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=CASJCEp8qRVO
	dbBeBpnghDkE1Ng=; b=ICPaKcr1pSrDm9jf8A1HTqtqxhzRosvDr30y5l81EGLx
	781GLBG8Dv2BOsCIvQtj2FxE5YfEz4X3V20jTO5tTHO+bjcgQiePuiqUKa8QdA7k
	AHmjLrG0QRimI++XTV7w5DQWRiyhBhpIz25e9FUBCvwuup2cCPrJinlfuNjmIxE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=iifSPz
	/xCHnCyYb5Uc+32zoY/juW08CEgKAvBAbsHKeVxPc+kXcHY76EZca/cRpLLRMGJF
	//iwa0WkVI1LLm+G+2sa3JeI3qHGJS44dzjKkShlG/un7Qf/Zvccb9oawXD+JJXt
	cgXL1eP+G1P3l9dKiV6sp488HfJ+2/xh67k9I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C66E8768D;
	Fri, 16 Dec 2011 17:17:06 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 59ACD768B; Fri, 16 Dec 2011
 17:17:06 -0500 (EST)
In-Reply-To: <CAN0XMOL674Hw_LctTC+8NNqA84Of6dMjdKT0SU+DWMG7EYShYQ@mail.gmail.com> (Ralf
 Thielow's message of "Fri, 16 Dec 2011 23:05:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B0481A36-2833-11E1-8BD4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187325>

Ralf Thielow <ralf.thielow@googlemail.com> writes:

> So i have to commit ".gitattributes" and everything is fine for me af=
ter!?

No.  Sorry if I was unclear, but I do not see which part was unclear in
what I wrote, so...

>> The sequence adds "test\r\n" file without .gitattributes to have the
>> repository record that exact byte sequence for the file. But then la=
ter
>> goes around and says "This file wants to express the end of line wit=
h CRLF
>> on the filesystem, so please replace LF in the repository representa=
tion
>> to CRLF when checking out, and replace CRLF in the working tree to L=
=46 when
>> checking in".
>>
>> So it is not surprising that "\r\n" coming from the repository is re=
placed
>> to "\r\r\n" when checked out. As far as the repository data is conce=
rned,
>> that line has a funny byte with value "\r" at the end, immediately b=
efore
>> the line terminator "\n".
>>
>> What you said is _technically_ correct in that sense.
>>
>> However, I think the CRLF filter used to have a hack to strip "\r" i=
f the
>> repository data records "\r" at the end of line. This was intended t=
o help
>> people who checked in such a broken text file (if it is a text file,=
 then
>> raw ascii CR does not have a place in it in the repository represent=
ation)
>> and it was a useful hack to help people recover from such mistakes t=
o
>> start the project from DOS-only world (with CRLF in the repository d=
ata)
>> and migrate to cross platform world (with LF in the repository data,=
 CRLF
>> in the DOS working tree). =C2=A0I suspect that the streaming filter =
conversion
>> may not have the same hack in it.
