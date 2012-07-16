From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/8] git-remote-mediawiki: actually send empty comment
 when they're empty
Date: Mon, 16 Jul 2012 12:17:49 -0700
Message-ID: <7va9yz1pnm.fsf@alter.siamese.dyndns.org>
References: <1342440053-3058-1-git-send-email-Matthieu.Moy@imag.fr>
 <1342440053-3058-3-git-send-email-Matthieu.Moy@imag.fr>
 <7vd33v377x.fsf@alter.siamese.dyndns.org> <vpqr4sbv83q.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Asheesh Laroia <asheesh@asheesh.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jul 16 21:17:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sqqnt-0006SB-Si
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 21:17:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753330Ab2GPTRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 15:17:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59355 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750890Ab2GPTRw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 15:17:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B2FC18A66;
	Mon, 16 Jul 2012 15:17:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8N6xnWEgZjBWZ0lLNV/b+cx8zSI=; b=SUIVey
	0TgAqCbRgJwMJypnww6lsFYMTI3JdzArXTUiyNgR/KdqKh8Syzl63SOvJy3cMqZ9
	QVCZl2KAyh6HJxpHXAyPrWNc+OGh1XgIPXjXiDi2F0XlsTWmEB8XQY33hQd0Ig0j
	12uXOhXYUe7RnQO9AKp8NFlZx+EMb6zpz08cc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Qn+BzdRlBJUqvh/EYuY3ToWzz/6bAWvM
	oNW+kFab7odqyUgbBauLDscp2zspSgS0vJOwFk0vd8ExnKAYRBesDk+uLv5E7/+u
	N1T+lkz58DlDXCMS88mXhsTcJVmv6oWWHKy6gKvYNr82ZaMGHaXJzTpKYHhp4LaA
	/5AaMBLlqk8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A196D8A65;
	Mon, 16 Jul 2012 15:17:51 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 04AE28A64; Mon, 16 Jul 2012
 15:17:50 -0400 (EDT)
In-Reply-To: <vpqr4sbv83q.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Mon, 16 Jul 2012 21:06:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EF947B14-CF7A-11E1-AF27-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201551>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>>
>>> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>>> ---
>>>  contrib/mw-to-git/git-remote-mediawiki | 9 ++++++++-
>>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
>>> index a6ad8cf..a2da52f 100755
>>> --- a/contrib/mw-to-git/git-remote-mediawiki
>>> +++ b/contrib/mw-to-git/git-remote-mediawiki
>>> @@ -51,6 +51,9 @@ use constant EMPTY_CONTENT => "<!-- empty page -->\n";
>>>  # used to reflect file creation or deletion in diff.
>>>  use constant NULL_SHA1 => "0000000000000000000000000000000000000000";
>>>  
>>> +# Used on Git's side to reflect empty edit messages on the wiki
>>> +use constant EMPTY_MESSAGE => '*Empty MediaWiki Message*';
>>> +
>>
>> Is there a reason why this sentinel value cannot be a real empty
>> string?
>
> That would mean having an empty commit message on the Git side, which is
> against the use (although possible with fast-import).

It also is possible with "commit --allow-empty-message", no?

> (note that the string was already there, my patch only makes it a
> constant to be able to use it in two distinct places).

It was clear from the patch text without looking beyond context, but
after all I thought this was meant to be a clean-up series, and I
simply wondered why mapping empty to some magic string was not
considered to be something to be cleaned up.  That's all.

I obviously do not care that deeply either way.
