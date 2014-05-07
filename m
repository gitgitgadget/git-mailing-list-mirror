From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Silence a bunch of format-zero-length warnings
Date: Wed, 07 May 2014 11:19:09 -0700
Message-ID: <xmqq4n11bgf6.fsf@gitster.dls.corp.google.com>
References: <1399183975-2346-1-git-send-email-felipe.contreras@gmail.com>
	<1399183975-2346-4-git-send-email-felipe.contreras@gmail.com>
	<20140504190121.GP75770@vauxhall.crustytoothpaste.net>
	<20140505052117.GC6569@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 07 20:19:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi6R5-0006M6-98
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 20:19:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbaEGSTP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 14:19:15 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58326 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750924AbaEGSTP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 14:19:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A38ED162FB;
	Wed,  7 May 2014 14:19:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TM9bFRPourdeFJBXPfWkFP2Nye0=; b=R2i4mj
	r4fjqRx2fXRrCG2VAJGEfyh3SxyL84pqWQyUGE6QjkwprpQUCdVll3haiui+GxxA
	WKv5I9YOquzoC6ifqJR7PP6tGxXytqemt4KkL9ECG0sRn28/utbu0nSIdUO322BR
	2HD9dMNiWOsmDIjfojg9GMuZQxAj3rz83S3I0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oQuQ9dEhBbBtSrRbpcp3genGJfAqzol5
	4Z8W0V9SM9chMahjApBYHWeXkO6IN8NG1kolvYWmyftz5BA3D4TGCPz2wlnPm7z7
	mo2+fMPbA+sAmDbH/Ef4yMfDWpnHoLHmzgT3xhK/kFTcOb+jLXgvHUnFGkFikj0L
	Mq+YJX4rsKY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 967E2162FA;
	Wed,  7 May 2014 14:19:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DA001162F6;
	Wed,  7 May 2014 14:19:11 -0400 (EDT)
In-Reply-To: <20140505052117.GC6569@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 5 May 2014 01:21:17 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 16A89900-D614-11E3-8BE9-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248343>

Jeff King <peff@peff.net> writes:

> On Sun, May 04, 2014 at 07:01:22PM +0000, brian m. carlson wrote:
>
>> On Sun, May 04, 2014 at 01:12:55AM -0500, Felipe Contreras wrote:
>> > This is in gcc 4.9.0:
>> > 
>> >   wt-status.c: In function ‘wt_status_print_unmerged_header’:
>> >   wt-status.c:191:2: warning: zero-length gnu_printf format string [-Wformat-zero-length]
>> >     status_printf_ln(s, c, "");
>> >     ^
>> > 
>> > We could pass -Wno-format-zero-length, but it seems compiler-specific
>> > flags are frowned upon, so let's just avoid the warning altogether.
>> 
>> I believe these warnings existed before GCC 4.9 as well, but I'm not
>> opposed to the change.
>
> Yeah, this started last summer when we added __attribute__((format)) to
> the status_printf_ln calls, and I posted essentially the same patch.  We
> kind of waffled between "eh, just set -Wno-format-zero-length" and doing
> something, and ended up at the former. I'd be fine with doing it this
> way; we're not likely to add a lot of new callsites that would make it a
> hassle to keep up with.

OK, so I'll take it as your Ack ;-)
