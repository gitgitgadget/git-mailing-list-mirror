From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RESEND] Explicitly truncate bswap operand to uint32_t
Date: Sun, 22 Nov 2009 16:16:58 -0800
Message-ID: <7vfx86aydh.fsf@alter.siamese.dyndns.org>
References: <4B03FC57.5000506@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: Benjamin Kramer <benny.kra@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Nov 23 01:17:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCMcK-0002Qy-1G
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 01:17:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626AbZKWARE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Nov 2009 19:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbZKWARE
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 19:17:04 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34485 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbZKWARC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2009 19:17:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B1B74A0BD2;
	Sun, 22 Nov 2009 19:17:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=hq8HMjIab/4XRtcUkZlLNOqWlXs=; b=QXfZ3Sw3jlRoStRaPiiEPmQ
	Kb68g5uUFLj8mHlz6YEZABvlIHKtLG0gltLmZfpBdkdgMtyL+568G7OxUOJFWbc0
	Ybu4N1Oy8uhdNhpW0IY3wrxmBEnpGr9+et9JALXRzGBV7Fs6887pFsaMH5qCB7Th
	qZ+luWYQjk8RoUNrBf+c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=srO0ZN5lAomQwdsBCmFRz0oCPnvTEAy51O34VIYGqxxZcoWMB
	mBnCry0QRncUwOXfqSicKwZm2wKwf6AcKxpfpB47PoWnj2tmeIGMRnfD00zjVot4
	pXz6L3HTft+mKxu+KNqm6JFPcqSk5katBQ2R3E/9FUW/RRJrq3JSuFoxco=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 82B12A0BCE;
	Sun, 22 Nov 2009 19:17:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 54AE0A0BCD; Sun, 22 Nov 2009
 19:17:00 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8739AECC-D7C5-11DE-A559-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133471>

Benjamin Kramer <benny.kra@googlemail.com> writes:

> There are some places in git where a long is passed to htonl/ntohl. llvm
> doesn't support matching operands of different bitwidths intentionally.
> This patch fixes the build with llvm-gcc (and clang) on x86_64.
>
> Signed-off-by: Benjamin Kramer <benny.kra@googlemail.com>
> ---
> Any comments on this patch?

My vague recollection is that the response was "we do not mind it per-se,
unless it ends up in an ugly change; but we would prefer if you go fix
your compiler", but maybe I read it on lkml not here?

Also my vague recollection is that the kernel folks took that patch in the
end, so I think it is Ok for us to take this patch, too.
