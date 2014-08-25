From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] Push the NATIVE_CRLF Makefile variable to C and added a test for native.
Date: Mon, 25 Aug 2014 10:36:09 -0700
Message-ID: <xmqqr404mpyu.fsf@gitster.dls.corp.google.com>
References: <53F797A1.1060804@web.de>
	<xmqq61hknnjo.fsf@gitster.dls.corp.google.com>
	<53F83321.1060906@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Aug 25 19:41:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLyHF-000382-KT
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 19:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933168AbaHYRll convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Aug 2014 13:41:41 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62349 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933149AbaHYRli convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Aug 2014 13:41:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 76F5B33317;
	Mon, 25 Aug 2014 13:41:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=2x8bMsoAiux4
	mdiy5luaImwQJ4o=; b=LmieR7l0dwny8Qo4qaX47iQORutXegy59JEeOQpO0JRm
	0dIyrAOKkN6BAL3XlWs5jdifbfF4l7Iw0Xk/LxcPw6YSRK83ovDRsSx6BV8lcFx3
	AfIFQs2DAo5Do5rchMkmmgzvMxZeg8FvFrtzrYHjb4vF78koT0Ppc9Z2bzc8Q8o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=nLu28m
	rNaYIp8VAP+JXrzuBLaFrUw7MMiu3XxYTVrhEzHVtks5vR93VIeukyQca/04HCis
	EcdaHVrFOi2lTu2kAe1BirL+J12FnSL5xFEfzUR6a9eh7BvbhC301F4RBoSsOro3
	KKM9kvjgzJgBrbA9RAJ6KCvdIGPLPTa2qjVx8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6E74833315;
	Mon, 25 Aug 2014 13:41:37 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5FC43330D3;
	Mon, 25 Aug 2014 13:36:11 -0400 (EDT)
In-Reply-To: <53F83321.1060906@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Sat, 23 Aug 2014 08:22:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4DFF24BC-2C7E-11E4-B9B5-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255842>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 2014-08-23 00.54, Junio C Hamano wrote:
>> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>>=20
>>> Commit 95f31e9a correctly points out that the NATIVE_CRLF setting i=
s
>>> incorrectly set on Mingw git. However, the Makefile variable is not
>>> propagated to the C preprocessor and results in no change. This pat=
ch
>>> pushes the definition to the C code and adds a test to validate tha=
t
>>> when core.eol as native is crlf, we actually normalize text files t=
o this
>>> line ending convention when core.autocrlf is false.
>>>
>>> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
>>> Signed-off-by: Stepan Kasal <kasal@ucw.cz>
>>> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
>>> ---
>>=20
>> Who should I record as the author of this patch?
>>=20
>
> Sorry for missing this, here is what Mingw says:=20
>
> commit 0caba2cacbb9d8e6a31783b45f1a13e52dec6ce8
> Author: Pat Thoyts <patthoyts@users.sourceforge.net>
> Date:   Mon Nov 26 00:24:00 2012 +0000
>
>     Push the NATIVE_CRLF Makefile variable to C and added a test for =
native.
>    =20
>     Commit 95f31e9a correctly points out that the NATIVE_CRLF setting=
 is
> []

When forwarding somebody else's patch, please start the *body* of
your message with the in-body header to force the author, followed
by a blank line and then the message, i.e.

 	From: Pat Thoyts <patthoyts@users.sourceforge.net>

	Commit 95f31e9a correctly points out that the NATIVE_CRLF setting is
	incorrectly set on Mingw git. However, the Makefile variable is not...
	...

The request applies to other patches in the series as well.  I
suspect that using send-email on format-patch output may do the
right thing automatically.

Thanks.
