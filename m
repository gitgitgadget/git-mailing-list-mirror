From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/8] remote-bzr: fix export of utf-8 authors
Date: Wed, 28 Aug 2013 14:58:39 -0700
Message-ID: <xmqq7gf58okw.fsf@gitster.dls.corp.google.com>
References: <1377717793-27170-1-git-send-email-felipe.contreras@gmail.com>
	<1377717793-27170-2-git-send-email-felipe.contreras@gmail.com>
	<vpqhae97f8j.fsf@anie.imag.fr>
	<CAMP44s2bu9gUE=McYq1prhjC3O2CRj1W_Yc+-CjTkk6Gc3JFTw@mail.gmail.com>
	<vpqy57l4jcx.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Antoine Pelisse <apelisse@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Aug 28 23:59:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEnlb-0000SI-U5
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 23:59:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754288Ab3H1V6n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Aug 2013 17:58:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40598 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752476Ab3H1V6n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Aug 2013 17:58:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C4B433DBF0;
	Wed, 28 Aug 2013 21:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=bSqx/+PdYIKy
	iTCFJywb99gs9Hg=; b=iFis7lWsuHaUj9btmOoSPNqL7bgnqrK5aRbfNLtJqEM1
	SMBEKNKdcwazs4d8C98twAixMfMc6bhL11yfubgRED5pnoxWnvR9uUxyWquHcbTS
	fAqSuFfbIytDsErLrSRqhDlTWNJyDr6kBaIlOt6D/UlnS3W9RYXumUwR27Rzf1w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=GY4cY+
	lnuuf6bJgDatoBwCCTP2jjPxMH9mJ2EM+BCHIchYkZnC4e7m4EhnbrsfaV+9/MhT
	PyAPGGJ/6JV7LbqmlxylYBe1tarZm4JII2K1JnRmzkkb0VGBC7kSP7NKKnPjhQoC
	MPbvswdfTm7OSsnrE6vX3/JWw+Etx+cSKwbf0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B7B0A3DBEF;
	Wed, 28 Aug 2013 21:58:42 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0FAE23DBEE;
	Wed, 28 Aug 2013 21:58:41 +0000 (UTC)
In-Reply-To: <vpqy57l4jcx.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	28 Aug 2013 23:05:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 009806C6-102D-11E3-B8A6-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233223>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Wed, Aug 28, 2013 at 3:05 PM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>
>>>> +     bzr log | grep "^committer: " > ../actual
>>>> +     ) &&
>>>> +
>>>> +     echo "committer: Gr=C3=A9goire <committer@example.com>" > ex=
pected &&
>>>
>>> Git's source code usually says >../actual and >expected, without sp=
ace
>>> after '>'.
>>
>> Not that usually:
>>
>> % git grep ' > ' t/*.sh | wc -l
>> 1943
>
> Do I really need to quote the paragraph in CodingGuidelines?

Existing violations are not an excuse to make things worse by adding
more.  I think with these comments we can expect a reroll coming,
and it should be trivial for any contributor to fix it while at it.
