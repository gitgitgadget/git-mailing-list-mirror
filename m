From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] cache.h: eliminate SHA-1 deprecation warnings on OS X 10.8
Date: Sun, 12 May 2013 14:25:05 -0700
Message-ID: <7vk3n3vqku.fsf@alter.siamese.dyndns.org>
References: <1368260548-52612-1-git-send-email-davvid@gmail.com>
	<1368260548-52612-2-git-send-email-davvid@gmail.com>
	<1368260548-52612-3-git-send-email-davvid@gmail.com>
	<CAPig+cSw5-S7MDhG+5WdnLd+7PDUrSJcZJ-caXGM8JmYU6YWHw@mail.gmail.com>
	<CAJDDKr5QbrY6dFLbdZc2P5fTdLx+MPrSE+r1AAJMU4g=nrV9BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 12 23:25:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubdlb-0004bT-H1
	for gcvg-git-2@plane.gmane.org; Sun, 12 May 2013 23:25:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751841Ab3ELVZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 May 2013 17:25:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61496 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751590Ab3ELVZH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 May 2013 17:25:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5183E1E61C;
	Sun, 12 May 2013 21:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k7PSZFm/VrAvrnDcHjmFXOX6oys=; b=NCnjgy
	M9vuTlXkFJKuowzIG2dsSPrrOrnAhyGJWVDu6HXND4kMlG2GsosQx5E7/SZXabFr
	L7PyxuzT2hLjAum30X9e8x2AQ3YFaJoIQtDIVcx/wML/eorUaChlM3mmzPC7bju/
	SrkZt1Fyxc6xkHnJS9ahRCeUG7qjtbyFrChyo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kZUdnBzrrHFtxyl/p2btcEn5KgxnXFbb
	h57miP9c7jqaAELgnOij/n2TqoKQiscr9Chu25rPHtBKj2u5WlriClK0rn5GzFO+
	Nj4qpvCq4BP6erIUWppMrjt6e3CbBdVwfgTDnpqEBkX1JLpCwUi9DbENUvMz14Yv
	zPH5GkKXCtQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 48F061E61B;
	Sun, 12 May 2013 21:25:07 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BF0051E618;
	Sun, 12 May 2013 21:25:06 +0000 (UTC)
In-Reply-To: <CAJDDKr5QbrY6dFLbdZc2P5fTdLx+MPrSE+r1AAJMU4g=nrV9BA@mail.gmail.com>
	(David Aguilar's message of "Sun, 12 May 2013 13:57:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6AC6894C-BB4A-11E2-A071-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224063>

David Aguilar <davvid@gmail.com> writes:

> Yup, warnings still remain, but only in imap-send.c.  All the SHA1
> ones are gone.  Those were particularly bothersome since they affected
> several files.
>
> I haven't dug to deeply into how to fix these.  In case anyone has any
> pointers, the warnings look like this:
>
> imap-send.c: In function ‘ssl_socket_perror’:
> imap-send.c:185: warning: ‘ERR_error_string’ is deprecated (declared
> at /usr/include/openssl/err.h:279)

Hmph.

I thought your separate imap-send patch switched to CommonCrypto.
Why are you still including from /usr/include/openssl/?

By the way, is CommonCrypo anything "common"?  I am geting an
impression that it is an Apple-only thing, and if that is the case
the naming feels somewhat funny.
