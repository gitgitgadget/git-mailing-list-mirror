Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFE928C2A1
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 17:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782149167; cv=none; b=ovy77NSENlx/0E6MI2WTzjFut4iYyh0AjFdrfL6flOqxQBf3KCHR79IqnV806SxK2yBltV2UThHzq/3LORjQfmJx6Z3YNI0+GbB2qhtMb7Hm9NVGj4BXUXog4rVjO1JeYHs97C+e5luezUTKLVLG9LklFHq7nSNXpUk3YdwqcK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782149167; c=relaxed/simple;
	bh=DKr/qJ4vcw+KAri6ei2IBMsRKRl5CezNclx01jr2N5M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iTYBtzUmIR+zJGuvQ4mzfEwAaWSTHXXKNLnZkb6vVQMuR97wsEpjavF5UMrhYtz7yOVBGiP0m/sU6PlWMWf0OmW88bbAkLAPe8iHRowJ7n5A/mnSbn5kVzOdYaYgnc0G+xRq3mXYH7HhwuAInis8MrPEJVZaC36wxOOEO19Pl78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IvJPLa84; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eAyM6WVd; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IvJPLa84";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eAyM6WVd"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id A244AEC01DF;
	Mon, 22 Jun 2026 13:26:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 22 Jun 2026 13:26:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782149164; x=1782235564; bh=NoCqSL5XVU
	6LAAP9oQGEFRi2/GALY6H84VgnUBjB0b8=; b=IvJPLa840uiMv2ijaO77txliQ2
	P9VBKuyUBJkSJ3m2v1KWdDE62N6JJq2jmlelZww9g6OthVdHxp0V4iiCbBhXHZVC
	O7ky0wF5us6l5y5f43qAOijVt6HX7U2MJ4kGbNjmQsfD7IEvsr5JTNjDciKdzNRz
	Mp5YybE5qj5AULX2Fnd3rgQFC+JnEvViJSxy+4kVD+SxGSh1bIqYefD4WZ72tyQC
	/UJj1jpztsMSUXPbjQtavfnK0iPMc/0AOk3bHmmgZaww5kWOKhaHbu0CXqQnQVLr
	chW9Wl8yeEHBUuiVM7j5y5WLuJ96v0l+lB27oZCHRvEB/pygIo012Lzq1zEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782149164; x=1782235564; bh=NoCqSL5XVU6LAAP9oQGEFRi2/GALY6H84Vg
	nUBjB0b8=; b=eAyM6WVdGS0Y8yEcTZz1IJbEDOg3xHLRL0lhTzZIITT5PExI6Z6
	CbdkhBGWSRtMGbi8IY9Yfy1RtnPiNoJDqkAa9TMSyeOMEDKzGBTya1KACFC4EXeh
	slV1piiLoh0jWN0fZ6M4uIWxKlYtBnubo300JgoIRFX39arC+Fmvpo7axStEvcZd
	V7XJ8NQhkAnOc67O5DxuGnMW9KdO5GNzpK22rfMwjh9xf1vJ1uq4zvU/fybW0qg6
	pk4Z03LrvQ8RRC225GBLAAYkEpAc6lsEjyRaqflJom2LwKgeNBMjoyEjaVg5jCX9
	fUXtNDA8Ir4J60Ui7qn6vYPysKlZt8EN74A==
X-ME-Sender: <xms:LHA5ajR2PX6vU7w-RpbZoGPQ_TqxEMEcimhABwneRkxPlquS4gx0VQ>
    <xme:LHA5arryeiP3r3Uz_rFB07ofTwJCWOrMvyolyZ_BZbxlloXHQnh368NeKDnCs7Hw8
    pEJc6tWe-HSYWHfHUfQiv6g9TuBxGynngVkahjI4CxOpXf19oj-Vg>
