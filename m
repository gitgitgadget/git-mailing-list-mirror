From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Reachability lists in git
Date: Tue, 18 Nov 2014 13:22:26 -0800
Message-ID: <xmqq1tp0uru5.fsf@gitster.dls.corp.google.com>
References: <xmqqa93ousme.fsf@gitster.dls.corp.google.com>
	<Pine.LNX.4.44L0.1411181610070.2918-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>, <git@vger.kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
X-From: git-owner@vger.kernel.org Tue Nov 18 22:22:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqqEY-0006lK-D9
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 22:22:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbaKRVWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 16:22:42 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58582 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932075AbaKRVWl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 16:22:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0577F1FB31;
	Tue, 18 Nov 2014 16:22:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Joyor9j1KY1TuJgRowYvK8DW0k8=; b=MM6y+s
	ygoOGxrZ4CHyUDHj40/Z58eswX7FrVi6PAszpJISS1XIhfT3MiSTI95ZlzLtQXkr
	olNDTYQkx+ijr2TIuP9RfVQBZGaglgzrCjQMVZn6oHiMsnsYrJLIejwz8MmM/M9X
	3CZnM6cJr5Kmmhr3fWtrDRbZk2+782M5z40bk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jjVj8MJGFtRpsH6LdwGoG63hpzU2ran1
	gW34cMYgJsrQOznhZdytwrzsFc+obHICuUTksN7ApeT1ayh8MyhRpbXHzOZ9cw91
	EPV8Kir9NWP0bd4KK55bf865isN/u8zEwaSsi5t9P4A8sZcmvvK2cfPt5ciYN5rr
	dAhoym8h0oI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EF3FF1FB30;
	Tue, 18 Nov 2014 16:22:42 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9F6221FB28;
	Tue, 18 Nov 2014 16:22:29 -0500 (EST)
In-Reply-To: <Pine.LNX.4.44L0.1411181610070.2918-100000@iolanthe.rowland.org>
	(Alan Stern's message of "Tue, 18 Nov 2014 16:16:57 -0500 (EST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 00628DC4-6F69-11E4-977F-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> writes:

>> > No.  Here's a simple example:
>> >
>> >             Y
>> >            /
>> >           /
>> >          X--B
>> >
>> > In this diagram, X = B^.  But B isn't reachable from either X or Y, 
>> > whereas it is reachable from one of X's children (namely Y).
> ...
> Thus, if B introduced a bug, that bug would not be present in Y.  But Y 
> might be better for testing than X, because Y might fix some other 
> problems that are present in X.

The problem with that line of reasoning is that in real life there
will be unbound number of Y's that forked from a point before
somebody wrote B.  Which one among these Y's would you pick and why?

If Y has fixed another problem that is present in X and make it
easier to test, Z, a direct descendant of Y (i.e. Z^1 = Y), may have
fixed yet another problem that is unrelated to the problem B
introduced and it may make the result even easier to test.  Where do
you stop?

Still confused...
