Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C7FC77B6E
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 13:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjDMNw6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 09:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjDMNwx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 09:52:53 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3C610CC
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 06:52:50 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n9-20020a05600c4f8900b003f05f617f3cso14818895wmq.2
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 06:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681393969; x=1683985969;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kZDHJSwJ3m/ReL3vZf0xAM+9NS+UeBe2gqhFfVtxpa0=;
        b=HKZIXiF0Hr0ddOsMzQ5bPAQdq5JPuveWRfV3/ZWmzGhc6vRLfK/0rLZJtQJUl4KYDL
         DoOycjVgIw6RWxLuRfMEhxgavGuddLYBlpF4kkt76NTWGNQIYg++xmGkb+LWJmC2aYfU
         MFjVC8zdDeP//ixBbSrBjs/7Z/T/ZzcMfGQcPn/6AQllOWMNnZ3h2NEjTNKU2t9/SaoB
         yoMuT4WJTe10IAn6STPxdX/xzGaVY4R+GkKDOqXKt/q/0kgpDoh4nz7+u4cVj1J0yv+w
         a5F6o2xkpJC2FGKJ1GIAahsPn/4Kg+6F5WVLRs0StpzRa9hcD1jgk3O9ZmKZXrkRs2D+
         2kjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681393969; x=1683985969;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kZDHJSwJ3m/ReL3vZf0xAM+9NS+UeBe2gqhFfVtxpa0=;
        b=bzHe22WMbRAGLWKCfR8OLjSf1N+bj1FDqVIkGJZ5xkJ/NopfjBA9dUlw/s2W1AvMPk
         vMdQ6HbtsQ9auzM71o/NJ+G0pKvkZZFf5byj5m2ys0+K7XEqz0f66Uf+bPxci5FPM42I
         IRjjOmxNHtsUV/+9Ir/CaALUGGqZyCtOlL9pVAXSm98VG1fO4HXWN4JaA1b9Zl9YIZzw
         6E66ZB0niJeinOk0WehtnhNiWzu5xaB6yB3QcHpAXjaKVIWuA9VTNRI1wscE3ael4lny
         zUJzM2pwChwUTxq46P19eRylt5PdI8larrayOe9/kDq8GZkj/I09hLYI6x0dt37Tz0dY
         ctPA==
X-Gm-Message-State: AAQBX9e/PEUpJAidI40A2003IRZCmm+cnJ4LLKKvWXuI8EunpB1FPvXv
        PrTXEez4COiyjsWkiYaHtlY=
X-Google-Smtp-Source: AKy350ZDeJAQbvdicxb0ITfQduvT2yxu30kmKcgOlJqlfBQOv6T9LCEjTJdRcXp/XA/8N3e8GFwAlw==
X-Received: by 2002:a05:600c:2904:b0:3ee:3df6:e411 with SMTP id i4-20020a05600c290400b003ee3df6e411mr1806792wmd.28.1681393968792;
        Thu, 13 Apr 2023 06:52:48 -0700 (PDT)
Received: from [192.168.1.212] ([90.253.53.152])
        by smtp.gmail.com with ESMTPSA id u10-20020a7bc04a000000b003f09d7b6e20sm1926794wmc.2.2023.04.13.06.52.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 06:52:48 -0700 (PDT)
Message-ID: <240577d5-3412-5a80-c7d9-e3d277869add@gmail.com>
Date:   Thu, 13 Apr 2023 14:52:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] send-email: export patch counters in validate
 environment
Content-Language: en-US
To:     Robin Jarry <robin@jarry.cc>, git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Tim Culverhouse <tim@timculverhouse.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Michael Strawbridge <michael.strawbridge@amd.com>
References: <20230412095434.140754-1-robin@jarry.cc>
 <20230412214502.90174-1-robin@jarry.cc>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230412214502.90174-1-robin@jarry.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Robin

