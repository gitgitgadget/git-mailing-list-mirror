From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] git-shortlog.txt: make SYNOPSIS match log, update OPTIONS
Date: Sun, 21 Apr 2013 00:04:10 -0700
Message-ID: <7vppxowej9.fsf@alter.siamese.dyndns.org>
References: <1366458313-7186-1-git-send-email-artagnon@gmail.com>
	<1366458313-7186-6-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 09:04:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UToJu-00011A-Nj
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 09:04:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752003Ab3DUHEO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 03:04:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43627 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751776Ab3DUHEN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 03:04:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB6D5138D7;
	Sun, 21 Apr 2013 07:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8VIDYC4WBM9iSqBjdULBe5WnSRQ=; b=hneIRa
	uKPv/kyHFpPNT/WR5fvX7moZ4rhprNWmNZtM5DhjAZUMEHz7zg2pAylIEHc253Xc
	yV4IOQxi9PYIDIr7n7jxQiSbbnqLM1pRHB0TyStWU3scwnez/z+G23ZxPHsSaNmb
	yOAPotfOFo8X8UwOMDtnrap/tw4ZgNJuGCzxw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u6Da1G1I1xxsMcgR7LM6YwY98VjljQCk
	AXyoZmhysqeOwDuHy1eAS+gn2JZdm9VWJ8Y3AmT9szJF71JepTK1jYo75a9DUkA+
	Ub9DMCBislQqlxcsNxPNp9+NHqCMpQMC6QvbQzRsM0V21sjzstrtjN3eILeNDRZW
	V+woW151jE4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B41E9138D6;
	Sun, 21 Apr 2013 07:04:12 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 498BC138D2;
	Sun, 21 Apr 2013 07:04:12 +0000 (UTC)
In-Reply-To: <1366458313-7186-6-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Sat, 20 Apr 2013 17:15:13 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ABA152F8-AA51-11E2-8C01-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221900>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> +<since>..<until>::
> +	Consider only commits between the named two revisions.  When
> +	either <since> or <until> is omitted, it defaults to `HEAD`,
> +	i.e. the tip of the current branch.  For a more complete list
> +	of ways to spell <since>..<until>, see
> +	linkgit:gitrevisions[7].
> +

The same "revision range" comment, and also that this should be
after all options and before "-- <pathspec>", apply to this.

> @@ -56,6 +63,16 @@ OPTIONS
>  If width is `0` (zero) then indent the lines of the output without wrapping
>  them.
>  
> +[\--] <path>...::
> +	Consider only commits that are enough to explain how the files
> +	that match the specified paths came to be.  See "History
> +	Simplification" below for details and other simplification
> +	modes.
> ++
> +Paths may need to be prefixed with "\-- " to separate them from
> +options or revisions, when confusion arises.
> +
> +include::rev-list-options.txt[]

While it is true that this page is missing many options, including
rev-list-options.txt as-is is more harmful than helpful and the
patch needs more work (hint: with "ifdef::git-shortlog[]" sprinkled
in rev-list-options.txt).

Some of the earlier one in rev-list-options are fine, but some
others are inappropriate in the context of shortlog.  For example,
--grep=<pattern>, while it would internally work as it is told to
do, is unlikely to be clear how well/correctly worked when viewing
the end result.  So are many others, such as --all-match,
--walk-reflogs, --sparse, etc.  Some e.g. --topo-order, do not make
sense at all.

I am not sure what the command would do if you give --stdin; the
command wants to read from the standard input to operate as a filter
for "git log" output, but the "--stdin" from rev-list family wants
to read revision range specifiers from the standard input.  I do not
think it is something any sane user would want to do.
