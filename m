Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D02FC83000
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 16:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48EF0206F0
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 16:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSfyPs41"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgD2QQR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 12:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726481AbgD2QQR (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 12:16:17 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B54C03C1AE
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 09:16:15 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id m13so2173515otf.6
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 09:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0z2YnOuvs76m79m982TagG3DB57S3+ycYnwopvwbPJM=;
        b=MSfyPs41RXUU0XrDTb9C3POeVllfxigUVO/zIjhOagv2ystdWcin0VDnkQ4bmubCVJ
         8C0tJ2mv0+scivaD5n81ideRxVCYPc9BkdF+br+wmXTErCYr87DENjTt6RhWbOR4KeFt
         8qS7MP6y3ZSCjJ0pNqYyaI/pcT6GDGTKpejXpTK00H7WJYSujpITFj+buMcQVNxR+vzV
         xEt8rPb+1Zw6hJCoQaQrJdJsHQC8jy3doucstSUyzrYCTP7LVy0hC+bNZuZEGnDczjor
         4vtB2CXDIKh/czJv5/qAeHByti0QMft+Jj2pGSg84at3Zn0GQBId4Nf74c9QMa3cv2lx
         2C2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0z2YnOuvs76m79m982TagG3DB57S3+ycYnwopvwbPJM=;
        b=q6KbSkXo/1z9icQQtRogmRSu31R2CVw26ahS2marKwDAl/qGnTikjBRF4WPEmYsCc7
         iZcIxXJBTiWq1W6SxsjCLurXAit+DkA8oroaKS0Ori2tEXsuY0h7/1oYznrrZj2ybRM9
         pDFfms+szDwZx8z+XiBfA/4yKqgYfOqVUmAW8qAqivrm1PHiWkwlIVE0Poz0/18NkbZH
         5u7m5Zy8c3CI5j5uPFAf+nbpN/Z2PUIw/UrTKAXAkNZ/h8K8XPyFAIJQJhZ0eeZToiCT
         LvwVQLSge0sL/CW6nOPyyK7sfCdNGn7n5sNoa1Fm3WzmFbCvxXRrcyeWVC++zZu8NJR8
         jGGg==
X-Gm-Message-State: AGi0Puag0IRTmJIsi0Tn6pjMIdL40Y0+bfENfms2ss3K6MJnivh/K6pb
        2WglH2CQ5I4//5FGNauTGuCho/vagksyxUyO0F2qpt+zXf4=
X-Google-Smtp-Source: APiQypKoJm/9Rh1Quhj0KMp/4LuFkWH3uzmAJB8+MxcOmjBduqzfmYvJA8ILt6D9UZtd67QjR1eDa6PvTMTUraKQM6I=
X-Received: by 2002:a9d:2aa9:: with SMTP id e38mr13485947otb.162.1588176974217;
 Wed, 29 Apr 2020 09:16:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200429093811.8475-1-shouryashukla.oo@gmail.com>
In-Reply-To: <20200429093811.8475-1-shouryashukla.oo@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 29 Apr 2020 09:16:01 -0700
Message-ID: <CABPp-BGkZOyyoFiK3hsJ3FQq8MEBPy5aganHjA66vKFE20Wk0Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] gitfaq: files in .gitignore are tracked
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 29, 2020 at 2:38 AM Shourya Shukla
<shouryashukla.oo@gmail.com> wrote:
>
> Add issue in 'Common Issues' section which addresses the problem of
> Git tracking files/paths mentioned in '.gitignore'.
>
> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> ---
>  Documentation/gitfaq.txt | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
> index 1cf83df118..b1e758ffd1 100644
> --- a/Documentation/gitfaq.txt
> +++ b/Documentation/gitfaq.txt
> @@ -223,6 +223,15 @@ a file checked into the repository which is a template or set of defaults which
>  can then be copied alongside and modified as appropriate.  This second, modified
>  file is usually ignored to prevent accidentally committing it.
>
> +[[files-in-.gitignore-are-tracked]]
> +I asked Git to ignore various files, yet they are still tracked::
> +       A `gitignore` file specifies intentionally untracked files
> +       that Git should ignore. Files already tracked by Git are
> +       not affected. See linkgit:gitignore[5] for details.
> +       To ignore and untrack the files appearing in the staging are
> +       it is advised to use `git rm --cached <file>`as well as make
> +       the file pattern is mentioned in the '.gitignore'.

Mostly looks good, but I can't help but nitpick several small items:
The first sentence alone seems to slightly undercut the answer, so
it'd be nice to make sure the first two sentences are just one.  Also,
it doesn't explain how people get into this state, which is probably
something users are curious about.  The "To ignore and untrack the
files" lists multiple end results, making it unclear which parts of
the end results the suggested steps are addressing.  There's also a
"staging are" typo (should be "staging area").

How about something like:

The purpose of gitignore files is to ensure that certain files not
tracked by Git remain untracked.  However, git allows people to
override the `gitignore` rules by using the --force option to `git
add`, and sometimes people started tracking a file unintentionally
before adding a pattern covering it to the gitignore rules.  If you
want to untrack a file, run `git rm --cached <file>` (and then
commit).  See linkgit:gitignore[5] for details.
