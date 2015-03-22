From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] strbuf: introduce strbuf_read_cmd helper
Date: Sun, 22 Mar 2015 16:40:37 -0700
Message-ID: <xmqqiodsbnyi.fsf@gitster.dls.corp.google.com>
References: <20150322095924.GA24651@peff.net>
	<20150322100724.GC11615@peff.net>
	<CAPig+cR5Ur4xOKZ6K=bOwOVM8bHHjJJXHxzCbvYBhqOTtD6dXg@mail.gmail.com>
	<xmqqwq28bq3e.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Wincent Colaiuta <win@wincent.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 00:40:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZpU4-0006JY-HE
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 00:40:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbbCVXkl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 19:40:41 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55076 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751919AbbCVXkj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 19:40:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A9B6842560;
	Sun, 22 Mar 2015 19:40:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=HqCTTSsMfjZybPShvFQ9iySzK7U=; b=pU9rG5
	jfIvFBTSDuQKPD6JkG76NHFmVtpURtyJIDfVvAHSSslxWuv7m2/GzuRUo7yp43mp
	mbRMMzaCgUg9uxpEwXVg0ES0wiXlhbHqq6hxurr/0IsxwFAWOVw9YL6el5iKzOye
	9fJ6m/cRuyCLB788G0RAY4R/ivTXapcAa4JgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e7AKZjrBMEz8AjF1hBztmGXBntwLpWST
	OmB+o+Dyyum/c0F6HdLsSTlm5R71SRRlmTjtNhAKqwLg+5FhHV8BBXteWC+jp6EY
	hcVQi3t1OBHf18gkemCYi0NFzKO6N2485loPsC3sWUHJa96gbdy5RqoSrsToHHqa
	JeGJ2GrtnD0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B2194255F;
	Sun, 22 Mar 2015 19:40:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1ABC54255E;
	Sun, 22 Mar 2015 19:40:38 -0400 (EDT)
In-Reply-To: <xmqqwq28bq3e.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Sun, 22 Mar 2015 15:54:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D7E997F8-D0EC-11E4-A738-6DD39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266109>

Junio C Hamano <gitster@pobox.com> writes:

> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> It does feel like a layering violation. If moved to the run-command
>> API, it could given one of the following names or something better:
>>
>>     run_command_capture()
>>     capture_command()
>>     command_capture()
>>     run_command_with_output()
>>     capture_output()
>
> Sound like a good suggestion (but I haven't read the users of the
> proposed function, after doing which I might change my mind---I'll
> see).

Now I read the callers, it does look like this new function better
fits in the run-command suite, essentially allowing us to do what we
would do with $(cmd) or `cmd` in shell and Perl scripts, even though
I do not particularly agree with the phrase "layering violation" to
call its current placement.

Thanks.
