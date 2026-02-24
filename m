Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBEA1F09B3
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 23:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771977301; cv=none; b=gdLRTojDPJjIWJAr+s3TBltfyl7+KYCcbcGOtbKLZa/qdfGaD4hUfo7ksAGNveh3lJSt5nFACydP8uaDVRvNAgNnEScIlwRAje5maynUEK80dPort4vUSYkcQp3+wyMwZe+IYrg232YAoMXB3sMzqby0yUBs7mlZdjevIHFxXdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771977301; c=relaxed/simple;
	bh=k9QEa9jBgVhcuuVLN8sUUBFzFnL6VoRl51an/mXkmU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UScoGxAyRr5WxIgRxZohosCHTA/Nd8ppVoSZSSXVr+yKvnT6HZnh0wM8j1tJAdJEC1kC9cfqLrc0mGNV9uxFcBFztiGS455VsAvXgvHQ88+c6dNhomAaOLTHyDmqbTOXOApWMNf7+lQAywNkuMS4PUgkRgzxxsgkrQvjQiik+B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=MSNYCqm/; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="MSNYCqm/"
Date: Wed, 25 Feb 2026 00:54:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1771977296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WxPkGMbsMZ7i26NjzYm9gvPvktahTD3NdhXJefyUQKQ=;
	b=MSNYCqm/wSIQzZ2XMaX7mw2wjFHyikWpdiWDvP1E+2FmIfgGv9pqNQ+2+lsk5f2VU7fZRR
	DkVLJUqZrU4zVIvfst9RNWzByz18/ZRiimH65gbhNnsW5tRbQ5dkwq1U/5eACWrE8Nizds
	Xw7ouMaUAjzIrsv394zImlgpVEhwVa3d1VS2cm5D+rdmMRW/uNb6X/GwFgoF3UnNR68pl2
	1TM7aDWDRcAF5z0muZ6aulkN38OEAz8x8yxhgzv7fIfbbIUE8/BZ4vEAOrOfspsHWnk6JC
	+eYcA9Slyqb9hv24EOWZ5RVyo7Dz0goIrlNZYWlcZr/yepiHnZ88O+vUzb4/5A==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, 
	Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH v2 1/2] format-patch: add ability to use alt cover format
Message-ID: <aZ4v6p_oKCayr9A7@exploit>
X-Developer-Signature: v=1; a=openpgp-sha256; l=8545; i=mroik@delayed.space;
 h=from:subject:message-id; bh=k9QEa9jBgVhcuuVLN8sUUBFzFnL6VoRl51an/mXkmU4=;
 b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpnjpAcz+V/ZuG/beiqFXVaDJGszOIDi3epw8qE
 GfBHDe0LWaJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaZ46QAAKCRBIeX6hnBm+
 0Rz6D/9PLQqi/5fIU9OM9nvGqdlwvkAgYhHbwt6yItCFMFXx3gUmVbYiuinNwhaWiptH9sTPW/3
 p5gjjLtdVD76rp2jeMpm0Ehq/J2150g3fYu3fH1NrfuDi+2sZWD8PjaS9g5nEJAVpTdORIa3gRr
 QNNToZLhx7nFeWdc1s+HhO/VHk93akUGhLeeClOGPWYnBXIS4SvUtCR1YN+VZVIHfPMdPxBrvxN
 zY+teE+zpWYJPaIU9dz2zyxh+wmYPOsG9GDyvvIjrgZPiQCqgnyVYOUNTXNBy9DD+ERH8R0w5OF
 /HtDMgPTFVKpO4iUxruCyKmoyV+psTqalZtz0aVeu3ZnZipsqKnXgjms5wPVal2Cp37GkMKyo+c
 ftoxH/g2C3ytCAGt2gIXer5WqmvuxMXFDU0KyBcdyVxmSRd8WeDTqisILyL4JVXufYGoa4+mbdC
 akiS4T/ukwtTCpTvUr/PgCqgPrnUWxjOwe4TGywahBB0S3UB83F31evAIonxjUaVtbUapjadvG2
 TsNQI5CVE3nXXFaUPwR986RDFX3ciawSeU/0b6ozz3i9Ks/3fcUP0HgPYJ5f98GayrHpaVEeHQz
 msrpeqvDUo3QP1yyFgHCO6QcgAYUQ/tyQn6SEZ7pLGwLe/TFeZ5TWqrQX5+YaYuh0VmvfDMMEaP
 t5uxwf/TKEUrODw==
X-Developer-Key: i=mroik@delayed.space; a=openpgp;
 fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
