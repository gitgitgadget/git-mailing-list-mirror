From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC] git describe without refs distinguishes dirty
 working  tree
Date: Fri, 16 Oct 2009 10:26:15 -0700
Message-ID: <7vd44nuu6g.fsf@alter.siamese.dyndns.org>
References: <dffdbd190910160812h6d6a876el8261a622b5439b30@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jean Privat <jean@pryen.org>
X-From: git-owner@vger.kernel.org Fri Oct 16 19:33:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyqgH-0006qD-Qb
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 19:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754303AbZJPR02 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 13:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932635AbZJPR0V
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 13:26:21 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47428 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754154AbZJPR0S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 13:26:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B09667AEB1;
	Fri, 16 Oct 2009 13:26:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=om5sPugObZ9vCkPam0rGqsfwqCM=; b=ujm5Br2KBK+gxlVIDHzSrDt
	AvjV7YfsIQsvb6Sej6Tlkse2QjxetjuMRfV5vpwsjc/Ir9vgVZpbtLqKHIIuDrqw
	Ux0fLQLDnxTSNv6OdDIs5Z5o2XstJ+VyClkLLOPshYcGtl9U6vCA2OVDTOut4DqT
	05Z4sMth4YFBR7LIWOXg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=hMJGn8ZlGZy0CIEaZCnyBeISSZqPld4UEv+Rrgs+C17kuTLid
	OSTpf9mPs0Y1K2yG8BKwC3U9ut+gu5EWEcTKZcYnLgvO9n9qlTQMjX2CRKHXbbBa
	6CdBVnJNT07/4yCA/KkXULGUeGNbcb0YSLLiuzib7sX/C2B/+kysMFvCHs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 936DF7AEB0;
	Fri, 16 Oct 2009 13:26:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 252017AEAE; Fri, 16 Oct 2009
 13:26:16 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 050386F8-BA79-11DE-A49F-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130513>

Jean Privat <jean@pryen.org> writes:

> ...
> This new behavior could affect existing scripts by producing version
> number like v1.0.4-14-g2414721-dirty-dirty.
> These scripts could be easily fixed by explicitly using HEAD when calling
> `git describe` and works with any version of git.
>
> Signed-off-by: Jean Privat <jean@pryen.org>
> ---
>
> Initially, I wanted to add an option `--worktree` that works on HEAD and
> appends "-dirty" when the working tree is dirty. After rethink I
> realized that users (me included) should prefer to describe the working
> tree by default, and only describe HEAD if HEAD was explicitly specified.
>
> Note that documentation of `git describe` did not mentioned the behavior
> of the command when no committish is specified.
> However, since it is still a behavior change. If the patch is accepted,
> it could target version 1.7.
> ---
>  Documentation/git-describe.txt |    5 ++++-
>  builtin-describe.c             |   18 +++++++++++++++++-
>  t/t6120-describe.sh            |    8 ++++++++
>  3 files changed, 29 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
> index b231dbb..c49ecc8 100644
> --- a/Documentation/git-describe.txt
> +++ b/Documentation/git-describe.txt
> @@ -8,7 +8,7 @@ git-describe - Show the most recent tag that is
> reachable from a commit

Here is an indication of a linewrapped and broken patch that discourages
me to look further.

As to the new _ability_, I think it would make sense to reduce the need
for an extra invocation of "is the work tree dirty" and this addition is a
welcomed one in that sense.  However, as you already are aware of, this
will break existing scripts; it should not trigger for them.

How about "describe --dirty" and "describe --dirty=-mod" (the latter
creates v1.6.5-15-gc274db7-mod"), possibly with a short version of options
if this proves to be useful and frequently used from interactive sessions?

I personally think this does not deserve to have a short option (as you
said in the log message, it is primarily a way to make up a version number
string, and give interactive users a sense of where in the history he is.
If you want to know if your tree is dirty, depending on the reason _why_
you want to know it and what you want to do with the information after
learning your tree is dirty, "status", "diff --stat", "add -i" are more
appropriate and useful tools) but you (and others) may bring up use cases
that I didn't think of when I wrote the beginning of this sentence ;-)
