From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/6] send-email: shorten send-email's output
Date: Wed, 08 Jun 2016 12:33:34 -0700
Message-ID: <xmqq7fdzlbld.fsf@gitster.mtv.corp.google.com>
References: <20160607140148.23242-1-tom.russello@grenoble-inp.org>
	<20160608130142.29879-1-samuel.groot@grenoble-inp.org>
	<20160608130142.29879-4-samuel.groot@grenoble-inp.org>
	<xmqqeg87mviz.fsf@gitster.mtv.corp.google.com>
	<4253fcd6-dba5-fc9a-d63e-e40ba10bb9e7@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, tom.russello@grenoble-inp.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	matthieu.moy@grenoble-inp.fr, aaron@schrab.com, e@80x24.org
To: Samuel GROOT <samuel.groot@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Wed Jun 08 21:33:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAjEW-000420-Tx
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 21:33:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754332AbcFHTdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 15:33:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54655 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751016AbcFHTdj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 15:33:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F2CFF20258;
	Wed,  8 Jun 2016 15:33:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DlEKSDS7noE3xFzUVQphEDbvMGU=; b=YjEIFX
	/4gEb7QHu3MvstZLUlhcSwzb5moXdNNuihmyM9WtgvpaAXkFQNFiF5yg8OQgWRFJ
	ph+L581Q2emJaIJ0no22HPXwaXKX5fFLST3wXIvxSA6LHfSuGbgZlfhvHJoOnQZZ
	OfIjml7u6NO7uH6Q11YTl5zkNK8mHm3mjHx4o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MSBSLHGwhQxboqEDNkGQHzg7747/ikYQ
	nhT4+ufJUMagHbA+dro7do72N6i0MX00F6/84iI8ZVkADc9pS4dufsMmFNgzdEO1
	qCoPpuLTtmbBU+9mbH0e15rysxI3LkGleKJaXyxebjivyCAY0VH5Wh6HHNpnxjDf
	UGRFjiBtd4w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EBAC020257;
	Wed,  8 Jun 2016 15:33:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6AC8C20256;
	Wed,  8 Jun 2016 15:33:36 -0400 (EDT)
In-Reply-To: <4253fcd6-dba5-fc9a-d63e-e40ba10bb9e7@grenoble-inp.org> (Samuel
	GROOT's message of "Wed, 8 Jun 2016 21:18:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E4F444AE-2DAF-11E6-9525-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296842>

Samuel GROOT <samuel.groot@grenoble-inp.org> writes:

> On 06/08/2016 07:37 PM, Junio C Hamano wrote:
>> Samuel GROOT <samuel.groot@grenoble-inp.org> writes:
>>> +				printf("Adding cc: %s from From: header\n",
>>> +					$1) unless $quiet;
>>
>>> +					printf("Adding to: %s from To: header\n",
>>> +						$addr) unless $quiet;
>>
>>> +					printf("Adding cc: %s from Cc: header\n",
>>> +						$addr) unless $quiet;
>>>  					push @cc, $addr;
>>
>>> +				printf("Adding cc: %s from Cc: header\n",
>>> +					$_) unless $quiet;
>>
>> These make the end result prettier by not repeating the same address
>> twice, but is it just me who finds these inexplicable case
>> differences irritating?  Shouldn't these field references in the
>> result mirror the field references in the origin of the information?
>
> It makes sense only in the case below...
>
>>> +		printf("Adding cc: %s from From: header\n",
>>> +			$1) unless $quiet;
>
> ... because the sender should receive its own copy (at least to avoid
> breaking threaded view in his mailer) and be cc-ed. By the way, we
> should cc the sender when sending the cover letter too for the same
> reason.
>
> But in other cases, it seems pointless to display identical field
> reference twice.

My comment may have been a bit too oblique.  What I meant was

	Adding cc: Samuel from From: header

looked strange, and I thought it would be better written

	Adding Cc: Samuel from From: header

Same for

	Adding to: Samuel from To: header

being strange, and a better version of it would be

	Adding To: Samuel from To: header
