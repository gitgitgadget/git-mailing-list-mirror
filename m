From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git show doesn't work on file names with square brackets
Date: Mon, 08 Feb 2016 11:35:10 -0800
Message-ID: <xmqqpow7807l.fsf@gitster.mtv.corp.google.com>
References: <6A7D4447-AC25-4591-9DA7-CD153198EC64@jetbrains.com>
	<alpine.DEB.2.20.1602061518220.2964@virtualbox>
	<25D155FA-6F05-425C-AB2D-7F0B44E0D1C5@jetbrains.com>
	<alpine.DEB.2.20.1602061708220.2964@virtualbox>
	<CACsJy8ChZzYWXePSwF6D8vPZMuz3dQe1=jtw6rSG7M1oC+RiNw@mail.gmail.com>
	<32B9BD70-F06C-49C4-B672-24173E69B99F@jetbrains.com>
	<CACsJy8AMEgk8UXF==VmvLXsL4R67u0+U4MiUGPtO6HX0Y30oXg@mail.gmail.com>
	<20160208141552.GC27054@sigill.intra.peff.net>
	<20160208150709.GA13664@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Kirill Likhodedov <kirill.likhodedov@jetbrains.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 08 20:35:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSrai-0007OA-0i
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 20:35:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753590AbcBHTfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 14:35:16 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61535 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752912AbcBHTfM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 14:35:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 229F14158C;
	Mon,  8 Feb 2016 14:35:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tkkrmUKqLAlXTKOsPnfep7vE93A=; b=gnYOZ+
	/QXjGN2Z6Zc3ox/sGrKFNGvd64QMDOkFwDTLedcMvlDjRAghtCCUECXwPQluQaC3
	FkJ8hInLTyEmxDaSsFV9V3O6DVjQ4mPo9MeHbF3CpIiIR2sG0qKumfmsEFJ8mF7p
	7Xn7QTyv26NEcjrWp7o9i7DtfjNLbmsWPxFgc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QEkCBwL/uCn3ustH50juMZKd2qFZKgjT
	o4qd1KtsvIdd8Ewj3+l77QxAPl07L22dgQE9l07a8X33iGArfenL+QZLZmvFmwF0
	c4bB7f4NXEhL0HzGJZRXAwyvoWqUYF4TcDk47k0LVmAG7qAE2koSh3jy5BvfRDbr
	8KnIGg1QUDc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 19CD84158A;
	Mon,  8 Feb 2016 14:35:12 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9045641589;
	Mon,  8 Feb 2016 14:35:11 -0500 (EST)
In-Reply-To: <20160208150709.GA13664@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 8 Feb 2016 10:07:09 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 11A6A7CC-CE9B-11E5-9F73-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285793>

Jeff King <peff@peff.net> writes:

> The patch for that might look like this. I like it for its relative
> simplicity, though it does make the rules even harder to explain to a
> user...

True.

To be bluntly honest, I do not see the current "string containing
wildcard characters are taken as path, not rev, unless you use the
double dash to disambiguate." all bad.  Isn't it sort of crazy to
have square brackets in paths and if it requires clarification by
the user, I do not particulasrly see it as a problem.

Having said that, I do not think of a big reason to say this patch
is a wrong thing to do, either.

> This breaks the second test in t2019 added by ae454f6, but I am not sure
> that test is doing the right thing (I'm also not sure t2019 is the best
> place for these tests; I added new ones here in a separate script).

I am inclined to agree that that particular test is casting an
implementation limitation in stone.

> We can afford to be fairly slack in our parsing here. We are
> not making a real decision on "this is or is not definitely
> a revision" here, but rather just deciding whether or not
> the extra "wildcards mean pathspecs" magic kicks in.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  setup.c                      | 21 ++++++++++++++++++++-
>  t/t6133-pathspec-rev-dwim.sh | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 64 insertions(+), 1 deletion(-)
>  create mode 100755 t/t6133-pathspec-rev-dwim.sh
>
> diff --git a/setup.c b/setup.c
> index 2c4b22c..03ee4eb 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -130,6 +130,25 @@ int path_inside_repo(const char *prefix, const char *path)
>  	return 0;
>  }
>  
> +static int dwim_as_wildcard(const char *arg)
> +{
> +	const char *p;
> +
> +	if (no_wildcard(arg))
> +		return 0;
> +	if (strstr(arg, "^{"))
> +		return 0; /* probably "^{something}" */
> +	if (strstr(arg, "@{"))
> +		return 0; /* probably "ref@{something}" */
> +
> +	/* catch "tree:path", but not ":(magic)" */
> +	p = strchr(arg, ':');
> +	if (p && p[1] != '(')
> +		return 0;

You seem to reject ":(" specifically, but I am not sure whom is it
designed to help to special case ":(".  Those who write ":(top)"
would not have to disambiguate with "--", but their preference is to
spell things in longhand for more explicit control, so I do not
think they mind typing "--".  On the other hand, those who write
":/" and ":!" (":(top)" and ":(exclude)") would need to disambiguate
with "--" with the change.

That somehow feels backwards.

"A pathspec element with the magic prefix" is hard to tell from
"Look for a path in the index" but not from "Look for a path in a
tree-ish", so if you get (p && p != arg), you know it is tree:path,
I think.
