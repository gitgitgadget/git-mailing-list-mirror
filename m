From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/6] sha1_name: avoid Yoda conditions
Date: Tue, 30 Apr 2013 16:07:02 -0700
Message-ID: <7v38u7aa95.fsf@alter.siamese.dyndns.org>
References: <1367358554-4257-1-git-send-email-felipe.contreras@gmail.com>
	<1367358554-4257-4-git-send-email-felipe.contreras@gmail.com>
	<7vehdrbrvz.fsf@alter.siamese.dyndns.org>
	<CAMP44s3osZJO1P6_KoPVON0cOSAD5D-OZmL=aKGkcWReortiCw@mail.gmail.com>
	<7v1u9rbrb4.fsf@alter.siamese.dyndns.org>
	<CAMP44s3K8BOfnUdc0514KgvYsbncSBO4DRSyfqhFQJomGrZN0A@mail.gmail.com>
	<7vobcvabxi.fsf@alter.siamese.dyndns.org>
	<CAMP44s26oZf0=xdqp5sr_J1TNhK83=88A7KH5n_LnstFe6o5gA@mail.gmail.com>
	<7v7gjjaagb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 01:07:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXJdf-0006hg-8f
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 01:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933786Ab3D3XHH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 19:07:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43337 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933739Ab3D3XHF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 19:07:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABD461B285;
	Tue, 30 Apr 2013 23:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p2mAZd4mtixfE1IDp5zONWSQXtk=; b=ns5xbA
	UkBCQ+8112mYawJBzFEAiiRlDf/qPRkuY4GMjphwat+rc8g3bl3EOY8fKIV8MNPw
	ZOrMwmhp+U/KcqCUKzY1dlJlZRNvf8ylbwTjUMNLCyPTgUMeNYTJtuDns5nRu2z9
	xGHt08GmUOz4Epcd1oUN60xCSeBucmXVGsDOI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xud2OeQs0Juf+j8vbDRKnh3v6sNRxG+S
	NTli0byhraY16J0C56ZysEcdZ1jLZkrrVNbSRFFensYzVe5ASffAmClQ5R8f5n22
	RZDVUxxJsIq+3nEeLZ4CIB8+Ou7mTWlD52wZq8se8tvYj9/7U6MvCgfxkX1aCeI7
	uN0ueZ1zbgk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E0951B284;
	Tue, 30 Apr 2013 23:07:04 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 206191B283;
	Tue, 30 Apr 2013 23:07:04 +0000 (UTC)
In-Reply-To: <7v7gjjaagb.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 30 Apr 2013 16:02:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AC0B24C6-B1EA-11E2-896C-A3355732AFBB-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223041>

Junio C Hamano <gitster@pobox.com> writes:

> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Yoda speaks in reverse "Stopped they must be; on this all depends".
>> "if (0 < len)" says "if zero is less than len", which is in reverse,
>> as reverse as "if 1.50 is taller than you". It's all reversed: "if you
>> are taller than 1.50", "if len is greater than zero", "They must be
>> stopped; all depends on this".
>>
>> I don't understand what is not clear.
>
> I never said anything is "not clear", did I [*1*]?

Ahh, OK.

Earlier I did not see the link between "Yoda" and "const op var"
that is "speak in reverse".  So I did say "not clear" or an
equivalent of it, and you clarified it with "reverse" here.

Thanks.