X-ME-Received: <xmr:LHA5ahII90N2NAr4yVE-nzDmgzb4B2LQNyXxWBG95Mt_4Gk1NUbpUY5yEOPgmQQ0d2A1RhuWc7AlcFq07rz3OAoOyFqAZUjC0WIaNPg>
X-ME-Proxy-Cause: dmFkZTEIh3Zbsax/6xuCXxkdt1DkP5UL7L/unfc4zZfx+8Tub1psB5TKzoSNcb4GKCnSJi
    R7aop77B3Z1Scv0BSAm4i/0Vldg2RiBMisyTWii6fYdYb4bxG6p6EPpza45oAch2M6VAOd
    8ll1iuZ+mBhtX4oyNUAaiqwutmer8NAjDRv5/92gWn+vU5Qrqx7zgozdqowtFyffqKuRjr
    /PHrOIpUI6OdZwjzXYwQa6yAd4V3IfgNZiTV3e2mPXlW6J7c4EmHc2t+cu8lVBS5h3HCUo
    Isdj0wnzqbVeTaku74VV3EV0J0PFENjIMgioAd51WKULDUaYY14EIcGh7OO6CxaJjBREeb
    ZvjTRawFGiv/reLhxIh2hXKEXlzK+tCi3wek6LPdKpbxAw0kpbhJrDV/bed+25H4BO2+jv
    cSEnqC9M8UCv62g0F66CAbaOljkwxn2lUOyGWNTW1dZcDhxsHTuzJm5eFCTmXKNgmI50/V
    hoeWJ/ZqpmWUYNe4jr5c7yf3teN3cDhEJmuaiOtDgz9h78hW3qJZPj5ueSnc3DgROVHfPX
    Sj0wy7s6n5HnG20e7LURTBCkUyKocMdMa6fyZ2uIw8mgQY6H2PSE+ca0RmsKAb9Swf3BYk
    l97jVeKQDpDXj2uTsGLeTxZV3HwjFQIxWgw0zc7DtpvWI4fyBqbvDwMaVjAA
X-ME-Proxy: <xmx:LHA5aurFp3MP4CPc90ksOcZk25xjk1YKnZOuzJBGY0RgWxRv43bxtg>
    <xmx:LHA5apw9DY98oSVcKLA6pCBMGZV6PIbZc2lF95s4Lg8GJZQMKC3cAA>
    <xmx:LHA5aiO9yeXq6nopN5OcseLqFyuO1MarMaTpKD-_f9v-I4N9l1wGrg>
    <xmx:LHA5au5BUCPARXVe_ncBAbjoXcV1uQ1p6G_y2_lrktxdZNw4rsoIlw>
    <xmx:LHA5ap7w1ldp5e7rH_gZQ-PETdCxwR8c-4Qn1KLjOAKY6gWxy2LUCtcR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 13:26:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 2/2] status: improve rebase todo list parsing
In-Reply-To: <b3514e9b1c9515bf1a7f7983b9f120d63edba97f.1782117361.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Mon, 22 Jun 2026 09:36:04 +0100")
References: <cover.1776697483.git.phillip.wood@dunelm.org.uk>
	<cover.1782117361.git.phillip.wood@dunelm.org.uk>
	<b3514e9b1c9515bf1a7f7983b9f120d63edba97f.1782117361.git.phillip.wood@dunelm.org.uk>
Date: Mon, 22 Jun 2026 10:26:02 -0700
Message-ID: <xmqqechy1o7p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> When there is rebase in progress "git status" displays the last couple
> of completed and the next couple of pending commands from the todo
> list. When it does this it tries to abbreviate the object ids of
> the commits to be picked. Unfortunately it does not abbreviate the
> object ids when the line starts with "fixup -C" or "merge -C". It
> also mistakenly replaces the refname in "reset main" and "update-ref
> refs/heads/main" with the object id that the ref points to.
>
> Fix this by using the function added in the last commit to parse the
> command name and only try to abbreviate the argument for commands that
> take an object id. If a command accepts a label then try to resolve the
> object name as a label first and only if that fails try to resolve it
> as an object_id. When trying to abbreviate an object id, only replace
> the object name if it starts with the abbreviated object id so that
> tag or branch names that contain only hex digits are left unchanged.

;-)  

Strictly speaking, the original that said "if begins with
exed, x, label, or l, then don't bother" style can be extended
without using the function added in the last commit to do this, but
it certainly is much more pleasant to read the resulting code
presented here that uses parsed command enum and switches on it.

