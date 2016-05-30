From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to add custom metadata to Git commit object
Date: Mon, 30 May 2016 11:52:04 -0700
Message-ID: <xmqqtwhf8jl7.fsf@gitster.mtv.corp.google.com>
References: <959E96F7-0FF3-4336-B098-58836136DB08@jetbrains.com>
	<20160530183016.GB17253@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 30 20:52:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7SIQ-0000WO-MI
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 20:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161877AbcE3SwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 14:52:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63554 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161557AbcE3SwH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 14:52:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 60C9420CCE;
	Mon, 30 May 2016 14:52:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OrHUf48wgfXQGWbKSKwZM/JbYss=; b=r8UR2T
	8sUDXU7AAz08Yd1rlWcOMLkzCyxkxvqHACpfwE/nN2P9EQoj98fzUkJC/6LG/UfV
	MjrHxUOPsXaXMjLUdBYE4qyKyci6RTHQZ+gur/WtCZxVXfb7lDpJDM8pqWnYd6E/
	qjYOuJz0d0jYXH7/nu4+fcDiIHVhxKvSJMVAI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ghYhDIbgiD6Pspx5KTLk36Awi3JNkXfi
	po1pYuB8eLw6JgsJccvM865WJ9jCxf0LPDbrC/3K/niuDFnGbrXk8fYtTbPc8H+T
	zNY4K636IZyjr6AWf7TuxliUyFEpIj8Mdu7Fz5w58FfhcYhTgCZjTTMXcdrXEejG
	2sfk0QoYRhs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5A02B20CCD;
	Mon, 30 May 2016 14:52:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DB42120CCC;
	Mon, 30 May 2016 14:52:05 -0400 (EDT)
In-Reply-To: <20160530183016.GB17253@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 30 May 2016 14:30:16 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9AB91780-2697-11E6-ACD2-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295924>

Jeff King <peff@peff.net> writes:

> On Mon, May 30, 2016 at 08:58:08PM +0300, Kirill Likhodedov wrote:
> ...
>> There are git-notes, which could be used for the purpose, but they are
>> visible to the user via standard Git command, and could be used by the
>> user for other purposes, so they are not very suitable for the task.
>
> Notes would work for this, too, but their main advantage is that they
> can be created _after_ a commit has already been made (whereas anything
> in the commit object itself will influence its sha1 id).

I would have said the same but with s/but/and/.  If the "rename
hint" or whatever other "custom metadata" Kirill gives to a commit
is found to be wrong, it can be corrected later.

And "the user can use notes for other purposes" is not a good reason
to reject them.  The whole point of allowing custom notes ref is so
that Kirill is not restricted to use the usual notes/commits ref to
store this custom notes in its dedicated notes/kirills-metadata ref.
