From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/14] numparse module: systematically tighten up integer parsing
Date: Wed, 25 Mar 2015 14:59:11 -0700
Message-ID: <xmqqegoc20y8.fsf@gitster.dls.corp.google.com>
References: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>
	<20150319052620.GA30645@peff.net>
	<xmqqk2ydjvcd.fsf@gitster.dls.corp.google.com>
	<55118B74.1030201@alum.mit.edu> <551195B6.9040402@web.de>
	<5513252A.7050601@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Mar 25 22:59:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YatKb-00051F-0A
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 22:59:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752290AbbCYV7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2015 17:59:17 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50301 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752193AbbCYV7O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 17:59:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C0A244581;
	Wed, 25 Mar 2015 17:59:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wYJXGdlvSrziqXQE2rNSoCHtzyg=; b=VgMoeI
	UR1OQd4cdpeRH1EUFt8LsTFlQSFZKEYpyXdDEcqgj65TJ/p6Vi7kyoJkQVV4UFie
	CwTOYZzklfj6vknNMWWMl6m4Gafm93EkeTom4MuxFNzNw52J4uj3CFaR3DwSZ8yL
	QEiczWRdHwtkcbn2ZcQviIMKMRVadB2EH8quA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Pg+ogAD+uhVG00hlIIpwKcVPC7jMYelI
	CUO++d3qx88iHfKipI9kKJsmD7S4UbVCxsjVl1fmdf/UH62CvVTe/gpz/NSlZA+z
	G1T6xPPAAxLPRjQqucaI/iIcIxq8M9qtQp2fXGNluElBDeoZm4amU0wNXakX2sX8
	ZzhaWY2AFe4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8FEB144580;
	Wed, 25 Mar 2015 17:59:13 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 12FE04457F;
	Wed, 25 Mar 2015 17:59:13 -0400 (EDT)
In-Reply-To: <5513252A.7050601@alum.mit.edu> (Michael Haggerty's message of
	"Wed, 25 Mar 2015 22:14:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2C30CEE0-D33A-11E4-B973-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266306>

Michael Haggerty <mhagger@alum.mit.edu> writes:

[jc: dropped a non-working address from Cc list]

> I wasn't aware of strtonum; thanks for the reference. It has an
> untraditional interface. Their willingness to sacrifice half of the
> unsigned range and requirement that the user specify minval and maxval
> have the nice effect of permitting one function to be used for all
> integer types.
> ...
> I think git will need more flexibility, for example to support other
> radixes and to allow trailing characters. So personally I don't think we
> should use (or imitate) strtonum().

I had the same impression.  An earlier suggestion by Peff about
uintmax_t may be something we might want to keep in mind; we might
want to use strtoll/strtoull as the underlying implementation if we
wanted to avoid rolling our own.

Thanks.
