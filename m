From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] commit: give a hint when a commit message has been
 abandoned
Date: Mon, 23 Jul 2012 14:00:19 -0700
Message-ID: <7vr4s2jiqk.fsf@alter.siamese.dyndns.org>
References: <20120723184634.GA31905@sigill.intra.peff.net>
 <20120723185218.GC27588@sigill.intra.peff.net>
 <7vzk6qjj7w.fsf@alter.siamese.dyndns.org>
 <20120723205209.GA6745@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramana Kumar <ramana@member.fsf.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 23 23:00:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StPjv-00037f-Oq
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 23:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754759Ab2GWVAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 17:00:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54216 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754536Ab2GWVAV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 17:00:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C9C07C2D;
	Mon, 23 Jul 2012 17:00:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VnNz6p9Fex/jeQ1YBeulV/leX4M=; b=wCSIP/
	72qVF4QIIXPzCY3NjYKXq/3ad6zhx5XV8giuNMZ+nLX/c+e5SsWkIzBB1XWCpmJl
	VCOS4wbL5U5bjWRR1zhLkN0IvgH1Hxe/atieFrFbTi5UbdSxlFS4BgJQSwjaOil0
	vEnKeEG1BowniojvkR+smZHF3HDeM3atgrq/o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cJ7XE5klJlU0nEbReTeeVFc6Jb0mLRss
	oZEObEIyxrHwMFk9H90ezx7/2S9XCJ+ZERxhOj6KT5KuQKqHsuSbDyUgVFdy+yp3
	/btOJl9i8qmBn+1d8Z3Vwxwu83/06ZjB28KDFqicdlpsb+mNl89f5IFjvlg2lnKN
	VEuzZYHXvoE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A6637C2C;
	Mon, 23 Jul 2012 17:00:21 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E7607C2B; Mon, 23 Jul 2012
 17:00:20 -0400 (EDT)
In-Reply-To: <20120723205209.GA6745@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 23 Jul 2012 16:52:09 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 69D1C43E-D509-11E1-BF18-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201982>

Jeff King <peff@peff.net> writes:

> On Mon, Jul 23, 2012 at 01:49:55PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > If we launch an editor for the user to create a commit
>> > message, they may put significant work into doing so.
>> > Typically we try to check common mistakes that could cause
>> > the commit to fail early, so that we die before the user
>> > goes to the trouble.
>> >
>> > We may still experience some errors afterwards, though; in
>> > this case, the user is given no hint that their commit
>> > message has been saved. Let's tell them where it is.
>> 
>> Liberal use of atexit() for something like this makes me cringe
>> somewhat.
>
> I don't like it either, but there's not really a better way. The die()
> that Ramana triggered in the initial report is deep inside the ident
> code. The only other option would be to hook into die_routine, which I
> think is even uglier.

Then I would rather not worry about it.  A documentation update is
probably a good first step, though.
