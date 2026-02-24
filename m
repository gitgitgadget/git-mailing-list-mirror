Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB72E555
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 17:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771954860; cv=none; b=Z51Ebg/+ie7QJCPq0BN00FPaLyhFolur0OBshYQmypKC+dkF6tBTZHCAppnphSrRn3zIVVdcortkRIiwpjWBliu0PLEoD1pKoGOKijys04MUtpVsLkrA0iZ94kqdWdD/sU8EkiwbgD8UcLMTS99ikCpafrnfaBFlVAqznyy6XGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771954860; c=relaxed/simple;
	bh=r2Yp1wJ31lpRjcSHAzK0w/zbM07jWV9fzJL/cLH9yMs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MyJEo3i+U1w5bEAWGjaCSHDX0VwI9L/+7JqsbkbVbC4o9Yl4F/AdNuf2cOHO+yao16MUJAJP0MrubQBcmk6v5v25FlovpljnkseLQ0vzFDbXD+s7q7texCflBB6nf2GCLbsjpdzCSHYq/zqSr/UGfccdUs/vdpJgpukdp4KaP0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Apsj981m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bnEBsUn6; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Apsj981m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bnEBsUn6"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B18DF14001AD;
	Tue, 24 Feb 2026 12:40:56 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Tue, 24 Feb 2026 12:40:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771954856; x=1772041256; bh=oRme9PX/av
	1MVx7D39t3mq+WwTvFirF5pI1W7ONZ5iA=; b=Apsj981mshoG+e+2DVAk8iCHIe
	YsZo8vBPxKz8GnErU/0EXPWP6mM73VpnFjPRSt7s85ZDrL69DifI+fBhpf/HvICe
	z82aEAkJCY/wgTeB/PCjzZuLS/RVVPVDxQbe9+m2gwBg+h4ph4YHl2P9krLbPtD1
	4MFOQB/V0AqcV/+seqTWspHWYxcFAVqAMYhIa9FDYQLMWax15L2xFiKGF5R2TV4t
	aeIrnFkMDbxwJ4GhuLcvQbd6Ooqnidfdh5V2x/eIFPB4vbNQobhPQbdu2H59JNbp
	nV5wsJzDpCPGsy+gezdPRdl1oWeqVqxlhPvAmdcKdsj7t5wsxTmeoL3rifLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771954856; x=1772041256; bh=oRme9PX/av1MVx7D39t3mq+WwTvFirF5pI1
	W7ONZ5iA=; b=bnEBsUn61eN3eWJH682nr/ssT4oAOE72MZVQ9N6uEZFy7m95fwa
	HiW8RPMtj1OBj33M5wKBBnaG7DIcmk4j9GVy5zyi/HbQQ+zLwKXx6oL08ItRqEE8
	yIXktVWkS+o0HkJb+Q1f7wob3rAybhYjzJPZ9JCU5P4xIZcO6OvFeSLOnAdyNUQy
	BwJYu4/caYLQ2M58Y078ARMcaoHrb5aHR/3XGnXbmdMzXyEQ4tFewEm5+7u1+udJ
	PZ3EsEJBd/KUNx9DQCKLPbyoR4W7XerBkErAP/RH6GJ7Wz8yggioYZdKR+uQy75P
	UL3vjyt/gu6kkUaCdlkT9CIL7EkG+0DSJNw==
X-ME-Sender: <xms:qOKdacehl_pIa8OPmSrYhKgFpf4Tajnzrf095m5TpluKYOBSgKsi9w>
    <xme:qOKdaVNsiwYGemuBFgeHwSSBDv1eGgD656E07UTVVIYBvm9JLLMyT8no08AOYtuSY
    gBKl8LPKt4TEZsLcoBTvBuUbQPQY7flODvaGnIR_KEi7xge9Hfo>
X-ME-Received: <xmr:qOKdaSi_HVHXCxAwtP6cJaCQb755SDTR42Q-vD1gZcTw_qyPHfNWglSUBF2Rehv-xq2YdxrOiXY2YH301Q3jf8zUF2eUUPCvjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgedtjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrhhoihhk
    seguvghlrgihvggurdhsphgrtggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:qOKdaQ1iaAUdX-dYUeZBAmD6UrKCdPQAUf4Ab824L9AlOEaBcnOkfg>
    <xmx:qOKdaUijxmwqDkmy1cp9kJOBgegpbgRyWxEWg9l6TAGwJz0QaVzbtA>
    <xmx:qOKdaYeDPAwYpCw7aH2fVQ2Uowq71WTzNSWeofp4g0XZ9rliwlDlXA>
    <xmx:qOKdafldTm7KYkF-lEOfyD6cbmT9-62INX2iLypqK-ji9BAfrOcjqQ>
    <xmx:qOKdaVhqHdzCjL267wL2S_HJE6IMu9WJm3s5D8qdCJ_o0sXtckAf_bhk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 12:40:56 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] format-patch: add ability to use alt cover format
