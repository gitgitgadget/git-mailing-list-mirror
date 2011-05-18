From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add -i: ignore terminal escape sequences
Date: Tue, 17 May 2011 22:03:03 -0700
Message-ID: <7vei3weh2w.fsf@alter.siamese.dyndns.org>
References: <05ce7ccdb3f4e07724d430f6ea2a8c9730971c9d.1305645331.git.trast@student.ethz.ch> <7vipt8fyxj.fsf@alter.siamese.dyndns.org> <BANLkTinSKFVP=VYw4PoLP=-AUbLKeGX+gQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: trast@student.ethz.ch, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 18 07:03:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMYup-0007mL-Tx
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 07:03:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046Ab1ERFDS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 01:03:18 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43529 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367Ab1ERFDP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 01:03:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 989572208;
	Wed, 18 May 2011 01:05:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b5k+D5Nc5GzI7gqo89IwzZb+XJ8=; b=ccFq5S
	DKpkgOJUuPj0YSkJP6YMvRyXGuhas9b0YFdVc1R3uZpsUfLoPqCUwO0VSW/vIMCw
	WeMoW06KG5ULXcc3FtflcBtjjI4goVNfEo6tqD1y6VI2U9sR2rNvLz5j+R/fx189
	Iy7H+FYdj6EIwKoVwJP6SlE62Ix54iB5noGOA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r0S1/DakMUBJLzluyucKMkb+34HS8Ne8
	Khyt9vLHtUL8Nq40gNuGrBt9fNsPhqhw5D5YT0xRnk/yy/MdPZlAV9Uot+z0rLDI
	wfM5XCARfXwP5Oi8g4IjEYjiBp/DLj5nt4H7nxuuOMyjG6iDH92efTSf56dmaxQn
	viEjsqULKJE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 545932207;
	Wed, 18 May 2011 01:05:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C0D172204; Wed, 18 May 2011
 01:05:12 -0400 (EDT)
In-Reply-To: <BANLkTinSKFVP=VYw4PoLP=-AUbLKeGX+gQ@mail.gmail.com> (Sverre
 Rabbelier's message of "Tue, 17 May 2011 21:37:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6C978FF2-810C-11E0-90A9-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173844>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Tue, May 17, 2011 at 20:52, Junio C Hamano <gitster@pobox.com> wrote:
>> Jokes aside, it may make sense to offer an extra confirmation for "a" and
>> possibly "s" in single-key mode. Unlike others, they are destructive when
>> the changes you are splitting from the working tree is large-ish.
>
> I don't understand why/how 's' is destructive? Doesn't it just ask you
> again for each of the split hunks?

I think "add -p" used to have an internal mechanism to merge the adjacent
split hunks back to a single hunk, so if we wanted to we could have given
users a way to recover from a mistaken "s"plit, but I don't think we kept
that code, so there is no way to properly "recover" from such a mistake.

Yes, it may be just the matter of two easy keystrokes, either yy or nn, to
recover from such a mistake, and that is why I said "possibly". It is
nevertheless destructive in the sense that you cannot recover without
quitting the current session and restarting.

Of course Thomas could have simply done "reset" and started from scratch,
so in that sense nothing is destructive, but we are not talking about the
kind of destructive operations you cannot possibly recover without typing
everything again.
