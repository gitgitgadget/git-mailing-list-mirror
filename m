From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] Using index-pack in place of verify-pack
Date: Mon, 28 Feb 2011 11:50:02 -0800
Message-ID: <7v39n8hrbp.fsf@alter.siamese.dyndns.org>
References: <1298886583-30965-1-git-send-email-gitster@pobox.com>
 <AANLkTimrO6NqB0pXcfz=dAzA5fxz9ZizLyW7YV4Jan6S@mail.gmail.com>
 <7vfwr8jfsl.fsf@alter.siamese.dyndns.org>
 <AANLkTikTPVf1fZiTxsmLe-MCWVQY4YBGen5Bj_Yn0SSz@mail.gmail.com>
 <20110228165827.GB24915@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 28 20:50:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pu96s-0001H1-Hg
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 20:50:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753683Ab1B1TuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 14:50:15 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58019 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753265Ab1B1TuO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 14:50:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3D2993A67;
	Mon, 28 Feb 2011 14:51:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+2apAavRxdAx33D4Slnj3hUHBDs=; b=B5fmgx
	0NnYb+rYD7PbNXdTDnMSPvgX1CoENqeL8dszZNLaa9khX7WNujDop0DFux2rkdfS
	7JoMSJnuy0O2hGnARjZ/E6LT7OTXEBijFF3Pui9A1ryFU8CjGHPmIcC46PmfXBQr
	COuvU+aor4nGz7nXhqUG9lf99kLXI9lStlTzM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e7vXeTYBQxbm7nq8TBfw8QcBqkEd6uGJ
	FSecMZbJJ/U+0KyAHqUdSXIRqjKzs0Q9y44SNwzvM7YZfuGT55xCO6WqNxbYGwWy
	zUOliSMupJAghQTN3e6z37pn5gztniOTfWiya4Q5ed0HZ6Q42nSc+jRSo2V/g6cP
	E+o0B4CUF1A=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EFE543A63;
	Mon, 28 Feb 2011 14:51:27 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A80203A61; Mon, 28 Feb 2011
 14:51:22 -0500 (EST)
In-Reply-To: <20110228165827.GB24915@sigill.intra.peff.net> (Jeff King's
 message of "Mon\, 28 Feb 2011 11\:58\:27 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 218F72A2-4374-11E0-B2E4-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168136>

Jeff King <peff@peff.net> writes:

> I'm not at all interested in this topic, but in the time it took the two
> of you to write your emails, I did this:
>
>   $ cd linux-2.6
>
>   $ time git verify-pack \
>       .git/objects/pack/pack-36c50f6082df404c26a699f2702946e0cce6208f.idx
>   real    2m37.338s
>   user    2m35.874s
>   sys     0m1.348s
>
>   $ time git index-pack --verify \
>       .git/objects/pack/pack-36c50f6082df404c26a699f2702946e0cce6208f.pack
>   real    1m37.208s
>   user    1m36.106s
>   sys     0m1.048s
>
>
> OK, with the CPU time it probably took longer than your emails. But I
> ate some ice cream while it computed. :)

I guess my box is showing its age.  It is 2m34s vs 3m25s for the kernel
repository packed with depth=50 (the default).

A pack created with insanely deep depth of course shows larger difference
(2m31s vs 4m38s for the same repository repacked with depth=8192).
