From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] http: support sending custom HTTP headers
Date: Wed, 27 Apr 2016 14:03:48 -0700
Message-ID: <xmqq4mam932j.fsf@gitster.mtv.corp.google.com>
References: <d087647975742a803735c838d0b970d962d75048.1461738362.git.johannes.schindelin@gmx.de>
	<3b71deffa5d07cf73a793773cc3d60ff611843fa.1461759454.git.johannes.schindelin@gmx.de>
	<20160427193055.GA6727@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 27 23:03:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avWcn-0004VW-1K
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 23:03:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323AbcD0VDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 17:03:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61867 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752184AbcD0VDw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 17:03:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0F58B16725;
	Wed, 27 Apr 2016 17:03:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SVaIBuPn8rLQfWE+Cp8Fg01pzPE=; b=xHHF5D
	gYiiFVElbwHiNkaKwiZ2FADx+HpBsZWv1iIMzEPNQ8gtLy6U11o2BWLuSDf5BeoC
	ql8LUOLQvj9Z8Pkn/0+jIgl4HUm4crRc2TDXQEUbCqOeCPU16cN3SUSiWoIt5vuw
	Rm5rKmXg/4dc1qDMklXK/VCVhLAKTS8Qgxw0M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MDM+OBjsd0M04LCjbmsaauqJpx+xZHW6
	SUOLDXwS+BvYShSsBlTvX/kOsTbePnq36sqpx+aiItZ+/d50KsG207TF2PeZ/kLJ
	voRpd4NiO6X+4DVOjTbIiXdVsz5KYKWG1xzA458AhMpgy+m8dLtZR8pDCcaLJIt/
	H7zNip9iP4U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 071DB16724;
	Wed, 27 Apr 2016 17:03:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6865A16723;
	Wed, 27 Apr 2016 17:03:50 -0400 (EDT)
In-Reply-To: <20160427193055.GA6727@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 27 Apr 2016 15:30:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8A8E696E-0CBB-11E6-9D60-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292825>

Jeff King <peff@peff.net> writes:

> On Wed, Apr 27, 2016 at 02:20:37PM +0200, Johannes Schindelin wrote:
>
>> The only change vs v3 is that I replaced my flimsical test by Peff's (with
>> *one* change: I realized that we need to group the Require statements in a
>> <RequireAll> block when I tried to verify that the test fails when I
>> modify the first header).
>
> Whoops, I didn't actually test that case. Thanks for catching (as you
> might guess, I wanted to make sure we handle multiple values correctly).
>
>>  Documentation/config.txt    |  6 ++++++
>>  http-push.c                 | 10 +++++-----
>>  http.c                      | 35 ++++++++++++++++++++++++++++++++---
>>  http.h                      |  1 +
>>  remote-curl.c               |  4 ++--
>>  t/lib-httpd/apache.conf     |  8 ++++++++
>>  t/t5551-http-fetch-smart.sh |  7 +++++++
>>  7 files changed, 61 insertions(+), 10 deletions(-)
>
> This version looks good to me.
>
> -Peff

Thanks, both.