On 12/04/2023 22:45, Robin Jarry wrote:
> When sending patch series (with a cover-letter or not)
> sendemail-validate is called with every email/patch file independently
> from the others. When one of the patches depends on a previous one, it
> may not be possible to use this hook in a meaningful way. A hook that
> wants to check some property of the whole series needs to know which
> patch is the final one.
> 
> Expose the current and total number of patches to the hook via the
> GIT_SENDEMAIL_PATCH_COUNTER and GIT_SENDEMAIL_PATCH_TOTAL environment
> variables so that both incremental and global validation is possible.
> 
> Sharing any other state between successive invocations of the validate
> hook must be done via external means. For example, by storing it in
> a git config sendemail.validateWorktree entry.
> 
> Add a sample script with placeholders for validation.
> 
> Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
> Signed-off-by: Robin Jarry <robin@jarry.cc>
> ---
> 
> Notes:
>      v2 -> v3:
>      
>      * Fixed style in sample script following Documentation/CodingGuidelines
>      * Used git worktree instead of a shallow clone.
>      * Removed set -e and added explicit error handling.
>      * Reworded some comments.

I think the documentation and implementation look good, I've left a 
comment about the example hook below. As Junio has previously mentioned, 
it would be nice to have a test with this patch.

> diff --git a/templates/hooks--sendemail-validate.sample b/templates/hooks--sendemail-validate.sample
> new file mode 100755
> index 000000000000..f6dbaa24ad57
> --- /dev/null
> +++ b/templates/hooks--sendemail-validate.sample
> @@ -0,0 +1,71 @@
> +#!/bin/sh
> +
> +# An example hook script to validate a patch (and/or patch series) before
> +# sending it via email.
> +#
> +# The hook should exit with non-zero status after issuing an appropriate
> +# message if it wants to prevent the email(s) from being sent.
> +#
> +# To enable this hook, rename this file to "sendemail-validate".
> +#
> +# By default, it will only check that the patch(es) can be applied on top of
> +# the default upstream branch without conflicts. Replace the XXX placeholders
> +# with appropriate checks according to your needs.
> +
> +validate_cover_letter() {
> +	file="$1"
> +	# XXX: Add appropriate checks (e.g. spell checking).
> +}
> +
> +validate_patch() {
> +	file="$1"
> +	# Ensure that the patch applies without conflicts.
> +	git am -3 "$file" || return
> +	# XXX: Add appropriate checks for this patch (e.g. checkpatch.pl).
> +}
> +
> +validate_series() {
> +	# XXX: Add appropriate checks for the whole series
> +	# (e.g. quick build, coding style checks, etc.).
> +}
> +
> +get_worktree() {
> +	if ! git config --get sendemail.validateWorktree
> +	then
> +		# Initialize it to a temp dir, if unset.
> +		worktree=$(mktemp --tmpdir -d sendemail-validate.XXXXXXX) &&
> +		git config --add sendemail.validateWorktree "$worktree" &&
> +		echo "$worktree"
> +	fi
> +}
> +
> +die() {
> +	echo "sendemail-validate: error: $*" >&2
> +	exit 1
> +}
> +
> +# main -------------------------------------------------------------------------
> +
> +worktree=$(get_worktree) &&
> +if test "$GIT_SENDEMAIL_FILE_COUNTER" = 1
> +then
> +	# ignore error if not a worktree
> +	git worktree remove -f "$worktree" 2>/dev/null || :

Now that you've got rid of "set -e" I don't think we need "|| :". I had 
expected that we'd always create a new worktree on the first patch in a 
series and remove it after processing the the last patch in the series, 
but this seems to leave it in place until the next time send-email is 
run or /tmp gets cleaned up. Also if I've understood it correctly the 
name is set the first time this hook is run, rather than generating a 
new name for each set of files that is validated.

Best Wishes

Phillip

> +	echo "sendemail-validate: worktree $worktree"
> +	git worktree add -fd --checkout "$worktree" refs/remotes/origin/HEAD
> +fi || die "failed to prepare worktree for validation"
> +
> +unset GIT_DIR GIT_WORK_TREE
> +cd "$worktree" &&
> +
> +if grep -q "^diff --git " "$1"
> +then
> +	validate_patch "$1"
> +else
> +	validate_cover_letter "$1"
> +fi &&
> +
> +if test "$GIT_SENDEMAIL_FILE_COUNTER" = "$GIT_SENDEMAIL_FILE_TOTAL"
> +then
> +	validate_series
> +fi
