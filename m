Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A388FC6FD1F
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 22:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjCIWQU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 17:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjCIWQQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 17:16:16 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A5D1B314
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 14:16:15 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so7762193pjb.3
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 14:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678400175;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+PpqHYgK6ua0cI72c9TbEtD8LO0JOYAL/VdlhjqaYAM=;
        b=N77S7jQRDE4bw+CkZhMTJ0qEiTrYmf0l5yaB4jwLPHr4ROxV64YORWNUqQ1LMIvgOo
         25xvk2ZWmXpkPfTeRPe64Apbjsbr0qjG3NaoV7vMCLLwD2FhNi3BuOL7Jk5AYg601ahx
         hdQhrjzW8p8NUfdBfIv0oFm6zv2UW55erfcf/0g6YXjwJNPxMjoNRGgnapw25J1qyFQe
         HC4YPdrcNxkjIHzeGWFLrZxcSArTW6IGg3mqrEFP9bGQKKAyMT3pVKGMW0372PKGf9jf
         jkbHIjGATbRvKJALSuNkOCF8o5n5qogBkoPaNfvB38D2HdY7WadL2Kn8P2ryHcJwBpmV
         XtXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678400175;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+PpqHYgK6ua0cI72c9TbEtD8LO0JOYAL/VdlhjqaYAM=;
        b=JBUIbF7ccZ1TNE69h5I1roi3zZhz3AHEKkMqqxceY6+9LJF0q7j/CYC2p2axBEjTqp
         WpQ3Nuhllf+1LO1iPviUQBHvWpbzlCR7RRuQrheek5KpVO8OvZVUHyo1p93ZjJda6UTm
         F1BZUlBmqJUza7me/XAdmwuwBIQvYxsX9Xbu0egdIbUA2C1VKe69gdVH+7C4bmK5RC3+
         yAthYUQeCCNokz54+QZjZqh9j7yhHqRThlTqQP88LH0WzDmuNe7PeXvw1qljpYjjM1UD
         BC71FDoGyv/HBdAvaHsm4wNgfduhmtfKy47cRUtrUL6Idbu5kRHGvUfiPhaez7lOiNnY
         es+w==
X-Gm-Message-State: AO0yUKX2tZjX+eSyyXzKyv8FIqQIFAM53o8YiTSw5TQxP3x1S4NFNFfc
        1dBXhhi7L1N7WPvIg6qFjbPk8X2/au0=
X-Google-Smtp-Source: AK7set9lbs7x293UTnl9uRAk+cG2RyEprku4BNVqhAQF2wEDYOwvfVUzhZyCzydwdYj1oTlHUPJJrQ==
X-Received: by 2002:a17:902:e746:b0:19e:6bc5:8769 with SMTP id p6-20020a170902e74600b0019e6bc58769mr30603427plf.69.1678400174998;
        Thu, 09 Mar 2023 14:16:14 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id kf16-20020a17090305d000b00196217f1219sm132973plb.70.2023.03.09.14.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 14:16:14 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Emir SARI <emir_sari@icloud.com>
Cc:     git@vger.kernel.org
Subject: Re: Feature Request - Better i18n support
References: <ZAnXddDN7v0AOBdm@mbp.local>
Date:   Thu, 09 Mar 2023 14:16:14 -0800
In-Reply-To: <ZAnXddDN7v0AOBdm@mbp.local> (Emir SARI's message of "Thu, 9 Mar
        2023 15:56:21 +0300")
Message-ID: <xmqqfsad8tap.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emir SARI <emir_sari@icloud.com> writes:

> For instance, in Turkish (and in French AFAIK), percentages are indicated
> in different formats. In Turkish it precedes the number like %54. However,
> all the percentages use the standard 54%. By marking these as translatable,
> we could easily provide the correct formats.

Interesting.  Let's take a look to see how bad it is.

$ git grep '[fd]%%' \*.[ch] ':!compat/' ':!t/'
apply.c:		printf(" %s %.*s{%s => %s} (%d%%)\n", renamecopy,
apply.c:		printf(" %s %s => %s (%d%%)\n", renamecopy,
apply.c:					printf(" rewrite %s (%d%%)\n",

These are currently not even marked with _() to be translatable, and
it should be just the matter of enclosing them in _().

If these should be translated in the first place, that is.  I do not
think these are originally meant to be machine parseable (it is
shown as part of "git apply --summary"), but existing users may
already be abusing them as such.

diff.c:				fprintf(opt->file, "%s%4d.%01d%% %.*s\n", line_prefix,

This is part of "git diff --dirstat" output.  I do not think it
should be translated, even though it probably is not machine
parseable.

diff.c:		strbuf_addf(msg, "%s%ssimilarity index %d%%",
diff.c:		strbuf_addf(msg, "%s%ssimilarity index %d%%",
diff.c:			strbuf_addf(msg, "%s%sdissimilarity index %d%%%s\n",
diff.c:	strbuf_addf(&sb, " %s %s (%d%%)\n",

These are part of the extended diff headers (e.g. "rename A to B
with similarity index of X%") that are very much designed to be
machine parseable, and cannot be touched.

diff.c:			strbuf_addf(&sb, " (%d%%)\n", similarity_index(p));

This is part of "git diff --summary" to show "rewrite", similarly to
"rename" and "copy" that we saw earlier.

wt-status.c:				_("You are in a sparse checkout with %d%% of tracked files present."),

This is already marked _(translatable) and your l10n files should be
able to do "%d%%" -> "%%%d" as needed.

