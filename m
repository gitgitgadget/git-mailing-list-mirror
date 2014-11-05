From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] use child_process_init() to initialize struct child_process variables
Date: Tue, 04 Nov 2014 16:32:06 -0800
Message-ID: <xmqqvbmuo5bt.fsf@gitster.dls.corp.google.com>
References: <xmqqlhnyy9e2.fsf@gitster.dls.corp.google.com>
	<20141030213523.GA21017@peff.net>
	<FEC7DC4C920D4F97B5F165B10BC564D2@PhilipOakley>
	<xmqqvbmzsyfy.fsf@gitster.dls.corp.google.com>
	<20141101033327.GA8307@peff.net>
	<F44397C122BB4E63B89EC9BE26007B2E@PhilipOakley>
	<xmqqmw88rvh3.fsf@gitster.dls.corp.google.com>
	<20141103220408.GA12462@peff.net>
	<xmqq389zrguw.fsf@gitster.dls.corp.google.com>
	<xmqq4muepr40.fsf@gitster.dls.corp.google.com>
	<20141104233215.GA16091@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Philip Oakley <philipoakley@iee.org>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 05 01:32:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XloWG-0001kc-Hz
	for gcvg-git-2@plane.gmane.org; Wed, 05 Nov 2014 01:32:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbaKEAcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2014 19:32:12 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50665 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751792AbaKEAcL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2014 19:32:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 482BE1BE5B;
	Tue,  4 Nov 2014 19:32:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2xGFFZYsq+aNyxhNik9TbST50Kc=; b=yAFg6t
	OhMjbrtSqf//Cgzu7Mn8jniOppllCvtt2sJOAVa97Fu2r49yS2HxdzgW3bO2GUO0
	UAgeBOf6la25a/TI8Y+D959enj9bFySY3gOIQr8gqG9nfJRFMeInVufFMd7+ezbT
	4LDYqJVzf34Vfhf/znZiFlVhwCNtghFU94nrU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nfl1lzBXtLtisZELykxnQJE0nenUmxGI
	8z/I7bSMKC7o4pvOo/iS839WmbtJJMGjQX35/YBn2ZOQC86Adv6rNMP6uobYBOpY
	3Thn7lgvelqZuusrAXrvVlJZz+a7SObypI+HK4CT1tV3G47nzg7GWmsPX6JZL4S9
	ng8F76DeH3w=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3FA1D1BE58;
	Tue,  4 Nov 2014 19:32:09 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C3EC41BE57;
	Tue,  4 Nov 2014 19:32:08 -0500 (EST)
In-Reply-To: <20141104233215.GA16091@peff.net> (Jeff King's message of "Tue, 4
	Nov 2014 18:32:15 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2D19DA5C-6483-11E4-A2B8-692F9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The bundle code is not bound by this historical legacy, and could do it
> in a different (and more efficient and flexible) way. But it is probably
> saner to just keep them identical. It makes the code simpler, and having
> bundle as the only transport which has the extra flexibility does not
> really buy us much (and probably just invites confusion).

Yeah, so let's have only symref=HEAD:refs/heads/master for now.

I would like to have the protocol update on the on-wire side during
2015 to lift various limits and correct inefficiencies (the largest
of which is the "who speaks first" issue).  We should make sure that
the bundle format can be enhanced to match when it happens.

Thanks.
