From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] upload-pack: keep poll(2)'s timeout to -1
Date: Fri, 22 Aug 2014 11:26:51 -0700
Message-ID: <xmqqsikonzx0.fsf@gitster.dls.corp.google.com>
References: <20140822151911.GA8531@debian> <20140822154445.GA19135@peff.net>
	<xmqqr408plgj.fsf@gitster.dls.corp.google.com>
	<20140822160334.GA20789@peff.net> <20140822162711.GA8598@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Edward Thomson <ethomson@edwardthomson.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 20:27:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKtYN-0005dQ-K1
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 20:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932780AbaHVS1E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 14:27:04 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64648 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932410AbaHVS1C (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 14:27:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AAB0932CDD;
	Fri, 22 Aug 2014 14:27:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t2KmQRlrRs4yMC/qV4GGR0hWD7Y=; b=uV25TI
	UISBWFse3V8rKuddfWb3t7O8PaIATrE44BECPj61wbSfJr5PQedMskpWMz3ARCiL
	zLrjVGY5jh7iWWnl3mmQfa6VEk2x9FDl1yQ2BJJgBOXzFTTkuHwoBd5occcc1UzR
	bDR0KAHqBuroLk1QJQzYF/VfC57CD6/ZGB0Jo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hNtlJ+mVWgQewRc3paiJeh9xXqurr+v0
	ESwAiXFIFx4MZes5W22mjSixxaAnO0cr7JdrQyaTroIwuNi/OUoVmdeO283ocfzw
	S9m9Zmk+XGeb2160NlEl8Kix7VjrptLSTYxc454NYaCMCFGfabNm/R//fqt+ly2i
	i9fqVVHRAmU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 823BC32CDC;
	Fri, 22 Aug 2014 14:27:01 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4FC4E32CD3;
	Fri, 22 Aug 2014 14:26:53 -0400 (EDT)
In-Reply-To: <20140822162711.GA8598@debian> (Edward Thomson's message of "Fri,
	22 Aug 2014 16:27:11 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E3E44798-2A29-11E4-96E6-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255690>

Edward Thomson <ethomson@edwardthomson.com> writes:

> On Fri, Aug 22, 2014 at 12:03:34PM -0400, Jeff King wrote:
>> 
>> Yeah, I wasn't thinking we would get negative values from the user (we
>> don't document them at all), but we should probably do something
>> sensible. Let's just leave it at Ed's patch.
>
> Thanks, both.  Apologies for the dumb question: is there anything
> additional that I need to do (repost with your Acked-by, for example)
> or is this adequate as-is?

I've picked it up and queued it on 'pu'.  Thanks.

commit 6c71f8b0d3d39beffe050f92f33a25dc30dffca3
Author: Edward Thomson <ethomson@edwardthomson.com>
Date:   Fri Aug 22 15:19:11 2014 +0000

    upload-pack: keep poll(2)'s timeout to -1
    
    Keep poll's timeout at -1 when uploadpack.keepalive = 0, instead of
    setting it to -1000, since some pedantic old systems (eg HP-UX) and
    the gnulib compat/poll will treat only -1 as the valid value for
    an infinite timeout.
    
    Signed-off-by: Edward Thomson <ethomson@microsoft.com>
    Acked-by: Jeff King <peff@peff.net>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
