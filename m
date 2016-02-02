From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 10/12] ref-filter: introduce remote_ref_atom_parser()
Date: Mon, 1 Feb 2016 19:59:02 -0500
Message-ID: <20160202005902.GA1132@flurp.local>
References: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
 <1454262176-6594-11-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 01:59:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQPJe-0003hP-Pu
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 01:59:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbcBBA7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2016 19:59:12 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:33400 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973AbcBBA7L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2016 19:59:11 -0500
Received: by mail-io0-f196.google.com with SMTP id f81so13789iof.0
        for <git@vger.kernel.org>; Mon, 01 Feb 2016 16:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=32D0vrskvd261f09RS8DV1ZH0QSYeBd3fN6WMxHFeZg=;
        b=tx0mRSJXDDR8dd0kkceiCCuZSiU2IxG3jQXKIepdZz5D1SnsLtYOjBwDMOwsJh7HVf
         bJIU7bGV9Bz3bADoT9fma3NYG/1KS8QTMhk6uvLaDDB1aFMhBKY9Ku7nxKz2BGwAGhS5
         04FfyikRpp0j8vXrUyJGxvkUmPZVfCNjhxS4Je/o7ccaGcsegDKH+agKiM22TSOfyN9r
         cH0INaRx/61tsjbxuMkkkQTxiZzcV6g01dyZGxTf50FjxbpiVzRlmXQaYT7B8aauclfw
         ooFXuXYN0ah4/NTvIBLppAzsuSzMn805U+khXhxBNEmD1RpjoCYghMsnYss7giXYcHkd
         x7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=32D0vrskvd261f09RS8DV1ZH0QSYeBd3fN6WMxHFeZg=;
        b=f30uKpXLny3QKTdxb76hwS3vDJWDE/ELHktjvth+NIMChGQhYM42G4NNBau4ZcaDzY
         4zRQFjz1cO1V+crqbA/yhmgPOh6f8avuQlTVaPREk80kWxTE7vL8DTIJSTlVLXa7MOel
         lA7txZasE6zVf7h9CENo6b8M0nPzcefTcx3wy5Q8A/RrbPpr2MR9RnE0R+OjU83eVpO9
         9OGcU7IbSlMS7/r1hBaXzYlcx72HmW3QNq+jPCgu/LGxdAF+/usGGyNvaZcInI3qeiPI
         W2IEbVWQTq87cKoZEGU2XLiL4WSFlFxVxR7e1IMOgOF3wPBaVVUIz8mmbCUu4Uz3lXjJ
         WPgw==
X-Gm-Message-State: AG10YOQu7SxPdI+h/Mvt8VfJG96OvrcpxPAHFp/u91JG85U45DEsJjRdaOzKztm/tevGPg==
X-Received: by 10.107.35.65 with SMTP id j62mr17884037ioj.30.1454374746689;
        Mon, 01 Feb 2016 16:59:06 -0800 (PST)
Received: from flurp.local (user-12l3c5v.cable.mindspring.com. [69.81.176.191])
        by smtp.gmail.com with ESMTPSA id u99sm214449iou.11.2016.02.01.16.59.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 01 Feb 2016 16:59:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1454262176-6594-11-git-send-email-Karthik.188@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285230>

This is a re-send of patch 10/12 on Karthik's behalf to give other
reviewers a chance at it. The original did not make it to the mailing
list since it contained a rather large binary resource Karthik
accidentally included in the commit (which has been stripped from
this re-send).

