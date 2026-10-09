Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF46431485
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 20:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791577035; cv=none; b=ilF3jLPIn9ul0Sq1wwYBn/3vYGaqrBStkRp1rLdMnKF4OIG2iCgnHIXwqivnj1RpE+PzbMyE41wPNQCuLahFuDzIFRxfR7b9u9KsNQjNPwqUrudP8i3g7Grwogm3Hz90rNtAdYzHdoOA9smJeZcCO/i929GMpwzTaZqZsmpuKwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791577035; c=relaxed/simple;
	bh=MfoeEgQD8Dnv85oGJ/VvQud5OjXW8WpwNO0DJKfvS/M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M6BVBeUgihy/xGWZ4PDP34Ix4vM+ovTqr6Shi0RuZX/NeDG0RCvNvaW4T+mvq7hiiE26UXw4LWLoAYF0n2re30yDpgjV0ms86BdbSU+wrL3s+SGumPt614KYIGEqnR+Imm+cJ1ieln8WYdz7PLR/6wqgypU8T3M70li3MHP7mjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aSE4fShI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D8wMOwe/; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aSE4fShI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D8wMOwe/"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 230F87A00DD
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 16:17:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 09 Oct 2026 16:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791577031; x=1791663431; bh=vbnxu/QWUt
	9EqkJWbEebmyQWs4pAf+iusVmhPehyD6M=; b=aSE4fShICzYBq+OgZRHfQrpOau
	qb0sDK8i7n5vvG6j/kJYzb5OQUVqL1hT1YtE1QjTm1D+LFTqia8wnRe7bmQGzlPS
	AOCkC30VRif8vPKLZu1cbVb+znRyImXsuPP8V4oqYgNhAx2dm+yTUaoBU0bGtO6e
	G0WzVbv6rQyRs3xZjMq36+DMUaq345np5PiuEu7SWp94N3dKyF9+S0+wfBuZApiL
	X3IT56X//Hr+X/77U6Sgu6BVCE96Rue5O8I+gdNgN+xldeZRDR554Y6FUjGdE2k8
	42a2asVGsxx/QIzM1GaMwtrwhPM3WqK1+363C7r4HkNWVFTxSpYAvPvAtsiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791577031; x=1791663431; bh=vbnxu/QWUt9EqkJWbEebmyQWs4pAf+iusVm
	hPehyD6M=; b=D8wMOwe/dK7D6g0us8oReFY12ily2SY2rUfnkS2/nbblc556Snt
	YjeYiotZGUfcV2OaI6Q8GxuslcOdZ7IvDaP5JryRM0zdwcsOCDkDJpq/dLEDzIcV
	aNmuyOsF4M8KHIXaeH1h8HhmtdpnMaw1Hs8dKPq67rxaOvc4g4SbA/hcwGIbBS8L
	hQ7xUBCQLQ0VkRDOBwY9pj6Yy9DXW6vYx6OPwxJNvuD7/RRRGJ/ctAMRe4/57aLy
	sloW3KEn0Q03LC+HuITfwA3ckrRojNpBSUWxEPgHZa1+o9iMlMClrmYBa83z3aAt
	+h1GlloAp1nI35VobLY7mS23YOjAiJEORcA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791577031; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:UBawY/IjDglxy2N79fMV8rqafF9m0pdpd2dec/XVUnrVtHz
	SUJm3jPBP8h1n+pRO/NbX9oweClcYQb4a5hYHZM4aV+/BhxFgadYvDyvWQrDPuFT
	QBVWaZhNJBLZSqEZgeQx3t6dUbmNMBfqYjCEjQ8jhZUIPQMpAJJS1FEFyIxbP4N1
	ZVZcSpY5r4irI6wC+LkrV8Nyf7sCAqcChDiTD+EFE9uwEC/4pFSEUDde87KQMMUP
	0wbMKj4X+xIk2hEv5/WGp9Q+cZGxGXrX1IRM1xJn0+4utjllLYZlpPJVf6aAaKgr
	epB02RdHaCl/mEQT16BB1/EA7Vx10I2bxzfkCtQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:dpdZncfgVNhkXYaY3r6UOZatwBGYW+oOGrdJlQ1m0aY=:MfoeEgQD8Dnv85oGJ/VvQud5OjXW8WpwNO0DJKfvS/M=;
X-ME-Sender: <xms:xkvJasembuIj9jiGrnraFctaV3iHb_cNkYrTl6TqOPPXECMlOBVWlA>
    <xme:xkvJaoPqUJlhZtVbiP9ibMbCKGKYsuK6Jz2xOjItKJ_l1RvzRpZ11fdN55IUaDX40
    NCceS3iSJvXspNzoOVboY-xtGHjdlN11uR1K_X6bcshlxiV2r3jeg>
