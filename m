From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git grep -O -i: if the pager is 'less', pass the '-i' option
Date: Wed, 14 May 2014 11:33:47 -0700
Message-ID: <xmqqvbt8jjlg.fsf@gitster.dls.corp.google.com>
References: <20140514155010.GA4592@camelia.ucw.cz>
	<xmqq7g5okztp.fsf@gitster.dls.corp.google.com>
	<20140514182654.GA9218@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stepan Kasal <kasal@ucw.cz>,
	GIT Mailing-list <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	msysGit <msysgit@googlegroups.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 14 20:37:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wke3Y-0008Mp-Gi
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 20:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbaENSh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 14:37:28 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65062 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750702AbaENSh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 14:37:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 216BD17ACD;
	Wed, 14 May 2014 14:37:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8M6Vdp53mizTwh5LwYjW6diQ1JE=; b=mIQmgA
	ho0P/9MsDmfEMun422H4kd55wVx61OlpJI39fT4f2M9ZyRuLiAq1aLGGxSGRpT+i
	qwyyA6z8S/8cT+wUmkT/BmuLO+WcvMIOK98FcNiWafeWI8XQ1bdHHJLxGHc/c8Yp
	SFuR8bMUPPZVeu8Bqn5vWXLKmC+ZAUe1zyCdY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lswucSHEBRpNwfwijdjBN1Yh9MmJzxhr
	xAw708NWkJECWwPEk21zfWHxD5KrIfnaitzk5Uk1IUFXQ80l13UVeWE4+TgdssNf
	CnuvUtpWwJzsAGKAOPDG6abWSwm8Rn2j94olqThiVK3iQ/Njh/SzNodiFP05z+wR
	9zUFv17Ln40=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 15AB517ACC;
	Wed, 14 May 2014 14:37:27 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2BF48177B5;
	Wed, 14 May 2014 14:33:49 -0400 (EDT)
In-Reply-To: <20140514182654.GA9218@google.com> (Jonathan Nieder's message of
	"Wed, 14 May 2014 11:26:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4A73BD82-DB96-11E3-8560-DDB853EDF712-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248934>

Jonathan Nieder <jrnieder@gmail.com> writes:

>>> +		if (opt.ignore_case && !strcmp("less", pager))
>>> +			string_list_append(&path_list, "-i");
>>
>> I have a feeling that this goes against the recent trend of not
>> mucking with the expectation of the users on their pagers, if I
>> recall correctly the arguments for dropping S from the default given
>> to an unconfigured LESS environment variable.
>
> It's just missing an explanation.
> ...
> (That's -I, not -i, because it ought to work even when the pattern
> contains capital letters.)

Spot on.  The change, especially with "-I", makes sense.

Thanks.
