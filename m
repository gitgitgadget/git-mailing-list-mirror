Return-Path: <SRS0=DQ4e=44=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BD4C0044D
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 19:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A852520736
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 19:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="hMdUn1wm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731093AbgCKT3f (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Mar 2020 15:29:35 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38590 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730913AbgCKT3f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Mar 2020 15:29:35 -0400
Received: by mail-lf1-f65.google.com with SMTP id n13so925793lfh.5
        for <git@vger.kernel.org>; Wed, 11 Mar 2020 12:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SPaAaVEfXdmjo6am9fFBhDN9JLLSg3ImblcuUQW8vjY=;
        b=hMdUn1wmMwwJ2FydXFvHjrywUpunAubPdOwMvaPveuzhrdHjIomjfYsgbhxX1G3C4v
         vuBZh4GCEZ2GaAgPNBT8+/uujOrYF7EyBgXy0cWL96JuYLrHoyFROtoP4A2Ob4IM/bRc
         nTvkBShHu2ghH492qHUQjoDRB6EigEcdswvPoN8qeGw12jtYzVWL48V/LZAVya/cmnFn
         9HLRNWTZbPjA9sTjhqGvLmDeb+W0QBArPXMgrO+nPVZB08m+QdAFHm8OKIZ49krD6ruQ
         p66ned0p97Q84ppSjnKtAghwF8Hc21tvxxF7A9+Fj5YPglcbH3MUM2UrAEVDdPy5xOZZ
         8Gww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SPaAaVEfXdmjo6am9fFBhDN9JLLSg3ImblcuUQW8vjY=;
        b=iFCqcwIQqk7c6z4FXhlgrjqoQ0YZQqKw0Gr+b0F9ldD0tOJlNnzBNmhtP93/hgH6/Y
         cAw/YhBhqKDddKxmZp7Vyl3FVmTefUOiBPKt9IF0N3gB5VLsq7Csf0CTNjbkLZdbignx
         cRiuBlEFcDLQHqjArxQYEAwdC/zLVOzUaL0bwXEjnSkTEbN7EPXgnDi7vLZwvM0Shgg4
         Uk4t6Wm9ZK93JOLYcJxuPqUP2vi88rmlLuSSsV3km1iUXay3eOhZ7ihC1zOCuLXO1mNO
         2M8a20otAQHgJDAcSJMqb7BOt6FzLZbcQMTCEx2mRiN2spkYxGtY8aEWQX4SQ4t8BMNk
         W6PQ==
X-Gm-Message-State: ANhLgQ1hXSDqe8mkeaL4tAKPcr9159bAOu6JYC3AiX0JHmfUPqfSS+mU
        3naCTkuitWBhgWgItmE5Fv0HNHy3y9aFvYxv7w1PvA1PXqY=
X-Google-Smtp-Source: ADFU+vsJb10Dn2HBiAfi/DRaUnQmaSzDgCGpKGNllLZ/97quBPy6gykKU0ToiYmyqWi4wMKmFFRhQyLg27hJAFJAPZw=
X-Received: by 2002:a05:6512:31d5:: with SMTP id j21mr3037483lfe.23.1583954973282;
 Wed, 11 Mar 2020 12:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200311180625.4643-1-shubhunic@gmail.com>
In-Reply-To: <20200311180625.4643-1-shubhunic@gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Wed, 11 Mar 2020 16:29:22 -0300
Message-ID: <CAHd-oW6K8Gh=un9znbNzm2rNvvL5s8j0uft8owNADkzjRL8jBg@mail.gmail.com>
Subject: Re: [GSOC] [PATCH] replace test -f with test_path_is_file
To:     Shubham Verma <shubhunic@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Shubham. Welcome to the community!

On Wed, Mar 11, 2020 at 3:06 PM Shubham Verma <shubhunic@gmail.com> wrote:
>
> Subject: [GSOC] [PATCH] replace test -f with test_path_is_file

It's common to prefix the patch title with "area: ", where "area"
corresponds to the codebase section which the patch is modifying. This
makes it easier to understand the scope of the change. You can check
what others have been using for this specific file with `git log
--no-merges t/t9801-git-p4-branch.sh`. In this case, I think a better
alternative would be: "t9801: replace test -f with test_path_is_file"

> Although `test -f` has the same functionality as test_path_is_file(), in the case where test_path_is_file() fails, we get much better
> debugging information.
>
> Replace `test -f` with test_path_is_file() so that future developers will have a better experience debugging these test cases.

It's also a good practice to wrap the commit body in 72 columns. This
will, for example, help viewing the message in most terminals. And,
please, add your Signed-off-by[1] in the footer of the message.

[1]: https://github.com/git/git/blob/master/Documentation/SubmittingPatches#L299

> ---
>  t/t9801-git-p4-branch.sh | 38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)

As for the changes, LGTM :)