X-ME-Received: <xmr:xkvJakIaKO0AwJFZ_cI_6K9Wv70CqZFie8tjVIwaymJewzUUCXTugvUNQVTj7Any5AOwTE7LSK5q3UPpN6ye9C__VE6CALVdJBQh>
X-ME-Proxy-Cause: dmFkZTFpUc+9JtrpMnsw488uvHemTmdORsOcP+170Zq0d8HAW6I+tMvuxxE2rs90GmTjCv
    8wpIQXSeiMuE0HY+QJ/eds0FzimU5GIzbKc9BtUXGJT8IicEY464ZL5XhVBUVacmiwcO9g
    Cm1aTzGhxdk+MCE+8LsQhQzgRz5v/oq5Nm2GlrU1kd0pTdBlJMOR0dlQfJuCEoW8TMn3wS
    /9rrghVpCDrKAAzLA9C21QFNcgUdJqBXYCYk4ppHz3IioE5TV3fb+r1AWfuwbAiYCyM7bl
    EoK4UN4O1JEii3F6wn5tB2oyNFpNOMeJ1JdrOgYYU6TEKKEipwPZo1ZJuwCLdfAebUIvSK
    GVct5muQ1aG2PyqbgNlSDvjYHrvyWPOAUxdg34BgipuGSFhgA/vySkIqHKytFV8Z2XO7kh
    +n38qrJMDCW5TKAZMX1adnUW7RVKrDZ3c3UMgNBYf638JId+3XEGKig/g+dMJABWBwXqXH
    JriJ1evRai9T3D7wFUNS6sPozFRs98dyxT58JE7w+FCMqCqlPsIVhwwTxJmlicUXIvVsI0
    4ip5076fIeG/YLPYOMNFlq/BE2nvq0i9Hd2o+41d5A96RyDg8bp8DD5IGlmf7sPWOEAWiD
    H/aAS8pG5NVXS+hAY6vFshtNqsa7MGDzBSO5wX7QzAoUIuuaBUMrLL8nr21Q
X-ME-Proxy: <xmx:xkvJagJ4OlMp3xY5dP7wB8BwEGSp3gFN7IdfIFzF_yBhAzG9YRV6Iw>
    <xmx:x0vJam41UtjR4jXTCG0jEu_GD3_8VTMAuE5GUJJjL_dSUIbQPiy8Ww>
    <xmx:x0vJaid0Hc-onPB_uxa-sztUap8UKJGUDvGk17-EG5S0i1ROlvwZww>
    <xmx:x0vJapFT9xLYbW5lLKHiip4aqPDfoUZEY4L0BFs3yX6hTjYqJn8RrQ>
    <xmx:x0vJalbU5TM52yo2SRYSTaF46fPo4N-ZhOm5f6nfiAKMbWWWNm5kpFDe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 16:17:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
  Abhijeetsingh Meena <abhijeet040403@gmail.com>,
  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  Phillip Wood <phillip.wood@dunelm.org.uk>,
  Eric Sunshine <sunshine@sunshineco.com>,  Ravi Mistry <rmistry@google.com>
