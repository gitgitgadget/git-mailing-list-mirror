From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Don't search files with an unset "grep" attribute
Date: Wed, 01 Feb 2012 18:03:51 -0800
Message-ID: <7vmx92yos8.fsf@alter.siamese.dyndns.org>
References: <7vy5sy8e0y.fsf@alter.siamese.dyndns.org>
 <1327359555-29457-1-git-send-email-conrad.irwin@gmail.com>
 <7vaa5d4mce.fsf@alter.siamese.dyndns.org>
 <20120125214625.GA4666@sigill.intra.peff.net>
 <7vhazb3rtm.fsf@alter.siamese.dyndns.org>
 <20120201082005.GA32348@sigill.intra.peff.net>
 <20120201091009.GA20984@sigill.intra.peff.net>
 <CAOTq_ptj06aNGsQRjV0fVRxnQFBHmU2FFSXwWDUUk9MM77k2LQ@mail.gmail.com>
 <20120201221437.GA19044@sigill.intra.peff.net>
 <20120201232027.GA32119@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Conrad Irwin <conrad.irwin@gmail.com>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Dov Grobgeld <dov.grobgeld@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 02 03:04:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rsm1m-0000LZ-IR
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 03:03:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754424Ab2BBCDy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 21:03:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50887 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753509Ab2BBCDx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 21:03:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C05C6C29;
	Wed,  1 Feb 2012 21:03:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lqXdtN+vR9MUJQrXiB0Iz1yJV50=; b=AT0l93
	REU5vhyHizTzOAtr8lzwiCi7XqWpD0BKunxoOBUcg00yoIu22ple1fZg1/fgmexP
	Wf4UXTP6zxWiVNFV5ZXuuRUSNlQjWgshEPKHy7axKTtGL5O3eP5276ZUFDbcWKDo
	+TtiIpfzzg8261p4VSpqJ+pJZ+XxMqjMxjadc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ArMdJgmSWyZKhD17tBiUoBgMnIr73H9O
	Yj4b2uDwRo+jSegFL1yZteoVomA8hddbP4XPE2nlrVk7nAttKV/eCNBiA7Wp1Fjq
	u0x9wOvzCYbpqNiUsdWvsMsnT2q46svmKOuseXotjpvN15p8KhoaJTTbf+pCei/K
	KPGO9YvPKK0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3362E6C28;
	Wed,  1 Feb 2012 21:03:53 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BB4CF6C26; Wed,  1 Feb 2012
 21:03:52 -0500 (EST)
In-Reply-To: <20120201232027.GA32119@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 1 Feb 2012 18:20:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 27BE4BDE-4D42-11E1-9552-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189576>

Jeff King <peff@peff.net> writes:

> There are a few optimizations I didn't do that you could put on top:
>
>   1. When "-a" is given, we can avoid the attribute lookup altogether.

Correct.

>   2. When "-I" is given, we can actually check attributes _before_
>      loading the file or blob into memory. This can help with very large
>      binaries.

Nice.

> ... However, for large files, it might be nice to have a streaming grep
> interface anyway, and (3) could be part of that.

Even nicer ;-)
