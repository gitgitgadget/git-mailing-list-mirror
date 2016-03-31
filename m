From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v11 2/4] parse-options.c: make OPTION_COUNTUP respect "unspecified" values
Date: Thu, 31 Mar 2016 13:45:38 -0700
Message-ID: <xmqqshz6l6kt.fsf@gitster.mtv.corp.google.com>
References: <01020153cd2340f8-4665cd5f-cd5c-41ab-a162-20acc43ca52e-000000@eu-west-1.amazonses.com>
	<01020153cd2341e2-2616ba0b-9271-4a97-87d1-b6dedbf31828-000000@eu-west-1.amazonses.com>
	<xmqq60w2o5g9.fsf@gitster.mtv.corp.google.com>
	<CAFZEwPO4CJ-Q=52Es14CdD0mjG-qgy4=X2kU71npi=8x7FsSQw@mail.gmail.com>
	<xmqqegaqmmyr.fsf@gitster.mtv.corp.google.com>
	<CAFZEwPN_=mLXf+8JfMhwf_5fviG-rjHp07b+41HXs2NLO6BnxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 22:45:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aljTY-0007II-OD
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 22:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933354AbcCaUpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 16:45:43 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:55128 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932877AbcCaUpl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 16:45:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B5B2552ED4;
	Thu, 31 Mar 2016 16:45:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OAl8WjoWHQEfmtroRaynkpmTLP0=; b=Do/tFE
	v9hGMqu1uXpLEjkeyBdm1v4MrVrOkQA/2bn8rU0HiLusoZXpag0tgxoLXatYfByV
	8LJbqNb/HNvhsTNgt/RxrBXtnYXKdriNtcWUqPgwIcDExes1GUEUiSlLphCcp/uU
	I8mPbN+zShvjm1cMARDBHdwPsaPqRBQY87OAg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cIEYMIrC6XBlliCWCQYfC6rzD0LAPhHO
	IUxOHT1azR+1Yo1L2XERrsUDm5jvCANgUlFcKPcOW1q3+CArwDqs1GqWUgnZpAYg
	CL+IS9bTGgONT8s3goY8wKFGV1/E7iC8zDH4rRAMew1lcuBNyhuIVfpYiJqwYDBq
	i4JzkPynHKo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AD56252ED3;
	Thu, 31 Mar 2016 16:45:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1E8AB52ED2;
	Thu, 31 Mar 2016 16:45:40 -0400 (EDT)
In-Reply-To: <CAFZEwPN_=mLXf+8JfMhwf_5fviG-rjHp07b+41HXs2NLO6BnxA@mail.gmail.com>
	(Pranit Bauva's message of "Fri, 1 Apr 2016 02:11:16 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8788761E-F781-11E5-9326-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290465>

Pranit Bauva <pranit.bauva@gmail.com> writes:

> Also, when such an idea for new feature comes up, it is better to
> implement it because let's say some developer is stuck in future and
> this new feature could help him but he doesn't have a clue that such a
> discussion happened some time ago. Thus saving him time and further
> effort.
>
> Anyways, How is the convention in git for these type of futuristic ideas?

Just keep it in mind without complicating the code, unless the idea
truly makes sense and has immediate use.

For example, I do not know how it would be useful to be able to
count up starting from 2 with an option --more that is COUNTUP, if
your --no-more would reset it to 0.

     git cmd --more ;# sets more=2
     git cmd --more --more ;# sets more=3
     git cmd --no-more --more ;# sets more=1, not more=2
