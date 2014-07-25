From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/7] enforce `xfuncname` precedence over `funcname`
Date: Fri, 25 Jul 2014 11:55:45 -0700
Message-ID: <xmqq61il6zf2.fsf@gitster.dls.corp.google.com>
References: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>
	<1406140978-9472-6-git-send-email-tanayabh@gmail.com>
	<xmqqtx67bt78.fsf@gitster.dls.corp.google.com>
	<vpqlhrjqmyw.fsf@anie.imag.fr>
	<xmqqiommadl0.fsf@gitster.dls.corp.google.com>
	<53D15188.2010209@gmail.com> <vpqegxa386m.fsf@anie.imag.fr>
	<xmqqppgu8sxz.fsf@gitster.dls.corp.google.com>
	<53D15EB4.1050303@gmail.com>
	<xmqqlhri8rdb.fsf@gitster.dls.corp.google.com>
	<53D17919.4020702@ramsay1.demon.co.uk> <53D1CBFA.3020107@gmail.com>
	<vpqlhriyll6.fsf@anie.imag.fr>
	<xmqqr41974cl.fsf@gitster.dls.corp.google.com>
	<vpqlhrh9vtf.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jul 25 20:56:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAket-0001Kx-3o
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 20:55:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758276AbaGYSzz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 14:55:55 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52232 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753480AbaGYSzy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 14:55:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EA2A3294FB;
	Fri, 25 Jul 2014 14:55:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=c4puzAO3anztnAzqB1QHqQC/nHM=; b=GsMV0l
	4IVvTN+GfKx2+uchYOlBGnkWaeQNRWEI5A2GUQSa0nizwhzCf8XznZIvKjjgQ1Br
	oT7AjJ63UcXIcjgM8DrCRcGCuD0Xk7io1SZpvWVvyBhETfpSZrfMyhUWGpG1/phV
	l6v+M2JIw8rUd3jmljgcB6ctdzE3d6O2ZCcws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QncW0a6pSIDq30HiIfeqSkh3E3AkIqXW
	dl8ECAEQHIAanIqzS+IpDXvt7HY1PXz4TqO/eEOnFCVyliFK4UALeAInuBaiL/eE
	el4E0kySRi3cjO/Dcwiciij1k2uyLUD2Y+1rGfYqK6eMC1Q0AI7qBxHNiaLLJrYZ
	4hgCEkMiCAY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E05C7294FA;
	Fri, 25 Jul 2014 14:55:53 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9B87C294DE;
	Fri, 25 Jul 2014 14:55:47 -0400 (EDT)
In-Reply-To: <vpqlhrh9vtf.fsf@anie.imag.fr> (Matthieu Moy's message of "Fri,
	25 Jul 2014 19:45:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4A0E76FA-142D-11E4-843F-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254256>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>>> I'd just replace "list" with "array" and use
>>> Documentation/technical/api-allocation-growing.txt.
>>>
>>> But I can't think of a better way.
>>
>> Presumably this array will reflect the order the source file told us
>> about the keys and their values; I wonder if the <filename, lineno>
>> information we already have can be used (or unified) with it?
>
> I've thought about this too, and I think it would be really hard.

Yeah, I do not offhand think of a good solution, either, without
going pointer-crazy and have bidirectional link everywhere X-<.
