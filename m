Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A546D155757
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 20:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782418017; cv=none; b=G62ItBxS6X9Gu3NbCZlugoL3ne34x202a3TBlDPwxnGIjlJkd4inyaXwpj9Gnc/Uxy9LL8w/3motLgmk5HFwUckl4EGgD0S48Zzy6Icqf8VaBKNR7ycFi5ZaD2ES1twoCc4PA/zEDGY1/BcAMaLKpHJ794+GyEJVhFAfDFefICE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782418017; c=relaxed/simple;
	bh=2xzejVBUP83x6B8pbF1bOzmQ2CrwFkxphYlV0RCdfUM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EnWiyT7lKYne3OYdbN89c18mj/Wq+EjxRm3HxFi3IDuGTKxX7jF9lohRj9C9jSV2DYbhLmnqjObJJhMs2YVPYoEeZGIF3S2WudypZUUUs7M07HPSThZhV8jCVVMDmHyREGBbcmBiNAgdNs9f9IXKi0GEZ1oBgqBuuAcC09treGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UF2ku2zo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eycA71QA; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UF2ku2zo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eycA71QA"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id CD6ADEC0200;
	Thu, 25 Jun 2026 16:06:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Thu, 25 Jun 2026 16:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782418014; x=1782504414; bh=4cm5dyDej6
	rKj2x5k5u5BzzsGcu7/zgTtrONAv6eE7s=; b=UF2ku2zoeaM/UvNn90DF+VGnLQ
	73ZVX1/Fm+CIkAESKdJCVNS5KFFxmK1CK9FLaapeRwpBv/H1k5N9EfSaiPnij2yt
	/m7JM9AF1ZNZBL8qDp81hRfCRWkNmGwJvftHIPh3NUcYTqAcq1XKLMfE4SqOSI5Z
	0M47LvlIgTRS8/LWTpqj/Re3RWqShCDEZvEB+Pv1vtzNZFw+8fpWElyHfQ3umXUJ
	uAFr1y5nsFSEQ22btooK+5xKwEVxVHBiaauioBmtqvQjUOug5DZrdKrHMSQo41GR
	/1TqIlzwg148ttJ9hLRY1ILgY3RnlSiVMdk+u+MVsr2YAp+r8p1YNTZm7iEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782418014; x=1782504414; bh=4cm5dyDej6rKj2x5k5u5BzzsGcu7/zgTtrO
	NAv6eE7s=; b=eycA71QAu4Bvj+Y/cb9LaJoC4/tN5HbaOj25UmrmUoeRnkuoO8t
	V6mbCCEamg0FC6WBngEu2r6+Vyv1zOwcqZfSPvbLKlW8h7w0ItqDshcFBsuhjz6m
	71+F+Pd7A+2LgJZWV6VcF6OaRoVpOxt4/yy6wE8wmdlXfz9PDhb5NlSSL4Cgxily
	Sjbby+wevot8Jnc3WTIEbumyS4LcXmLffXqnM1QsH0W4iVLT1wUtHCBO1gYCoebI
	AjkX29Dztm3J5M3ZCl+U9j6SZQ7rcD0TwxOUa7P7bI4kMa5Kc4jKNLa3ol6b/cDE
	t0i26a5sEhJ+0Mns5DRnrB/egwdKEjAOAuQ==
X-ME-Sender: <xms:Xoo9ao4EX4WIlMNJrvnqjcHQwUEhZSIgnamnPRpAH4TlbCT3DMhVsA>
    <xme:Xoo9agxroZloHZTr3zONG5dQpWr6ieQdsGeYalVWIFEUp0yylmWW4G0oZBqKl5J9b
    IuS1lmBzGxUxeUGEW3PRCYFxEAA7qEyJIjeI7eRPSWw9bF423r_9g>
