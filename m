From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix memory corruption when .gitignore does not end by \n
Date: Wed, 20 Jan 2010 22:48:31 -0800
Message-ID: <7vockovtq8.fsf@alter.siamese.dyndns.org>
References: <fcaeb9bf1001200458v436a8adeq5cfc6753900e6c0c@mail.gmail.com>
 <1263996556-9712-1-git-send-email-pclouds@gmail.com>
 <7v3a20367d.fsf@alter.siamese.dyndns.org>
 <fcaeb9bf1001201738x5cd374c2o280ec42d6d65c0f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Jonathan del Strother <maillist@steelskies.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 07:49:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXqqp-0008Ct-45
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 07:49:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752734Ab0AUGsp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 01:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752713Ab0AUGsp
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 01:48:45 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40672 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752528Ab0AUGso (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 01:48:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C03392F68;
	Thu, 21 Jan 2010 01:48:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jVcQh/ik/YFvQ+zqG1CdMyVc1ZU=; b=VbgBu8
	0sha6PHEc34EUF/WOdsyM48uIxghDbYDkRA7oB0kMx+mt5msk2MobCYenTJ3MuLJ
	Dv8zx6u0He8oWsjbRgUxwvJ7bhTh+aBViBKElwcYIlheKNeO2y0GQC+2tSyifJuu
	FH3eAbVNo3BdTrfhuUvOIq2BL9QJPgXqpdVQk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a8A1YFVkP9KyHV1pRHvptpWfrUPSpXGr
	ZhS72IowzjJhnPFTK+6QBQCVz32M+VaflfWL80/pT1h/ZA4kiNMV49kbu8MFIML5
	J2svVnE3XX3WCCWjzdxxTfN9XSiZF/RgZnI+xZU+c28GuzDFktLYrnIS7EnczaQz
	a8cOn+dFN/c=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DE8BF92F64;
	Thu, 21 Jan 2010 01:48:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E9EB692F63; Thu, 21 Jan
 2010 01:48:32 -0500 (EST)
In-Reply-To: <fcaeb9bf1001201738x5cd374c2o280ec42d6d65c0f7@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Thu\, 21 Jan 2010 08\:38\:48 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 01585C8C-0659-11DF-99F5-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137633>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> I mean the t3001 patch in comment part, which removes \n at the end of
> .gitignore and crashes the unmodified git.
>
> IOW I found a problem and this patch (not the t3001 one) should fix
> it. Not sure if this causes Jonathan problem though.

Ah, I see.  And a bug that leaves a string unterminated will exhibit
different symptoms depending on what garbage happens to follow it, so it
may not be universally reproducible.

Thanks; applied (and I saw Jonathan's Ack, as well).

Thanks, both.
