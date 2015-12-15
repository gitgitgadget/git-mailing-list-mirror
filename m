From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2015, #05; Tue, 15)
Date: Tue, 15 Dec 2015 15:36:15 -0800
Message-ID: <xmqqbn9rffo0.fsf@gitster.mtv.corp.google.com>
References: <xmqq8u4ve3at.fsf@gitster.mtv.corp.google.com>
	<20151215233207.GA30294@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 16 00:36:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8z8q-0001nP-Ds
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 00:36:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965657AbbLOXgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 18:36:19 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64659 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965649AbbLOXgS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 18:36:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5E9D133944;
	Tue, 15 Dec 2015 18:36:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vlGEUwZt6mXnOazFnQC0oNfELnU=; b=Juhn8+
	3yP4tSZuWB66fKhcnJiFBRBuRShbmLmYAMEjWE7qhqn4tlJ2S+Hy3VN3U0fdChX6
	pSYODWhR9Rp2WH4oRG7u3zkFokDidWwIJVmtAF0BT1WBUxKszqL+18DCGfOO9hKw
	4FZogswO/kLXqgASH5XW9amzYGRjOzqUSFbwU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Bb+teeLu8C8FiA2sABLRD/BF8qD0HgVM
	czeTlBRJ31N8fNU8Q5ZoGMtl+w0GcUWSALqi+YAyTYRIfCQ0AbHX4NUP9hGckpxG
	E36q15eQhcG1sktuyAF7fVDj3F4dAfjfpuJXKgiN/qHC4VUZY86UTg7RxJW9oAHC
	SyTeLV2x/E8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 56A7533943;
	Tue, 15 Dec 2015 18:36:17 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CE5F13393E;
	Tue, 15 Dec 2015 18:36:16 -0500 (EST)
In-Reply-To: <20151215233207.GA30294@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 15 Dec 2015 18:32:07 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A2E49CA4-A384-11E5-950C-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282511>

Jeff King <peff@peff.net> writes:

>> * jc/strbuf-gets (2015-10-28) 17 commits
>> [...]
>> 
>>  Teach codepaths that communicate with users by reading text files
>>  to be more lenient to editors that write CRLF-terminated lines.
>>  Note that this is only about communication with Git, like feeding
>>  list of object names from the standard input instead of from the
>>  command line, and does not involve files in the working tree.
>> 
>>  Waiting for review.
>
> I like the intent here, but I was a little disappointed that we end up
> with two almost identical strbuf functions. But even if the ultimate
> endgame is to drop back to one, the conservative route is to keep them
> both until all new code paths have "opted in" to the new behavior.
> However, I found the naming confusing: it was not at all clear to me
> which of strbuf_gets and strbuf_getline did the CRLF-munging. Perhaps
> it would be more obvious if the new one was strbuf_getline_crlf or
> something. I dunno.

There already was strbuf_getline_crlf(), and I wanted a new name to
be conservative.  It was modelled after gets() (not fgets()) that
removes the trailing line terminator, but there may have been better
names.  I dunno, either.

Thanks.
