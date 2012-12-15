From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Make lock local to fetch_pack
Date: Sat, 15 Dec 2012 11:31:27 -0800
Message-ID: <7vpq2bru28.fsf@alter.siamese.dyndns.org>
References: <1355510300-31541-1-git-send-email-kraai@ftbfs.org>
 <1355510300-31541-2-git-send-email-kraai@ftbfs.org>
 <7vtxrnrwer.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matt Kraai <matt.kraai@amo.abbott.com>
To: Matt Kraai <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Sat Dec 15 20:31:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjxSd-0006hE-Gc
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 20:31:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341Ab2LOTba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 14:31:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49085 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751093Ab2LOTba (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 14:31:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F72B8A08;
	Sat, 15 Dec 2012 14:31:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9DeKEse7VG/nBoiLB2qEekMpeZ8=; b=M9DGmp
	wErN3SXSGxrrFT6EqMEnkH4qIGQc7Hvdba6DMho+4GiY8hAT8UqvajvOqEJ5bQ9R
	14WCdgMhrjBMvxrXgNhE4Ea4Ia/pRKJO5+YAal3QvlagZtK+OwZEvGh5qImnHNj4
	NnNDISZmBAxL3QkCR+PKIF7DaFXdvgyo8Dd5g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YgyQOmSNanOQkFnIHj8a7k4V9ULIBJ3V
	FVLtYqwS1KDQFTcTsl2gHcFmwDc5KEvpmaBJSiYHAKhIlm37VztN+fyjHnjKqfYi
	zwlJFb1yiin7nvNz0lgEzeVlRc9G1TdowbcZMlhegbKfUzb8wq+/NRhpmTkQfmXJ
	jbU/dV4BiY4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A90B8A07;
	Sat, 15 Dec 2012 14:31:29 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BA0B78A05; Sat, 15 Dec 2012
 14:31:28 -0500 (EST)
In-Reply-To: <7vtxrnrwer.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 15 Dec 2012 10:40:44 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 05C8125C-46EE-11E2-AB69-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211565>

Junio C Hamano <gitster@pobox.com> writes:

> Matt Kraai <kraai@ftbfs.org> writes:
>
>> From: Matt Kraai <matt.kraai@amo.abbott.com>
>>
>> lock is only used by fetch_pack, so move it into that function.
>>
>> Signed-off-by: Matt Kraai <matt.kraai@amo.abbott.com>
>> ---
>>  fetch-pack.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> Eh, did you base your patch on something older than 2d4177c (Make
> fetch-pack a builtin with an internal API, 2007-09-10)???

Ah, nevermind.  I see we refactored this out recently but that is
still in flight.
