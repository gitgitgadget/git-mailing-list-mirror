From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 11/12] t5524: test --log=1 limits shortlog length
Date: Fri, 08 May 2015 10:32:35 -0700
Message-ID: <xmqq3837m0uk.fsf@gitster.dls.corp.google.com>
References: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
	<1430988248-18285-12-git-send-email-pyokagan@gmail.com>
	<05adfac12cb9a7ad183281974d991e00@www.dscho.org>
	<CACRoPnRfqQMRJ5N=oL84SMw=FC=Eg-Co-De_9E9cpWCaaSZAxw@mail.gmail.com>
	<554BB93A.3090000@kdbg.org>
	<8e34bc9ea27d147f86de0cf60141687a@www.dscho.org>
	<554CF03A.7030503@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>, Git List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri May 08 19:32:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yqm8h-000073-L8
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 19:32:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbbEHRcj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 13:32:39 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52866 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932161AbbEHRci (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 13:32:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9AC4D4E488;
	Fri,  8 May 2015 13:32:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NsX12E1zs1hdX0XOx8FSuI/qnqQ=; b=MKIBOy
	2Y+DGIc25ttO1eojX8Vjaf+ZTWy5GuphbzREJVfUIzK4DmAGaWgR4rfIoHdye4kJ
	SPZbstWjyfOJtWM5rnEup+7B1IAwE7hq19IFGdBMZZfDZ+ZMhum/+agRzYJ07A5x
	DjheO7cIeCEZvMd0+SSWAf5uLrdlCqR4h1qr0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HcOJrNUbzfckG7vAuonYqG+pKcMJ/eys
	MizXHL3mx2wu+euJ91XP7VZOThm4goiROE9mRPu01ALL7Y+KoSQI9Yo9/9b+rEfV
	4iPKMDR0EX09aXq8uljhJqQbDwl2uItaGnVU7Oy4W+DYA+vKKKMGw+mLU+jhvChY
	XcYeS07sJPk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 921B94E487;
	Fri,  8 May 2015 13:32:37 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 132D24E486;
	Fri,  8 May 2015 13:32:37 -0400 (EDT)
In-Reply-To: <554CF03A.7030503@kdbg.org> (Johannes Sixt's message of "Fri, 08
	May 2015 19:19:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 38028980-F5A8-11E4-8132-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268632>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 08.05.2015 um 12:07 schrieb Johannes Schindelin:
>> On 2015-05-07 21:12, Johannes Sixt wrote:
>>> Nope, it's not better. test_must_fail is explicitly only for git
>>> invocations. We do not expect 'grep' to segfault or something.
>>>
>>> Cf. eg.
>>> http://thread.gmane.org/gmane.comp.version-control.git/258725/focus=258752
>>
>> That link leads to a patch that changes `! grep` to a `test_must_fail
>> grep` and is not contested, at least not in the thread visible on
>> GMane. Would you have a link with a more convincing argument for me?
>
> Gah! Sorry for sending you in circles. I see that others have brought
> forward sufficient arguments. Just to get my own argument straight,
> here is the message I wanted to direct you to:
>
> http://thread.gmane.org/gmane.comp.version-control.git/258725/focus=258792

FWIW, I think Michael Gruber gave the rationale better than I did
in that thread.