Subject: Re: [PATCH v2 2/2] blame: ignore revs in HEAD:.git-blame-ignore-revs
In-Reply-To: <35e303d65bc378e733b1e9e8d6908a829352e857.1791493644.git.gitgitgadget@gmail.com>
	(Ravi Mistry via GitGitGadget's message of "Thu, 08 Oct 2026 21:07:24
	+0000")
References: <pull.2224.git.1789169384240.gitgitgadget@gmail.com>
	<pull.2224.v2.git.1791493644.gitgitgadget@gmail.com>
	<35e303d65bc378e733b1e9e8d6908a829352e857.1791493644.git.gitgitgadget@gmail.com>
Date: Fri, 09 Oct 2026 13:17:09 -0700
Message-ID: <xmqqbj92ochm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Ravi Mistry <rmistry@google.com>
>
> git-blame(1) can ignore a list of commits specified via
> --ignore-revs-file or the blame.ignoreRevsFile configuration option.
> This is useful for skipping uninteresting revisions such as tree-wide
> formatting changes, large-scale refactors, and code modernizations that
> would otherwise obscure genuine historical authorship.
>
> When revision-ignoring was introduced in commit ae3f36dea1 ("blame: add
> blame.ignoreRevsFile config option", 2019-10-18), it intentionally
> avoided adopting a default ignore file. At the time, the capability was
> new and unproven, so avoiding unrequested filesystem I/O or unexpected
> attribution shifts took priority over a project-wide default.
> Requiring explicit opt-in per clone was therefore the prudent design.
>
> Since then, maintaining a .git-blame-ignore-revs file in the repository
> root has become the de facto standard across the Git ecosystem, adopted
> by major hosting platforms (GitHub, GitLab, Gerrit) and prominent open
> source projects (such as Chromium and LLVM). As a consequence,
> developers frequently encounter a jarring mismatch: web interfaces
> seamlessly ignore formatting commits, but local git-blame(1) and
> git-annotate(1) runs do not, unless each user manually configures
> blame.ignoreRevsFile for every local checkout.
>
> Teach git-blame(1) and git-annotate(1) to automatically add the
> HEAD:.git-blame-ignore-revs blob, if it exists, as the initial element
> in the list of ignore-revs files in both bare and non-bare
> repositories. Reading the committed blob from HEAD rather than the
> working tree ensures that local runs match hosting platforms even when
> an untracked .git-blame-ignore-revs file is present or a tracked one
> has uncommitted local changes.
>
> To ensure consistent precedence and override semantics:
> - The default HEAD:.git-blame-ignore-revs entry is added before reading
>   configuration and CLI options, preserving user and repository config
>   overrides.
> - In git_blame_config(), blame.ignoreRevsFile entries are appended via
>   string_list_append() rather than inserted in sorted order via
>   string_list_insert() so that configuration entries preserve their
>   order relative to the initial default entry.
> - The HEAD:.git-blame-ignore-revs tree entry is resolved quietly via
>   get_oid_with_context(). Its mode is checked with S_ISREG() before
>   reading the object so that non-regular tree entries (such as a
>   committed symbolic link whose blob stores a target path rather than
>   revision IDs, a subdirectory, or a gitlink) are skipped instead of
>   being read and rejected as malformed object names. The blob is parsed
>   in memory via a new oidset_parse_buffer_carefully() helper in
>   oidset.c that shares line parsing with oidset_parse_file_carefully().
> - In build_ignorelist(), ignore-revs entries are processed starting
>   after the last empty string entry. This ensures setting
>   blame.ignoreRevsFile to "" or passing --ignore-revs-file "" or
>   --no-ignore-revs-file cleanly discards the default blob without
>   attempting to read or parse it, allowing users to bypass a malformed
>   default blob.
>
> Update documentation in blame-options.adoc and config/blame.adoc, and
> add comprehensive test coverage in t8013 for the default blob lookup,
> subdirectory invocations, bare repositories, uncommitted and untracked
> working-tree files, CLI and config overrides, committed symlink
> entries, and comments and whitespace handling.
>
> Based-on-patch-by: Abhijeetsingh Meena <abhijeet040403@gmail.com>
> Helped-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>

These Helped-by: drew my attention as none of these folks commented
on v1 of this series.  I do see they have helped the original series
<pull.1809.v2.git.1728707867.gitgitgadget@gmail.com>, but it is not
clear how much their inputs have survivied to this version.

They are all CC'ed so they can give their Acked-by: or Reviewed-by: 
on this round if they want.


[...]

> diff --git a/builtin/blame.c b/builtin/blame.c
> index 6741a7b9df..a730ee87ea 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -769,7 +769,7 @@ static int git_blame_config(const char *var, const char *value,
>  		if (ret)
>  			return ret;
>  		if (str)
> -			string_list_insert(&ignore_revs_file_list, str);
> +			string_list_append(&ignore_revs_file_list, str);
>  		free(str);
>  		return 0;
>  	}

Good, and the log message is clear why we make this change.

> @@ -946,17 +946,52 @@ static int peel_to_commit_oid(struct object_id *oid_ret, void *cbdata)
>  	}
>  }
>  
> +static void parse_default_ignore_revs_blob(struct blame_scoreboard *sb,
> +					   const char *name)
> +{
> +	struct object_context oc;
> +	struct object_id oid;
> +	enum object_type type;
> +	size_t size;
> +	char *buf;
> +
> +	if (get_oid_with_context(the_repository, name, GET_OID_QUIETLY,
> +				 &oid, &oc))
> +		goto out;
> +	if (!S_ISREG(oc.mode))
> +		goto out;
> +
> +	buf = odb_read_object(the_repository->objects, &oid, &type, &size);
> +	if (!buf)
> +		goto out;
> +	if (type == OBJ_BLOB)
> +		oidset_parse_buffer_carefully(&sb->ignore_list, buf, size,
> +					      the_repository->hash_algo,
> +					      peel_to_commit_oid, sb);
> +	free(buf);
> +
> +out:
> +	object_context_release(&oc);
> +}

OK.

