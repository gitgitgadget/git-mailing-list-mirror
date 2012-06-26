From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] i18n: mark outputs of mode changes for i18n
Date: Tue, 26 Jun 2012 14:38:58 -0700
Message-ID: <7vsjdhah3h.fsf@alter.siamese.dyndns.org>
References: <1340734910-7180-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pclouds@gmail.com, git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 23:39:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjdTg-0008Uy-IH
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 23:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753025Ab2FZVjD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 17:39:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44641 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750893Ab2FZVjB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 17:39:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 19DBD97E4;
	Tue, 26 Jun 2012 17:39:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x+KizZhYBirDKT/Sa/a2wnUkBbI=; b=ZBblY9
	+8tc8+5OiVL6vthfRDtn8Zg7JGWo/4Aoh09zUJnyOSS5mBmupl/9+N0UHH4mU8ZR
	QxmHY7ZYqh8ywlQ0BJVk7YSAisNyynT13juLEgNOal4x+w0NY5JaYJl2j/KycCLN
	wh2YBIjQELO1KAgiB7RDx2VC7kt/HNrKmIp2E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dY2IojVzX/HvXnSo+Rrf429Qg37jbwY6
	sRDmk5RAx/8gf5aeAIFvq87iPnqPS3bqXOtG4vBHAeU+uIb2MMvIyRDt4oPoTMzA
	JZFl7jPDIDuR5ks/ysrAnlqfOPY4qJH9phE6aoY4S9qdUAg6DYaopV9RmTZvvr+h
	BI3EAuQ26tM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0FCDC97E3;
	Tue, 26 Jun 2012 17:39:01 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 693D997E2; Tue, 26 Jun 2012
 17:39:00 -0400 (EDT)
In-Reply-To: <1340734910-7180-1-git-send-email-ralf.thielow@gmail.com> (Ralf
 Thielow's message of "Tue, 26 Jun 2012 20:21:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 577BA4D6-BFD7-11E1-9658-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200686>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> diff --git a/diff.c b/diff.c
> index 1a594df..25fcb6f 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2264,21 +2264,21 @@ static void builtin_diff(const char *name_a,
>  	strbuf_addf(&header, "%s%sdiff --git %s %s%s\n", line_prefix, set, a_one, b_two, reset);
>  	if (lbl[0][0] == '/') {
>  		/* /dev/null */
> -		strbuf_addf(&header, "%s%snew file mode %06o%s\n", line_prefix, set, two->mode, reset);
> +		strbuf_addf(&header, "%s%s%s %06o%s\n", line_prefix, set, _("new file mode"), two->mode, reset);
>  		if (xfrm_msg)
>  			strbuf_addstr(&header, xfrm_msg);
>  		must_show_header = 1;
>  	}
>  	else if (lbl[1][0] == '/') {
> -		strbuf_addf(&header, "%s%sdeleted file mode %06o%s\n", line_prefix, set, one->mode, reset);
> +		strbuf_addf(&header, "%s%s%s %06o%s\n", line_prefix, set, _("deleted file mode"), one->mode, reset);
>  		if (xfrm_msg)
>  			strbuf_addstr(&header, xfrm_msg);
>  		must_show_header = 1;
>  	}
>  	else {
>  		if (one->mode != two->mode) {
> -			strbuf_addf(&header, "%s%sold mode %06o%s\n", line_prefix, set, one->mode, reset);
> -			strbuf_addf(&header, "%s%snew mode %06o%s\n", line_prefix, set, two->mode, reset);
> +			strbuf_addf(&header, "%s%s%s %06o%s\n", line_prefix, set, _("old mode"), one->mode, reset);
> +			strbuf_addf(&header, "%s%s%s %06o%s\n", line_prefix, set, _("new mode"), two->mode, reset);
>  			must_show_header = 1;
>  		}
>  		if (xfrm_msg)
> @@ -4130,7 +4130,7 @@ static void show_mode_change(FILE *file, struct diff_filepair *p, int show_name,
>  		const char *line_prefix)
>  {
>  	if (p->one->mode && p->two->mode && p->one->mode != p->two->mode) {
> -		fprintf(file, "%s mode change %06o => %06o%c", line_prefix, p->one->mode,
> +		fprintf(file, _("%s mode change %06o => %06o%c"), line_prefix, p->one->mode,
>  			p->two->mode, show_name ? ' ' : '\n');
>  		if (show_name) {
>  			write_name_quoted(p->two->path, file, '\n');

I do not see how it makes sense to do this alone, among many other
metainfo lines that are not marked for translation.

More importantly, these lines are not for human consumption but for
machine parsing (see builtin/apply.c:parse_git_header() function).
