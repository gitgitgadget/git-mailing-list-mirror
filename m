From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 18/18] fsck: git receive-pack: support excluding objects  from fsck'ing
Date: Wed, 21 Jan 2015 01:02:47 -0800
Message-ID: <xmqq8ugwy094.fsf@gitster.dls.corp.google.com>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
	<cover.1421682369.git.johannes.schindelin@gmx.de>
	<dd54b4dc097f18bb3427ec6408e71ad65efd08a1.1421682369.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 21 10:02:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDrBg-0007tg-15
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 10:02:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752115AbbAUJCw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 04:02:52 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56975 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750918AbbAUJCt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 04:02:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E213E26B4F;
	Wed, 21 Jan 2015 04:02:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/sX1og5IWx+1SICog8q3UQPjQ9E=; b=tOKvIj
	f1HkL3cYwxE7TGDZIBAOJ67CUNxY284+2wiJkIyOajX2OdVSMuJIm6cZ4zbZq2at
	R7WGpx3dIQ0NeSinF2Ax0kdkZV9NkpqQTS7VKEJu6t4nt4C6omvS1+W16YeVKZdP
	12QgV/SEeB2HNTj0K39eT0HyV9T9ZLZkWx7G8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pxHnLPPCoopgDAfDKFURg/TOxjyVAvi3
	uOIhH+ht1Aey9A+HlA0QqBKgwBuWjvitAOsJf65weV5oOI9C3ywijr6067HsIyfo
	eMxRZGPYg8RtIBFm88KihAP2Erda38dY15NSFR+rhmZ/D/JpIFJ8pk332ggEiZEn
	KYzM+ZEmXjI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D968326B4E;
	Wed, 21 Jan 2015 04:02:48 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5DADB26B4D;
	Wed, 21 Jan 2015 04:02:48 -0500 (EST)
In-Reply-To: <dd54b4dc097f18bb3427ec6408e71ad65efd08a1.1421682369.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Mon, 19 Jan 2015 16:52:06 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4585A930-A14C-11E4-98B7-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262720>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> The optional new config option `receive.fsck.skiplist` specifies the path
> to a file listing the names, i.e. SHA-1s, one per line, of objects that
> are to be ignored by `git receive-pack` when `receive.fsckObjects = true`.

Makes sense, but I wonder if it makes sense to have a similar "ok to
be broken" list for "git fsck" (or perhaps they could even use the
same list) for exactly the same reason why this option makes sense.
