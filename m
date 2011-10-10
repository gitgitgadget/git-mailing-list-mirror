From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: teach --gpg-sign option
Date: Mon, 10 Oct 2011 09:35:39 -0700
Message-ID: <7vehykold0.fsf@alter.siamese.dyndns.org>
References: <7vaa9f3pk8.fsf@alter.siamese.dyndns.org>
 <4E91FD57.7050808@drmicha.warpmail.net>
 <7v8votrhbr.fsf@alter.siamese.dyndns.org>
 <4E9291B6.2090201@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Oct 10 18:35:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDIpR-0002bk-Ig
	for gcvg-git-2@lo.gmane.org; Mon, 10 Oct 2011 18:35:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140Ab1JJQfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Oct 2011 12:35:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60765 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750804Ab1JJQfn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2011 12:35:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB0335166;
	Mon, 10 Oct 2011 12:35:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2wDmNp4MmALffDdqvSN/nVFdW5A=; b=wqjkwD
	Z8YsQQo0dpSPadcFk9aTF+DvCPMRBQ+ZZwVU515RoXKQhHu9gCVENS/M5eVDqRRe
	vR7gQZPLMnZKj7T/PxRN+yVELo0OzPbEMKomKjdiDCRWhL4E0pIqtUzDkCq+HsCo
	4qXtQnR0s64UflGUoc8nfUFdd79aUVeJm3W+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W0m6OIXMXco3RpHh2UXNEf3E/3wdto5i
	YrFuetia5y/KKHseKGxJwpn3TiFFjXm3xzmMhqDna1PCP3ij8OC9eNmUzwor/Vtf
	T5RhOYDyR//CiV13laZIQpbycSeOoc3RWZhYH4wdzVMTpsSplcM3+3aBvBwOmVnn
	BvE9NIG2tjM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B25445165;
	Mon, 10 Oct 2011 12:35:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 33F6D5164; Mon, 10 Oct 2011
 12:35:42 -0400 (EDT)
In-Reply-To: <4E9291B6.2090201@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Mon, 10 Oct 2011 08:33:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E518D4AE-F35D-11E0-B37C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183246>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Junio C Hamano venit, vidit, dixit 09.10.2011 23:22:
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>> 
>>> I just noticed that this format differs from the one of signed
>>> tags. What special reason is there for the "sig " indentation?
>> 
>> Read the part of the message you are quoting.
>
> I certainly did, and certainly did not find any mention. Do you think I
> would have asked otherwise? I'm trying to be helpful by testing out a
> patch in flight. That is: *I* am trying to be helpful.

Surely, sorry and thanks. I should have pointed out where I _thought_ I
spelled out the reason but apparently in an ineffective way (as my wording
did not convey what I wanted to say at least to you) a bit more clearly.

> This
>> The lines of GPG detached signature are placed in new header lines, after
>> the standard tree/parent/author/committer headers, instead of tucking the
>> signature block at the end of the commit log message text (similar to how
>> signed tag is done), for multiple reasons:
> gave me the impression that commit signatures are done "similar to how
> signed tag is done".

Yeah, sorry if that sentence parses badly.

It was trying to say:

 - the sig is in header lines
   - which is different (instead of) from tucking it at the end of text
     - by the way that "tucking at the end" would have been similar to
       signed tag

The reasons why signatures in the header is better than tucking at the end
are enumerated in the part you did not quote in this message but in the
part you did quote in the previous message.
