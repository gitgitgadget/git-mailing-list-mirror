From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/7] reflog: improve and update documentation
Date: Mon, 02 Mar 2015 14:04:59 -0800
Message-ID: <xmqqfv9n9htg.fsf@gitster.dls.corp.google.com>
References: <1425288597-20547-1-git-send-email-mhagger@alum.mit.edu>
	<1425288597-20547-6-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 02 23:05:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSYSh-0001Ar-FZ
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 23:05:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754172AbbCBWFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 17:05:09 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64600 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753846AbbCBWFG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2015 17:05:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1331B3DF42;
	Mon,  2 Mar 2015 17:05:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lQFk/Re3FEVsTdlZkmY9QZLNE3I=; b=LlHma+
	U+xCgD+UGX1LiSBdXtmgEY6GXQ2ayTt3NaOX1tUnBKtqrGzmr8qXZZMCGHNjHjPQ
	KD5/RFitZ/dHIR1aj4wI+ABknSmlh6XYkRV0vhhlPMnCEv0Q3LLVt9lqm3aZIVh6
	4MbVFUqYzWvsq8MHtax60zJg99rdJZSngZd38=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QaL+NSQU4Z2F04NdxDtB5SQqyQU9sE1i
	rfzF1VgumvIJ8qQy+BdRB9F+M9oP5Qx+5C1ZY6WwJaeol8HS//eBWNPdF58Udwaj
	YeIkBTfz2vmA7Wb4pRwglKsIiiT/bgZMJRNQDGd3SB17uUVI9mpil1r+irP3NNne
	zFYOK4cOYbA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0A2573DF41;
	Mon,  2 Mar 2015 17:05:06 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4C9683DF33;
	Mon,  2 Mar 2015 17:05:00 -0500 (EST)
In-Reply-To: <1425288597-20547-6-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Mon, 2 Mar 2015 10:29:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2BB3757C-C128-11E4-A27E-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264627>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> +Reference logs, or "reflogs", record when the tips of branches and
> +other references were updated in the local repository. Reflogs are
> +useful in various Git commands, to specify the old value of a
> +reference. For example, `HEAD@{2}` means "where HEAD used to be two
> +moves ago", `master@{one.week.ago}` means "where master used to point
> +to one week ago", and so on. See linkgit:gitrevisions[7] for more
> +details.

Looks very good, especially the part that mentions "in the local
repository".  It seems to be a common novice misunderstanding what
`master@{one.week.ago}` means, and it might be beneficial to be more
verbose by saying "where master used to point to one week ago in
this local repository".

> +The "expire" subcommand prunes older reflog entries. Entries older
> +than `expire` time, or entries older than `expire-unreachable` time
> +and not reachable from the current tip, are removed from the reflog.
> +This is typically not used directly by end users -- instead, see
> +linkgit:git-gc[1].
> +
> +The "delete" subcommand deletes single entries from the reflog. Its
> +argument must be an _exact_ entry (e.g. "`git reflog delete
> +master@{2}`").

Just like "expire", "delete" should be accompanied by the same
"typically not".  I do not think it is even worth mentioning that it
exists merely as an implementation detail for likgit:git-stash[1]
and for no other reason.


> +Options for `expire` and/or `delete`
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

I think this started from a hope that these two share many, but
looking at the result I notice the shared ones are a tiny and
trivial minority.  It probably makes sense to retitle this section
"Options for expire" (and remove "For the expire command only"), and
add an "Options for delete" section immediately after it that looks
like:

	Options for `delete`
        ~~~~~~~~~~~~~~~~~~~~

	--updateref::
        --rewrite::
        --dry-run::
        	The `delete` command takes these options whose
                meanings are the same as those for `expire`.

> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index 49c64f9..dd68a72 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -13,9 +13,9 @@
>   */
>  
>  static const char reflog_expire_usage[] =
> -"git reflog expire [--verbose] [--dry-run] [--stale-fix] [--expire=<time>] [--expire-unreachable=<time>] [--all] <refs>...";
> +"git reflog expire [--expire=<time>] [--expire-unreachable=<time>] [--rewrite] [--updateref] [--stale-fix] [--dry-run | -n] [--verbose] [--all] <refs>...";
>  static const char reflog_delete_usage[] =
> -"git reflog delete [--verbose] [--dry-run] [--rewrite] [--updateref] <refs>...";
> +"git reflog delete [--rewrite] [--updateref] [--dry-run | -n] [--verbose] <refs>...";
>  
>  static unsigned long default_reflog_expire;
>  static unsigned long default_reflog_expire_unreachable;

Thanks for being complete, but I sense that it may be time we
switched to parse-options here, which gives us the help string for
free.  Perhaps throw in a comment line before this hunk

	/* NEEDSWORK: switch to parse-options */

or something to leave hint for other people?

Thanks.
