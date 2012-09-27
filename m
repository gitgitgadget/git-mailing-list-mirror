From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revision: add --reflog-message to grep reflog messages
Date: Thu, 27 Sep 2012 10:09:28 -0700
Message-ID: <7v4nmjs88n.fsf@alter.siamese.dyndns.org>
References: <7va9wctwg4.fsf@alter.siamese.dyndns.org>
 <1348745786-27197-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 19:09:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THHap-0003cM-Um
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 19:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751729Ab2I0RJc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Sep 2012 13:09:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38611 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751430Ab2I0RJb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Sep 2012 13:09:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFE5C94C4;
	Thu, 27 Sep 2012 13:09:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=SS9F9TRGbx1h
	/2On+Va1X37ZQdQ=; b=AQOkrBqQ1hW6b3Az1js9SlGZME/cL87D+tlMMjLFRPMU
	m5nJJQWJn4+yym37LVz0OvY/BdFIJlH5aT7Um7bMeWBWLdnoExOeW8SYv/fZP7f7
	Tyui5MPT+Odvqq4lNCUxcrW+/7im3MZHFXuIuzFt0gw6qRF5N/i0ZvUvJSdZ7Vk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=LEqaXB
	5nPgdi79X+32J+RmFgRCFLEhOfToz2pLrpEgmS25V/tWf6qsPSXYuoMRQrTrxm0Y
	pAopkJ460vJkpEqgzgDCv+AJOV8XD72eyKR2Yx6LFCrNhoSYmOCiCF+cQVAGzGKS
	O2ib6RljN9UBQBEfCzxYyTf7lZcDp0myaCqss=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CBA0694C3;
	Thu, 27 Sep 2012 13:09:30 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 00D7394C0; Thu, 27 Sep 2012
 13:09:29 -0400 (EDT)
In-Reply-To: <1348745786-27197-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 27 Sep
 2012 18:36:26 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 199289B8-08C6-11E2-936B-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206489>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

Plase explain yourself in the space above.

> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-l=
ist-options.txt
> index 1fc2a18..aeaa58c 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -51,6 +51,11 @@ endif::git-rev-list[]
>  	commits whose author matches any of the given patterns are
>  	chosen (similarly for multiple `--committer=3D<pattern>`).
> =20
> +--reflog-message=3D<pattern>::
> +	Limit the commits output to ones with reflog entries that
> +	match the specified pattern (regular expression). Ignored unless
> +	--walk-reflogs is given.
> +

I am debating myself if it is sane for this option to have no hint
that it is about "limiting" in its name.  "--author/--committer"
don't and it is clear from the context of the command that they are
not about setting author/committer, so "--reflog-message" may be
interpreted the same, perhaps.

The entry in the context above talks about multiple occurrence of
that option. Shouldn't this new one also say what happens when it is
given twice?

> diff --git a/grep.c b/grep.c
> index 898be6e..72ac1bf 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -697,6 +697,7 @@ static struct {
>  } header_field[] =3D {
>  	{ "author ", 7 },
>  	{ "committer ", 10 },
> +	{ "reflog ", 7 },
>  };
> =20
>  static int match_one_pattern(struct grep_pat *p, char *bol, char *eo=
l,
> diff --git a/grep.h b/grep.h
> index 8a28a67..1416ad7 100644
> --- a/grep.h
> +++ b/grep.h
> @@ -29,9 +29,10 @@ enum grep_context {
> =20
>  enum grep_header_field {
>  	GREP_HEADER_AUTHOR =3D 0,
> -	GREP_HEADER_COMMITTER
> +	GREP_HEADER_COMMITTER,
> +	GREP_HEADER_REFLOG,
> +	GREP_HEADER_FIELD_MAX
>  };
> -#define GREP_HEADER_FIELD_MAX (GREP_HEADER_COMMITTER + 1)

Please add comment to ensure that FIELD_MAX stays at the end; if you
ensure that, the result is much better than the original "we know
committer is at the end so add one".

I think I wrote prep_header_patterns() and compile_grep_patterns()
carefully enough not to assume the headers are only the author and
committer names, so the various combinations i.e. all-match,
author(s), committer(s), grep(s), and reflog-message(s), should work
out of the box, but have you actually tested them?

I do not know offhand the matching side is prepared to take random
garbage fields.  IIRC, we strip the trailing timestamp from committer
and author header lines when we match, and a new code needs to be
added to control when that stripping should / should not kick in
depending on the header.

> diff --git a/revision.c b/revision.c
> index ae12e11..837051c 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1595,6 +1595,9 @@ static int handle_revision_opt(struct rev_info =
*revs, int argc, const char **arg
>  	} else if ((argcount =3D parse_long_opt("committer", argv, &optarg)=
)) {
>  		add_header_grep(revs, GREP_HEADER_COMMITTER, optarg);
>  		return argcount;
> +	} else if ((argcount =3D parse_long_opt("reflog-message", argv, &op=
targ))) {
> +		add_header_grep(revs, GREP_HEADER_REFLOG, optarg);
> +		return argcount;
>  	} else if ((argcount =3D parse_long_opt("grep", argv, &optarg))) {
>  		add_message_grep(revs, optarg);
>  		return argcount;
> @@ -2212,8 +2215,20 @@ static int commit_match(struct commit *commit,=
 struct rev_info *opt)
>  {
>  	if (!opt->grep_filter.pattern_list && !opt->grep_filter.header_list=
)
>  		return 1;
> -	return grep_buffer(&opt->grep_filter,
> -			   commit->buffer, strlen(commit->buffer));
> +	if (opt->reflog_info) {
> +		int retval;
> +		struct strbuf buf =3D STRBUF_INIT;
> +		strbuf_addstr(&buf, "reflog ");
> +		get_reflog_message(&buf, opt->reflog_info);
> +		strbuf_addch(&buf, '\n');
> +		strbuf_addstr(&buf, commit->buffer);
> +		retval =3D grep_buffer(&opt->grep_filter, buf.buf, buf.len);
> +		strbuf_release(&buf);
> +		return retval;
> +	} else {
> +		return grep_buffer(&opt->grep_filter,
> +				   commit->buffer, strlen(commit->buffer));
> +	}
>  }

This part looks familiar and smells sane ;-)
