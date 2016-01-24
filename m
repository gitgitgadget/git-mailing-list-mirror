From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/1] Let merge-file write out conflict markers with correct EOLs
Date: Sun, 24 Jan 2016 14:09:01 -0800
Message-ID: <xmqq4me2d402.fsf@gitster.mtv.corp.google.com>
References: <cover.1453482052.git.johannes.schindelin@gmx.de>
	<cover.1453632296.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Beat Bolli <dev+git@drbeat.li>,
	Jeff King <peff@peff.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 24 23:09:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNSqX-0000zp-4J
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 23:09:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756410AbcAXWJG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 17:09:06 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58381 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756179AbcAXWJE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 17:09:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 56D5E3E422;
	Sun, 24 Jan 2016 17:09:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UjgGZKb7j8PoEXb5CF3cH3Dyhmo=; b=iHunue
	1mRHoVUQ9+lzbfuYeIjNWCD3jVP7E7gQ9P5xNS2qcBNike+ClEQEb6MWRpG2hnS4
	nEj9/aEhPJI1xneqTVUcdBByra6E4a7+b+OLNec0A7CF3n9EcZMe4bsHolpWWSrg
	A/I7GbdjUyuLYJzzNPixoqMiopvT7/oASiC8g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ci4hGtgqU5dAR9dfRDLoSGdVYubek7Bd
	ODPlcyEQ5fYyF70cA8VZ4uiWFXXOg5DjYC07ahn9Jfn+opml4Uxa86rBZCSvpEzJ
	GK9OHrly7rLOtyj7JUEpefAaefQEw5e/jK/fcEtMPisEX/7dBsbrNaVwwwQhZiif
	70/GleoWZBo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4ACB03E421;
	Sun, 24 Jan 2016 17:09:03 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AD85E3E41A;
	Sun, 24 Jan 2016 17:09:02 -0500 (EST)
In-Reply-To: <cover.1453632296.git.johannes.schindelin@gmx.de> (Johannes
	Schindelin's message of "Sun, 24 Jan 2016 11:48:27 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 13AC2E12-C2E7-11E5-8376-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284697>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> The crucial idea hit me yesterday when I took a step back: all
> we need to do is to ensure that the end-of-line style is matched
> when *all* input files are LF-only, or when they are all CR/LF.
> In all other cases, we have mixed line endings anyway.
>
> And to do that, it is sufficient to look at *one single line
> ending* in the context. Technically, it does not even have to be
> the context, but the first line endings of the first file would
> be enough, however it is so much more pleasant if the conflict
> marker's eol matches the one of the preceding line.

I like that approach.  My understanding of the xdiff/xmerge code is
very rusty and I have some time to re-learn it before I can judge
that the change implements that approach correctly, though X-<.

Thanks.
