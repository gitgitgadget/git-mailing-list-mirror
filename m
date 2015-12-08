From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2015, #02; Fri, 4)
Date: Mon, 07 Dec 2015 16:24:30 -0800
Message-ID: <xmqqegexlrcx.fsf@gitster.mtv.corp.google.com>
References: <xmqqa8pprej5.fsf@gitster.mtv.corp.google.com>
	<CAOc6etZBnB6EKiD3xD-zp-QJz20ueQzdtdJMSZz6wOH_HFZXxw@mail.gmail.com>
	<20151207204630.GD30203@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Edmundo Carmona Antoranz <eantoranz@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 08 01:24:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a665F-0003ov-Fl
	for gcvg-git-2@plane.gmane.org; Tue, 08 Dec 2015 01:24:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754807AbbLHAYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 19:24:41 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59744 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751881AbbLHAYk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 19:24:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AFA2B321D2;
	Mon,  7 Dec 2015 19:24:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ANQLpESaXau603YbLvu4TXPffDE=; b=Lna+BZ
	FBmiLix1R2i1Ko/oGwT90moVORpPcJMeI6x2DjYwklqCKiqPUEIzKS55btLKtyiJ
	ZC7VQe+47D347v0ayPGiLk70W36IifgRAHaXlNx/ATPOp5tCfRqIkh97Nx3N0ryC
	Lt60IYrTI/HaoZsWvp/sTLP0cDSbkG4u2/GJk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Uxy3cpuuC3PMrz4SKGwxasYIsqAB5pVR
	KCoyRCt1j/GXp1zq/GjUQxxqcskqE/2rKzC3buYqRB0mZUaOuIz7we/5YX2jYjuw
	EIxfox6legWx4l/DReyLgLIRaR+8cUFrYNcHMvIFlAqOcQ2c/7LG7KCo4HeBjkpI
	HFnj6fvYUqo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A6E9D321D1;
	Mon,  7 Dec 2015 19:24:39 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2C3F9321D0;
	Mon,  7 Dec 2015 19:24:39 -0500 (EST)
In-Reply-To: <20151207204630.GD30203@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 7 Dec 2015 15:46:30 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1183D9DE-9D42-11E5-9F2F-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282142>

Jeff King <peff@peff.net> writes:

> On Sun, Dec 06, 2015 at 10:12:18AM -0600, Edmundo Carmona Antoranz wrote:
>
>> Hi, Junio, Jeff!
>> 
>> On Fri, Dec 4, 2015 at 5:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> > * ec/annotate-deleted (2015-11-20) 1 commit
>> >  - annotate: skip checking working tree if a revision is provided
>> >
>> >  Usability fix for annotate-specific "<file> <rev>" syntax with deleted
>> >  files.
>> >
>> >  Waiting for review.
>> 
>> Is there something I have to do about it?
>
> A gentle ping is sometimes helpful. :)
>
> I did not see anything wrong with it, but I think Junio would be a good
> person to give it a look, as he knows all of the sordid history of blame
> versus annotate, and the intended allowed command-line orderings.

If you bring "intended allowed command-line orderings" into the
picture, then I would have to say that any effort that encourages
the use of paths before revs like this patch does should be frowned
upon---if anything, we should actively discouraging people from
feeding paths before revs, and this change goes in a wrong direction
by adding a special case only to annotate, giving another excuse to
people who think "git log path rev" should work "because annotate
does".

If the change is just to 'annotate path rev', and does not change
'blame path rev', it would be less distasteful, though.

I'd have to think about it.