References: <20260224040400.751247-1-mroik@delayed.space>
 <cover.1771925291.git.mroik@delayed.space>
 <66cac565f8a40f8de3dc3d857feb681bb80cb136.1771925291.git.mroik@delayed.space>
 <xmqqpl5uhwex.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpl5uhwex.fsf@gitster.g>
X-Spamd-Bar: /

On Tue, Feb 24, 2026 at 09:40:54AM -0800, Junio C Hamano wrote:
> > +				       struct commit **list, int n)
> > +{
> > +	struct strbuf commit_line = STRBUF_INIT;
> > +	struct pretty_print_context ctx = {0};
> > +
> > +	strbuf_init(&commit_line, 0);
> 
> So a single commit_line is given to repo_format_commit_message()
> repeatedly to accumulate those lines in it, which makes sense.
> 
> We prepare pretty_print_context once above and feed it repeatedly to
> repo_format_commit_message()---is that intended?  Not a rhetorical
> question; I do not know the answer.  I guess some existing callers
> (like builtin/archive.c) do reuse the structure when making multiple
> calls to the function, so this would be kosher, perhaps?

Honestly I applied Jeff change trusting his knowledge of the pretty.c
code. After taking a better look at repo_format_commit_message(), after
the pretty_print_context is passed to a format_commit_context as
pretty_ctx, it doesn't seem like this value is modified at all thoughout
the call. So it should be ok to reuse the same structure in multiple
calls of repo_format_commit_message().

> > +	for (int i = n - 1; i >= 0; i--) {
> > +		strbuf_addf(&commit_line, "[%0*d/%d] ", decimal_width(n), n - i, n);
> > +		repo_format_commit_message(the_repository, list[i], format, &commit_line, &ctx);
> 
> Let's line-wrap this overly long line (my lithmus test to complain
> about "overly long lines" is after losing three columns to the left
> for "> +" in e-mail quote like the above the right edge of the line
> does not fit on my 92-column terminal, which will never happen if
> you stick to the official "fit 80-column after quoted for a few
> times in e-mail" guideline).
> 
> 		repo_format_commit_message(the_repository, list[i], format,
> 					   &commit_line, &ctx);
> 
> perhaps.

My bad, didn't realise it went over. I'll change settings on my editor
to ensure that I can visually see it going over and do an overall coding
style check.

> > +		fprintf(cover_file, "%s\n", commit_line.buf);
> 
> I somehow would have expected that as we internally prepare "format"
> string given to this function , we ensure it ends with "\n" so we do
> not have to do a fprintf() here.

The value of format is user defined, I'm not doing any pre proccessing
to it apart from stripping the prefix. Would it be much different had I
appended a newline here? I personally think it's fine doing a fprintf
here.

> > +	strbuf_release(&commit_line);
> > +}
> > +
> >  static void make_cover_letter(struct rev_info *rev, int use_separate_file,
> >  			      struct commit *origin,
> >  			      int nr, struct commit **list,
> >  			      const char *description_file,
> >  			      const char *branch_name,
> >  			      int quiet,
> > -			      const struct format_config *cfg)
> > +			      const struct format_config *cfg,
> > +			      const char *format)
> >  {
> >  	const char *from;
> >  	struct shortlog log;
> > @@ -1342,6 +1361,8 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
> >  	struct commit *head = list[0];
> >  	char *to_free = NULL;
> >  
> > +	assert(format);
> > +
> 
> Curious.  We do not assert() for any other pointer arguments.  What
> makes this so special?

It's a leftover of code that should've been stripped. Sorry for this.

> >  	if (!cmit_fmt_is_mail(rev->commit_format))
> >  		die(_("cover letter needs email format"));
> >  
> > @@ -1377,18 +1398,22 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
> >  	free(pp.after_subject);
> >  	strbuf_release(&sb);
> >  
> > -	shortlog_init(&log);
> > -	log.wrap_lines = 1;
> > -	log.wrap = MAIL_DEFAULT_WRAP;
> > -	log.in1 = 2;
> > -	log.in2 = 4;
> > -	log.file = rev->diffopt.file;
> > -	log.groups = SHORTLOG_GROUP_AUTHOR;
> > -	shortlog_finish_setup(&log);
> > -	for (i = 0; i < nr; i++)
> > -		shortlog_add_commit(&log, list[i]);
> 
> It would have been much nicer to first create a short helper
> function generate_shortlog_cover(), move the above plus a call to
> shortlog_output(&log) to that helper function, without doing
> anything else and make it a preliminary patch [1/n].  Then introduce
> the corresponding generate_commit_list_cover() function in patch
> [2/n] (which is what this step is doing), which would have resulted
> in the body of the make_cover_letter() around here a short-and-sweet
> 
> 	if (... we are doing shortlog style ...)
> 		generate_shortlog_cover(...);
> 	else
> 		generate_commit_list_cover(...);
> 
> Just like readers of _this_ function are helped by not having to
> know the details of what happens inside commit-list style cover
> generation, they can concentratre on the flow without having to care
> about details on shortlog side that way.

Yes, it does read nicer. Will do.

> > @@ -1906,6 +1931,7 @@ int cmd_format_patch(int argc,
> >  	int just_numbers = 0;
> >  	int ignore_if_in_upstream = 0;
> >  	int cover_letter = -1;
> > +	char *cover_letter_fmt = NULL;
> >  	int boundary_count = 0;
> >  	int no_binary_diff = 0;
> >  	int zero_commit = 0;
> > @@ -1952,6 +1978,8 @@ int cmd_format_patch(int argc,
> >  			    N_("print patches to standard out")),
> >  		OPT_BOOL(0, "cover-letter", &cover_letter,
> >  			    N_("generate a cover letter")),
> > +		OPT_STRING(0, "cover-letter-format", &cover_letter_fmt, N_("format-spec"),
> > +			    N_("format spec used for the commit list in the cover letter")),
> >  		OPT_BOOL(0, "numbered-files", &just_numbers,
> >  			    N_("use simple number sequence for output file names")),
> >  		OPT_STRING(0, "suffix", &fmt_patch_suffix, N_("sfx"),
> > @@ -2289,13 +2317,14 @@ int cmd_format_patch(int argc,
> >  		/* nothing to do */
> >  		goto done;
> >  	total = list.nr;
> > +
> 
> What is this churn about?

This is introducing "--cover-letter-format"

> >  	if (cover_letter == -1) {
> >  		if (cfg.config_cover_letter == COVER_AUTO)
> > -			cover_letter = (total > 1);
> > +			cover_letter = total > 1;
> 
> What is this churn about?
> 
> >  		else if ((idiff_prev.nr || rdiff_prev) && (total > 1))
> > -			cover_letter = (cfg.config_cover_letter != COVER_OFF);
> > +			cover_letter = cfg.config_cover_letter != COVER_OFF;
> 
> What is this churn about?
> 
> >  		else
> > -			cover_letter = (cfg.config_cover_letter == COVER_ON);
> > +			cover_letter = cfg.config_cover_letter == COVER_ON;
> 
> What is this churn about?
> 
> Please do not distract reviewers by mixing immaterial "style fixes"
> on existing code to a patch whose primary purpose is to introduce
> new code.  A separate "preliminary fix and/or clean-up" patch before
> the main series begins is often a welcome addition, though.

This was not inteded. Is the result of me copy-pasting and then
restoring when I changed my mind on having the format spec be passed
through "--cover-letter".

Sorry for the unnecessary noise, will restore.

> > @@ -2375,12 +2404,16 @@ int cmd_format_patch(int argc,
> >  	}
> >  	rev.numbered_files = just_numbers;
> >  	rev.patch_suffix = fmt_patch_suffix;
> > +
> > +	if (cover_letter && !cover_letter_fmt)
> > +		cover_letter_fmt = "shortlog";
> > +
> 
> I do not quite see the point of doing this.  There is no law that
> "cover_letter_fmt != NULL" is a crime when cover_letter is false.
> 
> cover_letter_fmt can be initialized to a fixed string "shortlog",
> and nobody cares what random value cover_letter_fmt has when
> cover_letter is false.

Indeed, was the first thing that came to mind at the time. Had I had
reread a few more times before sending I probably wouldn't have left it
like this.

I'll try to take my time with the next version as to not waste your time
on unnecessary initialization trivialities.

> >  	if (cover_letter) {
> >  		if (cfg.thread)
> >  			gen_message_id(&rev, "cover");
> >  		make_cover_letter(&rev, !!output_directory,
> >  				  origin, list.nr, list.items,
> > -				  description_file, branch_name, quiet, &cfg);
> > +				  description_file, branch_name, quiet, &cfg, cover_letter_fmt);
> 
> This line has become overly long.  Please wrap it.

Will do.

> New set of tests should come together with implementation of a new
> feature in the same patch.

Yes, this is something you told me about on the other patch series as
well, sorry for forgetting. Will try to include them right away next
time (along with the necessary docs update).