In-Reply-To: <66cac565f8a40f8de3dc3d857feb681bb80cb136.1771925291.git.mroik@delayed.space>
	(Mirko Faina's message of "Tue, 24 Feb 2026 10:29:01 +0100")
References: <20260224040400.751247-1-mroik@delayed.space>
	<cover.1771925291.git.mroik@delayed.space>
	<66cac565f8a40f8de3dc3d857feb681bb80cb136.1771925291.git.mroik@delayed.space>
Date: Tue, 24 Feb 2026 09:40:54 -0800
Message-ID: <xmqqpl5uhwex.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> Often when sending patch series there's a need to clarify to the
> reviewer what's the purpose of said series, since it might be difficult
> to understand it from reading the commits messages one by one.
>
> "git format-patch" provides the useful "--cover-letter" flag to declare
> if we want it to generate a template for us to use. By default it will
> generate a "git shortlog" of the changes, which developers find less
> useful than they'd like, mainly because the shortlog groups commits by
> author, and gives no obvious chronological order.
>
> Give the ability to format-patch to specify an alternative format spec
> through the "--cover-letter-format" option. This option either takes
> "shortlog", which is the current format, or a format spec prefixed with
> "log:".
>
> Example:
>     git format-patch --cover-letter \
>         --cover-letter-format="log:%s (%an)" HEAD~3
>
>     [1/3] this is a commit summary (Mirko Faina)
>     [2/3] this is another commit summary (Mirko Faina)
>     ...
>
> Signed-off-by: Mirko Faina <mroik@delayed.space>
> ---
>  builtin/log.c | 65 ++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 49 insertions(+), 16 deletions(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index c1cd3999a7..5e99660d7c 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1324,13 +1324,32 @@ static void get_notes_args(struct strvec *arg, struct rev_info *rev)
>  	}
>  }
>  
> +static void generate_commit_list_cover(FILE *cover_file,const char *format,

"cover_file,const" -> "cover_file, const" (missing SP).

> +				       struct commit **list, int n)
> +{
> +	struct strbuf commit_line = STRBUF_INIT;
> +	struct pretty_print_context ctx = {0};
> +
> +	strbuf_init(&commit_line, 0);

So a single commit_line is given to repo_format_commit_message()
repeatedly to accumulate those lines in it, which makes sense.

We prepare pretty_print_context once above and feed it repeatedly to
repo_format_commit_message()---is that intended?  Not a rhetorical
question; I do not know the answer.  I guess some existing callers
(like builtin/archive.c) do reuse the structure when making multiple
calls to the function, so this would be kosher, perhaps?

> +	for (int i = n - 1; i >= 0; i--) {
> +		strbuf_addf(&commit_line, "[%0*d/%d] ", decimal_width(n), n - i, n);
> +		repo_format_commit_message(the_repository, list[i], format, &commit_line, &ctx);

Let's line-wrap this overly long line (my lithmus test to complain
about "overly long lines" is after losing three columns to the left
for "> +" in e-mail quote like the above the right edge of the line
does not fit on my 92-column terminal, which will never happen if
you stick to the official "fit 80-column after quoted for a few
times in e-mail" guideline).

		repo_format_commit_message(the_repository, list[i], format,
					   &commit_line, &ctx);

perhaps.

> +		fprintf(cover_file, "%s\n", commit_line.buf);

I somehow would have expected that as we internally prepare "format"
string given to this function , we ensure it ends with "\n" so we do
not have to do a fprintf() here.

> +		strbuf_reset(&commit_line);
> +	}
> +	fprintf(cover_file, "\n");

OK, so we have a blank line after a block of one line per commit.
Sensible.

> +	strbuf_release(&commit_line);
> +}
> +
>  static void make_cover_letter(struct rev_info *rev, int use_separate_file,
>  			      struct commit *origin,
>  			      int nr, struct commit **list,
>  			      const char *description_file,
>  			      const char *branch_name,
>  			      int quiet,
> -			      const struct format_config *cfg)
> +			      const struct format_config *cfg,
> +			      const char *format)
>  {
>  	const char *from;
>  	struct shortlog log;
> @@ -1342,6 +1361,8 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
>  	struct commit *head = list[0];
>  	char *to_free = NULL;
>  
> +	assert(format);
> +

Curious.  We do not assert() for any other pointer arguments.  What
makes this so special?

>  	if (!cmit_fmt_is_mail(rev->commit_format))
>  		die(_("cover letter needs email format"));
>  
> @@ -1377,18 +1398,22 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
>  	free(pp.after_subject);
>  	strbuf_release(&sb);
>  
> -	shortlog_init(&log);
> -	log.wrap_lines = 1;
> -	log.wrap = MAIL_DEFAULT_WRAP;
> -	log.in1 = 2;
> -	log.in2 = 4;
> -	log.file = rev->diffopt.file;
> -	log.groups = SHORTLOG_GROUP_AUTHOR;
> -	shortlog_finish_setup(&log);
> -	for (i = 0; i < nr; i++)
> -		shortlog_add_commit(&log, list[i]);

It would have been much nicer to first create a short helper
function generate_shortlog_cover(), move the above plus a call to
shortlog_output(&log) to that helper function, without doing
anything else and make it a preliminary patch [1/n].  Then introduce
the corresponding generate_commit_list_cover() function in patch
[2/n] (which is what this step is doing), which would have resulted
in the body of the make_cover_letter() around here a short-and-sweet

	if (... we are doing shortlog style ...)
		generate_shortlog_cover(...);
	else
		generate_commit_list_cover(...);

Just like readers of _this_ function are helped by not having to
know the details of what happens inside commit-list style cover
generation, they can concentratre on the flow without having to care
about details on shortlog side that way.

> @@ -1906,6 +1931,7 @@ int cmd_format_patch(int argc,
>  	int just_numbers = 0;
>  	int ignore_if_in_upstream = 0;
>  	int cover_letter = -1;
> +	char *cover_letter_fmt = NULL;
>  	int boundary_count = 0;
>  	int no_binary_diff = 0;
>  	int zero_commit = 0;
> @@ -1952,6 +1978,8 @@ int cmd_format_patch(int argc,
>  			    N_("print patches to standard out")),
>  		OPT_BOOL(0, "cover-letter", &cover_letter,
>  			    N_("generate a cover letter")),
> +		OPT_STRING(0, "cover-letter-format", &cover_letter_fmt, N_("format-spec"),
> +			    N_("format spec used for the commit list in the cover letter")),
>  		OPT_BOOL(0, "numbered-files", &just_numbers,
>  			    N_("use simple number sequence for output file names")),
>  		OPT_STRING(0, "suffix", &fmt_patch_suffix, N_("sfx"),
> @@ -2289,13 +2317,14 @@ int cmd_format_patch(int argc,
>  		/* nothing to do */
>  		goto done;
>  	total = list.nr;
> +

What is this churn about?

>  	if (cover_letter == -1) {
>  		if (cfg.config_cover_letter == COVER_AUTO)
> -			cover_letter = (total > 1);
> +			cover_letter = total > 1;

What is this churn about?

>  		else if ((idiff_prev.nr || rdiff_prev) && (total > 1))
> -			cover_letter = (cfg.config_cover_letter != COVER_OFF);
> +			cover_letter = cfg.config_cover_letter != COVER_OFF;

What is this churn about?

>  		else
> -			cover_letter = (cfg.config_cover_letter == COVER_ON);
> +			cover_letter = cfg.config_cover_letter == COVER_ON;

What is this churn about?

Please do not distract reviewers by mixing immaterial "style fixes"
on existing code to a patch whose primary purpose is to introduce
new code.  A separate "preliminary fix and/or clean-up" patch before
the main series begins is often a welcome addition, though.


> @@ -2375,12 +2404,16 @@ int cmd_format_patch(int argc,
>  	}
>  	rev.numbered_files = just_numbers;
>  	rev.patch_suffix = fmt_patch_suffix;
> +
> +	if (cover_letter && !cover_letter_fmt)
> +		cover_letter_fmt = "shortlog";
> +

I do not quite see the point of doing this.  There is no law that
"cover_letter_fmt != NULL" is a crime when cover_letter is false.

cover_letter_fmt can be initialized to a fixed string "shortlog",
and nobody cares what random value cover_letter_fmt has when
cover_letter is false.

>  	if (cover_letter) {
>  		if (cfg.thread)
>  			gen_message_id(&rev, "cover");
>  		make_cover_letter(&rev, !!output_directory,
>  				  origin, list.nr, list.items,
> -				  description_file, branch_name, quiet, &cfg);
> +				  description_file, branch_name, quiet, &cfg, cover_letter_fmt);

This line has become overly long.  Please wrap it.

>  		print_bases(&bases, rev.diffopt.file);
>  		print_signature(signature, rev.diffopt.file);
>  		total++;

In any case, the implementation in this iteration looks much nicer
than the previous one.

New set of tests should come together with implementation of a new
feature in the same patch.

Thanks.