On Sun, Jan 31, 2016 at 11:12:54PM +0530, Karthik Nayak wrote:
> Introduce remote_ref_atom_parser() which will parse the '%(upstream)'
> and '%(push)' atoms and store information into the 'used_atom'
> structure based on the modifiers used along with the corresponding
> atom.
> 
> Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
> ---
>  ref-filter.c  | 103 ++++++++++++++++++++++++++++++++++------------------------
>  test-fake-ssh | Bin 0 -> 4668264 bytes
>  2 files changed, 61 insertions(+), 42 deletions(-)
>  create mode 100755 test-fake-ssh
> 
> diff --git a/ref-filter.c b/ref-filter.c
> index 58d433f..99c152d 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -37,6 +37,8 @@ static struct used_atom {
>  	union {
>  		char color[COLOR_MAXLEN];
>  		struct align align;
> +		enum { RR_NORMAL, RR_SHORTEN, RR_TRACK, RR_TRACKSHORT }
> +			remote_ref;
>  	} u;
>  } *used_atom;
>  static int used_atom_cnt, need_tagged, need_symref;
> @@ -50,6 +52,20 @@ static void color_atom_parser(struct used_atom *atom, const char *color_value)
>  		die(_("invalid color value: %s"), atom->u.color);
>  }
>  
> +static void remote_ref_atom_parser(struct used_atom *atom, const char *arg)
> +{
> +	if (!arg) {
> +		atom->u.remote_ref = RR_NORMAL;
> +	} else if (!strcmp(arg, "short"))
> +		atom->u.remote_ref = RR_SHORTEN;
> +	else if (!strcmp(arg, "track"))
> +		atom->u.remote_ref = RR_TRACK;
> +	else if (!strcmp(arg, "trackshort"))
> +		atom->u.remote_ref = RR_TRACKSHORT;
> +	else
> +		die(_("unrecognized format: %%(%s)"), atom->name);
> +}
> +
>  static align_type parse_align_position(const char *s)
>  {
>  	if (!strcmp(s, "right"))
> @@ -132,8 +148,8 @@ static struct {
>  	{ "subject" },
>  	{ "body" },
>  	{ "contents" },
> -	{ "upstream" },
> -	{ "push" },
> +	{ "upstream", FIELD_STR, remote_ref_atom_parser },
> +	{ "push", FIELD_STR, remote_ref_atom_parser },
>  	{ "symref" },
>  	{ "flag" },
>  	{ "HEAD" },
> @@ -839,6 +855,43 @@ static const char *strip_ref_components(const char *refname, const char *nr_arg)
>  	return start;
>  }
>  
> +static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
> +				    struct branch *branch, const char **s)
> +{
> +	int num_ours, num_theirs;
> +	if (atom->u.remote_ref == RR_SHORTEN)
> +		*s = shorten_unambiguous_ref(refname, warn_ambiguous_refs);
> +	else if (atom->u.remote_ref == RR_TRACK) {
> +		if (stat_tracking_info(branch, &num_ours,
> +				       &num_theirs, NULL))
> +			return;
> +
> +		if (!num_ours && !num_theirs)
> +			*s = "";
> +		else if (!num_ours)
> +			*s = xstrfmt("[behind %d]", num_theirs);
> +		else if (!num_theirs)
> +			*s = xstrfmt("[ahead %d]", num_ours);
> +		else
> +			*s = xstrfmt("[ahead %d, behind %d]",
> +				     num_ours, num_theirs);
> +	} else if (atom->u.remote_ref == RR_TRACKSHORT) {
> +		if (stat_tracking_info(branch, &num_ours,
> +				       &num_theirs, NULL))
> +			return;
> +
> +		if (!num_ours && !num_theirs)
> +			*s = "=";
> +		else if (!num_ours)
> +			*s = "<";
> +		else if (!num_theirs)
> +			*s = ">";
> +		else
> +			*s = "<>";
> +	} else /* RR_NORMAL */
> +		*s = refname;
> +}
> +
>  /*
>   * Parse the object referred by ref, and grab needed value.
>   */
> @@ -890,8 +943,9 @@ static void populate_value(struct ref_array_item *ref)
>  			branch = branch_get(branch_name);
>  
>  			refname = branch_get_upstream(branch, NULL);
> -			if (!refname)
> -				continue;
> +			if (refname)
> +				fill_remote_ref_details(atom, refname, branch, &v->s);
> +			continue;
>  		} else if (starts_with(name, "push")) {
>  			const char *branch_name;
>  			if (!skip_prefix(ref->refname, "refs/heads/",
> @@ -902,6 +956,8 @@ static void populate_value(struct ref_array_item *ref)
>  			refname = branch_get_push(branch, NULL);
>  			if (!refname)
>  				continue;
> +			fill_remote_ref_details(atom, refname, branch, &v->s);
> +			continue;
>  		} else if (starts_with(name, "color:")) {
>  			v->s = atom->u.color;
>  			continue;
> @@ -943,7 +999,6 @@ static void populate_value(struct ref_array_item *ref)
>  
>  		formatp = strchr(name, ':');
>  		if (formatp) {
> -			int num_ours, num_theirs;
>  			const char *arg;
>  
>  			formatp++;
> @@ -952,43 +1007,7 @@ static void populate_value(struct ref_array_item *ref)
>  						      warn_ambiguous_refs);
>  			else if (skip_prefix(formatp, "strip=", &arg))
>  				refname = strip_ref_components(refname, arg);
> -			else if (!strcmp(formatp, "track") &&
> -				 (starts_with(name, "upstream") ||
> -				  starts_with(name, "push"))) {
> -
> -				if (stat_tracking_info(branch, &num_ours,
> -						       &num_theirs, NULL))
> -					continue;
> -
> -				if (!num_ours && !num_theirs)
> -					v->s = "";
> -				else if (!num_ours)
> -					v->s = xstrfmt("[behind %d]", num_theirs);
> -				else if (!num_theirs)
> -					v->s = xstrfmt("[ahead %d]", num_ours);
> -				else
> -					v->s = xstrfmt("[ahead %d, behind %d]",
> -						       num_ours, num_theirs);
> -				continue;
> -			} else if (!strcmp(formatp, "trackshort") &&
> -				   (starts_with(name, "upstream") ||
> -				    starts_with(name, "push"))) {
> -				assert(branch);
> -
> -				if (stat_tracking_info(branch, &num_ours,
> -							&num_theirs, NULL))
> -					continue;
> -
> -				if (!num_ours && !num_theirs)
> -					v->s = "=";
> -				else if (!num_ours)
> -					v->s = "<";
> -				else if (!num_theirs)
> -					v->s = ">";
> -				else
> -					v->s = "<>";
> -				continue;
> -			} else
> +			else
>  				die("unknown %.*s format %s",
>  				    (int)(formatp - name), name, formatp);
>  		}
