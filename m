From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 1/2] refs: add a new function set_worktree_head_symref
Date: Thu, 7 Apr 2016 17:20:10 -0400
Message-ID: <CAPig+cQym57U-izza5_Hn0xCDcG0MHFMcWJFc==ohKnr7acFWQ@mail.gmail.com>
References: <1458553816-29091-1-git-send-email-k@rhe.jp>
	<cover.1459087958.git.k@rhe.jp>
	<39bc3c1da6daf31f2a10e592dbb5d3daadc96199.1459087958.git.k@rhe.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Kazuki Yamaguchi <k@rhe.jp>
X-From: git-owner@vger.kernel.org Thu Apr 07 23:20:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoHLe-0003FF-TV
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 23:20:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757536AbcDGVUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 17:20:13 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:32811 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757447AbcDGVUM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 17:20:12 -0400
Received: by mail-io0-f196.google.com with SMTP id g185so14004925ioa.0
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 14:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=Y0Hkyl813tz2B33mwPtItfByi15Skj4VpEgvxxBEO0g=;
        b=shQdtKI2IIYDZCAz1VP28NPBWBRpXbqdRfRJVfbeOJJM3UD0HCh7C+HZpHj6J/sVgL
         L5E4WEPTX81pFoesrVqUAjnjaoXBiHNEOZ3drAwpVZbclLDXGoEX9PHnLVLCeDs7vZmD
         eDzW6tUEBkz7c5fCxOjOlz9KlQ6qPDaSkACabItykWo7tAFf605KM/YZGZFBVmqiMI0v
         /KBioWcL4i58EWvT+L1TXxazotuNyDy47OnXmuOlfWkoR3UI8zZ6LKt3y6JiBd2Y17io
         xehZGFYbsrrjMYoS54h+2vhExtOlZObmxQzUWkxCVJLfOTY4XGOK1nah8WWECp71chfm
         WiWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Y0Hkyl813tz2B33mwPtItfByi15Skj4VpEgvxxBEO0g=;
        b=fgYIgUZXXOtVyp6KRhpVnRzlQgMtxnvDJz4n9EFsLyRMkgP8u1Q1arTCq7mQb1csuL
         GJwPRNRfUkrK5JSMBlxFynYNn1sDVSSMBP1TqbGQD7kC5k7uQ4JRDwP391jZ6TI1uDMF
         OY25n6B0H6jNB9E7TI7RBJ4qTXusbg8VpHxBAqTFiozPzybTC7huHAQw2IyG5a7Xptzh
         8nlow1IiI6tvgNKsHsBti6SPrBYSEJOSdHh+ifEkv+q4qvVfW8SqF4zxK4mPEXB+PZyd
         YsA4n9REIOylYQQb+USHy9aRvww28LOo41rJzNerAjbAV6lhCvEJ1FR8LArKEMWsIR5y
         vfUw==
X-Gm-Message-State: AD7BkJKfq95bUEl3Lb0Y/BO4XDx5wwJVUzDefGg8LlH3hd1kl6CgFZQPv+3ZkMKMNktYf67OvprhAswqJ1FdWQ==
X-Received: by 10.107.47.41 with SMTP id j41mr5366944ioo.168.1460064010877;
 Thu, 07 Apr 2016 14:20:10 -0700 (PDT)
Received: by 10.79.139.2 with HTTP; Thu, 7 Apr 2016 14:20:10 -0700 (PDT)
In-Reply-To: <39bc3c1da6daf31f2a10e592dbb5d3daadc96199.1459087958.git.k@rhe.jp>
X-Google-Sender-Auth: jIOlR3vmZFybgQENmwh_FIgbMHU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290989>

On Sun, Mar 27, 2016 at 10:37 AM, Kazuki Yamaguchi <k@rhe.jp> wrote:
> Add a new function set_worktree_head_symref, to update HEAD symref for
> the specified worktree.
>
> To update HEAD of a linked working tree,
> create_symref("worktrees/$work_tree/HEAD", "refs/heads/$branch", msg)
> could be used. However when it comes to updating HEAD of the main
> working tree, it is unusable because it uses $GIT_DIR for
> worktree-specific symrefs (HEAD).
>
> The new function takes git_dir (real directory) as an argument, and
> updates HEAD of the working tree. This function will be used when
> renaming a branch.
>
> Signed-off-by: Kazuki Yamaguchi <k@rhe.jp>
> ---
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> @@ -2894,6 +2894,41 @@ int create_symref(const char *refname, const char *target, const char *logmsg)
> +int set_worktree_head_symref(const char *gitdir, const char *target)
> +{
> +       static struct lock_file head_lock;
> +       struct ref_lock *lock;
> +       struct strbuf err = STRBUF_INIT;
> +       struct strbuf head_path = STRBUF_INIT;
> +       const char *head_rel;
> +       int ret;
> +
> +       strbuf_addf(&head_path, "%s/HEAD", absolute_path(gitdir));
> +       if (hold_lock_file_for_update(&head_lock, head_path.buf,
> +                                     LOCK_NO_DEREF) < 0) {
> +               error("%s", err.buf);

'err' has not been populated at this point, so I suspect that this
error message is likely to be rather uninformative.

> +               strbuf_release(&err);
> +               strbuf_release(&head_path);
> +               return -1;
> +       }
> +
> +       /* head_rel will be "HEAD" for the main tree, "worktrees/wt/HEAD" for
> +          linked trees */
> +       head_rel = remove_leading_path(head_path.buf,
> +                                      absolute_path(get_git_common_dir()));
> +       /* to make use of create_symref_locked(), initialize ref_lock */
> +       lock = xcalloc(1, sizeof(struct ref_lock));
> +       lock->lk = &head_lock;
> +       lock->ref_name = xstrdup(head_rel);
> +       lock->orig_ref_name = xstrdup(head_rel);
> +
> +       ret = create_symref_locked(lock, head_rel, target, NULL);
> +
> +       unlock_ref(lock); /* will free lock */
> +       strbuf_release(&head_path);
> +       return ret;
> +}
> +