> Comments are now processed after stripping any leading
> whitespace from the line. This matches what the sequencer does in
> parse_insn_line(). The existing test cases are updated to test a
> wider variety of commands. Only the pending commands in the tests
> are changed to avoid removing existing coverage.
>
> Helped-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
> diff --git a/wt-status.c b/wt-status.c
> index 479ccc3304b..4b15bda76f4 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1363,6 +1363,71 @@ static int split_commit_in_progress(struct wt_status *s)
>  	free(rebase_orig_head);
>  
>  	return split_in_progress;
> +}
> +
> +/*
> + * If the whitespace-delimited token starting at or just after *pp
> + * is a hex object id that is longer than its default abbreviation,
> + * abbreviate it in-place, shrinking `line` accordingly. On return
> + * *pp points one past the (possibly abbreviated) token. Leaves both
> + * `line` and *pp-advanced-past-the-token unchanged in all other cases
> + * (non-hex token, label name, unresolvable, or a refname that happens
> + * to consist only of hex digits).
> + */
> +static void abbrev_oid_in_line(struct repository *r, struct strbuf *scratch,
> +			       struct strbuf *line, bool maybe_label, char **pp)
> +{
> +	char *p = *pp;
> +	char *end_of_object_name, saved;
> +	const char *abbrev;
> +	struct object_id oid;
> +	bool have_oid;
> +
> +	p += strspn(p, " \t");
> +	end_of_object_name = p + strcspn(p, " \t");
> +	/*
> +	 * For "merge" and "reset" the object name may be a label or
> +	 * ref rather than a hex object id. Only abbreviate the object
> +	 * name if it is a hex object id.
> +	 */
> +	for (const char *q = p; q < end_of_object_name; q++) {
> +		if (!isxdigit(*q))
> +			goto out;
> +	}

OK.  If the string has non hexdigit, it cannot be a raw object name
so there is no point in rewriting.  OK.

> +	if (maybe_label) {
> +		strbuf_reset(scratch);
> +		strbuf_addf(scratch, "refs/rewritten/%.*s",
> +			    (int)(end_of_object_name - p), p);
> +		if (refs_ref_exists(get_main_ref_store(r), scratch->buf))
> +			goto out; /* object name was a label */
> +	}

If it could be a label, then we check if such a label exists, and if
so, we won't modify it.  OK.

> +	saved = *end_of_object_name;
> +	*end_of_object_name = '\0';
> +	have_oid = !repo_get_oid(r, p, &oid);
> +	*end_of_object_name = saved;
> +	if (!have_oid)
> +		goto out; /* invalid object name */

We obviously cannot abbreviate if we cannot even recognize it as an
object name.  OK.

> +	abbrev = repo_find_unique_abbrev(r, &oid, DEFAULT_ABBREV);
> +	if (!starts_with(p, abbrev))
> +		goto out; /* object name was a refname containing only xdigits */

OK, nice to see sufficient paranoia ;-)

> +	p += strlen(abbrev);
> +	strbuf_remove(line, p - line->buf, end_of_object_name - p);
> +	end_of_object_name = p;

By abbreviating, line->buf only shrinks so we won't risk getting
confused by a realloc() happening under the hood.  Upon entry to
this helper, *pp must be pointing into line->buf, or everything will
go awry but for a file-scope static helper function like this, it
probably is too obvious to anybody that it does not have to be
spelled out.  OK.

> +out:
> +	*pp = end_of_object_name;
> +}


> +/* Skip "[ \t]*(-[cC])?", returns true if "-c/-C" was skipped. */
> +static bool skip_dash_c(char **pp)
> +{
> +	bool ret;
> +	char *p = *pp;
> +
> +	p += strspn(p, " \t");
> +	ret = skip_prefix(p, "-C", &p) || skip_prefix(p, "-c", &p);
> +	*pp = p;
> +
> +	return ret;
>  }

OK.

