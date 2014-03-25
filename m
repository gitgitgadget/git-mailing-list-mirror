From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 1/2] fsck.c: modify fsck_ident() and fsck_commit()
Date: Tue, 25 Mar 2014 02:50:47 -0400
Message-ID: <CAPig+cQg_GRwSpQb53OYHcu6=9B+9QhwBSCRasq5jN+-QHjoDg@mail.gmail.com>
References: <1395662901-10617-1-git-send-email-ajha.dev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Ashwin Jha <ajha.dev@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 07:51:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSLCy-0002O4-EZ
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 07:51:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbaCYGvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2014 02:51:10 -0400
Received: from mail-yh0-f47.google.com ([209.85.213.47]:65196 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466AbaCYGur (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 02:50:47 -0400
Received: by mail-yh0-f47.google.com with SMTP id 29so26079yhl.20
        for <git@vger.kernel.org>; Mon, 24 Mar 2014 23:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=qZpCu/eQWJjunP7AY3wta+q3PCjIVMzkx6F8ZXz++Kk=;
        b=d0DS8FX6AdmiVus0LilgI5RiU8iBQwIq8PUvzPyPFgf7qp2WwYWYr8ABW+Bjen2NI8
         CEf36huHbXP5x1trEoTQRmnbn9/XBQSfV+7UKhtF0iOz9iGHf186TQOxCze7GXtbJOeA
         w9foAv6cZj3RSKSVI41ZREKy82EvjA8hDgyjRj3CP+JSmh3yQ1OJ8l0jRJp3HjOj5GYC
         SwpYGZllBDQBAER5PCLLY4DM3mJ4twMwjur1V2QCrk0/zdf3vtUAyzhkA0bgbBkNr6x8
         C+XQm85NplnDXYQnuzZfrpKbNoby0w6yR42avNyHRkRifOhAa7aMgV3a3ltU0TV7oI2F
         R++g==
X-Received: by 10.236.142.48 with SMTP id h36mr70740470yhj.49.1395730247249;
 Mon, 24 Mar 2014 23:50:47 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Mon, 24 Mar 2014 23:50:47 -0700 (PDT)
In-Reply-To: <1395662901-10617-1-git-send-email-ajha.dev@gmail.com>
X-Google-Sender-Auth: m2Cc1SP4cT9JsbdTYGEPxp5PqhE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244907>

On Mon, Mar 24, 2014 at 8:08 AM, Ashwin Jha <ajha.dev@gmail.com> wrote:
> Subject: fsck.c: modify fsck_ident() and fsck_commit()

The subject should summarize the change while being concise and
expressive. The above is a bit lacking. A better subject might be:

    Subject: fsck: add missing 'const's

> In fsck_ident(): Replace argument char **ident with const char **ident
> In fsck_commit(): Replace char *buffer with const char *buffer

No need to repeat in prose what the patch itself already states more
concisely and precisely. You can drop this part.

> In both the cases, referenced memory addresses are not modified. So, it
> will be a good practice, to declare them as const.

The subject suggested above ("add missing 'const's") implies that the
referenced memory is never modified, so it's not really necessary to
explain it here too. Stating that it's good practice may be a
reasonable way to justify the change, although is also rather obvious.
I'd say that the suggested subject alone is a sufficient commit
message for this patch, though you and/or Junio might feel otherwise.

> Signed-off-by: Ashwin Jha <ajha.dev@gmail.com>
> ---
>
> Change in fsck_commit() and fsck_ident() as per the discussion with
> Eric (follow at [1]).
> [1]: http://git.661346.n2.nabble.com/PATCH-Modify-fsck-commit-Replace-memcmp-by-skip-prefix-td7606321.html

Providing a link to the previous attempt is indeed courteous to
reviewers. Since reviewer time is precious (due to this being a
high-volume mailing list), it is possible to be even more helpful by
providing more detail in your summary of changes. For instance,
instead of saying "Change in ... as per discussion", you might say:

    Changes since v2 [1]:

    Expanded to 2-patch series.

    patch 1/1: add missing 'const's to fsck_ident() argument and
    fsck_commit() 'buffer' variable so that 2/2 doesn't have to
    cast-away constness from the result of skip_prefix().

    patch 2/2: dropped the now unnecessary casts

The patch itself looks fine, thanks.

>  fsck.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fsck.c b/fsck.c
> index 64bf279..b5f017f 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -243,7 +243,7 @@ static int fsck_tree(struct tree *item, int strict, fsck_error error_func)
>         return retval;
>  }
>
> -static int fsck_ident(char **ident, struct object *obj, fsck_error error_func)
> +static int fsck_ident(const char **ident, struct object *obj, fsck_error error_func)
>  {
>         char *end;
>
> @@ -284,7 +284,7 @@ static int fsck_ident(char **ident, struct object *obj, fsck_error error_func)
>
>  static int fsck_commit(struct commit *commit, fsck_error error_func)
>  {
> -       char *buffer = commit->buffer;
> +       const char *buffer = commit->buffer;
>         unsigned char tree_sha1[20], sha1[20];
>         struct commit_graft *graft;
>         int parents = 0;
> --
> 1.9.1
