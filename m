From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2]  t0027: Support NATIVE_CRLF
Date: Fri, 17 Apr 2015 14:04:11 -0700
Message-ID: <xmqq8udqpius.fsf@gitster.dls.corp.google.com>
References: <55312A45.8060008@web.de>
	<1db9b0b7322c3b8b8e7a76b29b020ad8@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Apr 17 23:04:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjDQw-00083L-83
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 23:04:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753514AbbDQVEP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Apr 2015 17:04:15 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64063 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752764AbbDQVEN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Apr 2015 17:04:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A980C49619;
	Fri, 17 Apr 2015 17:04:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Yxayx6ZmaSRK
	PJ6OCQPyU5MSft8=; b=ZuNt2NCNqzhzN5qZYw4UzfDGBCyUPwlt7311k2B/EOmH
	IDG+YdJQB81G1dHKiRPSLtkRzJWfOOx9KJg6GukT3egO2uWo4demAu1JSZb+izwU
	2/0ozzrbTCrn3WjMIlqlS/qbQKZB1z6PwOvQ/v5ELW6OjAH61Zje7U9HjQXKhdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Odb/Us
	l8G/zfQYZgpOQS9qvMa4v/f2tysOKdxfCV0c1fJ1uVwaVvZ9r/Z/NbmOgz5t8pD1
	5HKu7L2i++M0cn4yyN6JO8u/hkzmd3IlMaolR42oKCwBSXU7D/wr/4q9FFUOhRSk
	gVcn0U1ctuNzDJy77v8dv7JItrd1AvYc9yYa8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A2F1649618;
	Fri, 17 Apr 2015 17:04:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2722149616;
	Fri, 17 Apr 2015 17:04:12 -0400 (EDT)
In-Reply-To: <1db9b0b7322c3b8b8e7a76b29b020ad8@www.dscho.org> (Johannes
	Schindelin's message of "Fri, 17 Apr 2015 21:55:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4C30CE26-E545-11E4-9DEE-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267391>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Hi Torsten,
>
> On 2015-04-17 17:44, Torsten B=C3=B6gershausen wrote:
>> Without this patch, t0027 expects the native end-of-lines to be a si=
ngle
>> line feed character. On Windows, however, we set it to a carriage re=
turn
>> character followed by a line feed character. Thus, we have to modify
>> t0027 to expect different warnings depending on the end-of-line mark=
ers.
>>=20
>> Adjust the check of the warnings and use these macros:
>>   WILC:  Warn if LF becomes CRLF
>>   WICL:  Warn if CRLF becomes LF
>>   WAMIX: Mixed line endings: either CRLF->LF or LF->CRLF
>>=20
>> Improve the information given by check_warning():
>> Use test_cmp to show which warning is missing (or should'n t be ther=
e)
>>=20
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> Thank you so much!
> Dscho

Thanks, is that "Acked-by: Dscho" for both patches?
