From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit -s: allow "(cherry picked " lines in sign-off
 section
Date: Wed, 17 Nov 2010 08:46:57 -0800
Message-ID: <7vd3q3hp8e.fsf@alter.siamese.dyndns.org>
References: <d0318dcd2b52f2e818888003e3dd81c7b713fec6.1289920242.git.git@drmicha.warpmail.net> <20101116193018.GA31036@sigill.intra.peff.net> <20101116202556.GA27390@burratino> <20101116204027.GB27390@burratino> <7vlj4shoej.fsf@alter.siamese.dyndns.org> <20101116233649.GA30700@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org,
	Martin Svensson <martin.k.svensson@netinsight.se>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 17 17:47:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIlAE-0004gm-Tc
	for gcvg-git-2@lo.gmane.org; Wed, 17 Nov 2010 17:47:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935048Ab0KQQrN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Nov 2010 11:47:13 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37361 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934973Ab0KQQrM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Nov 2010 11:47:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 000823400;
	Wed, 17 Nov 2010 11:47:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UlYqy3e1ek1NdUBlBcaPe0UuWrQ=; b=TZpPTD
	5R0aXSjuzgM9D8dyXXTT2AtFY0es+yIjuNohZmnMNov0E+7RDfFdWvu04UQ0iVS9
	KV8i/HkGu9WHY4VTLOg67V9mlsfC70wasU+ZDWieuw5CiZ4Bwh9bbOsixfIqJAy5
	owejnSqwTM+A77XnsTVOztINg4CGnqL/my+d8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HDg+EDc7u7E7Km5U86PooW5OozqzsLjz
	0+idi836VT79x7jsXBWj5rjXD6Wlg0H3X9wRy/Gt9N+178p5d4sdWfHCZKlwf9HV
	g9hnk0A7H/5Y1GeIDcy5CMdMo53BwTzVGlsQOU0TCRvH5rjr+nWK/KgHEPAeKWmr
	XMk/nkOYTqw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 971C033FF;
	Wed, 17 Nov 2010 11:47:15 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0F14B33FD; Wed, 17 Nov 2010
 11:47:08 -0500 (EST)
In-Reply-To: <20101116233649.GA30700@burratino> (Jonathan Nieder's message of
 "Tue\, 16 Nov 2010 17\:36\:49 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 554AA5AE-F26A-11DF-8C3A-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161622>

Jonathan Nieder <jrnieder@gmail.com> writes:

> How is the cherry-pick event different from the send-by-mail-and-apply
> event?
>
> In both cases, the result has a distinct commit id and distinct
> signoff and it is unlikely that the previous patch handler was testing
> with the same tree as the next one.  (And each patch handler should add
> relevant comments if the new situation warrants that.)

Fair enough.  If that is the direction we would want to go, perhaps it
suggests that we might eventually want to use "Cherry-picked-from: " as
the marker for this information?

And if we go that route, and if this information is being used, we have a
rather serious backward compatibility problem.  Older scripts will break,
and this cannot be handwaved away with a configuration option or a command
line switch (even if you personally choose to keep using the old format,
you may get a commit with the new style trailer from elsewhere).

Hmm.
