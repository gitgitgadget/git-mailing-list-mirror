From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 03/15] user-manual: Use 'remote add' to setup push
 URLs
Date: Sun, 10 Feb 2013 14:45:59 -0800
Message-ID: <7vsj53rdnc.fsf@alter.siamese.dyndns.org>
References: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
 <cover.1360508415.git.wking@tremily.us>
 <44d89e81a8465d3bbf50b106a8a844c9d90ac384.1360508415.git.wking@tremily.us>
 <7v8v6vua50.fsf@alter.siamese.dyndns.org>
 <20130210215442.GB8000@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Git <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Sun Feb 10 23:46:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4ffO-0006mJ-OF
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 23:46:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756935Ab3BJWqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 17:46:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53848 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756854Ab3BJWqK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 17:46:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2BD7ECD35;
	Sun, 10 Feb 2013 17:46:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=puK8IwSjBYUbsTtZIJrKF9QWFTM=; b=yMnVlW
	So1FGUVU99m5/Q87Ptj26ztHNB3Dk53rkWMEm13yHbZ7zoe6icd+pLeLl5TD583g
	bkJ6x7clBlJXoB+0a5aS5V8bALz6aoKpdCbN/XR6q/9peaudLtxfxI6TQjBxlrQF
	7TuGxNc8CkE8F8NQ3kIe1npKlaiC/JAb633x8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EVb2mSBhbCfibK8kDq38jT9/gKZ25gRi
	MZNEpMeDIYn8OImA7ffkRggUq9J8dUWRm6ubYQLMz6BbFBytBs0ll25bnaSvyqHq
	kWPZDWfrRDikkyfagCpnOpXSRfVVsUb+a5fgo5P9zovcbJqnL1uQK5+tH7POLI9W
	2jxcvlH6t6M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BF59CD34;
	Sun, 10 Feb 2013 17:46:10 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5A4E7CD15; Sun, 10 Feb 2013
 17:46:06 -0500 (EST)
In-Reply-To: <20130210215442.GB8000@odin.tremily.us> (W. Trevor King's
 message of "Sun, 10 Feb 2013 16:54:43 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A9749AD0-73D3-11E2-870C-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215962>

"W. Trevor King" <wking@tremily.us> writes:

> On Sun, Feb 10, 2013 at 01:33:31PM -0800, Junio C Hamano wrote:
>> Look at how "Fetching branches from other repositories" is done.  It
>> shows the use of "remote add" and then shows the result by running
>> "cat" to show the contents.
>> 
>> I think that organization is much nicer than completely hiding how
>> the result looks like behind another "git config --set" call, like
>> the latter half of this patch does.
>
> I think for new users, `git config …`'s opacity may a good thing

No.  Reducing the fear factor from new users by not hiding simple
things is one of the design of these tutorials, and showing that the
contents of .git/config is a simple, human-readable plain text file
is a part of it.

> I'm fine with this too, but if this is the suggested route, why bother
> with `git config` at all?  Is it just for ease of scripting?

I would actually say why bother with `git remote` at all, when you
can do that with `git config`, but arguably when a Porcelain that is
type-specific exists, use of it would make the life of end users
easier, and that is why we ended up having `git remote add`.  So if
you know how the remote configuration is implemented, you can still
use `config` to do the same, but `remote add` that futzes with many
variables at once would be easier to use for most people.
