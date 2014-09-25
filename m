From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Receive-pack: include entire SHA1 in nonce
Date: Thu, 25 Sep 2014 09:23:14 -0700
Message-ID: <xmqqoau3brf1.fsf@gitster.dls.corp.google.com>
References: <1411657340-62950-1-git-send-email-brian@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Thu Sep 25 18:23:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXBpC-0003Z6-8W
	for gcvg-git-2@plane.gmane.org; Thu, 25 Sep 2014 18:23:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753453AbaIYQXS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2014 12:23:18 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52731 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753183AbaIYQXR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2014 12:23:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2F4F93BA36;
	Thu, 25 Sep 2014 12:23:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tf5y7cZkeFz27NwIKbavrRJFp+Y=; b=iJF/Z+
	xtGqnoAy2X5LYMvvzxotPc8FVmlHDdHJgc1sN3Js0Vxpp5p9WuTQayMaXvEAgLHh
	cCimI4H6Kum6zoqA+n396kXOc6f0Liw8KJ5Zsh3XOqIjrUlx69NBTTwAjYQa4sPQ
	gk8TZ2l3d+T0quqczLLPkSNfzOVUJNSM3K994=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l6goUeKzbuo9mBX/mty0v9qkYXiWkbbO
	HI53ClkvNr1kyetqnlp+1t4Q+/SUF669YuJJtHN+iFhRlVZqDmwTDRi8iTuULJ3f
	KNUno48PwBTuIWEOEXTmy093qoMlYC+PnGkxOpg/WFwwYLxfCTrTv6Q3d75qoYtx
	F0QWA52j0Zw=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 13ED13BA35;
	Thu, 25 Sep 2014 12:23:17 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 13B003BA32;
	Thu, 25 Sep 2014 12:23:16 -0400 (EDT)
In-Reply-To: <1411657340-62950-1-git-send-email-brian@gernhardtsoftware.com>
	(Brian Gernhardt's message of "Thu, 25 Sep 2014 11:02:20 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 40EA08AE-44D0-11E4-B635-D931C4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257481>

Brian Gernhardt <brian@gernhardtsoftware.com> writes:

> clang gives the following warning:
>
> builtin/receive-pack.c:327:35: error: sizeof on array function
> parameter will return size of 'unsigned char *' instead of 'unsigned
> char [20]' [-Werror,-Wsizeof-array-argument]
>         git_SHA1_Update(&ctx, out, sizeof(out));
>                                          ^
> builtin/receive-pack.c:292:37: note: declared here
> static void hmac_sha1(unsigned char out[20],
>                                     ^
> ---
>
>  I dislike changing sizeof to a magic constant, but clang informs me that
>  sizeof is doing the wrong thing.

Thanks. I knew the code was wrong when I wrote it but somehow it
ended up as I wrote X-<.  Let me find a brown paper bag ;-)
