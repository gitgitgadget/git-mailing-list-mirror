From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-merge: mutually match SYNOPSIS and "usage".
Date: Tue, 07 Oct 2014 11:34:41 -0700
Message-ID: <xmqq4mvfg24e.fsf@gitster.dls.corp.google.com>
References: <87wq8cnla9.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Sergey Organov <sorganov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 20:34:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbZay-0004l0-HP
	for gcvg-git-2@plane.gmane.org; Tue, 07 Oct 2014 20:34:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754920AbaJGSeo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2014 14:34:44 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56896 "EHLO sasl.smtp.pobox.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753242AbaJGSeo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2014 14:34:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F9C6140AE;
	Tue,  7 Oct 2014 14:34:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PYXVVHpjSnY3enbja4zQxCp+RJQ=; b=eSWbG6
	hfHNZWODL+DVdvhgt8jFhDdHNHv5jTMk6HdzDxsttX+dDGEHJRhrzGVAmBPrDiBD
	5ZaWvUcHBY3YWNxuvl7rPkKfCcWvr/dqW20TKiz7psxCCFfuDfSMxP6ioHT8eTGB
	ykBenI/wmWNNUPevTcw4tNTWBKCtNNfD4Z0Qk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v395NUc7oeVHgxfndN087ziSmEbXSbfO
	NUwGWkSA2N5ZbODsVJ2nMlSjYhcN5SBmev5cDGCHS9+RY3YS4cjtERHk28TfcpPJ
	qS7xhMyIazrIstLH7Wtkaa0hrBCUHOIUvOVdHynLVxAsNZskNq7Xn3JWGtJOYemL
	FQ1oDkK8avw=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5789A140AD;
	Tue,  7 Oct 2014 14:34:43 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9DF69140AA;
	Tue,  7 Oct 2014 14:34:42 -0400 (EDT)
In-Reply-To: <87wq8cnla9.fsf@osv.gnss.ru> (Sergey Organov's message of "Tue, 7
	Oct 2014 15:54:58 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9AA13F00-4E50-11E4-B179-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257938>

Sergey Organov <sorganov@gmail.com> writes:

> SYNOPSIS section of the git-merge manual page had outdated explicit
> list of options.
>
> "usage" returned by 'git merge -h' didn't have "-m <msg>" that is one
> of essential distinctions between obsolete invocation form and the
> recent one.
>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---

Please do not do two unrelated things in a single change.

It may be a clear and very welcome improvement to change from
"explicitly list only often used options" to "just say [options] and
have the list of options and their descriptions".

I am not sure about the other change to single out "-m <msg>",
especially marking it as optional by enclosing it inside "[-m
<msg>]", makes much sense, as that is still not very easily
distinguishable from "git merge [options] [<commit>...]".  In other
words, I agree with your motivation to call for attention that the
command behaves differently with and without "-m", but I do not
think that part of the change in this patch achieves it well.

>  Documentation/git-merge.txt | 6 ++----
>  builtin/merge.c             | 2 +-
>  2 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
> index cf2c374..e24a1d4 100644
> --- a/Documentation/git-merge.txt
> +++ b/Documentation/git-merge.txt
> @@ -9,10 +9,8 @@ git-merge - Join two or more development histories together
>  SYNOPSIS
>  --------
>  [verse]
> -'git merge' [-n] [--stat] [--no-commit] [--squash] [--[no-]edit]
> -	[-s <strategy>] [-X <strategy-option>] [-S[<key-id>]]
> -	[--[no-]rerere-autoupdate] [-m <msg>] [<commit>...]
> -'git merge' <msg> HEAD <commit>...
> +'git merge' [options] [-m <msg>] [<commit>...]
> +'git merge' [options] <msg> HEAD <commit>...
>  'git merge' --abort
>  
>  DESCRIPTION
> diff --git a/builtin/merge.c b/builtin/merge.c
> index dff043d..086502f 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -40,7 +40,7 @@ struct strategy {
>  };
>  
>  static const char * const builtin_merge_usage[] = {
> -	N_("git merge [options] [<commit>...]"),
> +	N_("git merge [options] [-m <msg>] [<commit>...]"),
>  	N_("git merge [options] <msg> HEAD <commit>"),
>  	N_("git merge --abort"),
>  	NULL
