From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-import.c: always honor the filename case
Date: Mon, 03 Feb 2014 09:21:29 -0800
Message-ID: <xmqqvbwwf6xy.fsf@gitster.dls.corp.google.com>
References: <1391346784-11891-1-git-send-email-reubenhwk@gmail.com>
	<20140202230038.GB16196@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Reuben Hawkins <reubenhwk@gmail.com>, git@vger.kernel.org,
	dpotapov@gmail.com, tboegi@web.de,
	Joshua Jensen <jjensen@workspacewhiz.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 03 18:21:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WANDH-0003VM-Jh
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 18:21:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752388AbaBCRVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 12:21:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34351 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751999AbaBCRVe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 12:21:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 476F86761E;
	Mon,  3 Feb 2014 12:21:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1b06esEusOga4+uzZeEIRsKlxNM=; b=siww+U
	EC+yTRTTcpZ1tmvoSQ7u7XD3z5lmf0rgWe+8IlB04iyP0U6wHErgj5Fl+QwfRYBV
	xsCvaVFscaiZn8S62WVnZgNi7TgUWjSEpk0DvrXazmPh4kW2Hk0p3Ce1uyFYiynD
	ts4MgmxBITepDliI5zfgOJCUffTcY3BM6IylU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tYNyZfZ/xrG4qHgPSg7/V07QOV+6GbhF
	ENB+akVEEuQ09WkR7AZj2IO2QqI69UyOt2XdkWx7r0CodRzuCncEjIEvYQZolTgQ
	l8V7l5FsHqc8P7wfDyLpX1Bsg4XHfnHB6WlgDJav3zQB8Hh131RdXuuiWYoBVGBX
	tg9Z4XTVWko=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E88FA6761D;
	Mon,  3 Feb 2014 12:21:32 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 13B276761A;
	Mon,  3 Feb 2014 12:21:31 -0500 (EST)
In-Reply-To: <20140202230038.GB16196@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 2 Feb 2014 18:00:38 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A00852FA-8CF7-11E3-837D-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241440>

Jeff King <peff@peff.net> writes:

> [+cc Joshua Jensen, who wrote 50906e0]
>
> On Sun, Feb 02, 2014 at 07:13:04AM -0600, Reuben Hawkins wrote:
>
>> fast-import should not use strncmp_icase.
>
> I am not sure of that. My gut feeling is that core.ignorecase is
> completely about the _filesystem_, and that git should generally be
> case-sensitive internally.

I agree; if squashing mixed cases into a single canonical one is
desired in one use case (like Joshua described in $gmane/200597),
that should have been done as an optional feature, not by default
(ideally, it should probably be done in a filter between exporters
and the fast-import, I would think).

> [1] I am mostly trying to connect people on various sides of the
>     discussion here. So take my "gut feeling" above with a grain of
>     salt, as it does not come from experience nor thinking too hard
>     about the issue.

Thanks; that is exactly what is expected of project elders ;-)
