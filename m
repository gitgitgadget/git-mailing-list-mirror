From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] urlmatch.c: recompute ptr after append_normalized_escapes
Date: Thu, 12 Sep 2013 15:26:10 -0700
Message-ID: <xmqq61u5oewt.fsf@gitster.dls.corp.google.com>
References: <75d702a744eb33a456622dd2ff901abef83e51d8.1378979451.git.trast@inf.ethz.ch>
	<c8915eaaf877abe0e69864ffdc6c50f@f74d39fa044aa309eaea14b9f57fe79>
	<xmqqioy5q4dd.fsf@gitster.dls.corp.google.com>
	<85CEBFAA-8905-46EC-88C5-5DDE629B73F9@gmail.com>
	<20130912220505.GM4326@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 13 00:26:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKFL7-00026k-2B
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 00:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755289Ab3ILW0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 18:26:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57121 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752855Ab3ILW0M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 18:26:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E248415C2;
	Thu, 12 Sep 2013 22:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RxFCSO6bM29R+C3DkualobQ/Bww=; b=K9SyLc
	Bs4SYX9R5JThDKjRn8bcHmaDzI2PZ/MUQCRSfDiUibv/ltutJIaDKy1qbBPYYMjO
	Q5zigtyq+aWaqB0x8AHvsJnTs9wcQlROKjVT0UetnnalC/xgflOEqygwyJIiemmT
	La3UcGPwbXbcZ5A/+3GQVGDjkndR35UpzlwNo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R4OalyFNAmeHpfhtYwRD8uE9mdkL9mR5
	VFjle7ug6BZgrMyScXKstJR9sdCrG2e3Y8nSQH+fwWr55HNVTiW1U6WwNUAEOOFq
	xUdJUkE9myJ8TA1tPc7SYORv2dFwIYL4Qm7yyf6r103/wt1jpd39i42hr24Mwrcm
	lgEQzZjo8/8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63CF0415C1;
	Thu, 12 Sep 2013 22:26:12 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A43D2415BA;
	Thu, 12 Sep 2013 22:26:11 +0000 (UTC)
In-Reply-To: <20130912220505.GM4326@google.com> (Jonathan Nieder's message of
	"Thu, 12 Sep 2013 15:05:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5407E942-1BFA-11E3-B0FD-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234707>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Kyle J. McKay wrote:
>
>> The longer comment looks good to me.  If you think the code will be safe from
>> simplification patches without a comment, that works for me too.
>
> I think if we can't trust reviewers to catch this kind of thing, we're
> in trouble (i.e., moving too fast). :)
>
> So FWIW my instinct is to leave the comment out, since I actually find
> it more readable that way (otherwise I would wonder, "Why am I being
> told that a strbuf's buffer has a nonconstant address?  Do some other
> strbufs have a constant address or something?")

Yeah, I was staring at that message and coming to the same
conclusion.
