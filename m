From: Junio C Hamano <gitster@pobox.com>
Subject: Re: New special handing of '@' character broke my use case
Date: Wed, 14 Aug 2013 13:57:18 -0700
Message-ID: <7vr4dwrnwx.fsf@alter.siamese.dyndns.org>
References: <520BC017.7050907@gmail.com>
	<7vd2pgtagc.fsf@alter.siamese.dyndns.org> <520BE468.1030808@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Aug 14 22:57:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9i8F-0004hT-Dz
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 22:57:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933223Ab3HNU5X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 16:57:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47955 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933204Ab3HNU5X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 16:57:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26E3C38B34;
	Wed, 14 Aug 2013 20:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rrepSi0gNeP+xY7wHu2OuGj9Rdc=; b=iBX7up
	CBXVG17j9eL6zGHoJ/fY3nTFqlCHMC35WGsalqGABgy/W6w3NdaBp8hfc8EwC/mr
	jAj0YFG2zWoIMr6i+doSRYf6jkqR5T3poYk9RvEivojf//ZxfE7c8BnDxIKIU7b5
	a2RkWW6SlFUZmQ2oYMKGz5Hl0JkwdGvDpErZs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IitJizZGJoF7DGe8lLnptWKPqGHT4WJb
	bu/V71t0UmByVp9wMu36RI7azyy5hcIPK/FKUil6gJZy4UvdnoGQqW1Dt8L6Gk+z
	Gj5ShlL8ymY8TIngCN9rCcOyDOLHDenc7LZ/e4BpMlJR3RNym+FFyA3Izjcumu56
	V36SPYm5ceY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 19AC138B33;
	Wed, 14 Aug 2013 20:57:22 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BCFA638B30;
	Wed, 14 Aug 2013 20:57:20 +0000 (UTC)
In-Reply-To: <520BE468.1030808@kdbg.org> (Johannes Sixt's message of "Wed, 14
	Aug 2013 22:11:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1C969C48-0524-11E3-B97C-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232314>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 14.08.2013 20:05, schrieb Junio C Hamano:
>> Stefano Lattarini <stefano.lattarini@gmail.com> writes:
>>
>>> My problems is that some new automagical interpretation of the bare
>>> @' character (introduced after 1.8.3) has destroyed my use case:
>>> ...
>>> I don't want to ask you to revert this new behaviour, but I'd like to
>>> at least have an option to disable it.
>>
>> I do not think it is simply not worth the complexity to selectively
>> disable it.  If it is a regression, it is much better to simply
>> revert, if we can (it appears that cdfd9483 (Add new @ shortcut for
>> HEAD, 2013-05-07) can be reverted without any textual context, but
>> there may already be new stuff that depends on the "@").
>>
>> For the upcoming release, I am very much tempted to revert it and
>> let the topic retried, by people who really want the "let's save
>> four keystrokes and replace it with @ aka Shift-<something>",
>> without hurting your use case (and others), after the upcoming
>> release.
>>
>> What do others think?
>
> Stefano's use-case, where @/foo is turned into HEAD/foo, indicates a bug.
>
> In my opinion, the topic, which touches a central part of ref
> handling, was a bit hurried (and this report is a symptom of it), and
> I wouldn't mind seeing it reverted.

Thanks; you said it much better than I did.  I think the short-hand
is not a bad idea by itself, but the execution may need to be redone
a bit more carefully, and it is prudent to revert it from the
upcoming release.