> @@ -1371,29 +1436,68 @@ static int split_commit_in_progress(struct wt_status *s)
>   * into
>   * "pick d6a2f03 some message"
>   *
> - * The function assumes that the line does not contain useless spaces
> - * before or after the command.
> + * Returns false on comment lines, true otherwise
>   */
> -static void abbrev_oid_in_line(struct repository *r, struct strbuf *line)
> +static bool format_todo_line(struct repository *r, struct strbuf *line)
>  {
> -	struct string_list split = STRING_LIST_INIT_DUP;
> -	struct object_id oid;
> -
> -	if (starts_with(line->buf, "exec ") ||
> -	    starts_with(line->buf, "x ") ||
> -	    starts_with(line->buf, "label ") ||
> -	    starts_with(line->buf, "l "))
> -		return;
> -
> -	if ((2 <= string_list_split(&split, line->buf, " ", 2)) &&
> -	    !repo_get_oid(r, split.items[1].string, &oid)) {
> -		strbuf_reset(line);
> -		strbuf_addf(line, "%s ", split.items[0].string);
> -		strbuf_add_unique_abbrev(line, &oid, DEFAULT_ABBREV);
> -		for (size_t i = 2; i < split.nr; i++)
> -			strbuf_addf(line, " %s", split.items[i].string);
> -	}
> -	string_list_clear(&split, 0);

We essentially said, "do not molest exec and label, but everything
else, as long as there are two (or more) tokens and the second token
looks like an object name, replace it with its abbreviation",
regardless of what the actual command was.  Now we do the right
thing by ...

> +	enum todo_command cmd;
> +	struct strbuf scratch = STRBUF_INIT;
> +	char *p = line->buf;
> +
> +	if (!sequencer_parse_todo_command((const char**)&p, &cmd))
> +		return true; /* keep invalid lines */

... parsing out what the line is about, and ...

> +	switch (cmd) {

... switching on it, to make it clear that we cover all the cases
known to us (and the code will be maintained like so, by not having
a "default" arm).

> +	case TODO_COMMENT:
> +		return false;
> +
> +	case TODO_MERGE: {
> +		/*
> +		 * The argument to -C cannot be a label, but the parents
> +		 * can be labels.
> +		 */
> +		bool maybe_label = !skip_dash_c(&p);
> +
> +		while (true) {
> +			p += strspn(p, " \t");
> +			if (!p[0] || (p[0] == '#' && (!p[1] || isspace(p[1]))))
> +				break;
> +			abbrev_oid_in_line(r, &scratch, line, maybe_label, &p);
> +			maybe_label = true;
> +		}
> +		break;
> +	}
> +
> +	case TODO_FIXUP:
> +		skip_dash_c(&p);
> +		/* fallthrough */

Fixup always refers to raw object ID and never a label, so it
would be OK to just skip -c/-C here ...

> +	case TODO_DROP:
> +	case TODO_EDIT:
> +	case TODO_PICK:
> +	case TODO_REVERT:
> +	case TODO_REWORD:
> +	case TODO_SQUASH:

... and pass "false" for "maybe_label".  OK.

> +		abbrev_oid_in_line(r, &scratch, line, false, &p);
> +		break;
> +
> +	case TODO_RESET:
> +		abbrev_oid_in_line(r, &scratch, line, true, &p);
> +		break;
> +	/*
> +	 * Avoid "default" and instead list all the other commands so
> +	 * that -Wswitch (which is included in -Wall) warns if a new
> +	 * command is added without handling it in this function.
> +	 */
> +	case TODO_BREAK:
> +	case TODO_EXEC:
> +	case TODO_LABEL:
> +	case TODO_NOOP:
> +	case TODO_UPDATE_REF:
> +		break;
> +	}
> +
> +	strbuf_release(&scratch);
> +	return true;
>  }
>  
>  static int read_rebase_todolist(struct repository *r, const char *fname, struct string_list *lines)
> @@ -1411,13 +1515,9 @@ static int read_rebase_todolist(struct repository *r, const char *fname, struct
>  			  repo_git_path_replace(r, &buf, "%s", fname));
>  	}
>  	while (!strbuf_getline_lf(&buf, f)) {
> -		if (starts_with(buf.buf, comment_line_str))
> -			continue;
>  		strbuf_trim(&buf);
> -		if (!buf.len)
> -			continue;
> -		abbrev_oid_in_line(r, &buf);
> -		string_list_append(lines, buf.buf);
> +		if (format_todo_line(r, &buf))
> +			string_list_append(lines, buf.buf);
>  	}
>  	fclose(f);

This loop got much nicer than the original.

Looks good.

Thanks.
