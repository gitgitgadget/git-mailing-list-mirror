Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA3E820A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 23:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbeLGXHJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 18:07:09 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41590 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLGXHJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 18:07:09 -0500
Received: by mail-pl1-f193.google.com with SMTP id u6so2467495plm.8
        for <git@vger.kernel.org>; Fri, 07 Dec 2018 15:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d9wfaBGz+nbd7f4xmFq9WDfNTTFRNzJ2BW8WlyImJbs=;
        b=sIR+0Vi/5smnAkGvJZ1TohA4n1Q4GKuCGiGpHJLTLUFrN+VBkFXxB7WUhSe4OrwhB4
         nu/SdiGSohRQZZRuTprSXXOC2vww+9efKZ1uXINEDKpQZSv/JOE1PC7bO+DbJbltWLWJ
         /1ohn/HOSR1vAnR0obTAHRipDsnTahEDCgdfqeB6TFKMj67B7nRMwWKZTQVlIxaLt8GF
         aX0x5fi9YBZHgNuTlU1ewPg/GJfswlljfheSKHIb3Pf6sFfSkHVLZLiQiMr8MNGrsi3B
         l1qhkwgeemEN6xGDL/+IZjPJ6oIYBR2qyPamCWt4xnQcSVIzQKdgzP3U9BL+IdzVR9MZ
         LAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d9wfaBGz+nbd7f4xmFq9WDfNTTFRNzJ2BW8WlyImJbs=;
        b=f+iDC5Z57HE310dcuJySWzYbjfynQ1MSVth0Jef0giXCamTnh95AxzOYggNBHnSOg+
         ZIQ6f7wQCklUyTOPJO+YAkfPug2h2WjRX82IeCA9LNaLkD59qzqwdMnDGJCmAwob76M/
         Gl9CPk1EH1icBnminboLzi4Q6oERRYl0YJ6lOBNjeF+JvFgQBsP1mq6upQYIIUagghZC
         yOJ4gokxGuxGDTnu988pdFy8uDTE+7/qU6rIH/tOMSGSLhBrOwyKQLsQ++hBop/lbdYm
         71E8ImRdxwkqSL2be/GQlDCgTK/1HguFd9uUJbz/MMbt/gF3nK7i6enhMmYBeDwkBt3p
         zofg==
X-Gm-Message-State: AA+aEWYw4iQQsYWDx9odFa5HJKTvfmUpkQ/HEOE/XiQ+aCrliUUwV+Kj
        SaBmUOGSyIOA37pNaubJwNC1hbT4
X-Google-Smtp-Source: AFSGD/Xp9MhJzpWpZNaCkW64CQDqUvyjlVPiU7cdx1TcCbxNtQNOnWT8a/Yoi29g4EkPHuslXHbmKg==
X-Received: by 2002:a17:902:9006:: with SMTP id a6mr3852489plp.334.1544224028180;
        Fri, 07 Dec 2018 15:07:08 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id s9sm4638373pgl.88.2018.12.07.15.07.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 15:07:07 -0800 (PST)
Date:   Fri, 7 Dec 2018 15:07:06 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] commit: abort before commit-msg if empty message
Message-ID: <20181207230706.GF73340@google.com>
References: <20181207224817.231957-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207224817.231957-1-jonathantanmy@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jonathan Tan wrote:

> (The implementation in this commit reads the commit message twice even
> if there is no commit-msg hook. I think that this is fine, since this is
> for interactive use - an alternative would be to plumb information about
> the absence of the hook from run_hook_ve() upwards, which seems more
> complicated.)

Sounds like a good followup for an interested person to do later.  Can
you include a NEEDSWORK comment describing this?

> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> This was noticed with the commit-msg hook that comes with Gerrit, which
> basically just calls git interpret-trailers to add a Change-Id trailer.

Thanks for fixing it.

This kind of context tends to be very useful when looking back at a
commit later, so I'd be happy to see it in the commit message too.

