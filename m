From: Junio C Hamano <gitster@pobox.com>
Subject: Re: am fails to apply patches for files with CRLF lineendings
Date: Mon, 14 Dec 2009 18:12:02 -0800
Message-ID: <7vfx7d7zpp.fsf@alter.siamese.dyndns.org>
References: <20091214183337.GA25462@atjola.homenet>
 <7vvdg9i9mn.fsf@alter.siamese.dyndns.org>
 <tCQlJn153g8Oa6Z9HKe6xOUQJdcf2PCIVthlTrLgYE-wJ5jFyXVXWw@cipher.nrlssc.navy.mil> <7vhbrtdtth.fsf@alter.siamese.dyndns.org> <ee63ef30912141650ie05baf4kab8505adf160c62e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	jk@silentcow.com, git@vger.kernel.org
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 03:12:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKMtx-0003ph-Go
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 03:12:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758888AbZLOCMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 21:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758943AbZLOCMX
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 21:12:23 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43782 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758888AbZLOCMS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 21:12:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D655BA66DA;
	Mon, 14 Dec 2009 21:12:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xs+WxsQ0DXlBA+XcAOUKe7bCL3g=; b=DJ47qR
	1lvhew8Q0nOkzWIi848kUWfSZ6zUuE+904SzTI3DD51ViH7lIDy6FRGr0VF8v94z
	mJz4bAxQMWkeBFNL7Ms+ep0RNrzVGGcrWZZHTrOHABUqrbFq+mo9zooLd0fud3Ve
	EGOCT89AkO39W3/NFLgO+7Q/q88D7SQBkS1ew=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qAujbxKdKMq3mpnflbc2oSsOMJBgkJTF
	qhlDLcqWPatIFHgV/9c8ZMINxvjzubn7iQ1puY1siWIaBT3ZIvQgqYzR7Dvx9qw8
	tFDDbjd+WSRNVWis2XH4BEvV46rOlmIJv+e2jhtIOWCUj9kt09BBOlu0TXu+gCuw
	JrmtP7oZZlk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 88972A66D1;
	Mon, 14 Dec 2009 21:12:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5A14BA66CE; Mon, 14 Dec 2009
 21:12:03 -0500 (EST)
In-Reply-To: <ee63ef30912141650ie05baf4kab8505adf160c62e@mail.gmail.com>
 (Brandon Casey's message of "Mon\, 14 Dec 2009 18\:50\:44 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 41342CC0-E91F-11DE-936D-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135262>

Brandon Casey <drafnel@gmail.com> writes:

>> It actually is the norm to use LF as the line terminator in the body text
>> in saved messages (and trailing CR as a true part of the payload), and
>> "am" traditionally used that definition.  It is meant to read from "mbox"
>> format to begin with.
>
> But isn't each email in the mbox file supposed to be RFC-2822 formatted
> anyway?

If you are talking about the same "mbox" I was talking about, which is
what I see when I peek "/var/mail/junio", then the answer is no.  Their
lines are terminated with a LF, and if you insert CR at the end of the
line it would appear as true payload.  DOSsy boxes can have C:\mail\user
or whatever that has DOS text, of course, so there is no "supposed to be".

Having said that, it does not matter an iota in the real world if somebody
declares on _this list_ that it a bug that Thunderbird spits out CRLF text
in response to "Save As..."  on platforms where LF is the natural line
terminator [*1*].  Whether it is a bug or not, we still need to help
people with such a program without breaking others.

I saw "peeking the line ending of the first line" as suggested as a
solution, and my gut feeling, without thinking too much about it, is
that it is likely to be the right thing to do, especially if we do
both the check and the necessary conversion in either mailinfo or even
in mailsplit.


[Footnote]

*1* It is a different matter if it was done on _their_ mailing list, and
it would even be better if such a discussion on _their_ mailing list
resulted in a fix over there.
