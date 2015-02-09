From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 04/11] ref_transaction_update(): remove "have_old" parameter
Date: Mon, 9 Feb 2015 10:20:16 -0800
Message-ID: <CAGZ79kbbRdqd+EnJD3Opfc5Luf-1FnEarUpTnXAiKoxh-pqc1Q@mail.gmail.com>
References: <1423412045-15616-1-git-send-email-mhagger@alum.mit.edu>
	<1423412045-15616-5-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Feb 09 19:20:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKswb-0004fv-Da
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 19:20:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933602AbbBISUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 13:20:19 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:56151 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933233AbbBISUR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 13:20:17 -0500
Received: by mail-ig0-f172.google.com with SMTP id l13so18208075iga.5
        for <git@vger.kernel.org>; Mon, 09 Feb 2015 10:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8SHx7wUmKS+RUMf1wTINOCzlSYl5f0J8ISKwtDeYgg8=;
        b=KERtS4gQxV5zHAu3/bcjaQttT3hWgx+CG5F+BmUf9fy90I9ybAq3ehADSAn69J+D3c
         +yKzFOaoWg1gxZ347+Ehk2PXagojC0UUpgOPgqtjXdvg3zQRQURxPMnuuSF/HD33D4oV
         JO/oqFbmaKapPg2fkdafg3CzaEGxWVLGB9YbBSCYIuDc6p4b67j4qsC1xTEfW/i49TOw
         5oQiEyi+H7jQPEqcbud0OYROlpN4zuVZue0O4trcHP8OcWwdQGAVhdQUG0GboFwIloVd
         mqgMxrfe7wiW76uhlP3cgOcAxK9Anvyx+YEARJvbJ61nOsa6VY5abJE6miJ+OVbm6YY3
         wnXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=8SHx7wUmKS+RUMf1wTINOCzlSYl5f0J8ISKwtDeYgg8=;
        b=JvrzTDBv/MSkkT5qjTLWYjT5jbBuGQKDpj2/PCZOOQsFAcB4wyUnIzablwcF2Yxoku
         7JV8NIakxovtVHCL530xdREzKayLQCUOKvmV5nbiBhyH/5tJj7iu40Q+PAngyBUx50EE
         r/N7O4s+uUPefb3WYY5i2RgTXYH6AIOhJNUWGK/bKPuJVwbRbL0oSfPIJZV3HyIpoFqP
         qcV0Hb3t/J6j63CaEDJ4HpLeG/hDSoBcOTS7QuKOmhY8xibllFm1Irg4GPtECdr/wD7K
         GUalqgw1QtwnxBkIAOReeoAwKhNOMjfb/MY4hksz3B+o497fn2JFE52FEzBJdQc/dO2p
         xP6Q==
X-Gm-Message-State: ALoCoQm6EAiEJ+pEgzuBsiCX7DT3CP5i0Qz+OXiB9CUKqYABDCvvLDmAnEYSn/7Ym/wpvIAcnMxj
X-Received: by 10.107.137.17 with SMTP id l17mr7238258iod.33.1423506016852;
 Mon, 09 Feb 2015 10:20:16 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Mon, 9 Feb 2015 10:20:16 -0800 (PST)
In-Reply-To: <1423412045-15616-5-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263571>

On Sun, Feb 8, 2015 at 8:13 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Instead, if old_sha1 is non-NULL, verify it; otherwise, don't.

parsing error on that commit message. I needed to read the code to understand
what you want to say here.
The code itself is

Reviewed-by: Stefan Beller <sbeller@google.com>

