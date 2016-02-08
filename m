From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git show doesn't work on file names with square brackets
Date: Mon, 08 Feb 2016 14:36:32 -0800
Message-ID: <xmqqlh6u6d8v.fsf@gitster.mtv.corp.google.com>
References: <25D155FA-6F05-425C-AB2D-7F0B44E0D1C5@jetbrains.com>
	<alpine.DEB.2.20.1602061708220.2964@virtualbox>
	<CACsJy8ChZzYWXePSwF6D8vPZMuz3dQe1=jtw6rSG7M1oC+RiNw@mail.gmail.com>
	<32B9BD70-F06C-49C4-B672-24173E69B99F@jetbrains.com>
	<CACsJy8AMEgk8UXF==VmvLXsL4R67u0+U4MiUGPtO6HX0Y30oXg@mail.gmail.com>
	<20160208141552.GC27054@sigill.intra.peff.net>
	<20160208150709.GA13664@sigill.intra.peff.net>
	<xmqqpow7807l.fsf@gitster.mtv.corp.google.com>
	<20160208195230.GA30693@sigill.intra.peff.net>
	<20160208202043.GA6002@sigill.intra.peff.net>
	<20160208205637.GA13732@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Kirill Likhodedov <kirill.likhodedov@jetbrains.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 08 23:36:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSuQD-00044x-B2
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 23:36:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756221AbcBHWgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 17:36:36 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56062 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752997AbcBHWgf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 17:36:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DF3434240F;
	Mon,  8 Feb 2016 17:36:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XRTJufBJAb1knWmItpjIgdTyYTE=; b=Sg3X4V
	Ge8OwtQHjZHBh5PU9Io9xJeDr7rwpVx0lNpxqOJ1C4GO82kTDw0GkWQ4yiKl0rRP
	pnTxuWwbPL/Mx32YOyiLt/co4VqdTHspsHYcoXeYLa1KBS0zE+oFmyjmxLhX6ASt
	Gmf3hETZ8T4PM4eGNS6c9nFjVLYy8hUp0RHzc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c9Rg82uoppcT30oeztAppLnSqCahtNKe
	hy2jCi48VeCR47Aw8hea1yFF6D60XLB8p37lJWaFfrO6RgOnOGCQU7Z25Tzx2cL9
	Q5jMtA7GUQNL82wqcUf5oRuUYinn1IQKJ7frp2iIR1YCuBW6zl7gGSf9Hm8cU6U+
	59Jjm2N2eB8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D49AC4240E;
	Mon,  8 Feb 2016 17:36:34 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 58F334240C;
	Mon,  8 Feb 2016 17:36:34 -0500 (EST)
In-Reply-To: <20160208205637.GA13732@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 8 Feb 2016 15:56:38 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 684A26F8-CEB4-11E5-BE82-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285818>

Jeff King <peff@peff.net> writes:

> But having looked at this, I can't help but wonder if the rule should
> not be "does the file exist" in the first place, but "is the file in the
> index". This dwimmery is about commands like "log" that are reading
> existing commits. I cannot think of a case where we would want to
> include something that exists in the filesystem but not in the index.

Yeah, checking in the index, once it is loaded, is reasonably quick
check.  A path that is not in the index or the current HEAD may or
may not exist on the filesystem, so at some point you would need an
explicit disambiguation anyway, and the reason why we check the
filesystem is not because that is conceptually better than checking
in the index but merely because "does lstat(2) tell us the path is
there?" check was fairly a cheap way on the platform the system was
primarily developed on initially.  Looking it up from HEAD would be
a lot more heavyweight and would not buy us anything, but looking it
up in the index may turn out to be comparable to a single lstat(2).

I dunno.  I have a suspicion that anything conceptually more
expensive than a single lstat(2) is probably not worth doing, as
this "sometimes you do not have to give --" is merely a usability
hack, and we have to always do "git log -- removed-sometime-ago"
to find where in the history a certain path was lost.
