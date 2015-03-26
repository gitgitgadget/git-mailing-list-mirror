From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V2/RFC][GSoC] diff-no-index: transform "$directory $file" args to "$directory/$file $file"
Date: Thu, 26 Mar 2015 15:58:47 -0700
Message-ID: <xmqq4mp7xt5k.fsf@gitster.dls.corp.google.com>
References: <CAHLaBN+nE9tmGMdJM65V-bONKe8CE9PZ1Ottc1R9D=Pm0X7k_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Yurii Shevtsov <ungetch@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 23:59:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbGjo-00057R-2Y
	for gcvg-git-2@plane.gmane.org; Thu, 26 Mar 2015 23:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753373AbbCZW6v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2015 18:58:51 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56957 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753333AbbCZW6u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2015 18:58:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BBC7942C97;
	Thu, 26 Mar 2015 18:58:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=K576Xw3tRQ/cxM2zzrr+KCue9Rk=; b=tmdeQ2
	t0+xWQiKC2mKQ37SDvfsihUr8aQmcZWd/V+t86tEjdgZh6N/Q6F99mCNHgv7B1Vl
	WQMrwaZcOI3LInVdl3Pi9+r3cBegSF0K2xkTSHUk0+Q3qXlJUCkfDcVucVJ5a20H
	0CaGz4u1eUhCi9UzvsSH1bZVbD9+XLXf92XG0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OnXvs4QQtEhGnSRHXTUk6Z3lxttflh/r
	gJh/iXjVjCdPPP+6C7o80UUQLhr7uMz10lrIXBGzQb734Hq4mu6nBkzA7c/zoOZ5
	e8eNLHC6sWBBub1ffpRD5eWichb8Mp2YbgA2cUahHAAA4LLPwn2FxNcC/WYCwKy1
	N3wztcH/cR8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B53ED42C96;
	Thu, 26 Mar 2015 18:58:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3CC3942C95;
	Thu, 26 Mar 2015 18:58:49 -0400 (EDT)
In-Reply-To: <CAHLaBN+nE9tmGMdJM65V-bONKe8CE9PZ1Ottc1R9D=Pm0X7k_g@mail.gmail.com>
	(Yurii Shevtsov's message of "Thu, 26 Mar 2015 22:54:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AA2AFCE0-D40B-11E4-BAF9-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266356>

Yurii Shevtsov <ungetch@gmail.com> writes:

> git diff --no-index refuses to compare if args are directory and file,
> instead of usual diff.
>
> Now git diff --no-index modifies args, if they're directory and file,
> and diffs files, as usual diff does.
>
> Changes are done in diff_no_index().
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Yurii Shevtsov <ungetch@gmail.com>
> ---
>  diff-no-index.c |   31 +++++++++++++++++++++++++++++--
>  1 files changed, 29 insertions(+), 2 deletions(-)

This round looks sensible.  Good catch to notice that POSIX wants
you to append not just the "path to the file", but the basename of
the file, to the directory name.

I didn't try your patch, but I wouldn't be surprised if it passed
the tests in the patches I wrote last night in the $gmane/266315
thread ;-).

Good luck with your GSoC application.