>
> ref_transaction_delete() will get the same treatment in a moment.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  branch.c               |  5 +++--
>  builtin/commit.c       |  2 +-
>  builtin/fetch.c        |  6 ++++--
>  builtin/receive-pack.c |  2 +-
>  builtin/replace.c      |  2 +-
>  builtin/tag.c          |  2 +-
>  builtin/update-ref.c   |  7 ++++---
>  fast-import.c          |  6 +++---
>  refs.c                 | 18 ++++++++----------
>  refs.h                 |  6 +++---
>  sequencer.c            |  2 +-
>  walker.c               |  2 +-
>  12 files changed, 31 insertions(+), 29 deletions(-)
>
> diff --git a/branch.c b/branch.c
> index 4bab55a..b002435 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -284,8 +284,9 @@ void create_branch(const char *head,
>
>                 transaction = ref_transaction_begin(&err);
>                 if (!transaction ||
> -                   ref_transaction_update(transaction, ref.buf, sha1,
> -                                          null_sha1, 0, !forcing, msg, &err) ||
> +                   ref_transaction_update(transaction, ref.buf,
> +                                          sha1, forcing ? NULL : null_sha1,
> +                                          0, msg, &err) ||
>                     ref_transaction_commit(transaction, &err))
>                         die("%s", err.buf);
>                 ref_transaction_free(transaction);
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 7d90c35..5654abd 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1773,7 +1773,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>             ref_transaction_update(transaction, "HEAD", sha1,
>                                    current_head
>                                    ? current_head->object.sha1 : NULL,
> -                                  0, !!current_head, sb.buf, &err) ||
> +                                  0, sb.buf, &err) ||
>             ref_transaction_commit(transaction, &err)) {
>                 rollback_index_files();
>                 die("%s", err.buf);
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 7b84d35..719bf4f 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -416,8 +416,10 @@ static int s_update_ref(const char *action,
>
>         transaction = ref_transaction_begin(&err);
>         if (!transaction ||
> -           ref_transaction_update(transaction, ref->name, ref->new_sha1,
> -                                  ref->old_sha1, 0, check_old, msg, &err))
> +           ref_transaction_update(transaction, ref->name,
> +                                  ref->new_sha1,
> +                                  check_old ? ref->old_sha1 : NULL,
> +                                  0, msg, &err))
>                 goto fail;
>
>         ret = ref_transaction_commit(transaction, &err);
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 4e85e25..71be82e 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -951,7 +951,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
>                 if (ref_transaction_update(transaction,
>                                            namespaced_name,
>                                            new_sha1, old_sha1,
> -                                          0, 1, "push",
> +                                          0, "push",
>                                            &err)) {
>                         rp_error("%s", err.buf);
>                         strbuf_release(&err);
> diff --git a/builtin/replace.c b/builtin/replace.c
> index 85d39b5..54bf01a 100644
> --- a/builtin/replace.c
> +++ b/builtin/replace.c
> @@ -172,7 +172,7 @@ static int replace_object_sha1(const char *object_ref,
>         transaction = ref_transaction_begin(&err);
>         if (!transaction ||
>             ref_transaction_update(transaction, ref, repl, prev,
> -                                  0, 1, NULL, &err) ||
> +                                  0, NULL, &err) ||
>             ref_transaction_commit(transaction, &err))
>                 die("%s", err.buf);
>
> diff --git a/builtin/tag.c b/builtin/tag.c
> index e633f4e..232c28c 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -733,7 +733,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>         transaction = ref_transaction_begin(&err);
>         if (!transaction ||
>             ref_transaction_update(transaction, ref.buf, object, prev,
> -                                  0, 1, NULL, &err) ||
> +                                  0, NULL, &err) ||
>             ref_transaction_commit(transaction, &err))
>                 die("%s", err.buf);
>         ref_transaction_free(transaction);
> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
> index 1993529..f0db7a3 100644
> --- a/builtin/update-ref.c
> +++ b/builtin/update-ref.c
> @@ -198,8 +198,9 @@ static const char *parse_cmd_update(struct ref_transaction *transaction,
>         if (*next != line_termination)
>                 die("update %s: extra input: %s", refname, next);
>
> -       if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
> -                                  update_flags, have_old, msg, &err))
> +       if (ref_transaction_update(transaction, refname,
> +                                  new_sha1, have_old ? old_sha1 : NULL,
> +                                  update_flags, msg, &err))
>                 die("%s", err.buf);
>
>         update_flags = 0;
> @@ -297,7 +298,7 @@ static const char *parse_cmd_verify(struct ref_transaction *transaction,
>                 die("verify %s: extra input: %s", refname, next);
>
>         if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
> -                                  update_flags, 1, msg, &err))
> +                                  update_flags, msg, &err))
>                 die("%s", err.buf);
>
>         update_flags = 0;
> diff --git a/fast-import.c b/fast-import.c
> index d0bd285..1e72bfb 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -1716,7 +1716,7 @@ static int update_branch(struct branch *b)
>         transaction = ref_transaction_begin(&err);
>         if (!transaction ||
>             ref_transaction_update(transaction, b->name, b->sha1, old_sha1,
> -                                  0, 1, msg, &err) ||
> +                                  0, msg, &err) ||
>             ref_transaction_commit(transaction, &err)) {
>                 ref_transaction_free(transaction);
>                 error("%s", err.buf);
> @@ -1756,8 +1756,8 @@ static void dump_tags(void)
>                 strbuf_reset(&ref_name);
>                 strbuf_addf(&ref_name, "refs/tags/%s", t->name);
>
> -               if (ref_transaction_update(transaction, ref_name.buf, t->sha1,
> -                                          NULL, 0, 0, msg, &err)) {
> +               if (ref_transaction_update(transaction, ref_name.buf,
> +                                          t->sha1, NULL, 0, msg, &err)) {
>                         failure |= error("%s", err.buf);
>                         goto cleanup;
>                 }
> diff --git a/refs.c b/refs.c
> index 851c9f8..6beafcf 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3655,7 +3655,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
>                            const char *refname,
>                            const unsigned char *new_sha1,
>                            const unsigned char *old_sha1,
> -                          int flags, int have_old, const char *msg,
> +                          int flags, const char *msg,
>                            struct strbuf *err)
>  {
>         struct ref_update *update;
> @@ -3665,9 +3665,6 @@ int ref_transaction_update(struct ref_transaction *transaction,
>         if (transaction->state != REF_TRANSACTION_OPEN)
>                 die("BUG: update called for transaction that is not open");
>
> -       if (have_old && !old_sha1)
> -               die("BUG: have_old is true but old_sha1 is NULL");
> -
>         if (!is_null_sha1(new_sha1) &&
>             check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
>                 strbuf_addf(err, "refusing to update ref with bad name %s",
> @@ -3677,7 +3674,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
>
>         update = add_update(transaction, refname);
>         hashcpy(update->new_sha1, new_sha1);
> -       if (have_old) {
> +       if (old_sha1) {
>                 hashcpy(update->old_sha1, old_sha1);
>                 flags |= REF_HAVE_OLD;
>         }
> @@ -3694,7 +3691,7 @@ int ref_transaction_create(struct ref_transaction *transaction,
>                            struct strbuf *err)
>  {
>         return ref_transaction_update(transaction, refname, new_sha1,
> -                                     null_sha1, flags, 1, msg, err);
> +                                     null_sha1, flags, msg, err);
>  }
>
>  int ref_transaction_delete(struct ref_transaction *transaction,
> @@ -3703,8 +3700,9 @@ int ref_transaction_delete(struct ref_transaction *transaction,
>                            int flags, int have_old, const char *msg,
>                            struct strbuf *err)
>  {
> -       return ref_transaction_update(transaction, refname, null_sha1,
> -                                     old_sha1, flags, have_old, msg, err);
> +       return ref_transaction_update(transaction, refname,
> +                                     null_sha1, have_old ? old_sha1 : NULL,
> +                                     flags, msg, err);
>  }
>
>  int update_ref(const char *action, const char *refname,
> @@ -3716,8 +3714,8 @@ int update_ref(const char *action, const char *refname,
>
>         t = ref_transaction_begin(&err);
>         if (!t ||
> -           ref_transaction_update(t, refname, sha1, oldval, flags,
> -                                  !!oldval, action, &err) ||
> +           ref_transaction_update(t, refname, sha1, oldval,
> +                                  flags, action, &err) ||
>             ref_transaction_commit(t, &err)) {
>                 const char *str = "update_ref failed for ref '%s': %s";
>
> diff --git a/refs.h b/refs.h
> index 9bf2148..f05ac89 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -265,8 +265,8 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
>  /*
>   * Add a reference update to transaction.  new_sha1 is the value that
>   * the reference should have after the update, or null_sha1 if it should
> - * be deleted.  If have_old is true, then old_sha1 holds the value
> - * that the reference should have had before the update, or zeros if
> + * be deleted.  If old_sha1 is non-NULL, then it the value
> + * that the reference should have had before the update, or null_sha1 if
>   * it must not have existed beforehand.
>   * Function returns 0 on success and non-zero on failure. A failure to update
>   * means that the transaction as a whole has failed and will need to be
> @@ -276,7 +276,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
>                            const char *refname,
>                            const unsigned char *new_sha1,
>                            const unsigned char *old_sha1,
> -                          int flags, int have_old, const char *msg,
> +                          int flags, const char *msg,
>                            struct strbuf *err);
>
>  /*
> diff --git a/sequencer.c b/sequencer.c
> index 77a1266..32aa05e 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -252,7 +252,7 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
>         if (!transaction ||
>             ref_transaction_update(transaction, "HEAD",
>                                    to, unborn ? null_sha1 : from,
> -                                  0, 1, sb.buf, &err) ||
> +                                  0, sb.buf, &err) ||
>             ref_transaction_commit(transaction, &err)) {
>                 ref_transaction_free(transaction);
>                 error("%s", err.buf);
> diff --git a/walker.c b/walker.c
> index f149371..34881b0 100644
> --- a/walker.c
> +++ b/walker.c
> @@ -299,7 +299,7 @@ int walker_fetch(struct walker *walker, int targets, char **target,
>                 strbuf_reset(&refname);
>                 strbuf_addf(&refname, "refs/%s", write_ref[i]);
>                 if (ref_transaction_update(transaction, refname.buf,
> -                                          &sha1[20 * i], NULL, 0, 0,
> +                                          &sha1[20 * i], NULL, 0,
>                                            msg ? msg : "fetch (unknown)",
>                                            &err)) {
>                         error("%s", err.buf);
> --
> 2.1.4
>
