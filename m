From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] diff-highlight: exit when a pipe is broken
Date: Tue, 04 Nov 2014 12:52:57 -0800
Message-ID: <xmqqtx2epu1i.fsf@gitster.dls.corp.google.com>
References: <1415131272-89441-1-git-send-email-john@szakmeister.net>
	<20141104200932.GA15149@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: John Szakmeister <john@szakmeister.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 04 21:53:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xll6A-0000vU-Ah
	for gcvg-git-2@plane.gmane.org; Tue, 04 Nov 2014 21:53:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688AbaKDUxB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2014 15:53:01 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62959 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751118AbaKDUxA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2014 15:53:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 720481BDCE;
	Tue,  4 Nov 2014 15:52:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8spV0SR5Of2t8J60vWPljr85k5Y=; b=iAH4bX
	+KnGhVSmy1giV6VRZX09cKNnHbzrn0r3PPGcObQzYVHluWrFCjwi+a0KpeqQAGS1
	GjWPCku6aSj5k4wXFecpajxx/tZCcEm2mbF/LmhqR6BBSViNUtfc/1oxEuDyIl/s
	KzXf+IzxvaUXYLv8UIyGBkpskcZ00FeqjDzLI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LPpDNiyrGbjKA3J30rVKVfkzJ8FSrUZH
	eUoU71+MGmeW+oSJYEBDdh3C7d6e5aSum7jZNyTUOPwDK2BvnavoJh8xuxzEEXHr
	+UC0Mux8AtmdWivpR+7CStNyKgG+7sUGKYILDE4pvMnsO698Px3tS9+ovOkMsZOq
	rm9eLZmWR/Y=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 695A91BDCD;
	Tue,  4 Nov 2014 15:52:59 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E3AA91BDCA;
	Tue,  4 Nov 2014 15:52:58 -0500 (EST)
In-Reply-To: <20141104200932.GA15149@peff.net> (Jeff King's message of "Tue, 4
	Nov 2014 15:09:32 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8F2B11A8-6464-11E4-8EEF-692F9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Nov 04, 2014 at 03:01:12PM -0500, John Szakmeister wrote:
>
>> While using diff-highlight with other tools, I have discovered that Python
>> ignores SIGPIPE by default.  Unfortunately, this also means that tools
>> attempting to launch a pager under Python--and don't realize this is
>> happening--means that the subprocess inherits this setting.  In this case, it
>> means diff-highlight will be launched with SIGPIPE being ignored.  Let's work
>> with those broken scripts by restoring the default SIGPIPE handler.
>> 
>> Signed-off-by: John Szakmeister <john@szakmeister.net>
>> ---
>> Incorporates feedback from Jeff King and now we just restore the default signal
>> handler using the correct case of 'DEFAULT'.
>
> Thanks, this version looks much simpler. :)
>
> Acked-by: Jeff King <peff@peff.net>

Thanks, both.  The patch looks good.  Will queue.
