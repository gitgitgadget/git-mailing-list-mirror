From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/4] rev-list: add an option to mark fewer edges as uninteresting
Date: Tue, 23 Dec 2014 11:11:32 -0800
Message-ID: <xmqqvbl218rf.fsf@gitster.dls.corp.google.com>
References: <1419336082-283091-1-git-send-email-sandals@crustytoothpaste.net>
	<1419336082-283091-3-git-send-email-sandals@crustytoothpaste.net>
	<CAO2U3Qjbmz+fP-SLSeq1S+BDi4PSTSLf_TdqW-ik8GLV7=nUmA@mail.gmail.com>
	<20141223185142.GA27954@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Blume <blume.mike@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 23 20:11:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3Urt-0007RM-KM
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 20:11:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756454AbaLWTLh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 14:11:37 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50657 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755844AbaLWTLh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 14:11:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 03FFC298B7;
	Tue, 23 Dec 2014 14:11:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=309qSRA7O15/BnsiyMXBL6Lrk7k=; b=V7hqpx
	fgOcG6ymqhEHbOzektvgU2kuf4kO3t+BjJHD6BUZcjKYxBXk8Tal9MjfSn4eTYF7
	mpO2i82rhb6WaUv4mep4dFnCFzu+PGrt+aAxgSOHESE4P8KkBdb46Eja5k7U55A1
	R1OEHMhU4jJ9V9vN7dErp/4R2GQmYQtAXJ+iM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FML5X/zZMwjTW6YFPCYdnqsxxx4vVlHB
	nvesXPdMhsoz5ufyKqqpruwiKmIy3Z6RAcL2zk9AT+NYeik7zt+CgBfxw6EmeVJC
	9EeRqQUCZ+hCX3i4An46MzkgGr7tWilXeJQ4smG4Nzpt7MqbynYdTs/DwUmAdpXR
	V3pVfXA9CwQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ED809298B6;
	Tue, 23 Dec 2014 14:11:35 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AA3B9298B3;
	Tue, 23 Dec 2014 14:11:34 -0500 (EST)
In-Reply-To: <20141223185142.GA27954@peff.net> (Jeff King's message of "Tue,
	23 Dec 2014 13:51:42 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 82EC99B8-8AD7-11E4-BEE8-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261768>

Jeff King <peff@peff.net> writes:

> On Tue, Dec 23, 2014 at 12:55:48PM -0500, Michael Blume wrote:
>
>> This patch causes an error on my mac, test 5500 fetch-pack errors on
>> part 44 - fetch creating new shallow root. It looks for "remote: Total
>> 1" in the fetch output and gets 3 instead.
>
> It fails for me on Linux, too. Interestingly the tip of the series
> passes. I didn't investigate further.

Not surprised, as the first three are the same from the yesterday's
one that failed for everybody.
