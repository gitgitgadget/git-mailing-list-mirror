From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/3] improve symbolic-ref robustness
Date: Tue, 29 Dec 2015 13:24:42 -0800
Message-ID: <xmqqpoxpgd7p.fsf@gitster.mtv.corp.google.com>
References: <20151220072637.GA22102@sigill.intra.peff.net>
	<20151229055558.GA12848@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>, David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 22:24:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aE1lG-0006JL-J2
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 22:24:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753729AbbL2VYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 16:24:51 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60658 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752370AbbL2VYt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 16:24:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BDF1E38A1C;
	Tue, 29 Dec 2015 16:24:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eOYeTad50X4NALBhRjEqQjWibi4=; b=c6mcqg
	WecPVBS3M5sx+dd+CwJpP1hMv44/nNdC++YljkMJblpHRU6RVM0niwMwnslTHk07
	GeShDjh7keTnhiOR0p4iWlmwvnDWKQ1Eolut+Elr2FhHRo5fZI7BR4bvJeuQ8Lgs
	XoMJy5Xu+BS0hbxec9wL+gu4PAjeAlfWDNyUw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eEi+wsVofP+U1rHDwiGoGr4iVQHweJUt
	r2vBFYBnxfvFiJbQou4o75iB1trJXoU14UqUIJS8zhUmAo5EUuy55o4qkX8ZwbvU
	cJAuGq7ngttDIeYUnwdK5khdM4/f53IeFeMKix6TtgWs3W33qmaa9YAzvwME3PEu
	U+fJz5JV/jQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B598038A1B;
	Tue, 29 Dec 2015 16:24:43 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3526338A1A;
	Tue, 29 Dec 2015 16:24:43 -0500 (EST)
In-Reply-To: <20151229055558.GA12848@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 29 Dec 2015 00:55:58 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 93C00468-AE72-11E5-85E8-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283149>

Jeff King <peff@peff.net> writes:

> On Sun, Dec 20, 2015 at 02:26:37AM -0500, Jeff King wrote:
>
>> I noticed that an interrupt "git symbolic-ref" will not clean up
>> "HEAD.lock". So I started this series as an attempt to convert
>> create_symref() to "struct lock_file" to get the usual tempfile cleanup.
>
> Here's version 2, based on comments from Michael. The first two patches
> were picked out separately for jk/symbolic-ref-maint, so I've dropped
> them here (so 1+2 here are the original 3+4).
>
> The other differences from v1 are:
>
>   - use "refname" instead of "ref" to match surrounding code
>
>   - drop adjust_shared_perm, as lockfile does it for us
>
>   - adjust reflog writing order (done in a new patch)
>
> The patches are:
>
>   [1/3]: create_symref: modernize variable names
>   [2/3]: create_symref: use existing ref-lock code
>   [3/3]: create_symref: write reflog while holding lock

This is queued as an early part of 'pu', and some refactoring in
David's refs-backend-lmdb topic conflicts with it when merged to
'pu'.  I think I resolved the conflicts correctly, but please double
check the result when I push it out later today.

Thanks.