[...]
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -652,6 +652,21 @@ static void adjust_comment_line_char(const struct strbuf *sb)
>  	comment_line_char = *p;
>  }
>  
> +static void read_and_clean_commit_message(struct strbuf *sb)
> +{
> +	if (strbuf_read_file(sb, git_path_commit_editmsg(), 0) < 0) {
> +		int saved_errno = errno;
> +		rollback_index_files();
> +		die(_("could not read commit message: %s"), strerror(saved_errno));

Long line.

More importantly, I wonder if this can use die_errno.
rollback_index_files calls delete_tempfile, which can clobber errno, so
that would require restoring errno either here or in that function:

diff --git i/lockfile.h w/lockfile.h
index 35403ccc0d..d592f384e7 100644
--- i/lockfile.h
+++ w/lockfile.h
@@ -298,10 +298,14 @@ static inline int commit_lock_file_to(struct lock_file *lk, const char *path)
  * remove the lockfile. It is a NOOP to call `rollback_lock_file()`
  * for a `lock_file` object that has already been committed or rolled
  * back.
+ *
+ * Saves and restores errno for more convenient use during error handling.
  */
 static inline void rollback_lock_file(struct lock_file *lk)
 {
+	int save_errno = errno;
 	delete_tempfile(&lk->tempfile);
+	errno = save_errno;
 }
 
 #endif /* LOCKFILE_H */

It doesn't make the code more obvious so what you have is probably
better.

Also, on second glance, this is just moved code.  Still hopefully some
of the above is amusing (and rewrapping would be fine to do during the
move).

[...]
> @@ -970,6 +985,22 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  		argv_array_clear(&env);
>  	}
>  
> +	if (use_editor && !no_verify) {
> +		/*
> +		 * Abort the commit if the user supplied an empty commit
> +		 * message in the editor. (Because the commit-msg hook is to be
> +		 * run, we need to check this now, since that hook may change
> +		 * the commit message.)
> +		 */
> +		read_and_clean_commit_message(&sb);
> +		if (message_is_empty(&sb, cleanup_mode) && !allow_empty_message) {
> +			rollback_index_files();
> +			fprintf(stderr, _("Aborting commit due to empty commit message.\n"));
> +			exit(1);

What about the template_untouched case?

Should the two call sites share code?

[...]
> +		}
> +		strbuf_release(&sb);
> +	}
> +
>  	if (!no_verify &&
>  	    run_commit_hook(use_editor, index_file, "commit-msg", git_path_commit_editmsg(), NULL)) {
>  		return 0;

This means we have a little duplication of code: first we check whether
to abort here in prepare_to_commit, and then again after the hook is run
in cmd_commit.

Is there some other code structure that would make things more clear?

cmd_commit also seems to be rather long --- is there some logical way
to split it up that would make the code clearer (as a preparatory or
followup patch)?

In cmd_commit, we spend a while (in number of lines, not actual
running time) to determine parents before deciding whether the user
has chosen to abort by writing an empty message.  Should we perform
that check sooner, closer to the prepare_to_commit call?

> @@ -1608,17 +1639,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  
>  	/* Finally, get the commit message */
>  	strbuf_reset(&sb);
> -	if (strbuf_read_file(&sb, git_path_commit_editmsg(), 0) < 0) {
> -		int saved_errno = errno;
> -		rollback_index_files();
> -		die(_("could not read commit message: %s"), strerror(saved_errno));
> -	}
> -
> -	if (verbose || /* Truncate the message just before the diff, if any. */
> -	    cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS)
> -		strbuf_setlen(&sb, wt_status_locate_end(sb.buf, sb.len));
> -	if (cleanup_mode != COMMIT_MSG_CLEANUP_NONE)
> -		strbuf_stripspace(&sb, cleanup_mode == COMMIT_MSG_CLEANUP_ALL);
> +	read_and_clean_commit_message(&sb);
>  
>  	if (message_is_empty(&sb, cleanup_mode) && !allow_empty_message) {
>  		rollback_index_files();
> diff --git a/t/t7504-commit-msg-hook.sh b/t/t7504-commit-msg-hook.sh
> index 31b9c6a2c1..b44d6fc43e 100755
> --- a/t/t7504-commit-msg-hook.sh
> +++ b/t/t7504-commit-msg-hook.sh
> @@ -122,6 +122,17 @@ test_expect_success 'with failing hook (editor)' '
>  
>  '
>  
> +test_expect_success 'hook is not run if commit message was empty' '
> +	echo "yet more another" >>file &&
> +	git add file &&
> +	echo >FAKE_MSG &&
> +	test_must_fail env GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit 2>err &&
> +
> +	# Verify that git stopped because it saw an empty message, not because
> +	# the hook exited with non-zero error code
> +	test_i18ngrep "Aborting commit due to empty commit message" err
> +'
> +

Nice, makes sense.

Thanks and hope that helps,
Jonathan
