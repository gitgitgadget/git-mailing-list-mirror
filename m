From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/8] git-remote-testpy: hash bytes explicitly
Date: Thu, 17 Jan 2013 12:43:06 -0800
Message-ID: <7vmww7tuat.fsf@alter.siamese.dyndns.org>
References: <cover.1358448207.git.john@keeping.me.uk>
 <66c42ff65eddde494f40d0a582e89a081b4ab8e8.1358448207.git.john@keeping.me.uk>
 <7vtxqftulq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Pete Wyckoff <pw@padd.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Jan 17 21:43:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvwJL-00013t-0B
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 21:43:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756432Ab3AQUnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 15:43:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52781 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753689Ab3AQUnK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 15:43:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB183C869;
	Thu, 17 Jan 2013 15:43:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=giHT6iuhvSezv52HbjYRE2VYIgc=; b=mmILpg
	lAJcoIUDxVjYUg6J8frLt1w96qLW56xR3VCsgj7I7MjtrA+ez2sUO8NXeRzcRguC
	weJwmZ0BpO8b+zKgxf7fkZY/3g6g61I8UD7X75tu0T08QGP44Sx/kQwhG9dO1mfr
	xSl3cIq+Twfxdmp7zjr6WsefCeNgIt+AYRPSo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=paTHb/7gI3xhj9JnCWIJXNYjyyFFhth7
	yv0G49rDskdcPQm2QC0s8Ck4nx+O7SX7XHBtU7ppOpDooL6n0zyvQA2bz357TvMb
	9Qal1YkwiafaGYqB9eiPhr0XQAv8ba9GLU9AnI7tRm+Ce25IkFId4ot0nBEpcgl3
	+jBT+sMHjKQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE747C868;
	Thu, 17 Jan 2013 15:43:08 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3F3C5C864; Thu, 17 Jan 2013
 15:43:08 -0500 (EST)
In-Reply-To: <7vtxqftulq.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 17 Jan 2013 12:36:33 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 801D0AE6-60E6-11E2-ACE7-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213876>

Junio C Hamano <gitster@pobox.com> writes:

> John Keeping <john@keeping.me.uk> writes:
>
>> Under Python 3 'hasher.update(...)' must take a byte string and not a
>> unicode string.  Explicitly encode the argument to this method as UTF-8
>> so that this code works under Python 3.
>>
>> This moves the required Python version forward to 2.0.
>>
>> Signed-off-by: John Keeping <john@keeping.me.uk>
>> ---
>
> Hmph.  So what happens when the path is _not_ encoded in UTF-8?

Oh, my brain was not working. Forget this part, and sorry for the
noise.  We are not decoding a bytestring to an array of unicode
characters, but going the other way around here.
