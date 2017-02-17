Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB49520136
	for <e@80x24.org>; Fri, 17 Feb 2017 19:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755655AbdBQT1X (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 14:27:23 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36413 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753335AbdBQT1W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 14:27:22 -0500
Received: by mail-pg0-f68.google.com with SMTP id a123so2848848pgc.3
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 11:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ihT4stip9RzmqfVvroQmyfKPmXroNWEEY0HOPYEcWnU=;
        b=pI6G8eEfWIixnXkQvNUY8ep7jGR3tYjd39FSbGrkStQWuGneS7BfUxtrwTzSJpR9i0
         y35ElPRdoAbltqRKCzqywftJEejFdtnk6oDTJUU/DQ79PL/dlPJBcabWYgS26du6bTXa
         vT2vcQRSKzg+3o0b4FzN9kX2/chr15frMUkZW+YOANy7aY0b7dX23MY6DAFfNPrXfhbN
         +qB4WXAMbmqItSw72DMN5CxvwzHYg3c2FWzOgRm+rG9iy3ldipr2wTFIhzPGT6cDS8FD
         BlHX413hO7KPzN36IJeJLCMz2OnsGlSjGlHczXhLjSxn0x0tp4JCAYX9+smiulpEMlhS
         uECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ihT4stip9RzmqfVvroQmyfKPmXroNWEEY0HOPYEcWnU=;
        b=pWRNmhKDp/TAij3JD74MFh+W/9YtHu2nX/fiKXfc1p0+bgycn9RcKWIcXy47dvQGa9
         Oavvc0I/0/eeFo17GdNpZfp8KwDas8dP53KrsPJJdBYxACorDTtcNgL7GuWX103ls0+p
         NXAVaFMgQusmAJkKTM/FyPCTKZAJt7Y9K4a6qqlEACQpEZa7RvfsQFcrSzVpPMkG5+6c
         O3wcKiGjF4p3oATI3omjG26QlGctleS9Ycbiyi/+SPEsFeSADTepfasIKMsXPYozmnLz
         1d3XVrnrSXo7LjPTTeLg12czUVvKJE223m6m8g5ikG7zr7RybsQ/+amMLWuD2Jla24aD
         e60Q==
X-Gm-Message-State: AMke39mQ90SCTg67AfdYHGuXlVO+n+OnQmZ7qSebsgxU+KpRo4hpipFsUfbesKFTHNva6Q==
X-Received: by 10.98.79.150 with SMTP id f22mr11296245pfj.55.1487359641525;
        Fri, 17 Feb 2017 11:27:21 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3130:38b1:b121:8f0d])
        by smtp.gmail.com with ESMTPSA id u24sm21079677pfi.25.2017.02.17.11.27.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Feb 2017 11:27:19 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org
Subject: Re: [PATCH v3 04/16] files-backend: replace *git_path*() with files_path()
References: <20170216114818.6080-1-pclouds@gmail.com>
        <20170217140436.17336-1-pclouds@gmail.com>
        <20170217140436.17336-5-pclouds@gmail.com>
Date:   Fri, 17 Feb 2017 11:27:18 -0800
In-Reply-To: <20170217140436.17336-5-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Fri, 17 Feb 2017 21:04:24 +0700")
Message-ID: <xmqqlgt4sjmx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> This centralizes all path rewriting of files-backend.c in one place so
> we have easier time removing the path rewriting later. There could be
> some hidden indirect git_path() though, I didn't audit the code to the
> bottom.
>
> Side note: set_worktree_head_symref() is a bad boy and should not be in
> files-backend.c (probably should not exist in the first place). But
> we'll leave it there until we have better multi-worktree support in refs
> before we update it.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  refs/files-backend.c | 185 ++++++++++++++++++++++++++-------------------------
>  1 file changed, 94 insertions(+), 91 deletions(-)

In this step, files_path() is still "if refs->submodule field is
there, then use that to call strbuf_git_path_submodule() and
otherwise call strbuf_git_path()."  That is a very sensible
refactoring for things like packed-refs-file in this hunk:

