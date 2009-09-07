From: Junio C Hamano <gitster@pobox.com>
Subject: Re: tracking branch for a rebase
Date: Sun, 06 Sep 2009 22:05:21 -0700
Message-ID: <7vfxaz9wfi.fsf@alter.siamese.dyndns.org>
References: <20090904135414.GA3728@honk.padd.com>
 <4AA124DD.1030208@drmicha.warpmail.net>
 <20090904181846.GC19093@coredump.intra.peff.net>
 <20090904185949.GA21583@atjola.homenet>
 <20090905061250.GA29863@coredump.intra.peff.net>
 <20090905140127.GA29037@atjola.homenet>
 <20090905142841.GB15631@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 07 07:05:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkWQE-0000ta-Br
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 07:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754133AbZIGFFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 01:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754106AbZIGFFe
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 01:05:34 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61609 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753750AbZIGFFd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2009 01:05:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AE3AC28057;
	Mon,  7 Sep 2009 01:05:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=5IwaW4cByAzwBYRt/C0LLwaDwvs=; b=ZY79Rk/y785bHDlawK6TQVT
	PE1LcFn3E8NeHNH1kdjWYrHhAJD5JQT37kF6mye5+o3C43NfuPsoa2h2DBqR8lDU
	gCtpFYwm33v/9cAP6EbJIi77FveUW1qsZbAZikZdNyMDtyzTtiHlJxdwdXK6EWtu
	14UV+tkFQ7b44wIY+gNs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=YgkGVZDiXinUkwFoqOOc/MqT8sUEYsOQuSQ/23kI/kh26gfG/
	9/hydXmjMosMovjcPecZSiZiR9iRykAQSwo8wedpBzRrlZ2xBgTFkSdlYbwY+y5R
	6xWkBl3KXq8BeLl7meVfbfl2z3bONpSL0+Qv3YY/BWjJi7OJ9P2TB6A5kw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 68C5028056;
	Mon,  7 Sep 2009 01:05:28 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 87BE128055; Mon,  7 Sep
 2009 01:05:22 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0F5A41EA-9B6C-11DE-A298-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127884>

Jeff King <peff@peff.net> writes:

>> Hm, I'd prefer a shorthand for "upstream for this branch", instead of
>> magic defaults.
>
> The more I think about, the more I think that is the right solution.
> Because magic defaults for "rebase -i" don't help when you want to do
> "gitk $UPSTREAM..".
>
> The previous discussion on the topic seems to be here:
>
>   http://article.gmane.org/gmane.comp.version-control.git/113666
>
> And apparently you and I both participated in the discussion, which I
> totally forgot about.
>
> Looks like the discussion ended with people liking the idea but not
> knowing what the specifier should look like. Maybe tightening the ref
> syntax a bit to allow more extensible "special" refs is a good v1.7.0
> topic? I dunno.

At-mark currently is reserved for anything that uses reflog, but we can
say that it is to specify operations on refs (as opposed to caret and
tilde are to specify operations on object names).

It specifies what ref to work on with the operand on its left side (and an
empty string stands for "HEAD"), and what operation is done to it by what
is in {} on the right side of it.  This view is quite consistent with the
following existing uses of the notation:

	ref@{number}	-- nth reflog entry
        ref@{time}	-- ref back then
	@{-number}	-- nth branch switching

So perhaps ref@{upstream}, or any string that is not a number and cannot
be time, can trigger the magic operation on the ref with ref@{magic}
syntax?