X-ME-Received: <xmr:Xoo9avzuCSowrgIgkbo-Z82aHgrh71RScJKXFd9ndmGbE0LdoPUVJICdLKmr7fdzAu3XG5WNc8YqgCf5-XwBmPYe4hh3c87ACMPIeuQ>
X-ME-Proxy-Cause: dmFkZTFJM1MMY/2t/pPHm5l3bXQiSCkxmpECNR59h0YOrnFSQrrcHrAgBhbOCBP9FPeaiK
    ofmCQy6SbKPWUoFY/H1V0QJgbNDvLk6/n3NGO93SLeyP4WiQ16y/qcQNeYmAHDv1qYOEaJ
    a7jO/M+UYKWF26vFJE2oPH/5XrtkYA3/1FGP1pKAbkgIuv0Mw+f0qSpqlkVKbVbdnm0Kuq
    SIRPkthKcm8PYKh82zUOBlYGy7W9Pu5lkV41/GPP8tEcfJH3T2p3WlVW3n/CI43j7qATvX
    MF5+RzOrIzXbHTxYcb9D9qaExldflaVg9QuxCqhHjcYkKidCJdsN5Ojd6pGWw+S6AprOld
    xJzP4YR1u48M/lES+0UuCe8/++tESFpxd2ybXed2yYwEUjLeYiRwHxE/3X77Aon33hBWga
    lfefxoKRqg/WwMs8vJoCvfIbZNaPy1IJY0Vk4r/e9hdxKocddzjxXbaMDiBJFE5SREa13P
    eexNzuQP9oKGZRx/7RV9ZZdQI6aSNqJIYA0rP6A2VPdThPgwMRASJcnOZc98yVRCaQFeQF
    Qlp3giwyXShEiyPEukI/X9Ri0IC9vTCthKZuRNyy4/ypBC2LHDIbdD5TWcUGBgFpmVr71k
    VROHm7KxigOuB6w+JojAkATTyUcyYpFb7UgjB5K8vCml5dyPmB7kPWKTYjig
X-ME-Proxy: <xmx:Xoo9aoxT4jDCUXJaQKWTjrXQgSrVzyhCE88tPhfT-rKgsy4SUWF0BQ>
    <xmx:Xoo9apYXk8nMNvTqvwYQdQzK8gj7hALJjiwD50J-iENop931JuSyWQ>
    <xmx:Xoo9apUoFtFtj8e6hzKdPLaIEMlORSq61c1epFDMycDamW6eoprhdg>
    <xmx:Xoo9anhteuShLxB_c5j5NC-O-XmzTrAZo0J06vNH_Pa375B4avW8vA>
    <xmx:Xoo9avJfARPa2ZDtEhIrt_gh43cavont_gGdHp0_nLM0vIBHL3KlmBzu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jun 2026 16:06:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re* [PATCH] history: close COMMIT_EDITMSG before launching the editor
In-Reply-To: <pull.2158.git.1782412427801.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Thu, 25 Jun 2026 18:33:46
	+0000")
References: <pull.2158.git.1782412427801.gitgitgadget@gmail.com>
Date: Thu, 25 Jun 2026 13:06:52 -0700
Message-ID: <xmqqh5mqfkpv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Close the handle once the status has been written, before handing the
> file off to the editor.
>
> Assisted-by: Opus 4.8

