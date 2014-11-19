From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFD/PATCH] add: ignore only ignored files
Date: Wed, 19 Nov 2014 13:43:52 -0800
Message-ID: <xmqqbno2rhlz.fsf@gitster.dls.corp.google.com>
References: <3f78d6c1e35c87049daaac6cb1257ea8310a90bb.1416408015.git.git@drmicha.warpmail.net>
	<20141119191502.GC9908@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 19 22:44:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrD2c-0001hP-5z
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 22:43:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756963AbaKSVn4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 16:43:56 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61100 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756953AbaKSVny (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 16:43:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0F5481EE60;
	Wed, 19 Nov 2014 16:43:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wuyluEWhgPrnGOzkpFtMpQgz828=; b=SEbBK6
	2IHK5cFzVFSSzgmmy2dGw4ZvdeUu8tRh9ClNUPGsscjA5LBQgsBwDKu5xBvpzp1P
	6jmJjTuYZalBNJsou3nj1zLKmWVnnGkX+b0NruYs4fTOfVuYM7mRDNOw7KsDcEnE
	ZRqKBvQuACLYioMTrfLm+BDWAkbXIlgzPRQDE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Nt6TgOA4MsCFq7RB6WQU7Yh3JfcWyZcR
	JDEOQu4Qp1iKtCOmxUZVIrSi/mITAOK2PM5JUd82wZytUMLumqXLttHWYW/0D06a
	b+AR9IlOM7L6fADIh2MpbSdqKwTV220VciDfe9YVUAGGI5G+iA1wPjjdg+ElyGLo
	uSoXXt+rv+s=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0593E1EE5F;
	Wed, 19 Nov 2014 16:43:54 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7BEB71EE5C;
	Wed, 19 Nov 2014 16:43:53 -0500 (EST)
In-Reply-To: <20141119191502.GC9908@peff.net> (Jeff King's message of "Wed, 19
	Nov 2014 14:15:02 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2808779A-7035-11E4-BDF6-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Typically I keep a very neat .gitignore file and just use "git add .",
> which _does_ ignore those files. The real problem here is that git
> cannot tell the difference between "the user explicitly asked for
> foo.aux, so we should complain" and "oops, foo.aux got caught in a shell
> expansion".

Yup.  I also find myself doing "git cmd -- \*.ext" to let Git, not
my shell, handle the patterns.

> I almost wonder if skipping ignored files should _always_ be a warning,
> not a hard error. I guess that has unpleasant side effects for scripts
> which call "git add XXX" and check the exit code, who may be
> unpleasantly surprised that they missed out on some content.
>
> Perhaps we could do a hybrid: add the files that were not ignored, but
> then still exit non-zero. Careful scripts need to check the exit status
> of "git add" anyway, and sloppy humans with over-broad wildcards
> typically do not care about the exit status.

;-)
