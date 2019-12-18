Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B10DC43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 03:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0F72206EE
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 03:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U7yCDOrT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfLRDNn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 22:13:43 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:39537 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbfLRDNn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 22:13:43 -0500
Received: by mail-pg1-f201.google.com with SMTP id v2so307347pgv.6
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 19:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1lAAevH96QvMnoqS94h0blX9DGeuqGAWzL6Gs9/OeZI=;
        b=U7yCDOrT5eLnXtYaU9Brcz8/JOzrdRXrA5Gl/doWnqWC8GhzXlC2WUYKaY11OIHm0v
         sv8ItLUGNNxfxxSTac9/S8CCQxyX8h400K+0pQ0BWvRRTanQbCIhS5fz/nRhT+x1c7Mf
         YHTeV0ZN+00qH2Ig7FEqL9QUGbZzJLtqixA0faObDfqPrTK4CcCAghwDOgI3CFBoeXid
         Kp33VarV/w7e4y0CBYZhJLdljbJf6iNPwhDS/4uxk8igvUr3v5siYfvegPDcS/nEzt1S
         3quYUWanvS1dXQTkgkMAdprBr2ciy4jjJm2AYiiwV6tceiwpwGWf6yQ0Y9RfK1eDvPsK
         sIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1lAAevH96QvMnoqS94h0blX9DGeuqGAWzL6Gs9/OeZI=;
        b=bGQhdsIAhaz48OkhW3CDzZ5uvWmRVUC0SIQrMoav+A/z5IkFiqmBNoBEJ2j4AoDNv7
         QcdI5pnTW4ZUI0q1WAyyrIWMKQog1CXuEmOPIDHza3qyBeARdar02/+IOkdHncKbRiZo
         B6gjWvCqgiWyfFCUzKzqoJ7jSG8QBi6Z34eJid/mkhQRaPFLl/32/s7KcBReR4E8jvPq
         Glkn+x2F6raqPDnpAY+NOnDy8AgqsqGcxfvVKhKnXtB9plRiDt+xqBb+L3SM3zr0QJb8
         X0CqKH/V8IsF/HOXy8fL6wWpiBTV2sErqGM3IlzTZhsIiWAXUrBR454BCbnwmbkmDXoD
         ce4Q==
X-Gm-Message-State: APjAAAX+n4TSyxrvfUZMBd+96QqjLRjFEqZWEpr1D+7GEWVM8taFIkBh
        ss7A9GJ2crKEGG+Te2EdJZZWUIg/Qn89JJtlPouG
X-Google-Smtp-Source: APXvYqzuG9Z2GyvGh3FtxSI/wNmKTNeKeQbT/7H2lz+3iatEjrJ3kTozguhC4kU+YeqAXwm+FgqWoSMqF4JEqfQ63xPV
X-Received: by 2002:a63:1c5e:: with SMTP id c30mr346210pgm.30.1576638822085;
 Tue, 17 Dec 2019 19:13:42 -0800 (PST)
Date:   Tue, 17 Dec 2019 19:13:38 -0800
In-Reply-To: <f23477c5a32e5d638310024194040146026972b8.1576574242.git.gitgitgadget@gmail.com>
Message-Id: <20191218031338.203382-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <f23477c5a32e5d638310024194040146026972b8.1576574242.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: Re: [PATCH 1/1] commit: display advice hints when commit fails
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, heba.waly@gmail.com, gitster@pobox.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Heba Waly <heba.waly@gmail.com>
> 
> Display hints to the user when trying to commit without staging the modified
> files first (when advice.statusHints is set to true). Change the output of the
> unsuccessful commit from e.g:

Wrap your commit messages at 72 characters.

>   # [...]
>   # Changes not staged for commit:
>   #   modified:   builtin/commit.c
>   #
>   # no changes added to commit
> 
> to:
> 
>   # [...]
>   # Changes not staged for commit:
>   #   (use "git add <file>..." to update what will be committed)
>   #   (use "git checkout -- <file>..." to discard changes in working directory)
>   #
>   #   modified:   ../builtin/commit.c

For tidiness, can this line also be "builtin/commit.c" (that is, without
the "../" at the beginning) to match what's before "to:"?

> In ea9882bfc4 (commit: disable status hints when writing to COMMIT_EDITMSG,
> 2013-09-12) the intent was to disable status hints when writing to
> COMMIT_EDITMSG, but in fact the implementation disabled status messages in
> more locations, e.g in case the commit wasn't successful, status hints
> will still be disabled and no hints will be displayed to the user although
> advice.statusHints is set to true.
> 
> Signed-off-by: Heba Waly <heba.waly@gmail.com>
> ---
>  builtin/commit.c                          | 1 +
>  t/t7500-commit-template-squash-signoff.sh | 9 +++++++++

I wondered if there was a better place to put the test, but I couldn't
find one, so this is fine.

> @@ -961,6 +961,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  	 */
>  	if (!committable && whence != FROM_MERGE && !allow_empty &&
>  	    !(amend && is_a_merge(current_head))) {
> +		s->hints = advice_status_hints;
>  		s->display_comment_prefix = old_display_comment_prefix;
>  		run_status(stdout, index_file, prefix, 0, s);
>  		if (amend)

I checked that this undoing of "s->hints = 0" is safe, because s is no
longer used in this function nor in the calling function cmd_commit()
(which is the one that declared s locally).

Still probably worth a comment, though. For example:

  This status is to be printed to stdout, so hints will be useful to the
  user. Reset s->hints to what the user configured.

The corresponding comment on "s->hints = 0" might need to be tweaked,
too, but I can't think of anything at the moment.

> +test_expect_success 'commit without staging files fails and displays hints' '
> +	echo "initial" >>file &&
> +	git add file &&
> +	git commit -m initial &&
> +	echo "changes" >>file &&
> +	test_must_fail git commit -m initial >actual &&

Use another commit message for this, since this is no longer "initial".
(Maybe "after initial" or something like that.)