Do we even need this?

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     history: close COMMIT_EDITMSG before launching the editor
>     
>     I noticed this problem while trying to whip MinGit-BusyBox into a better
>     shape during the -rc phase. Technically, this is not a fix for a
>     regression during the v2.55.0 period, but I figured it'd be better to
>     send it now anyway than to forget about sending it after v2.55.0 is
>     released.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2158%2Fdscho%2Ffix-fd-leak-in-history-reword-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2158/dscho/fix-fd-leak-in-history-reword-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2158
>
>  builtin/history.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/builtin/history.c b/builtin/history.c
> index 9526938085..4a5d9192f3 100644
> --- a/builtin/history.c
> +++ b/builtin/history.c
> @@ -74,6 +74,14 @@ static int fill_commit_message(struct repository *repo,
>  	wt_status_collect_free_buffers(&s);
>  	string_list_clear_func(&s.change, change_data_free);
>  
> +	/*
> +	 * Close the handle before launching the editor: on Windows an open
> +	 * handle would prevent the editor from replacing the file (e.g.
> +	 * BusyBox' `ash` cannot overwrite a file that another process keeps
> +	 * open), and leaving it open leaks the descriptor everywhere else.
> +	 */
> +	fclose(s.fp);
> +
>  	strbuf_reset(out);
>  	if (launch_editor(path, out, NULL)) {
>  		fprintf(stderr, _("Aborting commit as launching the editor failed.\n"));

The function is extremely sloppy beyond words X-<.  Thanks for
taking the first step to clean it up.

 * It calls git_path_commit_editmsg() to obtain a constant pathname
   into "const char *path", but then the part that leads to this
   file stream leak does not even use that "path" constant.  It
   makes two independent calls to git_path_commit_editmsg()!

 * The function first calls write_file_buf() to the file, which is a
   convenience function when you have something you need to write
   upfront and just want to write it and be done with it.

 * And then the unclosed file stream you just fixed.

What is surprising is that all of this was created in a single
commit.  I suspected that this part that does fopen() to leak the
file stream was a later addition than the initial write_file_buf(),
which should have been critiqued with "once you want to do your
custom writing that is more than "I have this block of memory, write
it into file", you should rewrite write_file_buf() call and roll it
into your own custom writing", but that is not the case.

So taking the opportunity to clean things up, how about doing it
this way intead?

----- >8 ---------- >8 ---------- >8 -----

Subject: [PATCH] history: streamline message preparation and plug file stream leak

An early part of fill_commit_mmessage() function uses write_file_buf()
to write out what was prepared in a strbuf, which is primarily meant
for use by callers that have their own message prepared fully and
called as the last thing to flush it to the destination file.

However, the function then opens a file stream in append mode to
further write into it.  It may have been understandable if this was
a later addition, but it seems it came from a single commit,
d205234c (builtin/history: implement "reword" subcommand,
2026-01-13), which is somewhat puzzling, but anyway...

Just open the file stream upfront for writing, write the message
the function has in the strbuf, and then keep writing whatever it
wants to write to the same open file stream.

And do not forget to close the stream.  We are about to pass the
resulting file to an external editor, and on some systems, notably
Windows, you are not supposed to keep a file open while expecting
another program to access it.

Diagnosed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/history.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin/history.c b/builtin/history.c
index 8dcb9a6046..a882ad82e5 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -41,11 +41,6 @@ static int fill_commit_message(struct repository *repo,
 		  " empty message aborts the commit.\n");
 	struct wt_status s;
 
-	strbuf_addstr(out, default_message);
-	strbuf_addch(out, '\n');
-	strbuf_commented_addf(out, comment_line_str, hint, action, comment_line_str);
-	write_file_buf(path, out->buf, out->len);
-
 	wt_status_prepare(repo, &s);
 	FREE_AND_NULL(s.branch);
 	s.ahead_behind_flags = AHEAD_BEHIND_QUICK;
@@ -57,14 +52,20 @@ static int fill_commit_message(struct repository *repo,
 	s.whence = FROM_COMMIT;
 	s.committable = 1;
 
-	s.fp = fopen(git_path_commit_editmsg(), "a");
+	s.fp = fopen(path, "w");
 	if (!s.fp)
-		return error_errno(_("could not open '%s'"), git_path_commit_editmsg());
+		return error_errno(_("could not open '%s'"), path);
+
+	strbuf_addstr(out, default_message);
+	strbuf_addch(out, '\n');
+	strbuf_commented_addf(out, comment_line_str, hint, action, comment_line_str);
+	fwrite(out.buf, 1, out.len, s.fp);
 
 	wt_status_collect_changes_trees(&s, old_tree, new_tree);
 	wt_status_print(&s);
 	wt_status_collect_free_buffers(&s);
 	string_list_clear_func(&s.change, change_data_free);
+	fclose(s.fp);
 
 	strbuf_reset(out);
 	if (launch_editor(path, out, NULL)) {
-- 
2.55.0-rc2-165-g3249676ba5

