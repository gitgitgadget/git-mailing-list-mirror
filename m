From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pack-bitmap: do not use gcc packed attribute
Date: Wed, 06 Aug 2014 12:32:32 -0700
Message-ID: <xmqqd2cdmn1r.fsf@gitster.dls.corp.google.com>
References: <20140728171743.GA1927@peff.net> <53D806AC.3070806@gmail.com>
	<20140801223739.GA15649@peff.net> <20140801231044.GA17960@peff.net>
	<53DFDCD2.2090803@gmail.com> <20140805184724.GA10369@peff.net>
	<53E27ADC.4070501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 21:32:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF6x6-00051x-OM
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 21:32:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbaHFTco (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 15:32:44 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61096 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932357AbaHFTcn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 15:32:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2C16D2FF51;
	Wed,  6 Aug 2014 15:32:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sY62uwmG6e6WTX0N0oZRKyPESyM=; b=HjQrss
	Lp2s1qgG51NyVP3AkHBlvPNX5wzFSHXXMFaV+WT4/Rr6tlN1SdWXqRhnGs9i8keX
	swUSEV7uQU4iOmQ6TaAj92+z/tt5BQ8D8y+3ObxOqGACexK64au49RVKc4vX3fJq
	HuyKNR7cKH3cgaLGnukX16lwhdnQJjCE5In0k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L+Gd7bl4SIMTaZ1px75kNAQFcAynGpXY
	GVuuCgOTStdFIG4EG13Ze6UWCxh4Maxy92k6EB1k6HzHrqBZvpMvgUbaUcJ52lj2
	USLiN/Gl1fi8T+UAmZlwMhKqr91xtBj6gbzRysnlWfUgO+tzLnMwhG1tBcpeHepP
	DUWjPoJGCG8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 228D42FF4F;
	Wed,  6 Aug 2014 15:32:43 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B68C82FF41;
	Wed,  6 Aug 2014 15:32:34 -0400 (EDT)
In-Reply-To: <53E27ADC.4070501@gmail.com> (Karsten Blees's message of "Wed, 06
	Aug 2014 20:58:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6A8DB8D8-1DA0-11E4-9831-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254894>

Karsten Blees <karsten.blees@gmail.com> writes:

> Am 05.08.2014 20:47, schrieb Jeff King:
>> On Mon, Aug 04, 2014 at 09:19:46PM +0200, Karsten Blees wrote:
>> 
>>> Hmm, I wonder if it wouldn't be simpler to read / write the desired on-disk
>>> structure directly, without copying to a uchar[6] first.
>> 
>> Probably. My initial attempt was to keep together the read/write logic
>> about which sizes each item is, but I think the result ended up
>> unnecessarily verbose and harder to follow.
>> 
>
> Yeah, having read / write logic in different files is confusing, esp. when
> not using structs to define the file format.
>
>>> Here's what I came up with (just a sketch, commit message is lacky and the
>>> helper functions deserve a better place / name):
>> 
>> I like it. Want to clean it up and submit in place of mine?
>> 
>
> Will do, but it will have to wait till next week.

Thanks, both.