>  static struct packed_ref_cache *get_packed_ref_cache(struct files_ref_store *refs)
>  {
>  	char *packed_refs_file;
> +	struct strbuf sb = STRBUF_INIT;
>  
> -	if (refs->submodule)
> -		packed_refs_file = git_pathdup_submodule(refs->submodule,
> -							 "packed-refs");
> -	else
> -		packed_refs_file = git_pathdup("packed-refs");
> +	files_path(refs, &sb, "packed-refs");
> +	packed_refs_file = strbuf_detach(&sb, NULL);

But the original code of some other changes do not follow that
pattern, e.g.

> @@ -1585,7 +1578,7 @@ static int lock_raw_ref(struct files_ref_store *refs,
>  	*lock_p = lock = xcalloc(1, sizeof(*lock));
>  
>  	lock->ref_name = xstrdup(refname);
> -	strbuf_git_path(&ref_file, "%s", refname);
> +	files_path(refs, &ref_file, "%s", refname);

Is it the right way to review these changes to make sure that a
conversion from the original that is an unconditional
strbuf_git_path() to files_path() happens only if the function is
"files-assert-main-repository" clean?  lock_raw_ref() certainly is
one of those functions where the caller should not have a non-empty
submodule field in refs.

> @@ -2052,7 +2045,7 @@ static struct ref_lock *lock_ref_sha1_basic(struct files_ref_store *refs,
>  	if (flags & REF_DELETING)
>  		resolve_flags |= RESOLVE_REF_ALLOW_BAD_NAME;
>  
> -	strbuf_git_path(&ref_file, "%s", refname);
> +	files_path(refs, &ref_file, "%s", refname);

So is this one; lock_ref_sha1_basic() is protected with assert-main-repo.

> @@ -2343,7 +2336,7 @@ static int pack_if_possible_fn(struct ref_entry *entry, void *cb_data)
>   * Remove empty parents, but spare refs/ and immediate subdirs.
>   * Note: munges *name.
>   */
> -static void try_remove_empty_parents(char *name)
> +static void try_remove_empty_parents(struct files_ref_store *refs, char *name)
>  {
>  	char *p, *q;
>  	int i;
> @@ -2368,7 +2361,7 @@ static void try_remove_empty_parents(char *name)
>  		if (q == p)
>  			break;
>  		*q = '\0';
> -		strbuf_git_path(&sb, "%s", name);
> +		files_path(refs, &sb, "%s", name);

But here it gets iffy.  try_remove_empty_parents() itself does not
assert, and its sole caller prune_ref() does not, either.  The sole
caller of prune_ref() which is prune_refs() does not.  As we climb
the call chain up, we reach files_pack_refs().  Am I confused to
doubt that the method is inherently main-repo only?

    ... ah, OK, files_downcast() at the beginning of pack_refs
    forbids submodule.  So this is safe.


> @@ -2462,7 +2455,7 @@ static int repack_without_refs(struct files_ref_store *refs,
>  	if (lock_packed_refs(refs, 0)) {
>  		struct strbuf sb = STRBUF_INIT;
>  
> -		strbuf_git_path(&sb, "packed-refs");
> +		files_path(refs, &sb, "packed-refs");

This is safe, as repack_without_refs() asserts that it is main-repo
only.

> @@ -2558,17 +2551,17 @@ static int files_delete_refs(struct ref_store *ref_store,
>   */
>  #define TMP_RENAMED_LOG  "logs/refs/.tmp-renamed-log"
>  
> -static int rename_tmp_log(const char *newrefname)
> +static int rename_tmp_log(struct files_ref_store *refs, const char *newrefname)
>  {

The sole caller files_rename_ref() is main-repo only and that is
guaranteed when downcast is done.

> -static int log_ref_setup(const char *refname, struct strbuf *logfile, struct strbuf *err, int force_create)
> +static int log_ref_setup(struct files_ref_store *refs, const char *refname,
> +			 struct strbuf *logfile, struct strbuf *err,
> +			 int force_create)
>  {
>  	int logfd, oflags = O_APPEND | O_WRONLY;
>  
> -	strbuf_git_path(logfile, "logs/%s", refname);
> +	files_path(refs, logfile, "logs/%s", refname);

This and friends of log_ref_write() eventually rolls up to
commit_ref_update() that has the main-repo only assertion, so they
should be safe.

Another entry point files_create_symref() via create_symref_locked()
also reaches log_ref_write() and friends but the safety is guaranteed
via the downcast that asserts.

OK, overall I really like the loss of "Check the validity but we do
not need the result" with this step.  The same checks are still done
but the code looks much less hacky.

