From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] regex: fix a SIZE_MAX macro redefinition warning
Date: Mon, 06 Jun 2016 11:10:48 -0700
Message-ID: <xmqqd1nuxk5z.fsf@gitster.mtv.corp.google.com>
References: <575212DF.90209@ramsayjones.plus.com>
	<alpine.DEB.2.20.1606050815360.4250@virtualbox>
	<57542A85.3040206@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	GIT Mailing-list <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 20:10:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9yzI-0005mJ-7E
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 20:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919AbcFFSKw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 14:10:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62300 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750933AbcFFSKv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 14:10:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4F07222516;
	Mon,  6 Jun 2016 14:10:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mzQwcC+BeMTo62iIizurr0hvlgg=; b=ddr6fS
	rQMg9614rnEgpFbcvNP1nDFpLAcLwD8X8w0TenmDLn5XuM34UsY9OYcL58NCSglB
	VtTc2dnUSBV7B0CQp0Xd+Dq2VZLMcBWk8bEgdtk2UC1DsZEbfJk7T0b+WDx8JGeB
	+deCJ72VhwJdrncc6uEa/0ELmXmslxLy9xX8I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fyc9m2hizB9wTRGnPwU0wcUp4gC8jHm7
	vli+umUUPrLXskfbNjhrAVkPLUa1P9WveKdgFoYK8+ABsGvUTbn2mByPPZ/1IOjL
	lBmP9bQqw8W6DPl3CKR6ChABDYkoS0EQx5x6HL86ReXDDRUcT/1fIPSgM4riUlv0
	MDpufvEMBqA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 46D3822511;
	Mon,  6 Jun 2016 14:10:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C16C02250C;
	Mon,  6 Jun 2016 14:10:49 -0400 (EDT)
In-Reply-To: <57542A85.3040206@ramsayjones.plus.com> (Ramsay Jones's message
	of "Sun, 5 Jun 2016 14:35:01 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FFBD5072-2C11-11E6-99C5-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296547>

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> The original version of this patch looked like this:
> ...
> So, just move the unconditional inclusion to the start of the compilation
> unit root file, before the #include of the regex_internal.h header.
>
> In some ways this is a better fix, because it makes it clear that, currently,
> the compat/regex code requires <stdint.h>. This would remove the need for
> such a comment.

Sounds sensible to me too.
