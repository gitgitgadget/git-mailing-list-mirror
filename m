Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9E5C54EBE
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 01:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjANBdF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 20:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjANBdC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 20:33:02 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701D81AA1D
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 17:33:01 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so28668098pjj.2
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 17:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GTy7oW9ZCO4pgl7iQosEEW4N4jxircII+ig0KaFV1Gk=;
        b=X/r4jT+zq6jV0Z2he7BvlFWt0HJqfrsq2F8uN3grVx1bMc1Mup4qH5A6EEMt7VrGKc
         fj+M7mNsv/m66Qqf+QmTkeQnINPsiJyZdUhT5O1rZL6O4HtYDaEqwceb8K9xkvdFZqur
         3Qf4ts5foQLurORnoPkLq86dAw41swB3GuwLROu2gjSgvxTC2am4VXm/m58hZe0yWweI
         T0+5TI6IWg2uHKDOP+Hsqpa3RbrcNLofi03UvJl4xNlTYjnlHw09aqP2NuZ4MF2QRVvw
         j+DVpPFQzm2lmEyNn+EAQaBDxnzdNuYoft4OLhJxGjwWzsCkr8sjuZ78U6Kcdg03stdR
         xKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GTy7oW9ZCO4pgl7iQosEEW4N4jxircII+ig0KaFV1Gk=;
        b=xYHdpcYO6FEJPMRnuF+JtorJ/AULBm8NhQZKQDaIBOJv4yEsGj0nMsTEAsGXZqkTnO
         2VrPEtnvs8GJo5DOfZc+bHjwb42hMFyL1ik/gZQ79sGc5ESuJ/smXjDB4+/9lLw7hVO4
         MByB2XZgAWkf9/1q7SQhL/XcUrm7FZRrIrC2HFjgWm2JY7l5TkABnIZpM8EYUOUhdEGC
         DzsAVrvEUz1G4hqDzjzX3TwtiLQZrtOkMCfdadntQC889yfvf+uNpJvh0JAFtaNZmsF8
         ktdgVj5hp37HZMJSVbaur6P6zVLMur0UTfAGrJbzGJzcHQqV5vBp4UihoNgWMc5+RtSp
         rNVQ==
X-Gm-Message-State: AFqh2kp6NTwvGW5vr/SXDaxeszDNBfDJqKgujDZfunlBfcpLKkOdnGHc
        b11ynV2rnun9PqD375WUpa6uhT5ie4k=
X-Google-Smtp-Source: AMrXdXsO49hlFRR0BCWm4lOBNCWS8v0YLcZ9YQmgGJt0/sjLJ3Tgw0eMrYilVo9AB3kqV++H+AIzGQ==
X-Received: by 2002:a17:903:330b:b0:193:30be:d146 with SMTP id jk11-20020a170903330b00b0019330bed146mr19467744plb.63.1673659980798;
        Fri, 13 Jan 2023 17:33:00 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id n13-20020a170903110d00b001925ec4664esm14789931plh.172.2023.01.13.17.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 17:33:00 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     muzimuzhi Z <muzimuzhi@gmail.com>
Cc:     Clemens Buchacher <drizzd@gmx.net>, git@vger.kernel.org
Subject: Re: [PATCH v2] doc: fix non-existent config name
References: <CAEg0tHSLyaewkgGs0dEXfwQhKmbiO65bXZVU8t7Kn4WwJ1p0Fw@mail.gmail.com>
        <xmqqfsclzlqx.fsf@gitster.g>
        <CAEg0tHT5PD4K89E3fcNq_WbaLPHozLi-PsJFDsQrzkGi7Na9jg@mail.gmail.com>
        <CAEg0tHQtf9G0N24Xfe-gvRM1AFaiS_ApcuQ8hZtsZAeMhhVWAQ@mail.gmail.com>
        <xmqqo7r248x9.fsf@gitster.g>
        <CAEg0tHSZi22RUBREJB=Cfy6O72cicv9FTkgo_Z=gvGRdPK1acw@mail.gmail.com>
Date:   Fri, 13 Jan 2023 17:33:00 -0800
In-Reply-To: <CAEg0tHSZi22RUBREJB=Cfy6O72cicv9FTkgo_Z=gvGRdPK1acw@mail.gmail.com>
        (muzimuzhi Z.'s message of "Sat, 14 Jan 2023 09:12:12 +0800")
Message-ID: <xmqqedrxoq7n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

muzimuzhi Z <muzimuzhi@gmail.com> writes:

> From c879cb10f61afc361c484267f498d5815bc1b932 Mon Sep 17 00:00:00 2001
> From: muzimuzhi <muzimuzhi@gmail.com>

The "author identity" is taken from this line (or from the e-mail
header), and it should be identical to your sign-off.

> Date: Mon, 9 Jan 2023 06:37:47 +0800
> Subject: [PATCH v2] doc: fix non-existent config name

In general, there shouldn't be a reason to include the above four
lines in your message body.  An exception is "From:" to override the
author identity when you cannot send your e-mail using the same name
as what is used on your sign-off.  See Discussion section of "git am"
manual page.

> Replace non-existent `branch.<name>.fetch` to `remote.<repository>.fetch`, in
> the first example in `git-fetch` doc, which was introduced in
> d504f6975d (modernize fetch/merge/pull examples, 2009-10-21).
>
> Rename placeholder `<name>` to `<repository>`, to be consistent with all other
> uses in git docs, except that `git-config.txt` uses `remote.<name>.fetch` in
> its "Variables" section.
>
> Also add missing monospace markups.
>
> Signed-off-by: Yukai Chou <muzimuzhi@gmail.com>

Perfect.  Will queue.

> Changes compared to PATCH v1:

>  - Update commit reference in a non-shallow clone, resulting in longer
>    <abbrev-hash>

Great.

> diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
> index 63d9569e16..fba66f1460 100644
> --- a/Documentation/git-fetch.txt
> +++ b/Documentation/git-fetch.txt
> @@ -251,10 +251,10 @@ EXAMPLES
>  $ git fetch origin
>  ------------------------------------------------
>  +
> -The above command copies all branches from the remote refs/heads/
> -namespace and stores them to the local refs/remotes/origin/ namespace,
> -unless the branch.<name>.fetch option is used to specify a non-default
> -refspec.
> +The above command copies all branches from the remote `refs/heads/`
> +namespace and stores them to the local `refs/remotes/origin/` namespace,
> +unless the `remote.<repository>.fetch` option is used to specify a
> +non-default refspec.
>
>  * Using refspecs explicitly:
>  +
