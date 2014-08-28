From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] resolved deltas
Date: Thu, 28 Aug 2014 16:14:01 -0700
Message-ID: <xmqq1ts08ax2.fsf@gitster.dls.corp.google.com>
References: <53F5D98F.4040700@redhat.com> <53F79CE3.60803@gmx.net>
	<53F868F8.9080000@web.de> <20140823105640.GA6881@peff.net>
	<20140823110459.GA13087@peff.net> <20140823111804.GA17335@peff.net>
	<53FB66D1.709@web.de> <20140828220821.GA31545@peff.net>
	<20140828222227.GA30879@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Shawn Pearce <spearce@spearce.org>,
	Martin von Gagern <Martin.vGagern@gmx.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 29 01:14:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XN8tb-0003yo-0y
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 01:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647AbaH1XON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 19:14:13 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54149 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750894AbaH1XON (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2014 19:14:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5268535240;
	Thu, 28 Aug 2014 19:14:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZTkAxs1tLZmri7TGeOGyhUgO2QI=; b=LwXQJx
	r5kBlV+wfUuM6ggA4qNzUom7HhfUZySjpAmGc2GsqyZ3tvwiSk8GZCwRngGcyBQe
	8SpWaljF+spfl00gYxKF3IMS38X/xOkJYNnG9Jh2wclCYmGno96cpBsfzKU0wbk/
	yYE7uwrSKSXva5VxfRxuXCS7AsH5JLYC5bHw0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C3b0TFedYC14uUbIBYEuZu9y2dEqDQRJ
	UuQfVeR1knhtljo/tBMtyVE9qSAxqjhzcYvteU5KeyQjA/jjFVCwvUyWYWHpQayU
	TlC91ZX0LQgAJJO5rxAV+noShe84ZFYw9DAiDPElUxIwSUz609U7KN40YVUkyIG8
	1WGtwTOYRy0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4549E3523E;
	Thu, 28 Aug 2014 19:14:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BDCB43522D;
	Thu, 28 Aug 2014 19:14:02 -0400 (EDT)
In-Reply-To: <20140828222227.GA30879@peff.net> (Jeff King's message of "Thu,
	28 Aug 2014 18:22:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FFEC78F0-2F08-11E4-BFEA-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256133>

Jeff King <peff@peff.net> writes:

> On Thu, Aug 28, 2014 at 06:08:21PM -0400, Jeff King wrote:
>
>> Interesting. I couldn't convince Helgrind to catch such a case...
>
> Ugh. It helps if you actually helgrind the git binary, and not the
> shell-script from bin-wrappers. I can easily replicate the problem now.
> The patch I just posted seems to fix it (at least it has been running in
> a loop for over a minute with no failures, whereas before it took only a
> few seconds to provoke a failure).

Thanks for digging.  I'll pick it up and may comment on it in
tomorrow's cycle (it is a bit too late for today's cycle,
unfortunately).
