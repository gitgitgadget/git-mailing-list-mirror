From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10 04/14] Refactor write_name_quoted_relative, remove unused params
Date: Thu, 16 May 2013 12:15:10 -0700
Message-ID: <7v38tm68jl.fsf@alter.siamese.dyndns.org>
References: <cover.1368696028.git.worldhello.net@gmail.com>
	<a2794488b5ec4f221ff404b4875c7c23a54492c4.1368696028.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 21:15:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud3e3-0002tW-4o
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 21:15:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752519Ab3EPTPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 15:15:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48015 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751978Ab3EPTPN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 15:15:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DAF8F1FB99;
	Thu, 16 May 2013 19:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PYpNBgir7Lpt7/A4OHtV7bgZ1UU=; b=J+nMCD
	vF4qWaTXlB8mx/XlUXXpXF3ZBney55Zi+abGegZH+3IkyN1L7m+BMV/bvFWg/cMX
	Umpob2OwR2ar4XZQWv9YRQ19fXb3nYoExMXsdGfhQMTHbdpxYyeK5bmR1s2E7vkb
	AM4Cyu+iruOmMlNAW7hO7cb8uZGquAczA5ElY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aZeaOvgOrLR5mngTcQ9D7fxkXhNNMPVM
	AsMacGg9el92ih3x3hGxBX9qCJdXet77T9NX8Q7nXZRBWnylipArMTe9xfBRLuIm
	3SlXgGTPPiJWPonXQvS2WiCCnPybpjkwJsFnIsoI8CPoIu+bT4WlmhpLDTXuR0Wn
	jb9C0F3kp5o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF02A1FB98;
	Thu, 16 May 2013 19:15:12 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 100121FB97;
	Thu, 16 May 2013 19:15:11 +0000 (UTC)
In-Reply-To: <a2794488b5ec4f221ff404b4875c7c23a54492c4.1368696028.git.worldhello.net@gmail.com>
	(Jiang Xin's message of "Thu, 16 May 2013 17:53:35 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EE6AA458-BE5C-11E2-BA01-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224611>

Jiang Xin <worldhello.net@gmail.com> writes:

> After substitude path_relative() in quote.c with relative_path() from
> path.c, parameters (such as len and prefix_len) are obsolte in function

s/obsolte/obsolete/;

> write_name_quoted_relative(). Remove unused parameters from
> write_name_quoted_relative() and related functions.
>
> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> ---
>  builtin/ls-files.c | 14 ++++++++------
>  quote.c            |  3 +--
>  quote.h            |  3 +--
>  3 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index 00f07..d3b33 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -46,10 +46,12 @@ static const char *tag_modified = "";
>  static const char *tag_skip_worktree = "";
>  static const char *tag_resolve_undo = "";
>  
> -static void write_name(const char* name, size_t len)
> +static void write_name(const char* name)

This is not a new problem but an asterisk sticks to the variable not
type, i.e. "const char *name".

>  {
> -	write_name_quoted_relative(name, len, prefix, prefix_len, stdout,
> -			line_terminator);
> +
> +	/* turn off prefix, if run with "--full-name" */
> +	write_name_quoted_relative(name, prefix_len > 0 ? prefix : NULL,
> +				   stdout, line_terminator);
>  }

Are you sure all the callers pass a NUL terminated name and want to
show them in full (not just a prefix by passing a len that is
shorter than the string is)?

My quick scan indicates that is the case, but double checking.

The same comment applies to 03/14 (I checked that all callers either
pass strlen() of the first parameter or -1, so that patch is safe).

>  static void show_dir_entry(const char *tag, struct dir_entry *ent)
> @@ -63,7 +65,7 @@ static void show_dir_entry(const char *tag, struct dir_entry *ent)
>  		return;
>  
>  	fputs(tag, stdout);
> -	write_name(ent->name, ent->len);
> +	write_name(ent->name);
>  }
>  
>  static void show_other_files(struct dir_struct *dir)
> @@ -163,7 +165,7 @@ static void show_ce_entry(const char *tag, struct cache_entry *ce)
>  		       find_unique_abbrev(ce->sha1,abbrev),
>  		       ce_stage(ce));
>  	}
> -	write_name(ce->name, ce_namelen(ce));
> +	write_name(ce->name);
>  	if (debug_mode) {
>  		printf("  ctime: %d:%d\n", ce->ce_ctime.sec, ce->ce_ctime.nsec);
>  		printf("  mtime: %d:%d\n", ce->ce_mtime.sec, ce->ce_mtime.nsec);
> @@ -196,7 +198,7 @@ static void show_ru_info(void)
>  			printf("%s%06o %s %d\t", tag_resolve_undo, ui->mode[i],
>  			       find_unique_abbrev(ui->sha1[i], abbrev),
>  			       i + 1);
> -			write_name(path, len);
> +			write_name(path);
>  		}
>  	}
>  }
> diff --git a/quote.c b/quote.c
> index ebb8..5c880 100644
> --- a/quote.c
> +++ b/quote.c
> @@ -312,8 +312,7 @@ void write_name_quotedpfx(const char *pfx, size_t pfxlen,
>  	fputc(terminator, fp);
>  }
>  
> -void write_name_quoted_relative(const char *name, size_t len,
> -				const char *prefix, size_t prefix_len,
> +void write_name_quoted_relative(const char *name, const char *prefix,
>  				FILE *fp, int terminator)
>  {
>  	struct strbuf sb = STRBUF_INIT;
> diff --git a/quote.h b/quote.h
> index 5610159..ed110 100644
> --- a/quote.h
> +++ b/quote.h
> @@ -60,8 +60,7 @@ extern void quote_two_c_style(struct strbuf *, const char *, const char *, int);
>  extern void write_name_quoted(const char *name, FILE *, int terminator);
>  extern void write_name_quotedpfx(const char *pfx, size_t pfxlen,
>                                   const char *name, FILE *, int terminator);
> -extern void write_name_quoted_relative(const char *name, size_t len,
> -		const char *prefix, size_t prefix_len,
> +extern void write_name_quoted_relative(const char *name, const char *prefix,
>  		FILE *fp, int terminator);
>  
>  /* quote path as relative to the given prefix */