>  static void build_ignorelist(struct blame_scoreboard *sb,
>  			     struct string_list *ignore_revs_file_list,
>  			     struct string_list *ignore_rev_list)
>  {
>  	struct string_list_item *i;
>  	struct object_id oid;
> +	size_t start_idx = 0, idx;
> +
> +	for (idx = 0; idx < ignore_revs_file_list->nr; idx++) {
> +		if (!*ignore_revs_file_list->items[idx].string)
> +			start_idx = idx + 1;
> +	}

OK, we make two passes, and during the first pass, we find where the
last "empty" entry that signals "forget everything you have seen" is.

>  	oidset_init(&sb->ignore_list, 0);
> -	for_each_string_list_item(i, ignore_revs_file_list) {
> -		if (!strcmp(i->string, ""))
> -			oidset_clear(&sb->ignore_list);
> +	for (idx = start_idx; idx < ignore_revs_file_list->nr; idx++) {

And we scan starting from there.  Very clean.

> +		i = &ignore_revs_file_list->items[idx];
> +		if (i->util)
> +			parse_default_ignore_revs_blob(sb, i->string);
>  		else
>  			oidset_parse_file_carefully(&sb->ignore_list, i->string,
>  						    the_repository->hash_algo,
> @@ -1036,6 +1071,8 @@ int cmd_blame(int argc,
>  	const char *const *opt_usage = cmd_is_annotate ? annotate_opt_usage : blame_opt_usage;
>  
>  	setup_default_color_by_age();
> +	string_list_append(&ignore_revs_file_list,
> +			   "HEAD:.git-blame-ignore-revs")->util = &sb;

Cute.  This takes advantage of the fact that everybody else just
appends to the string_list without populating the .util member.

> diff --git a/oidset.c b/oidset.c
> index 90d39204d3..8469d03b9b 100644
> --- a/oidset.c
> +++ b/oidset.c
> @@ -70,44 +70,76 @@ void oidset_parse_file(struct oidset *set, const char *path,
>  	oidset_parse_file_carefully(set, path, algop, NULL, NULL);
>  }
>  
> +static void parse_oidset_line(struct oidset *set, struct strbuf *sb,
> +			      const struct git_hash_algo *algop,
> +			      oidset_parse_tweak_fn fn, void *cbdata)
> +{
> +	const char *p;
> +	const char *name;
> +	struct object_id oid;
> +
> +	if (memchr(sb->buf, '\0', sb->len))
> +		die("invalid object name: %s", sb->buf);
> +
> +	/*
> +	 * Allow trailing comments, leading whitespace
> +	 * (including before commits), and empty or whitespace
> +	 * only lines.
> +	 */
> +	name = strchr(sb->buf, '#');
> +	if (name)
> +		strbuf_setlen(sb, name - sb->buf);
> +	strbuf_trim(sb);
> +	if (!sb->len)
> +		return;
> +
> +	if (parse_oid_hex_algop(sb->buf, &oid, &p, algop) || *p != '\0')
> +		die("invalid object name: %s", sb->buf);
> +	if (fn && fn(&oid, cbdata))
> +		return;
> +	oidset_insert(set, &oid);
> +}
> +
>  void oidset_parse_file_carefully(struct oidset *set, const char *path,
>  				 const struct git_hash_algo *algop,
>  				 oidset_parse_tweak_fn fn, void *cbdata)
>  {
>  	FILE *fp;
>  	struct strbuf sb = STRBUF_INIT;
> -	struct object_id oid;
>  
>  	fp = fopen(path, "r");
>  	if (!fp)
>  		die("could not open object name list: %s", path);
> -	while (!strbuf_getline(&sb, fp)) {
> -		const char *p;
> -		const char *name;
> -
> -		if (memchr(sb.buf, '\0', sb.len))
> -			die("invalid object name: %s", sb.buf);
> -
> -		/*
> -		 * Allow trailing comments, leading whitespace
> -		 * (including before commits), and empty or whitespace
> -		 * only lines.
> -		 */
> -		name = strchr(sb.buf, '#');
> -		if (name)
> -			strbuf_setlen(&sb, name - sb.buf);
> -		strbuf_trim(&sb);
> -		if (!sb.len)
> -			continue;
> -
> -		if (parse_oid_hex_algop(sb.buf, &oid, &p, algop) || *p != '\0')
> -			die("invalid object name: %s", sb.buf);
> -		if (fn && fn(&oid, cbdata))
> -			continue;
> -		oidset_insert(set, &oid);
> -	}
> +	while (!strbuf_getline(&sb, fp))
> +		parse_oidset_line(set, &sb, algop, fn, cbdata);
>  	if (ferror(fp))
>  		die_errno("Could not read '%s'", path);
>  	fclose(fp);
>  	strbuf_release(&sb);
>  }

Shouldn't the above refactoring have been part of the previous step
instead?

Thanks.
