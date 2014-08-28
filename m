From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] teach fast-export an --anonymize option
Date: Thu, 28 Aug 2014 11:11:47 -0700
Message-ID: <xmqqwq9sa3h8.fsf@gitster.dls.corp.google.com>
References: <20140827165854.GC1432@peff.net> <20140827170127.GA6138@peff.net>
	<CACsJy8B3gFC7kLf-cLhAk3BgQ+v427rMXWHTqjU4LYP3NQte7Q@mail.gmail.com>
	<20140828123257.GA18642@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 28 20:12:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XN4B0-0004Tt-Su
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 20:12:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848AbaH1SL6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 14:11:58 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61249 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750892AbaH1SL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2014 14:11:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 965723525A;
	Thu, 28 Aug 2014 14:11:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sGVICMM0e1V/Lh1DETQYeKYQ+E8=; b=Z0HuIe
	sx2qdJO+ENt1xV2zgZGsvNUm5qOForwbfpcuOVjOpeBfG1Sb0khsmpmuqYoZTUC1
	ukC7IJeAGvXg+bV4i7n7UtAkVOZx7zdGefcnNjieFUAG8zebnR7aUPpJPhyOOYXS
	Zd8hiQ0wBiBcmEJe08Ztn/2u0iQ5t4oDHwdRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BVErLTvdgWUquCWvLnOu58dLKOIoeGQR
	FmsZO/jcXOsJvEcNgotTGwaFTG+Q7FS0i+GKqPOCoN1bBUt+yGDa8UTM9lvDgNiM
	kAiGgpYAsCyWrLwkYVi9oCsEh9Z8UU0HD2+k9JV8+jWqFkSxpxISZScP7vjLuIZc
	wZ2KN41LeIc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8D75935258;
	Thu, 28 Aug 2014 14:11:57 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 62FC03524E;
	Thu, 28 Aug 2014 14:11:49 -0400 (EDT)
In-Reply-To: <20140828123257.GA18642@peff.net> (Jeff King's message of "Thu,
	28 Aug 2014 08:32:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C797AC56-2EDE-11E4-89AC-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256110>

Jeff King <peff@peff.net> writes:

> Subject: docs/fast-export: explain --anonymize more completely
>
> The original commit made mention of this option, but not why
> one might want it or how they might use it. Let's try to be
> a little more thorough, and also explain how to confirm that
> the output really is anonymous.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Documentation/git-fast-export.txt | 63 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 59 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
> index 52831fa..dbe9a46 100644
> --- a/Documentation/git-fast-export.txt
> +++ b/Documentation/git-fast-export.txt
> @@ -106,10 +106,9 @@ marks the same across runs.
>  	different from the commit's first parent).
>  
>  --anonymize::
> -	Replace all refnames, paths, blob contents, commit and tag
> -	messages, names, and email addresses in the output with
> -	anonymized data, while still retaining the shape of history and
> -	of the stored tree.
> +	Anonymize the contents of the repository while still retaining
> +	the shape of the history and stored tree.  See the section on
> +	`ANONYMIZING` below.

Technically s/tree/trees/, I would think.  For a repository with
multiple branches, perhaps s/history/histories/, too, but I would
not insist on that ;-).

> +ANONYMIZING
> +-----------
> +
> +If the `--anonymize` option is given, git will attempt to remove all
> +identifying information from the repository while still retaining enough
> +of the original tree and history patterns to reproduce some bugs. The
> +goal is that a git bug which is found on a private repository will
> +persist in the anonymized repository, and the latter can be shared with
> +git developers to help solve the bug.
> +
> +With this option, git will replace all refnames, paths, blob contents,
> +commit and tag messages, names, and email addresses in the output with
> +anonymized data.  Two instances of the same string will be replaced
> +equivalently (e.g., two commits with the same author will have the same
> +anonymized author in the output, but bear no resemblance to the original
> +author string). The relationship between commits, branches, and tags is
> +retained, as well as the commit timestamps (but the commit messages and
> +refnames bear no resemblance to the originals). The relative makeup of
> +the tree is retained (e.g., if you have a root tree with 10 files and 3
> +trees, so will the output), but their names and the contents of the
> +files will be replaced.

While I do not think I or anybody who would ask other people to use
this option would be confused, the phrase "the same string" may risk
unnecessary worries from those who are asked to trust this option.

I am not yet convinced that it is unlikely for the reader to read
the above and imagine that the anonymiser may go word by word,
replacing "the same string" with the same anonymised gibberish
(which would be susceptible to old-school cryptoanalysis
techniques).

Among the ones that listed, refnames, blob contents, commit messages
and tag messages are converted as a single "string" and I wish I
could think of phrasing to stress that point somehow.

Each path component in paths is converted as a single "string", so
we can read from two anonymised paths if they refer to blobs in the
same directory in the original.  This is a good thing, of course,
but it shows that among those listed in "refnames, paths, blob
contents, ..." in a flat sentence, some are treated as a single
token for replacement but not others, and it is hard to tell for a
reader which one is which, unless the reader knows the internals of
Git, i.e. what kind of things we as the debuggers-of-Git would want
to preserve.

Isn't the unit for human identity anonymisation even more coarse?
If it is not should it?

In other words, do "Junio C Hamano <junio@pobox.com>" and "Junio C
Hamano <gitster@pobox.com>" map to one gibberish human readable name
with two gibberish e-mail addresses, or 2 "User$n <user$n>"?  Is the
fact that this organization seems to allocate two e-mails to each
developer something this organization may want to hide from the
public (and something we as the Git debuggers would not benefit from
knowing)?
