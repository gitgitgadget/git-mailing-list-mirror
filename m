From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] branch: add optional parameter to -r to specify
 remote
Date: Mon, 20 Jun 2011 08:39:58 -0700
Message-ID: <7v62o0eckx.fsf@alter.siamese.dyndns.org>
References: <1308511149-10933-1-git-send-email-billiob@gmail.com>
 <1308511149-10933-2-git-send-email-billiob@gmail.com>
 <7vtyble9k8.fsf@alter.siamese.dyndns.org> <4DFEEB60.5000005@viscovery.net>
 <20110620070316.GA15246@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Boris Faure <billiob@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 20 17:40:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYga9-0004pA-1Z
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 17:40:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722Ab1FTPkD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 11:40:03 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34886 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317Ab1FTPkC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 11:40:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 68A7953B9;
	Mon, 20 Jun 2011 11:42:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OuWzn7i8ME2OeJVGMbO0uCMoDgg=; b=iTWpGY
	bfozKu0+S28RctZL17LZMs85qZ+SsrX3E2kGA9LdaNTZACZZ4C2H1e9O0AgGyQrD
	hTlFtYSKbpNI6a3nImabynwjCmlqDECBF/jIv+36cruJ6iAPAWykH3/Nyu88/b7w
	vnQKllhIbc+6ipIgOgsim6WOgoeAdP5COPbP4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dibHSmq4AstrAUsyF9A8FOXnDtT1YzNO
	gncGCPhHRs7j1aap1lNZB3YNEuEwPFOwHJNSJWWmc7Wx9ZUcqhjWxPDcc9+9zDqn
	K50uLmr/YC52e3x2hMY3lrnNh6Xs5acOycBb4T6sNCXnA7QrXDl463dYsDY9wjH8
	FKhhRIerL6w=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6221553B8;
	Mon, 20 Jun 2011 11:42:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9D74A53B7; Mon, 20 Jun 2011
 11:42:11 -0400 (EDT)
In-Reply-To: <20110620070316.GA15246@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 20 Jun 2011 03:03:16 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DD2EBE6E-9B53-11E0-A3EA-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176072>

Jeff King <peff@peff.net> writes:

> On Mon, Jun 20, 2011 at 08:40:32AM +0200, Johannes Sixt wrote:
>
>> > 	$ git branch --match "jk/*"
>> > 
>> > to show only local topic branches whose names match the given blob.
>> 
>> I would hate having to learn a new syntax '--match "jk/*"' when we can
>> already say
>> 
>>     $ git log --remotes
>>     $ git log --remotes=alice --remotes=bob
>>     $ git log --remotes="jk/*"
>> 
>> IMO, it is the right approach to have a long option --remotes with an
>> optional argument.

Yeah, it was just me being sloppy. I didn't mean to suggest a brand new
option name "--match"; I was merely saying that it should be something
that specifies filtering.  Except for the last one, if you are naming
remotes, that also would make sense.

But not the last one at least in the context of the example I gave in my
message. I wanted to see local topic branches whose names match jk/* so
using --remotes is actively wrong.

> For that matter, --match should be spelled "--glob", as we already have:
>
>   $ git log --glob='jk/*'
>
> I think having the ref-selection for "git branch" match that of the
> revision walker makes sense.

Yes, again I was just being sloppy and did not mean to introduce a brand
new --match; --glob indeed is a lot more appropriate in the examples I
gave in the message.

Here are two other examples of "listing" mode of the branch command:

	$ git branch --no-merged --glob="jc/*" pu
	$ git branch --with jc/some-topic --glob="maint-*" --glob=maint

I sometimes wish if they had such filtering.
